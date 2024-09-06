Return-Path: <stable+bounces-73729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166FF96EDFA
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89DEDB24371
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC96215747A;
	Fri,  6 Sep 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx4YIUTR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7E5157476;
	Fri,  6 Sep 2024 08:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611345; cv=none; b=lSD+BP4vnUQMcYbeUVsydWWnjVcaYRuB7DoTiQdnO6IPpCMYZIowNxasOhe5BhjVg72Kkr8zEakQa8QS0QR6kFQZL8uAi7yG/TwojFKg9HG3m//puJVW8GiPRnYz2bICuhQ7va3vBeWizGPjNikxcZQeWQ0bxpdpfVK2oVdZY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611345; c=relaxed/simple;
	bh=X48nl3to1g7eRWoLVuEHraRGZKvGqO6riK+lemkiL0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XFzQKFK9viry2ST6UeMczM7afpf37ouiLHK07fYnn0e9PyAvB0Vr9NPfuGutsvG81YItFB4NGf1mFV/iQFQxeJmt3fMNF5rMoFuJwSSaWu72a673wWIOq8srAWMjj+boLwOtkP3EnVIEyD04dzRGrfLYDrbp2X7qwGA1io9mKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx4YIUTR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903C9C4CEC4;
	Fri,  6 Sep 2024 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611345;
	bh=X48nl3to1g7eRWoLVuEHraRGZKvGqO6riK+lemkiL0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tx4YIUTRkaBZ7eTjHfdCnrXdaR5auTPZ7TRV7asjRlRMAr16NHxhIFCfDA3VXnfFU
	 qsyTbtriWMOkNvzqjigeVKRTZThFvxvwAvR3UZlfJyVDSE1D6XZnB1QBuTi2GEiPoZ
	 GxIQ2YNEN24kC4mHEniX1AWUxobvXJMNbkj/HmZPaZ0G6Z1qkPNWmV9TRLG7qqAaGe
	 6Lcdy1MVJFDv8IZKKxMIftC6WJimVzNOAY6+f7s2yI8XPqI9qeVNN99dia+i7P6FOT
	 PhgZG4yqIP0UcASNzg4DFTEtUj20VF6aJ63OyrQWBrOt5Mr9H7ZIXMsR2pLzRCDCjd
	 IYMopYasH18Nw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15.y] mptcp: pm: re-using ID of unused flushed subflows
Date: Fri,  6 Sep 2024 10:28:54 +0200
Message-ID: <20240906082853.1764704-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082642-google-strongman-27a7@gregkh>
References: <2024082642-google-strongman-27a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=matttbe@kernel.org; h=from:subject; bh=X48nl3to1g7eRWoLVuEHraRGZKvGqO6riK+lemkiL0A=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2r1FyRWnhRO/yevewebJ43af6IqQPyvpCaByH 2Rgtj+ToZqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtq9RQAKCRD2t4JPQmmg czelEACHetKE4wXN14XHK7GEsDsMucZevRll8BTLDyaruJoxjbD+FroyLAXDIeuEeaJP0vMLqPX fxjFVWLlKdcsUA0ktFiZjKC6SMBMoctEGa8jLgO37iubVuPcdCQWPBO2V+zDjN30lOpzRHBUoAl VYEQdNTsdQlt33H35n/Kd+zpDt354MzUYzECm3COYaStmeMIl+ogwC5zH5c9vnJqI9nNMp3MmOx y1SkvRLnYXg5wp+W7oLBBf+YSc0R8/vyQBy69ZaAE74B2yAl3+tYKcVHk0dSzS6OjC+5+fhxiQP cFfNpwsWvaRu4DIX1SdHnZQACUSC+zdmiRdGqSWge+DZnaqf+cFFP5m3pmApnsHE2H4T5sobgOH uGILarv7Wa/idF4OCz5S0jDqENorcqa3BL+vIytdJD7rJUg7uJ9h4BgvQx8oYCmEiNicoidQ5Hw DeXCakup2gGlCQ1r4mlXAFbi4h7sAKIxwRHzljYcuZws3/EggFViuS5zk9zbkAlcFqxg+C84KrO Rk3YBWQG1PY66v+Zec9kcdj0hAbeHzEdW7BLg/iwdNSXVm8zPjiu6EoZy70NEhmMHPJOd/V48u/ iwfc9z8qoKYCJBs6VgapWjOqsU6yzPo9Um14XHQMYhyUQqwfScOhpe3haUtBSiUGl1UtX0zRwPL W1vLvjfhW6ys0HQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit ef34a6ea0cab1800f4b3c9c3c2cefd5091e03379 upstream.

If no subflows are attached to the 'subflow' endpoints that are being
flushed, the corresponding addr IDs will not be marked as available
again.

Mark all ID as being available when flushing all the 'subflow'
endpoints, and reset local_addr_used counter to cover these cases.

Note that mptcp_pm_remove_addrs_and_subflows() helper is only called for
flushing operations, not to remove a specific set of addresses and
subflows.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-5-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts, but the line modifying msk->pm.id_avail_bitmap has been
  removed, as it is not in this version, introduced later in commit
  86e39e04482b ("mptcp: keep track of local endpoint still available for
  each msk") and depending on other ones. The best we can do in this
  version is to reset local_addr_used counter, better than nothing. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 1ae164711783..fc1c983dc0d2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1498,8 +1498,14 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
+
 	if (slist.nr)
 		mptcp_pm_remove_subflow(msk, &slist);
+
+	/* Reset counters: maybe some subflows have been removed before */
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.local_addr_used = 0;
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 static void mptcp_nl_remove_addrs_list(struct net *net,
-- 
2.45.2


