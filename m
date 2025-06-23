Return-Path: <stable+bounces-155345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22E3AE3DCE
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5096016FAA0
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA507231C8D;
	Mon, 23 Jun 2025 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HCPZAx4V"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB94F1B808
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750677669; cv=none; b=WW4qVvbQWm3G+WwsUZBZVIb7P37rnvx4lAFO4zqPw5lel/cqIEpL19DiTEha1IByRLUdyTZEC5dCfC0/sX2uKoHIh749QYjiPMDz8L2OXYA4s9RZk4+rTmuJKxWq9QF9bZC7XPBuOZDLCCI8OJCPjtuL2DK8c/skH+AgHa9bS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750677669; c=relaxed/simple;
	bh=OHbtlh0WqaM5Iv8xkeWgEHRhNOm8JqO/Lcgzy/0RRj4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NI167FzYKlVYWDmyEYwIVUs+yVkautgdKIbMiNJtVIAgHZB4u7lgtdDmEKuOLEZXeaPaFvhNiMm/rdDXDl5QRb7Yll6gyvmNegp44Z0ACGKgEbZ0j0t0InE8iQ6xa124cPmdTZzf8OqxUPdsF/hRpTT4Ya+cpLrp0iVWZhp2OR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HCPZAx4V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N657Hm018896
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gloMeWpkaV8ZIUcDm
	9QedOcj3Lp4XzFCuxejNbfS8DI=; b=HCPZAx4VFv21kvftvtHVIdkhTQd6Clxhe
	0h4QDkXoRTBReTxaR7Gdf8NIMycvYL/TCsyLctcc3PKmmMozQi81aBYvXEmzFNGA
	95ayzPSaIBi3UNdytxzVJgHQGN8+5irpe/YJfMOEQYDzJbQCvMB5rBz46vtLxEpH
	mcJXTAQ6SIqKVomhRSlkYXizL4Yu8GzITiS5P38iJMmLG1kdGHmP+QrUN6g2ygqf
	4v49BnxFtmg/+Dk1U9rsy2oQvthJGfK48VlK8SEDNuX5WJ9c85bsgVIVunaNAzgm
	aPYjgM8e90Xhkw+LTzasJEMvIgDZxxST4AiXjrQSAkfU6LXoYccLw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme1187k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:21:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9HjS7003989
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:21:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kdu8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:21:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NBL5Ek46399944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:21:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 242105805C
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:21:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9892858058
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:21:04 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:21:04 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.4.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Mon, 23 Jun 2025 13:21:03 +0200
Message-ID: <20250623112103.3663238-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025062023-wobbling-aloof-8d23@gregkh>
References: <2025062023-wobbling-aloof-8d23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685938a2 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=TStIGci8u6cbjIpgzpwA:9
X-Proofpoint-GUID: wb3m8fnD_OuX-CyHFXR0WxnHe8qrpSNp
X-Proofpoint-ORIG-GUID: wb3m8fnD_OuX-CyHFXR0WxnHe8qrpSNp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA2NyBTYWx0ZWRfX9o4UJJFN/nJ7 IRncoFemRCWWIg99uSsi8GtzptqrupbiiGlBeOpYekTxPZkwn/g5fR56e3kVd52saAk4GQMTPhq inY/8KeiZ/gRlyIFx1vMzKWJ2kFAjZEVzdBe/CqPX1Ewpx/MOX28kA8McefoNowz4IrWYt4lC53
 ETjA4W2wcvmthlb3SoszbX0w+OCAhUBVBY7QlQwR/I/bKersXrvl/LNuKvKtKroUpM3eNpbdTXQ ziSzAbOEido3BedSTlm/o/7QCJ/Zn4va08cD9bXBTCijXaK2l21hKBuq/QKh5wQ4/tgDLmYpZIJ 1RcO03EYS6+jvILepTLKItHHl+n9mOKSsbnmQ01YqneqoBKrZEHWjAca3UmAFjfwsw58bT+koYc
 d1Djt96E5Rg0AL8FXkF5mtMVki34raP5C5gNl0lAfLb5BAzmXV8YO2AkWDbRb79N85OpQG4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=417 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230067

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
index 675e6cb50584..e28c84a53f92 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -227,7 +227,7 @@ static inline int __pcilg_mio_inuser(
 		:
 		[cc] "+d" (cc), [val] "=d" (val), [len] "+d" (len),
 		[dst] "+a" (dst), [cnt] "+d" (cnt), [tmp] "=d" (tmp),
-		[shift] "+d" (shift)
+		[shift] "+a" (shift)
 		:
 		[ioaddr] "a" (addr)
 		: "cc", "memory");
-- 
2.48.1


