Return-Path: <stable+bounces-93824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5979D180C
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 19:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D858282CD0
	for <lists+stable@lfdr.de>; Mon, 18 Nov 2024 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9531E0DF6;
	Mon, 18 Nov 2024 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XL51Kp4Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19C81DED55;
	Mon, 18 Nov 2024 18:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731954469; cv=none; b=gzp+SbOP/nPcaPezwCNZ9g6qi7/zdlUia5MpkfymztHAbjw+ymYilU3QcXE13U7k27Z7UUexNVUX5/prRpNSAXLnxhjbRKyOUkLDw13J4ak0v46n1FSEETKS8HtZu4VSBXyHmEpPpxnxzYfaDFCOgUv0tw7Pf0VPI2VehqwDj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731954469; c=relaxed/simple;
	bh=oiVQNKFq0gEyMzWsr5z5leGv6yB3xSPIZROm0rpJ+nY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgctasONJy3UcLlmdygSz1OdmxVXFyx52+lr7RRTttIK14bNy5q6aHKwvyEBHxZIdmnOd1RSfTjQuAlrcPvqhqajZ/PMfDRbnHEU7VsaG9oY9WSa0h59pIjG7R99wn6DhWKuwIuIWUIWTVzuOpjf1W9qLhQZvohVmMjHlFEpQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XL51Kp4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E249C4CEDA;
	Mon, 18 Nov 2024 18:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731954468;
	bh=oiVQNKFq0gEyMzWsr5z5leGv6yB3xSPIZROm0rpJ+nY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XL51Kp4QoULk+EvhwGla5CxAYb8SgSiT4xD7rRsnhdNpxZeW1G8EtOBs8Nkbzpq4R
	 OF2bd6Si/Pn6j6wOBWwNFqrQkxsY1ZJYdoWoT6si2Zrsgx71WC6jX0pi4lZW/1m3QD
	 u8fB2p8UpBziM4SCxqUWkuEjUz9tY/Pp1jyQ5Ax0Lr7hlWovbH9QmegJ0LyCEVozBs
	 Cr1qHrLTSV2k7sG7HOEN5VRYWleJKja5IMls61LtH8V32tE9d7f/BuM557qJsWQQcy
	 svObap53Gr7pGUrv45ZmuzX4IvlPe8TsOW72cRmB9Da9Jvjc9E7fMipx/STu/6XAVB
	 8mOrT5CZ3QKKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y 3/6] mptcp: update local address flags when setting it
Date: Mon, 18 Nov 2024 19:27:21 +0100
Message-ID: <20241118182718.3011097-11-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118182718.3011097-8-matttbe@kernel.org>
References: <20241118182718.3011097-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2411; i=matttbe@kernel.org; h=from:subject; bh=ZEnmqhcd9qYrLaa0Wh2id9efvACa+gyIat1FkDDs3dY=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnO4cGh++17SLZNwBDlDwCKZG39FSv28Jh1rk2h r1ZkCdvrxGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzuHBgAKCRD2t4JPQmmg c4+HEADn7qrsQDN8g7Ezj+z/l00WO+dUQuIdFpW36hEa13OCFuaQTehPtoEMgqgU4/DPbOX6sN5 RZzxXuBL305ZvqsKzw+HfeEA2Q4m6TsrJ55Q6E9TEcQiR8g706UqktbanN1rMK+EW6kDk7mpFbv cbyzDiLD9neDIt1Rw8sfQx5rz+Vq0T8LNpF8fjU/tvBlLaqytpxZ3zJW4ytZHLacpp0i7oGGg90 QIjoVqpiDcU5Z3mv8TVJFV6/tcC3W9W6FXT9eBGT5r9Jv9S4Crw6ifVz+TtmHMGmhV2iD/gjTle JB+hErDPMMryr06aBS/l1gM975BvFTcQM/Y1oBUkk+nIuondZI063zaUfR82mA5jjKPO5UIchN6 2F4bO+C2S5PLYdho6iSEDt0O4jnXuwhz4eHyuX7f1E6jmqr96RLPMEwWPCpx0Emu0n9X6CjWi4t OlVWJfLMi4uDkK7+1pCHEoED1UMxVhXGjUKDRp/Lry4CrRaq2ZWND6aQQItQgUdPVMRYRrHsmWA KjVVev1t0smGPTAEBvUqZYwfVzKnEp9srxVHKjlH40NmfklmsEMZNkb2mZRDtZ1xgH1eiJlxEp8 5SzhsC6wufiqkQucZ/d6mHq+ybGKUlcg/NBBj3htFdy4p1+Fn3BRlXvpo/cejEKTqlNwQxn3+iR cz5W8wdSbV16/lw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit e0266319413d5d687ba7b6df7ca99e4b9724a4f2 upstream.

Just like in-kernel pm, when userspace pm does set_flags, it needs to send
out MP_PRIO signal, and also modify the flags of the corresponding address
entry in the local address list. This patch implements the missing logic.

Traverse all address entries on userspace_pm_local_addr_list to find the
local address entry, if bkup is true, set the flags of this entry with
FLAG_BACKUP, otherwise, clear FLAG_BACKUP.

Fixes: 892f396c8e68 ("mptcp: netlink: issue MP_PRIO signals from userspace PMs")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-1-b835580cefa8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in pm_userspace.c, because commit 6a42477fe449 ("mptcp:
  update set_flags interfaces"), is not in this version, and causes too
  many conflicts when backporting it. The same code can still be added
  at the same place, before sending the ACK. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 23e362c11801..e268f61d8eb0 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -563,6 +563,7 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 				 struct mptcp_pm_addr_entry *loc,
 				 struct mptcp_pm_addr_entry *rem, u8 bkup)
 {
+	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
 	struct sock *sk;
@@ -583,6 +584,17 @@ int mptcp_userspace_pm_set_flags(struct net *net, struct nlattr *token,
 	    rem->addr.family == AF_UNSPEC)
 		goto set_flags_err;
 
+	spin_lock_bh(&msk->pm.lock);
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (mptcp_addresses_equal(&entry->addr, &loc->addr, false)) {
+			if (bkup)
+				entry->flags |= MPTCP_PM_ADDR_FLAG_BACKUP;
+			else
+				entry->flags &= ~MPTCP_PM_ADDR_FLAG_BACKUP;
+		}
+	}
+	spin_unlock_bh(&msk->pm.lock);
+
 	lock_sock(sk);
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc->addr, &rem->addr, bkup);
 	release_sock(sk);
-- 
2.45.2


