Return-Path: <stable+bounces-78724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A301C98D4A4
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CCD283355
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65EE1D0412;
	Wed,  2 Oct 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kMsFZApb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937A225771;
	Wed,  2 Oct 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875341; cv=none; b=JtyqcQ+T+fzVNrCIyZtHy5rd5S4cnztL17Hsa1vX2SE6eIFD7HISjP3URo246m6FX5jQAZyflX8H79d8tarhmhG1S/FKN8W0VhYz4trMnNR7Vg07wgS5vuP+ZRWU20W26zcwO0CFPKOwlWgdvn1oxLWCwM7HP2ZmBUSLwb4wKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875341; c=relaxed/simple;
	bh=8tfYqWRN5Zo7Rt8Vh5ZmApjHDaDYWkRURSvp6wTJ1Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDrlnM7NUZSTwc64t6X6HW514MfqN/Wbb3QfgiEffzsKGWHC5RX3y4A16VrNX0HdyLCWvimho8L4XZZBeEYH90npohi/hLQBJIhAELyz7tWX3V2WYuSKNo2bwf9bQkPrkaaJ2Af+bVv6inzo8/UB+/35uf/BSgdVX2FeJ8+SLnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kMsFZApb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162C1C4CEC5;
	Wed,  2 Oct 2024 13:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875341;
	bh=8tfYqWRN5Zo7Rt8Vh5ZmApjHDaDYWkRURSvp6wTJ1Vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kMsFZApbyUBOfel4FOj6VZiU5wbOETCT2TOc33MT1kI9Q8+mzOGu+Vnz+Tt3GufTD
	 HncvbQ+x9/LRD1fnIYxpvNSB/WEaszBcKvnseJr+ek2JUCX5GSqa7lY9/PZKt95S/C
	 LueXa0915IPJvDZs96jOwOwPkUItA5/8mUmqkRb8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 069/695] perf/arm-cmn: Fix CCLA register offset
Date: Wed,  2 Oct 2024 14:51:07 +0200
Message-ID: <20241002125825.237365971@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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
index b59ae8513dcee..4e2338afe6694 100644
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
@@ -2393,10 +2394,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
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
@@ -2414,7 +2418,7 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
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




