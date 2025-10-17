Return-Path: <stable+bounces-186296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED0DBE7CC5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 11:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980331894155
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D4F2D9ED7;
	Fri, 17 Oct 2025 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z2RETS1P"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401C82DA77E
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693159; cv=none; b=G3bLw/u1P4S8xzRWtm4TbDv0ZlRsRMkfKISEYEtjVgnHlv1l3Eyuoe3tqtuweviUJVvXn1tvb34x4PoIPUkjQeVILNGRYYGNY3oT/qrh2awSPXZlovoP3RGrTK6EhZLXYbqUdBEd+/8GHMCM/TLm5U6c9CwTyozFQywywtzKrV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693159; c=relaxed/simple;
	bh=q/bApSmAUbrVGWWqdx7rWRuGwMTLu3MEJUZvyEuOnfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmVfarFH0i/AOOBwZu1LG5pepWEcf7Vygu3wlLxjnQKlfwpse53zP36BTvF61kch4r0z7/lqioSKS+yCFre4RUJarlbcKZI9c6EjGoixrHtoI6hiaU+SvQsxjJBXCJcHOmGdUbcZqgZ45Q3gdzIfO3726FG2VQ4eqkN/rLCA0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z2RETS1P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uVmE001425
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Uk7Z33x2UAQpQro9OpJFTMNeBbKNeAFJ/d5uDkQWJ
	fQ=; b=Z2RETS1P8+8xFlMDPK05jxyfC0cotdO1P8xTA4fLLvJPcgTFDT/By7tYb
	56EUzpWXaKU9ARNbpB0S9zLNukpBTZ2Ew0233VQnTqEJTZEIVyxMXMTsJfoWFXbG
	9MeXX1JEkQHSgwekToawOVLj45S7V67dCPAO8Ki4DxwyUDPuy5hdXLqNClBvaOz2
	HlJkFpjcoA22jN1g1gf69oMAzkmXuTZt+zX4My4HMO4DiOJHCiF1Z5XGSo3cLZWI
	F8NgmGc4trbWYz370Auy2PlPhloZoqR2ZdXoLSEESbicPlE3dqAq+TZOx5c1C+5K
	JsiR7/rU8viXuWcK5krHhHr8e9icA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8ckur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:25:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9ISJh018894
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:25:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r2jn4fnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 09:25:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59H9PqmW25690582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:25:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F10BB2023D;
	Fri, 17 Oct 2025 09:25:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B69DE2023B;
	Fri, 17 Oct 2025 09:25:51 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.58.138])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Oct 2025 09:25:51 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 6.12.y 0/4] s390/bpf: Tail call counter fixes
Date: Fri, 17 Oct 2025 11:19:03 +0200
Message-ID: <20251017092550.88640-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z3e8pF-DZP18Z4syRzYBXj_dQ5FeCY7I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfXxSiDvby1Gy4/
 Eipu4eeP+fGNFEj45D43d/T7Q4ivz2qh79Z/ZShnBCX+7hm/Hy9FONTsbJteQ3h9WGbR7cg9r4X
 kt7s5iFCaVU3jkWPucnql2wrtRRSTH3MdvwUf/I9idHL6v/zcC1H+CpV28rEjyABGTfNJufhwpJ
 EUjblBseSm5TZ7pyQLGj5GAslY6tF7fHWzXOuY7FBEHuMoFQ9hw54nZQeOB+yhWgNMbDM04z1IQ
 hAMSN2YoS6lZFYCrppmOUHhVMbya6je4+TOdlxDOIKkICouvYYfoWJFf8NfZ5ft84bhjsgOyGIV
 Q10z5w+RQe7xxYfUdTm9sQPUesNEZHKWc8EMZbvH0thvu/LXBgznKkunytsoFwuboogg4mfkTBw
 XHKyqeyASVb/BL2Z0KO8TeeUXbKb2w==
X-Proofpoint-GUID: z3e8pF-DZP18Z4syRzYBXj_dQ5FeCY7I
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f20ba5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=7Y2CGLhXa0D80JtmyR8A:9 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084

Hi,

As discussed in [1], here are the backports of the s390 BPF tail
counter fixes. Commits 1-2 are NFC prerequisites, commits 3-4 are
fixes themselves.

[1] https://lore.kernel.org/stable/CA+G9fYsdErtgqKuyPfFhMS9haGKavBVCHQnipv2EeXM3OK0-UQ@mail.gmail.com/

Best regards,
Ilya

Ilya Leoshkevich (4):
  s390/bpf: Centralize frame offset calculations
  s390/bpf: Describe the frame using a struct instead of constants
  s390/bpf: Write back tail call counter for BPF_PSEUDO_CALL
  s390/bpf: Write back tail call counter for BPF_TRAMP_F_CALL_ORIG

 arch/s390/net/bpf_jit.h      |  55 --------------
 arch/s390/net/bpf_jit_comp.c | 139 ++++++++++++++++++++++-------------
 2 files changed, 86 insertions(+), 108 deletions(-)
 delete mode 100644 arch/s390/net/bpf_jit.h

-- 
2.51.0


