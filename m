Return-Path: <stable+bounces-249436-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Nw0I4y7C2q3LgUAu9opvQ
	(envelope-from <stable+bounces-249436-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:23:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C6C576042
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 03:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C5493023E68
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 01:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A912D7DF8;
	Tue, 19 May 2026 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWBA5KDU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739982749CF
	for <stable@vger.kernel.org>; Tue, 19 May 2026 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153793; cv=none; b=oxefdv6kqPvInDLzQAFRg9VE6S52hPqWXRBv5NwVnZB98Qa4ZXem9f9o8Re3VGb2S368bObwhqTPU0s//byJaNZf5hSIJaWj6lNmyLAhWmF22h/0YLYrsZlNfs6WFi7WIG9p+pze1Y/RYiUSL9x2tpat0z/yrLdT5GaB5VY9GbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153793; c=relaxed/simple;
	bh=wuhXmf7lDpEG92Mma472C67JJ3dGywIrB7rVAhIaudw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdLOz6qs9/XXMPNw1Q4LCD1EGUYJTvzS798TwVIwXVd1ZRnsiLovRShgSKispaRG5SAPSuhin+JA4WDDCDFZbCyPH2VXpfFwDbx10x0HNMW+sEqdiOSZrnhxkKNOp3QIJg4mboZj66Km4tHuMLvKe2IPCNdy4qA25ElMwfY46FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWBA5KDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C408EC2BCB8;
	Tue, 19 May 2026 01:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779153793;
	bh=wuhXmf7lDpEG92Mma472C67JJ3dGywIrB7rVAhIaudw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWBA5KDUQfol12la6lsKVfqjkgg1m214lhPm+EgtVYkw1wmWSLf1xcANQxOQZT5D8
	 RzW6/1kisBMdnsb9m2bCSeoXeOkOaOZEOs2m9o/GUlWU0zr7RIltiVcZfqnW2K1TLm
	 TB2Swj89n+qqyGiPJiHEUrVANwS++UIEFjz6QYoXVcY1dDZqeUaUYAiaQRGkVwmtS1
	 xJpqe45BL2oetXBl+Mm7gTE2wVEQcAZOuPs4ySGk68vHay6zBcoLx4b45H2gu0IQX/
	 aQXOdxBXgI2sDCQA9drF0sJc6C83v2T5GpKAzu8iA2bnLf/985dTdnw2XtFD7NVWDE
	 HC+S62MPBtXgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
Date: Mon, 18 May 2026 21:23:11 -0400
Message-ID: <20260519012311.2020532-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051253-hammock-appendix-2109@gregkh>
References: <2026051253-hammock-appendix-2109@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249436-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 34C6C576042
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 3cf12492891c4b5ff54dda404a2de4ec54c9e1b5 ]

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
[ replaced `TCP_RTO_MAX / 8` with `HZ` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 3ac09bfe6e4b2..3b426194097b2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -308,7 +308,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		return;
 
 	if (mptcp_pm_should_add_signal_addr(msk)) {
-		sk_reset_timer(sk, timer, jiffies + TCP_RTO_MAX / 8);
+		sk_reset_timer(sk, timer, jiffies + HZ);
 		goto out;
 	}
 
-- 
2.53.0


