Return-Path: <stable+bounces-191712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CDFC1F5DA
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 10:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F14E24EADF0
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605D134403C;
	Thu, 30 Oct 2025 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="llXfMHF5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4bDPy1m"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999232D7F3
	for <Stable@vger.kernel.org>; Thu, 30 Oct 2025 09:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817351; cv=none; b=cJKQsVC/7fx03vBWZaRAy1POUB9JWYc5hOYF4apnWSuCAsjqX+kMh4ZfIFV6jI2vCpvWaW4AKgHHoUEPQkRmeNfxNjY0Rsr9vex8mdN8hM4B/qM5L0e/Ti3v8KZjNKsExwo0UvrTYm2x26AEvXOiAw+60I80KEnpjAT3marQsE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817351; c=relaxed/simple;
	bh=slKW9L5x+Vd9nonv1JxQPKYUvCioEofsk+O6FXGrWEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUC18dGbLVde5yP2xDyWTe5Vp92LmoifxTkNVRq0ROc5zIufWRn/H+OseU78230O2upKGNbs+gY3ZbQV706xDfTolLr+m1ntj+WgdQ2u/rUjn3gdx4VeosThIZAOutcafgL4QGA2/1eDcWIFrjRk/5wTW967cmoXYFD5Tg3S4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=llXfMHF5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N4bDPy1m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7NMfm1599075
	for <Stable@vger.kernel.org>; Thu, 30 Oct 2025 09:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J5/Jxy6FXaPiBQjK1w8+WRc0ckZ+y5lc27V0KfPeyZo=; b=llXfMHF53jrUKs9Y
	rpYYL+GoyBt5fZp1tqfiR2y0mJiZ0y9KbVxny3EgyYPMSsfEh/G6cUFq2VmbIFnN
	kKQfTo4c/sR7ux2eRLdU8S91RNcGDOwTjfDPSnix/8jW9dLqgPt2KJSb+YpL2QTe
	xOY6B0yJg++b8H1vNWCgQm/bQfkHRDyEHdSDulGgy+TXSOKdTaSlEyRcXac46Ojj
	f4FN7FVn1flWnCOCoq0SGX9KcG4wBFOO8SMqr+N53bgL6mPogjg0FWqfgsxGNq6E
	A0svXhoXOPSyJYs/Nfxo9oNKZJSZu3aFA6YFc8BffY4uDCS7//OJY34OgeQmioDu
	y4pf6g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3ta7sykr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 30 Oct 2025 09:42:28 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e88ddf3cd0so22180621cf.3
        for <Stable@vger.kernel.org>; Thu, 30 Oct 2025 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761817348; x=1762422148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5/Jxy6FXaPiBQjK1w8+WRc0ckZ+y5lc27V0KfPeyZo=;
        b=N4bDPy1mnzwPsGFEPRV9CptsERvUXswEAG6qdxYI4koeR68mKw2gehxhL1kPyunIOh
         76Gy7PgdewPL7gD1cMJtG/lGrWCnleM3xGe1M7Hl8PAFn0Ip8yLfzXTAMm7e3TToyPkp
         JZCAkhgx/P1DJtAuE6XsMIdiPNouZqGKcMPa1L7rbq5nyTpLM5Owqi98G0KpaWzS7o+l
         loUEMt0CV2MbguQmcEw3A3inssPSuC3Cdf2ICutWiRAjRCUqW5Y8EbyLG9ZRmMll9k/3
         E2KJ5Xk5rwJDIuSnT1n47KyHClraEqnVcPMYC9h97DeipCJdaey/9uaoVup5OkFE0UWC
         vRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817348; x=1762422148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5/Jxy6FXaPiBQjK1w8+WRc0ckZ+y5lc27V0KfPeyZo=;
        b=qO1x4A61E1tLF+mwBMHL/8D5iZQrLcf7JrpipErLfjDk8wlh90vg7+V8HqrcHRyDzp
         zJuplraLpYSF+hGC+mPHhhD3Sz4y66fOyOmoqdxBNopIsVPWNSf4OMD/pEDOrwRcfwtK
         5/SdMc4WlepoCQJvTUAMKyh5Iao4rhkGdXTJRxPzwici27h/WRSrgagpDE+IsMzP3iWE
         OzPk1+pM0FusX0DX2jNTSRRhAkM0gc2stRRbgf8g6/oVWNIU8t6SOu/mcbWfJcWEjyJj
         Q4jn93HcBZxNwbgMVZ/M859ofKJ5g6Q+PKJD094FsxCYyUbu8OIdxOeYortYi2phc7Nb
         QMFw==
X-Forwarded-Encrypted: i=1; AJvYcCVr1EqY8f0P5SRhFABCOTWN2A1sQo37nfNl5Go7xLwuJf6sTdUGoLdRG6OIws5ZtYwPvysDWpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywGZTKMON1dSxvpltPIACy4pwC5pM4iDFaf7Kp6ljr7PGUZia4
	qG1akRWA4+pEA6UFIRAIzQgca/RO4HKoKZCss8QcHwxUDXwj90hpAZ99qHuGSb7IU1HOjOeJy+f
	dmXVcBUOa68LeaWFVo+3MzGa4G6MUBHxDal+Nf6X3ASMhftRtcRJCSIO/EAE=
X-Gm-Gg: ASbGncsfFV9AD3fsWCog2Zk/+x9prf+VZUSQQfyeCPtCCGK1NtvvX5v9UpHyYYuVziM
	7W+rOOJqIg0PJDB/8+hrEUbe1YU50QU2g8ZCbP95rTERKtfhUrvWIBmAnCYFRr8eP/1HNUIQv0Y
	mIhM3N3dMK84OsjWOWBx5jUbLoZb0fGJbNh37crEPNVHNtl0iUuRGCcZ6ZX8LGp1gJmlPP8IpOi
	IH2p9Pe3RC2LT+napEEgL/ueapSpIkg2db4tfcfeHsQWNNlJkoihNjgnAUup01GTMpEXEzPqHv3
	UKwVgJvTrRSRqZMlceLJsusL2V2p1xwqUgZS/wiuGPGnvgN9d8x2ReB011SxidR51Kw7TeEgzA6
	+f4IZtZSzFvU1QSXhXHSC6GBHtg==
X-Received: by 2002:ac8:59c3:0:b0:4ec:f654:8522 with SMTP id d75a77b69052e-4ed22216b99mr34207421cf.38.1761817347657;
        Thu, 30 Oct 2025 02:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/8qp23qWFyHDBD7eZ1LN+vTcJ3LO+5eIrwfuCD9HQ3Q5hCF4435OigRG3baPksTJWu7zEGg==
X-Received: by 2002:ac8:59c3:0:b0:4ec:f654:8522 with SMTP id d75a77b69052e-4ed22216b99mr34207121cf.38.1761817347050;
        Thu, 30 Oct 2025 02:42:27 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429952b7b2dsm30920542f8f.2.2025.10.30.02.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 02:42:26 -0700 (PDT)
Message-ID: <82beffa9-d956-4820-812c-b2cd53d4a262@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 09:42:24 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] ASoC: codecs: lpass-tx-macro: fix SM6115 support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        Stable@vger.kernel.org
References: <20251029160101.423209-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251029160101.423209-2-srinivas.kandagatla@oss.qualcomm.com>
 <312b62d9-c95e-4364-b7e8-55ebb82fd104@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <312b62d9-c95e-4364-b7e8-55ebb82fd104@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aaVsXBot c=1 sm=1 tr=0 ts=69033304 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=2Ovg_PPPbudXyttJYDwA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 7X5YV2Wftsv9zOz74dv8sjnoEFp8jAyI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3OSBTYWx0ZWRfX24vgsXbU/Yb9
 bu6yx6TciEjEqtPHnp61B7/ACRqfyg2FGbTiO248U1vsGENJe2/UajMOqlxtc4Ulfy4RQIrWhJD
 CfBz+ar9HmpLK/qH8UynZPs8huCXu5Lr1PXFAhsVoEjRRJDewYmbru2ghTippe+MVG6g8pKVozv
 FzKubE41tJrR9GuU1BtP6Bi4Is/adPaeoRYhxR68ZXAKWLSCrCwFKmKXXKucPWiuE+cFXE++gKC
 yxVBND6It/S6w/Hh+JObcCvTAPof/qHDwYH0JhrxGeYcAqJEdYdHR+tUvIQUs0jxdFCHi5Wm0NP
 hyHifIijnloYW/5ZfqhtSrQCdgu1Ukae0O2gQdS95WmAACvmG5Iu9TbsrRPIoV+qKjdBWoyvJF6
 rGQBX1U1LUug62tWYnfcPRK9h9/czg==
X-Proofpoint-GUID: 7X5YV2Wftsv9zOz74dv8sjnoEFp8jAyI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300079



On 10/30/25 9:06 AM, Konrad Dybcio wrote:
> On 10/29/25 5:00 PM, Srinivas Kandagatla wrote:
>> SM6115 is compatible with SM8450 and SM6115 does have soundwire
>> controller in tx. For some reason we ended up with this incorrect patch.
>>
>> Fix this by removing it from the codec compatible list and let dt use
>> sm8450 as compatible codec for sm6115 SoC.
>>
>> Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
>> Cc: <Stable@vger.kernel.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  sound/soc/codecs/lpass-tx-macro.c | 12 ------------
>>  1 file changed, 12 deletions(-)
>>
>> diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
>> index 1aefd3bde818..1f8fe87b310a 100644
>> --- a/sound/soc/codecs/lpass-tx-macro.c
>> +++ b/sound/soc/codecs/lpass-tx-macro.c
>> @@ -2472,15 +2472,6 @@ static const struct tx_macro_data lpass_ver_9_2 = {
>>  	.extra_routes_num	= ARRAY_SIZE(tx_audio_map_v9_2),
>>  };
>>  
>> -static const struct tx_macro_data lpass_ver_10_sm6115 = {
>> -	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
> 
> 8450 has | LPASS_MACRO_FLAG_RESET_SWR here

sm6115 has soundwire controller on tx macro like 8450, so they are
compatible.

>> -	.ver			= LPASS_VER_10_0_0,
> 
> and the version differs (the driver behavior doesn't)
Its 9.5 on 8450 vs 10.0.1 on sm6115 both the CSR maps are identical, so
9.5 is compatible with 10.0,1


--srini

> 
> Konrad


