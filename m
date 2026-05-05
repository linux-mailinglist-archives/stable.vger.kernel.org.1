Return-Path: <stable+bounces-244180-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJAJHYMH+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244180-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:06:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1398F4CFEED
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8008A30BF802
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01547481246;
	Tue,  5 May 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP3OlXAx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA6480DC5;
	Tue,  5 May 2026 15:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993289; cv=none; b=FnaATb/sdTW+r2+fTsh+dlrHTqM8xTQlbgSkwFklaT2eJjaG5RGljobpj4Ex8Sb7tCfF1Ry4gdlUMRPF3kp+vUVDq1PsTXHKqVdFx7nGF0MlgcLMd5hHG/U1UKItFceaQr2YO3/rfcOiFuicO/laBWB+nOz9aaDSfPYS5CL0/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993289; c=relaxed/simple;
	bh=EkSruGFMHGWcQLZNz6XQq0dIVKxBOld8BsSrTpSJ7VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ykm/8wEF90xmc+8pO6OloJFI2FZMjrgAyDa24r3b1cMS7YSCM98C82Y2DxCdQCzcq1olSG+mNZFx8GhSeCEqKUy8ZC0/mLsPTFL46KuqcjyHXNEC9gETHLcAJeC2oAW+pa6twSDFhJHPDXVdEiLrrG3kz5q8VyMqsXhZzWrWIns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP3OlXAx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF9BC2BCB4;
	Tue,  5 May 2026 15:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993289;
	bh=EkSruGFMHGWcQLZNz6XQq0dIVKxBOld8BsSrTpSJ7VA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NP3OlXAxFSgNVMW/v3wUxdDhgCJLJZbSWceJJtoXX4m2H2RswmsRI16zJ3SkMcdan
	 +RwQ2g3VHJ/P8GhvLXuB5CFNWYNHg5xNvQLt7GNIkRNlfN9M/CrQSaIm08wyw2lrlZ
	 bnetWHpUtV8zLdvt+riUligAx2Wi2Cgm8+JET0/BSuwz97PPQfNrSRQEper2A9o2qM
	 4x/dBhadg+dJDfXH9Bdiipkhv6d8Auk8jzsmHq7J3l7jUrMIGMBxiHWH3MaiCOHuax
	 Ihft73+xqUicgL1NRimIiiEF0RZYQyHUDbPzJKmnGIaaekRF6RPj7KFGVBH4W/LwH/
	 lUq9T7xz/1Q1Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 May 2026 17:00:49 +0200
Subject: [PATCH net 01/11] mptcp: pm: kernel: correctly retransmit ADD_ADDR
 ID 0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-1-fca8091060a4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2153; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=EkSruGFMHGWcQLZNz6XQq0dIVKxBOld8BsSrTpSJ7VA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/sVlr3t26vKDt85+CS5+4ft+zXXRF8rPPBwv/7vfpE
 jFazSwhHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZdo/hf5TCmdnbVRVcKtY/
 vHXKY09AjuptoYvCT78pl15aFcn1W5uRYbXavk3HGdNO1WT7Hnd0+srvcrRlSkqUh+lE+UYlHvc
 +XgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 1398F4CFEED
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
	TAGGED_FROM(0.00)[bounces-244180-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,addr.id:url]

When adding the ADD_ADDR to the list, the address including the IP, port
and ID are copied. On the other hand, when the endpoint corresponds to
the one from the initial subflow, the ID is set to 0, as specified by
the MPTCP protocol.

The issue is that the ID was reset after having copied the ID in the
ADD_ADDR entry. So the retransmission was done, but using a different ID
than the initial one.

Fixes: 8b8ed1b429f8 ("mptcp: pm: reuse ID 0 after delete and re-add")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index c9f1e5af3cd3..fc818b63752e 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -347,6 +347,8 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	/* check first for announce */
 	if (msk->pm.add_addr_signaled < endp_signal_max) {
+		u8 endp_id;
+
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -360,19 +362,20 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
 
+		/* Special case for ID0: set the correct ID */
+		endp_id = local.addr.id;
+		if (endp_id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
 		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(endp_id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
 
-		/* Special case for ID0: set the correct ID */
-		if (local.addr.id == msk->mpc_endpoint_id)
-			local.addr.id = 0;
-
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_addr_send_ack(msk);
 

-- 
2.53.0


