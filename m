Return-Path: <stable+bounces-245757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILdcDfI5A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:32:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A818A52290B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A094630F833A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647C3AEB43;
	Tue, 12 May 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ok82ONd8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B93ABD91
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595730; cv=none; b=r3qHtJwlzrO4GGbrrk0fPM/zllsYL51xVjSn/ZXD9yGgRgC0sOLS849AKQ6vPNhQxkAJsJSlm4ZzghZSNWFx7Za7399ZgoFhtCLHW63g+x92Snmg64CEbDCgzFsX3XvsxMd2SMmb8N0x7tAnQFIFgeaZe0swegd0QfQs93bY4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595730; c=relaxed/simple;
	bh=tEGFkRHDsvkiPgavsr2BZYtWV0xluAce61vfLKvDPK0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZOgQaZ7muV8OMoiM4w6ZutYQqs3A3SjEwX8XPvnVwVWO7WFhCf7Tx6el6PR/Q2Y5UffFRvTzEYZ5EOS7whRK/2uhhuYsNltuqPiNTycptBreMBp5hL6dUKV3Dit9vEiINc3pHt08eVTvaijcui/0XGc3I0PYQbrN4E3Aq4Al5RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ok82ONd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F4CC2BCB0;
	Tue, 12 May 2026 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595730;
	bh=tEGFkRHDsvkiPgavsr2BZYtWV0xluAce61vfLKvDPK0=;
	h=Subject:To:Cc:From:Date:From;
	b=ok82ONd8mbuGJLLVjpkVqph3jIXR9y3HhmSvCdGMVlmHcbZnTaU81482VSmoWBBps
	 dHMF8TZ24+ymPM69KE7fnrv8djOTseLpGbEAJ0F8N3vkTvG52nLY6Aq7ZSDpjMHLAI
	 Li6TPujyRVnvizObR1LV8+MspSY5eDQOhr2JyK2U=
Subject: FAILED: patch "[PATCH] mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker" failed to apply to 5.10-stable tree
To: matttbe@kernel.org,kuba@kernel.org,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:21:54 +0200
Message-ID: <2026051254-uptake-mantis-38b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A818A52290B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245757-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 3cf12492891c4b5ff54dda404a2de4ec54c9e1b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051254-uptake-mantis-38b3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3cf12492891c4b5ff54dda404a2de4ec54c9e1b5 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 5 May 2026 17:00:54 +0200
Subject: [PATCH] mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker

When an ADD_ADDR needs to be retransmitted and another one has already
been prepared -- e.g. multiple ADD_ADDRs have been sent in a row and
need to be retransmitted later -- this additional retransmission will
need to wait.

In this case, the timer was reset to TCP_RTO_MAX / 8, which is ~15
seconds. This delay is unnecessary long: it should just be rescheduled
at the next opportunity, e.g. after the retransmission timeout.

Without this modification, some issues can be seen from time to time in
the selftests when multiple ADD_ADDRs are sent, and the host takes time
to process them, e.g. the "signal addresses, ADD_ADDR timeout" MPTCP
Join selftest, especially with a debug kernel config.

Note that on older kernels, 'timeout' is not available. It should be
enough to replace it by one second (HZ).

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-6-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 8899327e59a1..29d1bb6a69cf 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -342,13 +342,8 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
-	if (mptcp_pm_should_add_signal_addr(msk)) {
-		timeout = TCP_RTO_MAX / 8;
-		goto out;
-	}
-
 	timeout = mptcp_adjust_add_addr_timeout(msk);
-	if (!timeout)
+	if (!timeout || mptcp_pm_should_add_signal_addr(msk))
 		goto out;
 
 	spin_lock_bh(&msk->pm.lock);


