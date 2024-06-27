Return-Path: <stable+bounces-55972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3291A9AB
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99035281564
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0444219AA78;
	Thu, 27 Jun 2024 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fIuddPza"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F68619A2A7
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499501; cv=none; b=grNYOqmYPhNHnk00ieMEhy44sdqNwxxlgJ8hXsaHd9ppr6d2Tu1RAVe3xxjzD0UW3ZdR1ZY8eCz6BI5I26OtsFC5FeuNGedBOlmAB2ZW/VC2Zo7I4w5AoH7mjVcr5IKKd366RSZVBU908AW5LI3UW3IszqxLa4rzI7pjJ7S6AlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499501; c=relaxed/simple;
	bh=1E8CXTaeS0vfb3JNuYWvmFd/1VjQ+/BGgq4+DuENiCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lyBjYrbPxzBiNlc+T5SwAYdD6XShg0kOEmI7GEqD+xmKm9lkSalqRq4FBalkLCuZvD6F3SlfYeE/EwHGM1aqyeZ+nbCELQRuhGT8+g2j75ATPlqVse64StGdfwrKCO4jqYpQx1bmSUkL8vqS5GVBNfqsalWFTNpCp84oBAQzdxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fIuddPza; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RBI6j9018763;
	Thu, 27 Jun 2024 14:44:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WslwZJ62dfJVvCtGkzCHotG8/kqwFxTrKlBEYc9dgv0=; b=fIuddPzajNa5j2pP
	bzrwLj0UINUD7NS8RhQi6jZmaF4SVH9RnZ9qBhHCX9ugjap2oHXdZTyNwNdTzc0K
	08aw3yiQyuDZ6UOqb1PLX+Rsx1YXA9V/Eus4YMomKG+AXkHtGT/pVX8TUbRk+Vyh
	TJwdceEiDh8f5giTfhQUJjUTD/qwvjRh4eCKVlN+mt99cfPB8I5omqbsISIo5Pch
	e7ZIm0ygpGls2+cbllM9oQTpMO/iTr1b/mTiW2EjpHTQkiRaTdwqOn6pg1jBmLsx
	WfI5HLrdn84d9wipC+zJC04t0IfvMDNBqbX22JOztCv15r12tSERPWqtIXjlj2Cv
	daSriA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400f90kwas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 14:44:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45REinTX029711
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 14:44:49 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 07:44:49 -0700
Message-ID: <b77e4ae4-fea5-4032-9d76-fbefc1c5dc65@quicinc.com>
Date: Thu, 27 Jun 2024 07:44:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please backport 2ae5c9248e06 ("wifi: mac80211: Use flexible array
 in struct ieee80211_tim_ie")
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
        Kees
 Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
        Koen Vandeputte
	<koen.vandeputte@citymesh.com>
References: <fc31dd6f-ec32-4911-921f-1f34e9ad2449@quicinc.com>
 <2024062745-erased-statue-0a01@gregkh>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <2024062745-erased-statue-0a01@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EO1tTDdKbSnDDsxjnSioOchBEEDv7sXT
X-Proofpoint-GUID: EO1tTDdKbSnDDsxjnSioOchBEEDv7sXT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_11,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=824 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270111

On 6/27/2024 12:18 AM, Greg KH wrote:
> On Wed, Jun 26, 2024 at 11:32:22AM -0700, Jeff Johnson wrote:
>> Refer to:
>> https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/
> 
> Please provide the information in the email, for those of us traveling
> with store-and-forward email systems, links don't always work.

Apologies. I was trying to be concise, but over did it.

The issue reported is a splat in 6.6 due to FORTIFY_SOURCE complaining about
access to an "old style" variable array declared with size 1:
            u8 virtual_map[1];

>> Looks like this should be backported to all LTS kernels where FORTIFY_SOURCE
>> is expected to be enabled.
> 
> And where would that exactly be?  Have you verified that it will apply
> properly to those unnamed kernel trees?

I don't know which trees are actively enabling FORTIFY_SOURCE. Since the
report is coming from 6.6, I would expect we should backport at least to there.

I've cc'd Kees in case he has more definite information, as well as the
wireless maintainers and the reporter in case they have anything else to add.

The actual fix is trivial, containing just a change to a data structure along
with a related documentation change. Any conflicts would more likely occur due
to the documentation rather than the code, since that code definition had been
unchanged since 2012 but the documentation has been refined over time.

/jeff

