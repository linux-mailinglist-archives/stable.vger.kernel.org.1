Return-Path: <stable+bounces-221562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDH6FCWXo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:32:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD47D1CAE4B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BC9A304954D
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFA729B78D;
	Sun,  1 Mar 2026 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijkJsMzC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5538242D72;
	Sun,  1 Mar 2026 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328584; cv=none; b=NbHH2U3nBWN1doFCUu1FsmJ6SHWj9+QsYHJ2XK0pPQMGX2AsS0F9nCD8VcmnYGByQZYKLIaZazOibl30UAu8/BMyU5jUtLYVgiU5lYEjG4F75ymV3mW1/32Lw+F7pXxVq9LLxqKHx27paD9+6tu7/6zLG8W2CsBF3dyqnOEL0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328584; c=relaxed/simple;
	bh=UoDERUQgRx6wrwT3Y/PqQ9SqB4KImTq13W3tq+drXHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0wt7HRD0SGYE3JSN0Xo2YhsTBzDDSGVdIlT45xDsGWKOV+Tz23mj+3gnc0vHlvSBkJf6+MwG/R9ayZ8ocoR0ltk9mHqIDjjEsuFvejizYc50Du9BEWEaYHktXk5xxbPL9QW0jON6QAUHCYno3MKGDPNYPVRzvz6KT9Z3HHwxb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijkJsMzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AD2C19421;
	Sun,  1 Mar 2026 01:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328584;
	bh=UoDERUQgRx6wrwT3Y/PqQ9SqB4KImTq13W3tq+drXHY=;
	h=From:To:Cc:Subject:Date:From;
	b=ijkJsMzC7jBBBQp4x5uo8SK4LvqMbVq9Ra6T0j2IPMImXCY8nFtRuMeI0k9C1hsrb
	 g0WJIWwXK6UA7fGk3uj1sijzVp/y/y86ywk5atRVIU7QR7fxHCneKs+ULv5oj3psme
	 eM2OS+11flaYLAjxqcPxOmE0M0wHq8hJXR0q9495WY3i29TTsrxYDL0woIiUtgcZK+
	 Wn7PwmieJSz2tCPB1eWhal1EEXYCAuh3ALihb4hvHZnXAV28o1pqvYw3oKxzjcSrYO
	 Jtqx4LguMg224ZEhxSxgmk9CSXC+1sqAT8RPA47A5ohRwRSKTSpMQn31DvOQfRi2b9
	 GXy3V7oxu3AFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	d.dulov@aladdin.ru
Cc: kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Subject: FAILED: Patch "ring-buffer: Fix possible dereference of uninitialized pointer" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:29:42 -0500
Message-ID: <20260301012942.1687554-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221562-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,goodmis.org:email,linuxtesting.org:url,msgid.link:url,aladdin.ru:email]
X-Rspamd-Queue-Id: BD47D1CAE4B
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f1547779402c4cd67755c33616b7203baa88420b Mon Sep 17 00:00:00 2001
From: Daniil Dulov <d.dulov@aladdin.ru>
Date: Fri, 13 Feb 2026 13:01:30 +0300
Subject: [PATCH] ring-buffer: Fix possible dereference of uninitialized
 pointer

There is a pointer head_page in rb_meta_validate_events() which is not
initialized at the beginning of a function. This pointer can be dereferenced
if there is a failure during reader page validation. In this case the control
is passed to "invalid" label where the pointer is dereferenced in a loop.

To fix the issue initialize orig_head and head_page before calling
rb_validate_buffer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Link: https://patch.msgid.link/20260213100130.2013839-1-d.dulov@aladdin.ru
Closes: https://lore.kernel.org/r/202406130130.JtTGRf7W-lkp@intel.com/
Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d331034089552..bdc8010d8f482 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1919,6 +1919,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	if (!meta || !meta->head_buffer)
 		return;
 
+	orig_head = head_page = cpu_buffer->head_page;
+
 	/* Do the reader page first */
 	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu);
 	if (ret < 0) {
@@ -1929,7 +1931,6 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
 	local_set(&cpu_buffer->reader_page->entries, ret);
 
-	orig_head = head_page = cpu_buffer->head_page;
 	ts = head_page->page->time_stamp;
 
 	/*
-- 
2.51.0





