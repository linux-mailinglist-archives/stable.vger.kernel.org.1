Return-Path: <stable+bounces-244182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBZkLcQH+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:07:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 542514CFF28
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9511930D3AE8
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835E4480DC5;
	Tue,  5 May 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPDw7r7T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B1480DCF;
	Tue,  5 May 2026 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993294; cv=none; b=fvfkar15n/dtzeG3RSZ9Hj2XRxQfv+KByoX19OvPM+VVrxhAIVn2ifvGar7SLpc2EB9oda0CDh1NFIo3D5s0YkkCpNnO/wd7LdX4HXjCQhgdOWCfhZxMAE781FNmhdviXbBhzyhYxHVSiLpYshkuF0YZWYsA34ZFmmrchLFvb+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993294; c=relaxed/simple;
	bh=O+sF1GAywSQrGhzPouN65AXm4Ji3EuL/SL0gRQhTA98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R7dmdnus2Hp0NApwCuzUzAqn5XTkl93bCV3us7+T3gWkhOeVWg/bVS90kUQCGqqJmFHXSN4Jjwa/kNwkBa/s+XtoMR89DyHhPSCwrp6tXnl2TCXij48cBAlyQItsQYNRLIcPmSMsLCWPZxHcH/iGhpN2/+JtuW5qLa2pNockQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPDw7r7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206D7C2BCB4;
	Tue,  5 May 2026 15:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993294;
	bh=O+sF1GAywSQrGhzPouN65AXm4Ji3EuL/SL0gRQhTA98=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bPDw7r7TiVLcuOMIhEnhM5wzrqldCztQ+uEjVpv34ydujiF/OWged8icNXp3Akk9Z
	 9SPWaK6BIOatk2l4M6lXZ6dpR31dkSQjWoZZbUoisUjLcILaECSr98Fgsg9DS11g+2
	 h9CpK5IKQi3w3gNUiVBxuv/QtaWztsX54V6Wwi8bauSjFyrHwKIV5C8zjhSLuglpXR
	 kX57XL5bTQ6HKgI/7LWGfNAuRJBXUVzSR1dNXGfozBwjuAhm7xisu4jJjo51xrQJXq
	 S8HaoID1UMJOfPr6SEGzMS/eSaJJYWEoWT01iI/0cpSbrERCmn8PNn5QYn6c4vIZrZ
	 tms0uqfOJlV0g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 May 2026 17:00:51 +0200
Subject: [PATCH net 03/11] mptcp: pm: ADD_ADDR rtx: fix potential data-race
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-3-fca8091060a4@kernel.org>
References: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
In-Reply-To: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=O+sF1GAywSQrGhzPouN65AXm4Ji3EuL/SL0gRQhTA98=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/sdlqPNZ++flpSWuz2pbOvZ+nTnVJ2ralSfv16pnvl
 j2bzuT0r6OUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAij5QZGY4tlL6kw7nnwxNr
 qcI7fzTbon7W7P2qK52+ne/pu4sFz5YxMhw4ZpVfYF5l6TbHsFDFfsrFE4FWXN1ztl9Qypz/MX/
 REU4A
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 542514CFF28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244182-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This mptcp_pm_add_timer() helper is executed as a timer callback in
softirq context. To avoid any data races, the socket lock needs to be
held with bh_lock_sock().

If the socket is in use, retry again soon after, similar to what is done
with the keepalive timer.

Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 5056eb8db24e..3912128d9b86 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -337,6 +337,13 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	if (inet_sk_state_load(sk) == TCP_CLOSE)
 		return;
 
+	bh_lock_sock(sk);
+	if (sock_owned_by_user(sk)) {
+		/* Try again later. */
+		sk_reset_timer(sk, timer, jiffies + HZ / 20);
+		goto out;
+	}
+
 	if (mptcp_pm_should_add_signal_addr(msk)) {
 		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
 		goto out;
@@ -365,6 +372,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		mptcp_pm_subflow_established(msk);
 
 out:
+	bh_unlock_sock(sk);
 	__sock_put(sk);
 }
 

-- 
2.53.0


