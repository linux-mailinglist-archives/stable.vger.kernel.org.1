Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8287F6FC91A
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235825AbjEIOe5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 10:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbjEIOex (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 10:34:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AFE1BCA
        for <stable@vger.kernel.org>; Tue,  9 May 2023 07:34:52 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349E6YNS002577;
        Tue, 9 May 2023 14:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=YqlrglftFOBKlLndc5sqxJjJQ/NOxC/Mt19jexm4Hk4=;
 b=Nk15vQjK/ZXX3aIaK9rqXUdvWZ+UhoE0JBUmzSRYRMwv6a1WAvD+ATQlwxDnXUvx5gyT
 97DDaNvPc5jmua6C1NuxuGxWOEc3xruiOdwrSCsR6W63x4hHkOMASaYKOUd3s9QDoD8w
 Q5X+a2IYqI93MnRoglqdAQ08k4Ypb4pXaOKVjymVO1ucEDy/0oXGfcWB2LoySMa7MDNM
 +i64HfiZHDKnfkDU9XOJEi5fdz6S5cUlUwtPN/xsBXjf/qS6+nRG9AUtMKFilugHZqZD
 8Vmb9NbW/W0+XykK+tbjK0B8jJKar2heRccUaJvInMGb11ZQJmZJBpmnYY3aLsYoJ/rJ jw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfmb3827e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 14:34:41 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 349D7MxB025849;
        Tue, 9 May 2023 14:31:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3qf7e0rdfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 14:31:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 349EVDNX13107954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 May 2023 14:31:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5AD320040;
        Tue,  9 May 2023 14:31:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70CB620043;
        Tue,  9 May 2023 14:31:13 +0000 (GMT)
Received: from localhost (unknown [9.179.7.201])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  9 May 2023 14:31:13 +0000 (GMT)
Date:   Tue, 9 May 2023 16:31:11 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH stable 6.3 0/2] s390/mm: fix direct map accounting
Message-ID: <cover.thread-961a23.your-ad-here.call-01683642007-ext-1116@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ayymI0BZS3IPenVVRO0DtQvgCJNNjZRm
X-Proofpoint-GUID: ayymI0BZS3IPenVVRO0DtQvgCJNNjZRm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 mlxlogscore=385 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
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

As an alternative to backporting part of a large s390 patch series to the
6.3-stable tree as dependencies, here are just couple of rebased changes.

Avoids the need for:
Patch "s390/boot: rework decompressor reserved tracking" has been added to the 6.3-stable tree
Patch "s390/boot: rename mem_detect to physmem_info" has been added to the 6.3-stable tree
Patch "s390/boot: remove non-functioning image bootable check" has been added to the 6.3-stable tree

Thank you

Heiko Carstens (2):
  s390/mm: rename POPULATE_ONE2ONE to POPULATE_DIRECT
  s390/mm: fix direct map accounting

 arch/s390/boot/vmem.c           | 27 ++++++++++++++++++++-------
 arch/s390/include/asm/pgtable.h |  2 +-
 arch/s390/mm/pageattr.c         |  2 +-
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.38.1
