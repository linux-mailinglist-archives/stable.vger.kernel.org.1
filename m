Return-Path: <stable+bounces-66132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0729A94CCF1
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5EF1C20AE9
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 09:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376CD18FDC5;
	Fri,  9 Aug 2024 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYLpvA3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AA5BA41;
	Fri,  9 Aug 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723194536; cv=none; b=PHIIWvJFcT8/8PImM3XePET/7U6L1XO0mCeBJkJWpKEGNTqvPBMLnL51Ce/10rwol77GplFdnqKBpl3eD7YdWyODmx13SBL/uO4AkFQWzU2jbM1Vt3kOB2Ugh5Hwd1n9MwBFiuCtNSnu1bLSfjl0rnp55hW8KF59s0UcHfo6Xd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723194536; c=relaxed/simple;
	bh=dUCe6wkSLWUf8MtBDYK08Qb4o7Tjvp/4Hc25LXOTzN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNLIFmla/D2VBzFdKQSdzxsMZz2ptnzh26qOsuF0VoI7CVZkdTCEPwVnmDsoPO2x49x7dmSiK77e/BTlEQhItIn1Hd6CGQ2prpMiNo34GWx3tC9yyqDDI09dRCpz5EdXA1T+rZSp9NU/59v8s1VBZhWoq+CPSk8YPADJciZU5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYLpvA3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076B0C32782;
	Fri,  9 Aug 2024 09:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723194535;
	bh=dUCe6wkSLWUf8MtBDYK08Qb4o7Tjvp/4Hc25LXOTzN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gYLpvA3WeFBYh3DdkM9czByiTaIzx4Kj+hjmdHgojQtKm1O3UuffsWaX59NTlc6jE
	 1vRTGQXBeXY4TDf+45qBCkiionL1SNA/ByuA2gs/EV2PFScgn5CtEBaQYs3e+t67N3
	 f2Sr6IJEr7JfV98On8TMKQ8ix7P+EGSfDQLu6NFHasLcFap/IZiPYMcihwjozJkJRW
	 c8CB2cR8Mqy+qx/ieW5gDaflN/zkADMRgj5VTufXRq0qzm8njcxWNNNBVfD/pmej3g
	 b9SXVEkbwG7FJ8vigjqOumiOBdyKznB2WRUCSiZD9Lf0sfb48+Ngoz9DZBSyFlKZLp
	 Fv6iwG3i3Wkvw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] mptcp: pm: only set request_bkup flag when sending MP_PRIO
Date: Fri,  9 Aug 2024 11:08:46 +0200
Message-ID: <20240809090845.2700989-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080704-coconut-decorated-b5ae@gregkh>
References: <2024080704-coconut-decorated-b5ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=matttbe@kernel.org; h=from:subject; bh=dUCe6wkSLWUf8MtBDYK08Qb4o7Tjvp/4Hc25LXOTzN0=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtdydj/j8AW3tPg1W/+A2VYeePFFOnCPwx5xqa 251lO6gojCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrXcnQAKCRD2t4JPQmmg c2HKD/0dgAy4HN/mkjXWzf7MObfngrhns0lc9DvWe3GdXHQZu20tTOwWL+8xi12LTc9FSsCSCGW UsOfYnd8i4QEJRywmJY5eyK4fyBaLcSTsEvcNrVtXVfLVGnhc+rb7tpDsBJKx2a+ab80jGuwVOQ kNBouuhAPEpOFs2fYGP3PcMlhoZWgJmzU/EcZoJMC0OciNhj21ATBHB9zphD5stM7ZKYtETMQuI rZ2ZyWMQcq8OygUDMt6MUqq2ntA4oPEOKS8E9dbmb2/wLreC73dMX7El7PZJiaYrv/vhcznN8JX aKDMMgIWw2uAPwlQc6Ial324Jqyd6fJ5XuxgZEDTn7e52ZkUzk5fWd/6CYOYMDcHUzYlROxebGI AL1spNh8bs4tJSyi3GTAk/VK7vgWvIZkupjteEVeqiKF5a7nPgNXvV2PJvbV5YAmeleM1xvh0/J ifUKBR8C/bg4AhM6ZCZ9Q8CXnxhagtMKz0XkmZnkoKgMVq3v2PnvDQzJE+lai8NLIPojKX9qiHF +D4O0P4HHSX99NeF/tfpr8jG3P359euGfSSAwRvjLFHPICuWPmgJNvmKVXEUlw0qyAMpevtBkWO 8Xz37CPz+SR0WWZYYmGZ73SPrTz/aOCQEs0hqAtIUeXe7TWELzVkLyw51yRHtsCfXsPUy49sgGK WeaZDpCZPQzMA/Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 4258b94831bb7ff28ab80e3c8d94db37db930728 upstream.

The 'backup' flag from mptcp_subflow_context structure is supposed to be
set only when the other peer flagged a subflow as backup, not the
opposite.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in pm_netlink.c, because the commit f5360e9b314c ("mptcp:
  introduce and use mptcp_pm_send_ack()") is not in this version. This
  code is in mptcp_pm_nl_mp_prio_send_ack() instead of in a dedicated
  helper. The same modification can be applied there. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1d64c9fed39e..67ece399ef60 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -699,7 +699,6 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 
 		if (subflow->backup != bkup)
 			msk->last_snd = NULL;
-		subflow->backup = bkup;
 		subflow->send_mp_prio = 1;
 		subflow->request_bkup = bkup;
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
-- 
2.45.2


