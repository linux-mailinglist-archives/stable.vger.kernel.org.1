Return-Path: <stable+bounces-8978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8F28205B0
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9961D28210C
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B9C8473;
	Sat, 30 Dec 2023 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iDJObq7e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB62A79CD;
	Sat, 30 Dec 2023 12:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442CCC433C7;
	Sat, 30 Dec 2023 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938256;
	bh=lJvT+1aAN3WKK45ZUutqXdrmP44/+FzG/UO5FWVXVeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDJObq7ej8AYGzlXV9d7VC/i3pdfJbT4o3s2s1hcdIrB326PWopOim4Jlv158oP3G
	 VBgO4N+fDk97df7peO1F3ws/PAgB6FlfDY7kE5as3zfjBQzSmLMBKLxOvWXRUqVo0+
	 Or6WKbiptRy7lz7fShWSFJVmeQpbrP9ctq1oiL40=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	JP Kobryn <inwardvessel@gmail.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 6.1 087/112] 9p: prevent read overrun in protocol dump tracepoint
Date: Sat, 30 Dec 2023 12:00:00 +0000
Message-ID: <20231230115809.593494801@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: JP Kobryn <inwardvessel@gmail.com>

commit a931c6816078af3e306e0f444f492396ce40de31 upstream.

An out of bounds read can occur within the tracepoint 9p_protocol_dump. In
the fast assign, there is a memcpy that uses a constant size of 32 (macro
named P9_PROTO_DUMP_SZ). When the copy is invoked, the source buffer is not
guaranteed match this size.  It was found that in some cases the source
buffer size is less than 32, resulting in a read that overruns.

The size of the source buffer seems to be known at the time of the
tracepoint being invoked. The allocations happen within p9_fcall_init(),
where the capacity field is set to the allocated size of the payload
buffer. This patch tries to fix the overrun by changing the fixed array to
a dynamically sized array and using the minimum of the capacity value or
P9_PROTO_DUMP_SZ as its length. The trace log statement is adjusted to
account for this. Note that the trace log no longer splits the payload on
the first 16 bytes. The full payload is now logged to a single line.

To repro the orignal problem, operations to a plan 9 managed resource can
be used. The simplest approach might just be mounting a shared filesystem
(between host and guest vm) using the plan 9 protocol while the tracepoint
is enabled.

mount -t 9p -o trans=virtio <mount_tag> <mount_path>

The bpftrace program below can be used to show the out of bounds read.
Note that a recent version of bpftrace is needed for the raw tracepoint
support. The script was tested using v0.19.0.

/* from include/net/9p/9p.h */
struct p9_fcall {
    u32 size;
    u8 id;
    u16 tag;
    size_t offset;
    size_t capacity;
    struct kmem_cache *cache;
    u8 *sdata;
    bool zc;
};

tracepoint:9p:9p_protocol_dump
{
    /* out of bounds read can happen when this tracepoint is enabled */
}

rawtracepoint:9p_protocol_dump
{
    $pdu = (struct p9_fcall *)arg1;
    $dump_sz = (uint64)32;

    if ($dump_sz > $pdu->capacity) {
        printf("reading %zu bytes from src buffer of %zu bytes\n",
            $dump_sz, $pdu->capacity);
    }
}

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Message-ID: <20231204202321.22730-1-inwardvessel@gmail.com>
Fixes: 60ece0833b6c ("net/9p: allocate appropriate reduced message buffers")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/trace/events/9p.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/9p.h b/include/trace/events/9p.h
index 4dfa6d7f83ba..cd104a1343e2 100644
--- a/include/trace/events/9p.h
+++ b/include/trace/events/9p.h
@@ -178,18 +178,21 @@ TRACE_EVENT(9p_protocol_dump,
 		    __field(	void *,		clnt				)
 		    __field(	__u8,		type				)
 		    __field(	__u16,		tag				)
-		    __array(	unsigned char,	line,	P9_PROTO_DUMP_SZ	)
+		    __dynamic_array(unsigned char, line,
+				min_t(size_t, pdu->capacity, P9_PROTO_DUMP_SZ))
 		    ),
 
 	    TP_fast_assign(
 		    __entry->clnt   =  clnt;
 		    __entry->type   =  pdu->id;
 		    __entry->tag    =  pdu->tag;
-		    memcpy(__entry->line, pdu->sdata, P9_PROTO_DUMP_SZ);
+		    memcpy(__get_dynamic_array(line), pdu->sdata,
+				__get_dynamic_array_len(line));
 		    ),
-	    TP_printk("clnt %lu %s(tag = %d)\n%.3x: %16ph\n%.3x: %16ph\n",
+	    TP_printk("clnt %lu %s(tag = %d)\n%*ph\n",
 		      (unsigned long)__entry->clnt, show_9p_op(__entry->type),
-		      __entry->tag, 0, __entry->line, 16, __entry->line + 16)
+		      __entry->tag, __get_dynamic_array_len(line),
+		      __get_dynamic_array(line))
  );
 
 
-- 
2.43.0




