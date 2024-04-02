Return-Path: <stable+bounces-35622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A0895996
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 18:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2261F243F8
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 16:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D2D14AD38;
	Tue,  2 Apr 2024 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="UIbsKLyf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C68A14AD2B
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074877; cv=none; b=lKJOvpd8VqSnHWTa7l+fnXsvcYT5kH+oL8uIlnYMZ3tO92HG4rVmhcdxJvy3FXp3PTLS43OFEjxPhOukfsPkC+x5B3LxwUUkYStbDqBRlEDjTerXDA6XIPhzqhFHwa3QeAIF3HzeSxLSdrJrM9+y0etH7KCp44/qpFBtNA+EmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074877; c=relaxed/simple;
	bh=nJkbyzDzJu8AbBlxu9MvWWyNm4g05xRBGV7WbEoqo5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=arJ+MVOiXQFRD8ir3mQNjHuF5xnp3zujL/Pd3gpmieJdwSkoUcX8Qa28tuYxhVn4UriP7e+a1uBUMwGqsxzaTYOf+9SqrLB0paBK387OlaPWK8cyDosdgynA1HLqM/4STBk93OAOs/cvpZ166MY7fcx/yQK/Z8LQfgGzL3T0FPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=UIbsKLyf; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432FkCNP010735;
	Tue, 2 Apr 2024 15:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=hGhf+lmO4aytr+VvPpt9iQuxaJHC+acbTWmO/AeqEd4=;
 b=UIbsKLyfPX9k0B2u2jWuWq+1DPyfta3gGzBF7OdbfGQxsPzrslrE+hLXleXX6iYjDLpR
 uwajW1v7RfXLDgzKrxeaTwRzgaDUQBooyxeYobFEfXPLXTt2AurkUFrYPa+utbVvSjl3
 SkjMHNx9REtYoRBPWZxVR5LMTfiXnSRM+QzWSB0Tkqwn4qKxIIBGDNTEJRRrkiO3bqTQ
 dTDDRGvIsdJ41EkEcPD946aFap7JbHmPTzNgM3wrUjayF5fwW0DBjBlFiBI1Trhru/fZ
 qHRzBcW50biZ0++cKbbyZfMOF1Wud50dL0HzYEQNpQ1aiHN851zJOU+3daEiB30fa0OM zw== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3x8my003n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 15:58:30 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 10097805EB0;
	Tue,  2 Apr 2024 15:58:22 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 70D89801D88;
	Tue,  2 Apr 2024 15:58:22 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id D5C9130000A0D; Tue,  2 Apr 2024 10:58:21 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Russ Anderson <rja@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 5.4.y] Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."
Date: Tue,  2 Apr 2024 10:55:50 -0500
Message-Id: <20240402155549.2883270-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2024040122-implosive-although-530c@gregkh>
References: <2024040122-implosive-although-530c@gregkh>
X-Proofpoint-ORIG-GUID: lKu_iFprX4--KD3fYEabkNZNYD60rjRz
X-Proofpoint-GUID: lKu_iFprX4--KD3fYEabkNZNYD60rjRz
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
 definitions=2024-04-02_09,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2404020117

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


