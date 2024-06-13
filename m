Return-Path: <stable+bounces-50493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6C0906A08
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517D31C2082D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06E313E036;
	Thu, 13 Jun 2024 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JPSz/nhC"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44EA136663;
	Thu, 13 Jun 2024 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274695; cv=none; b=kfCPQaIZ5QPuKUFoXIGwwvVXYjb/CxcVPFZazuuFQtULTwGzafcuU7XA1ExRoZRP4m5WUPD5SYG0SA8BA+5wWC276fo+P7z+TACq0eQl4dF5rssuPVD4gLbcG+7LfAcHxlX+hkAgHKRbDaLI3UlhIdj5F2QgPNcjoqXrgFy34eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274695; c=relaxed/simple;
	bh=XchcFWCNPg1L9cSqAz/t3ciT2SWLAiYs7ywKgxYt7MA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sb/xjowO7R5m/CUxq/PA9DAAzHRWq6Bh51Ll3MuiIZaTrWZ2T8tf81f8NpDuhfXk5gO4Oc5EETaSSETlpfddiDMaxFiJ97h9GUIXP5EhZamEQd3SVXhA7GHLSqrNEQGQInd7oJSUVPyH6AUZrhfN0g1nguipBqDx0OTXJ4vvwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JPSz/nhC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D6X3XI001981;
	Thu, 13 Jun 2024 10:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EBJ2Q92ghG1HkKBLyMMx2+Er
	jtsQbdw75uRcCN6zc5w=; b=JPSz/nhCuDf32knpFirPBeWxd/N5Wp9T36ZWj5Od
	SsVPIV3aClF5D+mqG2f+NbH/pjrXcgnYLONcEFEEGnTtVe6+bvZrpaksPFXkTPmi
	ibJRe5mg9Rs9GeH4WJN8wIHybuBZtCsM/Mns037qpbNuBGsabrozt8WtUFYdXHuD
	OMW6JmXpMF79qmT8B0X1+YayqFPwe+Aji3KZZ41+OPkg1v79X8sh1AAgXnj9MX2I
	njg2CtkR6Rid2/bKlDz0SNLYkSRvVh32kRGFMuLJcCO2aHlqcVQ5T+pzEnGNsq9C
	PVVSYyGlwvCwFBEMjGjOhiu4C19q75AWdYh9U8mWgk/n7Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqukc8k5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 10:31:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45DAV9un025330
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 10:31:09 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 13 Jun 2024 03:31:05 -0700
Date: Thu, 13 Jun 2024 16:01:01 +0530
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
CC: <stable@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon
	<will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        Tom Murphy
	<murphyt7@tcd.ie>, Saravana Kannan <saravanak@google.com>,
        Joerg Roedel
	<jroedel@suse.de>, <kernel-team@android.com>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.15.y] iommu/dma: Trace bounce buffer usage when mapping
 buffers
Message-ID: <ZmrKZYJ0+z3mRZXx@hu-bibekkum-hyd.qualcomm.com>
References: <2024012226-unmanned-marshy-5819@gregkh>
 <20240122203758.1435127-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240122203758.1435127-1-isaacmanjarres@google.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ApMcbWOuRM4yF9_N3X1to9QvETfBRKIG
X-Proofpoint-ORIG-GUID: ApMcbWOuRM4yF9_N3X1to9QvETfBRKIG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_02,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130075

On Mon, Jan 22, 2024 at 12:37:54PM -0800, Isaac J. Manjarres wrote:
> When commit 82612d66d51d ("iommu: Allow the dma-iommu api to
> use bounce buffers") was introduced, it did not add the logic
> for tracing the bounce buffer usage from iommu_dma_map_page().
> 
> All of the users of swiotlb_tbl_map_single() trace their bounce
> buffer usage, except iommu_dma_map_page(). This makes it difficult
> to track SWIOTLB usage from that function. Thus, trace bounce buffer
> usage from iommu_dma_map_page().
> 
> Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> Cc: stable@vger.kernel.org # v5.15+
> Cc: Tom Murphy <murphyt7@tcd.ie>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> Link: https://lore.kernel.org/r/20231208234141.2356157-1-isaacmanjarres@google.com
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> (cherry picked from commit a63c357b9fd56ad5fe64616f5b22835252c6a76a)
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  drivers/iommu/dma-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 48c6f7ff4aef..8cd63e6ccd2c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -25,6 +25,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/crash_dump.h>
>  #include <linux/dma-direct.h>
> +#include <trace/events/swiotlb.h>
>  
>  struct iommu_dma_msi_page {
>  	struct list_head	list;
> @@ -817,6 +818,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  		void *padding_start;
>  		size_t padding_size, aligned_size;
>  
> +		trace_swiotlb_bounced(dev, phys, size, swiotlb_force);
> +

Hi, this backported patch trying to access swiotlb_force variable is
causing a build conflict where CONFIG_SWIOTLB is not enabled.

In file included from kernel/drivers/iommu/dma-iommu.c:28:
kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
                 enum swiotlb_force swiotlb_force),
                      ^
kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
#define swiotlb_force SWIOTLB_NO_FORCE
                      ^
In file included from kernel/drivers/iommu/dma-iommu.c:28:
kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
#define swiotlb_force SWIOTLB_NO_FORCE
                      ^
In file included from kernel/drivers/iommu/dma-iommu.c:28:
kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
#define swiotlb_force SWIOTLB_NO_FORCE
                      ^
In file included from kernel/drivers/iommu/dma-iommu.c:28:
kernel/include/trace/events/swiotlb.h:15:9: error: declaration of 'enum SWIOTLB_NO_FORCE' will not be visible outside of this function [-Werror,-Wvisibility]
kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
#define swiotlb_force SWIOTLB_NO_FORCE
                      ^
kernel/drivers/iommu/dma-iommu.c:865:42: error: argument type 'enum SWIOTLB_NO_FORCE' is incomplete
                                       trace_swiotlb_bounced(dev, phys, size, swiotlb_force);
                                                                              ^~~~~~~~~~~~~
kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
#define swiotlb_force SWIOTLB_NO_FORCE
                      ^~~~~~~~~~~~~~~~
kernel/include/trace/events/swiotlb.h:15:9: note: forward declaration of 'enum SWIOTLB_NO_FORCE'
enum swiotlb_force swiotlb_force),
     ^
kernel/include/linux/swiotlb.h:143:23: note: expanded from macro 'swiotlb_force'
#define swiotlb_force SWIOTLB_NO_FORCE

--------------------------------------------------------------------------------------------------------------------------------------------------

I have a simple proposed fix which can resolve this compile time conflict when CONFIG_SWIOTLB is disabled.

--- a/include/trace/events/swiotlb.h
+++ b/include/trace/events/swiotlb.h
@@ -7,6 +7,7 @@

 #include <linux/tracepoint.h>

+#ifdef CONFIG_SWIOTLB
 TRACE_EVENT(swiotlb_bounced,

        TP_PROTO(struct device *dev,
@@ -43,6 +44,9 @@ TRACE_EVENT(swiotlb_bounced,
                        { SWIOTLB_FORCE,        "FORCE" },
                        { SWIOTLB_NO_FORCE,     "NO_FORCE" }))
 );
+#else
+#define trace_swiotlb_bounced(dev, phys, size, swiotlb_force)
+#endif /* CONFIG_SWIOTLB */

 #endif /*  _TRACE_SWIOTLB_H */


Thanks & regards,
Bibek

>  		aligned_size = iova_align(iovad, size);
>  		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
>  					      iova_mask(iovad), dir, attrs);
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

