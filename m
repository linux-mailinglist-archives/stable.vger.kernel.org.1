Return-Path: <stable+bounces-210450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7FBD3C16B
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 09:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32CA7585FC6
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 07:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2C23ACA40;
	Tue, 20 Jan 2026 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ov4gbPkh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rgjn5N3K"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409B3B8D6A
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895778; cv=none; b=sNLChEz7EJQg5RInO+TclxA2pALeZfaONtCtcMgILoso3MYfkfNN6T2AHJzr6yQdOxGC1SpyXFG43RmtoqNWhorZXWCnF/jMtq0Y14SPnW36osiKlEaU9TAZBOVDvAob6ChWHvDXg68QUYyDzlcOyFcXG/4juO3RzlUDAGy2eik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895778; c=relaxed/simple;
	bh=A3q6+wEcVXOwNaUIOc41Dhe9Ssf7vGNyYFuZ6euRtFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOg/NoFbUmQz2EYtPA88ShydSzh7rnTMgTHYMahrAqgSBbbOsfjNnq0I3sp6Za4NyYLQo82pGHgfsnzR+zGdtA+5OF4NtWlOnuXViC6nkZTP9+KnB+oICZKXV2sOX0z0JHK8XrGkQXcb+aoBpPKyC+03bFvtxQ86Mz+2GEB+FB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ov4gbPkh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rgjn5N3K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K71fwV1408584
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 07:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AKsLovc3KARkhs/4j/9k3GVlFSpps4fzd+8+jeJ5Fh4=; b=ov4gbPkhPBvrGYXK
	9JUcYDfDzemzidbvJ6mol5gOOB3uaC1K7XuOkKAS9zJTUJIW2V/X/+Xg2kEbQSOk
	SzTUEiX4k9SVWqJJhf1RnNZHS5Z5lFHSnnUMw0xeXeAv0e6PRK546BfAgtINTPQt
	ftXbMUP1nBV1eGHNDG6DBoEUzlVv555D/GHW1LWSyv74vYy6OB8tGOw+Ub6GS8Tg
	YabxkTumRm+aUYNeQIJQl4wre8iwIkcg67gZcq0IU8yjeZaM+9YbNd0tbXnfAQHk
	MxWGZO/ZCp93aDUkjPChU6/wrt8bEs/UnjEEnNIjnhbY8Ts2MWOQ+FSze8E04xrb
	CCt4QA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bt4y2r4xh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 07:56:16 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f8c209cfbso2359941b3a.2
        for <stable@vger.kernel.org>; Mon, 19 Jan 2026 23:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768895776; x=1769500576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AKsLovc3KARkhs/4j/9k3GVlFSpps4fzd+8+jeJ5Fh4=;
        b=Rgjn5N3KkyW0PPpq2hyXs7mtM46v2bkA/1dxcwBAOvZ3JZQkQ+sW+YRb5ifrgaYXAN
         yq+LUfMyYZXeWe+v37TBGWU7rgvjgOdl2bM7l2BgVvbxsLyT+LQ8pQflm6V1tTeUByf6
         qKn6aX8hNNUWeuiFNBqLFwEyesvfy1dwe1HRg/oRYaB2lYoVmTr7k0Ui7vBvEohoUjyG
         +vOPLy5u94/BBKLgBx+aZro/LZa43MnMIHJurEbwPTUdHbZnG92iXOdHBNN8SZbOLfqC
         HS1v+TeEdgVQVtthbYZYMw4LRwhNlbKPL0kknA1n5qSTMXTUNgZU5Tl8dl5fP5ccwclp
         N4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768895776; x=1769500576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKsLovc3KARkhs/4j/9k3GVlFSpps4fzd+8+jeJ5Fh4=;
        b=WFn1o4xMG3/E8o9Lnt6c1j10dtkjT1KzKt+lUxoIEpUf9wjy9/IpMFdFnzmHOoy2NM
         iW8/OUJ5XvREtrgBEQT3gs8oD3uQgbLtXnG3VaPopkNit/Vh+385w+LOoTvmOHCq2lWF
         z2LDa+SDl6RDjT3cV901UYpN+eL/KpxHUPnONCZLYN4Iadir3Pgcn/jwTuq8VrUCrKzm
         cdGi9Ew/L7iNoIHxaPzfiYnaInHw1pN2bioCrtRNDNXw8f3LoS8GuP0QfERn0i9eQGi8
         PFlTBjiKpfyQ5GfKM5Y3LhgT/vRyw70/43Bm6to5nLCNw7TfeDRwIi/H5SzogABPWQRI
         jZew==
X-Forwarded-Encrypted: i=1; AJvYcCVfToEhMumFW8RJ4KCXRKXc+vouWMzqFn/tUUso3Arg54gVRG3poDsrexErlisLRKc+Jq25J18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzrMBahm9FywgISyATt0ZdKV1Eo6VWwYCrpspYWiAISGUYU+/t
	NFla+xmDAyEX0s+AVZhoKc6MdPDjkWPOMIgb/Z7yfuSRLa3cE5jS1paYXMUf5GuYB/wlBlOg8pL
	qm1NDRyKdh8io9ZOjM7c1dI2PJZ3zy1EXpfZFgRso2tlCT2tYko6X/3x0lsY=
X-Gm-Gg: AZuq6aKEGa9npC8d/E4vfAbO5yYOmH1FdbaSEzpQ631pkhSwG5DzT25j12lKI3suKDC
	2GpXf5y6+8oGkCwH752GcoHe6Hvd6lFagPP+DWcC/I6t3i6ZNjCzwyIpGs9KgwEumEM8ERwX/hS
	KB6/HbHKFASKfKPm/g7g7o9KDe21OxuLewRUZ5sbZdubeTyrc8D6HFcVGhWPiYBflfCy2p7BrF6
	F6CS5v0Q4d52f4lbZ+zfhfTvDhllR0knzSWvTUCRYAfvDB0+84xdXk6a43yH9znMk0WTZ6oQ0xy
	ztMqSH4cb6Kkg2xFm6LhUA7NrjOZrGiBSddDN7ugqKFpF9lpPqbtC3qESDmrCIbGL3e6fMGvjp3
	eMviGOYzoHkr/7Qt/yTjSv2BXccVdUF7Q2TtAsy1QysH3JdugpHMa8cjpI+5tA6Jxd0DO8cqZYN
	SJbHRN
X-Received: by 2002:a05:6a00:3a0d:b0:81f:4346:6870 with SMTP id d2e1a72fcca58-81f9fce68ccmr13367831b3a.28.1768895775874;
        Mon, 19 Jan 2026 23:56:15 -0800 (PST)
X-Received: by 2002:a05:6a00:3a0d:b0:81f:4346:6870 with SMTP id d2e1a72fcca58-81f9fce68ccmr13367810b3a.28.1768895775371;
        Mon, 19 Jan 2026 23:56:15 -0800 (PST)
Received: from [10.133.33.57] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa1291135sm11142535b3a.47.2026.01.19.23.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 23:56:15 -0800 (PST)
Message-ID: <8c63a77c-1676-461a-bfcf-55202e723718@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 15:56:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/msm/dp: Correct LeMans/Monaco DP phy
 Swing/Emphasis setting
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com>
 <47skckagggxijdhinmmibtrd3dydixtj6pccrgjwyczs7bj2te@2rq2iprmzvyf>
 <749e716e-a6cb-4adb-8ffc-0d6f4c6d56c4@oss.qualcomm.com>
 <5ytgf7saw6yfvqzqmy4gtjygo4cx52vomi7mwswc7hgedzz3rb@eiqxiqs2cjmb>
Content-Language: en-US
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
In-Reply-To: <5ytgf7saw6yfvqzqmy4gtjygo4cx52vomi7mwswc7hgedzz3rb@eiqxiqs2cjmb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA2NSBTYWx0ZWRfX+7q9+WtOnsKm
 yRCcb9BGv55TD9mRGXfL3WwR6IoTJxy1TZr4c9A7kTnCD27W2mWMcc2Tw/Qcf37ckzNth9p9knw
 i88opuPPozaWVwRydK8/iS1ZDkYqrH+IJxZKKnDQgZ9mzwLPPoB55rf8/wZJHnYoVNTcn6PWfTk
 1HlU7BUGvJTo3UtnoaW0uCmRZVSenb3BPCVc5hrz6rNt9KWHvTG9qHTqznXhlfu58gk09x5xDPZ
 k5N6toBrmCKW+2/PD05/LYTswdQzuqYPVJi6Ufz4gPKsM/DpCWNyLXPB8OsR4cRtNu8iI9srG+P
 4QuPN/kXGXiufaHomdYb00C7xEINv97V8LHIUN1PDQUof6C0ic0aIRckAli5HZW9cKv5d9r2ona
 vhrep50Qv/8HIpYdcgJQeFrJiY07iGfv4dz6AA7E0BhB5RTRhx+f/J/hUses+0IDUHIeZiTQvS3
 GOpM2L2ZlpuqJKgKGlg==
X-Authority-Analysis: v=2.4 cv=Ds1bOW/+ c=1 sm=1 tr=0 ts=696f3520 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JfrnYn6hAAAA:8
 a=TcOkVFdsAhurElaN6YEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: nBC4BvEjzm1vPpvdWAISFYJyx0WeStj3
X-Proofpoint-ORIG-GUID: nBC4BvEjzm1vPpvdWAISFYJyx0WeStj3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601200065



On 1/20/2026 11:12 AM, Dmitry Baryshkov wrote:
> On Tue, Jan 20, 2026 at 10:43:46AM +0800, Yongxing Mou wrote:
>>
>>
>> On 1/19/2026 8:55 PM, Dmitry Baryshkov wrote:
>>> On Mon, Jan 19, 2026 at 08:37:20PM +0800, Yongxing Mou wrote:
>>>> Currently, the LeMans/Monaco devices and their derivative platforms
>>>> operate in DP mode rather than eDP mode. Per the PHY HPG, the Swing and
>>>> Emphasis settings need to be corrected to the proper values.
>>>
>>> No, they need to be configured dynamically. I wrote earlier that the
>>> driver needs refactoring.
>>>
>> Hi, Dmitry. I plan to submit them in this order: this patch → LDO patch →
>> refactor.
>> Since the refactor involves more platforms and may take some time, I’d like
>> to get this patch merged first.
> 
> This patch is incorrect. It trades working on some platforms (DP) vs
> working of someo ther platforms (eDP). I don't think it is a proper fix
> for any problem.
> 
Got it.. will post refactor series.
>>>>
>>>> This will help achieve successful link training on some dongles.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: 3f12bf16213c ("phy: qcom: edp: Add support for eDP PHY on SA8775P")
>>>> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
>>>> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
>>>> ---
>>>> Changes in v2:
>>>> - Separate the LDO change out.[Konrad][Dmitry]
>>>> - Modify the commit message.[Dmitry]
>>>> - Link to v1: https://lore.kernel.org/r/20260109-klm_dpphy-v1-1-a6b6abe382de@oss.qualcomm.com
>>>> ---
>>>>    drivers/phy/qualcomm/phy-qcom-edp.c | 23 ++++++++++++++++++++++-
>>>>    1 file changed, 22 insertions(+), 1 deletion(-)
>>>>
>>>
>>
>>
>> -- 
>> linux-phy mailing list
>> linux-phy@lists.infradead.org
>> https://lists.infradead.org/mailman/listinfo/linux-phy
> 


