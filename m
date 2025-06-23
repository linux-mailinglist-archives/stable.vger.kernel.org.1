Return-Path: <stable+bounces-155344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF32AE3DA9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2A73A38F1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A855238150;
	Mon, 23 Jun 2025 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DT3iUgW5"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646791E492D
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676944; cv=none; b=PL4RI8fU362oipfJD3gpELtcr1dqPFA/9GbpgdUG+eVgn73erckZnzWLLpNEpTRUmZvWs+ffJrOokN2ozjS/kUPF+sPDxSZQotayAVP82fiuDgfqRDA3Wy1MElLXUJ6L/rPCaW2jiT8HHzRSpjlMcRhRmuSiGGXEolzBgRbUp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676944; c=relaxed/simple;
	bh=2q0ihQ+UTLi1LpBuk9/qJO7CGr3ACPK7eeEluhSxo8o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PmFuesCiViyNCGl8AzeKEtwsE7bueUqfcr338ukURotgD7PPEnT0sHH97xFDYvPzWcS1iwYuC/qFPzsymkIt6D8u52qyrQP4UUM2VV21D4dJ8XlHagBNpaGNNvNtOH38dtDGSqOSSWWnfFOvd/fFwX5ntb8evO1J8mZrb4Bqr54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DT3iUgW5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9KFPZ010991
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AYWGNbMaUwcUZ5q/e
	JAePryt84uGN1y02AIiMgG8fvA=; b=DT3iUgW5Snwh9UJCxkDznbfUaxZeXkhOi
	/KcXj1DRodzCXhQhK9Q2yNelT2iXAlbp4OZGTWNOxuwRvIp77jdQVCKaZ7wJR+w/
	0tNG2zFw2q+uupQIGIcXVfuZ0O+FJmC4wsMSUlTOd7wibV/PS7ccEmExUnEiUjsf
	f+QnIFHJlBumLhRH4CuXErbhTfpvAPwBZHX/Fk58LAul2bAKFl6iApArT95r11hL
	AZQiOHISGuh/yf3aq7kZmaEATrEHE2OSvow9JWF7UFRfjLKxuaRkwIVaPA5HTtW0
	HptXDqjLfpY8o78Wrqbjby01u651JkKOx+FFehHECk/gJRJJuo+WQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmfe16sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:09:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9l8wZ014710
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:09:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s25p9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:09:01 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NB907615729206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:09:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF7195805F
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:09:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E8625805E
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:09:00 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:09:00 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Mon, 23 Jun 2025 13:08:59 +0200
Message-ID: <20250623110859.3456221-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025062021-coastline-bacteria-9de3@gregkh>
References: <2025062021-coastline-bacteria-9de3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hKYcbiZf6WISF_2TN22LlXr1NTo3WyII
X-Proofpoint-GUID: hKYcbiZf6WISF_2TN22LlXr1NTo3WyII
X-Authority-Analysis: v=2.4 cv=BpqdwZX5 c=1 sm=1 tr=0 ts=685935ce cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=TStIGci8u6cbjIpgzpwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA2NCBTYWx0ZWRfX6IkYTziPkG30 nizDAYvlaw/kUW286SJHoOFcgYDRTYzrFoZ0lXdZTqt3soIcOT04HVesixNGzk4nagLBdeJA6Rs ro5lyStWkTV1s9M7XKBpxO6Vh/xAfNtqRVd/nMDeLtScX1mk9LLEtluLJ7vzhmxkscvv/Yo9GH3
 5Onau3VxqF8bSTwW6xTguvGLg8ezHTrV3maxAhB8aSCwoX/cbGoCOFEmKTGWRu7K8vLaxJEeCww F1dD/dm9SyeB4qhghAf8dB9oPuZoW9EvsPdjR42feCXmpFCnBG9Ywz4C9a/7VH3/I7L6xxPWR8/ 7psW/UMJStqQWZa92ea521NGOEE6Oxqj929oXDCNajN60iH5UUkjdOom/7sctakG7BKXqQOSHX6
 R5fQ/vQhZXy/HtJhpb/HFppdBL87KJJ3LW0kBjwkQSYyjRDSRZ1WJu/5ftlhaglE/JemYsjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=436
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230064

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
index 7e4cb95a431c..ad500c22e812 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -222,7 +222,7 @@ static inline int __pcilg_mio_inuser(
 		[ioaddr_len] "+&d" (ioaddr_len.pair),
 		[cc] "+d" (cc), [val] "=d" (val),
 		[dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		[shift] "+d" (shift)
+		[shift] "+a" (shift)
 		:: "cc", "memory");
 
 	/* did we write everything to the user space buffer? */
-- 
2.48.1


