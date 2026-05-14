Return-Path: <stable+bounces-247165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHJcFI6qBWrtZQIAu9opvQ
	(envelope-from <stable+bounces-247165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:57:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0756540AFA
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AABD3084004
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 10:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C13B2FFC;
	Thu, 14 May 2026 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aA9HlGX0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j7ZIIk1+"
X-Original-To: Stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3763B2FCA
	for <Stable@vger.kernel.org>; Thu, 14 May 2026 10:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778756121; cv=none; b=k70uRfa69FV3MRHSOOURB944fnqOlFUGQG0r0ZpX16dpJBwqw0oKz5VT5s1xKhvjsGNxi5yXQfUNIs231R5tQMSfw+DmKxphkjMBr+vjLPZu7U19YFl4x4R7eqiRHZk3wup5viBL2/uXcouqK9zRboq08xxfL4w5DYMDQ178p8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778756121; c=relaxed/simple;
	bh=kMx/J9r7WnLfGWxPaoBGcSxdF3FD+RiowqHAxhNB8XY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzaF92e5fOJp9amLwmNYKT4XQkcZlJOK6sp2M8nTj8+AA/FhmDJcdydgAdwtpUYmOFT7bcZ6s7f5Egd2LTNsmDYW98uDCToA7krjxaHOmaqcey5wIjTNaUlphwjpzsox2OlVv0rBMPyQmOjjLOC5ACDiqxOyXHAPA7SAvfECJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aA9HlGX0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j7ZIIk1+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E9k56E2010551
	for <Stable@vger.kernel.org>; Thu, 14 May 2026 10:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/VaAgEDcKuwipa1EtcRKH0tyrwq9hyUOCh/ncQOk15A=; b=aA9HlGX0+x/vmO1M
	0/bwdFXvoVQkh1AdtGj8ArfJH2/Dd/695f4ekzQflgxe9psVIm9mAQDs9z0JRA/j
	iYqnO/3QjTtsnpPducprCpG+PJytux3dhPyYsi6FDNEqKtnSAinksDy/TNEOH0/U
	zCmycVRdy64DbXNf1pBJf0eZjhfYQVoagalF4IvP3Cf6tiHMs76ifgRecuE3hnJL
	HIIbKK62Rl6hv9KMIsYF0hfmyTGSMgcUu4B4Ed97FwOF1wyNxZhanUq6Selsu5Le
	N/VwXjn5C+haGU8sCQuwVOW22/B1ekaZ09rWSvjbq639Wfbh4LqL069wsJ4Z9CM1
	nmJYGA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e563hhgty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Thu, 14 May 2026 10:55:18 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51494d74d4bso138511441cf.1
        for <Stable@vger.kernel.org>; Thu, 14 May 2026 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778756117; x=1779360917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VaAgEDcKuwipa1EtcRKH0tyrwq9hyUOCh/ncQOk15A=;
        b=j7ZIIk1+7whHq/49ZBPW5rR5UXqqzYLqRRSA/o8VBmqFeLSImt73Se+xmdP2JFHFx6
         Vxn3EPXqindPcOHLZgQDcTlVc0wDJoDSXhws7iPSRvgH+LO2AIfzKmnnPI6BAf18DFJZ
         A8hVSDmqmjG1IC/fcJ8qxmfiZraj7rNXxdcHSptMiVSn0vujZhonj5FDhHBwF9ULgDpz
         L8azYwri2A6DtY6/ycoVGeBMxzGqQ7QfRMTgDmPoDOdfhjPruDuHKx8ria6Xc68EAcyD
         n5dAwEo+pDSbjUxBd6+IpHPOSj+NpDs4iwYm04WCc4KfYzJQzBtkKvjkqf/1ebZi6NE4
         yDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778756117; x=1779360917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VaAgEDcKuwipa1EtcRKH0tyrwq9hyUOCh/ncQOk15A=;
        b=H3r0lyMlK38L3y1L4ULVKXmxxUmZQI+3WpLY+ntnowXIPNh6owiqo1rW01kCDwAO0o
         c3+0zNngiQo4cy4gh4SLDfbcl3BTGv+trVUQXX5X6qG+M1phb44OF78pmpnsB2sE7ekq
         MNvP1jq5ca3fgumpzA7Q/oIZKyY6uy8Bt+01ui4rfOpTgQgjB7QQdwDDKUGI+JT9MY1/
         /Hl3tIw1oHfO3Yv24Y3HB7566HWeld0hYPg+6zTWMnT3zxKtMeg79rxRKkVWGyNOAEfQ
         cQEz5ssjN5SRZYfFuF/g5HbplrDA5cEuuKUzPnb8jqhp8KgmOzxFJoXD0Q51NICxPWxv
         AgAw==
X-Forwarded-Encrypted: i=1; AFNElJ/9mDwmf/g22hdrU1UkXO63k8YM3DY4qYWNsolzsLHzbjvTf7bpf/qq1KEafmAsxTSI3WWxZPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi58gzbszRGje1b4vZjk2Sb6waW4x/vQHXgQXJpm6hM/7LHfG+
	I9ZsdFUcgcm0zLKDZ3kLcTVV5C5My4rq8SIUYFrdWu2HI9hpK16/0CPLr3DH2jj7dWNWEMR0FGi
	tY3rrUaMOC+QYZdisLquq33pVlLvNLZngxNYiPyWT565pEcqKK3KWtbdPElU=
X-Gm-Gg: Acq92OH1Xp7BHi2w3qEZ1VBGEPI3QYWWjdLWmH1W69Fkwul/mBE0HwdCfuLJE4Ag1Tr
	pnDQjtmJS6kdWKcqsiPGUrJYrc9dPSyrgDLPdFJijh4knTtqNqaRCfzEUVgDYN26xWXdNS5J7fl
	yfc8SN2/duhjRxRpTXTOAPRZV+cHLEIpy7xcYDQ4pIJLy3KZGXlDq9fuudZDxJR2eYpRLx3GLzp
	DuAKxoeQGyDllnGOuSppwXyDa5WdUt10990/ny4jd8F8yFKr1NlQ2Q+GZJd2dNws8IVzopo5a9u
	8lFRplkeuK7aB0+VTAR5cBL8dG4g95/+jBoLx3FDfgD/XHG7z/lx3WGiKC9BCP4KOqyUMMrpYPl
	EPoJFLDzxmf5Mn8OabfzjKvwR+cYZ5DDo2gtpnd15a4UwXRma
X-Received: by 2002:ac8:1089:0:b0:516:4781:39e7 with SMTP id d75a77b69052e-51647813c38mr14418721cf.21.1778756117404;
        Thu, 14 May 2026 03:55:17 -0700 (PDT)
X-Received: by 2002:ac8:1089:0:b0:516:4781:39e7 with SMTP id d75a77b69052e-51647813c38mr14418271cf.21.1778756116899;
        Thu, 14 May 2026 03:55:16 -0700 (PDT)
Received: from [192.168.68.112] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45da0a178adsm6433563f8f.18.2026.05.14.03.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 03:55:16 -0700 (PDT)
Message-ID: <c6be57b9-ce26-4e96-b029-b18798904e2f@oss.qualcomm.com>
Date: Thu, 14 May 2026 10:55:15 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: qcom: q6apm-dai: Allocate an extra page for PCM
 buffers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: broonie@kernel.org, jens.glathe@oldschoolsolutions.biz,
        linux-sound@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, johan@kernel.org, konrad.dybcio@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        val@packett.cool, mailingradian@gmail.com, Stable@vger.kernel.org
References: <20260514090607.2435484-1-srinivas.kandagatla@oss.qualcomm.com>
 <2pe7rk7jhc36osc6i4rxeyw342mvza2m7i4ztsmm6pjgwtlemc@k4gkw5b4jg7g>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <2pe7rk7jhc36osc6i4rxeyw342mvza2m7i4ztsmm6pjgwtlemc@k4gkw5b4jg7g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: xXO9N1YD89vHH7diso7abIHTUHyLbNN3
X-Proofpoint-ORIG-GUID: xXO9N1YD89vHH7diso7abIHTUHyLbNN3
X-Authority-Analysis: v=2.4 cv=DewnbPtW c=1 sm=1 tr=0 ts=6a05aa16 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=gxl3bz0cAAAA:8 a=EUspDBNiAAAA:8 a=_21zWEb1aClpJhlDeeEA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=kiRiLd-pWN9FGgpmzFdl:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDEwOCBTYWx0ZWRfX0Q0HROBTSW+j
 WgKwwCSgmfmUkRVEixxX3c++lAOpVNMsgF98neFjiCeVjuEs6MGvNOi29Dafe4k3LXLoKFbsDSe
 rmKAUo6KYW4/bYL2T2zv/fO1BtkYAsBC3gmzKysmkd3KIBUAT0IBpjdH8T5VWtvdl1vuiMvSXLm
 vMmAjmyQp81cjvZgcZSTu04iFsca/bWyLKz2sZBcE+stAIq+TNsR0zuHl/3/X2tQA4pWsLdIxau
 glGpWY088TGsweqMIFlj81LDmt173OmbT/a53Xj/Q2hGaapNJeAp8Babd3vCN4v57fBKFT1zek9
 pLMhhtcHWegg9civG/u996UAN39uO/aNvumTNQAtSwEiPaGWq/ZUKBsT/Odd9mILsG/yqKSFGYu
 5XKeKv+0SqNJdIwnLOsSGpsaWyprP2QLvEdX72ccRtsx9oyJ7nhRtRby0UHXUpghyS/M0AOn+50
 wFAJ9VTCltuXY5KFe1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140108
X-Rspamd-Queue-Id: D0756540AFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[kernel.org,oldschoolsolutions.biz,vger.kernel.org,gmail.com,perex.cz,suse.com,oss.qualcomm.com,packett.cool];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247165-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oldschoolsolutions.biz:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.kandagatla@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/14/26 9:22 AM, Dmitry Baryshkov wrote:
> On Thu, May 14, 2026 at 09:06:07AM +0000, Srinivas Kandagatla wrote:
>> Some Old DSP firmware versions use 32-bit address arithmetic and size for
>> validating the PCM buffer address range. If a buffer is allocated near
>> the top of the 32-bit address space, arithmetic calculations involving
>> the end address can overflow and fail checks.
> 
> Should we limit the workaround to those platforms only?
I would love to do that, but I have no idea which platforms or firmware
versions have this bug.


--srini
> 
>>
>> Work around this by increasing the preallocated PCM buffer size by one
>> page. The DSP is still passed the usable buffer size, excluding the extra
>> page, which prevents the firmware from seeing an end address that crosses
>> the 32-bit boundary.
>>
>> This was not hit before because PCM buffer allocation and DSP-side
>> mapping happened at different points, and the size mapped on the DSP was
>> usually nperiods * period_size. Therefore the mapped size was unlikely to
>> match the full preallocated buffer size exactly, although the issue was
>> still possible. With early buffer mapping on the DSP, the full
>> preallocated buffer is mapped during PCM creation, making the failure
>> reproducible at boot.
>>
>> Fixes: 8ea6e25c8536 ("ASoC: qcom: q6apm: Add support for early buffer mapping on DSP")
>> Cc: Stable@vger.kernel.org
>> Reported-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>> Closes: https://lore.kernel.org/all/7f10abbd-fb78-4c3a-ab90-7ca78239891a@oldschoolsolutions.biz/
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  sound/soc/qcom/qdsp6/q6apm-dai.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
>> index ede19fdea6e9..3a1be41df096 100644
>> --- a/sound/soc/qcom/qdsp6/q6apm-dai.c
>> +++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
>> @@ -497,7 +497,12 @@ static int q6apm_dai_pcm_new(struct snd_soc_component *component, struct snd_soc
>>  {
>>  	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
>>  	struct snd_pcm *pcm = rtd->pcm;
>> -	int size = BUFFER_BYTES_MAX;
>> +	/*
>> +	 * Allocate one extra page as a workaround for a DSP bug where 32-bit
>> +	 * address arithmetic can overflow when the buffer is placed near the
>> +	 * end of the addressable range.
>> +	 */
>> +	int size = BUFFER_BYTES_MAX + PAGE_SIZE;
>>  	int graph_id, ret;
>>  	struct snd_pcm_substream *substream;
>>  
>> -- 
>> 2.47.3
>>
> 


