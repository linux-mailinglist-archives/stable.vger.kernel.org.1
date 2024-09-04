Return-Path: <stable+bounces-73002-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DA696B979
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 12:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82161F294FB
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 10:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38CB1CFEAD;
	Wed,  4 Sep 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpIxHr6H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9E1CFEC2;
	Wed,  4 Sep 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447452; cv=none; b=qWZdHYSE9l+WijOlSvNcF/RXxjKJ7zrMkROVDWWqwMYNJJC+RHFXXqjDKF5M/cdwHQYCvrHuKOO+vht8PPvVfKtzptDkCRYbSYlnWIH8WAjrU0f00tALKlhsMQpE8jlBsIezWmvkUqvAjDT2VFeom3+a099ZG+gRLRu6tqQfwns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447452; c=relaxed/simple;
	bh=RncFxiJsAUUV8VzKh7EZffKWsMGXTyj9/Tkfx5WGeDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llRx3WHPkgaG5SpwGBquCB8RjJqR7rm3oB9mqLGDyzm5xACkxx76Bk+xm3pJazmiVM0ggn0EmX7Ic2YMaFM2AIJ5ncntFN2Sjld45ehHEH1mR4+Yo3bU4X52l2YjW7tLdb0nT15fQK+YPccQPEEN94MGJOCovIMdstbR9dKgRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpIxHr6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FBBC4CEC2;
	Wed,  4 Sep 2024 10:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447452;
	bh=RncFxiJsAUUV8VzKh7EZffKWsMGXTyj9/Tkfx5WGeDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HpIxHr6Ha5Dm7+Epsv3J/RvBh9p/EYM7VDFCDYwgS3gBAqPudk25DXiqb+ERY2JSa
	 mOaPW1zc24jtwkaBPJM0V7TlN/7mg7VHFlkuBkNWswl61pVYrfZPPKNBr7IhI50bIA
	 ELWjwkVz+llfQOoiy8i4w70tSIpLxixkb2FYlJf5ttyCA/DAuGZiDBAZ9ik9WBfP/0
	 T5dxxa6c+kPy05EnrvQu5xaBwLGuv5Pj17ffcpTSgjsnK/Aevh67I9EHhLg9KDM9ad
	 8lmHCdoex+PhdI5b8d8sHSUZbWLzV0AHgpna3+DLt+9ktkkVlew9ATATPAGx/rW0O+
	 psCmnzgLI2Wag==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] mptcp: pm: avoid possible UaF when selecting endp
Date: Wed,  4 Sep 2024 12:57:22 +0200
Message-ID: <20240904105721.4075460-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082656-bamboo-skinless-9366@gregkh>
References: <2024082656-bamboo-skinless-9366@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6195; i=matttbe@kernel.org; h=from:subject; bh=RncFxiJsAUUV8VzKh7EZffKWsMGXTyj9/Tkfx5WGeDk=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D0RTJ3QTcGzQOPpXnsz2soQkQaFj+Q67coX4 MSyZ5fxMkSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg9EQAKCRD2t4JPQmmg c51tEACRZRRZ4y5K9hTBb/FUuqCuAoBnelBMc18hkKc16bvGQ78J2ZY6Ulr3VXZf/mES+GSshD7 eT1OHrO/d0tdh7ZwRVqIVkVyb1bo02rxo+Hvkj0Fbm8cZ7ULvFno0+keqbWlCjWp6R+lkN++swr Ieh9E2J3fKoPsrwTf/Zp34RO9TpJ3ppUF4DXrPxfbd9thOklAbCDRgqPIvuhy1L9SJhzZXW8zvB Xw5fl/vrNQT0kSVH8a8alPyPvXX+ytpItGj0Pm+V68JFrngP+OGykS2XSmnceh6lu2+CO5N0Hvg QaYX4yd4MCYbzgVUoTxajxeYVQ1zLUc16QYvF4OAQi3vIPrfZnwjXY7UVAEq6HB9iDc/42AS1VU HvkKTH5DVNr2rHeN5II3RG8l9wb33VPI/G6tUFyW5q87brXMFcOG7+6Tej/obCeXht0tXVP7wGz NMBELSLIkaO93fnaFKrbbxveI3bNkfhJCWs0CWayJyxCuJyTR8ZNUkprjL0a/JE7pKGSt91tQUD 08PrNtxy+QZeWS30xIaLWG56RD6umbyfxR82CN5wcCnW5lr5l99pqRKdPtyyCSEEZGC8UoUR69y fucTzU5396156xlqtwWNHsQxMy8zTXuX8sSKng+6G7R9cNIB+VcDGFJFNqXt0RuECS0j9AntiEE 7WMzBInjvV1G3hA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 48e50dcbcbaaf713d82bf2da5c16aeced94ad07d upstream.

select_local_address() and select_signal_address() both select an
endpoint entry from the list inside an RCU protected section, but return
a reference to it, to be read later on. If the entry is dereferenced
after the RCU unlock, reading info could cause a Use-after-Free.

A simple solution is to copy the required info while inside the RCU
protected section to avoid any risk of UaF later. The address ID might
need to be modified later to handle the ID0 case later, so a copy seems
OK to deal with.

Reported-by: Paolo Abeni <pabeni@redhat.com>
Closes: https://lore.kernel.org/45cd30d3-7710-491c-ae4d-a1368c00beb1@redhat.com
Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-14-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_netlink.c, because the context has been modified in
  commit b9d69db87fb7 ("mptcp: let the in-kernel PM use mixed IPv4 and
  IPv6 addresses"), which is not a candidate for the backports. The same
  modifications have been applied in this version. The conflict in
  mptcp_pm_create_subflow_or_signal_addr() has been resolved by taking
  the newer version, which skip a lock if it is not needed. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 68 +++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a152a3474d2c..44b036abe30f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -150,12 +150,14 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_addr_entry *
+static bool
 select_local_address(const struct pm_nl_pernet *pernet,
-		     const struct mptcp_sock *msk)
+		     const struct mptcp_sock *msk,
+		     struct mptcp_pm_addr_entry *new_entry)
 {
 	const struct sock *sk = (const struct sock *)msk;
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	msk_owned_by_me(msk);
 
@@ -177,17 +179,21 @@ select_local_address(const struct pm_nl_pernet *pernet,
 				continue;
 		}
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
-static struct mptcp_pm_addr_entry *
-select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
+static bool
+select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk,
+		      struct mptcp_pm_addr_entry *new_entry)
 {
-	struct mptcp_pm_addr_entry *entry, *ret = NULL;
+	struct mptcp_pm_addr_entry *entry;
+	bool found = false;
 
 	rcu_read_lock();
 	/* do not keep any additional per socket state, just signal
@@ -202,11 +208,13 @@ select_signal_address(struct pm_nl_pernet *pernet, const struct mptcp_sock *msk)
 		if (!(entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL))
 			continue;
 
-		ret = entry;
+		*new_entry = *entry;
+		found = true;
 		break;
 	}
 	rcu_read_unlock();
-	return ret;
+
+	return found;
 }
 
 unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
@@ -527,9 +535,10 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info,
 
 static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_addr_entry *local, *signal_and_subflow = NULL;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_addr_entry local;
 	unsigned int add_addr_signal_max;
+	bool signal_and_subflow = false;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	unsigned int subflows_max;
@@ -580,23 +589,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		if (msk->pm.addr_signal & BIT(MPTCP_ADD_ADDR_SIGNAL))
 			return;
 
-		local = select_signal_address(pernet, msk);
-		if (!local)
+		if (!select_signal_address(pernet, msk, &local))
 			goto subflow;
 
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local->addr))
+		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
 			return;
 
-		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
-		mptcp_pm_announce_addr(msk, &local->addr, false);
+		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
-		if (local->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
-			signal_and_subflow = local;
+		if (local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)
+			signal_and_subflow = true;
 	}
 
 subflow:
@@ -607,24 +615,22 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		bool fullmesh;
 		int i, nr;
 
-		if (signal_and_subflow) {
-			local = signal_and_subflow;
-			signal_and_subflow = NULL;
-		} else {
-			local = select_local_address(pernet, msk);
-			if (!local)
-				break;
-		}
+		if (signal_and_subflow)
+			signal_and_subflow = false;
+		else if (!select_local_address(pernet, msk, &local))
+			break;
 
-		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
+		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
 		msk->pm.local_addr_used++;
-		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
-		if (nr)
-			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
+		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
+		if (nr == 0)
+			continue;
+
 		spin_unlock_bh(&msk->pm.lock);
 		for (i = 0; i < nr; i++)
-			__mptcp_subflow_connect(sk, &local->addr, &addrs[i]);
+			__mptcp_subflow_connect(sk, &local.addr, &addrs[i]);
 		spin_lock_bh(&msk->pm.lock);
 	}
 	mptcp_pm_nl_check_work_pending(msk);
-- 
2.45.2


