Return-Path: <stable+bounces-169530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A762B2643E
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 13:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF3D7280A0
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 11:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC8E2E9EDB;
	Thu, 14 Aug 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dxg8T1Ei"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B52EB5DA
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170841; cv=none; b=rJgnugoGA1V8BMXlNDBi/+lVj2EfIxQFJmELSMdroEeMVW9T9daxDUwV8Qjv1ysy85A8uMC73wk0G5+MYhp24H8DTOtXO/JPMFdxiC34bgU58jsSYjp/+7JFG2rInm8BpHpDLBvb1xDKzmup4zX8kFeUWldID3BPcxzkbh99ljk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170841; c=relaxed/simple;
	bh=48tAzMVD40mXj8PB2BiEi7B6j1poHkoi0f43NUhjxlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAf+n0WyQw6ZhA4LlTx7XQE/P04OzQn6E0cDwuG8D1KpB9n9HqVtohoWjI1osxYw4OuvMh4hT3wsn/lNhk0K4eOTdRK63hj8So1vCbVubDSRnt6AgtPx226ua9a1EkYIl1w8VcFGl1nbJ/c3b9HZ9KKCUNzmOSzEdIUChgdXACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dxg8T1Ei; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E9SGnU027001
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bvsGtU8EQVIVsNLvkznVXlqh5U1/8tjeUVO97mEHdw8=; b=dxg8T1EiYL9OcJwS
	5mzMdXeaqv222a/hfOGO/LDSP2ifmAk2SRanZBzWs1waH5nr8tkRyukja7LjhrTx
	0iz1QgJuBRzfcDEySMoRDsHuIAMtYH8J+20fac5nyNGJyi7xs2kIO5j6ayicbgYV
	mY/Ic7p7/YB3YGosS263/N3J1AFNiOtPAEsC25NGLeENqJ+etLSzydaR3TxgtSXv
	Ofq5RlAvt7Ys5+GS197TyKy5bX8PIS/jGDp0D00USFk39nxVMB8H1Ig+iQZxch4d
	OdgWJxV/BfyRTfH9XmtihLfXkxqMLTB7yudFNlBD/tCAvkKoKTDtrG4fH7Ll+D+h
	zRHomQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjub32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:27:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e87068f8b0so22832485a.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 04:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170838; x=1755775638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvsGtU8EQVIVsNLvkznVXlqh5U1/8tjeUVO97mEHdw8=;
        b=E9lr1m3nxlUvS1RiERmmYGdjCpjSVnR76A2Cy2IcPGg+6nIy4Xn47DBD0EJpaW+B8l
         8Iyhlk7jJ3oTQXbaLeZBtqdt63I4sREmWuc4RrgRW9Lz2XKmcSdJJU3YdFFvdWGDjiPT
         JciSKov6dnwxZ/zgspNipfKw3XpbC0NCEfR5Am3woa3saG92eQhHsc9Tzp5sGN+yvhXy
         nqK3fMab3Fmk/Gw8YVgp9semfqd7V0FOsF05Jtw3JsVDeizP+klzhdcfK/Wdn2uPGZez
         YliCEoHzcDlhKB5Nx0o1u978RAGhu6BSwjm4tiJDpQ8r7R+9EXBoA0Y67Ishp3JR+yJv
         8sqQ==
X-Gm-Message-State: AOJu0YxgnFpRcUD4OxDy44+qpLWZRYpxfF1ac6vSC+5OLg56KA5WpFgJ
	iKTrecLvsYLW4hTJN6HeGTw+170rP767RocIcQ2VGpHa8rAVFMN9iUb+JDV6aNXa8ejvY0j1HR7
	NUrcHy4RBz5zoLDuu8TbZffwSFk0Fl6PBF6v5v60EBhnH3+S0SrIVs8Hl8hk=
X-Gm-Gg: ASbGncuTh+8t7t7y5Lk361FvkOOXrAG6mCf/Qa4+lSkQ/J/PEXXo8tuLaGk/JyFym/I
	68cD4Gu5RV3dsh3HcJGZq5bq5jbCfnOf4Xs9nVd/XbE1asDha4jXNAwcHAaxhI1ZI4+Y1ZfDi6M
	Y+tLIJy5lx+U5mLF41LxSYv82eapRoliPIuth55V+VcIyhV6x0FsJqhZyLDRn1sq2EysEbyxveG
	XS2p4mTr46gly+TG+M6c0ZDQaxnxfl31C+sDZmzVj6202QiNsT1CBubigUGVJrT0Ais9oM+GfH1
	mK1nZUeNO2iF9gob7No6x9aQHSBs9raZYYa7FiePL+0GQe1hvBsqnSbcaCxQoBCp1GYFV7QdXPZ
	vCz4zYaZFibTR5ibx2A==
X-Received: by 2002:a05:6214:62e:b0:709:8842:56f5 with SMTP id 6a1803df08f44-70ae7011913mr17664206d6.3.1755170838182;
        Thu, 14 Aug 2025 04:27:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTu7SXRxQxpz8/MLVN48BYHvT9GmSmQ485QFVu7S13NXbeVoB0o9r138fw7Vr2LU4rtD2YLA==
X-Received: by 2002:a05:6214:62e:b0:709:8842:56f5 with SMTP id 6a1803df08f44-70ae7011913mr17664016d6.3.1755170837694;
        Thu, 14 Aug 2025 04:27:17 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61850794509sm4720140a12.31.2025.08.14.04.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 04:27:16 -0700 (PDT)
Message-ID: <213ce041-733e-4e3e-87d5-db0b37c410b4@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 13:27:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: icc-bwmon: Fix handling dev_pm_opp_find_bw_*()
 errors
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
References: <20250814063256.10281-2-krzysztof.kozlowski@linaro.org>
 <e35ca54c-252f-45c4-bfdf-fd943f833bc4@oss.qualcomm.com>
 <f2400037-c39c-4266-9e77-b084bd5f9395@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <f2400037-c39c-4266-9e77-b084bd5f9395@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX/HLlGVOmNuMF
 oZQb06ZAkx8HCq2S6Xgt1MXKbflTDU+NNPiyqPQwEFTZVq7jnrPV9EI/5JrR1v+R6ThVkd1RP93
 osPn6ilyaYQYLbDHQzFc+BPwKuT+fKd41gnaNnXVDUoLVTvp8K3RFEkzEW6d4BrjJlyQ4+clSqc
 z+sjnOEynI/gQwmwaQMLGdATUrCtT9+ZSYJPg8V3ROzGD/cw5OfqmdURmLU2piDmVR8/V0NejK+
 U9EQ6zSklEVrYAST5ohnWF9WaD0rrg91/4bA88lbp1rAynSSADFzieBrKK3TjxX47McZE9gFFl9
 R0D7a9foI+jkL8KDYuZ+2FgHCh4ZiilDDRJ56l/ILhrtsFcdyfnAR0mD4KjtyZVHWfciQ+XZDgh
 4VovcvY5
X-Proofpoint-GUID: NObMPULyZ5hxYSyVeY7REAA3C5hDJVgN
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689dc817 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=Y1L1eU8S7K9_Pyojpb0A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NObMPULyZ5hxYSyVeY7REAA3C5hDJVgN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

On 8/14/25 1:25 PM, Krzysztof Kozlowski wrote:
> On 14/08/2025 11:15, Konrad Dybcio wrote:
>> On 8/14/25 8:32 AM, Krzysztof Kozlowski wrote:
>>> The ISR calls dev_pm_opp_find_bw_ceil(), which can return EINVAL, ERANGE
>>> or ENODEV, and if that one fails with ERANGE, then it tries again with
>>> floor dev_pm_opp_find_bw_floor().
>>>
>>> Code misses error checks for two cases:
>>> 1. First dev_pm_opp_find_bw_ceil() failed with error different than
>>>    ERANGE,
>>> 2. Any error from second dev_pm_opp_find_bw_floor().
>>>
>>> In an unlikely case these error happened, the code would further
>>> dereference the ERR pointer.  Close that possibility and make the code
>>> more obvious that all errors are correctly handled.
>>>
>>> Reported by Smatch:
>>>   icc-bwmon.c:693 bwmon_intr_thread() error: 'target_opp' dereferencing possible ERR_PTR()
>>>
>>> Fixes: b9c2ae6cac40 ("soc: qcom: icc-bwmon: Add bandwidth monitoring driver")
>>> Cc: <stable@vger.kernel.org>
>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> Closes: https://lore.kernel.org/r/aJTNEQsRFjrFknG9@stanley.mountain/
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> ---
>>>
>>> Some unreleased smatch, though, because I cannot reproduce the warning,
>>> but I imagine Dan keeps the tastiests reports for later. :)
>>> ---
>>>  drivers/soc/qcom/icc-bwmon.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
>>> index 3dfa448bf8cf..597f9025e422 100644
>>> --- a/drivers/soc/qcom/icc-bwmon.c
>>> +++ b/drivers/soc/qcom/icc-bwmon.c
>>> @@ -656,6 +656,9 @@ static irqreturn_t bwmon_intr_thread(int irq, void *dev_id)
>>>  	if (IS_ERR(target_opp) && PTR_ERR(target_opp) == -ERANGE)
>>>  		target_opp = dev_pm_opp_find_bw_floor(bwmon->dev, &bw_kbps, 0);
>>>  
>>> +	if (IS_ERR(target_opp))
>>> +		return IRQ_HANDLED;
>>
>> So the thunk above checks for a ceil freq relative to bw_kbps and then
>> if it doesn't exist, for a floor one
>>
>> Meaning essentially if we fall into this branch, there's no OPPs in the
>> table, which would have been caught in probe
> Yes, unless:
> 1. There is a bug in the opp code
> 2. Probe code is anyhow changed in the future
> 
> I think the code should be readable and obviouswithin the function, not
> depend on some pre-checks in the probe. But if you think that's
> defensive coding I can also add a comment to silence future Smatch
> complains.

I ultimately don't *really* mind either, just wanted to point out that
currently it's effectively a false positive

Konrad

