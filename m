Return-Path: <stable+bounces-217503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMZBJ313l2nVywIAu9opvQ
	(envelope-from <stable+bounces-217503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:50:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA93D1626FE
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24DE3026596
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 20:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778DE3254B6;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUFlVw5v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0E830DD1F;
	Thu, 19 Feb 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771534198; cv=none; b=sneDiDy5XkfhJifttTnMc0I4G7vFOcYtaPQ9BSxMTvAIZjxiuVc25ZaNvVQFe4kea/f1NJ/yOfyBSIVYiFkZCGx2CWNx8SKE9pBxXJ6MuesASfefR7YMbkB4RX7dzNadx4K1uq8XU1NoqTEF8XJGkWQlKbihnVGCzRnMfbYxsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771534198; c=relaxed/simple;
	bh=05eXMLVb0c51uSNdXRwWQbrKXkkVcDp8J4v23OawnDY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ubOweawIMpDjT1a1uc43fKhkfvoxuhraPLoCvVpAUBmlCP4eS/P5kbgT4hUArb+nFyqOsfZJ/Jrp+hDMfCmhHFQm/miWqPxhp7PZxAQm60AAEXJ7HWZ0zoFYJZQsoNbTh5P1eU7HoZ35fwMkvwbiDqMgfG1fzsviAY9NQmkt9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUFlVw5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0BEC116D0;
	Thu, 19 Feb 2026 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771534198;
	bh=05eXMLVb0c51uSNdXRwWQbrKXkkVcDp8J4v23OawnDY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=sUFlVw5v2enIhrJexWmwfU6QkyxYfny+hVWdyR/SCwyJ5r6IkLUGPAgv/kNN/z06e
	 O8KbTcyfXKQ/HVWRdt6rKjU391nz0+Dh5BzPnDo2OYhlZUZDkr2tIx9Z7pUGe/4Sh5
	 dW1j2rOIVkZbmo6ENDXmpOSvZXdMNLdu/vuRVfNgvh8PbpN3qlIEsULceUYNT3JWGp
	 WZeaTLQrNFjbi4SUJgGIetEYzvl/WhOfe/2GALcvaA0Xbl+QLFWhUH8BdD1Ul/L4ud
	 KdHKIH7MNFrZcp3D8KpZGGOf/zjFURPjHDHRHMoHSbwsWDZiKVpNDecTroEoan/X51
	 exPgr/YftXH5Q==
Received: from rostedt by gandalf with local (Exim 4.99.1)
	(envelope-from <rostedt@kernel.org>)
	id 1vtAyK-00000000kfJ-3ZuR;
	Thu, 19 Feb 2026 15:50:04 -0500
Message-ID: <20260219205004.720044375@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 19 Feb 2026 15:49:48 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniil Dulov <d.dulov@aladdin.ru>
Subject: [for-linus][PATCH 1/5] ring-buffer: Fix possible dereference of uninitialized pointer
References: <20260219204947.830172370@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217503-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,goodmis.org:email,linaro.org:email,aladdin.ru:email]
X-Rspamd-Queue-Id: EA93D1626FE
X-Rspamd-Action: no action

From: Daniil Dulov <d.dulov@aladdin.ru>

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
index d33103408955..bdc8010d8f48 100644
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



