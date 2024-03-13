Return-Path: <stable+bounces-27582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A937687A70B
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 12:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542621F22CF4
	for <lists+stable@lfdr.de>; Wed, 13 Mar 2024 11:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E943F8D4;
	Wed, 13 Mar 2024 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hP/L08/s"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424E73EA6C
	for <stable@vger.kernel.org>; Wed, 13 Mar 2024 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710329020; cv=none; b=uGhlzXfls70NsjaFM4VWfyopes/azfYzfVs7FzEADGvfAnS2PK9FT5NUARpNcnRHbuo5C7X+9F6mM2j2jgEChSjLZkCFkSNnXLHLaeeEckJgua0CL4k3h0XqAkMrpQMPHv+lJTpguBZln31Uv0Mu+9IwK94sxgpRL6M/ON6UaWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710329020; c=relaxed/simple;
	bh=snCtwmWFz2VQkRVkYgDqqbYQNPCAkM8uboUeL8aDobI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tkL1RJGi6pUYitmkjefpTsupCX/8qqv9eW02RGNH50ISLTqD422n+KZEWYwHqNA24OV+Z3/jgi9PlKpvn8H4/Qq8luAFypbiogueTZV9meiWNsQSi0zHFMSNXpWQ9svlUD0QOIe5Wyp/bUaAlBdG672HgwxYc4OTqhT0o2aKLus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hP/L08/s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42D9v8uR007212;
	Wed, 13 Mar 2024 11:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=NQpXNVfH+tJUTwyZ+SqQMBl5k1g/PXORYi/fo/4MB8s=; b=hP
	/L08/sno3oCbu0ePSUoxEizITZ4NYhlB81C3yF/mSFDEJ9FX44PPFkXWgrhN7R2p
	rHVFIVehgAjBKWUaqf/CPt2ilc/MbxmaH2m93RgmJtPD12M+zpPq5cYINjAx4kai
	0KStzxe/5WhjbOLg0lbWoaRCB7nln8OUx3WDEFAz6AExCM67rLIPdvYggdxKjjko
	y757XtBiJJjlKBNDU5qx+jt+QisPVNUmsmreZRqL/RANXfAutqjayTS+kFLYuM/0
	BMcSJ0ZqWXSFTHsVovrevNYr9js7W2YJleevIPgDmsHz/FZabIa6QueEuF6FVTAe
	wxcxSEp4Z7IoDu68q4kA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wu9y3r57y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:23:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42DBNGeE017532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Mar 2024 11:23:16 GMT
Received: from [10.214.226.177] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Mar
 2024 04:23:13 -0700
Message-ID: <8dd12cfc-e5bd-caae-5a32-e1203a478bac@quicinc.com>
Date: Wed, 13 Mar 2024 16:53:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
To: Zi Yan <ziy@nvidia.com>, <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC: <linux-mm@kvack.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Naoya
 Horiguchi <naoya.horiguchi@linux.dev>
References: <20240306155217.118467-1-zi.yan@sent.com>
Content-Language: en-US
From: Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <20240306155217.118467-1-zi.yan@sent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BQLT4tyFDTUi3-WYfkazEnPF2aXjRTnr
X-Proofpoint-GUID: BQLT4tyFDTUi3-WYfkazEnPF2aXjRTnr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_07,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1011 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403130083


On 3/6/2024 9:22 PM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> The tail pages in a THP can have swap entry information stored in their
> private field. When migrating to a new page, all tail pages of the new
> page need to update ->private to avoid future data corruption.
> 
> This fix is stable-only, since after commit 07e09c483cbe ("mm/huge_memory:
> work on folio->swap instead of page->private when splitting folio"),
> subpages of a swapcached THP no longer requires the maintenance.
> 
> Adding THPs to the swapcache was introduced in commit
> 38d8b4e6bdc87 ("mm, THP, swap: delay splitting THP during swap out"),
> where each subpage of a THP added to the swapcache had its own swapcache
> entry and required the ->private field to point to the correct swapcache
> entry. Later, when THP migration functionality was implemented in commit
> 616b8371539a6 ("mm: thp: enable thp migration in generic path"),
> it initially did not handle the subpages of swapcached THPs, failing to
> update their ->private fields or replace the subpage pointers in the
> swapcache. Subsequently, commit e71769ae5260 ("mm: enable thp migration
> for shmem thp") addressed the swapcache update aspect. This patch fixes
> the update of subpage ->private fields.
> 
> Closes: https://lore.kernel.org/linux-mm/1707814102-22682-1-git-send-email-quic_charante@quicinc.com/
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Tested this patch for 6.1 kernel and observed no issues. With that,

Reported-and-tested-by: Charan Teja Kalla <quic_charante@quicinc.com>

Thanks,
Charan

