Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057DE7C87DC
	for <lists+stable@lfdr.de>; Fri, 13 Oct 2023 16:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJMOaR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 13 Oct 2023 10:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjJMOaQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 13 Oct 2023 10:30:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFCE95
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 07:30:15 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DEHZlA023011
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6+y8P6iVx91hy24OiIHRs9af8ghIrQnrqC5oc+v1Ow0=;
 b=GxWfWJIHVwUYrGkupC0VTJSu0UYfQpB/l+LYsojKMDiiloXGCcisiBOvtZ+LyxMLiOn4
 xPj4qoYU2hUedW8WEVwCmGvCtrxXGjWTUOzaQE4o5OAbN7zwcX7tsigas/ylcNctPb8b
 Xoa/VKL2jj5F+A1cCooOQpORlcdLgm3OuVQyXgXHNrXmwU2LwLco8oqaa3vTQFamIS79
 EZuPCZUpI18qNyrGB5wB2pOFxltrv9UpCPBt05X1+Y0tgZiDvwcnIlvtnnthfOmQ9IHE
 H8ISaDyiaD6UtVKWUfsm4cuyxkjdC2473u7IYVG/NtnXu4B66u47eCMg9dXaR3RfWDdA CQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq7he8dqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:30:14 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39DEEApb009040
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:30:13 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tpt57mf37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <stable@vger.kernel.org>; Fri, 13 Oct 2023 14:30:13 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39DEUBDr20251246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 14:30:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDF7558059;
        Fri, 13 Oct 2023 14:30:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE6245805B;
        Fri, 13 Oct 2023 14:30:10 +0000 (GMT)
Received: from gauravs-mbp.lan (unknown [9.67.43.36])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 13 Oct 2023 14:30:10 +0000 (GMT)
From:   Gaurav Batra <gbatra@linux.vnet.ibm.com>
To:     gbatra@us.ibm.com
Cc:     Gaurav Batra <gbatra@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH 25/25] powerpc/pseries/iommu: enable_ddw incorrectly returns direct mapping for SR-IOV device
Date:   Fri, 13 Oct 2023 09:29:45 -0500
Message-Id: <20231013142945.1956-25-gbatra@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20231013142945.1956-1-gbatra@linux.vnet.ibm.com>
References: <20231013142945.1956-1-gbatra@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hUf8_6lu0f6Q8dpbT4j8u6vpCVUXp5ZA
X-Proofpoint-GUID: hUf8_6lu0f6Q8dpbT4j8u6vpCVUXp5ZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Bugzilla Number: 202953

Upstream CommitID:

Dependency-commit: d61cd13e732c0eaa7d66b45edb2d0de8eab65a1e

Description:

When a device is initialized, the driver invokes dma_supported() twice -
first for streaming mappings followed by coherent mappings. For an
SR-IOV device, default window is deleted and DDW created. With vPMEM
enabled, TCE mappings are dynamically created for both vPMEM and SR-IOV
device.  There are no direct mappings.

First time when dma_supported() is called with 64 bit mask, DDW is created
and marked as dynamic window. The second time dma_supported() is called,
enable_ddw() finds existing window for the device and incorrectly returns
it as "direct mapping".

This only happens when size of DDW is big enough to map max LPAR memory.

This results in streaming TCEs to not get dynamically mapped, since code
incorrently assumes these are already pre-mapped. The adapter initially
comes up but goes down due to EEH.

Fixes: 381ceda88c4c ("powerpc/pseries/iommu: Make use of DDW for indirect mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Gaurav Batra <gbatra@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index efdcdf2aa42e..ce47ba64cb60 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -911,7 +911,8 @@ static int remove_ddw(struct device_node *np, bool remove_prop, const char *win_
 	return 0;
 }
 
-static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift)
+static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *window_shift,
+			      bool *direct_mapping)
 {
 	struct dma_win *window;
 	const struct dynamic_dma_window_prop *dma64;
@@ -924,6 +925,7 @@ static bool find_existing_ddw(struct device_node *pdn, u64 *dma_addr, int *windo
 			dma64 = window->prop;
 			*dma_addr = be64_to_cpu(dma64->dma_base);
 			*window_shift = be32_to_cpu(dma64->window_shift);
+			*direct_mapping = window->direct;
 			found = true;
 			break;
 		}
@@ -1278,10 +1280,8 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	mutex_lock(&dma_win_init_mutex);
 
-	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len)) {
-		direct_mapping = (len >= max_ram_len);
+	if (find_existing_ddw(pdn, &dev->dev.archdata.dma_offset, &len, &direct_mapping))
 		goto out_unlock;
-	}
 
 	/*
 	 * If we already went through this for a previous function of
-- 
2.39.2 (Apple Git-143)

