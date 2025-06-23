Return-Path: <stable+bounces-155343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D62AE3DA7
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F05F189326F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B9E23C8DB;
	Mon, 23 Jun 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ErOkrGCI"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2623C4F1
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676840; cv=none; b=cB2rp31HqXi6Zg1ExCnn116/MGWk/Dnq9ao8CuE2mJI5Gz2UqO09zeRKFNfUBagPpuZIujLKSMzf/2yRrH0hgriA4z5nx1amQht+nBC0jAEw+6KY0oDSAL0CNJd1v95/YZd2h9P8NbupGiTY+K9WwnwGBsh/KeBoYIFUrso0i/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676840; c=relaxed/simple;
	bh=D+OomGbcZF5j+AHcn+7tC6UmRKiK+aSr9UKH6kFSFqc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqZ0stKzWEgwBVYRszGg/BV5gwoXvDJiM9lj6vdfmEg1j7rh2c3/7RFozf7NTx3w1Dhhug4Vj+r16L60VtgcoXlFsmVmTcmLZaQ+w3bfeKz7YtMT+PSeHR40izIh3iR+QJ5/xijMx8x1i54mluAL/nASZtFak+i+2nm687Z73n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ErOkrGCI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8EtXq010702
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ANdTPjUbjo3Zu7v8
	qUW/riJ2+CYiTlhJL64LYnQaAg=; b=ErOkrGCIj88vMLj773GZbunPKs/zIJWYR
	eJhybvHt6yfMY+XQULfNz5aXHiy6V7nT3e0gmnii9q1RRr/veAWZjhbCdt6dchum
	ubEs08CNl0+eh3eFyTLHi8TNBpaIhWLRvAyfuN/e7GeJY0SZGCeiYJdD6jF4OzKZ
	yjyy1em8GFfoU5y3WtThqxGa4z23NeobFmA9kNLK5xgSuW+vEK5Xw5RMblr/S5jf
	xO0S4BK0L2xbD2vixvs9lrZQfwIWQMxHWzE4dfx57IKjN8tgSXBrOPRMGw0jNKzW
	Mw6DhKjGdefz7stu4Uhpi9/F2rcdHohUWeka12Hn8wygbpr80rw6A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2rxx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:07:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9a3p0014698
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:07:17 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s25nyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:07:17 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NB7Gqg4194986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:07:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F9125805B
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:07:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D490F58055
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:07:15 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 11:07:15 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Mon, 23 Jun 2025 13:07:15 +0200
Message-ID: <20250623110715.3446009-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025062022-gracious-throttle-46c8@gregkh>
References: <2025062022-gracious-throttle-46c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=68593565 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=TStIGci8u6cbjIpgzpwA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA2NCBTYWx0ZWRfX5gobKVOxublH MtgSGyTvwxu4L25ZyNy7Bu3iM4mAetr+7ikElMs5xiUeOSEZsU4iYEoT1E5ldSZAB8FCX8P4HyQ fRkIE7FKcLE1o2pDlPIPA7TaV1PMpthsOjNOfmdo0EGE9dKQfhpRpuH/r2gCbQKpYB7IjNYtPka
 EgoaRWUbXW8jIm7Mq5sGURsIRCUHI8ay9HDZnr5NbtiIQ32YnHC6UAgHXrA8eLB25353ULwclHT N9vjvkVJaakXdvujEVmvf1tnDJDBgl7jgI00Y/DqJ1MYAO9yfMYcCcPQAidhAS+t1cHcdFeizy7 jpjoV4SEYcot8OGkbfLDoOopEFwYLxG17rU93lGS6TEiHQXsLJ7nOSSYal1PkNta/rXlor9CYd+
 ZpCTG80vYdjhCNgbVafXwy/ZgOv+f401qxDOibI39r7t3J4Qid86VygCJH3JbkoH2B8XjSfj
X-Proofpoint-GUID: IqxSk1cRla0fzOi-htZ1ssbBbe7CsM4X
X-Proofpoint-ORIG-GUID: IqxSk1cRla0fzOi-htZ1ssbBbe7CsM4X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=422 classifier=spam authscore=0 authtc=n/a authcc=
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
index 6e7c4762bd23..d3be09092a3b 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -229,7 +229,7 @@ static inline int __pcilg_mio_inuser(
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


