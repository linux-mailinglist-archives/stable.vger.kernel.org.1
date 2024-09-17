Return-Path: <stable+bounces-76548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2B497AC01
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 09:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BE34B2B702
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 07:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020EB1369AE;
	Tue, 17 Sep 2024 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXTdqrGb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D9C44C77;
	Tue, 17 Sep 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726557988; cv=none; b=RV12611CB6eW8pz+hQP9k9x3FEv2af71DobqI4kIi/QNyYw+KdXE4cfzvGdJ9zCZQwtpBjt1+G/EA91VQcrCoo3rqRqhwGGnjYdIEZmoNtg+b1hbehs9ZuqQydwVt3+CXoSFW0aNkcTAxsws/Rs6YOAWH8/EKXKDHBP1S6935BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726557988; c=relaxed/simple;
	bh=nRfmVPEDUVmNUuD9Fyeh8+jCoo2WVsRCK9jRCfh0E2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swhm+GL0Ch9aQEQdyyRwWh0f43/iT2GqUllERyIF8uRbLaZ428Y3fy9iLd7g9lSrLnZuqZqA32R3MdwL680uUBcJ1csXUT4m6LgLmj+1pVzn0fvKL+0ZT9j/3oOJDbc5JER/wBFznpE/WVoCKIUqNOqhM3XLc7pw5KYxr70PjME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXTdqrGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A18C4CECE;
	Tue, 17 Sep 2024 07:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726557988;
	bh=nRfmVPEDUVmNUuD9Fyeh8+jCoo2WVsRCK9jRCfh0E2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NXTdqrGbKa+thdcRpxmf2B9YWP3sDwjlk4caxwN1EhWvFK3LE+hOhH4Cg4Ym7VVoB
	 pGzHcYd4V9WJBfmdZA5IAFZuNCtu8MW68lze8atcFRJ7AZbIOdtdIOpPUJcqSW9TkQ
	 eISu36gykgcuT0thrrlybwwDESRiAQvbb7dWlGBnFp+l4Dl3GfHQMtowUiKKUfekAA
	 P9RUMQXFTtVL9fULxT6UnIxCaOuHAfxEqRFos30nSxd40sj1AG6E4f1OIujr2oSvaV
	 VI7PPhAz87XnE1zPAlB60J+dXtwaRA1UQtBK2Fa0Rt5vZ6+JbnrlWmI+8PdmFxNyDY
	 S2ixm35MoOqBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <geliangtang@gmail.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH 5.10.y 1/3] mptcp: export lookup_anno_list_by_saddr
Date: Tue, 17 Sep 2024 09:26:09 +0200
Message-ID: <20240917072607.799536-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024091330-reps-craftsman-ab67@gregkh>
References: <2024091330-reps-craftsman-ab67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=matttbe@kernel.org; h=from:subject; bh=oIUrVRRV+PohuYO406E7ZO7xZUbtLZlK9mM1GWWX6oY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm6S8QvsEjhPdCBBunVh6iluUh8rsZSwfXokqp0 nHz77R+dH6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZukvEAAKCRD2t4JPQmmg cxX2D/44RastLMAwUN2zBw441Yy8J97UEn1nmZqvIAltrvLqr5fTbKZRkwIMA/Xz7U6/G7cFRtD fR7SVa+c23qxcYaNdoogCy+BshSXMh0wmaw4pY3QW31o8WNAzwUoot9eRI+rEWcUkppTylZSLHT RnacEahWM/iQDJf6EOMB2r3Rlxf+VY6e+4lxZR3/QYZ2Ug/4rFaZgzeD+sD9Y1uFJ8/8lYId4nO V4ziYpBqG+es6Lh1BY/5QMOYlWEMftr49uKpF+Z2MyDwsM3hRdhVG4DZAV34XTTj9Iwtd66AfDY KKLL3m/W4H7MRU86vBRfU6RXxaH+00oBzzeiZd2czTEpVr+MrfvX3v65qKXqqXA7RiLHp3tMEt5 cNZ04HI3vCakSNQGhdUa+Qv3QwZ1TrtXf8ykI8VfElrlmG/uJu5V+CVg/Ul6jodpocsViAt5qwt mkjNeVNsTV81uavxtAfxm6fe7WTyKe3a7qU0Mv3jFOsecQotP0p9KDI4tu2LqoeW47v/1qUNvqq mPW0Xr0kmtQhqiN1Ih+Yc0h9iCfiZop4pzvHeNC6/5yvyt1Uc46T90yR7Us6p7eI15jgh2pcspx FnAcHiS+JvVLs6JFnxNQMkwp1qZ8EkepyAu7VJecucYceLAg+iegrabadwZSWUJTXq9xUTLHlyP ShXjokadFCVAYpg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@gmail.com>

commit d88c476f4a7dd69a2588470f6c4f8b663efa16c6 upstream.

This patch exported the static function lookup_anno_list_by_saddr, and
renamed it to mptcp_lookup_anno_list_by_saddr.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: b4cd80b03389 ("mptcp: pm: Fix uaf in __timer_delete_sync")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 +++++-----
 net/mptcp/protocol.h   |  3 +++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index f115c92c45d4..0b566678cc96 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -194,9 +194,9 @@ static void check_work_pending(struct mptcp_sock *msk)
 		WRITE_ONCE(msk->pm.work_pending, false);
 }
 
-static struct mptcp_pm_add_entry *
-lookup_anno_list_by_saddr(struct mptcp_sock *msk,
-			  struct mptcp_addr_info *addr)
+struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
+				struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
 
@@ -255,7 +255,7 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	struct sock *sk = (struct sock *)msk;
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = lookup_anno_list_by_saddr(msk, addr);
+	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
 	if (entry)
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 	spin_unlock_bh(&msk->pm.lock);
@@ -272,7 +272,7 @@ static bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 
-	if (lookup_anno_list_by_saddr(msk, &entry->addr))
+	if (mptcp_lookup_anno_list_by_saddr(msk, &entry->addr))
 		return false;
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b8351b671c2f..eaaff2cee4d5 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -451,6 +451,9 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
 struct mptcp_pm_add_entry *
 mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 		       struct mptcp_addr_info *addr);
+struct mptcp_pm_add_entry *
+mptcp_lookup_anno_list_by_saddr(struct mptcp_sock *msk,
+				struct mptcp_addr_info *addr);
 
 int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 			   const struct mptcp_addr_info *addr,
-- 
2.45.2


