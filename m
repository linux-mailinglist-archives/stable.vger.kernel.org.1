Return-Path: <stable+bounces-186207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AA5BE59E2
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 23:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF58F5E3EFC
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 21:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFA52E0916;
	Thu, 16 Oct 2025 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VOy2bUPB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46902DE6F4
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651719; cv=none; b=Cxqua5JIkqZZQjnIJX33uFZOcxPA0se1zDwyhWhc7MDf6tuD5uzRanccoIYsT+fUdrapEWC+4UeFy1hHah2IAkj0niITlG2MzIwmqfanFiYoNDPUiQRcJTJ7dkhdaeDwCHHVAf6IRBhpS0Vj2eqFbhfyIYFCesUy/dBQk1bmJ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651719; c=relaxed/simple;
	bh=GZ8W6UZa1xmE5fXBGhaHGD7ek5snmXJq4tf28YryBvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LazzGMsNGu69eT0i3W/x39rVY8REXKDqU1PjcV2wGkPmDYI9lojhvTPIf6pF4V3vCkO555k0G99Igy/r6ryUKZ7AsK1udeDOjjFWR0jPb4KQlq3yhAjE9XTg4r+poAAO7BEmxjBFBM11Rgy/Ag9B5ju3D2FZaINQJwKw19+RzoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VOy2bUPB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKFTGI001277
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HIkKuKdQE3kMkPThWISxwrqiqYWTNXyX8Mgbokhyt
	vk=; b=VOy2bUPBcr4X3z+6mWQ6t2Ld4BSOewslAmKclu78EUEF6NTB46kHv3NzF
	lkEzDRWb3C6Wc6CrEJ5Jy6Xr0QPAwu3yG5fz3RDkzMyTNN0zr/s3OrCWwfaE3l6p
	KZChKUMRvIedujlzH7WH3hoo2omJ7RT0UAwYRYbkcLN7g5eGvzGcT15Zj7KiIYLo
	mC71/gR1e2NaqCIEy4+JLsXmLey2FL8eNNt2wfRWUpOU6guHNVl1J6A4Uq4KxDzO
	KqvfpYaYelYJxI0HRDO4+hUp+VWU9DE1B9xYPDXQGbwaR97IiaUtjw6T/ftkFSiT
	EWlm/ZwV1HcxVPfzZtwkjE1SK8+5g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp88a8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKOxL9018894
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jn039d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 21:55:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GLtBd436700598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 21:55:11 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 673EB20174;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B8120173;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 21:55:11 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 6.6.y 0/5] s390/bpf: Tail call counter fixes
Date: Thu, 16 Oct 2025 23:51:23 +0200
Message-ID: <20251016215450.53494-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PAfTfl_xD2lzA3ipxTdhBiAFyfcgyc90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfXyzwkEcsJ4q7c
 mApiyOct4Z6h9cbDSjdMyy1WI1NH0lRwzc98c59RVSdfbOso/LI/Ov8MV/SvMwCC70h7uIiUXcy
 aZsPxZEMJA4uJYUH078mx2RTkO1W3rzu26rBmlaiMist8RdztGXA9NnorDzDP1yNVXXT30DCxir
 yuYLtdW3tHwzyvBQuPO3L9KgOFAkholAQg5GaJfOHOMeiK8vgDvTfwCC7r2d42DvPmaHIRWwBEe
 OWZxL7M4b4QptcQ2rZIzjGSjjJCnH28Zaga1cTOlCFI3QRAAqsxzYQ3WjVI2c67SHprHKzNBf40
 tVpBPt/YeUHSXVGLtRgJTHyhDpszwVTapBpxJQrs8KdZutV34JdHm+dwSAm/3vJk4LvnlMXSUGs
 hISBBM46J/g2v6ZTQl6fIFyrWkptHQ==
X-Proofpoint-GUID: PAfTfl_xD2lzA3ipxTdhBiAFyfcgyc90
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f169c4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=KSIzangOkniVJOnj-W4A:9 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084

Hi,

As discussed in [1], here are the backports of the s390 BPF tail
counter fixes. Commits 1-3 are NFC prerequisites, commits 4-5 are
fixes themselves.

[1] https://lore.kernel.org/stable/CA+G9fYsdErtgqKuyPfFhMS9haGKavBVCHQnipv2EeXM3OK0-UQ@mail.gmail.com/

Best regards,
Ilya

Ilya Leoshkevich (5):
  s390/bpf: Change seen_reg to a mask
  s390/bpf: Centralize frame offset calculations
  s390/bpf: Describe the frame using a struct instead of constants
  s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
  s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG

 arch/s390/net/bpf_jit.h      |  55 ------------
 arch/s390/net/bpf_jit_comp.c | 161 +++++++++++++++++++++--------------
 2 files changed, 97 insertions(+), 119 deletions(-)
 delete mode 100644 arch/s390/net/bpf_jit.h

-- 
2.51.0


