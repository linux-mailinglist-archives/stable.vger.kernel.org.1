Return-Path: <stable+bounces-226986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KbOKUlZumnFUgIAu9opvQ
	(envelope-from <stable+bounces-226986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:50:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ABE2B73AE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 08:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C66153018F17
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF426290;
	Wed, 18 Mar 2026 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hM86jTDd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0888736C0BC
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773820232; cv=none; b=EPTr9KP42v6lj5kUSZ2JxHSLcRorB8vjXRpQjO3i4ZSwemxv7HsUMeS1GuP9c8EHjZJ53ss3IhKmGZHig+qVs661jmWE5fSV96llp2i5RmS6rwIrqapbBfH3DnhpaHUJUI0124HgwjcyviQFafzlJXOlq1qU/mQTzAtwKLhqj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773820232; c=relaxed/simple;
	bh=Y962atEasaLEeftpcXSYHrVRhMDHFN/2RtTH361J6jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPGCzgm4xOWSYxNLyle5mejwXc8wuJWQsGx6mYmvg2qAjNXRCidomBZBWFCAYOLnw9RVnkDT1iyj1dmwT6M+95/2jW1r6x18vU+SjHL7Qi34H+PzHBq+0bzfVJVhgD4IfLmw9BuJuTH1qmyzcO42p8cynk/SOq2wInzHx20gTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hM86jTDd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HK8cxh626728
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Oaoq4AT6kRjaOmLae
	Rq+PrUnwLXzZsTr2Gx9TkHdRDc=; b=hM86jTDdsXCH9d7jkUTQIEvIdn1jisN4b
	ps4u3b3hmSxz0pfdlwMMK4zG5nfoRqrgIf2hfWWCC6ctSP1pONHiaafd+GTWkVZP
	ueUJH/SWhQFzx6LBXS/CVNWuXdVbyF968p8qc70Jwlw7lozsAvMmiXwrgx4JEYR2
	BkAbyD0aBWG1GAP7rVIdl59At9HvJGSzYcwEbnTeVlMuOKoB9g3otfvo8cz9nZQt
	cS/Tbo1OJMFd9Yyyn+PIgy+yfWARULZH5h1JnIA6X7f42POe5PXtqwwRdnHiFiKQ
	65D7oYQtO9IeEHRQSQXZC4vGzJAyHP5VVNYz5rt3k8SNChmfSlhew==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs8sf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:50:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4mDTW013987
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:50:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy51x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 07:50:27 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62I7oNdQ58392900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Mar 2026 07:50:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A45AC2004D;
	Wed, 18 Mar 2026 07:50:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F36F2004B;
	Wed, 18 Mar 2026 07:50:23 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Mar 2026 07:50:23 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.15.y] s390/xor: Fix xor_xc_2() inline assembly constraints
Date: Wed, 18 Mar 2026 08:50:21 +0100
Message-ID: <20260318075021.3951848-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031700-tabasco-facility-e917@gregkh>
References: <2026031700-tabasco-facility-e917@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69ba5944 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=aKZOg4wb7pFh2cTURR0A:9
X-Proofpoint-ORIG-GUID: k93psGHIytkMzuQUzJh9nmf0qvLpURdW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2NCBTYWx0ZWRfX0eEhLPX208+N
 JSXmdksIp10Enj/BPtAizUOwzkoRlRCPFvXyUbky+8K31GFo41UVeFXVwE/IVvj8P/OWUd+wyeM
 Vn5DG7eEniydhmOP0XaHUPT6sHDx+hoPreH5BJIzypgWK+H5kJRlLCP+dwUc1VSy/no6HeoctY3
 zqHByDGkiWT0cDNI2HNkTLrXCenl/MgxX7xJzxx7Bs1rB6p2xyQydI4Il3b6q7V97oMI6CMnJ/d
 dX7p1Zzx5OS9e/Cv0KHco5VOhbKdoJLxRdbdcaZFeGaQ9UrpRQZySdQ/dkcNNd86kQs01LmUJvn
 bykMTCjILJsBqDM2InO0ACciuHKLfHsxlJKY8Q3i3Tp08g1OSOSOVLVl/qTCYrCRmxHW5dBSfWQ
 F5H91OxQP0vqPUfr/MmdMAVGZ+6S+nUDb9FzZLhFOIupOJcqDADF2rQCU5Qwu+eVyX7wb3UffpM
 tbVhTLUSd45xPki961g==
X-Proofpoint-GUID: k93psGHIytkMzuQUzJh9nmf0qvLpURdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180064
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226986-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 66ABE2B73AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The inline assembly constraints for xor_xc_2() are incorrect. "bytes",
"p1", and "p2" are input operands, while all three of them are modified
within the inline assembly. Given that the function consists only of this
inline assembly it seems unlikely that this may cause any problems, however
fix this in any case.

Fixes: 2cfc5f9ce7f5 ("s390/xor: optimized xor routing using the XC instruction")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/20260302133500.1560531-2-hca@linux.ibm.com
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
(cherry picked from commit f775276edc0c505dc0f782773796c189f31a1123)
---
 arch/s390/lib/xor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/lib/xor.c b/arch/s390/lib/xor.c
index a963c3d8ad0d..7afc06f1d5a8 100644
--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -28,8 +28,8 @@ static void xor_xc_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 		"	j	3f\n"
 		"2:	xc	0(1,%1),0(%2)\n"
 		"3:\n"
-		: : "d" (bytes), "a" (p1), "a" (p2)
-		: "0", "1", "cc", "memory");
+		: "+d" (bytes), "+a" (p1), "+a" (p2)
+		: : "0", "1", "cc", "memory");
 }
 
 static void xor_xc_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
-- 
2.51.0


