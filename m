Return-Path: <stable+bounces-79413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CDE98D820
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF161C21B68
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2661D0787;
	Wed,  2 Oct 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ToBV4xO4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDB1D0488;
	Wed,  2 Oct 2024 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877376; cv=none; b=TkejEW74BsygHKFydHsesxTx/b1NxTeKDaH4EwK5/5ucL4Wb94twWUcsX3PHU3TCLJrk2f55R9Zx4jVY99Zd7CjsgyCJEAISjGR0W2/NhFQcF5Yq3mavaeMpav8ZzMzkfAWRYKAyAkYSDl9zlNFby59wC5/7UPcIvodEIxx6B4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877376; c=relaxed/simple;
	bh=dQazX52KD1gWkf1fPIvwKuOgk7dE/EdUynB8uBv83v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8L0ovhYf/W2a1IOiUjXFMtn05AHbaTNl3OnTzhNSS3akMu8qlKq57xzms056bYphSpZQPpwhfS1+3vFW/NzvQLzdczV1hY/cHWu3cy5GbzLb6HLWj8uubRnlqiDItP8FGcNMFqSTnjprvyWSQD+tz/BefF46ZpTtKMekH6B3qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ToBV4xO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E1BC4CEC2;
	Wed,  2 Oct 2024 13:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877376;
	bh=dQazX52KD1gWkf1fPIvwKuOgk7dE/EdUynB8uBv83v4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ToBV4xO4GauMMV8LE3zSZ7j+VlxzgaJSETzM0rQqbkywIy10UBxX9QQ4+dCMtrKvB
	 eOZlR2NWY2Cf3oGeOetXdgG3HDSItwaFElCvr40I6SrlzttwEz7QxER/yNN1KTTQBz
	 cGb6fIwCuXSSpqAmzTgXGhOl3p6h1aRWUqQOalHI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 059/634] perf/arm-cmn: Fix CCLA register offset
Date: Wed,  2 Oct 2024 14:52:39 +0200
Message-ID: <20241002125813.436995390@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 88b63a82c84ed9bbcbdefb10cb6f75dd1dd04887 ]

Apparently pmu_event_sel is offset by 8 for all CCLA nodes, not just
the CCLA_RNI combination type.

Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/6e7bb06fef6046f83e7647aad0e5be544139763f.1725296395.git.robin.murphy@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-cmn.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 6cd4fd9667aa6..f33fd110081c3 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -70,7 +70,8 @@
 /* Technically this is 4 bits wide on DNs, but we only use 2 there anyway */
 #define CMN__PMU_OCCUP1_ID		GENMASK_ULL(34, 32)
 
-/* HN-Ps are weird... */
+/* Some types are designed to coexist with another device in the same node */
+#define CMN_CCLA_PMU_EVENT_SEL		0x008
 #define CMN_HNP_PMU_EVENT_SEL		0x008
 
 /* DTMs live in the PMU space of XP registers */
@@ -2323,10 +2324,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			case CMN_TYPE_CXHA:
 			case CMN_TYPE_CCRA:
 			case CMN_TYPE_CCHA:
-			case CMN_TYPE_CCLA:
 			case CMN_TYPE_HNS:
 				dn++;
 				break;
+			case CMN_TYPE_CCLA:
+				dn->pmu_base += CMN_CCLA_PMU_EVENT_SEL;
+				dn++;
+				break;
 			/* Nothing to see here */
 			case CMN_TYPE_MPAM_S:
 			case CMN_TYPE_MPAM_NS:
@@ -2344,7 +2348,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 			case CMN_TYPE_HNP:
 			case CMN_TYPE_CCLA_RNI:
 				dn[1] = dn[0];
-				dn[0].pmu_base += CMN_HNP_PMU_EVENT_SEL;
+				dn[0].pmu_base += CMN_CCLA_PMU_EVENT_SEL;
 				dn[1].type = arm_cmn_subtype(dn->type);
 				dn += 2;
 				break;
-- 
2.43.0




