Return-Path: <stable+bounces-93956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F1E9D25D4
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0026B294B1
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A675A1C07DB;
	Tue, 19 Nov 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRrJ/ZlU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7871CBA12
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019439; cv=none; b=o3jPz01DFrWkf6VElV5vhmUrqGHFvn76DI998O8zJvH/a8wDTGRWI+tQbIPSPzJ3eeysetnWEEvUDfXK5Mei6K/xvDT0sx3IEYISw6Ts2au/fINhKYH3uZy2cTp7RhxaEuvXziQEIlBbUKxyktV9cRm7JJjjc5FzFlpOFN0gLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019439; c=relaxed/simple;
	bh=E32+QOn1tQ1/JFiqIhC5sGnXZdWP+mrFw+U4wDPAFA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjVCQbmzOuiESZRSUn2kX59dMBVF4VD2XKvZYSgzZWIdVnMFvdbjyF025fzTDR6zwKkW/tGi992FmkXTtJoghjD0BMC7ejFQt2U6aHZbFH8Bq4r1GdGgU61qPryGmABU80cvDwQNww0ANJ7/F7vE7xm/x8CMNNZLmYCaHbZUVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRrJ/ZlU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D06C4CECF;
	Tue, 19 Nov 2024 12:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019439;
	bh=E32+QOn1tQ1/JFiqIhC5sGnXZdWP+mrFw+U4wDPAFA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRrJ/ZlU0k5UARBaSVTXsCwzB6xbg5yaxNhSvaxjpqA31ix8fDyuXye7VaB+id+fM
	 khhTxSVR4ZL3D7ZtEbdvMMJgCaXOc7s6j4PJaTu5Atupzsgc78qXQTrZZlN0pmxItN
	 Oy9u8i3xXwlggH0EWXsrpDBjhjA3g5MtLhf182dOmv5mSV+24xqthgRjxr7hQ6UCvR
	 +lHbstRNX1UwuQ1LDvSrlX/dUV3gYXV6rt3TtXaxjcavQ327Nmnz0d4APVTmECVN9v
	 RJHOmW3OBOLkbzZiRKcxdlpXC8UveFiaEh7HOKYCWufnFCmwrVwdIt1PG0vTW8/DH2
	 OcWpnk6WzY5yQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 4/6] mptcp: hold pm lock when deleting entry
Date: Tue, 19 Nov 2024 07:30:37 -0500
Message-ID: <20241118182718.3011097-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118182718.3011097-12-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: f642c5c4d528d11bd78b6c6f84f541cd3c0bea86

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Geliang Tang <tanggeliang@kylinos.cn>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: ff6abb7bc44a)      |
| 6.6.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 01:13:28.589534977 -0500
+++ /tmp/tmp.4bH6oETSx7	2024-11-19 01:13:28.583100037 -0500
@@ -1,3 +1,5 @@
+commit f642c5c4d528d11bd78b6c6f84f541cd3c0bea86 upstream.
+
 When traversing userspace_pm_local_addr_list and deleting an entry from
 it in mptcp_pm_nl_remove_doit(), msk->pm.lock should be held.
 
@@ -11,15 +13,16 @@
 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-2-b835580cefa8@kernel.org
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/pm_userspace.c | 3 +++
  1 file changed, 3 insertions(+)
 
 diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
-index 3f888bfe1462e..e35178f5205fa 100644
+index e268f61d8eb0..8faf776cb977 100644
 --- a/net/mptcp/pm_userspace.c
 +++ b/net/mptcp/pm_userspace.c
-@@ -308,14 +308,17 @@ int mptcp_pm_nl_remove_doit(struct sk_buff *skb, struct genl_info *info)
+@@ -324,14 +324,17 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
  
  	lock_sock(sk);
  
@@ -29,7 +32,7 @@
  		GENL_SET_ERR_MSG(info, "address with specified id not found");
 +		spin_unlock_bh(&msk->pm.lock);
  		release_sock(sk);
- 		goto out;
+ 		goto remove_err;
  	}
  
  	list_move(&match->list, &free_list);
@@ -37,3 +40,6 @@
  
  	mptcp_pm_remove_addrs(msk, &free_list);
  
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

