Return-Path: <stable+bounces-92780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE409C5714
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F172833D1
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E26D1CD1EC;
	Tue, 12 Nov 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvVDY/yk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FCD23099A;
	Tue, 12 Nov 2024 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412623; cv=none; b=nUsRFtSCRhEJpkKL1sNt4kvj8vI+zAqagRZQ51RU+jlVrMpcT4GerHTEw7yPc3z9FR49VYQZTNgWdy2axEnbETHyQeUnEnqT1x2gF8kT3xyifduaMJllTz01IDVYUTrv98j10OLON+jkNZr+SgsbhKo6AEiGQTL944q14qwvdW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412623; c=relaxed/simple;
	bh=raGOCI4olUmct7eYFc+pJLCilCI9/9CufmqPe7VooIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S0Y/1gfApulc14taolTsKhBC0mlgrHZHGUQYus0j2o+jmFAH/hd4WsDrORU1sdOR/663WdNubdwz5Ww0zz+mmFJ3RdgY9nw29IIdAucerP39xQk5Rw+gJvtWkODhXSVdRdRaicdoHEkuW2XLeoiaVKg3epGT2X+pQtWf+xlAth8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvVDY/yk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piggz.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431688d5127so44035605e9.0;
        Tue, 12 Nov 2024 03:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731412619; x=1732017419; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gSu5VRx/T0r2Y1TQNYxUEQDwIAks1NmmDqtGiwK+coE=;
        b=DvVDY/ykgychd03Zf/V2iZLFmiDgzngSToZxEqN2OMRpDr4WcTIXY4DIYQ8s2x3JNt
         kVwEZe/gTiMG/c8oEnfSO0Y2X+R1ujPnykVteg17BhPQpuRi9nboLqEdIuX/oqpdZPGp
         tQDINwvm2pwtE7CfoHK+qqyJNRvrSKhFHwq95bgV7nuth/uO9QHBU/41ktW5zVExCOIE
         r2IykTEFfi0Eyj+LZfsXQ9nTYiNMrV3nMdxUv71pgriOgcIpkXKDTZkZFBchRRQ4AYYo
         G4HJ8Zb1tUEbZElcvWWvU4Y8pqVmh99PCIRN0FurXgggb/iytVJS4oj0TlqHKKP0iJsd
         cx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731412619; x=1732017419;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSu5VRx/T0r2Y1TQNYxUEQDwIAks1NmmDqtGiwK+coE=;
        b=JE+YATAfmPbm3tcAL6x1xg2BgR7NJYWsKhHfhOF+rhY5llj91gJAhAwDbxvNaLz9ZU
         r5pYXsHS1cHpOsvLc0NbypqX6sbvm25NY7tDArdfoYZ8k8Kqul1PhWYPf4wk7vE835bg
         lE8HaQiLpDN33Hvx7b/L9ru1I47G67DEeGAyhN2p21xnlyvnZelE222MTKJmESUU6/Ll
         SGja8nw2W7V/mIaq6bZcAQJ0nkmhGcS4sqpXqy64gPwdNHFP8xm/gsLrHLZTfbTpLKK+
         xcGju/KvvFFg0FDLa7HOsVuh+G2IrYIXKYakweWIJAFKw1fz5pQX8P52bv5MT0KCgQN1
         Zk+w==
X-Forwarded-Encrypted: i=1; AJvYcCW19/btpWVjJUcA8eZPJHjpuXZEcxdSNOzPdKRT5kVzOVKDos8SuQC7yF1VOCsUevB9m29KTLyLGT7CNEC/@vger.kernel.org, AJvYcCWM3IdS//EFQLJ+XJ5q37q2VqCBdUKGUz5M2EGIeOII7tzGon+kvnnL7Y52+k2TuYwiviVAe1F0@vger.kernel.org, AJvYcCWxwujgMl6/j5L9PzxxZyKYLi3vxxbB/35M2q6meLnCgsM2EF4dPS2Cer20vkQ4hNlQagktmO4PRC8M@vger.kernel.org
X-Gm-Message-State: AOJu0YwGcxkHQD5eZMrzcToPsjECpLkee+YMGWhU8R863Y2mnVhmjaRU
	n5YWiJu5PN+DYZV0q5FNhHwwaENIt0fwSiqpEn5Edtyr0shtbj9M
X-Google-Smtp-Source: AGHT+IElsmspuC7y92QmrSRjeRp6WqdcehDOD3Uw/GDj15rvF4LUjZ5UI8+zxBjPZPJSfOK8ith9ow==
X-Received: by 2002:a05:6000:1f8c:b0:37d:4a80:c395 with SMTP id ffacd0b85a97d-381f186b313mr12410123f8f.21.1731412619186;
        Tue, 12 Nov 2024 03:56:59 -0800 (PST)
Received: from adam-laptop-hp.localnet ([2a0a:ef40:d5b:4001:e118:be36:46b9:41b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed97cfefsm15121948f8f.26.2024.11.12.03.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:56:58 -0800 (PST)
Sender: Adam Pigg <piggz1@gmail.com>
From: Adam Pigg <adam@piggz.co.uk>
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, stable@vger.kernel.org,
 Dragan Simic <dsimic@manjaro.org>
Subject:
 Re: [PATCH] arm64: dts: rockchip: Fix vdd_gpu voltage constraints on
 PinePhone Pro
Date: Tue, 12 Nov 2024 11:56:52 +0000
Message-ID: <2815923.lGaqSPkdTl@adam-laptop-hp>
In-Reply-To:
 <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
References:
 <0718feb8e95344a0b615f61e6d909f6e105e3bf9.1731264205.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2630842.XAFRqVoOGU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2630842.XAFRqVoOGU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Adam Pigg <adam@piggz.co.uk>
To: linux-rockchip@lists.infradead.org
Date: Tue, 12 Nov 2024 11:56:52 +0000
Message-ID: <2815923.lGaqSPkdTl@adam-laptop-hp>
MIME-Version: 1.0

On Sunday 10 November 2024 18:44:31 Greenwich Mean Time Dragan Simic wrote:
> The regulator-{min,max}-microvolt values for the vdd_gpu regulator in the
> PinePhone Pro device dts file are too restrictive, which prevents the
> highest GPU OPP from being used, slowing the GPU down unnecessarily.  Let's
> fix that by making the regulator-{min,max}-microvolt values less strict,
> using the voltage range that the Silergy SYR838 chip used for the vdd_gpu
> regulator is actually capable of producing. [1][2]
> 
> This also eliminates the following error messages from the kernel log:
> 
>   core: _opp_supported_by_regulators: OPP minuV: 1100000 maxuV: 1150000, not
> supported by regulator panfrost ff9a0000.gpu: _opp_add: OPP not supported
> by regulators (800000000)
> 
> These changes to the regulator-{min,max}-microvolt values make the PinePhone
> Pro device dts consistent with the dts files for other Rockchip
> RK3399-based boards and devices.  It's possible to be more strict here, by
> specifying the regulator-{min,max}-microvolt values that don't go outside
> of what the GPU actually may use, as the consumer of the vdd_gpu regulator,
> but those changes are left for a later directory-wide regulator cleanup.
> 
Ive tested this on my PPP and can provide the following outputs.

On a device without the patch:
# cat /sys/class/devfreq/ff9a0000.gpu/trans_stat
From  :   To
: 200000000 297000000 400000000 500000000 600000000   time(ms)
200000000:         0         0         0         0     12203   5387782
297000000:      8208         0         0         0      2973   2337382
400000000:       784      6283         0         0       439   1859857
500000000:        67       287      1093         0       284    389599
600000000:      3145      4611      6413      1730         0   1748889
Total transition : 48520

And with the patch:
[root@PinePhonePro defaultuser]# cat /sys/class/devfreq/ff9a0000.gpu/trans_stat 
     From  :   To
           : 200000000 297000000 400000000 500000000 600000000 800000000   
time(ms)
  200000000:         0         0         0         0         0       364    
188911
  297000000:       120         0         0         0         0       234     
31652
  400000000:        77       182         0         0         0        82     
32287
  500000000:        10        57        56         0         0        57     
13376
  600000000:        21        14        35        31         0        22      
9463
  800000000:       137       101       250       148       123         0     
97310
Total transition : 2121
[root@PinePhonePro defaultuser]# uptime
 11:56:24 up  3:34,  1 users,  load average: 2.77, 2.24, 1.70

I havnt noticed any issues, though I havnt done anything more in-depth than 
run the compositor and play a youtube video in the browser

> [1]
> https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211
> 127.pdf [2]
> https://www.t-firefly.com/download/Firefly-RK3399/docs/Chip%20Specification
> s/DC-DC_SYR837_838.pdf
> 
> Fixes: 78a21c7d5952 ("arm64: dts: rockchip: Add initial support for Pine64
> PinePhone Pro") Cc: stable@vger.kernel.org
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Tested-By: Adam Pigg <adam@piggz.co.uk>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts index
> 1a44582a49fb..956d64f5b271 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -410,8 +410,8 @@ vdd_gpu: regulator@41 {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&vsel2_pin>;
>  		regulator-name = "vdd_gpu";
> -		regulator-min-microvolt = <875000>;
> -		regulator-max-microvolt = <975000>;
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
>  		regulator-ramp-delay = <1000>;
>  		regulator-always-on;
>  		regulator-boot-on;
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--nextPart2630842.XAFRqVoOGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEr1aGel3+a3VM67n3d+rfHu07OYAFAmczQoQACgkQd+rfHu07
OYADkAf+LXSLL2XQi2NHVwvmnLvT1HH5gVHM/L+nTrbxrNJs6efCnE35HYlo4ye1
kw9pN+BfWTGHuAOE3yRgIgXZXY9J/OEKcKpKpRNO6SYPiVnjm8F3ct8LAPXaPU53
tQNF4VXtffgWoDgFDMbDd+kAWd6zPVyR3BuDFy9iMKYvFTKLka2JMHIz25wb+l94
Vx6WDGlq0LTvslHsX1BTbIH82jzJrM07ohtQmeuZTsBPnV6jxpHDp3KaPAqtDoml
6NtxipN/scNJXRAzq5lvyp1rHmTYTvjtvjJmuRrOnEYjyk6+Q2/ySxFVNw4+RhMG
HheiovMko5kHxT1bvbFOJXjsKL23mA==
=MG/w
-----END PGP SIGNATURE-----

--nextPart2630842.XAFRqVoOGU--




