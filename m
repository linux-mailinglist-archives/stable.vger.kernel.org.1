Return-Path: <stable+bounces-204478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AB5CEEB54
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 14:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1F3B300E175
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E716531281C;
	Fri,  2 Jan 2026 13:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fhpC6dug";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WlK1gP2w"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775E207A32
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767362285; cv=none; b=TFsZwWilVv2xtvob5iwBQSaanGixcEpyihlSPdJ2S7kvZ17IsJFJAcMZDJXizSCVY/gDgL5ZwixE67gG4JWdYm1WjgbeKyH5V2ri72N85noYRpZkKcyUaNoyhWTMus9ysSVKLTV9f9/ugsfXIIzwdLtZyAzMzIJ2KGfwavtSjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767362285; c=relaxed/simple;
	bh=1sV8MipC1LWZdrArTgWJG14vnKiaAJ4m/AHNLobfCKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkOfOtlSi0ZPCaPjsq4+S6PPwRrSqhlwmA66ZUX4zuoI3Ej+lGSZUg6uel6DoX/pN0pMH+j/7ODfXPPn5OMUWksBiRP68BkAuvjj5BhiGNFJiuQpMwdvnxNIYZGRbIJdBJhJ/RgubIQsCfD2rGffBf1Zi3dCmP9SHoa3W3WtnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fhpC6dug; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WlK1gP2w; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602Bnj7L1094766
	for <stable@vger.kernel.org>; Fri, 2 Jan 2026 13:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SXZonBfFrLlWUInQu9VdJssXOsC/CpSwdoDF+7WOCOo=; b=fhpC6dug0bQrpgy2
	8862cfilctnWJ2fwxDGm4JVnWUyVIDo1jBvIhZvwS9WbyjLRAjhl4l/NvRm5zjYs
	jnTl6ruMe7Fq0C9jiONvjwbun0MR5QWOa2VOitaQMoHx+I4SuBZ1WH8HitqmENuw
	g1QTgynYQrLTOx99YMtnBVh7ajuj+9S8fydjNxBDRAg12ziv7xdCYrq2QWEJkRJ7
	aYsYKbGU0G4PwjoCyxlnpuV/irz4m0BALm7Cb7/bviGVfAM508hDsKlmwHvSH+PV
	7iE1B0t2I0li5bOt/1OwX28iNwGebNWsZdEGaOZowYFvrk5wGX0y+tBk+siqhM7u
	W3mK/w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bedg406wa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 02 Jan 2026 13:58:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4f1e17aa706so72760891cf.2
        for <stable@vger.kernel.org>; Fri, 02 Jan 2026 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767362282; x=1767967082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SXZonBfFrLlWUInQu9VdJssXOsC/CpSwdoDF+7WOCOo=;
        b=WlK1gP2wXmrT/looXthQ+YhEfZKN6g1G0nZDi7NsDuyM+TpIKLL48aJS5hmrp0Kzcw
         r/YvHLSfhFS+KhUG95LPZcgonv5C2lweDbYrExWBImvNAfoY4WV4E5LYpx4z/lew22Oj
         +IM0HKjSANpnKxgP/otE5UDz/9JYdcJ84OW2faoQ7naqepXPRNbciamFUEIPU38kTjSG
         BSGCJzJfwQljVDILCXKzrJTdWmqIqKnzmi8SFXPLOeXU3UzUr59iSGCsa+ruV/Sa4Nd0
         XfGCZiZWuH5pLaLptHn1bIHkb67ywe2xkxtX7FhLSydljz8QRAmUNGxsgQdGUVisAbXb
         reKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767362282; x=1767967082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXZonBfFrLlWUInQu9VdJssXOsC/CpSwdoDF+7WOCOo=;
        b=pASUupOOkW1Cg9p0ImkKdT+fsXqBgLSE5JJ/f+G65L8VapsmJFbLhaRpe9IOCherjA
         mtGnyMTa2DgiScFAwDj9HXQjEFNO2uxjnpeUidcd/xiMiWR+ieLoVFqd7U+jSqD9MHw4
         hc6hmLm4I8mMnx8hl/noQSmc7ggi6N5QX8WmYLiRv+vzSYVy2GIojIMTR+k1gNfxRqk4
         HgMIqDZtzmaIBBUuOpcxW4ZzodQ02GgAoPdzUjQDxVHQypXT4n5cvWp3k+1qnExEr6xA
         2TG1DYjlgM0WLODv5MF9Eh5+JEHzu2dQNkEEXsNBV6VtD9ePJvyvqgszJgffl3gPQnoR
         Y0mA==
X-Forwarded-Encrypted: i=1; AJvYcCVFevm70zw7JUNaAp6ViwWI1s0+CX9EooTjUeIpexpeWF8w90O3tgMJR+WUU3JtvgYDRItVsEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKynrtLK8xtJ2zvy3FhAEpMtt35BGVBLGcMMWZsvUiNs7+9ppQ
	Ick02vj0dogaXuEandI/0fi3VljChvp7h8QFWq06VeyfGPfmH4uVpjF+4J1TkWkUYHBAybolsxw
	3PbIqAWABKXpS5/QoCpqwPIRnDan3KmXyuW89AMMbfbLGQ1R5MJ7J5MhbHYc=
X-Gm-Gg: AY/fxX6Y2Ng0JObjRUmRkZGvxHYjveb0vmWKtF1GR4s8Xvdt6YT7BVxf5g1an5B7ouP
	QzQaQI+3GGQNifa3sny9yXLTB4iXe+nnC0xuDBa7eQHmpLYimuQm1m49j7BoTwOCGait6djHTw6
	QABYKePv2mXftQcR9w3CLZFO8WGEqyIjNvFfbfLTYTehY1tTZczGwI3NumxkNj6cTkatlDrV/NB
	Rxu4kHFSeSslob3QWarXDoEmcVP+iHhcY8CyNLsUy+vXnObMb1R0abin8F5M+rez1UEVNRo7mkK
	3W0vIbuFRFGeXnrdI4zgJyheM0+9vb+8faXqou+Xm3KucjZu9DQUopx0PFUnBChXiBNR/SbaluB
	emA/bGXv9JRJwKT2RHsRsz0SNJB2gCe/b7R9lB6o7XdswR3VETySONe54h8d/NQ9jrw==
X-Received: by 2002:ac8:66c7:0:b0:4f4:b373:ebf with SMTP id d75a77b69052e-4f4b3730f72mr333863601cf.8.1767362282319;
        Fri, 02 Jan 2026 05:58:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7Y/WQ8VpeHWMYOtwRnUu1StCNtd8fnIuIk1RT/81Hf/IE5HzOME5xziQdtKVDZLPfJJayvA==
X-Received: by 2002:ac8:66c7:0:b0:4f4:b373:ebf with SMTP id d75a77b69052e-4f4b3730f72mr333863211cf.8.1767362281838;
        Fri, 02 Jan 2026 05:58:01 -0800 (PST)
Received: from [192.168.119.72] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b9ef904bcsm43228684a12.22.2026.01.02.05.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 05:58:01 -0800 (PST)
Message-ID: <e917e98a-4ff3-45b8-87a0-fe0d6823ac2e@oss.qualcomm.com>
Date: Fri, 2 Jan 2026 14:57:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] clk: qcom: gcc: Do not turn off PCIe GDSCs during
 gdsc_disable()
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        manivannan.sadhasivam@oss.qualcomm.com, stable@vger.kernel.org
References: <20260102-pci_gdsc_fix-v1-0-b17ed3d175bc@oss.qualcomm.com>
 <a42f963f-a869-4789-a353-e574ba22eca8@oss.qualcomm.com>
 <edca97aa-429e-4a6b-95a0-2a6dfe510ef2@oss.qualcomm.com>
 <500313f1-51fd-450e-877e-e4626b7652bc@oss.qualcomm.com>
 <4d61e8b3-0d40-4b78-9f40-a68b05284a3d@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4d61e8b3-0d40-4b78-9f40-a68b05284a3d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aN4Yvy1-Jtp9Z2Jj4ITODvfGcto4Ll2k
X-Authority-Analysis: v=2.4 cv=IssTsb/g c=1 sm=1 tr=0 ts=6957ceea cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=LvUvCMLUZ1wwccowk60A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: aN4Yvy1-Jtp9Z2Jj4ITODvfGcto4Ll2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDEyMiBTYWx0ZWRfX/3Co3m8Dx/uO
 DwL8dlgnA4kRvfxYHoPY1A+v4qhH4HjZccW2SPdnq33iQDqMWtp3gyG9d9fySAjPad2Lf2NGcTj
 mUQNcDpIhzr8f0s3O4CXJnjh/qTwpSiohyD1oCN77yScXXfhIwWcBL7YT59CmX2Ord0wERjmxHs
 Y90Ysl08SqERgf/LcUQiY4bi6tF1xOY78XdfhIpFUPk2uHktMDJpMGeN6VSunfZo4DsTYdsPO2u
 EI+18IdWk1bz2ibKeCQc1OyWCxywdxisTVLOGTXW7HbaUFEOon+teoTmDMCHGIvwKDWRtmW46Ae
 f+jraBDNG1ifeS/S4P4aCswl66kNSfsbt+JH+OSERK1Ts2wUzF9EemnDGDnf9l2sVsQNv+89Os7
 C34RGtpkrNKOhAbibsbSVPctQPBhIE7w6eacMi4zfY9jtLBwwjU19qHfTakhRVtsPAkdv+Nhbqc
 ULb2D4SR5CHUZlu3UNQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020122

On 1/2/26 2:19 PM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 1/2/2026 5:09 PM, Konrad Dybcio wrote:
>> On 1/2/26 12:36 PM, Krishna Chaitanya Chundru wrote:
>>>
>>> On 1/2/2026 5:04 PM, Konrad Dybcio wrote:
>>>> On 1/2/26 10:43 AM, Krishna Chaitanya Chundru wrote:
>>>>> With PWRSTS_OFF_ON, PCIe GDSCs are turned off during gdsc_disable(). This
>>>>> can happen during scenarios such as system suspend and breaks the resume
>>>>> of PCIe controllers from suspend.
>>>> Isn't turning the GDSCs off what we want though? At least during system
>>>> suspend?
>>> If we are keeping link in D3cold it makes sense, but currently we are not keeping in D3cold
>>> so we don't expect them to get off.
>> Since we seem to be tackling that in parallel, it seems to make sense
>> that adding a mechanism to let the PCIe driver select "on" vs "ret" vs
>> "off" could be useful for us
> At least I am not aware of such API where we can tell genpd not to turn off gdsc
> at runtime if we are keeping the device in D3cold state.
> But anyway the PCIe gdsc supports Retention, in that case adding this flag here makes
> more sense as it represents HW.
> sm8450,sm8650 also had similar problem which are fixed by mani[1].

Perhaps I should ask for a clarification - is retention superior to
powering the GDSC off? Does it have any power costs?

>> FWIW I recall I could turn off the GDSCs on at least makena with the old
>> suspend patches and the controllers would come back to life afterwards
> In the suspend patches, we are keeping link in D3cold, so turning off gdsc will not have any effect.

What do you mean by it won't have any effect?

> But if some reason we skipped D3cold like in S2idle case then gdsc should not be off, in that case
> in resume PCIe link will be broken.

Right, obviously

Konrad

