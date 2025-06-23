Return-Path: <stable+bounces-155341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2B1AE3D7D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 12:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4AE168FA6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 10:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F3223E355;
	Mon, 23 Jun 2025 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g58Pkois"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53CA23D29C
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676134; cv=none; b=GhLnCI8nDC3QatizL4tomWt19bU/+tEkSGwM5+2qSGDLFqnKXY3dBfojOt9JxV5pcAjCTILMXoZ73ffL7hc3y8gDY10i/qC907X278kEa4l/lo47RilTkuwRe36xnSn5y+/cIs8l4sb4tkrygmt8o/QzggpT7achFniotwyr1vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676134; c=relaxed/simple;
	bh=zbReDyIJQeSxK4ouOhCquHfDkJ1910+DN64H6O8UuHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEV2gFN8dcKD1MlX/SdYedmWE4qNViViM1Ani0o3mYzy2JyGint0fCZN/9fFSDG/NUl3u+RTSbFm+fS44qmoAevIxZ+xpvKztJ9Zrfarkx/qC9MjrRKLN09k1ZdV/igowBbswsCR0oa5XHtD3mmKyAZGJS7pZhE5TeTyyy/JkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g58Pkois; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55MMSupC015122
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XF5qHVR3HkPmt9zi/
	StIY0e065Pij4Da+JBjKhZOztg=; b=g58PkoisrxZvEwhIF5Vulm/3m8azfb1oI
	lNC91fh5D34S4MG+Zujq9AoMSRiIyOAq3LY9OeFW8QguCKgguBxbylYslI06n+5h
	c3cbU/snF87T2X+1Q64D0EBT0B7uXPI6yjUcLQWj4Rm+Bj0UeRRKnvZTKOtdrRW9
	fwAyxPZAFufgcOlPwcJiM+ziBiFoaVcXqmtSS5sCJBwbTXsjP1MQp+KXsDXCNO8s
	0Jo1J5uvRw6D2DOZHQ/rzHUjyt+jlyut/Wk4b8TQJVWzERcUtaOI44S++ufwGbcR
	cMRslbYJ/ji1oxzTWddYmlbEPHUL7qe9gvZ9IZQdVyHGwpBtAMeKA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmfe145w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:55:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55N9R5j7004643
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:55:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e99kdq5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:55:30 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NAtPoD67043646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:55:25 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28AF95805D
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:55:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99E325805C
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:55:29 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:55:29 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Mon, 23 Jun 2025 12:55:28 +0200
Message-ID: <20250623105528.3173164-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025062021-owl-bauble-35cd@gregkh>
References: <2025062021-owl-bauble-35cd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5PAg5LB6G5qRGBqSmQgBAHG4QX4hnjXY
X-Proofpoint-GUID: 5PAg5LB6G5qRGBqSmQgBAHG4QX4hnjXY
X-Authority-Analysis: v=2.4 cv=BpqdwZX5 c=1 sm=1 tr=0 ts=685932a3 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=TStIGci8u6cbjIpgzpwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA2NCBTYWx0ZWRfX7bc3V3Dwwskb 02AKf6lOUH9vnhRXwRXGJtm39EPXx58grJJcfEI4OlCiB1qjhJuem+Am9Ns3wFcFZ8tB1RD+HPi 51fpFsXwf8eGuDrpUFEXfXEKocMvQt+vHAnHPmk2nc8UD0pkC1+0roe6imHG17YkmaIzNdDEiGT
 VWEu/UqSMgK9sBDFJsSM+R/8MqZrtwUQ7uuJacjjwSuszCLqsj6oC2qNfy1ciBrUoUgx4DTSwBk YTCSE3Qe0liMN688j2deaEXI/VYMiLA6tveqY/QyLoNniqVqjLHkd/t8FB6PJsDwJIzVKM/d6re p/0rskoxbG6vb0hkfAv2AtOcPezpy5XBIVMgPrbUbGL0UT0hfVCCGeU+oYI/4meQI7ZA2WY7Pf9
 lqciExhSrkL/39KxQkO2gXvXtg8kZtWIuSIa6yXWgFwp/RrrsqVP1xIgCDlMp9ZOcKOOP3Un
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=435
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


