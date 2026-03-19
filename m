Return-Path: <stable+bounces-227211-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHrkNWyQu2lmlgIAu9opvQ
	(envelope-from <stable+bounces-227211-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 06:58:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE0B2C66A3
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 06:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D2993054CB9
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 05:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A617B39F183;
	Thu, 19 Mar 2026 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P2KCUt9+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Czp+MJFz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD3039DBC0
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899782; cv=none; b=htNn34UrYi3jBFXeHsniiZPRkAtsKbNt2P5QcxWAV/slN0GwFJT4qNkxf6LXUXZuXf+HU7WD3qrxDmMKNNGvFukra4hLTSJ5TRgjrux1y56uH8qcLEcXn/8AYa29LT5fgj6RtuM6lSv19tSEHDcsLK1A6/vQsppG8ms5LvAjz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899782; c=relaxed/simple;
	bh=8ZiUi24fqFUdPu4QU34GDgepeC6HnaXmOxRZ/hB7GnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GA31XtiLZ6CCd959S8/doFbLc/8Un8dZ9qVIklBVMefrQkaXQURZ/b8lJdE/kTlv2FZmKNQtsm/JgvhZRjIVQzVlu3WXqL3mEs9aSFeudKv7OicKclKObPYAeIaLEo6pVyCCUAe2VclHEheO8qRpZdV9AQ5Z4YKyZk3Vc49jh8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P2KCUt9+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Czp+MJFz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J5XbIu1702050
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 05:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tDkC/xeR/SGMrqyVDxbSwFz+SYbQs1f95eXg5vYl4CQ=; b=P2KCUt9+iuiCPzY0
	8GD9yGDozQOvPOZugZX0KlZQmhXzvvoP0xCp5QTSuO+PnJ8NmUTpEbYlX1iJKJJo
	/k5Ieg7ga4PayK7fHuRiaF6XR8ao5jG62z+tHSGqicntiyTAEsBovvkwVbeDX6En
	9ni2jsQa3G2PfQnjIP2chTYYmCVv42JNCXThSqBnIGHmqwSKsGv3soCLhAfEhtzx
	al2UHcJNhBWuv1Q6qruC8hN/kyjx+wHLZ3QbwL30S2MHsHsc8E6IaHHrnOlPYbhh
	kgxmM0YY+MgelIna5/t0mu2mCnn+YqC9UDs1xu2Gqh7mdc23HQG1zwpgCTrVQBXf
	qGSkDA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyyhga867-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 05:56:20 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c0d15416b3so11684832eec.1
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 22:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773899779; x=1774504579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tDkC/xeR/SGMrqyVDxbSwFz+SYbQs1f95eXg5vYl4CQ=;
        b=Czp+MJFzSxFeJuwMiEV6QpHeA+d46cZXKv/aQ5U/FFls+C+EOywoU1w03Ds9LSswJO
         RUjxb+bJfBUVfFZg/GvAJwAbkTJGbEW+dhw2NrEgoHYGJ+8MGqoGn3DVDIqOynrdgrdD
         vyCOEX8UXnNNbEjaXBFfL4lLTcHI7AYy4fjtaerW1Ip+A+zXynMLiFUo2G3tqtMacyB/
         RisuwBF0tRY1/Ch5JTgPh30/sQ4g7plakjAExWKXXc3cDzRfVcDKKoZc8BABXE41jHkv
         CAEfrFDCwZz4BfcRTpBaXBvi0OXrG6B0IKAYnsW2FgfwpnV/Wfyj6ScEJ4AUwfSBmIIR
         KGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899779; x=1774504579;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDkC/xeR/SGMrqyVDxbSwFz+SYbQs1f95eXg5vYl4CQ=;
        b=SFmbo0cme4QmkSl5Mi9GLOMhP2TWf7kQ8QyU2KHqzICbtYUs5brsTFdV+gWiG2XBF1
         bN4gUkHFnJqsct6+dhn0nNHCpv8byREpqePxxOVOfu/opTqyOjXPGpDUACJX6Ln2Z1cN
         ELn0/5QEOnsYAOw9vxZujzZ/xgae0vJ2+NWRwv3UWA6g8mflsSvk8kQpa9MjtXIyjT/P
         CkkmGzpoumubaChAQ6ZGI2wb+pds3omkVXDfKTkF6DRtc1HbeHSUoSnpR4JU/q/B/hDE
         PWQS922Pg0X+fghZ+EGxRLgkxxeK4+q4LPd9dflmhJ1A0C5yS+XgiTqrT7Utl5xBrnkf
         xmsw==
X-Forwarded-Encrypted: i=1; AJvYcCU1i+3E8/CpnVdfyAvaX8ikuHjKbRUVUbJioLfUsk52o42XbeTj3Vk07dIsqmOob5gEaV07CIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxczaxieMQ4a9jmJwrCzEZ20upOCtb/0f4t//n8j3dGLKINWvCT
	aTp9ckHTuul2K5LRZxPKAciP1u1/PmHblFcO/wOyPky2HPQoniprCHCigZTxcnStJnRiF9HnqlH
	+8GvrjB3hDkI+GhUqBnLX0n24RjzUvzNi3UMtQmOde1i3Jd5uHNbKtUuNK5c=
X-Gm-Gg: ATEYQzyi2aL69r1lAO4k94moeR7BC0m8g5sTWh548FOu96SPW92Pc3V248G1ztm7Ia1
	QXdLj+QnwhZxcIyCPj141nR+V+qT0tHwu6GGOOMXWewNdY1LHXb4S0hfy5DtbQYfHOgZ+uW9waX
	f9OoBvL7goMpHdK2aEjYRxa9aDzepmyecghGDSFbK28aW+/ZbFhSayqt/ijw/iZpgqY0BusZMsP
	TEZe/CGJyPzPo1M+aqKBv6Yj6p7eVtphs/bApvrcE2zmWmHWi3f9RBKokha4bZf7rnFO1HuatGD
	ylVBlvJCOxebB1VGZuhtdfgRAIBmTRkg1lLjeNmId7FqP7pCoNrm4iTpAqe2jhMjpeJJv2JjXvr
	SIFndlmVNIOrd0Jzx3t5I84lpz3YDdMSOcrFE2YiwfNKz89dzDWWKJpTDOlYE5m1Q0jyKT6iJYz
	4=
X-Received: by 2002:a05:7300:7f9f:b0:2bd:b961:7e8b with SMTP id 5a478bee46e88-2c0e50e9b2dmr2972218eec.24.1773899779378;
        Wed, 18 Mar 2026 22:56:19 -0700 (PDT)
X-Received: by 2002:a05:7300:7f9f:b0:2bd:b961:7e8b with SMTP id 5a478bee46e88-2c0e50e9b2dmr2972208eec.24.1773899778813;
        Wed, 18 Mar 2026 22:56:18 -0700 (PDT)
Received: from [10.110.94.9] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e53b5235sm6901248eec.8.2026.03.18.22.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:56:18 -0700 (PDT)
Message-ID: <6b5e6d2d-68cb-42da-82f3-43b2fd6fb943@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 13:56:15 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix SSR unable to wake up bug
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Shuai Zhang <quic_shuaz@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
 <CAMRc=Mce4KU_zWzbmM=gNzHi4XOGQWdA_MTPBRt15GfnSX5Crg@mail.gmail.com>
 <212ec89d-0acd-4759-a793-3f25a5fbe778@oss.qualcomm.com>
 <CAMRc=MdoUvcMrMga6nNYt8d-o8P-r3M_xY_JHznP3ffmZv8vkQ@mail.gmail.com>
 <96472b7c-9288-4f81-9673-d91376189a18@oss.qualcomm.com>
 <CABBYNZ+5ry0FWFSgOskw60jja9mE6WG5AwOi2pKxrkzqMn9bkQ@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZ+5ry0FWFSgOskw60jja9mE6WG5AwOi2pKxrkzqMn9bkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0NCBTYWx0ZWRfXwTXbfsvhTrNH
 8S0J11iX4AbSNWJ9D8ogPDoqY8X5WcOd2huS8ISbIxokgG+WdKFqQjv3AP4EHTIu4pqwn+lU5Hj
 9ez1x7PDkiPI79i306ZihaQ9K1Rq+Y39Rm3HkOJDxRC9fGQCxTS03V8B5bdn7TxuwdTxzaI4/5S
 yO0rLqru7hTlOSPX7humlzRE10p0mxHPRC9l5yU3USGQ9cvjH/h3Lrl1j3EVlc4mwO6AjOoa9JN
 EG8zz65bAE7sDuUi/sM9qTEuwisDAsG/uxx5elXLzEe8VglhGwMkXQ1vKeGMjpOR/UXGmYDGYZb
 gQI4NsjU31y2jRllgdap/fgoEnNCG/zgRHPOX50b+aLQ6Yx6thAsvZwHPBjmYL4r6ZMfuVkVSS8
 mbqtPT0Wcfh6ZyL60mXCmwG6L5KaYqUEfE6GlDj2yyl2OgVW74ICKT6UXdq4PKBKBK33VdfGI1V
 lwQ9LivQTayAufGNtBw==
X-Proofpoint-ORIG-GUID: hcKWcGceDWVX8X34iPdvA9ngfGcq9iPf
X-Authority-Analysis: v=2.4 cv=IbSKmGqa c=1 sm=1 tr=0 ts=69bb9004 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=2-u-yepbH7nZdbuG-UkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hcKWcGceDWVX8X34iPdvA9ngfGcq9iPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1011 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190044
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-227211-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,quicinc.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuai.zhang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4FE0B2C66A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi  Luiz

On 1/16/2026 10:42 PM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Fri, Jan 16, 2026 at 4:48 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> Hi Luiz, Marcel
>>
>> On 1/16/2026 5:20 PM, Bartosz Golaszewski wrote:
>>> On Fri, Jan 16, 2026 at 9:37 AM Shuai Zhang
>>> <shuai.zhang@oss.qualcomm.com> wrote:
>>>> Hi Bartosz
>>>>
>>>> On 11/7/2025 11:37 PM, Bartosz Golaszewski wrote:
>>>>> On Fri, 7 Nov 2025 04:39:22 +0100, Shuai Zhang <quic_shuaz@quicinc.com> said:
>>>>>> This patch series fixes delayed hw_error handling during SSR.
>>>>>>
>>>>>> Patch 1 adds a wakeup to ensure hw_error is processed promptly after coredump collection.
>>>>>> Patch 2 corrects the timeout unit from jiffies to ms.
>>>>>>
>>>>>> Changes v3:
>>>>>> - patch2 add Fixes tag
>>>>>> - Link to v2
>>>>>>      https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>>>>>>
>>>>>> Changes v2:
>>>>>> - Split timeout conversion into a separate patch.
>>>>>> - Clarified commit messages and added test case description.
>>>>>> - Link to v1
>>>>>>      https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>>>>>>
>>>>>> Shuai Zhang (2):
>>>>>>      Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup
>>>>>>        during SSR
>>>>>>      Bluetooth: hci_qca: Convert timeout from jiffies to ms
>>>>>>
>>>>>>     drivers/bluetooth/hci_qca.c | 6 +++---
>>>>>>     1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> --
>>>>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>     Just a gentle ping. This patch series has been Acked but I haven’t
>>>> seen it picked up by linux-next.
>>>>
>>>> Do you need anything else from me?
>>> I don't pick up bluetooth patches, Luiz or Marcel do.
>>>
>>> Thanks,
>>> Bartosz
>> Could you please help clarify this?
> There were no Fixes: or Cc: Stable in your changes to indicate they
> need to be applied to the currently RC and stable trees, in which case
> it will only be merged to next-next at a later stage.
>
> If that is not correct then lets us know if that needs either a Fixes
> or stable tag so I can send a pull request immediately.


So far, I haven’t seen this change merged into linux-next or any other 
branch, although it has already been Acked-by.

I’m wondering whether I might be missing some information, or if there 
is any additional action needed from my side.

Please let me know.

[1] Patch history: 
https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/


>> Thanks，
>>
>> Shuai
>>
>

