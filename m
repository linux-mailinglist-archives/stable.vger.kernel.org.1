Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74216FC917
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 16:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjEIOes (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 10:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjEIOeq (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 10:34:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D2235A9
        for <stable@vger.kernel.org>; Tue,  9 May 2023 07:34:44 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349ETLGR006774;
        Tue, 9 May 2023 14:34:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=cgirU6UXZvfNoZe6lukQ9/GXfZK35vHCiuqEPdDwHEY=;
 b=WOb/PmhopnTcbcZVpJ641R/DtY7sk+xG7okcsn+5osxnNPDbe82HUshcD2aJb4n8HiQq
 omMZSlzxnTx97nlLrQbCh5XkQlyh9glpQwhrLMXrzsXM3nKk8KHM0hojMbqNCpcgZaet
 ZaGz0Hx/JO812QEXzJ4HzM8KtRzvgHpDPr1kJaRAfUmEoa3qRcFAMdKSHONLV1gsM1/W
 +MqIpQz+6+a3L7UIkW/JEwoxtjFBUBMR0F5YdAJGOfjjto8jXO2y//c/fnkU/p3kXYsf
 fBc5JxD1Za+i1Jrakobxb9PrlaVAfHa6+44w7Q41aQywB5M9QheAjl4bx1/WlRmE9HuN zQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfmb3829h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 14:34:30 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3493lZVR008952;
        Tue, 9 May 2023 14:31:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qf896rg8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 14:31:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 349EVGfI18940374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 May 2023 14:31:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4CEB20043;
        Tue,  9 May 2023 14:31:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B6C620040;
        Tue,  9 May 2023 14:31:16 +0000 (GMT)
Received: from localhost (unknown [9.179.7.201])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  9 May 2023 14:31:16 +0000 (GMT)
Date:   Tue, 9 May 2023 16:31:14 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH stable 6.3 1/2] s390/mm: rename POPULATE_ONE2ONE to
 POPULATE_DIRECT
Message-ID: <patch-1.thread-961a23.git-0b29fdfb1223.your-ad-here.call-01683642007-ext-1116@work.hours>
References: <cover.thread-961a23.your-ad-here.call-01683642007-ext-1116@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-961a23.your-ad-here.call-01683642007-ext-1116@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lg7lfnP5-W1zAciVv5TzDC0sWPjblviC
X-Proofpoint-GUID: lg7lfnP5-W1zAciVv5TzDC0sWPjblviC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxlogscore=979 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305090119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 07fdd6627f7f9c72ed68d531653b56df81da9996 ]

Architectures generally use the "direct map" wording for mapping the whole
physical memory. Use that wording as well in arch/s390/boot/vmem.c, instead
of "one to one" in order to avoid confusion.

This also matches what is already done in arch/s390/mm/vmem.c.

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/boot/vmem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index 4d1d0d8e99cb..db8d7cfbc8a4 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -29,7 +29,7 @@ unsigned long __bootdata(pgalloc_low);
 
 enum populate_mode {
 	POPULATE_NONE,
-	POPULATE_ONE2ONE,
+	POPULATE_DIRECT,
 	POPULATE_ABS_LOWCORE,
 };
 
@@ -102,7 +102,7 @@ static unsigned long _pa(unsigned long addr, enum populate_mode mode)
 	switch (mode) {
 	case POPULATE_NONE:
 		return -1;
-	case POPULATE_ONE2ONE:
+	case POPULATE_DIRECT:
 		return addr;
 	case POPULATE_ABS_LOWCORE:
 		return __abs_lowcore_pa(addr);
@@ -251,9 +251,9 @@ void setup_vmem(unsigned long asce_limit)
 	 * the lowcore and create the identity mapping only afterwards.
 	 */
 	pgtable_populate_init();
-	pgtable_populate(0, sizeof(struct lowcore), POPULATE_ONE2ONE);
+	pgtable_populate(0, sizeof(struct lowcore), POPULATE_DIRECT);
 	for_each_mem_detect_usable_block(i, &start, &end)
-		pgtable_populate(start, end, POPULATE_ONE2ONE);
+		pgtable_populate(start, end, POPULATE_DIRECT);
 	pgtable_populate(__abs_lowcore, __abs_lowcore + sizeof(struct lowcore),
 			 POPULATE_ABS_LOWCORE);
 	pgtable_populate(__memcpy_real_area, __memcpy_real_area + PAGE_SIZE,
-- 
2.38.1

