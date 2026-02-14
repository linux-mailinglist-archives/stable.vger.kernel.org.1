Return-Path: <stable+bounces-216313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFo3K7TGj2kdTgEAu9opvQ
	(envelope-from <stable+bounces-216313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:49:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CDE13A2E7
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0918D303A930
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 00:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127A1DEFE0;
	Sat, 14 Feb 2026 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="epGufIGK"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534771DF75B
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030190; cv=pass; b=hm/yoSzM1k2+OzpfImoRJULL209j/3e2gTvSrl/s4ODSfaHHNi1wjZ7Jg+ImDrToVcuP6xptAkaw5BTMyVFc7woLMeTSbPPIQmDRfmNKyO+J16eQMXioZTbXPaKPkBVTjaiqVVRtzVeruun31bHb35/dT92iST7Xn3H5HkU7cm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030190; c=relaxed/simple;
	bh=a7PROfwzw0uDYjOmUvdofyVuFC4ks1BIodJ3cizCOgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d329gNYZqcTDm+WaSK6PTgcHuHEv+gEhe3CadreH9om8/BFX1CEwzi+SRsjtiPBqPo3rJeUI1Cn2UymY969tKeh4LgPMQKoTDPG1oyMgV1L34Fap075MoMpqDfYAwiYAueDGcpaTIqqAlCQwMscCHTBbW9NawRxXDFmyuF5xiZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=epGufIGK; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1233bc1117fso2036906c88.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:49:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771030188; cv=none;
        d=google.com; s=arc-20240605;
        b=PUYHRUh58iPv4pJ6b8QiD4rvPKknoFNsHTMLbB5rkGGpmss5+HnWCMeSo7SNGOy9IN
         MAkt94o024gW+NLMFpsCZsgqPaXEG1gLOSvdmPBdI/eStsRYnbqCe1MR2ljdj8OpQmeZ
         AsQj9OJRJegMm56avHSxiUgbfKT5YTKWEmlwiJu0qVKj3pvfbickKyK4raOSZpzZU6bk
         6FzVlpNSMK79qKHxkiJkWd8RQZEsOEr8ag3prit1hAqmZx+OqGwgtJYyjDEkPsy9sD4k
         Al9H+0EWNI7ze3EJXqfTkReWIj2ug5oRIfY5r6FbkhkpKbetGuG7UXcVmz3VwXnYklPr
         0tZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MDeplCTKE3hBZ9MCemPQht+8CuEL/Hn8Q/JJRmPD14c=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=IVjSyhV/BmeNfmjdNw6aI4cDyq7ytgcUfX3/GcMmrYLndLRGGGCFyzW4R4D4aCmt3n
         brUCD/qLJaCXr12FsXD7/8ONmwqws3L1WBPiVXTaph6Xa4Oh4RqExaM8UFTpRyLW4Zyi
         gmfntKNKftOIWvf1eJGWRJWPTApsR80NLdYqH0ZOaSpNCmGEx1Nrq/OMv6cFkTxDcJKo
         EW9hqq8dTS7Vkcm1pq0P9jBEmS0HLTxF6M3EeqKrOkTNKUBTq4F7iCd/Z1mZ1xx/ZWuv
         oHPy2/4pVJCdxTk4ZCrmzPVDlMdhjxBCzDiiTMNGLOhzKtrRp0ucXCBErmM6PYhfhSIK
         a8Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1771030188; x=1771634988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDeplCTKE3hBZ9MCemPQht+8CuEL/Hn8Q/JJRmPD14c=;
        b=epGufIGK1H70Grt5OOZBbPfRjmL0OLa+ClnP6ZFPS+T4gXbs72di3wpXgv8XW6YidP
         yyt9tFjeYzCjkoJRJoy5Kp3mQLiEJ5Oe40QXw6pZr6YV+tDzR3alX2kxp+ZLFl1/dilM
         JlYlaF19ek2nfJ/HpAPGC1NUvnwd/+qUPM2EC0LkKcndgqIN7PYdlukaqf4GnHsx+Kje
         gwJ/iVNYPioAjLdpOiI7czY+GfKr9rlnJNJvZRSlB6Pd0IjLj/fVj2BpgCR8jKVa7w+L
         rZUSY8S3+K1AuwDVWngif7MVjGlcyt2krXHEl8A2S4Ar/t3kho3EKyys51Akt9dzp8a7
         JUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771030188; x=1771634988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDeplCTKE3hBZ9MCemPQht+8CuEL/Hn8Q/JJRmPD14c=;
        b=ZVktgz6lxLY2SQk9h67hultvjG7vgdd5R/eUk5E+fYJyVkc6HmWAH+ELvirssey8ze
         BofrLbMOg4rMuayfZslHcrIeOqYEcA0fbJZJOGX+4IGdS2NGjeGf/Lu5t7g1Uw7Om5uW
         tn37ZdohrHZR1SlEitrCIMDl/R7q7u2zjf38VaC0Vmrr/QlCbiH6hViohq0UpUtVjBeT
         LO477p6IKpiE9J6+SR4K99USJD907nGKwL7os2pIeS/i2wnq4Nh/u8oXaDd32jWNZF0g
         xz3xV6aSQn25KdjMBKtzFsFAanMDcbXgR08g2/luiB2rlsnw4yS+R9luDgE3uVlIaOxo
         I6ew==
X-Gm-Message-State: AOJu0YyhKXVUXd/+LoTj+6ZlTtFg5R/o600Ol2FRKMTB5Yy+TX50oTu1
	i69JtGxNNOoj05Iem2uYAKqorS/sxNNFG7onaDzl28EKtNg/paAJBUB7q836qNDH6LpmzLa4eXK
	ryOsYwFm5XLMGBbxnqS0enUNP4L8ijWQw3VMqltlqDg==
X-Gm-Gg: AZuq6aI88Njy30QEp4dYqoRb9+tZIra/npdmZlj7DQfw+BDbBuk2Q8dFK1HQwXBJAPt
	uenVqDDElBXRHEmM+kyzbyDPNTqeJ948/t1EJfz0IoXUu+WUHwnf92JjEC4UsWZH7/vZw9rRJfa
	sgZvMYMC0wD+mCm+93Y11B7nIVgKl6h6yNCb753ySG+/BpATq3XUQXny5HswH09tMsI5fQ8ZYZC
	OzN2PUKtr0HOeBGJq0SKT/kTZBdZp5E9cR/qYPpfEGCcKTv6hjcoqkRS7McS2XfMhkGwSc/aEEK
	DnTShn7V
X-Received: by 2002:a05:7022:628e:b0:123:35cb:96d2 with SMTP id
 a92af1059eb24-1274103d2f0mr909512c88.21.1771030188313; Fri, 13 Feb 2026
 16:49:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213134708.713126210@linuxfoundation.org>
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 14 Feb 2026 09:49:32 +0900
X-Gm-Features: AZwV_Qi-J_fSbdclz5U2-o8QFNrhomSioWRPng1Ta1jpF_YCy8_tKpJrk64-VMc
Message-ID: <CAKL4bV5HP5PExu4DPHHhiDxt6n=SH2WEpoDGb+JHA+D_6RE+TA@mail.gmail.com>
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216313-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,futuring-girl.com:email,futuring-girl.com:dkim,thinkpadx1gen10j0764:email]
X-Rspamd-Queue-Id: 03CDE13A2E7
X-Rspamd-Action: no action

Hi Greg

On Fri, Feb 13, 2026 at 10:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.1 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.19.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.1-rc1rv-gfdd37e7f30ac
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Sat Feb 14 09:14:57 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

