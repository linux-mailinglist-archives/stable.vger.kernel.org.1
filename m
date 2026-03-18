Return-Path: <stable+bounces-226974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBhYGjtVumm8UQIAu9opvQ
	(envelope-from <stable+bounces-226974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:33:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BED502B6F8D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FB4730B2204
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D65363C59;
	Wed, 18 Mar 2026 07:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m3tn93Ma"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D3369984
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819093; cv=none; b=ltj0q6giw1YRcpfBnAhMY98vqSVlvWiuxvtCDD5NehkhQ25cGW4MgsKIy0pnM0s50F8eGVTzHcFV0SOm9MOAqYw8tKpcyZO+LwVUp5SVhC1W//E5V0x+coevXVLI61h6Bth6vmb9tpv0xlx6tahO2YdBi4hxTaZCRDcqc/yr7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819093; c=relaxed/simple;
	bh=UoUySImdnklvh4Ac0ZppSWUYm9LQJ2NbzQeUWvkGG0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haUFmpgdBBnQ1kNgEZXYGzCDH5btDeVrt4quoLghRcoBUZ58ya5vZTsOU+6pCx3TOrGBlbHAwXvR9jIulvhvRRX9hIutNa7eyqurycc2WyuK9JiaZjvX1JQ5ZFga9yXv10ZE9JkXYi86cszFG5GdvXCQ/PyBzO6zGnmQKLqUMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m3tn93Ma; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HJqWiK1484495
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CsoZLbNyb8omY7Umc
	pZDudMVJyvPKjjjZ1rYzSKcSpY=; b=m3tn93Ma3t05B+gDBy3+57hj3hwYOfb4i
	HCss1nfn37Br1b55H5PH9wDmQTsSB0tAWw8cSZf+i2GNPWjhSTWS/gYNuKyVDiW0
	qthxU/miTRqWfByFTuBaM3owWLpbKPWLOEaeaR/mqQIga/ZXAxEbEnWiUUNXMlGT
	lgJlxANVMDvzD7bxzcz8U6UConv+CwGiP//L2pXfytZL7ZX+5WnOXZRCMz1grHNU
	h3jCAk7Ygo+xDGYICkFjap0uB7chwc35P4dgdEFWOXbvV34PaIo6aVSWUve93X2N
	uc4PIqqFG/E9awPM3JkhE6RLjrkSZRS6nkRmdJc5g5+e7qp3+Nv/A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfk0d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:31:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4cm74013997
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:31:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy5017-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:31:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I7VQcW29753660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 07:31:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F6C02004D;
	Wed, 18 Mar 2026 07:31:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAB5620043;
	Wed, 18 Mar 2026 07:31:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 07:31:25 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.12.y] s390/stackleak: Fix __stackleak_poison() inline assembly constraint
Date: Wed, 18 Mar 2026 08:31:17 +0100
Message-ID: <20260318073118.3116589-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031738-blob-labored-5201@gregkh>
References: <2026031738-blob-labored-5201@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d543w2vgau35ow9a_257z3Mnm9v-OqMI
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69ba54d3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dh6oAghXbX3gNeQxLKgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2MCBTYWx0ZWRfX173ZQwP6cyJX
 biJqfZtr7lviG4Wu/22NJZid6gIZS1/2ZSjef5sdeoYZ+QbDzKvJablLScptjtFebI35iZp5Xkm
 AwMGF4FyxCdiu74mFsanyoY8zhqvw6dkvG4MuX3tSNbQkgvy8205gwA2PlU39GushYtFSdo73Aj
 amBdA/5r1a6iqrA/mbzqjLO9GO6nGHa7TcK4PkEyt6KyONgdM1jXlI/CeXG9s1gvmsxry/ggkvb
 BVkvvuP809+S1bDhm3fp5/G4Od5xykfmArJHq7oIDBXAhg2FRojRJa2s8emyL14ooPLKcDAP8rV
 hCj5TLxK//iKCemK/k2lzrfYUgQPEkZ3rBRu0rr3STWJSPcf8AOMQeM9b5YiuxHEnNPGTJq6iMk
 7ACSj/rf6FZxtEIG8+8ww94MENpT3Ngu+fRKiGMpLPsCk61txOwLeP4OGozM09WZBQ8Q3eCTzyx
 ggiRZAPLyqLNrp4x1ww==
X-Proofpoint-GUID: d543w2vgau35ow9a_257z3Mnm9v-OqMI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180060
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226974-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: BED502B6F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The __stackleak_poison() inline assembly comes with a "count" operand where
the "d" constraint is used. "count" is used with the exrl instruction and
"d" means that the compiler may allocate any register from 0 to 15.

If the compiler would allocate register 0 then the exrl instruction would
not or the value of "count" into the executed instruction - resulting in a
stackframe which is only partially poisoned.

Use the correct "a" constraint, which excludes register 0 from register
allocation.

Fixes: 2a405f6bb3a5 ("s390/stackleak: provide fast __stackleak_poison() implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/20260302133500.1560531-4-hca@linux.ibm.com
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
(cherry picked from commit 674c5ff0f440a051ebf299d29a4c013133d81a65)
---
 arch/s390/include/asm/processor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 21ae93cbd8e4..ef622c3f88e5 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -168,7 +168,7 @@ static __always_inline void __stackleak_poison(unsigned long erase_low,
 		"	j	4f\n"
 		"3:	mvc	8(1,%[addr]),0(%[addr])\n"
 		"4:\n"
-		: [addr] "+&a" (erase_low), [count] "+&d" (count), [tmp] "=&a" (tmp)
+		: [addr] "+&a" (erase_low), [count] "+&a" (count), [tmp] "=&a" (tmp)
 		: [poison] "d" (poison)
 		: "memory", "cc"
 		);
-- 
2.51.0


