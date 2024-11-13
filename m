Return-Path: <stable+bounces-92884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA909C67AE
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 04:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C7E1F24F04
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 03:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A62166F26;
	Wed, 13 Nov 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYWZ/0FM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBCF165EE8
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731467820; cv=none; b=fyhyYBizKOg+7TETZkhvaKRKVU218MxwYchJnlGbYnf3aqdO9VKAj9r/aXNGxpX8g8PTSOasCELZxJBSxr2Inh1R37fkkrMEqn8QHhx84MoX8F21b5JyrPxKS9+6EXyKcA8TUFBLZPxLQoTQFPoN8AOiulsgfvMizmlnA3s2cE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731467820; c=relaxed/simple;
	bh=IRbA/Qjs9jrGhAIVi+ZYZQhHDjLhIEPE2SzrJHX4Ju8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ZPqf9exWKL3A7jO5/AMtLT8/6wt27WC7gMpagRNxwFrIgJupy2So85MuzP4OvjX/3l0h7hdJ1h8xIwzX5MsP4q91nGiul0VxT+XZwRtHmkw7owFODDYW9S/XPHOm5LiLd/ZXQQHIWDzQ33ir3NIuvPRsyx/czl9h9i6DQYCkpqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYWZ/0FM; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so536703a12.0
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 19:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731467817; x=1732072617; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iEgZKKTvneh89a13mEBq6vv3iiCLjOOI/49JujqqZgI=;
        b=QYWZ/0FM4ZzXZJEXHIMAmmO/FLZmcrLcP+vY4SlQ3limbLp9n5iPPJI2hPtRS60zl3
         v22LCMdp3Fans+tvw2FbjL5ZISrVuEP7/2crva55V620soC74TcIVHD9mS6dDTwn2U/t
         RCHFtNRIXwpc+f7zHvSTMqhS8gvXgb8AXLKCrDWdXSpCnsfOctwNOyy6uEZnBw3bCAX/
         c34hXG8L/+z8QiZ8rh4lSsrAZPHjVMHNBy0kdziGLK4vQT4C9mDmi0V9mrQ1UIoXYZ/4
         kn8LdGloWYGqiFY+krL23s8sjevrhXNuf6bZ2lGI7dJC7W3KNo4Tr+5GBDwV0s3Yp/0z
         iuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731467817; x=1732072617;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEgZKKTvneh89a13mEBq6vv3iiCLjOOI/49JujqqZgI=;
        b=sP96Uu5y+5R80ARcbQDawzhyVYq47DYbZuaQ1JOKapWj8iJizo2x3HVxaq7kqUBrHB
         hVZQquRTDPKmhCxNrpnKW0VBDhr2qhO8r43emW4XEtvtiD+dX6w+mlCwQOBvlC4vmrIU
         MDr9LaDs08QBZowShcno0DUM2/wroVyWZqASnHpEFJQ7eHmhEVhY5o/ZbWKMTVE+Z3uE
         pcxJeGdpGIBFkGO8m85WSbLZGfU2MBpbyN/ozryHGX2t/P8eFDDslF1+iwzHLL7ItH9/
         j1N9Ftb9LTHizZ0kAZ6cAjPyeX95m5ojfjOjLPYYC2goFBxBX7lk8oM1ogNRtt359sYo
         ptYw==
X-Forwarded-Encrypted: i=1; AJvYcCXmmmrwU3c/KrAG9/DBcgBzqQAeYop1wh6s3rC3WykNXE54htB/epvdS8IJ5UQfGemHbNgP4ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbABvc3phNkFdiOlXP3EArVabBV/XOcPuffzdUkrmZAPtEjwKt
	ObDN5fer4dNiI3xlAt8eQCQ7NKHaUXjeq6+UP+MKiSClA1SwPn7K
X-Google-Smtp-Source: AGHT+IHLC0hnl8Hfqn+qfXRGiHO91GsYvql01efPD0cTYfYAZNxgzfHPSpovsnzh3qlX4vaXmtO+lw==
X-Received: by 2002:a05:6402:5cb:b0:5c5:c2a7:d535 with SMTP id 4fb4d7f45d1cf-5cf0a50d38cmr15970042a12.16.1731467816406;
        Tue, 12 Nov 2024 19:16:56 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b7e8d0sm6705345a12.33.2024.11.12.19.16.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2024 19:16:54 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] maple_tree: simplify split calculation
Date: Wed, 13 Nov 2024 03:16:14 +0000
Message-Id: <20241113031616.10530-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20241113031616.10530-1-richard.weiyang@gmail.com>
References: <20241113031616.10530-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The current calculation for splitting nodes tries to enforce a minimum
span on the leaf nodes.  This code is complex and never worked correctly
to begin with, due to the min value being passed as 0 for all leaves.

The calculation should just split the data as equally as possible
between the new nodes.  Note that b_end will be one more than the data,
so the left side is still favoured in the calculation.

The current code may also lead to a deficient node by not leaving enough
data for the right side of the split. This issue is also addressed with
the split calculation change.

[liam: rephrase the change log]

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
CC: Sidhartha Kumar <sidhartha.kumar@oracle.com>
CC: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: <stable@vger.kernel.org>

---
v3:
  * Liam helps rephrase the change log
  * add fix tag and cc stable
---
 lib/maple_tree.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d0ae808f3a14..4f2950a1c38d 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1863,11 +1863,11 @@ static inline int mab_no_null_split(struct maple_big_node *b_node,
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
@@ -1900,18 +1900,7 @@ static inline int mab_calc_split(struct ma_state *mas,
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
@@ -2390,7 +2379,7 @@ static inline unsigned char mas_mab_to_node(struct ma_state *mas,
 	if (b_node->b_end < slot_count) {
 		split = b_node->b_end;
 	} else {
-		split = mab_calc_split(mas, b_node, mid_split, min);
+		split = mab_calc_split(mas, b_node, mid_split);
 		*right = mas_new_ma_node(mas, b_node);
 	}
 
@@ -2877,7 +2866,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
 		mast->bn->b_end--;
 		mast->bn->type = mte_node_type(mast->orig_l->node);
 		split = mas_mab_to_node(mas, mast->bn, &left, &right, &middle,
-					&mid_split, mast->orig_l->min);
+					&mid_split);
 		mast_set_split_parents(mast, left, middle, right, split,
 				       mid_split);
 		mast_cp_to_nodes(mast, left, middle, right, split, mid_split);
@@ -3365,7 +3354,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
 		if (mas_push_data(mas, height, &mast, false))
 			break;
 
-		split = mab_calc_split(mas, b_node, &mid_split, prev_l_mas.min);
+		split = mab_calc_split(mas, b_node, &mid_split);
 		mast_split_data(&mast, mas, split);
 		/*
 		 * Usually correct, mab_mas_cp in the above call overwrites
-- 
2.34.1


