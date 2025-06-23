Return-Path: <stable+bounces-155339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55470AE3C2D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813DF3B764B
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EFB23C4E2;
	Mon, 23 Jun 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cQrdioR2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E7423ABAD
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750674235; cv=none; b=iImEGItHdRi8l2ADNL439rrhoucOV9ZFAuLEL1W9XCQvX5A+ywHdyD2odpw5SdT8TYihGw7yoC1LAovQoRvvpZTvLwLT0u5EstfOPYYUUjWsSpmTn+ckFlyVKN61i583wY88ifYQqqIKdUs26vtO6/2gnvI6AiUGT2+bN6hSq6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750674235; c=relaxed/simple;
	bh=zbReDyIJQeSxK4ouOhCquHfDkJ1910+DN64H6O8UuHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAzBj6x5W8Eo3tB0XrhfgBKxxDcmDVvR0PsQLkAAZfpUXtrwUa+3xZLnOXjSQKjJXjOtYlHLtTbV+ITa70s244zyQZpoGTrw0QwheJwjJYb5jBxm150YqouuGXLYP8BtQe60e+KT3AFGmJqmfyvDwf48dpjKIqWRgmdCTljzEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cQrdioR2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N1wQNC013720
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XF5qHVR3HkPmt9zi/
	StIY0e065Pij4Da+JBjKhZOztg=; b=cQrdioR2c5Y1sNgs6nfUwP0Hzou/RoDw8
	PVPJ4fQVxOC2DYRi5iAiO+L+gkmq+sY0+2kjAfcTd3XAHhwHx7Lzseef4I1LVSH4
	FcZudUt9YkANRzDTqjEAs9TE91JBy1k+Ozp9lrd9tujgFFTsYLp7TeMau7AtgyRC
	SvelzMjSchIn4bY8jInZR4fvdLtfE3g95SPcMNsbXhCaCYWw0fGbMIivUgzXUy5P
	tqgUgLd7mZNVfnVj+G5kL9I804DpPlj1cULPzJ1usCq2FV3nfg8SEub9elzX4N4T
	CKUNG2Voc7uul4IRRAmOrYpa0XDyY1ejITgEgTOSBx2fqJAj9u7HA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2rq4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:23:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9a3aP014698
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:23:51 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s25f2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:23:51 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NANjOC27394602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:23:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C63B658043
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:23:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AD555805F
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:23:50 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:23:50 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Mon, 23 Jun 2025 12:23:49 +0200
Message-ID: <20250623102349.2826464-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025062020-kindness-glancing-e58b@gregkh>
References: <2025062020-kindness-glancing-e58b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=68592b38 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=TStIGci8u6cbjIpgzpwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA2MSBTYWx0ZWRfX6fpYA/OfMKkG hMIO3BaG1VDB6W+jxk5Hkyh63WxDlRPP6zeB4RISQjzhioFAWErsu3/XNpf29H23RIHQT40twQK bJS0+dQgJV7nw3CZokKLI+uFqn9/bVNbnTgPiO4HAcS+GGIzuCRgPH49UYRQzzhXVXY169hyXzt
 6lF+uiVMeFM/7w12zadhVfsuRtnyCr3k6pKN5cQLP9SO1AMFWK5OvqXZba4LN5WtCW/MghJRygb m+8nsTK2WfIyMl0ky1HOJNTjYygwhzjG3Ihb01+UipRkBM6DG6+WqLCLHelz43ammLqVkUC2ORh 8eVGVfKY4ulYM1otLJnN7FZaO6q7dF0ReGL5/OQg1ykmmJyiT1niXp/U4Bl6dZiLhSIYhGBdfQs
 73YJqECHuC45geQWGEfKFWFtvkE3FeCFreH1I6TBskAJ1nHDXB+uCP0EBiVhwTwTGy0DhCjl
X-Proofpoint-GUID: 63LvlF04akbD4F7XzM7wDm68T7zvKcM0
X-Proofpoint-ORIG-GUID: 63LvlF04akbD4F7XzM7wDm68T7zvKcM0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=436 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230061

From: Heiko Carstens <hca@linux.ibm.com>

Use "a" constraint for the shift operand of the __pcilg_mio_inuser() inline
assembly. The used "d" constraint allows the compiler to use any general
purpose register for the shift operand, including register zero.

If register zero is used this my result in incorrect code generation:

 8f6:   a7 0a ff f8             ahi     %r0,-8
 8fa:   eb 32 00 00 00 0c       srlg    %r3,%r2,0  <----

If register zero is selected to contain the shift value, the srlg
instruction ignores the contents of the register and always shifts zero
bits. Therefore use the "a" constraint which does not permit to select
register zero.

Fixes: f058599e22d5 ("s390/pci: Fix s390_mmio_read/write with MIO")
Cc: stable@vger.kernel.org
Reported-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
(cherry picked from commit c4abe6234246c75cdc43326415d9cff88b7cf06c)
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index a90499c087f0..2ee7b5a5016c 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -223,7 +223,7 @@ static inline int __pcilg_mio_inuser(
 		[ioaddr_len] "+&d" (ioaddr_len.pair),
 		[cc] "+d" (cc), [val] "=d" (val),
 		[dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		[shift] "+d" (shift)
+		[shift] "+a" (shift)
 		:: "cc", "memory");
 
 	/* did we write everything to the user space buffer? */
-- 
2.48.1


