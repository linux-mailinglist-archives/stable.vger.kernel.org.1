Return-Path: <stable+bounces-5938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E7C80D7EF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7675A1C21485
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D1A524B5;
	Mon, 11 Dec 2023 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QUJgMqug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DBFBE1;
	Mon, 11 Dec 2023 18:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC6BC433C7;
	Mon, 11 Dec 2023 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320071;
	bh=Jg1lqmeiCOTztKnc+kaWefsP7jQkon20wquQNf2vNb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUJgMqugChrR5uygQVJycSKXfTlc/W4HsKf32HrRn838NXO1T3FP+Bq2FlLSsai9d
	 cKVCq/UegRXT9fKKZHv7nFNiYtCyxUml/1/967BM1axwBtr1ojUnodXswpzt7o3Uid
	 tIiG7xSlyxMw/cOgnGcA0wE25aJcT7b/i3U7n3hY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	mhiramat@kernel.org,
	Zheng Yejian <zhengyejian1@huawei.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 63/97] tracing: Set actual size after ring buffer resize
Date: Mon, 11 Dec 2023 19:22:06 +0100
Message-ID: <20231211182022.461006659@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>
References: <20231211182019.802717483@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit 6d98a0f2ac3c021d21be66fa34e992137cd25bcb ]

Currently we can resize trace ringbuffer by writing a value into file
'buffer_size_kb', then by reading the file, we get the value that is
usually what we wrote. However, this value may be not actual size of
trace ring buffer because of the round up when doing resize in kernel,
and the actual size would be more useful.

Link: https://lore.kernel.org/linux-trace-kernel/20230705002705.576633-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: d78ab792705c ("tracing: Stop current tracer when resizing buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index adabf4f0b081f..2c9769e1f7652 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5852,6 +5852,15 @@ static void set_buffer_entries(struct array_buffer *buf, unsigned long val)
 		per_cpu_ptr(buf->data, cpu)->entries = val;
 }
 
+static void update_buffer_entries(struct array_buffer *buf, int cpu)
+{
+	if (cpu == RING_BUFFER_ALL_CPUS) {
+		set_buffer_entries(buf, ring_buffer_size(buf->buffer, 0));
+	} else {
+		per_cpu_ptr(buf->data, cpu)->entries = ring_buffer_size(buf->buffer, cpu);
+	}
+}
+
 #ifdef CONFIG_TRACER_MAX_TRACE
 /* resize @tr's buffer to the size of @size_tr's entries */
 static int resize_buffer_duplicate_size(struct array_buffer *trace_buf,
@@ -5929,18 +5938,12 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		return ret;
 	}
 
-	if (cpu == RING_BUFFER_ALL_CPUS)
-		set_buffer_entries(&tr->max_buffer, size);
-	else
-		per_cpu_ptr(tr->max_buffer.data, cpu)->entries = size;
+	update_buffer_entries(&tr->max_buffer, cpu);
 
  out:
 #endif /* CONFIG_TRACER_MAX_TRACE */
 
-	if (cpu == RING_BUFFER_ALL_CPUS)
-		set_buffer_entries(&tr->array_buffer, size);
-	else
-		per_cpu_ptr(tr->array_buffer.data, cpu)->entries = size;
+	update_buffer_entries(&tr->array_buffer, cpu);
 
 	return ret;
 }
-- 
2.42.0




