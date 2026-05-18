Return-Path: <stable+bounces-249292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG+5C5gZC2o5/wQAu9opvQ
	(envelope-from <stable+bounces-249292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:52:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F95D56E0A3
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B2430B65C6
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B13B1A3165;
	Mon, 18 May 2026 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoRSkYJG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8388634C
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111934; cv=none; b=tejkwdYISblyM18ZNV84+TLWf+6utRjbOC6ZpHAtN9UCN/61h5B3/XGvIx5zPPY80u78hTzo+FigplTP93ObTQ8Oiall961mTf04wbpxPD51PpOQCBg2lI/qiU/XEO7voa3Eb6mi2rjRYR8iHdZxdjPxY+JAgl2vWSpEJgwAXVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111934; c=relaxed/simple;
	bh=YYiyTrhmhtUgJqjXS8Rf5WrOCTiEFTMa0gpi5jQg3S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gS6TI52TZMtSGAigfnrrMUTQ8UrYS5mM9q4M2d3vQItqsHmpAOl9kFBL9H+rLDlyByq9zO3/XxzyVEBicQwGSOCNwptdwt19Vk2w4+CiYS1F+tj3AlQvZbptOfkLWDF5IyN3HgaOWvFaufh0bP/LzaSOZmYc1Kgjj4LbdYOcAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoRSkYJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B906C2BCB7;
	Mon, 18 May 2026 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111934;
	bh=YYiyTrhmhtUgJqjXS8Rf5WrOCTiEFTMa0gpi5jQg3S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoRSkYJGBaJnNfkxKyjXgMnyYhyY68hPx9URsV/t83oFbjox/vCIu+DFiCPJe065/
	 mSuDLxNtv53JcUz1nG2qials8OpC/UPR2xvMYYeAecvIMkluhtp2c1V9hN/o+8WUFX
	 fGvUgm0F96hs9Ee7IZUoExFEtYRZbgz7CVH+B2e8Z2rnpc3DllEUoWUeoXsfl78MAK
	 OSny2fP5Fxm8Hrc0fvCzBOB7IhHF95cC2jOWP5WuqVRdgZip15xmfXyCo/xPlBHJ6L
	 DxZQw/O2GD4GOZzwSTkSnAc7DUI9uvN2J9fvnhSZNvP8tlho8fVLNqiofCRpvttRH+
	 31TdE1NIziRmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: prio: skip closed subflows
Date: Mon, 18 May 2026 09:45:31 -0400
Message-ID: <20260518134531.1135631-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051229-ozone-hardener-e249@gregkh>
References: <2026051229-ozone-hardener-e249@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249292-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F95D56E0A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 166b78344031bf7ac9f55cb5282776cfd85f220e ]

When sending an MP_PRIO, closed subflows need to be skipped.

This fixes the case where the initial subflow got closed, re-opened
later, then an MP_PRIO is needed for the same local address.

Note that explicit MP_PRIO cannot be sent during the 3WHS, so it is fine
to use __mptcp_subflow_active().

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Cc: stable@vger.kernel.org
Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-9-fca8091060a4@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ applied to renamed function `mptcp_pm_nl_mp_prio_send_ack()` in `pm_netlink.c` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a16a7a538c425..2f261d691c6f5 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -924,6 +924,9 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		struct mptcp_addr_info local, remote;
 
+		if (!__mptcp_subflow_active(subflow))
+			continue;
+
 		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!mptcp_addresses_equal(&local, addr, addr->port))
 			continue;
-- 
2.53.0


