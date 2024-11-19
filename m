Return-Path: <stable+bounces-93972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54D39D25E3
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B62428527B
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC91BDABE;
	Tue, 19 Nov 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gpaz+qN3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97461CACD9
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019470; cv=none; b=lmdvllaCnm8oean3AMN8/upqT86YJRvhPm4YaTqDtqhlM8qto0swrGV4T+dyBJoTnXwnlsNS7Cc8mmH0I/CfUGcvvHAcIuGwjrttv9viOyyoif6OWcnrzOJHvWaYyDDv0QW7MUv6jdU0QjpLhl8oGB3VapgofsDEfGkiG09Q+ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019470; c=relaxed/simple;
	bh=ey4wKhSCRkrS/8r/BX86IG6zxSUSnNFKPDrKigxjOwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKNgmLLe44e3Ulhnew0mu0UkHr0T2FZW27c9BC6I83W6tukjTPiowCea8MjXxAMCp89hT4TWyKH4oSy1alVmbdMu2MtoGX2CvPVRd0sbXXZyddjvqOi29tv0oRDtJj2mrj2lkTQr7MWjxIWhdFIKASXo/NIKqDa3Yc6o5Lsi3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gpaz+qN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043A4C4CECF;
	Tue, 19 Nov 2024 12:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019470;
	bh=ey4wKhSCRkrS/8r/BX86IG6zxSUSnNFKPDrKigxjOwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gpaz+qN3gDYbZ824IsvaQ73+CPvtx5kTwTqFfGzIZCuadCDpHk14BbD/T15LAyT8H
	 Oru+AZYfuuLb6PP+Fz1rvJUNNV9n+YpwUFTzZ29YvcE8SofUbM72oUbLUfmbn9YehE
	 BCxiXi6Oeuk0wBFKNs3toKE5ftx6tfLu1ZMQCyJo7CIaKJJvHPPnBMi0l1n9DazYB8
	 1M1xHr+FPGXDD75QIqOQBkPFtJCedsYBSTxRShuisoYMZR5hb37Ta0kOem6ogG0t8j
	 jtKevBS5P8SG5TC4eGVyvs//CRCR2HEKfsMemugFUHgQib6unVpM+w8S4FLWQv7sJR
	 tS3s7raOOJR/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 5/6] mptcp: drop lookup_by_id in lookup_addr
Date: Tue, 19 Nov 2024 07:31:08 -0500
Message-ID: <20241118182718.3011097-13-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118182718.3011097-13-matttbe@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: af250c27ea1c404e210fc3a308b20f772df584d6

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Geliang Tang <tanggeliang@kylinos.cn>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 01:18:40.472383026 -0500
+++ /tmp/tmp.zP9Ogi8y9E	2024-11-19 01:18:40.466656512 -0500
@@ -1,3 +1,5 @@
+commit af250c27ea1c404e210fc3a308b20f772df584d6 upstream.
+
 When the lookup_by_id parameter of __lookup_addr() is true, it's the same
 as __lookup_addr_by_id(), it can be replaced by __lookup_addr_by_id()
 directly. So drop this parameter, let __lookup_addr() only looks up address
@@ -8,15 +10,22 @@
 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Link: https://lore.kernel.org/r/20240305-upstream-net-next-20240304-mptcp-misc-cleanup-v1-4-c436ba5e569b@kernel.org
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Stable-dep-of: db3eab8110bc ("mptcp: pm: use _rcu variant under rcu_read_lock")
+[ Conflicts in pm_netlink.c, because commit 6a42477fe449 ("mptcp: update
+  set_flags interfaces") is not in this version, and causes too many
+  conflicts when backporting it. The conflict is easy to resolve: addr
+  is a pointer here here in mptcp_pm_nl_set_flags(), the rest of the
+  code is the same. ]
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/pm_netlink.c | 12 +++++-------
  1 file changed, 5 insertions(+), 7 deletions(-)
 
 diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
-index 354083b8386f0..5c17d39146ea2 100644
+index d8c47ca86de4..76be4f4412df 100644
 --- a/net/mptcp/pm_netlink.c
 +++ b/net/mptcp/pm_netlink.c
-@@ -499,15 +499,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
+@@ -521,15 +521,12 @@ __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
  }
  
  static struct mptcp_pm_addr_entry *
@@ -34,7 +43,7 @@
  			return entry;
  	}
  	return NULL;
-@@ -537,7 +534,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
+@@ -560,7 +557,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
  
  		mptcp_local_address((struct sock_common *)msk->first, &mpc_addr);
  		rcu_read_lock();
@@ -43,13 +52,16 @@
  		if (entry) {
  			__clear_bit(entry->addr.id, msk->pm.id_avail_bitmap);
  			msk->mpc_endpoint_id = entry->addr.id;
-@@ -1918,7 +1915,8 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
- 		bkup = 1;
+@@ -2064,7 +2061,8 @@ int mptcp_pm_nl_set_flags(struct net *net, struct mptcp_pm_addr_entry *addr, u8
+ 	}
  
  	spin_lock_bh(&pernet->lock);
--	entry = __lookup_addr(pernet, &addr.addr, lookup_by_id);
-+	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr.addr.id) :
-+			       __lookup_addr(pernet, &addr.addr);
+-	entry = __lookup_addr(pernet, &addr->addr, lookup_by_id);
++	entry = lookup_by_id ? __lookup_addr_by_id(pernet, addr->addr.id) :
++			       __lookup_addr(pernet, &addr->addr);
  	if (!entry) {
  		spin_unlock_bh(&pernet->lock);
- 		GENL_SET_ERR_MSG(info, "address not found");
+ 		return -EINVAL;
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

