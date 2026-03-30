Return-Path: <stable+bounces-230983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPuQHt/SyWlj2wUAu9opvQ
	(envelope-from <stable+bounces-230983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 03:33:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C37535497A
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 03:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED582300232C
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE1426B755;
	Mon, 30 Mar 2026 01:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EEbmzDGp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q9SVjtIS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD43C2638BC
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774834396; cv=none; b=rp+uK5uX+YSc/cxeBcI1kxBKl8roWfu+Nvrtxhvc6g6nK/HIjkIOcw8nfb0fhWMgOJYxQdBOMPYtBgvrQ0qWmWjamKnP52yS+HLoTNa4v06CWbSasDIOZ6qozSivznkKA4mP9U9v1NR1gxgB+r+p2dvqgTDnFFcMr1kgKvp0xu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774834396; c=relaxed/simple;
	bh=jhRUsi2abn4RL99GkvJy7e3OejC3t3RdEQ9XYnNq2qY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FotSipYfn5GEo2m64N/z9EdD3pwUUwWzL4lZvLxEIxbBTtJca3sDhMRBFKbMp7GWmvUzxudvUYL+/R6TeoMWbrHnFQ8a6Ya9oCrvYhosKxFsaJx2DUkNnkrfCxUiAJZ1S7QgF0CyYd3UxHOtsnhY1iv9zYMiGjwFymAzbU+RJJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EEbmzDGp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q9SVjtIS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TAhkV7866310
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 01:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	go/zEsryBvkHqam+eTEiWB5UJtTv80weDZhW169qTyM=; b=EEbmzDGpnZcWFGzH
	xC+Bc+LZhPiza7AGodxCYuHNpdE0yA4jx8kEhXjaJ0tycXid4yFV7rkwjWpqw3nv
	/FrA08xcgrdejoSLnzqbYUClRnQevUWskzn8rVXG0xFaMSRWJ7TYcPEHVutmYB1V
	PeKgRnnGbFZzPXH6FfFYRecrFuCk1DV1jAU2GtPMTK3vS73LHiOqJSy7vhy3jpXZ
	PCicq2E9dag00rHp7UfDejP251J3s1dGoI4h/xwazC0Z8Q74bYSkAGjSgMxj1I2c
	pm/D5rJJRZAw08N3g720L/jKnd8hkGa1GrxqMOA67lcKrn6YJmLFdRiYsgPL5A9z
	068muQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d685hbvfy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 01:33:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c769cb60d7dso270539a12.1
        for <stable@vger.kernel.org>; Sun, 29 Mar 2026 18:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774834393; x=1775439193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=go/zEsryBvkHqam+eTEiWB5UJtTv80weDZhW169qTyM=;
        b=Q9SVjtISDBk2bnR5nUJWXrBfFFhoETWEd0GHjK6rQy9mXqRRB332XmIdlhoysRU+SS
         FdK/t0b5zHarext1UhzVIiiY606gxG1DYqQPvPIJjkF0gPNzYqFKentxW0ppv/OG7wAL
         mS8p766ZOcTLfRO/ZRFIt2EzxxmjK89ohdFvzzBI0faTUinTOk0nCfPEt63C+NdSpqqJ
         +3nrf9F7RLyJyedoW1TN1KKMb2qtccfYP57+hiFsN2YacIpoT666coRiUwWLRifUPjw9
         OgXZKEkyTcYOeqLInA+v+tNugUs9U0nUMAD9N1IWwHfYiwI/G2sIylgDGzi7qlH4YjrT
         suDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774834393; x=1775439193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=go/zEsryBvkHqam+eTEiWB5UJtTv80weDZhW169qTyM=;
        b=Qd8DI3cFeMYl8nTkQMuRrQ4wc4iIABcLfcpCzkHu0ClOY1Msx6elfkszsX9zTy9j64
         Yn7UF8nRPqm4XJgq6hUqCQuXIR2MNx5AuoahlS7CFmcvjBF+2d0iXSe0LiPNiUDfgdIh
         jdKvkwfFyeA9OuKrTtV2esUioVDl8xLAUhD9USy/i5NrewERTOlZrLDlDz98jKdmLRv8
         AJjUEdK/9GmJWoCM/BvWbid0CyLwskZVgUNfwY3u64IyQL24/hwXRZIVDsI9dzRx7HWF
         v4xSMdEAtNDXrqoigQJzuICTunI/DErzsCraxUNQ+uemX75+iPAtlK/X9l1hjnZhtrks
         E6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/Ad5n1CXVH3SxoaivLYnttOaMXgIAXkkMCYXauubgvouoYvgNYCJyYyE5MsdccjljFAm428=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmSQ+C9u7Ak4DMYRXXJCjjYJOnPqYv2G8uaGzH8KiSNNFJzZ3Q
	PVkRy2IAi7hOjzhH6JTjrVBZ2ZJ+WvV+m1XJ9NQtJu8cQTZYB/jtaSYzs1bzWUuRPMVNE7DpeMc
	aEzyOsUtERJ0HkTq2Pv+QS1poiS4dK1HW6HdmZEyHUrO+Ihv+TGKdt6i/IwA=
X-Gm-Gg: ATEYQzz6aCydWnn+5rv52QQhO+53S+TjtD5XJCj1Nma+wjPZxqj/dEwklAB4W52Wmln
	cdCWnxhwaje8mhKBjnn4bW1gW5UvHyVVf3M/ONiAfe6rFQVgcEFSnimqSXSRfp61bTHF6G2L5rP
	/IZnozSvNa5IuS2/+IIXoQabRetOfx/x2dZ/+vDGtnmp4CMkw7+ypKSeh3oi/ByNus7UzgAhAd+
	sAnvu926cv3pQX2SV12Ki030K+8ykAKMF8iDRKwW/9edyJg4B4vAu3NCke6RdXUyAKL69Gazp02
	ofcM6DNBsFrqKX8a2gkFQAgYhnAALTEwPK6znxzTEEY9aFXIck/9Y4I1IqjYGhznuSrQ2a/CQOc
	WtbPtCd30flnKRL1j4JKijHuIlpcUyZOzUEv7uflFGOpICecs
X-Received: by 2002:a05:6a20:3d23:b0:39c:cdb:5d7c with SMTP id adf61e73a8af0-39c87bcf3aemr10512725637.58.1774834393285;
        Sun, 29 Mar 2026 18:33:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d23:b0:39c:cdb:5d7c with SMTP id adf61e73a8af0-39c87bcf3aemr10512711637.58.1774834392835;
        Sun, 29 Mar 2026 18:33:12 -0700 (PDT)
Received: from [10.239.97.158] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c769179e30dsm4856214a12.20.2026.03.29.18.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 18:33:12 -0700 (PDT)
Message-ID: <852c8b4a-f45e-4b9a-9c5b-249c493d7c8b@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 09:33:01 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, Shuai Zhang <quic_shuaz@quicinc.com>,
        stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
 <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
Content-Language: en-US
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
In-Reply-To: <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=csKWUl4i c=1 sm=1 tr=0 ts=69c9d2da cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=c92rfblmAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=mEO4ALF7hCPe5JJGosAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAwOSBTYWx0ZWRfX292gGo7yTJZE
 HsSsaBA7lAOf0K8aG1EOWlBLiqEEcr+ytLCMsgh1D8IL6oGK9FFnsfReJyAVo/xL5n+jghtMW62
 GyFk1ofJxGlSJpyHaTZfKznVQtJgRgNIflg4advpRuiJT/WJCirk82RFdxYFQhc8P8IWP2IxV1y
 W8UFrOS1l66tWJuo2JkoE8FQlfUARBrWj3WhOAgCMJyw8pH518iSZbt1PXuN9nmso7BKmkoYVGb
 6N5t/ShdLxrz8ZEOzvGdGURS3e8jyDrUqYDyDG7dQM+pUpFk43wQc9tJ0LSfeXrzWMDh+Tgoyw7
 urxMygCgLK3YoryOM0bqmpGXCLb4EhjLhyp22WlsmaDKYPRMimZYH0AKT46QPOxJE4LOKpiPNDZ
 TGnex6uuKSXLGysmZ7Q1zs5caVKnHYVyLkmzCkVQyZe4+p8H9HzYxUjUm8H2f9EAL/o2Ve9BpiM
 DIcEyxXnMG4MRpTHtCg==
X-Proofpoint-ORIG-GUID: rKsuO1FsR4JiVds2vsducnqdNlzvsVhS
X-Proofpoint-GUID: rKsuO1FsR4JiVds2vsducnqdNlzvsVhS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300009
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230983-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,quicinc.com:email,mpg.de:email,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 0C37535497A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luiz

On 3/28/2026 1:53 AM, Luiz Augusto von Dentz wrote:
> Hi Shuai,
>
> On Fri, Mar 27, 2026 at 4:30 AM Shuai Zhang
> <shuai.zhang@oss.qualcomm.com> wrote:
>> From: Shuai Zhang <quic_shuaz@quicinc.com>
>>
>> Since the timer uses jiffies as its unit rather than ms, the timeout value
>> must be converted from ms to jiffies when configuring the timer. Otherwise,
>> the intended 8s timeout is incorrectly set to approximately 33s.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
>> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
>> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>> Changes v4:
>> - add review-by signoff
>> - Link to v3
>>    https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc.com/
>>
>> Changes v3:
>> - add Fixes tag
>> - Link to v2
>>    https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc.com/
>>
>> Changes v2:
>> - Split timeout conversion into a separate patch.
>> - Clarified commit messages and added test case description.
>> - Link to v1
>>    https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc.com/
>> ---
>>
>>   drivers/bluetooth/hci_qca.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 228a754a9..d66af13ab 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -1607,7 +1607,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
>>          struct qca_data *qca = hu->priv;
>>
>>          wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
>> -                           TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
>> +                           TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
>>
>>          clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>>   }
>> --
>> 2.34.1
>>
> https://sashiko.dev/#/patchset/20260327082941.1396521-1-shuai.zhang%40oss.qualcomm.com
>
> Comments seem valid to me.

This comment is valid. I have addressed it in commit [1] by updating the 
completion path to use |clear_and_wake_up_bit()|.

https://lore.kernel.org/all/20260327083258.1398450-1-shuai.zhang@oss.qualcomm.com/


Thanks,

Shuai



