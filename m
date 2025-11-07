Return-Path: <stable+bounces-192727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5A7C4008E
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 14:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E343B8B70
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 13:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714B42C032E;
	Fri,  7 Nov 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyHqf8Tw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C053264A9D;
	Fri,  7 Nov 2025 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520877; cv=none; b=fu9DSZkUIV0DP0ZRESGWwSNryH8ihc5nPXdeyk6jwt2aOU46mUAsQ2jWkbbckQ43YF4Yq5gc5WYPyalI7G9TYW3RZrk2i67xA5C5jWIjkTO6FQe4MpUVuXNWA2yB5uLnwnai/DtzoSTYd4uFzbOXqndet6fgvJX9eFaDBnTlv2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520877; c=relaxed/simple;
	bh=gTCe6+8DCvvTv/gwaosX0O1LJx32TQrppUBdFg7nEZ4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GNpGRsyTnQO02YHdK1M5W8CS24Bz3MaCvLXb44ZfGr5eskDEanp9L1KcISkGMP8sJiFcKK1DG+lLfbZDxPcUzCkYMmz/MGNMbNAOI2lMfe+RhzPTTC0MnM7YGgHPUqJ+o+y7ISq34/5qpA734qkY+H4pUj6vO6Sbn9KqcBYrWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyHqf8Tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB87EC19421;
	Fri,  7 Nov 2025 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762520876;
	bh=gTCe6+8DCvvTv/gwaosX0O1LJx32TQrppUBdFg7nEZ4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=GyHqf8TwIU4rt1cFeUgO4fS4nNJ6DVg8ytscgRw4KL4L3gaewE1KKnGmw/TlKo/nM
	 SI1mAPSUB/M1mDxvwmNJy+b+fFqF5cMQw4pnAvqNT/cR4+ejYkPpCvrinXK6/UrWYp
	 FNyqKkviQLAASmtazERNk3yVPzwYzJuv+3VGFXKHoNafAFiph/IaSOohjasYUK/uds
	 DvlYoDxN3oFoMwi+Jr7e9y2utGowRaqKFw0bDWMfr2uKxDhxUg/sEtIw4csAfP0QjZ
	 1xnfkBxLLiA7VzG2oq4TpEIpV8+Y0GRaSsL4BkBLXl0ide4d/CHQem41exgdfl0Pc9
	 OCIrQijE17auA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vHMC6-00000000GGV-0MR2;
	Fri, 07 Nov 2025 08:07:58 -0500
Message-ID: <20251107130757.937218818@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 07 Nov 2025 08:07:31 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>,
 syzbot+92a3745cea5ec6360309@syzkaller.appspotmail.com
Subject: [for-linus][PATCH 1/3] ring-buffer: Do not warn in ring_buffer_map_get_reader() when reader
 catches up
References: <20251107130730.158197641@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function ring_buffer_map_get_reader() is a bit more strict than the
other get reader functions, and except for certain situations the
rb_get_reader_page() should not return NULL. If it does, it triggers a
warning.

This warning was triggering but after looking at why, it was because
another acceptable situation was happening and it wasn't checked for.

If the reader catches up to the writer and there's still data to be read
on the reader page, then the rb_get_reader_page() will return NULL as
there's no new page to get.

In this situation, the reader page should not be updated and no warning
should trigger.

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Reported-by: syzbot+92a3745cea5ec6360309@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/690babec.050a0220.baf87.0064.GAE@google.com/
Link: https://lore.kernel.org/20251016132848.1b11bb37@gandalf.local.home
Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1244d2c5c384..afcd3747264d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7344,6 +7344,10 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 		goto out;
 	}
 
+	/* Did the reader catch up with the writer? */
+	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
+		goto out;
+
 	reader = rb_get_reader_page(cpu_buffer);
 	if (WARN_ON(!reader))
 		goto out;
-- 
2.51.0



