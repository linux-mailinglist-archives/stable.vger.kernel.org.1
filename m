Return-Path: <stable+bounces-255017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD70BvFOGGpMiwgAu9opvQ
	(envelope-from <stable+bounces-255017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:19:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C46755F393A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60A1F30E8ED0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D91C2BEFED;
	Thu, 28 May 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D78VVkFj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KGzeBcys"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CCF2D7D47
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779977457; cv=none; b=Tjf8L4Nb9RfchKHu4k2FYPjWgriuXSi2dPu3T/BW3gb47trkjqTLyI5bg/X32pv4vC0x49gVrMi35RdACrQ4Wvjyy0guwH83Kkl9w2GgCRe+gmp8zqpROOUwCK/01/H5IghCciMjSpfC19qrDUXPn8TEyMx1G8C8HzUuBPUXOrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779977457; c=relaxed/simple;
	bh=4rZJVp5bncr+uawsObC7M/OUhB7Yjqizbpz8zuZmW9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvN8Q3VluVevoqzGnzTQJvTMZ0hvnVEKn0tnA6M5bNQuMklOSpB3P6ME5I0nq9c+GaWRyJQ9rJb5R8tkIf3op/fOulXFQ/bcYPoxI7qjOiQYlDPGKKJ2mwmsD1xlGmUMm8JKUqlnn6ubqNs4V2lGVDgL2LUGicyklRRENEQ6KTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D78VVkFj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KGzeBcys; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vXbh1562852
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iJ6t2LX8Nf3WHTmQ5lnb3pmaPw0YLr8cKpgF7Dcvu5o=; b=D78VVkFjlkuEcyzV
	lA5MQoHG+VL+o//HIRREbJTwdUOSH12gv48aMjCVORR6d88dLvsl3OvOwfBRPrNi
	Q5FA5uGDReErbHRo9RAmcTfVU+qTbRWt3lpZt8WMKkDvHeXKSwtFaV+tGjnthuzQ
	+1eCuA+3k49fs+lXWCknDat69t8FSVMB8OqK50nsgcK2OJWbCiRygTYVD4Pgsnxt
	ZoSlO/awycGLZ505VX2jGI0car+hbc3UlGFUo2X8s7Dd9slO7e7HquBovDRZVSh3
	UosDMuifqT/2UFc4Iu2mf3O08uNizPJUUeh9S6FdRISZY5cByS9PJVh9fIU9QQjF
	5Jtv1A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2u1dc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:10:54 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-63302aca17aso5178528137.1
        for <stable@vger.kernel.org>; Thu, 28 May 2026 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779977454; x=1780582254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJ6t2LX8Nf3WHTmQ5lnb3pmaPw0YLr8cKpgF7Dcvu5o=;
        b=KGzeBcysYasT/96Fvpr6rEWEuY9Lo97M3jYNFv01g+FVdrWblL59JNooIg8ZqDh1pM
         ncG/W9xy9x2IkwAJu8A70doY2qjgzHUK7FZNd9DeOXxUhMBAzghdg4y5Jp/wu80Ut7pm
         xa4s0QfGH+Q4KqO8oDradpryu7C6WnU6Tvzr+/Ze98MiQFdp69ySIFPy/hNdAB3k51Yp
         Kba+As70UyxRyQr0T8IHl9UitKrrXEt49NJm24vps+OaeQuBWdJgPBHDzrtr8cbCLAbj
         Ci/YoTyFCyZ4IFiOhY9rGjhjKtnEqO52sC+zjvteTsgj+V3yHaKEYvYpc7x9Wh36ZiKL
         TJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779977454; x=1780582254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJ6t2LX8Nf3WHTmQ5lnb3pmaPw0YLr8cKpgF7Dcvu5o=;
        b=HmLVfLefW9lCP5VngUXMpG6qJ8JFcHZsAoMstz6hkL/80oD9QmLqsKUvULNGkdOAHo
         jR+pppvszaR5ZhyjfyIliVbCxL38p+1i773nGcpLyvWt1Cpk3O2Mjf9erE10UVbcM5Wh
         eaLSl2MoRhkdtabFJLQfM2OY7nkp4PkRAya1M5Y6o4Ysmizig0OpsDtynZTxw/SWpZoZ
         mNkuSLvY6ZUvg8LTaye6OSIREiqS7b0bdecq13DA+UrlnWvmHT8kDrLI6sUQGnxeGvQZ
         6jrsMEDMuRGCMpnXZrHtI+Bp/5r4L+l7Vo9ftNCQ1rCkSyOXsYgThkOKWqiX+fMrVZUf
         ObqQ==
X-Gm-Message-State: AOJu0YyyQgAzjDAFMQsKvppEdawUivEff06/FZy/nk8U8wLRDvLsGRxH
	dnh4fDC5UaGuhyDEL9nEi4KuTqe0hMMyjEBfq9GrZK+qzjwIjucT9SNip9Qdp2/CZMsHwjptcxk
	G+4GinM82ZEflYHNzKw3y9bHct3weGHxarjnNa/c2fyeIXD7pD/6tyuuVpF8=
X-Gm-Gg: Acq92OG8efGD0FXFFcGpN/hXaZ5KSel1UNoBHEbby9Kn5T/7Mglv7xmkoO4n61Qt6Lt
	iYbj+Tfq5muQm7N8fgdSz4jc7Am+y2ZaWe/LKbcp60DgcmFx+CFg+d0PkBDPETmrtwJDhLCMQeZ
	4iycirjjYEEwpvEB+WNJkmg6JtEsfGv1Dyd8gaEHXNiPaXHzYpoQi3Om/E6/H+HBcILymP9vFwp
	nRDrljd0bvn4l0YmfbnWJNVZJXCftAWtJFRnFI1L8jg9JfpTRqRFxxfbHvlh4gwvecbueIGd6eg
	MThB9TAT6gZOtzbFUck5HrfDQ6ip87VqK+asWrvAqJDV3yQQRkENWsEU2KIlcl7k7kufKYEDpk/
	KoB/NFx+w7DyLlpV5DOrbM03YUG6PQnn+Qe/yn5sS9+Sf+YxSwRS6GE+euzsJz+fVVeupkhZZFt
	l1cQd/d/lbZuuV5s9roAQ=
X-Received: by 2002:a05:6102:2c13:b0:62f:4553:7a28 with SMTP id ada2fe7eead31-67c8dbf6c45mr12405599137.21.1779977453673;
        Thu, 28 May 2026 07:10:53 -0700 (PDT)
X-Received: by 2002:a05:6102:2c13:b0:62f:4553:7a28 with SMTP id ada2fe7eead31-67c8dbf6c45mr12405549137.21.1779977453082;
        Thu, 28 May 2026 07:10:53 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ae20:597c:99b8:d161? ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b28absm14324149f8f.27.2026.05.28.07.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 07:10:52 -0700 (PDT)
Message-ID: <14c628b9-0bda-4658-8e60-7781284aaee2@oss.qualcomm.com>
Date: Thu, 28 May 2026 16:10:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: s32g3: Fix SWT8 watchdog address
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Chester Lin <chester62515@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
        NXP S32 Linux Team <s32@nxp.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260528120323.46287-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260528120323.46287-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a184cee cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RFvq1impTiYap7nS4gAA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE0MyBTYWx0ZWRfX8zW3P5xtdV2b
 lPmqRU94V4Isg0MD3ELOHo+ol+BVfSi+GHkE1R7CWabtMucJWKFp5DnNn5La/ov3rklNH5Beer4
 rW8/6TCVCAk92dDg/PrvucHBdrS1cpB7ohnz/NrKNi574o2SgLT9ewcNM1yogC8q/rSdThkdxTS
 fOT2syApepLuSOSB5+1ghBgL5PCMUZz/RLZP5cZvIpV7+hVhEthZ4NjOg2HJI9HJICO2RC6zeUP
 jrLendVvFUM7MYNQHOC0kcRAk256yCkdz+U5tZLoZNtjvSLExz3FYpDCCcyE7G41nE+sEhQB/tb
 n4jsgpjRpzL13UJxlVNZJihYlQSb1UYY7EwdX0javkZhVeDPfbREiJMfbnnUjCf0X0vE/lUU/GY
 8bsVBHBCHzsbIJlnZE9mDspPbeGnFw==
X-Proofpoint-GUID: 1PvWMgtF7SY2Ez2T5MXrTzxfU50uSrh4
X-Proofpoint-ORIG-GUID: 1PvWMgtF7SY2Ez2T5MXrTzxfU50uSrh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2605280143
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255017-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,gmail.com,suse.com,oss.nxp.com,nxp.com,pengutronix.de,kernel.org,lists.infradead.org,lists.linux.dev,vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,0.0.0.0:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_PROHIBIT(0.00)[2.105.251.32:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C46755F393A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 14:03, Krzysztof Kozlowski wrote:
> Add missing hex annotation to fix the SWT8 watchdog address in 'reg'
> property, as reported by dtc W=1:
> 
>    s32g3.dtsi:863.27-869.5: Warning (simple_bus_reg): /soc@0/watchdog@40500000: simple-bus unit address format error, expected "269fb20"
> 
> Lack of hex '0x' meant address would be interpreted as decimal thus
> completely different value used as this device MMIO.  If device was
> enabled this could lead to corruption of other device address space and
> broken boot.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 6db84f042745 ("arm64: dts: s32g3: Add the Software Timer Watchdog (SWT) nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Thanks for the fix

> ---
>   arch/arm64/boot/dts/freescale/s32g3.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g3.dtsi b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> index e314f3c7d61d..7e28dff53a86 100644
> --- a/arch/arm64/boot/dts/freescale/s32g3.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g3.dtsi
> @@ -862,7 +862,7 @@ gmac0mdio: mdio {
>   
>   		swt8: watchdog@40500000 {
>   			compatible = "nxp,s32g3-swt", "nxp,s32g2-swt";
> -			reg = <40500000 0x1000>;
> +			reg = <0x40500000 0x1000>;
>   			clocks = <&clks 0x3a>, <&clks 0x3b>, <&clks 0x3b>;
>   			clock-names = "counter", "module", "register";
>   			status = "disabled";


