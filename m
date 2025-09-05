Return-Path: <stable+bounces-177853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A7BB45E95
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 18:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87ABF16B70B
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7A5309EE7;
	Fri,  5 Sep 2025 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PdAciHQ2"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CA12FB087
	for <Stable@vger.kernel.org>; Fri,  5 Sep 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090868; cv=none; b=eG3pvlIUk7rdetr/D7aAuY1KK6m6FV7ZCf9r70sc7HuLF0+bhW7n9sPuWZ2iVSgEUwHDoIoqTWpUlk969GKXMX3T9SZ3yCtBwfaN+BvlV178qt+8wxiBRfkU/A1GLFWs/SsAO7nZabWia8/04VPtrKm581eC7pkJROkJJ2Jc6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090868; c=relaxed/simple;
	bh=TkfY89RKRXEALwgB2aNVJLpg692JYnKY4FfUhrmhjUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVWG2ds3qHbdVb/jGC89bKAQFNo1nEV9Vn/Tty8wngIkmYbE5u+/SMf5Oni1oSVMgMpE1MPjaThdiwsf3XaOihQxDgKKuiYJtY2iFzY9Ezno5zSbIPkJBEUZoIYxFaSh+sfEQ97+VfQh+YAVj4R2LWm5HsYj+NSRpXmZM27+kb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PdAciHQ2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585GaIAA012043
	for <Stable@vger.kernel.org>; Fri, 5 Sep 2025 16:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UUdgNg/39urdaUGy5tuNL+v9wjA5hMimn7UR8IzRX/Q=; b=PdAciHQ2LJAlN3lz
	mhfyemdXnUhAmCxtsYv54lZFu/YK+QqDMz9kGCQys1dPqVHD/b2muwcqnzvC4RaO
	nkW0KBEzjPRZ7o8UL/I/qrEQCG4soGkbi6y3GUpCev3WtEY//5mc32yEInyBXeFe
	hcjDPgfoaHE/j92vUC1xCyRznE7QMlR/3VDlzq/dsowpB4D0/Ojf6phUR90hGkSy
	q/1w+aQ0L5hGwBSU4E7SFZEiZq++32A/Ys+XvNs0A+Kzi48Vs11OCKA8+ZTeDHyg
	WV0KqaxhM/YrHWwFqbkZfYeJ/KjBl1/E+b8intGJlkacHB1gEEhBcm6hI/9ENAWx
	47RKIA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj858f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Fri, 05 Sep 2025 16:47:46 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70fa9206690so54146526d6.0
        for <Stable@vger.kernel.org>; Fri, 05 Sep 2025 09:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757090865; x=1757695665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUdgNg/39urdaUGy5tuNL+v9wjA5hMimn7UR8IzRX/Q=;
        b=Bug9fmUrLHN/NAvp0rpeZZ9rKPy917q5mp+tUzmaNUUTBWhYoj9H7c0CthF3UQskWU
         Ml7xmiZ/y7kx9zpX8KhKdc2wv5tI7ALhjX3eZcP2R6ELAgOteCGoU9AOLXACKKTD/3uV
         iNoQ5h/0iVinf9g0b9FWCh1+xnoPX397LGFL1a8wcfxQXTlT8pkbuJDgMTiR2lQU8ecb
         MgYlGtKjF9EEhrXJZ7FdBJRRpJ+2QYYpLYI69Tl09Udgw1jGUah1LrpcltrJqQk0mocB
         wtPYGlX/uvHpGOcz/mmv9HYyyxkDuiJbCdXfTVQxFRXiPJ3NE4JNi3x5gYdGCmxUVjn+
         FnrA==
X-Forwarded-Encrypted: i=1; AJvYcCXARlFBS9MXliDKA9ru/5wB91uGtep0eM/aC7VapOZCktMnUbTlPpCSbw2qcy1jZ9z+DzrmVdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Jd1CdEVQo3j//+jPi1mgtu5BkOpOJO+TAixIK1jxNAN7pn/C
	15TPwGY6agC9JPj50ccvdwxY39qjGb12kFQD3SMiwfbCnTPveHgW9dHACfcAeF+TPaRY13EjcRk
	8lnamGvPwkS36GdoE5qFp4y7IeZNj3EmJARy5EcS3/qy9R/FYMHQdGhjNBnk=
X-Gm-Gg: ASbGncsLrMOx4i3aurgJUwwTOQMfJHxInzRjAg1vrWvbQ6u+Rrl6LRw5PqZBKImlTsK
	Pm772wW4/teSlpFI5CE+V8AGabrJGaPui4JhV7GsgPJuFEvrsp5LwqxIM8QaSp+NllL/CdeOMHs
	8bg3uV+98dyPWlnuVggO6nj5oT4cKzZN+Vwg2F4lpCzC7quUwbR0NnCjWMa0/wTbNg6w3K4yaNN
	mbsMybMN/pAP5Slo6BmV+cX+gSXD+Kuqwdcw+Xja85FzXLw7i5viIP0kEUjneVfQ8Eeocx8gHGA
	7lSUNy4aAoEytaaCNwc0UcwBNVrJE2hdg3ZrJoVh3cEB9ElYifEdpUaGYAUtQ0zVqxA=
X-Received: by 2002:ad4:5fc5:0:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-72bbf3fb0b1mr43965626d6.9.1757090864941;
        Fri, 05 Sep 2025 09:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ8+8+MxEUmtiGkpVpKbOO3CIojnpVHP4pNFKV12I5SozNXXmspK50f6RKTZrWEioefG8OdQ==
X-Received: by 2002:ad4:5fc5:0:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-72bbf3fb0b1mr43965196d6.9.1757090864286;
        Fri, 05 Sep 2025 09:47:44 -0700 (PDT)
Received: from [192.168.68.119] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3d66b013b7dsm20987137f8f.28.2025.09.05.09.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 09:47:43 -0700 (PDT)
Message-ID: <08afe342-e108-4f0c-9903-fb4df4eb860e@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 17:47:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] ASoC: codecs: wcd937x: set the comp soundwire
 port correctly
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org,
        srini@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski@linaro.org, linux-sound@vger.kernel.org,
        Stable@vger.kernel.org
References: <20250905154430.12268-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250905154430.12268-2-srinivas.kandagatla@oss.qualcomm.com>
 <as3wxoths3rgy2qpbqwyys6zydhjo3lbueu7ibrwbinxt3sffw@wyprroihsjs7>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <as3wxoths3rgy2qpbqwyys6zydhjo3lbueu7ibrwbinxt3sffw@wyprroihsjs7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfXx9CqE8qoZcUP
 Jp54xgPKAoTIegejKC66EwvVk8pLMKLy7l/dzGGQwLfr6CO285TJE50MCSl2Le7kGV+jBXXQoUL
 JFq8ubwDibhjFWxxb4aAjc+Ei0Xw/Pb6EGuK+7g3mG37R4VMoJCJsWPOBF/mHcoVTMXDOXvUelS
 hYEQKGz5UoZ37mqfLKEmwGUycGgyd+vUoYoSYd/0kVTpMDVCNAlVyQ/F38NmLqL21vcXDpIBmu2
 UzGxs2o4Bx0lhr0mUYeYHKuW+c9ide6vt2HhxYjUR1v4FXY1HPKakHNnXuTbftqJsSEtsDzhcbz
 H1HU++K1pu/O7IhqJPIKOZbxtzNVc98Lw8hZcOKOhONtjz9LddEx8XLlz5mo7KQ9Wobf828V8ap
 F+lQKUI/
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68bb1432 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=OWw5mONqTAKyzQI3keYA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: FL4WWTmHMU892sOmE2yTF-PGNDU-YJNc
X-Proofpoint-ORIG-GUID: FL4WWTmHMU892sOmE2yTF-PGNDU-YJNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/5/25 5:14 PM, Dmitry Baryshkov wrote:
> On Fri, Sep 05, 2025 at 04:44:19PM +0100, Srinivas Kandagatla wrote:
>> For some reason we endup with setting soundwire port for
>> HPHL_COMP and HPHR_COMP as zero, this can potentially result
>> in a memory corruption due to accessing and setting -1 th element of
>> port_map array.
> 
> Nit: if passing 0 here might result in a memory corrution, then
> corresponding code should be fixed to warn loudly and ignore that 0.

Agreed, This is something that should be fixed at source am on it.

--srini

> 
>>
>> Fixes: 82be8c62a38c ("ASoC: codecs: wcd937x: add basic controls")
>> Cc: <Stable@vger.kernel.org>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  sound/soc/codecs/wcd937x.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
>> index 3b0a8cc314e0..de2dff3c56d3 100644
>> --- a/sound/soc/codecs/wcd937x.c
>> +++ b/sound/soc/codecs/wcd937x.c
>> @@ -2046,9 +2046,9 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
>>  	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
>>  		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
>>  
>> -	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
>> +	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD937X_COMP_L, 0, 1, 0,
>>  		       wcd937x_get_compander, wcd937x_set_compander),
>> -	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
>> +	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD937X_COMP_R, 1, 1, 0,
>>  		       wcd937x_get_compander, wcd937x_set_compander),
>>  
>>  	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
>> -- 
>> 2.50.0
>>
> 


