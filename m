Return-Path: <stable+bounces-172923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CECDFB3575D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 10:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 742D02A2141
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACCD2FC86B;
	Tue, 26 Aug 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k6Q/yNoJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185AF2F90C9
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197608; cv=none; b=ueDm4d9HzMJsOLdSPCEY8wrPwYNqZ7vKz6Ni1f7Ynw61hOFuiGSVV5zle0xr8BTukgqsxF+OB7b+Ydjswcq0WRY6b+Y/Yuw83vMJC05/mT5la7C2TOErSJJXW8UkHnj21iMYPFFvAoRhsKY3TvQ159cZB9o9esF2zEOvvSTLwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197608; c=relaxed/simple;
	bh=l0kbiIGF1pDSwWfvhUdw7e1i+RQ9T4G2DNY6m3SB5ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ch+t6ToPEeYvGgwDL04Eit/sPyCvTGdPJ9mjFzuFTWoJ6qQ6yjoKWru6LSSvtKLn4qAmsB75632zxw7MxMw8h/eTZAeAWPhawD8jbBeyAcKlIA5L2ER5vRyDMGVOLQ8IDpMuV3x1IJWi4PKWKehSpR0WqnGPgth+pf1RluaKfG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k6Q/yNoJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q5l7bf026177
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 08:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ZzBwPQpsFm5dOpqRIWUvHHP01zFw0ebgHPUha5E/DY=; b=k6Q/yNoJIikDIO/9
	5ZhlsK16bE9KEph72O3PEOvWqU0nt4xcUl4N+XIYuJUfaJy3CZboulsq8Pk98i/N
	8OZRUfbpIDYQVlGDDhHTtVyZFjCodvmOOgYp/BvSOMzAACIZVWx4fkrT77WYqkQd
	vZ6EJ2kpOIl/mseEMvI2Q4E4NLz1Qop0y0LMFTwHcqO9ThnjUxQaH1bluaYE1NXh
	cqG7PGa4bz0sDPpOxXcSX6a2DyUda6lFBsQeh5DQ408FU+2MKP9Aon8roI3m6k6a
	1zim5/VsW5m8+3Akx+V0Pj5juxCzvv35WUn7YB9MroT2U/vp0xGaiD4pH5iWahJc
	we4p9g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xfg1wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 08:40:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-244582bc5e4so66806345ad.2
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 01:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756197604; x=1756802404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZzBwPQpsFm5dOpqRIWUvHHP01zFw0ebgHPUha5E/DY=;
        b=BcAqFx7bcR4D1IDHwTa6yOT/abKRSFnaVU5Ye8f4UfuD6aQV0gdJhWCrftpFk8e6HT
         df/Mo4pm6XFPCsZ9q5HL3N2F+LS/PR7ox49PrPwQvWG0HXy6WV/t07aNYq3qIri7Th8p
         nez/17XtO4yXTLvyEwX5PsKapN+tyndRtfhHGb73mustpwr25Oqb2oGC9/UiP8Sntjkv
         YpL7a4tS6+PDJ6TEx/GDbIfxm+skIUmTYcz49Wos+Ue5md6BRX3ezYusAtoLyiu0jZ9j
         hN/6KIwVVGSilFN/NXS1FHnhcrU+Km7R41ZfwopfDBt29yLYwadPnbekNAyWCARpIML5
         IdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpJ0bznrDKY47/IH+16cku1N+qLtrzQornjt+vVphyyta9g/U3oDBH7zQ+96ik+PqC64byGig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51Pmv67Av3SF88pGfN8GLiPcMagpMSf65yus+F2ooDSE1vOmU
	CLfQ8/3tEQBzm6KgZ6n1+LsFHFzybRwrDPT1uE3WRtC6Xj7yf5f15MeGO2qNup3Q2sos0seSXI8
	boe3RmOz5IiMIn2EDcZ/QWssPPfuZC2kSMUpq8TvLFsdv0mO25XltvODUt0s=
X-Gm-Gg: ASbGncsWmhl2hjcTkuvnbwcsBUFJ2Xy4t/JScS9vyF2yR5dzLmfiwKuGH/t8SbxuGrG
	NU3qBAkBUYlA+0S9AJubuDOaWj3a8NnbjQikN4fv5a5X+St6ytWDJQnN68ZOSYtB5KA6gVl4sEj
	H2aQEr36VRYUafGezJucQpkkOMUH/tnUVlHKs6+BhPT015cSd1NAah9HOorM7goFiRmiUGaSIkG
	w/OX7xZQHO6oCqHeAZDplQCH8g4lcuAtxnHHazV+7+Ct1GAWSFiIig9VHac0m4ges23C2aLPlrp
	44zSym77BUvS6MdYipCEQMfb8AefRA9GUVken2UR4HeGc6e9JdOfsxj0E0KJu0jNVodvDHsK+O9
	lGDhDJrGR
X-Received: by 2002:a17:903:37c4:b0:246:76da:80ea with SMTP id d9443c01a7336-24676da82b5mr136669405ad.30.1756197604125;
        Tue, 26 Aug 2025 01:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFps5spYMgMSBOykW3IsGvhVvZ5qGTh7lw6hM84N5G9hXec38uZg+X3bGMa48Hor3TRcNwCfw==
X-Received: by 2002:a17:903:37c4:b0:246:76da:80ea with SMTP id d9443c01a7336-24676da82b5mr136669095ad.30.1756197603599;
        Tue, 26 Aug 2025 01:40:03 -0700 (PDT)
Received: from [10.151.37.217] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688645e1sm89184635ad.79.2025.08.26.01.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 01:40:03 -0700 (PDT)
Message-ID: <8753d857-5d72-493b-8c39-8caa84e0ba16@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 14:09:58 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] phy: qcom-qmp-usb: fix NULL pointer dereference in PM
 callbacks
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        stable@vger.kernel.org
References: <20250825-qmp-null-deref-on-pm-v1-0-bbd3ca330849@oss.qualcomm.com>
 <20250825-qmp-null-deref-on-pm-v1-1-bbd3ca330849@oss.qualcomm.com>
 <sxqgnmj4bawj7n6kan7tiutb5ynhxz6cgbtpbz2xx4ixodtdw6@q2ftbnpjouvb>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <sxqgnmj4bawj7n6kan7tiutb5ynhxz6cgbtpbz2xx4ixodtdw6@q2ftbnpjouvb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX0OhlazIPxNn5
 Btk1GYSJu6CvzBLpa1gRy68pOOXaQuzdjfTGfe2u2UVmThmBWg+tC2D7X42ADFXr0lx23v8K5Xd
 ahGkdX21kFrgWhywJ8qV0b6C1Vnmz4hHLjX5AULhMs7TpfXxxc0oEvUTtmWANpZh6HDA0mDbdCE
 ZDKesWOgODYwhUU07Oy8d2oMI8RpS3vT1YyOnYvSrBkTetSADAirzWHyIxa4mCjTRXaJ0w5C7ot
 YvepPlU+1hc9dja+0tt7HkC877ueHzY9NizydQp/7xsr8p3bUSJtH1Ia731V3uf3b3zLIPnwhS/
 wyWzypVni/vVE0E+ViBzbYvY3/TfHiTARjpJ09CkE6qL0dTP0xGaOYOXrT2rZvwcMEXRVVgNH+c
 DKn2EYyn
X-Proofpoint-GUID: xS_krKdtd_gv5rvMk5P9meBhpT95Sp1k
X-Authority-Analysis: v=2.4 cv=MutS63ae c=1 sm=1 tr=0 ts=68ad72e5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=5K2DVmaXFLzhwRWEU4gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: xS_krKdtd_gv5rvMk5P9meBhpT95Sp1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033


On 8/26/2025 8:20 AM, Bjorn Andersson wrote:
> On Mon, Aug 25, 2025 at 05:22:02PM +0530, Kathiravan Thirumoorthy wrote:
>> From: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>
>> The pm ops are enabled before qmp phy create which causes
>> a NULL pointer dereference when accessing qmp->phy->init_count
>> in the qmp_usb_runtime_suspend.
>>
> How does that happen? Do we end up in the error path inbetween the
> devm_pm_runtime_enable()? Or does it happen by some other means?


qmp_usb_probe() is scheduled out per the below stack (collected from the 
RAM dump),


Stack trace of the kmodloader process:
     [<0x408def88>] __schedule+0x348/0x55c
     [<0x408df1f8>] schedule+0x5c/0x98
     [<0x4052c318>] rpm_resume+0x150/0x404
     [<0x4052d4e4>] pm_runtime_forbid+0x54/0x60
     [<0x629c47f0>] qmp_usb_probe+0x3c4/0x5d0 [phy_qcom_qmp_usb.ko]

 From the above snippet, we can see that the phy-create has not happened 
yet as the probe is still in pm_runtime_forbid() and qmp->phy is NULL. 
Meanwhile, qmp_usb_runtime_suspend() is called, causing the NULL pointer 
de-reference issue. Since the issue is not easily reproducible, we are 
not able to find out who/why the suspend was called.


>
> This would be quite useful information for others to know if they hit
> the same or just a similar problem.
>
>> So if qmp->phy is NULL, bail out early in suspend / resume callbacks
>> to avoid the NULL pointer dereference in qmp_usb_runtime_suspend and
>> qmp_usb_runtime_resume.
>>
>> Below is the stacktrace for reference:
>>
>> [<818381a0>] (qmp_usb_runtime_suspend [phy_qcom_qmp_usb]) from [<4051d1d8>] (__rpm_callback+0x3c/0x110)
>> [<4051d1d8>] (__rpm_callback) from [<4051d2fc>] (rpm_callback+0x50/0x54)
>> [<4051d2fc>] (rpm_callback) from [<4051d940>] (rpm_suspend+0x23c/0x428)
>> [<4051d940>] (rpm_suspend) from [<4051e808>] (pm_runtime_work+0x74/0x8c)
>> [<4051e808>] (pm_runtime_work) from [<401311f4>] (process_scheduled_works+0x1d0/0x2c8)
>> [<401311f4>] (process_scheduled_works) from [<40131d48>] (worker_thread+0x260/0x2e4)
>> [<40131d48>] (worker_thread) from [<40138970>] (kthread+0x118/0x12c)
>> [<40138970>] (kthread) from [<4010013c>] (ret_from_fork+0x14/0x38)
>>
>> Cc: stable@vger.kernel.org # v6.0
>> Fixes: 65753f38f530 ("phy: qcom-qmp-usb: drop multi-PHY support")
> Has this been a reproducible issue for last 3 years? I think the fixes
> makes sense in that it introduced the indirection, but when did the
> issue actually show up?


After migrating the QSDK Linux from 5.4 to 6.6, we are started seeing 
this issue randomly. We didn't had a chance to test in the other kernel 
versions.


>
> Regards,
> Bjorn
>
>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> index ed646a7e705ba3259708775ed5fedbbbada13735..cd04e8f22a0fe81b086b308d02713222aa95cae3 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-usb.c
>> @@ -1940,7 +1940,7 @@ static int __maybe_unused qmp_usb_runtime_suspend(struct device *dev)
>>   
>>   	dev_vdbg(dev, "Suspending QMP phy, mode:%d\n", qmp->mode);
>>   
>> -	if (!qmp->phy->init_count) {
>> +	if (!qmp->phy || !qmp->phy->init_count) {
>>   		dev_vdbg(dev, "PHY not initialized, bailing out\n");
>>   		return 0;
>>   	}
>> @@ -1960,7 +1960,7 @@ static int __maybe_unused qmp_usb_runtime_resume(struct device *dev)
>>   
>>   	dev_vdbg(dev, "Resuming QMP phy, mode:%d\n", qmp->mode);
>>   
>> -	if (!qmp->phy->init_count) {
>> +	if (!qmp->phy || !qmp->phy->init_count) {
>>   		dev_vdbg(dev, "PHY not initialized, bailing out\n");
>>   		return 0;
>>   	}
>>
>> -- 
>> 2.34.1
>>

