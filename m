Return-Path: <stable+bounces-159177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344A3AF0726
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 02:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09730483173
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 00:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB119A;
	Wed,  2 Jul 2025 00:02:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656F2FB2
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414541; cv=none; b=OWdJdLu7JXYxC2mNTQakc9PAA8C27J+hqOYpeLgLBerNYFnTsrJXnpjAxeGjwd/VOdGjd4OqKMs19VBR0DPZ/roCEAY6tnt3fwjB7JZWlE/zpCvTlu5eozmBVL4ymADkVFD69Auotymtj07kBIOYQfVD0CoLgUeuO+2WDk1itZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414541; c=relaxed/simple;
	bh=kdSX08iCVA1J+J3zXVB7ofjNZ6cIC9SDcQ/VnRgXEu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpK8iNUzvqRDwtoCMjOjb7C84xwsspzZmpc5wRhCJ4jtGIjMnzULP6VElu3tUIuwyap9La7vl/1zhvyp0o5REmMNMS3mm2sDOQYeBKOw4/YybEN13VbELQnCCi9Jm9cDmquBP2oglVD5ZtAdiBLn3HcNQ/cQw/6i4Vny0kOAk38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-a6-686477017b1c
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/4] samples/damon: fix damon sample mtier for start failure
Date: Wed,  2 Jul 2025 09:02:03 +0900
Message-ID: <20250702000205.1921-4-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250702000205.1921-1-honggyu.kim@sk.com>
References: <20250702000205.1921-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsXC9ZZnoS5TeUqGwUUHiznr17BZPPn/m9Xi
	3pr/rBaHv75hsliw8RGjA6vHplWdbB6bPk1i9zgx4zeLx4vNMxk9Pm+SC2CN4rJJSc3JLEst
	0rdL4MrYsr+qYAVHxa9HrxgbGF+wdTFyckgImEjM2j4Jzt7V94ERxGYTUJO48nISUxcjB4eI
	gJXEtB2xXYxcHMwCcxglvr3bxQwSFxbwlzi3KQKknEVAVWLytu1sIGFeATOJ/uvBEBM1JR5v
	/8kOYnMKmEt8bF4NtkkIqGTe4XdgcV4BQYmTM5+wgNjMAvISzVtnM4OskhCYwybx//sCJohB
	khIHV9xgmcDIPwtJzywkPQsYmVYxCmXmleUmZuaY6GVU5mVW6CXn525iBIbksto/0TsYP10I
	PsQowMGoxMN74kpyhhBrYllxZe4hRgkOZiURXj5ZoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
	o2/lKUIC6YklqdmpqQWpRTBZJg5OqQbGfral+yZsvT03TZYnmunao+xLMec7vnB3KVy20M1U
	O2+Rzh4TEWmneWIpP98NUfdbLZFSFwx7j613u8rlF6pp+eQ3++eEk87Vq4239N32CIrUa3ph
	tVv3WTZDvH1umdXuujvbplQzsl8ulKpZe9zb8WbZG6metU+ZFr/fsDNh4nNj4zQd1n1KLMUZ
	iYZazEXFiQBjxiXLRQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMLMWRmVeSWpSXmKPExsXCNUNLT5exPCXDYNkmY4s569ewWTz5/5vV
	4vOz18wWh+eeZLW4t+Y/q8Xhr2+YLBZsfMTowO6xaVUnm8emT5PYPU7M+M3i8WLzTEaPb7c9
	PBa/+MDk8XmTXAB7FJdNSmpOZllqkb5dAlfGlv1VBSs4Kn49esXYwPiCrYuRk0NCwERiV98H
	RhCbTUBN4srLSUxdjBwcIgJWEtN2xHYxcnEwC8xhlPj2bhczSFxYwF/i3KYIkHIWAVWJydu2
	s4GEeQXMJPqvB0NM1JR4vP0nO4jNKWAu8bF5NdgmIaCSeYffgcV5BQQlTs58wgJiMwvISzRv
	nc08gZFnFpLULCSpBYxMqxhFMvPKchMzc0z1irMzKvMyK/SS83M3MQKDblntn4k7GL9cdj/E
	KMDBqMTDe+BscoYQa2JZcWXuIUYJDmYlEV4+WaAQb0piZVVqUX58UWlOavEhRmkOFiVxXq/w
	1AQhgfTEktTs1NSC1CKYLBMHp1QDo/7lg+xvnmy68u5RTJBqYU5SUJ3+Mf+pGx96uevean/t
	8ONnUmKfoCfztf38T1c/cPwT9O/0pzkL/1/479E06wlHssIO4wUSq9Q27OloC9quKPCuxSh3
	V/bUtXumXjZZJvB1l8Lueh3X08vbeD89bftZ97BQcuPZC92HzstuX/DY6qW246+luxcqsRRn
	JBpqMRcVJwIAe7oD9jYCAAA=
X-CFilter-Loop: Reflected

The damon_sample_mtier_start() can fail so we must reset the "enable"
parameter to "false" again for proper rollback.

In such cases, setting Y to "enable" then N triggers the similar crash
with mtier because damon sample start failed but the "enable" stays as Y.

Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org
---
 samples/damon/mtier.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 36d2cd933f5a..c94254b77fc9 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -164,8 +164,12 @@ static int damon_sample_mtier_enable_store(
 	if (enable == enabled)
 		return 0;
 
-	if (enable)
-		return damon_sample_mtier_start();
+	if (enable) {
+		err = damon_sample_mtier_start();
+		if (err)
+			enable = false;
+		return err;
+	}
 	damon_sample_mtier_stop();
 	return 0;
 }
-- 
2.34.1


