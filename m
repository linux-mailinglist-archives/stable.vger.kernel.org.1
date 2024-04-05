Return-Path: <stable+bounces-36127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E8889A12B
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 17:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30BEAB25D64
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C520171E62;
	Fri,  5 Apr 2024 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hg2KElQ/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49916FF28
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330972; cv=none; b=bTHK2z+lX1UB7Gfva0wFd/7tAba0zEAxCUtYauGbR+2Opf4ez7Z8h+ZLgwAJVkZCzkCqrxREJy44Vkyl95AxOms01svYwy6qNoKIE3Wi+F2Oaf4Ucr+r6jrPP8QDCc1OFKvwGqDR1ri+Xvg2C8LbTDev0cEjgbCYt/sAMV+W6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330972; c=relaxed/simple;
	bh=DukQ98ox/VmI0uVaMGkiWqZIeY6XnxYTO7LjoINUaHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=enmuUP4NQAaGYFrgLfXebcpBPzroy79OHshun02v/uXt6S1kXv73t1pX1/zxk0/A4+cdVr9HiHDo2mHBguU1sNKdGdQzCI5+yxlMebj2r/HwvrvVeLTLFbFcRCpD2Mf56qxe2V/j090YY9oZERwAp2Z5NaVJNxe3k2Ks4qCGbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hg2KElQ/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435EtSA8004968;
	Fri, 5 Apr 2024 15:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=XWLbok1JGXwyONtMGiH9Y4A89YnwGf1CyiXHkZxhqc4=; b=Hg
	2KElQ/exxh3B8yANvB+goY0FMjdGWLn1qI46xunUQYVftrTRVz8c2BzywN97efvJ
	TnttZTQMX1YjYAE5Mz2DiyqlX5RmQaCSkoUbnxnqiSl2XngS/oON3lhYLNe7p4nj
	ejd8RRajQ0oIeBwDCTJ6PKICO1TyNq+bIViEifSISC8aaHu7Qj2uo13polazaZsD
	d0AigFu6DYMsrDnP4XCyP1cfe6GyQdCyLVcg3ERYzcMsk9NWPHpwVPX3+0mCIppe
	36ufIx8Oh+iC7phikPoAbGg9Z1D9wMTnEFdsl97kNO+r+LCHMzf1LleSWrSnHLIW
	f4e4GZ0NWXJ04hJYZThQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xahgt0dg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 15:29:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435FTON3001401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 15:29:24 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 08:29:23 -0700
Message-ID: <1f579682-945e-2515-f303-349c6e8f38b0@quicinc.com>
Date: Fri, 5 Apr 2024 09:29:23 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 8/8] accel/ivpu: Fix deadlock in context_xa
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <stable@vger.kernel.org>
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
 <20240402104929.941186-9-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240402104929.941186-9-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: q9gm0_yqXkx7rrLVRIUgen_TF_ODT1Gw
X-Proofpoint-ORIG-GUID: q9gm0_yqXkx7rrLVRIUgen_TF_ODT1Gw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_16,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=899 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050111

On 4/2/2024 4:49 AM, Jacek Lawrynowicz wrote:
> ivpu_device->context_xa is locked both in kernel thread and IRQ context.
> It requires XA_FLAGS_LOCK_IRQ flag to be passed during initialization
> otherwise the lock could be acquired from a thread and interrupted by
> an IRQ that locks it for the second time causing the deadlock.
> 
> This deadlock was reported by lockdep and observed in internal tests.
> 
> Fixes: 35b137630f08 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
> Cc: <stable@vger.kernel.org> # v6.3+
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

