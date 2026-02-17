Return-Path: <stable+bounces-216873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLs3NX+xlGlbGgIAu9opvQ
	(envelope-from <stable+bounces-216873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:20:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6490C14F019
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 19:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB4C0303988F
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE4D36E49A;
	Tue, 17 Feb 2026 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cLip4ikh"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355C3542DC
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352405; cv=none; b=idfJsqwztABHidRpuCvjnPnQN9Xp2UHUE4hLwD2zdpU3umxOJ0kVi27p1AnrOgdbErP53BZQHErbBjeJXG93XsrZNxUOqrLQlqx7MgCNdzPG/pMbSGvI3URjQhzSqsxsYuE+lUDjiHVhhmoehwZxD9gdakgE87LrgGcAR+e44uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352405; c=relaxed/simple;
	bh=4wglaby+R8snrfD9UzVPP38foDdpaiJrB3YvtnEdI6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUaDrlcvUk64k+JjkiSFUcYkAidgXVPiXWFWV7GMejfidpfa0W6Lkwwb71lF9z4OwMN+ygsp8kPNLud1KSjIMNPbRqtZJkbfYn9vxGMh4l8QTh54opD7/qJfWZhquXeiQXnJPCkp0xtKvM/onolyn1up+/xClDpdhFfls2eIGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cLip4ikh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HEQMwA2414481
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9h1TT/s2NziYpsxx+
	DjjI2cbosM+B1a21s+AOqeVmp4=; b=cLip4ikhGrs0bkV0ZSdpJDoMcZriArZex
	SWbLhoj6fBwrT3e5mAPHx1fMxY577m3RXLmvsqyoeWJYxPzuB5B6edaZ11tEcsFR
	vnFwMk/6h8Km8Y0r1N/sW499+lJ/APLmRQZeBqn0+xAdugDcbm4rP7a1iSd2+L6r
	bKVPcfCcy6BggQw6IqMVnheYgCWjp/hM7y0mHht3+ylcUZivzeMeCPZI+OBfCXwv
	3y+fW5WJHiqS9X0Wn7viMK0r5SptmTIN5eYufSDlI+X85f9ScZ3XqZRg2vOiUlZy
	Yta2OL4vtumtHSJwJacgzYpTk3jJ13AQOdhCZ6BrGIpp+rEzqPe1g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6unjg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFvVEa030208
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb4542ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:02 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HIK1Mr62390594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 18:20:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B29795805A;
	Tue, 17 Feb 2026 18:20:01 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6541958056;
	Tue, 17 Feb 2026 18:20:01 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.249])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 18:20:01 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: alifm@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH v9 4/9] PCI: Add additional checks for flr reset
Date: Tue, 17 Feb 2026 10:19:54 -0800
Message-ID: <20260217181959.1536-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217181959.1536-1-alifm@linux.ibm.com>
References: <20260217181959.1536-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6994b153 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_COy7Z8VS3VoYlkUqhYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfX01cywKBZQ4Ai
 AFftlVJEHlu3sCCG9EX/U0WaNqPyrInCk5Ygj1ChGb22Z09iRu3ZxOe+7qmWaqhj4TEiEx4d5l1
 9pBdT3BFJ3NQjSUOCCWc4Rkda/HC/HL3zrX32jSWn1zSewi3kgkUVqQdQBtLBAYRuU3iGLKg5+L
 uzmXF6wz0FRPTpcnPzVfuweVlocER4mezefqzUZ0Zt2L5PzUa/oCLl+x1w4oE3LxH4i0LmYsFRX
 qpoWeXb5mB/Xmw+MpCfBjjuSEDWUkg5wuAvt9VNniqU0ycn7VimcxrGYD3VXtGauZSo/pusHvM2
 gzDEvtErxDuWWo2jvKhvV+R8nlOeBeQzNwfItaiPdKEVxdsE0E35hgjYFXSraEyU6e+h2xStpMM
 HyNIKbLyhiVn8uiOJW8Du8T6mIrQ0jSJIZYnrlCj0lEtjSOpmOmyI/nE+EJbmhaUHaKq7Xz633E
 6NWOs938P8yh6sXOk/g==
X-Proofpoint-ORIG-GUID: SbEofWGaS3XFYuwzpd4qodz4VVd_gCt6
X-Proofpoint-GUID: SbEofWGaS3XFYuwzpd4qodz4VVd_gCt6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216873-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 6490C14F019
X-Rspamd-Action: no action

If a device is in an error state, then any reads of device registers can
return error value. Add addtional checks to validate if a device is in an
error state before doing an flr reset.

Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2242b97e7d46..d867db7188d0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4373,12 +4373,19 @@ EXPORT_SYMBOL_GPL(pcie_flr);
  */
 int pcie_reset_flr(struct pci_dev *dev, bool probe)
 {
+	u32 reg;
+
 	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
 		return -ENOTTY;
 
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &reg)) {
+		pci_warn(dev, "Device unable to do an FLR\n");
+		return -ENOTTY;
+	}
+
 	if (probe)
 		return 0;
 
-- 
2.43.0


