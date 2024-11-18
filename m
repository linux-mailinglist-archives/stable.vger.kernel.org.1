Return-Path: <stable+bounces-93825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027049D180E
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 19:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7DB282BF0
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253E1E0DF8;
	Mon, 18 Nov 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjWOkjoI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB81DED55;
	Mon, 18 Nov 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954471; cv=none; b=nziq3+FQv01QrdXzUBp0WLWnSLXNnwIjWLoL4vFIcnYd6iYF6igsVS7uzoA2BkidSSJMyU5WYnFKz8bivFYDmKKaP6XOYy/kAmGOAspvTP3Mr6c0racjvqLpd9AfRZz7lQDGlJybYOyD8et89I6w69mVRtHViNSEzi/25J9DU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954471; c=relaxed/simple;
	bh=CdJglmChTxPvCtcuBJbIchuWMi7jrzVTg3UuiGg/2/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHsocjir471dkQYFL/3kPL+6k7gGb486CFytd2HoUrw6jGZnwFHLeUjuE5GUr2vie/7XL27YWjYIn42bOREh46JOSGxqmBbgANWduVifkEtvy6MfXWStA/8VFVEHJyDDtE2J/925JfUb4SFQGtf1VuiqWRHE4/9pzNnIWOn9AOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjWOkjoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00FE2C4CED1;
	Mon, 18 Nov 2024 18:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731954470;
	bh=CdJglmChTxPvCtcuBJbIchuWMi7jrzVTg3UuiGg/2/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjWOkjoIHgICTicAbASA4Umx2kDmpfh6tJIFGWipUwIlQwnjlwwUH7bf0sjVaDiJA
	 Hi00cSTuVE3kHv/8Q9k7Gf7G8px/J+pQGBHLzQ4WKV1UsODNPjdKelXb1KZpYRLn1K
	 LnLmj/jRA7jxm5DEha5WG9LPTrvYtBAbhF3f6+WFvdXyFbW9Tt5bYNRVylBIP/Ng1b
	 KeaznYcd02KPDrAljppgf0g5Loozg5fpqn2ZSDApsxPDz5mQP9ce0KKrZZa0q8vZ67
	 I5ED4XidTpPDF15A69NQCC4qVyoWRJ+ZPtUQ4sUpt9EF/6bdJ0Ne0zRSqKIA1vT02w
	 trLAnJy922JPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 4/6] mptcp: hold pm lock when deleting entry
Date: Mon, 18 Nov 2024 19:27:22 +0100
Message-ID: <20241118182718.3011097-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118182718.3011097-8-matttbe@kernel.org>
References: <20241118182718.3011097-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1570; i=matttbe@kernel.org; h=from:subject; bh=SMoaqfsurtC6D2JNsiposiESLPMcvY287nxTCPsXang=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnO4cGKsSQS9V78pDIw2VLzAglaaSkLH9/C+Drr LrXPQayRMyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzuHBgAKCRD2t4JPQmmg czGjEACsPHUH62v014SQaNsBCKF5zRyhMD5aAt6pdj1BSqCugYyovuP6ze02bAf4prc95foW7DB U/jEMbBjyNBFl6duzy53dv6Fw0FfNJR/cT1rTRqMZ/q4jn9M6dgsvgKluvED35dLICdpV9wzgRs xs3Hn5Gvc7Ok7Wo/0ItTFQSASO5z1iUOeW7EG/JFy/4fPljkugK/rI3cgZLgXZEmgPIXoXcfgNS A1SxAaaHs0r0MJI/itmpcwrBQDV2UqUv4UlblBwzp76zqtnn6VvUVlZbtxCvhAfszLuW4uj8oND /EPznlIJepa+EM8IlfN5qDIZK3Xlv4D4T4c5GZeduc7tr/kk6fJ+rUNX9IfqL2weXWTfOs6Txa4 JOGmNlZ9Hy52Nkz6FmxQwCrlKsnK4Xox55/OIgP3WW7XJlAfJdlT4Fw2+MIXCEzMLykFgljt8JX Y0MV78q0mOBDNJ7amS9dk7qmG5ZQHJes+AJYq4sIC2X3ZkcqWskNQ0xmHyIS5t0h3pyXWaXjszl UmT4rSOkIy0kPCdJMkoe9InmfZgvDsYZRc1B7NHm6Eg2Wwy2ORosPP3vfCgj/kIIWZ3mn7ZfUZX 98T8rwSFPsbC8ljNnOejgisSF5dpoHSRxaLSufg/I2Az53KUiTo+XIH7H8MHAZcydjZ0/xVlifn PI/W1G85LMhjcyQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit f642c5c4d528d11bd78b6c6f84f541cd3c0bea86 upstream.

When traversing userspace_pm_local_addr_list and deleting an entry from
it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held.

This patch holds this lock before mptcp_userspace_pm_lookup_addr_by_id()
and releases it after list_move() in mptcp_pm_nl_remove_doit().

Fixes: d9a4594edabf ("mptcp: netlink: Add MPTCP_PM_CMD_REMOVE")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-2-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index e268f61d8eb0..8faf776cb977 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -324,14 +324,17 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
+	spin_lock_bh(&msk->pm.lock);
 	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
+		spin_unlock_bh(&msk->pm.lock);
 		release_sock(sk);
 		goto remove_err;
 	}
 
 	list_move(&match->list, &free_list);
+	spin_unlock_bh(&msk->pm.lock);
 
 	mptcp_pm_remove_addrs(msk, &free_list);
 
-- 
2.45.2


