Return-Path: <stable+bounces-25277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CBC869E80
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 19:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBA51C2373B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 18:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C589E4EB46;
	Tue, 27 Feb 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZb9Efoq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8279D4E1DC;
	Tue, 27 Feb 2024 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056911; cv=none; b=sbTzMW60krI0HtbyOD3wmYb8e51Sf1/KYIaQChxrqG3RujoMslQc6eYq6sMmXCOxoRxjXYeN55xtqkKVd6i04t7C3LawjQG4VLa7i6C6yZQovF2Z8rIsAYlzwWs7/2lfyWxbQUAI6ZiadNnIbTUJrrV7H7RtRcQyxldFaVxhlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056911; c=relaxed/simple;
	bh=1Z3Q69OmYEu30Zls/B+/PXEuGL1+o71jrgcyXnwvUsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4xesgJ8QC0nejmez1ND+dpt2cXzvnXnF2eOknqawfHIMZsYtwn2Fig2tqLUiYvnaSSbXOvUioAWyHkzTne7f4n09IjdUZf0BVX/dP5UjmIx14nLu8LCbxAL8g5PkTygOvq3e6v5wePJxix/5cHvGYOzv3NZF+tqEs3hu1PtQho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZb9Efoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD98C433C7;
	Tue, 27 Feb 2024 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056911;
	bh=1Z3Q69OmYEu30Zls/B+/PXEuGL1+o71jrgcyXnwvUsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZb9EfoqlEsZktVzYg6qqcGg+ojgiQdfT7QOPtopnh5yoJc0z6lKnzWk7nEzGhQ5y
	 NGDq311TPy6QYh2b1+4VO6zuSgo/quvRZs05CZWjZ1h5TkVZCuGNnbXnS1/8ox8WXF
	 HUpCGHen8pFjMMtq6vj00x9mTeNMPvRqRFU6iCi1NK70gq5JIg7NGrk+cQ4fRqQyo9
	 Tvm2WWGE2n4HDmYuOp0kK733By+Pr5+wFklG8DV20gEGMpCEd/9yGZyX+Yk4OYCsIU
	 uyrzPcICXMF8rtScN9w0NagDoaooDW/M/nK6/GeScFVt1pM3g5L9wTn+HPq0pYOy2+
	 TvuFYYHnYn9yw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y] mptcp: fix duplicate subflow creation
Date: Tue, 27 Feb 2024 19:01:43 +0100
Message-ID: <20240227180142.4029958-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024022601-footwork-fastness-bcab@gregkh>
References: <2024022601-footwork-fastness-bcab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4260; i=matttbe@kernel.org; h=from:subject; bh=ysNUQLXVc2HfAJaSCVuvhMnhQwcLe/2SYGZDWFX4rM4=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl3iOG5YfFW070nm831uSJJPVuA98bapHMgN+1j TWHLVdn8ISJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZd4jhgAKCRD2t4JPQmmg cwu3EADiNmB1+nEREpXf8lLzj0LiP4CWAaiF19eSBztbJ7FWtdD6ibQE9ufjY/ewQKHbw4Dq2um K9Jh4NL21n38owz1uDXZlpxDgDFes22fy4yhJ75l33zWZQLhZzBsJmC91OhW3bo03BbctTGDspS 2TNNuMX3xIjP2EATMX6JXR6f5CoA14J11/EvBQJ4nA8ryy23CR4F3pbIhuz7z713mpndBHyEzUu t4mr8pP8haiC+q9CagD822KnpxijJSbXf419XbYb94ngvR1HTHukXTgUc6g3sZpI1ouCtb3+HfF s+jiqcw5ItDP55p8f/7W0u/hMPpay1XPxUqjxykPSK22aOU8G2Phjcwvxutp9Y5z2DaAdN2Ui/P 81EtZQg/mtPgJJHYgj+13Z+sKS/HSBlWqa0hc0CyjppQkehtbwUoJ87lo+xNM9Pr+00ZQLEZGJs OyuIR3zASFBU7cYa9CQ8k6dDcyNgwM3uIG9wtSNuIUB8DOEXOoPQFXI9J41j6gRGDi8hCcvYNWR b+NQflYIjnJeR/bIQRRAV3wT4ykCLPnt7+A9LfpsFaWinWQ9c8P5KIk6HWjwiSwagGt6XbH442Y RWdaSMof13RDi2SqAs7zwxsop5/uhKqKHH/L9Obq6QIoJ48x06kj/9/d9TqpnVv//OHceq3Haj/ SBn/7O/xpTfCc+A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

Fullmesh endpoints could end-up unexpectedly generating duplicate
subflows - same local and remote addresses - when multiple incoming
ADD_ADDR are processed before the PM creates the subflow for the local
endpoints.

Address the issue explicitly checking for duplicates at subflow
creation time.

To avoid a quadratic computational complexity, track the unavailable
remote address ids in a temporary bitmap and initialize such bitmap
with the remote ids of all the existing subflows matching the local
address currently processed.

The above allows additionally replacing the existing code checking
for duplicate entry in the current set with a simple bit test
operation.

Fixes: 2843ff6f36db ("mptcp: remote addresses fullmesh")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/435
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 045e9d812868a2d80b7a57b224ce8009444b7bbc)
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - conflicts in pm_netlink.c because b9d69db87fb7 ("mptcp: let the
   in-kernel PM use mixed IPv4 and IPv6 addresses") is not in v6.1, and
   it introduced an extra check (mptcp_pm_addr_families_match()) in the
   modified context we don't need here.
 - we need the new 'local' parameter from b9d69db87fb7 ("mptcp: let the
   in-kernel PM use mixed IPv4 and IPv6 addresses").
---
 net/mptcp/pm_netlink.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 582d0c641ed1..3328870b0c1f 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -407,23 +407,12 @@ void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
 	}
 }
 
-static bool lookup_address_in_vec(const struct mptcp_addr_info *addrs, unsigned int nr,
-				  const struct mptcp_addr_info *addr)
-{
-	int i;
-
-	for (i = 0; i < nr; i++) {
-		if (addrs[i].id == addr->id)
-			return true;
-	}
-
-	return false;
-}
-
 /* Fill all the remote addresses into the array addrs[],
  * and return the array size.
  */
-static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullmesh,
+static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk,
+					      struct mptcp_addr_info *local,
+					      bool fullmesh,
 					      struct mptcp_addr_info *addrs)
 {
 	bool deny_id0 = READ_ONCE(msk->pm.remote_deny_join_id0);
@@ -446,6 +435,16 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 		msk->pm.subflows++;
 		addrs[i++] = remote;
 	} else {
+		DECLARE_BITMAP(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+
+		/* Forbid creation of new subflows matching existing
+		 * ones, possibly already created by incoming ADD_ADDR
+		 */
+		bitmap_zero(unavail_id, MPTCP_PM_MAX_ADDR_ID + 1);
+		mptcp_for_each_subflow(msk, subflow)
+			if (READ_ONCE(subflow->local_id) == local->id)
+				__set_bit(subflow->remote_id, unavail_id);
+
 		mptcp_for_each_subflow(msk, subflow) {
 			ssk = mptcp_subflow_tcp_sock(subflow);
 			remote_address((struct sock_common *)ssk, &addrs[i]);
@@ -453,8 +452,11 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 			if (deny_id0 && !addrs[i].id)
 				continue;
 
-			if (!lookup_address_in_vec(addrs, i, &addrs[i]) &&
-			    msk->pm.subflows < subflows_max) {
+			if (msk->pm.subflows < subflows_max) {
+				/* forbid creating multiple address towards
+				 * this id
+				 */
+				__set_bit(addrs[i].id, unavail_id);
 				msk->pm.subflows++;
 				i++;
 			}
@@ -603,7 +605,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		fullmesh = !!(local->flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
 		msk->pm.local_addr_used++;
-		nr = fill_remote_addresses_vec(msk, fullmesh, addrs);
+		nr = fill_remote_addresses_vec(msk, &local->addr, fullmesh, addrs);
 		if (nr)
 			__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
 		spin_unlock_bh(&msk->pm.lock);
-- 
2.43.0


