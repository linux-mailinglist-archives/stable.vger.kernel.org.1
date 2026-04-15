Return-Path: <stable+bounces-238013-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9Bi7GZv+3mm2NQAAu9opvQ
	(envelope-from <stable+bounces-238013-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:57:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D78973FFDEF
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B666830E5E2D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14253148D8;
	Wed, 15 Apr 2026 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mCWrYkCT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hUFS0Xl5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2172D3016E0
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776221391; cv=none; b=cyy7ev6O5FWlXT4LjT33IcbA6kti3F4EI+iLhIQF2AuJqLKkSwel16FX5UVYD9jNWwacY99N9YUBDAinOoWm2uYT/ICh1XMwlllWTkiP84A7fcwSUlklK/dsM/UBjb06DujJStSPAyE+RuwMwsZkfn3BuHk8o3fBL+/Ul1RTM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776221391; c=relaxed/simple;
	bh=JFEi0VD48StKC6owki25ycmNF/t8sTADQ78yU90b22o=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fm8iqQqETfa1U7SzC7rHkKTbyE2ko5m3Yfo7YFuuw11BvFE5HmQcLxyzQXFAaNqJj4qH22YS6vHExgi8gyUWk9FdcOkHERu/hPolI7tbqTDSA3C6VPvw9OGhPdoswOCg/b+CM68Frl14DI9xjSS2zSrOT16vrSnDRYstF+CTso0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mCWrYkCT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hUFS0Xl5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EHbXJL3126613
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4r/cAuIiAsQKjwiHb55odcavxKshbzULhKnHQ931Y8w=; b=mCWrYkCT8qk1NUkB
	bewW2VfbzffXXXquDehlKK6/SDL7mFZQH55DugkuLnFg64kT7XJoqxrYi0TYOrRE
	76GVArR9Cia4n1O+qSKmEzNhloTNDVRTfsj098jmpXPWiVWdVgqtjkiUzriPnBpd
	Eg5x24Sov0BJH/NQI0NHKv/j3VoDN8YQegEu4aNW+ZlJ+cnpdAViPlOcS0sSThyU
	H3io9liQVlYG4UCkDFpr2q6/oSDUGXTtmg5PdTpzx8hjK8XNnhNGOV164jkOdS9S
	YV/ZQLHttedaP03ZYkx2ECXAHvrkcy7lqlTlQpkO42nHddx0fY7wkcFC20UeA0r7
	WIGUWQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dht56scv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:49:49 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-12c20d5d7f4so13235068c88.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776221388; x=1776826188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4r/cAuIiAsQKjwiHb55odcavxKshbzULhKnHQ931Y8w=;
        b=hUFS0Xl5KD9YsELGNZrZuGnZ/mPAZHp7ENOtXFS+qPjgkS2zobuNoF7g/LaXAZOIDv
         lmAjkIaJ7SBdC7HLAedJIIYSfOiZ8t3CSugMLO1rYvADN3U1GebApnhXe/PxvL3/o7KQ
         ULS0bEuK8N1XFECRobhxcNqQQcTeuE9Od5pUVq8Pl76wyO+h5b82llXB+MJT/WTT3IbM
         KHdw5WSb0FxCWQXJigpOzXNhMBSYiuXTJiKJ4bABtaBRbqwggIrsYa8U/UquaTJpLgG8
         I6p46G3UxUb2TXVOFLofhoUiGBJqiGYs/Aspo8UUkK8pmvKrleBzzxXdoOd2GR8H/1So
         hE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776221388; x=1776826188;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4r/cAuIiAsQKjwiHb55odcavxKshbzULhKnHQ931Y8w=;
        b=CV/415I4bH0hfWrVSQxZebbusaqXfZTNgXGqOkFqBBf2/ZHn20a4wdnQ1oldcqJkmQ
         1N/plW2jTMg53mg6InFsA61B7YdOFJVaxGXlfqh2LS+aqfxUPgjmmSzPqbEorwV7BIWe
         LfCA342dHPecrURRFTgBb2PQT0Bls2rwfBVDGEV6Wzb0n8L2byx8nsEQeaOM3mQe0HMk
         6nKCV3LYQ+akd/SufdO1j9HwZuAMQFm84cbqu+I4UnfuePS/J12Kz0nD1t84SMUH+HYL
         B0UdPM6SXHE/Siq6Qq9XPGj9IEZyEWHauZ/Um7daRy+BMpMEw5MQ0sKvevoNp86z9Kvt
         MT8A==
X-Forwarded-Encrypted: i=1; AFNElJ/GofreJTR9vEgkw3RvHJUtFKmCawNb4QfXLMUbZjR6HekfNEQSEBFvuMC3GI2/G7oidZOJaRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRk/0sYVhosdl2nuQ+jvVxgOqKZ0zJFd69ws9hEiATipPWFcH
	PGadvull7FYYAYtVdZgp034yYO18N9rAmI/w4yogGjQGlIyVE/XB/V9cOXZWBSA9OtAIWG/T/Tv
	PZMrZvq+5pSlsA6ty/NA7gu7eD04vzr9jY3mZ8Bg7KSSzq+yye+VHy4h53pg=
X-Gm-Gg: AeBDiesnDzIC8k2k4YM1ioIMTXyuTCVtOLU4MpkH5UwEoLRHdk7AFQPkOBLuk8kZiBA
	g9MCKk1pIcbqdDnBabmgCUUBXqfJvs1NZ2QbfIrYsHQpJrt1JkQGKNSXIP5Ew2OceDjFlSivLZG
	1fJZLp5nVUo8UHYjUAfrBYafq2Y7V+t14Xo72nW0WXSiKm/3i8UCiAa1aB+KS+vFiJMnAwbFk3R
	yYfkGJ51666CQmqt/jAFEGa4qZT+P3xeDfwHaHWCihG8by/p6T+uHtf4vYo8r9Zm6vt767IBdz8
	+FIEnd1aQZtM29eGabdo7YnS4okELcd+xDt7BWR0pPHM7jn9I4h5mFn4IhrJ4ZyxpWH/liqBRG3
	B9SZ6n72uxBN77D7SoGTLGOLfZbjALXmJsEdJCChDPovJmKpJ
X-Received: by 2002:a05:7301:1017:b0:2c9:1943:e7ff with SMTP id 5a478bee46e88-2d587d80ee9mr13078008eec.10.1776221387996;
        Tue, 14 Apr 2026 19:49:47 -0700 (PDT)
X-Received: by 2002:a05:7301:1017:b0:2c9:1943:e7ff with SMTP id 5a478bee46e88-2d587d80ee9mr13078000eec.10.1776221387489;
        Tue, 14 Apr 2026 19:49:47 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c605883sm710270eec.10.2026.04.14.19.49.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 19:49:46 -0700 (PDT)
Message-ID: <e41ee37c-c93a-44c0-9168-79bf59550859@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 10:49:39 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
 <f6a9419d-5e63-4c36-a7e9-aab6ac798703@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f6a9419d-5e63-4c36-a7e9-aab6ac798703@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LuiiDHdc c=1 sm=1 tr=0 ts=69defccd cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=PU9PaiTs9atMpjuS6XkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAyNCBTYWx0ZWRfX8clgge/2B49C
 6GnNZ9nQlvgBSSImbwNFTCXve1gh+0I/gKrrPTd0g6SXq4curW2vDIGyapkFwiLh8lD7q/zs3UN
 8Q5b1gA7oz5Q8Wn3xubhxzGb/nyW0klp8rcGtX7AbpJdQlpSG53FinjXjmxTz5nKuPgUhlEbTkg
 qJC1aNiGg0XQzuLJb7Y6e1vF/DZI1n0ITPbTXE7oJPpIxd7qjwKEYfAzq69vlwrS0Aszv1IL/UI
 Z7GZpgecjCC5CwdhEo0fXGI6c7o/RYvRKmzT2GLXPaOUvqdGuFZjBh69HjbaO983ApSCf9ft0Wg
 QTkGvFmveavBgBX4ijxvxLCtoj2f3K8sOHaGGsKKlk0xMrys4UjbxDzQIGjpqy80DgNEsFqGaZO
 V4efi9JMLqMC6hGlOQj8LVwkEck15brUmul+tYW1bj8nu3H3gCQKQEuUWOLgAahBEa41PDgcuS0
 3S2mfhxLZqTAhF2882w==
X-Proofpoint-ORIG-GUID: 83Mc3LQmgGBiAFBkzw0A-vQrO_oVHsXR
X-Proofpoint-GUID: 83Mc3LQmgGBiAFBkzw0A-vQrO_oVHsXR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150024
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238013-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quicinc.com:email,qualcomm.com:dkim,qualcomm.com:email,mpg.de:email];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuai.zhang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D78973FFDEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luiz

On 4/10/2026 4:56 PM, Shuai Zhang wrote:
> Hi Luiz
>
> On 3/28/2026 1:53 AM, Luiz Augusto von Dentz wrote:
>> Hi Shuai,
>>
>> On Fri, Mar 27, 2026 at 4:30 AM Shuai Zhang
>> <shuai.zhang@oss.qualcomm.com> wrote:
>>> From: Shuai Zhang <quic_shuaz@quicinc.com>
>>>
>>> Since the timer uses jiffies as its unit rather than ms, the timeout 
>>> value
>>> must be converted from ms to jiffies when configuring the timer. 
>>> Otherwise,
>>> the intended 8s timeout is incorrectly set to approximately 33s.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory 
>>> dump during SSR")
>>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>> Changes v4:
>>> - add review-by signoff
>>> - Link to v3
>>> https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/
>>>
>>> Changes v3:
>>> - add Fixes tag
>>> - Link to v2
>>> https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>>>
>>> Changes v2:
>>> - Split timeout conversion into a separate patch.
>>> - Clarified commit messages and added test case description.
>>> - Link to v1
>>> https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>>> ---
>>>
>>>   drivers/bluetooth/hci_qca.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>>> index 228a754a9..d66af13ab 100644
>>> --- a/drivers/bluetooth/hci_qca.c
>>> +++ b/drivers/bluetooth/hci_qca.c
>>> @@ -1607,7 +1607,7 @@ static void 
>>> qca_wait_for_dump_collection(struct hci_dev *hdev)
>>>          struct qca_data *qca = hu->priv;
>>>
>>>          wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
>>> -                           TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
>>> +                           TASK_UNINTERRUPTIBLE, 
>>> msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
>>>
>>>          clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>>>   }
>>> -- 
>>> 2.34.1
>>>
>> https://sashiko.dev/#/patchset/20260327082941.1396521-1-shuai.zhang%40oss.qualcomm.com 
>>
>>
>> Comments seem valid to me.
>
>
> https://lore.kernel.org/all/20260410085202.4128000-1-shuai.zhang@oss.qualcomm.com/ 
>
>
> The wait will be woken up once the coredump collection is completed.
>
>

Please let me know if any additional information is needed.


> Thanks,
> Shuai
>

