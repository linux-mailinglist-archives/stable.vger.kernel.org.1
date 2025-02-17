Return-Path: <stable+bounces-116026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED542A346B4
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9FE4189905A
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3EE139566;
	Thu, 13 Feb 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YppXZGDf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287E126B0BC;
	Thu, 13 Feb 2025 15:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460067; cv=none; b=UgA7OsmFMP7wtq8iVcrlC7u+R+a6/qzIxfXPAsa/d9RwwR0fiz+PNf+uoYmxKPEPYS85YKElgM23FbfQBeWfjgiU7e8wmt1u6K84+4FpVmQKUEm3Xemmj/RpNQoEZhQMIZUk0AgB91hqtptIzeSAU3/R3gu3494my5GS6dBLxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460067; c=relaxed/simple;
	bh=dsixDzuzo3tVjYVy9QFhcb+nui0g2WoCMdI4md54i6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlSTk5pdWiiWBhDRhfY9/YtAba+1kR7bo0fuE4Pnzp+5sHwrtCEH+lNI2xoG69D9v7Q5QEqMcS5ES4AoXY5ZytsFhkW17+OlK1Ffdfftkxyw5ryfHqKwqRMcugXkq1Y9kVQ+OoM+32akc6V81tYHm/sGPdc1LNsUPQZKFbv60h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YppXZGDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885C1C4CED1;
	Thu, 13 Feb 2025 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739460067;
	bh=dsixDzuzo3tVjYVy9QFhcb+nui0g2WoCMdI4md54i6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YppXZGDfKJnaTQgzhQQWpGhGCkVKYwIKzwD14f3KpQiKEJikxKgQB9+Z5S1LzxLKI
	 QuGnI7SeuEuORSbg3D/iCK9MEt/3f3NpOFz+hxc+KfhIIhovDr+KhMFiBHlHnqDEzt
	 /P+s0G3u9IDXU6qFcLiZKIdENqZe38QXAhC5RXAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.13 417/443] maple_tree: simplify split calculation
Date: Thu, 13 Feb 2025 15:29:42 +0100
Message-ID: <20250213142456.703639214@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1863,11 +1863,11 @@ static inline int mab_no_null_split(stru
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
@@ -1900,18 +1900,7 @@ static inline int mab_calc_split(struct
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
@@ -2377,7 +2366,7 @@ static inline struct maple_enode
 static inline unsigned char mas_mab_to_node(struct ma_state *mas,
 	struct maple_big_node *b_node, struct maple_enode **left,
 	struct maple_enode **right, struct maple_enode **middle,
-	unsigned char *mid_split, unsigned long min)
+	unsigned char *mid_split)
 {
 	unsigned char split = 0;
 	unsigned char slot_count = mt_slots[b_node->type];
@@ -2390,7 +2379,7 @@ static inline unsigned char mas_mab_to_n
 	if (b_node->b_end < slot_count) {
 		split = b_node->b_end;
 	} else {
-		split = mab_calc_split(mas, b_node, mid_split, min);
+		split = mab_calc_split(mas, b_node, mid_split);
 		*right = mas_new_ma_node(mas, b_node);
 	}
 
@@ -2877,7 +2866,7 @@ static void mas_spanning_rebalance(struc
 		mast->bn->b_end--;
 		mast->bn->type = mte_node_type(mast->orig_l->node);
 		split = mas_mab_to_node(mas, mast->bn, &left, &right, &middle,
-					&mid_split, mast->orig_l->min);
+					&mid_split);
 		mast_set_split_parents(mast, left, middle, right, split,
 				       mid_split);
 		mast_cp_to_nodes(mast, left, middle, right, split, mid_split);
@@ -3365,7 +3354,7 @@ static void mas_split(struct ma_state *m
 		if (mas_push_data(mas, height, &mast, false))
 			break;
 
-		split = mab_calc_split(mas, b_node, &mid_split, prev_l_mas.min);
+		split = mab_calc_split(mas, b_node, &mid_split);
 		mast_split_data(&mast, mas, split);
 		/*
 		 * Usually correct, mab_mas_cp in the above call overwrites



