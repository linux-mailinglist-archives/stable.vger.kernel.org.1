Return-Path: <stable+bounces-210273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E16D39F75
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 08:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2DE030047B6
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 07:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE152DB7AD;
	Mon, 19 Jan 2026 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5bcQ3Bg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NOtTYEBq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D192494F0
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806888; cv=none; b=nGzpq6RlKa8H8sNZ4SSC5Ab0VnnZ1uT3eo0LX4JQTESCo9v9LHRvKKJFwDudFl4DCOUtfhA1RjL9F2TzvfJNh6TBX3AymTT8nnWCBjyu9jjTWdWeetmpGG18JXRKNV32TZVJz9gu0F3xmjRNxX6fGQmMY7yeakuLpUolZ8y+tdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806888; c=relaxed/simple;
	bh=5fPllbsOf7sccFo5RXhDhCDsCKJFQkF8T9XtQ7NNf2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZAkMIiL5Bt4YAT8uJVmyWwrBbE+SWgfXkNAHUlkRWV0CxTQgnMyRQxlGzCj2qZeRgnVjv53tL7MgyuoZe1cOWtVfQYFM4P6eg+V8H0W8SOlUbdtW29QtZ+qDxxQAZ0H5LMeWVzX782qJyDhsWQPoVdyEf3YhjVBD5rQBlTRxZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5bcQ3Bg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NOtTYEBq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J5V0Q13010904
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 07:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5WfZUJN+4yyrEknLJ+I9YLz3L5ZjIyay+AUARwvRzZw=; b=B5bcQ3BghjX7/XIL
	kHDxyfbB4oy+Hn29hjlD1MQUkE0orp0YfSnWgJxAL0yFPEsGPs8wOrhKKu1J70hD
	p8a4AOIogHfI281bK4qrnL3ABK42Gowf5pcIzoc1HoMjRkaFghSL4cHFVBWZpW3k
	BjD+2XfRBJuIuhiEkcgC1Z/ruoO/ooMi+nh80jXCBGoLLunSgrRPC691QqUs4TsJ
	Jqhzhg3teFMcYnDN0gNpCtXW+3lkNxBShCJa++6iMBOswRmJsDTvcPfRRnZzQ+O6
	QYRFF8j4/D4GclDY/8KnW0D662F2ZoiZSIQ3j3DcCRwhwqAV5b9V70ulMC62c8Yz
	slEXrQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br2gum44p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 07:14:46 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a377e15716so82389395ad.3
        for <stable@vger.kernel.org>; Sun, 18 Jan 2026 23:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768806885; x=1769411685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5WfZUJN+4yyrEknLJ+I9YLz3L5ZjIyay+AUARwvRzZw=;
        b=NOtTYEBql61bpuxuM3VikKcrqZXdEBdakj8U+74QU6Gul8dKfq5mBvGwhoIaeKIDH8
         G4xSr3jeXnJS4uUpQFZx4zl+9/5zTWiuw20yBWQyNWZHHnbdRN83Dyay35NwB7Q8iRmq
         abOZiEMirp/67o8MaMhwnBrOdXYdnWSBoRhG3kDz0EXFIcMiaDuuzQpHIiX5ji4zWhG5
         jPozlUlR6ReZdHgVmBMhLe2ohQHZoI+7or+HCfZRbLYtk70ZXLEHqoJRTSraPgL10b0J
         z8YAHFNP4w0raErWKwGr7WWgebMmX9tr596WxdoLShhmGGY0lC4QctqA1iIPhQNhid1L
         oPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806885; x=1769411685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WfZUJN+4yyrEknLJ+I9YLz3L5ZjIyay+AUARwvRzZw=;
        b=VzkDxQv7rSy6t1t/SBnIWDASqJxkkRmZcheMxI6izS4VnG7kH9JPT4VBaG59LGpkW0
         55eQluZEEalwZ9ayhOY+Ja4i9+cCXLlQKszKHTp2sCa6fySkUwG6OAE/Ltpa3zXnVhZx
         /ApcyJaQELVIQhtbkzh6hku1SaRFOpr0Hkkdj7rH53W8usfuE7/Rbai+ntghrBzAFKBt
         UawFOd/dGn/grawPEjDG+fi7MMWEbaeSlhY3LRiQuW3V9wtr2VgiQeIiPdxxClZm6EZj
         WGzohbmKggSds648SiT36u1SUNM0F0l7nhNHGG9zF6tt8XPH7FaWHZfJKVx8eOLnrck9
         j6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQw96rnCE6rdUYQ28G2te2BHmHW7iWRe4E0pUttFY+pvI76khmAo24PaHbp/viAniw+AkWU4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/XWz4cIhGW8L/OccvfLlh4AbLAJmvJpH7YhqGoceX37sLCCz/
	YJfspaKJQulCyDAZPkQkU6g1agErEEoPjBBwXuXoXpHP0XhwKEh5W4vocdmv6Upwt7GsQyVvwdR
	tBhKULZ7gMFPguSWwqQlJiw9gDQQ4VxMYDKvwCiEC0wvVtYaUP/EhMxNiJwA=
X-Gm-Gg: AZuq6aK1YmuSuwoVSJdKRc8wSR8JvB+4fmnmxKLibFIsYUmjMu36OatY6sNKtVxnmqs
	NOheeJzPYBmJZgNWp7yd2amvCDeqjHMf2XRTxxr80PceMz5MIiuThn5rzlEXehZwi9OmF/1i0H6
	0msZvW+KhiukiD1BWibGCchmtA4TriIKhov1FNKlPRCvWdi3RuI/7wQGD7MtLU4hdwem9Pxnnnu
	aJlKSjqgcjxt+w8ncJVU+eZzxFiR4dB4cnpvBS0QtqhuMt58hOlNFYX4wsJEv3/9RAlFGm/wYAS
	r5ibgcLKM+eOb7SmEOApoWaxHZrs8k4KTb7eFP2Vp7FHU6kFwZCfLJC4bP7MSSl8QK63MEPzVBY
	ueHbCWfBOSlm5Ryy2A2duKv+fdVmSMSBOWls=
X-Received: by 2002:a17:902:d549:b0:297:e69d:86ac with SMTP id d9443c01a7336-2a718914867mr106392655ad.39.1768806885180;
        Sun, 18 Jan 2026 23:14:45 -0800 (PST)
X-Received: by 2002:a17:902:d549:b0:297:e69d:86ac with SMTP id d9443c01a7336-2a718914867mr106392405ad.39.1768806884680;
        Sun, 18 Jan 2026 23:14:44 -0800 (PST)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193df75bsm67919475ad.54.2026.01.18.23.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 23:14:44 -0800 (PST)
Message-ID: <cdd9dd67-5281-472e-8e84-65a578f999a4@oss.qualcomm.com>
Date: Mon, 19 Jan 2026 15:14:38 +0800
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1OCBTYWx0ZWRfXxm3jzmEE174j
 SouUwUu3Y+IqU7erKY2vR83pBngTBk0xa9GloX6z5BahZicnIklZNzeMM2xQrxXgnZpjLnYgvOG
 yNXTgdpsVqA5CesXemML0QKHxmg7hgxMbcLIepDV9Vvvlr/zqu147w98sm7/8UnR/9n6fkmTSVA
 eIM5hVuM3uumJMXlKBwVkO3sreFpgh0/x5p3puA6E+6w+IARd3OMqOwHPwkydK8snmxjXtJduy4
 BUykCAIYa3xvUhEvEQDu0jInrlHjsrXAcPN7Q5qfIaEXM1ZaECFBt8wY90Yb5n1Q58o4sEIUil8
 dIz3ZBa24PuL0yAetWyDR5yLcm1e2J4yGilkat+kqDUC7SVX2xWo05qKgM9i0FCOOgl5IM8KssX
 aBA56KGgTyGCA1VL6jOfVpGQSzmCh3sf7xlr6QkOT+ddoQPki4xJjyIBH7Q4NX+9Qe8DV51cpFn
 LebizZCnr9u8k8EmBhg==
X-Authority-Analysis: v=2.4 cv=Sev6t/Ru c=1 sm=1 tr=0 ts=696dd9e6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=oRiKqNWV6AETYgLPPlIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aLSj-qNl7FNuyQL8MakomHORMQZjzKn6
X-Proofpoint-ORIG-GUID: aLSj-qNl7FNuyQL8MakomHORMQZjzKn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190058

Hi Luiz

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


I will add Fix tags then update patch.


>> Thanks，
>>
>> Shuai
>>
>

