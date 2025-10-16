Return-Path: <stable+bounces-185873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3DBE1362
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 04:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C4694E1E44
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F7E1F03FB;
	Thu, 16 Oct 2025 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xoh3AENT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88071E487
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760580120; cv=none; b=GqGD7N2rhr+VVRyIHQ/PAczQn3NCI2WDw7V6Tdl19TrLEfAND/tuIN9bZr9VxlBz2s5dBrYDUtuFdFFpUHiHGcVVdCvyoXAOiIvf5ahzZzExMtQxVYZoSJj4DVetlX/GFvlZUpCSAt9WNVcyTxr+So9lkUhWi/ODjr3XQpD/G7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760580120; c=relaxed/simple;
	bh=gZpk9l4GODKcAbTHiyKB6PL4aJAfqpr67cEFyclZlfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Efb4YT0qEkLE/EG7q7VivYyQxH0aqT9DKG0QqnZhCrx3hjZhjZuN0SrM7rMFKL6aywtvVeQ+nv/d1uAGbzOJmfZ/AZGjT0INAlNVA8kRU+e/06S+EKmlU1PPr016ODhrg+kKO53znJPTT0/WlKLPxXXmQvjSNPxZhD6fjiOIGik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Xoh3AENT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FIQVBa016060
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 02:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k4GrjthokzpfV3NB+jVI7qiQ1VZwJxFM9jmJgqFonaY=; b=Xoh3AENTNxOgLXUT
	VMGPyqZFr+VXzmP5E58zC1DJ1FOcIG8sqBZoCFuU7pTNvIYRIL0w/mCydV0Qr+g9
	2vLBVmdtYL4X5Z9dwnYiCQuHKj37vmNzj6YzoqIIWml/RqSME38600X+wzcCbHqx
	VR69i4KwD7txLIR0vYjM2GFN+VkY/uEdCjBVXIxezLGysJHfJwYy21q/k1r2mKrd
	ZbeugMPjsaJyb7GSJwzKULzWetKy4XsBihQe978hTX9pXkLivNzZgHLdln2jAYhE
	npXbcai8bhJbsiINSD69ft2IFOzk+euR9eQAHkvFaUaLZVhamNjwC/cOWssH/Ii/
	CiN6Cg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5pp8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 02:01:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-335276a711cso290270a91.2
        for <stable@vger.kernel.org>; Wed, 15 Oct 2025 19:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760580116; x=1761184916;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4GrjthokzpfV3NB+jVI7qiQ1VZwJxFM9jmJgqFonaY=;
        b=xTequw0eBk3v0z2kY8A0BbFSe2KKJGP6TdDlQUBuxHzu5egrPPWSLJAPm0h3hz8Wk/
         yGfwyo0Vb7RVF3qBQCLDufz8XgmahpIIv1N8XBj5keV98NlvIBChXi2YlQWlIVVuFmnn
         W8XldR86hvjh0uFkHgyYT1cKq0g1/m1sWaiH68TSrgod3u+QvEUrtJCcoVrvTTXWxMGA
         BMk/UUOu9/L6C8nWQ5XvxT0o7QVho0SC8A8am3NC9xV1/xyzWSukhVsxoMDRUJz3Gzcb
         sk9NUpd1RdlG02o0LjL3ahIwW6HTbbYZpfSOCNZtqynr7+cSUj7G5UiK/CQNg/ifHUsy
         slKw==
X-Forwarded-Encrypted: i=1; AJvYcCWI40Sx5hrCd/lvHuvu/TwZzVSa49eFh8cppl+7bcMqgM8IHTyAVnjuVVvbh6lSkTmkz+PuVO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRp9AoWdXkqBv4PVBXwmL3HyKeTmqfNYdv+qgFlRGCtIS5eP6
	WzQOwdu0G+4rdo2Uk7f+0jmxqYW+/LCZY2OF0keBCBJukeSNvuCzJfoqgMMklR/eGs4WK4OTbvb
	UKJkuj+ZB4wFqyfZTp2Su4gNmj04Jb6q1bsyYBqgBM9+jLlV4IP1uEm1OveRLkyomJ2uNqw==
X-Gm-Gg: ASbGncvHZX8RvHMeXZqgalKxPFqHw17uR3HglYxnwIQaBuiKLFndqx2oxzbNJWVjFiT
	ygNslg1kYNUYNGJ0IFvqkaM3nHFw+fcI9/ltcdAEOBCJaPdyf/+YZmawcx+oVQ/abnvOP4wcHz6
	IH1rWL7RwqKOBBuMpST1+f8guZ/Iif5NvC4rR0ZUda7Pm5AvZUSlLGQfgqDNItelGt+TZ618/Qw
	2/+pU//e9KE6oGFE8YeSZB4BVFzOpWoXEjETFeqmQME9z0QlswWMWzk5k+rKXTf44vxdcjlXGLi
	lNEkAIXFRtDjXxxVOWONGyA6kMa/67vfC46yYZs5A1FIeZwnMc15v6EvFKOR2XLqGFv+0jSUQhT
	0iaf7YkiJX6LrzbGd0bsL4QvJO2ic9WyKdjk0Hni6wOifcDcAvsMHdNl0JlbjFtmyKcN7TFo=
X-Received: by 2002:a17:90b:17c2:b0:327:734a:ae7a with SMTP id 98e67ed59e1d1-33b5114ac35mr45958457a91.11.1760580116212;
        Wed, 15 Oct 2025 19:01:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWVYvmEDzBuW8u69AvWwe6XINE0/1Tv/gUO4QvhGqoFqfVxgghQxKpegnYo4snoGk9Y9sHxw==
X-Received: by 2002:a17:90b:17c2:b0:327:734a:ae7a with SMTP id 98e67ed59e1d1-33b5114ac35mr45958420a91.11.1760580115690;
        Wed, 15 Oct 2025 19:01:55 -0700 (PDT)
Received: from [10.133.33.11] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61b0dd26sm21392512a91.22.2025.10.15.19.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 19:01:55 -0700 (PDT)
Message-ID: <fe63bbbf-3833-477e-a820-d41e621e6a41@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 10:01:52 +0800
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
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <03727147-0115-4ce9-b68d-756c6e41db94@onway.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: e-fplnMWjU4PXMcjQvSamhvryWckkscJ
X-Proofpoint-ORIG-GUID: e-fplnMWjU4PXMcjQvSamhvryWckkscJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX47HpShGe2GY0
 /zIpXrqdjksk+0/aFdep8nZDjSFQthvqxJG6KkYouWHjDKUMgv64tc1FA7tmD1PidaOlw1QjUKL
 PVilzsXXaK1DW32w0pM7xQSt9dgPZLNG59+oyKcrj0wFWjDS4bc4IZfWxnN+4du3aE965cNr3gk
 qv5w6lWx0nheVKPhHdq2x8wd9OtU57LcDeU6am8LcdbP+jXCG9UvRZpxdhgVidk4coK8tF9Cv4A
 87wXJiSfohRaBJW/AturFd3oXyfRBAXbcJuyIEHFKp7u0nhedcyf9HGbfx+JB5ZXYhZ+tSVWM7A
 GtAjh1O4cFASrFvdro0/sLh2QanmS328QkfexTXxsZ05lMPtNc0/wC1bm9AnTa2EFlndK0mqMo5
 Y/0KOgCVh35qS6Rmt+p22dSAduNQ2w==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68f05215 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=oC5KwCwwnPi90cocTB0A:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020



On 10/16/2025 4:10 AM, Andreas Tobler wrote:
> Dear all,
> 
> this commit (Upstream commit 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7) makes our WLE600
> Compex wifi cards (qca988x based) unusable. Reverting the commit brings the wifi card back.
> 
> This was discovered on the v6.12.53 from today.
> 
> ath10k messages excerpt:
> --------------
> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: pci irq msi oper_irq_mode 2 irq_mode 0
> reset_mode 0
> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: qca988x hw2.0 target 0x4100016c chip_id
> 0x043222ff sub 0000:0000
> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 1
> testmode 0
> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: firmware ver 10.2.4-1.0-00047 api 5
> features no-p2p,raw-mode,mfp,allows-mesh-bcast crc32 35bd9258
> Oct 15 22:00:13 klog: ath10k_pci 0000:05:00.0: board_file api 1 bmi_id N/A crc32 bebc7c08
> Oct 15 22:00:20 klog: ath10k_pci 0000:05:00.0: wmi unified ready event not received
> Oct 15 22:00:21 klog: ath10k_pci 0000:05:00.0: could not init core (-110)
> Oct 15 22:00:21 klog: ath10k_pci 0000:05:00.0: could not probe fw (-110)
> --------------
> 
> Beside reverting, how can we help fixing this?

Thank you Andreas for the report.

If this 100% repro?

Can you try just ignore the err and see what we get? I am suspecting we are missing the
interrupt for unified ready message.

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 6f78f1752cd6..cf4cc44d0a1e 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3217,7 +3217,6 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
        status = ath10k_wmi_wait_for_unified_ready(ar);
        if (status) {
                ath10k_err(ar, "wmi unified ready event not received\n");
-               goto err_hif_stop;
        }

        status = ath10k_core_compat_services(ar);


Anyway, please help collect verbose ath10k log, you may enable verbose log by

	modprobe ath10k_core debug_mask=0xffffffff
	modprobe ath10k_pci

> Thanks & regards,
> Andreas


