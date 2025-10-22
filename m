Return-Path: <stable+bounces-188951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C2CBFB394
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 11:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4741D402B41
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABAB314A78;
	Wed, 22 Oct 2025 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UoovsAjg"
X-Original-To: Stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88606289340
	for <Stable@vger.kernel.org>; Wed, 22 Oct 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761126744; cv=none; b=BaYXk755yujnncVjPJvh7T56mQE6FJqK9NBBAurUdEu/2fzGbZB/l8aP9IhTnCIEi0qDZaWu8xrZ13x4caFnlKJyNnqpaeLZqh8suggutV7ialmXnOG4w0LDgrVnH2u1wx9V94HlmaLQQvugMcVf9tz/ZYDVLU1NTCuvszMWxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761126744; c=relaxed/simple;
	bh=HotdHt9tSRG/l9u8l0jrHhHMNryAyiv5DnclJcYD9DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2Ws4YnoFJf8rApNSM4xw49MD8jwreyM9qaon9CuYmddtZ8ZeHbjudeQVuH3rqhIBrIhrYMY28RIUFLtS+24gg54w5v87RZFG6WfBD7ma0f6dWLv5kdaoF3r/S3x52+2ygd/XhVtqOrhJ4XJZkpnVE+9jQPotSu59UirG9WLyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UoovsAjg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2h7eo032759
	for <Stable@vger.kernel.org>; Wed, 22 Oct 2025 09:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gL1oSL5COCo33UPaZkHwdffpCD3r0s6TIvOc79+npqQ=; b=UoovsAjgB93b7px1
	kFp1U3H3nnIDdIxw1dFkJ9LdXGSVAtdC/M/s18sUscm3/VG0i+IV2CfyDqhx3qbA
	GscTW/JzsFz0Qmvg4igd4fklb/fIuSdlm/bRuwL/hXZg/ZbNevgc2KEZeoZEqDV6
	F8t1lHlFRXqA48saHAcv5b2zAnG6qFEM2/LIq5nCyVmPX0G6ini0bPDKEmFiDD6L
	52uAC4lrKZo27PfdpR5y6zybZ6o1St2My6m638sXX1T/ejBE1SU5q0hIXkKp7IYQ
	1JL0IFtNOSb6BYXXoXMZc76lXgWfRzgAJ42NCGfoVnohpeci9z7fvHV3FfOJbLi9
	gKGlbw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08w9ssd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <Stable@vger.kernel.org>; Wed, 22 Oct 2025 09:52:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8984d8833so39688841cf.0
        for <Stable@vger.kernel.org>; Wed, 22 Oct 2025 02:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761126740; x=1761731540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gL1oSL5COCo33UPaZkHwdffpCD3r0s6TIvOc79+npqQ=;
        b=m0e6tydlqxyxqh2akL9cZRbRKiC35h2F190jVRWnOk9G1dCbA4QFkUFBy98zvr/3tx
         xPZFvcCMYs71IlsfX5Ojffw4e1PDqAg/KlzD8Dk6PQsuSPXQinqSJ4HFBL4kRJjf8OV/
         pv9aJntGNB4rnQg3Btj2qTrx+N22ohHb8PM33KSG1C2PDY2JAKDoWSZMacEcO7niVPPp
         W/yLf0PEshfXAJhGzAOETL51nilYwP8rRcu3uMPo/hS+TrsNfXU8EzT+BG3arQaxDBat
         qEv1Sk7gzRgxAK+mrSUDFzrWa/2LCDGypnZumg1xJ4dV2BCpB9Ji7KlCbUClZZowa92O
         HoMA==
X-Gm-Message-State: AOJu0Yxm+4OT54VZy7TYjP10RspSCxtB+/Ca/yjdvU/4pWj+CGunIgdw
	Hldni+dt/bHHom8ZbWmMljXN8Gmv+VHoyTz4smu4jzMvQXuHy0u72LpH2PO4GazASVIk8zH/7pL
	bHYpu+ON8JA29+c7tDy5pAC/oHDYRKff4wx7NT5nD1df47KxA87moqKZjELk=
X-Gm-Gg: ASbGnct2GoEr7L0Nq5/K+ukFqjAT/loBoF3zoYukdXQrNNuuEaN5iHvPqFkosdU1GY5
	f04nCOwhBri/c5jlnbGYF2ZhmebWeYvQ4sRWoEcHfTlNAPjmVoHyAtxqdV2Qms+3T6X+mqlVeVu
	aimdWWmhfZaH0YM+IoyaXUQ8iNmBZYkJqch48obXXqjbWnWJlAZIsa2yb1tvKWms8F5GhebIOSF
	bm/rHT9mDuYFI2YAtznPTnp1rwnvnIeVw3wv3DwbPyhzQZP6k9ZsdkqValmECOrXC9dPBGlBeWE
	EZBRXMuz0A2fl/dj1r6w+sgkXDQxnE5kcX8nLkFo37wBSCytagpbhNnvyCH2RRg33PuIs2RVqV+
	m5mKZP71n3vCGjQuaQTsf1CFEkQ==
X-Received: by 2002:a05:622a:138b:b0:4e6:f8b8:50f7 with SMTP id d75a77b69052e-4e89d33642bmr274377751cf.44.1761126740217;
        Wed, 22 Oct 2025 02:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD6+cZ2h2uTsJmpX7ZrNcDvQJ02RS4D6pmlQSOL6VJLe0LLRCucdWLVJ34ffIHd5GjyVi6dw==
X-Received: by 2002:a05:622a:138b:b0:4e6:f8b8:50f7 with SMTP id d75a77b69052e-4e89d33642bmr274377521cf.44.1761126739754;
        Wed, 22 Oct 2025 02:52:19 -0700 (PDT)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427ea5a0e9csm24523076f8f.5.2025.10.22.02.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:52:19 -0700 (PDT)
Message-ID: <76567559-4cac-467f-9740-e8a539a445f7@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 10:52:18 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ASoC: qcom: sdw: fix memory leak
To: Steev Klimaszewski <threeway@gmail.com>
Cc: Stable@vger.kernel.org, alexey.klimov@linaro.org, broonie@kernel.org,
        krzysztof.kozlowski@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
        perex@perex.cz, srini@kernel.org, tiwai@suse.com
References: <20251021104002.249745-2-srinivas.kandagatla@oss.qualcomm.com>
 <20251022003429.4445-1-threeway@gmail.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251022003429.4445-1-threeway@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wsdfGsh5ZUxlSehK4_VeSLcSUVAUTL3R
X-Proofpoint-GUID: wsdfGsh5ZUxlSehK4_VeSLcSUVAUTL3R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX7JbFG75rb86O
 02bMcKYJAjPOcp0Ask/ZoTvoJXXkqfPtTzp2o6cw67F8JQssxEoDoRz+RTcdC8q3Te+vnC9fsv1
 QIuniKqTBT2u4KJ+mRdN2ZrxCtr89aWD91+fmQ75+ovYPrQcgq0luN/VL31xw45LAJ91Qo4c3Lf
 4d8MqGhGe+Pbj0hzzhH2l53Ybx6grsj41avGSUIQQ0i/1QJTT9BJdoQJGqdDxo4scP3EJJ1Bff2
 lfIWNHmI/Z4tIKUJdfTLb5XWmcPo5xP1ftNeL9iNEkJnyAG6POiBV4gzS4uVyogHTJkEz2msYLZ
 F/CbPYAer3jKLGux9xLzBHp754jPkt3EpSRm2pgGtYYv9oqDu2IHYUwvs+Yg/AiIhpwKg1y4C9i
 vdumANx0D5fjd+C9zltsgPCGi8oTTg==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f8a955 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iO20W2wDcHnNQb4HqdoA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

On 10/22/25 1:34 AM, Steev Klimaszewski wrote:
> Hi Srini,
> 
> On the Thinkpad X13s, with this patchset applied, we end up seeing a NULL
> pointer dereference:
> 

Thanks Steev,
I think I know the issue, There was a silly typo in 3/4 patch.
Could you please try this change, I will send this in v3 anyway;


-------------------------->cut<------------------------
diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 16bf09db29f5..6576b47a4c8c 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -31,6 +31,7 @@ static bool qcom_snd_is_sdw_dai(int id)
 	case RX_CODEC_DMA_RX_6:
 	case RX_CODEC_DMA_RX_7:
 	case SLIMBUS_0_RX...SLIMBUS_6_TX:
+		return true;
 	default:
 		break;
 	}

-------------------------->cut<------------------------

thanks,
Srini> Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000020
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010abfe000
> pgd=0000000000000000, p4d=0000000000000000
>  SMP
>  pdr_interface(E) crc8(E) phy_qcom_qmp_pcie(E) icc_osm_l3(E) gpio_sbu_mux(E) qcom_wdt(E) typec(E) qcom_pdr_msg(E) qmi_helpers(E) smp2p(E) rpmsg_core(E) fixed(E) gpio_keys(E) qnoc_sc8280xp(E) pwm_bl(E) smem(E) efivarfs(E)
> CPU: 5 UID: 111 PID: 1501 Comm: wireplumber Tainted: G            E       6.17.4 #2 PREEMPTLAZY
> Tainted: [E]=UNSIGNED_MODULE
> Hardware name: LENOVO 21BX0015US/21BX0015US, BIOS N3HET94W (1.66 ) 09/15/2025
> pstate: 60401005 (nZCv daif +PAN -UAO -TCO -DIT +SSBS BTYPE=--)
> pc : sdw_stream_add_slave+0x4c/0x440 [soundwire_bus]
> lr : sdw_stream_add_slave+0x4c/0x440 [soundwire_bus]
> sp : ffff80008bc2b250
> x29: ffff80008bc2b250 x28: ffff0000a56b2f88 x27: 0000000000000000
> x26: 0000000000000000 x25: ffff0000a301b000 x24: 0000000000000000
> x23: ffff0000e8ce0280 x22: 0000000000000000 x21: 0000000000000000
> x20: ffff80008bc2b300 x19: ffff0000a305a880 x18: 0000000000000000
> x17: 0000000000000000 x16: ffffb9859eb15c48 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000000 x10: 0000000000000000 x9 : ffffb985391c0614
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff0000a56b2fd0
> x5 : ffff0000a56b2f80 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : ffff0000eb005000 x1 : 0000000000000000 x0 : ffff00011de2c890
> Call trace:
> (P)
>  wcd938x_sdw_hw_params+0xa8/0x200 [snd_soc_wcd938x_sdw]
>  wcd938x_codec_hw_params+0x48/0x88 [snd_soc_wcd938x]
>  snd_soc_dai_hw_params+0x44/0x90 [snd_soc_core]
>  __soc_pcm_hw_params+0x230/0x620 [snd_soc_core]
>  dpcm_be_dai_hw_params+0x260/0x888 [snd_soc_core]
>  dpcm_fe_dai_hw_params+0xc4/0x3b0 [snd_soc_core]
>  snd_pcm_hw_params+0x180/0x468 [snd_pcm]
>  snd_pcm_common_ioctl+0xc00/0x18b8 [snd_pcm]
>  snd_pcm_ioctl+0x38/0x60 [snd_pcm]
>  __arm64_sys_ioctl+0xac/0x108
>  invoke_syscall.constprop.0+0x64/0xe8
>  el0_svc_common.constprop.0+0xc0/0xe8
>  do_el0_svc+0x24/0x38
>  el0_svc+0x3c/0x170
>  el0t_64_sync_handler+0xa0/0xf0
>  el0t_64_sync+0x198/0x1a0
> Code: f9418c00 b9006fe3 91004000 97ffe306 (f8420f43)
> ---[ end trace 0000000000000000 ]---
> 
> -- steev


