Return-Path: <stable+bounces-158877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0891BAED71A
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EE13B3AED
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 08:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCF323B60F;
	Mon, 30 Jun 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CMciJsXs"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408B24293C
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751271833; cv=none; b=J2sZfUOKoLxD374vDLhZjP7255alTO6bqhNLgzfaosCnlXjKtg5woLmIo/bYERQvek5klpSsLhFG4VNgfG6RqvW5Hl96WzO+y4keW+GuwvEp3NVZQW2rqM/VxFtSJZhLdsDErj3mY8Y0RRrnLrVOo7wGTXg6+Qh8pzv4xvp5E3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751271833; c=relaxed/simple;
	bh=sCqoCWWDTuYRhAI7wZWMPgLTexgZgcMwxZRgn2whWAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eL6xZ5szQWjIwdLa3SffRCMHHP+/4J+BRhQGsp3oPHA1mZQzAjOydFj41mIV5lFPo/zNN5DjsHEMGqlrn7Whzm3hWJwepvWoy4zcuIOeYkySbo1gfuCEUUWYZW0PTYeTvY/QFdmvekFm+wCrPjYKWtuXnFO1WqBnFrfa9Q96Hhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CMciJsXs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55TLGZRD024160;
	Mon, 30 Jun 2025 08:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c/XL5Bwd3xR52kcEo
	RDPo7PmJlCaRk4M7m+ScB/13jA=; b=CMciJsXs2Q2GDh6G6BFlcTetJ16UcCIQC
	GQ1onWf4vllKBc2J7JYqeSekH6eRLfuVthrasoG4UY3JaJfmGvnyjxKoqrOAFLl3
	fr8N3C7knE21/MuRKOPwyBbzYgbOZJyplQGsvXt0FyCjIHWcnEmecB3O+2ArC5xe
	cHqkmmK1ngBy5SezzKol0mwP/tHBsw2WAraURji7LQoPw856qZOzhBq1SkztV6Mq
	0QQkJF40vkQ3ozYtdPSUSNlcPh0MTXm0Yz70Lf1ueDUEvlFSXgRtmsv8x1EhuNxT
	PdVYqLtIHUO8R/4HZI/9UsrB/sOmcU6oRz4BJS6HZ33KSFX7gH05g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j6u1g68m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 08:23:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55U4UaZ6032151;
	Mon, 30 Jun 2025 08:23:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47ju40d4ub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Jun 2025 08:23:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55U8Niap49349018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 08:23:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38E6B2021E;
	Mon, 30 Jun 2025 08:23:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 201A22021B;
	Mon, 30 Jun 2025 08:23:44 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Jun 2025 08:23:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.15.y] s390/ptrace: Fix pointer dereferencing in regs_get_kernel_stack_nth()
Date: Mon, 30 Jun 2025 10:23:40 +0200
Message-ID: <20250630082340.2741373-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025062928-revival-saint-3ba2@gregkh>
References: <2025062928-revival-saint-3ba2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UTV0xI-y4jTRdddxzlc-DbFeasVHfpDd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDA2OCBTYWx0ZWRfX9R91WsJcdNIL OdvvOVsZt/KpjUOH4j4te+CkMndB4Jp2V3KEeQj0kWggZHkryEbLroxp8eV2vtfAXLBtYdrrvY/ pnP5JeouGCyTZmIDE7sfxsc3ZIt865gDg41M+rfe+aSd9QvghwGcNtYoEd07EOWOgIQi+ThGLUi
 jyOn4cczPYbod051m+oVg9RZfsPfHzIeKnGvkOvhufyxNvoaf0Hw9r4W4DcKkca+LXvjGueXDbi a58ft4nSTRs4gteZIBdS6EeAWykplIWvRX5EWk/rPx5w7SU+eQAoiHCWVDy9FyHWH8LJ25MjOez vLrnD5U5LHAwKXeMVqKVaGXDLrAViDZFACq50hAmDwJF03P8TG5ILNm9OntvSWYOZLTw6wrR+/M
 vPEg7FKe+TmTie5BShqJFVX9ADIUXDWLvp1VOoBCxoc+F0EPlOCWeaJGPzqDegD8dJPp/ZQE
X-Proofpoint-GUID: UTV0xI-y4jTRdddxzlc-DbFeasVHfpDd
X-Authority-Analysis: v=2.4 cv=GrRC+l1C c=1 sm=1 tr=0 ts=68624995 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aMph1pUC56sQlk_oYRkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=789 mlxscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506300068

The recent change which added READ_ONCE_NOCHECK() to read the nth entry
from the kernel stack incorrectly dropped dereferencing of the stack
pointer in order to read the requested entry.

In result the address of the entry is returned instead of its content.

Dereference the pointer again to fix this.

Reported-by: Will Deacon <will@kernel.org>
Closes: https://lore.kernel.org/r/20250612163331.GA13384@willie-the-truck
Fixes: d93a855c31b7 ("s390/ptrace: Avoid KASAN false positives in regs_get_kernel_stack_nth()")
Cc: stable@vger.kernel.org
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
(cherry picked from commit 7f8073cfb04a97842fe891ca50dad60afd1e3121)
---
 arch/s390/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 34b8d9e745df..1b8bc1720d60 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -1574,5 +1574,5 @@ unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
 	addr = kernel_stack_pointer(regs) + n * sizeof(long);
 	if (!regs_within_kernel_stack(regs, addr))
 		return 0;
-	return READ_ONCE_NOCHECK(addr);
+	return READ_ONCE_NOCHECK(*(unsigned long *)addr);
 }
-- 
2.48.1


