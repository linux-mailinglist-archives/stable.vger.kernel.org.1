Return-Path: <stable+bounces-35624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA178959D3
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 18:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3781C21F0E
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268DE15958B;
	Tue,  2 Apr 2024 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="LGZN3x0/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226B0133283
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075843; cv=none; b=Tv8E9XRG9g5KQ2y7oQ7c19hqxqjFcNof9hEuOc/PlXmikKSeKcpXKGbKwuKjwmzgovdpLeLbeAKOm3xe2Soe6HrWvcpmA2eYGW0jZJqvmNSjHVsvi9Cnt/y8apSP7hlNjS2/dXUG7S9ba4dUGsKU7mFChFF8N1nKeAr+088s/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075843; c=relaxed/simple;
	bh=nJkbyzDzJu8AbBlxu9MvWWyNm4g05xRBGV7WbEoqo5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuz/dGsd+E2tgn9/tL0pz0CfzKRbF/AmJ/SFfvCIGLtUvVdf9omia+pjZ2lR0b0R2uviyM2wPfWYpHhKd9WZc85lXhIeght6f2gyHawTJVCc1HiMuX5oQY+kznDeB/GGzdlQp8IWafQ38ChNWj0kYfUQ6P4ME86V/s56/sGXAME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=LGZN3x0/; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432EZsMs007647;
	Tue, 2 Apr 2024 16:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=hGhf+lmO4aytr+VvPpt9iQuxaJHC+acbTWmO/AeqEd4=;
 b=LGZN3x0/9H1XV+0GeEw2nZexJlbBi05ZM7iaum3AYqICLs6uoL4NJnNP7hLerEpZAQk4
 nCZH5vRYG2n7T6SrX8q0q6YTbXCA55kxZ103oggonlsQNBrbhMvqIx5V0UjFMpHiMwJU
 8I/91JGyw1mrU4w+uheVWIM5zh6bq+P9OisLyI+abNFwhBfi9vlu8WtTKgWQzIQfGBaf
 ZFz1IsWWWDcbP2L2xinVle+mrhLbsyXwcRlqjOiId/Nqg9kDued4FGRlIYrCgbvLfav0
 vXrX34SUJBf8yjMul42AbtsY027aS1v0SHFoYg7pleBXsRvc5IiBrvhH1pHoDwa8/SMY Jw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x8kx194qn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 16:37:15 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 6DFA38005CD;
	Tue,  2 Apr 2024 16:37:15 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 77A08801FCC;
	Tue,  2 Apr 2024 16:37:03 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id E806B300009E4; Tue,  2 Apr 2024 11:37:02 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Russ Anderson <rja@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 6.1.y] Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."
Date: Tue,  2 Apr 2024 11:36:26 -0500
Message-Id: <20240402163624.3422454-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2024040119-scanning-immunity-c63d@gregkh>
References: <2024040119-scanning-immunity-c63d@gregkh>
X-Proofpoint-ORIG-GUID: ZwnYCVuEQKKHBqSRekHub_yXjIvP0UH1
X-Proofpoint-GUID: ZwnYCVuEQKKHBqSRekHub_yXjIvP0UH1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_10,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020122

From: Ingo Molnar <mingo@kernel.org>

This reverts commit d794734c9bbfe22f86686dc2909c25f5ffe1a572.

While the original change tries to fix a bug, it also unintentionally broke
existing systems, see the regressions reported at:

  https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/

Since d794734c9bbf was also marked for -stable, let's back it out before
causing more damage.

Note that due to another upstream change the revert was not 100% automatic:

  0a845e0f6348 mm/treewide: replace pud_large() with pud_leaf()

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Cc: Russ Anderson <rja@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
(cherry picked from commit c567f2948f57bdc03ed03403ae0234085f376b7d)
Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---

Thought I'd try and be of help.  The pud_large() / pud_leaf() change
is what caused the difficulty in reversion.

 arch/x86/mm/ident_map.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index f50cc210a981..968d7005f4a7 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,31 +26,18 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
-		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		/* if this is already a gbpage, this portion is already mapped */
-		if (pud_large(*pud))
-			continue;
-
-		/* Is using a gbpage allowed? */
-		use_gbpage = info->direct_gbpages;
-
-		/* Don't use gbpage if it maps more than the requested region. */
-		/* at the begining: */
-		use_gbpage &= ((addr & ~PUD_MASK) == 0);
-		/* ... or at the end: */
-		use_gbpage &= ((next & ~PUD_MASK) == 0);
-
-		/* Never overwrite existing mappings */
-		use_gbpage &= !pud_present(*pud);
-
-		if (use_gbpage) {
+		if (info->direct_gbpages) {
 			pud_t pudval;
 
+			if (pud_present(*pud))
+				continue;
+
+			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
-- 
2.26.2


