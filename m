Return-Path: <stable+bounces-118135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E490A3B9B4
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621BD7A7BE9
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270D11DFE10;
	Wed, 19 Feb 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0eq+s4bL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60851D88DB;
	Wed, 19 Feb 2025 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957336; cv=none; b=MMDSEI+6HpCH29EHYCFemRd1bx94d87pZbSREDuNs+FY4jh2TEFnWEbNWoX/BxhdFjg3xehygVywA33ymD7eD47Y9pwzxHIsNBLDLXRS4bPbMKdY5ZOmrLYKq5Zao0R5mZtTYKBZrjEfPO30XtHqLz4Tqm/o/vyRWOZ3cqVpaRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957336; c=relaxed/simple;
	bh=uzmmus7CYBAIE+f6BB0oY8hUxc3UM/DZZ7ZkLjhzsNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpiUe8qjfTGFBL1G9u5xefRnuZmC3t/2LnwsjX5LISjs9GcSPRqvIcXL50OixvpSPhnWTZlaiORXqMtskkRGy9EDBJskjE3rLlDRR+miqX9QUmgr+Xe9Ugd2Qa5hQdDrUbgPC4sIw2M0vzBm1MxuTte7zZtK7OTYAnWlKRp3aP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0eq+s4bL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D394C4CED1;
	Wed, 19 Feb 2025 09:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957336;
	bh=uzmmus7CYBAIE+f6BB0oY8hUxc3UM/DZZ7ZkLjhzsNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0eq+s4bLnr0G/PcJErSKqdJN3B4naWV/4ziaZTiGZq2taembfVoNoYLRT4/DGgqRY
	 Xn/f7XIwh8SG1Mq5lP8NyCRJg0bfOvTNlY++q/ySQAkSuZhVdWqZf8KtFcEVon7Fq+
	 /M7AWcpIZ7Galta1SHNVXxWsjBSQg7OsSf7NdeRo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 458/578] maple_tree: simplify split calculation
Date: Wed, 19 Feb 2025 09:27:42 +0100
Message-ID: <20250219082711.023421388@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Yang <richard.weiyang@gmail.com>

commit 4f6a6bed0bfef4b966f076f33eb4f5547226056a upstream.

Patch series "simplify split calculation", v3.


This patch (of 3):

The current calculation for splitting nodes tries to enforce a minimum
span on the leaf nodes.  This code is complex and never worked correctly
to begin with, due to the min value being passed as 0 for all leaves.

The calculation should just split the data as equally as possible
between the new nodes.  Note that b_end will be one more than the data,
so the left side is still favoured in the calculation.

The current code may also lead to a deficient node by not leaving enough
data for the right side of the split. This issue is also addressed with
the split calculation change.

[Liam.Howlett@Oracle.com: rephrase the change log]
Link: https://lkml.kernel.org/r/20241113031616.10530-1-richard.weiyang@gmail.com
Link: https://lkml.kernel.org/r/20241113031616.10530-2-richard.weiyang@gmail.com
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/maple_tree.c |   23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1890,11 +1890,11 @@ static inline int mab_no_null_split(stru
  * Return: The first split location.  The middle split is set in @mid_split.
  */
 static inline int mab_calc_split(struct ma_state *mas,
-	 struct maple_big_node *bn, unsigned char *mid_split, unsigned long min)
+	 struct maple_big_node *bn, unsigned char *mid_split)
 {
 	unsigned char b_end = bn->b_end;
 	int split = b_end / 2; /* Assume equal split. */
-	unsigned char slot_min, slot_count = mt_slots[bn->type];
+	unsigned char slot_count = mt_slots[bn->type];
 
 	/*
 	 * To support gap tracking, all NULL entries are kept together and a node cannot
@@ -1927,18 +1927,7 @@ static inline int mab_calc_split(struct
 		split = b_end / 3;
 		*mid_split = split * 2;
 	} else {
-		slot_min = mt_min_slots[bn->type];
-
 		*mid_split = 0;
-		/*
-		 * Avoid having a range less than the slot count unless it
-		 * causes one node to be deficient.
-		 * NOTE: mt_min_slots is 1 based, b_end and split are zero.
-		 */
-		while ((split < slot_count - 1) &&
-		       ((bn->pivot[split] - min) < slot_count - 1) &&
-		       (b_end - split > slot_min))
-			split++;
 	}
 
 	/* Avoid ending a node on a NULL entry */
@@ -2664,7 +2653,7 @@ static inline struct maple_enode
 static inline unsigned char mas_mab_to_node(struct ma_state *mas,
 	struct maple_big_node *b_node, struct maple_enode **left,
 	struct maple_enode **right, struct maple_enode **middle,
-	unsigned char *mid_split, unsigned long min)
+	unsigned char *mid_split)
 {
 	unsigned char split = 0;
 	unsigned char slot_count = mt_slots[b_node->type];
@@ -2677,7 +2666,7 @@ static inline unsigned char mas_mab_to_n
 	if (b_node->b_end < slot_count) {
 		split = b_node->b_end;
 	} else {
-		split = mab_calc_split(mas, b_node, mid_split, min);
+		split = mab_calc_split(mas, b_node, mid_split);
 		*right = mas_new_ma_node(mas, b_node);
 	}
 
@@ -3076,7 +3065,7 @@ static int mas_spanning_rebalance(struct
 		mast->bn->b_end--;
 		mast->bn->type = mte_node_type(mast->orig_l->node);
 		split = mas_mab_to_node(mas, mast->bn, &left, &right, &middle,
-					&mid_split, mast->orig_l->min);
+					&mid_split);
 		mast_set_split_parents(mast, left, middle, right, split,
 				       mid_split);
 		mast_cp_to_nodes(mast, left, middle, right, split, mid_split);
@@ -3591,7 +3580,7 @@ static int mas_split(struct ma_state *ma
 		if (mas_push_data(mas, height, &mast, false))
 			break;
 
-		split = mab_calc_split(mas, b_node, &mid_split, prev_l_mas.min);
+		split = mab_calc_split(mas, b_node, &mid_split);
 		mast_split_data(&mast, mas, split);
 		/*
 		 * Usually correct, mab_mas_cp in the above call overwrites



