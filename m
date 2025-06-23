Return-Path: <stable+bounces-155337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B52AE3BC7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 12:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0901170E0D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511222D4F1;
	Mon, 23 Jun 2025 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hvo2IciA"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4500217730
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750673361; cv=none; b=EZwsS37pUUODme0dMnsU0r8gCHM6nU6+JyI8KND9hVIlp3HsBj+NjbGhnEIsgbt/ILGcZJwFnodex1NNeGG2JGtfwtU3VCmOnhAfUJfeHcjXt3UwXkhqRWCKx+CVtHVfRrLtn/IztERy5V/3MjKy88JaT0MeIZNWTJHyUvU5Gj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750673361; c=relaxed/simple;
	bh=nYUktp4BqYKEtSwIBUKjOVACQh1DEtJtRIFfiOyeG9A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4GNUjcawBALI4Wos9xweDTPsdB/Ag52clW5P3BF/X0ckCnaEhuvX2zsHAOIotsx5F7Ul/Tca0+0Zro0wZR2vEyIWzg9tbl1OfCy9RzcuNh2Pepcgzzrwlc162t4d8deoPSZC6mgmvVjflPrKGPn+xRGmqgVHZs1cviv7GqVT7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hvo2IciA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8PfPi027991
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8MIyqxfO4hrSnhTM4
	NMzM8luCnZH4dhl9/ik0lBcq1M=; b=Hvo2IciAumvHa59LXTsu0qAyC8lvCRbx3
	ElJOj+MYUF/suoE/mxlrM8NAIJFbyHMDesRe1nJoKbUTDOB+idxRtPUavhQ8r+8r
	53MPL4v4XLZjuNtyqmn3DizK13f8yJg3gIixYCPQuvrbxA4+59MWc0wisoFny/Wq
	QDFSFWPFIfjnj7By3TKzx/HeqkoLx5RpPvknMZ0ArAqdmB2O5PHc5ChJWrfs1/4c
	dWBUGd1wXTOaZNKDQe+AAEeukryUlThxyJc5E1pBNyXy47/If/NQ/vtb6+nXi3WG
	G4QBCmLxOE5B3bNHoZLiTROdhouvCnLPaRfAjro7Lmt7A+qQS1SHg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j0sx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:09:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8O3sV031277
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:09:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7eynu84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:09:16 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NA9FwK26542778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:09:15 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77D885805C
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:09:15 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBE935805A
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:09:14 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:09:14 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Mon, 23 Jun 2025 12:09:14 +0200
Message-ID: <20250623100914.2680078-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025062020-aware-estranged-e8a8@gregkh>
References: <2025062020-aware-estranged-e8a8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1NyBTYWx0ZWRfX64PbH+lcGOOV QpX8La35XWZaouJdJXVjLTXBj7i0l6PqkAArln7npDMoa2C/WFyZiWN3KEvJl6RNZyXiif8jxK4 WU9i/7BPYHCKspNtfysLfAdM2+V6hULSc69xioH6vj+mu+iCLTAFr7OILY9w7B61y3uuMOFfStJ
 aAb3rwQyExKdN4b+os8FBXBjVkX8PzFjOhvQkxyFv9EmXfCT2zjTWsducctm245pOe99qKlSYTM bxI7xpgUDhUj//HLCQlln/yx+SbADua1J/7s4SQKUkp5bOaCnNI2y0A2/5doPiyeeJN8uFaJB43 c3trbXGtXjX09ATR5em+642yI3RJ5F6XAe4f3lVRLtJIbq16ZSJcUVIsDETdynhZwccqWYu1XjH
 RVJI9fKjhyzthHD+AF7/zpAOQxqPWZ0gpbhkktBhEVz8czTVKAiJdG9Au+zCKltqIXJ88wYX
X-Proofpoint-GUID: lILC2ywHbU8BYw1s3P8wD2jldqzakK5a
X-Proofpoint-ORIG-GUID: lILC2ywHbU8BYw1s3P8wD2jldqzakK5a
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685927cd cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=TStIGci8u6cbjIpgzpwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=475 clxscore=1011
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230057

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
index 4779c3cb6cfa..0fa34c501296 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -228,7 +228,7 @@ static inline int __pcilg_mio_inuser(
 		[ioaddr_len] "+&d" (ioaddr_len.pair),
 		[cc] "+d" (cc), [val] "=d" (val),
 		[dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		[shift] "+d" (shift)
+		[shift] "+a" (shift)
 		:: "cc", "memory");
 
 	/* did we write everything to the user space buffer? */
-- 
2.48.1


