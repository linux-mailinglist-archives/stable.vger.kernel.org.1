Return-Path: <stable+bounces-196954-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC88C8834C
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F10F3A5343
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 06:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC22D279DCD;
	Wed, 26 Nov 2025 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ALcucnHx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZUuQLgUv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30537311587
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764136947; cv=none; b=QTvLh2c/Jf4M3L2X4n8vNM5gLqY2kXqcGkaEDoJ58IBac24l3trGAKEUfwB/8Q3ujIQI3+vsggxRAL5r7UlOmfPzZbNJS2tmWIxB0ROI99fuIAY0TTW+g9c4D5ezXCop92iIQVEsylgdjjPYoKIH/DEr9fISFYsBl+tbCN1/0yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764136947; c=relaxed/simple;
	bh=dyl3/ntopNbv3yYZrrcoXgHieaoSmqCTWvqkmEhoeps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEoekO8dQMW7njTVI/nrcCeuYhr9yY73AL1rHZd08jqO4+2MiJSoYuG1SK89O2JgziOaqPosB4c0hlvE4d8mDk2bcta5v9zVqT2Qgn2mFf9SvYsvt/LVbKiD+DGIgCDhS1TD8Db8r2QC/ojIptRGzYULGm1D+nAlSZYo9ouwvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ALcucnHx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZUuQLgUv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APNMNNc4048890
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YjciP6a0IjtUI3khiEOBEKvlx4zrrgo6zDwtEPrHGbA=; b=ALcucnHxbdsQkIDE
	YFTT1NZt8QfrlVMGFvJ2R6MnnPeB7RyYWksm1tbO3o+id894Q57RzEJAMmFj3U0S
	9XYLx01PLjGYrkBYTrr4ZQtwm36IP5GS7EJ8yA1uD/e0VpZ67S04i7m85K1sOIUI
	LNogdGzYN4sD0xpE4deOXjDi+6BzOEdVlQgpiDhqpsN1jVY7On27+Q5F9wFCscuN
	VohNkhPk18lLkoGl0yoAmqb/c3ci6xFvdobSYI8VVPAJoeAgR7/I2SoF3l/JBs24
	IcWM5tKRVYvIzlFk9ltWjruOS7CzGIVBIL+4DlG+0D4qCyU0u4PsfvKzO8BIMAjh
	U6ItUg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anp2ngth9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:02:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3416dc5754fso14067956a91.1
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 22:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764136944; x=1764741744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjciP6a0IjtUI3khiEOBEKvlx4zrrgo6zDwtEPrHGbA=;
        b=ZUuQLgUv4E3frpkguGQi7GPzv+rroHAJz0oHcJuJvJRVLzyp/DoW4dwRb3nsM9IeL9
         BqUJfQTC7gSF7Tbxq7Sf4dSr0EfXBO7LZn3IA6hEyr3blDDg+VNear2Bxb+Il9m87k4Z
         n6aoEO5VucpjmBhu35sfxWxd8sl2R+0zKtEuhQVi86OIOsdDe17bc4iaGr84m73RMlIr
         JIL7A2qD+bqKANUDv+zWxxrN2SKBbnvD1KyOmXhTOZi/jDRYanzs7AaVq7rcVUV9DqF0
         qgv/o8pVxYnn0jWkcah4WYKk+zzGB/ggI3c1SH/0sBpmUtDGJK+yyPtOBJxFTyj59k3h
         UqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764136944; x=1764741744;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjciP6a0IjtUI3khiEOBEKvlx4zrrgo6zDwtEPrHGbA=;
        b=uJuAUTOMWJ4bsRvOYfYIqjXiqTExZYUtxgoP0/azUU/XQyL6g0IWABhjOtryTKCT6E
         Om5OKmMjb8s86CAaP+6JrQWmHwCTlm+oRrcn/gKYXt7fOhwPaP7OPDLEOH4RX5J9IkGc
         +u9DF562n/+Zt69Ix7PwWLxb9fD24aDbS2jqM0uH5F/T1h6Z17fTPhWsK2ZonTyqeE4n
         DVNmtJ7l/hqI2QfXiXhBr5d8uDQMEm0Ovl6W7y5TpsTJDaTlRxwWSwQ4whPaaXaiGRTT
         LDHoJCArhXSqUxXXP9PG7BUgXMqk8US1ju52a/dhqfjD6RecQewwEM5J4fy1FkEMdf/P
         6H1w==
X-Forwarded-Encrypted: i=1; AJvYcCUFNXXe1NNeAlr+ik7ichZy2bIvJhZqFq6FwYzMKvE6x3nB0HWEIXikt4yOSl7BpeT5nUovndQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRnbfwoS/8jh+Uj7h1H0xTQWR7UuQ9mAUK5y/ETQaPQtWKAuMU
	JPnK+gMBQaP5GY0Kj7CC5upux4jMZieFG3T+Yb30gnHWQGFUbp/4MPk1qo0r8A7WBLIT/rLhZ/L
	L8a2em0/gfQKLeKO3N4XKKu2BJgqHS7DnLf7Nim5/grNrxCD0UgiEQcwkQDQ=
X-Gm-Gg: ASbGnctl5p5IAKe6nDg3bgEuZDWzX/MF7FPY/Plo9C0JWyAeoJCINREuvGUhBcfIzCk
	vGPe3yneE5U/meiJCpukJb79LH01w5q8sKIPJExnYcSXlZrckYmyEV4N8EJlygbKrFlUlI79lEC
	da7N5UD4kWdjJLvlpnD/t9LWNMUahOQOxu0vYs0aKN2ukeR1kkE1QIo68BoJ+UmpRrIgYoZdc4m
	e4yjnqlpQCXu+4Ua7H59lFIU937cfIYQExRyU3I3qsukRftvCja8VsWPDflXT7X7tGM6QdGRpSL
	oxWiw+9+zcXptPM/Vos/W7O5AYOLBZWB8w+CP3RnVEtcC8eXbAP4LJVI9E3xR5qpXNA+T82ZqDB
	5PBfXO23+YOINsYmmbPQb6Az/QgSp1fGXeHU6hkeQjQ==
X-Received: by 2002:a17:90b:5183:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-34733f2278bmr19708999a91.17.1764136944446;
        Tue, 25 Nov 2025 22:02:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHel1qAda4IjKOVHP8XaISvlRtkrTCjU5jX/Ea+jQHwfDaLvLGE5EziIf1nQXJ3erB8dBXmSQ==
X-Received: by 2002:a17:90b:5183:b0:32e:9f1e:4ee4 with SMTP id 98e67ed59e1d1-34733f2278bmr19708971a91.17.1764136943841;
        Tue, 25 Nov 2025 22:02:23 -0800 (PST)
Received: from [10.0.0.3] ([106.222.230.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e980f41sm2286889a91.2.2025.11.25.22.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 22:02:23 -0800 (PST)
Message-ID: <e2b33a10-819d-df49-0687-74f6db4c5a05@oss.qualcomm.com>
Date: Wed, 26 Nov 2025 11:32:17 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] media: venus: vdec: restrict EOS addr quirk to IRIS2
 only
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab
 <mchehab@kernel.org>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Mecid <mecid@mecomediagroup.de>,
        Renjiang Han <renjiang.han@oss.qualcomm.com>
References: <20251125-venus-vp9-fix-v2-1-8bfcea128b95@oss.qualcomm.com>
 <wq7kaelokxqxkxxi5cvp7sz2az5hlam4nyyt4v55zrgei3jsyo@yyefysdsw3co>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <wq7kaelokxqxkxxi5cvp7sz2az5hlam4nyyt4v55zrgei3jsyo@yyefysdsw3co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KerfcAYD c=1 sm=1 tr=0 ts=692697f1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=12FOtvgV4D2gsqRYbU+y8g==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=GE1HXsG9Zi4TFkiVsKoA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: NNkpeivRVALgF1X70UC6IEwPsAlCF4XH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA0NyBTYWx0ZWRfX/Kvw0sOa4toj
 2jzA9lsu2X13/I3AQbSa2fdZNj3Oi+Xzdb/1iMNQKQMCRS1nhPJRKT3e68hveojqzUUbjSfL5GR
 R9d47YhbZGmqIbVpqtQPnYARCJNBgX+ib2XIaERKTpSe4Mph1f4bdq5VerVyFf/ZmRL/1V1tvKg
 YC7O8XsA5NKpWe0hnAlSR6etXkCg2mRyFEP7zicwUn0Oxiyam8whHw/qmL2KS9LUOTS6yEj41Ih
 YCA0bGB4U7/DojkVuWxjFJxwqqFIZFz1Se60gVXdyb/pszEU/tHbOg5b+pj61PWTm+HM2yXsWbk
 vRBQyMLZFusiG0kFJmZyIlSLD64SdxEgh7uYurrZka1DEUY5poPtOH/6NgjfIco4tNfxFMHozhC
 zc9sCqX0eQVDUNFAmr189H9R5T14NQ==
X-Proofpoint-ORIG-GUID: NNkpeivRVALgF1X70UC6IEwPsAlCF4XH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260047



On 11/26/2025 6:43 AM, Dmitry Baryshkov wrote:
> On Tue, Nov 25, 2025 at 11:04:19AM +0530, Dikshita Agarwal wrote:
>> On SM8250 (IRIS2) with firmware older than 1.0.087, the firmware could
> 
> Hmm, interesting. In linux-firmware we have VIDEO.IR.1.0-00005-PROD-4
> for SM8250 firmware. This version wouldn't be parsed at all for SM8250
> (nor does it follow the format string). Why? Would you please fix
> version parsing for this firmware?

Right, Seems this firmware doesn't have the proper version string, I will
upload a new binary with proper version string soon.

> 
>> not handle a dummy device address for EOS buffers, so a NULL device
>> address is sent instead. The existing check used IS_V6() alongside a
>> firmware version gate:
>>
>>     if (IS_V6(core) && is_fw_rev_or_older(core, 1, 0, 87))
>>         fdata.device_addr = 0;
>>     else
>> 	fdata.device_addr = 0xdeadb000;
>>
>> However, SC7280 which is also V6, uses a firmware string of the form
>> "1.0.<commit-hash>", which the version parser translates to 1.0.0. This
> 
> I still think that using commit-hash is a mistake. It doesn't allow any
> version checks.

Agree, we had this discussion with firmware team sometime back and for all
latest firmware they are having rel version in the firmware binary, but
SC7280 firmware binary would still have commit hash in version string.

Thanks,
Dikshita
> 
>> unintentionally satisfies the `is_fw_rev_or_older(..., 1, 0, 87)`
>> condition on SC7280. Combined with IS_V6() matching there as well, the
>> quirk is incorrectly applied to SC7280, causing VP9 decode failures.
>>
>> Constrain the check to IRIS2 (SM8250) only, which is the only platform
>> that needed this quirk, by replacing IS_V6() with IS_IRIS2(). This
>> restores correct behavior on SC7280 (no forced NULL EOS buffer address).
>>
>> Fixes: 47f867cb1b63 ("media: venus: fix EOS handling in decoder stop command")
>> Cc: stable@vger.kernel.org
>> Reported-by: Mecid <mecid@mecomediagroup.de>
>> Closes: https://github.com/qualcomm-linux/kernel-topics/issues/222
>> Co-developed-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
>> Signed-off-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
>> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>> ---
>> Changes in v2:
>> - Fixed email address for Mecid (Konrad)
>> - Added inline comment for the quirk (Konrad)
>> - Link to v1: https://lore.kernel.org/r/20251124-venus-vp9-fix-v1-1-2ff36d9f2374@oss.qualcomm.com
>> ---
>>  drivers/media/platform/qcom/venus/vdec.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>> index 4a6641fdffcf79705893be58c7ec5cf485e2fab9..6b3d5e59133e6902353d15c24c8bbaed4fcb6808 100644
>> --- a/drivers/media/platform/qcom/venus/vdec.c
>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>> @@ -565,7 +565,13 @@ vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
>>  
>>  		fdata.buffer_type = HFI_BUFFER_INPUT;
>>  		fdata.flags |= HFI_BUFFERFLAG_EOS;
>> -		if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
>> +
>> +		/* Send NULL EOS addr for only IRIS2 (SM8250),for firmware <= 1.0.87.
>> +		 * SC7280 also reports "1.0.<hash>" parsed as 1.0.0; restricting to IRIS2
>> +		 * avoids misapplying this quirk and breaking VP9 decode on SC7280.
>> +		 */
>> +
>> +		if (IS_IRIS2(inst->core) && is_fw_rev_or_older(inst->core, 1, 0, 87))
>>  			fdata.device_addr = 0;
>>  		else
>>  			fdata.device_addr = 0xdeadb000;
>>
>> ---
>> base-commit: 1f2353f5a1af995efbf7bea44341aa0d03460b28
>> change-id: 20251121-venus-vp9-fix-1ff602724c02
>>
>> Best regards,
>> -- 
>> Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>>
> 

