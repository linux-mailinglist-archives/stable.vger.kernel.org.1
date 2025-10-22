Return-Path: <stable+bounces-188919-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCA6BFAB78
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7FE1895FCE
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7C62FDC2F;
	Wed, 22 Oct 2025 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3FrZTvm"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B472FD1D0
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119879; cv=none; b=aBy6yxGrIvSLL7vmnLmEWrPDbY4rPfDI3Ldsy+79z68QQuCB4218juQ+pozuj/nX0TdgFIouMUxeFSlxXh+R02PfSNj72xdXJbKdVt6AW2NP9ICDo1TOD1xmAM9hvPP7xSZS5wQQvAsBejocaF9w1Ss14CU4u+5OCZnkNzF+ABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119879; c=relaxed/simple;
	bh=1MshIsOhPZZtUvhlLkXTb/ywrfXh5+dzPkN5+5Pdpmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUMK5BU+utMTt9fVV8U1tPlneMGqiVIgSpeFMS4ROKqjIkvybULKUf4OFW9yvVaV5P/S0CC97AbdH3Nutc82n39qKXxU/jA9H4+Zt7R79aFpRpXXKYTdr9mXuSo4vpo/RDci8UQUYe8FXi1WOrDuwhnwz5gunZPhP3roVrmXtNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3FrZTvm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2sFDW005242
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 07:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zKCpASVkSEHOs8PWao32o2/CeR3cTvfo93uScS7Z46M=; b=J3FrZTvmZ9Iv33uH
	TsKgWFkpwqGsAW1jEV3nW1I6Wfm3IQA9/uwQmzC4i5p9K2WLWJC3Lfa4/3vUMfPH
	R3bDAN/vQzaI30zHGBEFkvJYS2mJdzGgezi4C5Cvmx33a7HhDxog5336xpJ2KrXb
	JysjD7mu6ELuaFSNhP/ADnWTKv5RIxVhB0qgeChHLXFA4kdGNGdv45J1+dna+YiU
	4PJogSEqrtZC6wR+YGLeiGmTQ5RlpB8F4PIDZNurkz+UMpTj6so+kPfjXzfV31Aa
	8zVazreLcMDeFlX0EDsM1wo/Nfo86SzvStGfQPF4nHP+bd5bVfrby77+B47tp9gH
	Y5JoAA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3nfkqst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 07:57:56 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78108268ea3so659834b3a.1
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 00:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119876; x=1761724676;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKCpASVkSEHOs8PWao32o2/CeR3cTvfo93uScS7Z46M=;
        b=t0xS9bRO9VFeXBFoj5A2cLo4o1xJM/bm/RrJnOmMN5aF+JNdABMrR3rlKtSroAIUko
         Gt1q3Nr5biUloSJCXE6NLRvC+d98cC5HRKElepAaUnPNAZcB0RChm3Tuc4cYHrchPm6f
         3m4yJOXeCUdtVxLbmynAhCFWvomEtlns3F4m4o4Tao1j/WRAYXPoSnflQ2M921PNwhju
         bLn97DppWvNCuY3OmPlKJIBk/LRhTX//JpPulQNmSCIpyWi6xrR/InjKVQA4dSwUN95d
         +8v9DzzsHgrpHxTMdtGG12Z3saznib04YktS/Z0W+ofll/DT0v5UHldd2/GDSkUcEuaZ
         3OvA==
X-Forwarded-Encrypted: i=1; AJvYcCXeMTA9KRL8m06CBI9qSMhbV8RbdpoaFuhLZ7ZCYlcI51O53saqMSslXuth7ZVxiySMDtJ/FRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzhlARLeoTofDVhpcRZzfDyleYwZxlS+ZhtPj49zkYS3o0v5jh
	Y74IK4gKJmycYDKjmn9PuhtAs+an2x5JDEMK5Es689adm61YG5JGvwW6SwZ7ydGoqkFabnXQT/1
	PaRZIlms3+DCxcvxGzW0j9DqgqdS1AiHNA2c0fn8MMWMlw/CfM0NeNTb8r6qs9fiDVM4=
X-Gm-Gg: ASbGncsZfHmuwKhj2nfCK/2iLLZx2xgB+NSuta+d/uPNUzFpVGV9GOa85aC0ThvCAS0
	G4iEjv0aqQ7ORMa0tHkyso24VBE6MlJsdXhvzJBR5U0ihUEDHjlMmVh3r4GECI2djO01yf+L0V1
	kgRYAKyIrr81jM8JizWDpw3O4M0+bKjbUQne0HYkg6aO5MgYlmzVha2JXgHlGOQw5fGZn4vEj/V
	thZfTamZO/j29nRB+RvYCtJCE0cKiObQ3EBLNnw8CF3SlA98ofpSoW8JhPZUMqLz3TEV57oogn5
	KqnI4M9f6NgnPMDSx4kKWWppAyYUqwghy82ldOh34t02hddPyii/5uCvYBmoY/cBkV4guvgaRSV
	bJuuF22LEj7+Ogszv277RRZn+JwT7nU7dif+fUXmma5zVs25dRTCEc61GY4GX571xGqfzAicD
X-Received: by 2002:a05:6a20:158c:b0:2ca:f345:5673 with SMTP id adf61e73a8af0-33aa80b9cf0mr3343194637.27.1761119875576;
        Wed, 22 Oct 2025 00:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQrMZ3+KoL7YTWqjC/NNOCSrl+HNCyBF041iti9PGb89VI8BhU1vl6m2r+vYhJ6Fc9vaaI7g==
X-Received: by 2002:a05:6a20:158c:b0:2ca:f345:5673 with SMTP id adf61e73a8af0-33aa80b9cf0mr3343169637.27.1761119875048;
        Wed, 22 Oct 2025 00:57:55 -0700 (PDT)
Received: from [10.133.33.147] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff5d76bsm13616866b3a.33.2025.10.22.00.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 00:57:54 -0700 (PDT)
Message-ID: <29734775-71f8-48d4-8202-fc7aaca99f14@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 15:57:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: wifi: ath10k: avoid unnecessary wait for service ready message
To: Andreas Tobler <andreas.tobler@onway.ch>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev
References: <03727147-0115-4ce9-b68d-756c6e41db94@onway.ch>
 <fe63bbbf-3833-477e-a820-d41e621e6a41@oss.qualcomm.com>
 <da61ce87-09c1-4992-91fe-358225e0ea1c@onway.ch>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <da61ce87-09c1-4992-91fe-358225e0ea1c@onway.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NbxemvbdVP5gKtxsWW8GqXtDNzFCH5FF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNyBTYWx0ZWRfX87U6xe2mtdAU
 qGITZGvLbMF3o2vB+3++p3h1nzfwnZ/roaei75OKxrZSn0E/w6/nqM7gP8W72QZ5yN5X0KgWNdU
 +wgsAgtRamWkbmIdKJGyV04iTw9mViHE2SNZIywJOR9XXp8ZMncfZFks67cM21QjP2ViXu62pak
 8TqFNCL8ku0Eu1J8teb9gKpLGQk9tku5m9FcxyurEjzoqEcCjYinD7xcSQqpBmJUxZdLbWqe17m
 TGaEizjLVcr/m02IUxNEWLKoYRxK3h3ya3YnvuXbcmNJ72Al360AOlQnpCheOZW6KFBcbc53xby
 YDi9TIJGVY0W44CuaPPGEzGU7H63MIO7OESBJSumtJ15mHt7vyDDJ/omPsIktAkKGWhH3T64uFG
 As9vtsGY0MYpMZxh4Csc0NQdq25kOg==
X-Proofpoint-GUID: NbxemvbdVP5gKtxsWW8GqXtDNzFCH5FF
X-Authority-Analysis: v=2.4 cv=EYjFgfmC c=1 sm=1 tr=0 ts=68f88e84 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=1lTS2cm5rUV1xho6mMkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180027



On 10/16/2025 1:11 PM, Andreas Tobler wrote:
> Hello Baochen,
> 
> thanks for responding.
> 
> On 16.10.2025 04:01, Baochen Qiang wrote:
>>
>>
>> On 10/16/2025 4:10 AM, Andreas Tobler wrote:
>>> Dear all,
>>>
>>> this commit (Upstream commit 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7) makes our WLE600
>>> Compex wifi cards (qca988x based) unusable. Reverting the commit brings the wifi card
>>> back.
>>>
>>> This was discovered on the v6.12.53 from today.
>>>
>>> ath10k messages excerpt:
>>> --------------
>>> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: pci irq msi oper_irq_mode 2 irq_mode 0
>>> reset_mode 0
>>> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: qca988x hw2.0 target 0x4100016c chip_id
>>> 0x043222ff sub 0000:0000
>>> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 1
>>> testmode 0
>>> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: firmware ver 10.2.4-1.0-00047 api 5
>>> features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
>>> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: board_file api 1 bmi_id N/A crc32 bebc7c08
>>> Oct 15 22:00:20 klog: ath10k_pci 0000:05:00.0: wmi unified ready event not received
>>> Oct 15 22:00:21 klog: ath10k_pci 0000:05:00.0: could not init core (-110)
>>> Oct 15 22:00:21 klog: ath10k_pci 0000:05:00.0: could not probe fw (-110)
>>> --------------
>>>
>>> Beside reverting, how can we help fixing this?
>>
>> Thank you Andreas for the report.
>>
>> If this 100% repro?
> 
> Yes, on several boards, amd, armada-385 and imx6 based.
>> Can you try just ignore the err and see what we get? I am suspecting we are missing the
>> interrupt for unified ready message.
>>
>> diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/
>> core.c
>> index 6f78f1752cd6..cf4cc44d0a1e 100644
>> --- a/drivers/net/wireless/ath/ath10k/core.c
>> +++ b/drivers/net/wireless/ath/ath10k/core.c
>> @@ -3217,7 +3217,6 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode
>> mode,
>>          status = ath10k_wmi_wait_for_unified_ready(ar);
>>          if (status) {
>>                  ath10k_err(ar, "wmi unified ready event not received\n");
>> -               goto err_hif_stop;
>>          }
>>
>>          status = ath10k_core_compat_services(ar);
> 
> No changes.
>> Anyway, please help collect verbose ath10k log, you may enable verbose log by
>>
>>     modprobe ath10k_core debug_mask=0xffffffff
>>     modprobe ath10k_pci
>>
> 
> I attached the compressed log, not sure if it is too big while uncompressed.

Thank you Andreas for the log.

Could you please try if below diff can fix this regression?

diff --git a/drivers/net/wireless/ath/ath10k/ce.c b/drivers/net/wireless/ath/ath10k/ce.c
index 7bbda46cfd93..1a981d333b5c 100644
--- a/drivers/net/wireless/ath/ath10k/ce.c
+++ b/drivers/net/wireless/ath/ath10k/ce.c
@@ -1256,6 +1256,19 @@ void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int
ce_id)
 }
 EXPORT_SYMBOL(ath10k_ce_per_engine_service);

+void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id)
+{
+       struct ath10k_ce *ce = ath10k_ce_priv(ar);
+       struct ath10k_ce_pipe *ce_state = &ce->ce_states[ce_id];
+
+       if (ce_state->recv_cb)
+               ce_state->recv_cb(ce_state);
+
+       if (ce_state->send_cb)
+               ce_state->send_cb(ce_state);
+}
+EXPORT_SYMBOL(ath10k_ce_per_engine_check);
+
 /*
  * Handler for per-engine interrupts on ALL active CEs.
  * This is used in cases where the system is sharing a
diff --git a/drivers/net/wireless/ath/ath10k/ce.h b/drivers/net/wireless/ath/ath10k/ce.h
index 27367bd64e95..9923530e51eb 100644
--- a/drivers/net/wireless/ath/ath10k/ce.h
+++ b/drivers/net/wireless/ath/ath10k/ce.h
@@ -255,6 +255,7 @@ int ath10k_ce_cancel_send_next(struct ath10k_ce_pipe *ce_state,
 /*==================CE Interrupt Handlers====================*/
 void ath10k_ce_per_engine_service_any(struct ath10k *ar);
 void ath10k_ce_per_engine_service(struct ath10k *ar, unsigned int ce_id);
+void ath10k_ce_per_engine_check(struct ath10k *ar, unsigned int ce_id);
 void ath10k_ce_disable_interrupt(struct ath10k *ar, int ce_id);
 void ath10k_ce_disable_interrupts(struct ath10k *ar);
 void ath10k_ce_enable_interrupt(struct ath10k *ar, int ce_id);
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 97b49bf4ad80..ce8e0c2fb975 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -1812,7 +1812,7 @@ void ath10k_pci_hif_send_complete_check(struct ath10k *ar, u8 pipe,
                if (resources > (ar_pci->attr[pipe].src_nentries >> 1))
                        return;
        }
-       ath10k_ce_per_engine_service(ar, pipe);
+       ath10k_ce_per_engine_check(ar, pipe);
 }

static void ath10k_pci_rx_retry_sync(struct ath10k *ar)

> 
> Thank you!
> 
> Andreas


