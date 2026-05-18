Return-Path: <stable+bounces-249274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD7tF4YQC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:13:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8656D64B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A5A5306600F
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F4447ECFE;
	Mon, 18 May 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQZVQ6LI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6843CEF8
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109500; cv=none; b=ku1Wo8c/1pi1o4bOssWlmjugUwycdf+gtlHZSBQn/oYM+TZvGLo0LAfmy9PflDFtc2zzylyjE3kZb09RgLjeWNS/lAQi/8hRAvTi2enZpo7vPyr3yd9HT9OSrDhiHqBPMzWakQcagM3r6/bztJyFJkEASFtWA31sYJ6RX+C7apE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109500; c=relaxed/simple;
	bh=Ftmhs1kh3A0HrMKe5pNPz0w8fC4ntFqKRh7FETgwCFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYbnqv8YwW/0cOX2WSAb04xYAAk2XMxNB2AQMGb/rqFatZkg+7IKwUaEhHk9EzP8DWJY8k8PLthzKVwlt808wulPxKMOQseNjVeQRTEPUViAsX+IofX9F7UWW+V6ME9ik/xrJI4+8hfbCw31YnajtyISz+r6hoo/WqMGnb1zHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQZVQ6LI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B007C2BCB7;
	Mon, 18 May 2026 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109500;
	bh=Ftmhs1kh3A0HrMKe5pNPz0w8fC4ntFqKRh7FETgwCFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KQZVQ6LI27qfVAWYW7ABOrWqRSYOLRCryh9GHY4S6GugU7p5RtVdXv2xDNnpCz14C
	 VuhjgGwWUQJHKG1Tag7IfO5j/S/IuI//GgcdNec6PyoSr2rsz8bIY5ahKXRTJ44ZnR
	 zuoGbH3TLSQFPpzyA3SOTBiYBeQ0wNHAQpus9qE16/0lWPpxRiCQR9WaDhTc8ZAIX5
	 fZEorwHpBi707QOi+d0Gmt76xAEYiWH+nY8ptNRJksV6eVYXuD4zAb1NDlmmgTjX8T
	 2J6ZOdsp3mrTK5S2/JkvQ3o27ClYF3vHbzPxZJuj7gg+0HZx8eKiC/Kz92uskEOdbQ
	 prP60gt7tfREg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mptcp: pm: prio: skip closed subflows
Date: Mon, 18 May 2026 09:04:57 -0400
Message-ID: <20260518130457.973971-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051229-encounter-relish-ce49@gregkh>
References: <2026051229-encounter-relish-ce49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DAE8656D64B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249274-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

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
index 28f8d7fb7bdf3..655fb90465f75 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -923,6 +923,9 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
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


