Return-Path: <stable+bounces-240424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I9XOl636WlgiQIAu9opvQ
	(envelope-from <stable+bounces-240424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:08:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B3444D6B4
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 08:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E818330074F1
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 06:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFAD38D017;
	Thu, 23 Apr 2026 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nK768mAb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DeIAiwu5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36A21771B
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776924502; cv=none; b=Fofjr0VZW89sh14KbrKHZbX8oieCFq0zRD+48fY5uOZJEqtTjWUxOWwI7KSA/kV21+xPpxVf/dqT0STN6AiXN6k+2tqI0z0mlMqFl+1p4kmnga6+JLtxKEO0Ro5dCvAeqrAtd1ce1rLtXjwwTkAz4qyFBqURrDZRdrBpUe6fIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776924502; c=relaxed/simple;
	bh=8NzhCLSUvgpS1is19m5aquovbJPJJBEQksmroAUT1cU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ahnr1Tu27hQg1VxbgDj2TI8p6HSK9iPF2B3MU2HWrGmT4PExhVnhWQYIqIGch5HbyF19l1U7nWeFappAxKzwS5td87w+i9SPuVc5qIGCM+hlBhx2L9TFlEvC9f5w06ye/2S6ew/KQQjkmaJ9pzpMbJX4Nsw8wT0GW2Zg2lwklNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nK768mAb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DeIAiwu5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N3sFCp1587764
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ra3Oh0VE+DpjFugvfYDPOsGLhtyDlJGOjMAvcNm/GFk=; b=nK768mAbiSZccH5F
	dqJf0QdbtOB3M8JSWnkyfE8e9pz7SIYQbz+PQIO3KUqzJ1zAcUbJH8pL52WKVyAy
	ElpLxGaLiegc+bi6LIbxXD0yhnex7Bw16j65h8G9whxEPZlcPYCnSaPcfUfMGigb
	yVHOvcgryx+4I5PRmtk+0T0FXoKhmaLKvGmudjucwl8D9ba5NB655tMhDBH9vNqJ
	NwSMGBz1Y37wm2WhqUMK1M7mMa50cCQQGYvAJ+vvUUs04HZRM0DETl7p7B3VgI+a
	VVX7WKgUKiSqKdtQy/9NHKloads+v+vhMBAPazOGr1BFbtm0gOYAWsD24Eo2FPYO
	GQefSw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq2d9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:08:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-362d9dd9a49so341118a91.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 23:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776924499; x=1777529299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ra3Oh0VE+DpjFugvfYDPOsGLhtyDlJGOjMAvcNm/GFk=;
        b=DeIAiwu5qVpe3IWk4FlV5FEjVW+7oj/P+2hHzQir7AvbvdgdK0lZI8GprkMC1g7INj
         onhvZ3hMfZ6w3qVurCdbxA+XmZKzZ9B9DwTImu5UXlJlmUQ+l52+qu7UYU3/LBEWbXxH
         G2MVHb4h6UTBTUReRsK52a7ImXiEGhzQ4qa/3vVv76bNT1R/C+m00z10QSDVR5fhFSo4
         10D2Cyg4PAFLVH3E4wf9cddvkHOjaQ3wWYiR1wI+B2/S7KtTlYLlSJIHtXcIyJPnCS7+
         YCRjhd932au0x7hGrv6lE5lsfQFapcv//ZYRbISKAq612KZ9A6SO31Ofr21KliKkYtUs
         kb3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776924499; x=1777529299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ra3Oh0VE+DpjFugvfYDPOsGLhtyDlJGOjMAvcNm/GFk=;
        b=HFuK3IxUdf0kAcn5qLnCVXaaLB+1p6RnzL3ONekLwCMJmI9IrfVUUM7J8eDFV2Igy9
         fqqT509D0yZgg/CoVQD2eiNm8tNuHusmtBPlCeRk2sAO2SzXvUTiiE85wAznAeLgd2xK
         O0HVXejPEqMCvzh8UDOiuTnQSmjC5CGr7JMagfU7npo3zC6N09Hu/rlfbKFCZQNGVmYg
         RX0bxqruqbsb+vlJImQlrfcy5dkNgwEbi7kyNzK0E/CqFT8Bq3LNPs0HpRTaS0kVDiUj
         4Oh0deVz6l1c/RupfiV0QG2QX/MgZqFH8TNywvXFlZn1Aqs9yvRkgr9i9MEqqiUpeV8G
         K8Xw==
X-Forwarded-Encrypted: i=1; AFNElJ8A7gbjASlwAzmnwbkBnu9xvANlpGAKMeDKT1BtSxXJXwmKfEAGa9r28p2KekX7rCDGCgBlDsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEfqJbnAmZOEQRUpySrzrDrtHxHhzxpMkuuBEXvAOnnUnGAdu9
	a53yHsRcPCRHrWVFBHl9LrILR8xjdYdTnU9ukyMYwePYyf1B8rA2jc5DCFiWTOqkBZOcYW6S+Uv
	7UuLX1/7dKkLg3VHYuBrY1w8Ub5dPNAk0Fc/LVM1Me6nV/Rfodmvrw8u54R0=
X-Gm-Gg: AeBDievwtutmNapS00cppYsD89WGr6mNMnTjSX/bk7H7gtQpkFHKmogxYOPlfLcqofn
	jevHIslVKsPpNvp93dZvojuCtt3RYbBgPQ0ck3Ug8vGxeaoc76WllLPUbEPfRd4MVb2WQBj6eGv
	WpJQFpbhilzrtl3ulcsWkb5RFsLSbrOcM7culaNvV7NIU1F0R+5oHNt7pyCvUpPfXW6CX1YPQlY
	y376xsfOHyuT2rWXuHGdX4XpEUuLLycyGRUWDOmJGfCKnpvYV/tOygeqzXGS1D7BhIfXCBrUxUs
	xGKruKyidWwUMEI95loys6SR4fQjE6W/+z/iFPPlNho1Ymo4d+ms2c/WCuQLm7k2zxDtl6SObno
	6CvcqHw60Pe0uFx/UIFOUlJ2kGYK7bksoRq9FnGaib2rhJA8bYZUZ6+XyTrguH87b4aAvBcXXEL
	baID9LWFXZPTOtqLXWEGRz1nOK5rPy
X-Received: by 2002:a17:90b:270a:b0:35d:a8d9:3b4 with SMTP id 98e67ed59e1d1-361403c35b5mr25168073a91.4.1776924499386;
        Wed, 22 Apr 2026 23:08:19 -0700 (PDT)
X-Received: by 2002:a17:90b:270a:b0:35d:a8d9:3b4 with SMTP id 98e67ed59e1d1-361403c35b5mr25168045a91.4.1776924498942;
        Wed, 22 Apr 2026 23:08:18 -0700 (PDT)
Received: from [10.133.33.147] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410b998fsm18948440a91.13.2026.04.22.23.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 23:08:18 -0700 (PDT)
Message-ID: <cd18af00-335c-4762-8abe-73b64378f2cd@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 14:08:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] phy: qcom: edp: Add DP/eDP switch for phys
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
 <ifwckc6zx3ymlyjpqyt6iqglgz2c4thianaxxups7h5ts7ikyk@m67gguvtkvzb>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <ifwckc6zx3ymlyjpqyt6iqglgz2c4thianaxxups7h5ts7ikyk@m67gguvtkvzb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA1NSBTYWx0ZWRfX2gAbgRPpew6h
 htvCF/mJzD6Usklf3nCvY1MqZjoy1r8ykCaxffa3S3nD6XpkXPIAWlIo0kstUAcpekIyjlEaONy
 hZokwGNXLC4EaUtfzfvTULFiOT94zrmI6TU8I6kJiUcLBxiGjYWxJJipMgzjT82y5JiSlVKeMF4
 Z5xz7botCZ01q0A8hZHAk94PZXDBpSlIMB5Ey6xvi4b3pXe6QenL2gshk5JW55lj1ASTQdpfZha
 4mpBc4Jja18DDo4PTMIV0DeKoZj0zclBMiM3qsuNVX/u0krGfc3UJWwvpGDwePS+qhFeTACvWzs
 jixs4RCeOcT0UMMwIz2f5I1SjNs8l4NRmoF2Hl0Daqxbf6i3skKp214Gwq08NdCDrhqsKF6OQV0
 g2iRZr5a/YWGFQIQ9puaWiXVbMizZhlNFiN1UjCTBn/TCQ7ox34EJCL68ubMXMkukvUrMjMeMk7
 NxAz2dzntOqLGdjW1Og==
X-Proofpoint-ORIG-GUID: hne1zQZ7IjD3u3ZPKJaC0HEYuIovmHmI
X-Proofpoint-GUID: hne1zQZ7IjD3u3ZPKJaC0HEYuIovmHmI
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69e9b754 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8 a=WyWhWuvX_BU0g5tmHqUA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230055
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,infradead.org:url,infradead.org:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240424-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E0B3444D6B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/23/2026 1:24 AM, Dmitry Baryshkov wrote:
> On Wed, Apr 22, 2026 at 02:01:50PM +0800, Yongxing Mou wrote:
>> Currently the PHY selects the DP/eDP configuration tables in a fixed way,
>> choosing the table when enable. This driver has known issues:
>> 1. The selected table does not match the actual platform mode.
>> 2. It cannot support both modes at the same time.
>>
>> As discussed here[1], this series:
>> 1. Cleans up duplicated and incorrect tables based on the HPG.
>> 2. Fixes the LDO programming error in eDP mode.
>> 3. Adds DP/eDP mode switching support.
>>
>> Note: x1e80100/sa8775p/sc7280/SC8280XP have been tested, while
> 
> Tested with eDP or with mini-DP too?
> 
x1e80100 eDP (hamoa-evk)
sa8775p DP(full-size)
sc7280 (rb3, mini-DP)
sorry for sa8775p mini-DP... i don't have the hardware to test.
>> glymur/sc8180x have not been tested.
>>
>> [1] https://lore.kernel.org/all/20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com/
>>
>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>> ---
>> Changes in v4:
>> - Splite changes.[Dmitry]
>> - Add sc8180x tables in a single chagne.[Dmitry][Konrad]
>> - Link to v3: https://lore.kernel.org/r/20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com
>>
>> Changes in v3:
>> - Rebase to next-20260224.[Dmitry]
>> - Only enable TX1 LDO when lane counts > 2.[Konrad]
>> - Link to v2: https://lore.kernel.org/all/20260213-edp_phy-v2-0-43c40976435e@oss.qualcomm.com/
>>
>> Changes in v2:
>> - Combine the third patch with the first one.[Dmitry]
>> - Fix code formatting issues.[Konrad][Dmitry]
>> - Update the commit message description.[Dmitry][Konrad]
>> - Fix kodiak swing/pre_emp table values.[Konrad]
>>
>> ---
>> Yongxing Mou (5):
>>        phy: qcom: edp: Unify generic DP/eDP swing and pre-emphasis tables
>>        phy: qcom: edp: Add eDP/DP mode switch support
>>        phy: qcom: edp: Add SC7280/SC8180X swing/pre-emphasis tables
>>        phy: qcom: edp: Fix AUX_CFG8 programming for DP mode
>>        phy: qcom: edp: Add PHY-specific LDO config for eDP low vdiff
>>
>>   drivers/phy/qualcomm/phy-qcom-edp.c | 221 ++++++++++++++++++++++++++++--------
>>   1 file changed, 173 insertions(+), 48 deletions(-)
>> ---
>> base-commit: bee6ea30c48788e18348309f891ed8afbf7702ac
>> change-id: 20260205-edp_phy-1eca3ed074c0
>>
>> Best regards,
>> -- 
>> Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>
>>
>> -- 
>> linux-phy mailing list
>> linux-phy@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/linux-phy
> 


