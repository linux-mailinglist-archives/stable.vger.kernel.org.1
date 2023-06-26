Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C6B73EF01
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 01:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjFZXDW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 19:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjFZXDH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 19:03:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062891702
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 16:02:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QMiWu6029286;
        Mon, 26 Jun 2023 23:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=zV3r52VOpJXSoOK1eXMjuQnsv1GaL0DyuRYJdUUANZk=;
 b=GgfJJPp/mMDAeKEqcsPzumbiItm8JPhuUY7FR3FcvpEVN8ysEL6Yl3FZta2LFwPKdUJc
 Rz92bPYBvWKQ62BBQhzG7OdnTGMX5Aj6Z8O3Rzodth7+S0L2MTHZ7afxRuyWeU/jXQXz
 lXquJg4G3lmlEsNzaHhvNvVBCx801x0hXAhkmsJb/URQMVQZ4jpxd3+xsmUKfeOLpLhe
 48OE6W/zOSxGRYYquNJVbVH4ftEQfrNOhZPZaz+C08gZaIjSpAFzZ+WUMnO2V/1m57aj
 4rOj9Dqo1A4W98e7JfZeIHA3XkKeT3o2ni7cVS7wdAHUVedfs47/qDu5GR4H5hCf04YJ TA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq30uxg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 23:02:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35QMCWJd018998;
        Mon, 26 Jun 2023 23:02:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx3ydy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 23:02:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35QN2Uuv001944;
        Mon, 26 Jun 2023 23:02:30 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rdpx3ydxg-1;
        Mon, 26 Jun 2023 23:02:30 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     stable@vger.kernel.org
Cc:     tony.luck@intel.com, dan.j.williams@intel.com,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com, glider@google.com,
        jane.chu@oracle.com
Subject: [5.15/6.1-stable PATCH] Copy-on-write hwpoison recovery 
Date:   Mon, 26 Jun 2023 17:02:17 -0600
Message-Id: <20230626230221.3064291-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=625
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260214
X-Proofpoint-ORIG-GUID: mV4ZOoSTZa65nEBnYFZUSLpcUEoE0rKn
X-Proofpoint-GUID: mV4ZOoSTZa65nEBnYFZUSLpcUEoE0rKn
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

Followed here is the backport of Tony patch series to stable 5.15
and stable 6.1. Both backport have encountered trivial conflicts
due to missing dependencies, details are provided in each patch.

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

