Return-Path: <stable+bounces-183536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D33BC13C8
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 13:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E145134E4F9
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 11:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A64B2DC34E;
	Tue,  7 Oct 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f5opgIXz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A296A2D9EC2
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837103; cv=none; b=EHwbp9AmCKRfMjry4iMuHs77i4fmVDq4PUfOw1gXHB51ydxuAWx6PdnLVMdpCOe8KNeyhMEZo+FD9ZCiMMgydhYDpj8q9RZV/fLRRAUShxDJDemoHnelnObx3LXIJD7i6PtMO7vu5XQFDDRIS8jexY+Mu6N+/vFQ2C4ygcRusJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837103; c=relaxed/simple;
	bh=ZXrGelmvQas8vmmTp/wX0exf21knoe1W83mDfua+9fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1mKYWBAcstEM+e6+iXq4Axg4VL2md3+NknGQkMUU8CT8gobZSInaJmupmQZYV8zJGCcSGCrpiZeOtP5l7gF/Eu0bkAjuFXuYaAIh/bFd6UEqc8ti8expfDgbBjlcFgG/mMB23dKpCGMLwYHdtNLSnc0J9CjC0ZeWgNfiFjeekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f5opgIXz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5973m77k004958
	for <stable@vger.kernel.org>; Tue, 7 Oct 2025 11:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GCYeVPjY1mm3YEzAO8t9rcepeUOr5QIFPQ94aq1HS8A=; b=f5opgIXzjj32H8O2
	GznYGxX7b9hB7zfT+3AMVvQ1pink7gbD5s75hTBwmdY9fop0FyRPss6FpvsX4iJm
	ieMfCKXwwsvaDQA9ibIcq8G5h8CTF19JfPuapbTFQ64why/7SgMqsKtptku/ncxX
	E7sBbKsKIakPF9RF+X39F1iP4nX6/nBoh+/vHrc2E7NPj8VgIHCLxVq0pxkM8KyV
	htbGGg/KTmp1jmr3nNxDNWzzlFtt9fBaljuYtbq4RIH5ragoacVHNu5Mp8yZnHyE
	HBCnyBDTTwinimNRtcOHSbdCebsOHem4dHqb0qqgadoVPdTe2UVClST0ORpwcLeE
	bLFK2w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvrhpvet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Oct 2025 11:38:20 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78427dae77eso5155418b3a.3
        for <stable@vger.kernel.org>; Tue, 07 Oct 2025 04:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837100; x=1760441900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCYeVPjY1mm3YEzAO8t9rcepeUOr5QIFPQ94aq1HS8A=;
        b=qJmPpwbtU8CUTdTv0VAfFHwSVsLFKjWg6VGi7RcxnYxa03u9Rcm4udshNRBQ8+zy3z
         jD78HfLfVEfWlAjWIl5xGe4XbihKn6hEXu24q5tlPrYs7z6jgI4CiNTeLLI9cCEPoeDD
         JnDElnxq5gsi8PIo7626WO97tYnYzOGlO1r6vRn7MZTNQW1dR4HvsjQ2y6FPEmuO/EPu
         bdLJ29g7PfO4BB3JySOQN042+pXNFlkSm5HVFM46cxdbDjD2RdvkjdmYnezPl0dsNFOw
         zEc9qVAw9hz1t51YXpiAuCWbaDw1k2hUb6O5kIuHORcjJsefUhxi9EbZzrGti06xpJgm
         PKmQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8K9qHsOJXuLVIXHbs80+7/ltcP58k/dFiaPio+BLhe5ZjY2F8gsvxH/IBJxUtgjGSXygiuwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeRvdRUKoTvvaG/2sexiC0LCn9KoigRT+N+C68NOZHx95sXKJ
	zc0tAIDJkTDGTExHBX0A2TPyN3OyeX0g7UWAkgR43eIgHOw6XbKyYeWZT1f0+SAvvIc9aLnvIro
	4RquN5RRWRGGZXbh5JxsWWTCRCiA1hNDLNeMYgMEwg3QIGBhrYphG6tFzK74=
X-Gm-Gg: ASbGncvzJxuOmPJP5YlXJwGgpYrOBIFkgLDiLASZzoSkb8exF9LoGzG8j3KDaYL+BNe
	8jNhu3afCJxlsO8udCcqsfFfWFcXME6HJKaVx/yfrJiMQlk0Ye5J7zWHR9OiAngaqUWCtbRKwyK
	CcOw8RNqq1hg220MWSWdlIyo2i7Z+X04THHrGaTS+1xvPK/rEJPI9+3b9G3bCwp7cSMSeBHKrOp
	Dd6yVcfNOkBix3KReq7XOU4XobBxalIqTD4lTOU1HJHMJzBfC3sS9g+uIQEJuq9sAv0xGuSoJZQ
	xGBpyvij4aYx4rkHOUA0aIC4JgqkOI43Xk5a7JcT+g3jnJi5TiipTlLw4LIQzwfit15mCxUN3Jo
	sig==
X-Received: by 2002:a05:6a20:12d6:b0:2c6:cdcc:5dc0 with SMTP id adf61e73a8af0-32b61e6d11emr21191685637.16.1759837099736;
        Tue, 07 Oct 2025 04:38:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjww+c/j8M44jX9PgI+h6Etypkqn272KmpewHvoFomBsMZzaaIb9jb1O3bbZyUinW/tDhShQ==
X-Received: by 2002:a05:6a20:12d6:b0:2c6:cdcc:5dc0 with SMTP id adf61e73a8af0-32b61e6d11emr21191635637.16.1759837099017;
        Tue, 07 Oct 2025 04:38:19 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099ad926fsm14634202a12.5.2025.10.07.04.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:38:18 -0700 (PDT)
Message-ID: <aff68f3b-298a-2cb0-c312-808d7efce6f3@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 17:08:13 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: iris: Fix ffmpeg corrupted frame error
Content-Language: en-US
To: Vishnu Reddy <quic_bvisredd@quicinc.com>, vikash.garodia@oss.qualcomm.com,
        abhinav.kumar@linux.dev, bod@kernel.org, mchehab@kernel.org,
        hverkuil@kernel.org, stefan.schmidt@linaro.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251006091819.2725617-1-quic_bvisredd@quicinc.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251006091819.2725617-1-quic_bvisredd@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNiBTYWx0ZWRfX0HKxBNN9AYmV
 iz7//4Q0pkqxaDt9jWhdJCyTEs5zcLKg9kBwzkNOX5kgDjAuL53nt3i0obOitUF/G3gqdBsw7Hn
 UvWV2dF65bvDUjBX2BEvwqMl9Ik2nrsnLLOHIzx9h+dYNqLhSiHeEiovliPyPYPztf3fKuqjk7i
 tqrmagDLMMFoXgKxmVbuQ5g0cn8FECtDKB2JbCI0Bux+HQsPwRXONwL1qaGP7T54QYOFmV7NLhI
 FF7iEe9U3NwbMlikmugpTwDXAH+CytXcbMY1geQ+7Nq+4tQvl7sT39K/a1wvh133lwGpgCAxbP/
 I7EY+ESFlDzw3emQ4di+0efUd8AkWrZWcJMXaAiGYyGCZrRJbnD1bG0HSGsJOpGGI08hTVau/SV
 Hl3jX8i5tN8DBk3Buq6bigtg802dWA==
X-Proofpoint-GUID: Mim50S7yAZo6dHlolAKm5ZEOBJ6tvSX1
X-Authority-Analysis: v=2.4 cv=XIQ9iAhE c=1 sm=1 tr=0 ts=68e4fbac cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=kcjkJnMakA67_LZCmskA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Mim50S7yAZo6dHlolAKm5ZEOBJ6tvSX1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040036



On 10/6/2025 2:48 PM, Vishnu Reddy wrote:
> When the ffmpeg decoder is running, the driver receives the
> V4L2_BUF_FLAG_KEYFRAME flag in the input buffer. The driver then forwards
> this flag information to the firmware. The firmware, in turn, copies the
> input buffer flags directly into the output buffer flags. Upon receiving
> the output buffer from the firmware, the driver observes that the buffer
> contains the HFI_BUFFERFLAG_DATACORRUPT flag. The root cause is that both
> V4L2_BUF_FLAG_KEYFRAME and HFI_BUFFERFLAG_DATACORRUPT are the same value.
> As a result, the driver incorrectly interprets the output frame as
> corrupted, even though the frame is actually valid. This misinterpretation
> causes the driver to report an error and skip good frames, leading to
> missing frames in the final video output and triggering ffmpeg's "corrupt
> decoded frame" error.
> 
> To resolve this issue, the input buffer flags should not be sent to the
> firmware during decoding, since the firmware does not require this
> information.
> 
> Fixes: 17f2a485ca67 ("media: iris: implement vb2 ops for buf_queue and firmware response")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
> ---
>  drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> index e1788c266bb1..4de03f31eaf3 100644
> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
> @@ -282,7 +282,7 @@ static int iris_hfi_gen1_queue_input_buffer(struct iris_inst *inst, struct iris_
>  		com_ip_pkt.shdr.session_id = inst->session_id;
>  		com_ip_pkt.time_stamp_hi = upper_32_bits(buf->timestamp);
>  		com_ip_pkt.time_stamp_lo = lower_32_bits(buf->timestamp);
> -		com_ip_pkt.flags = buf->flags;
> +		com_ip_pkt.flags = 0;
>  		com_ip_pkt.mark_target = 0;
>  		com_ip_pkt.mark_data = 0;
>  		com_ip_pkt.offset = buf->data_offset;

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

Thanks,
Dikshita

