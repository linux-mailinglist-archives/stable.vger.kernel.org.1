Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07BD730CEA
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 03:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjFOBxR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 21:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFOBxQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 21:53:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA658E69
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 18:53:15 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJempE009926;
        Thu, 15 Jun 2023 01:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=5CiVtYhOoN7qV45Sx8vz4fvFgjBEKFxo+bhyG8hYerM=;
 b=LFg3BSpRxD12LpZ1MCYXhQuPq49XCYSm4Kmnr3NPQ2eu4QvuKeH9ZuhRZo0uv9xKRL28
 Y4fajmoSnCtuKBvlVQle57oEtNDsOrMuGiBBOWTiftQbZVX0pa/OKPSaSabn4dezX3+c
 5zBwrugbvF7kVe1QVUG1ciXBw36BsDlaf4ySQIR/cw7LIJJzbHZoXyebqSlUUACQGjT2
 uW9ZoFdsGYo+e+pSFjY4pqBqGBmqdcW50IQgAwYtDP8sTyhFJYTTZpwoVWc/lWyeNEO3
 YCBbA91Gq7Qm9+Ysyf/MEfirz/nQSUsiW1V9Nv19qn8/Tu+WS/CnEPAGYSTg2BO2xhKK 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4g3bs0s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:53:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENiBhJ021725;
        Thu, 15 Jun 2023 01:53:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6aqwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:53:05 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F1r5r8001175;
        Thu, 15 Jun 2023 01:53:05 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3r4fm6aqvx-1;
        Thu, 15 Jun 2023 01:53:05 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     stable@vger.kernel.org
Cc:     tony.luck@intel.com, dan.j.williams@intel.com,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com, glider@google.com,
        jane.chu@oracle.com
Subject: [5.15-stable PATCH 0/2] Copy-on-write hwpoison recovery 
Date:   Wed, 14 Jun 2023 19:52:53 -0600
Message-Id: <20230615015255.1260473-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=617 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150014
X-Proofpoint-ORIG-GUID: YH6GtzYYkIrCAoRjfCZXrY6VM_H-lLN1
X-Proofpoint-GUID: YH6GtzYYkIrCAoRjfCZXrY6VM_H-lLN1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

I was able to reproduce crash on 5.15.y kernel during COW, and
when the grandchild process attempts a write to a private page
inherited from the child process and the private page contains
a memory uncorrectable error. The way to reproduce is described
in Tony's patch, using his ras-tools/einj_mem_uc.
And the patch series fixed the panic issue in 5.15.y.

The backport has encountered trivial conflicts due to missing
dependencies, details are provided in each patch.

Please let me know whether the backport is acceptable.

Tony Luck (2):
  mm, hwpoison: try to recover from copy-on write faults
  mm, hwpoison: when copy-on-write hits poison, take page offline

 include/linux/highmem.h | 24 ++++++++++++++++++++++++
 include/linux/mm.h      |  5 ++++-
 mm/memory.c             | 33 +++++++++++++++++++++++----------
 3 files changed, 51 insertions(+), 11 deletions(-)

-- 
2.18.4

