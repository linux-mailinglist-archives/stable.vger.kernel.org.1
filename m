Return-Path: <stable+bounces-227569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD1wIgx3vWmt9wIAu9opvQ
	(envelope-from <stable+bounces-227569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:34:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B472DD7C4
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BF5C3015B66
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FB3378823;
	Fri, 20 Mar 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCYOcLzM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD521DE8BE
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024457; cv=pass; b=LjICLkhOvXWgLI0HWdeTg05B95/vzvTWyxws1LgQIgxAfQ/0kJ3bJTCxurhLQopqCMamp/cjywzAMaRvNUf2ILgNImmNkMRTKuPXs48WEbkQwni4xASXBJ7sfHIDn6VIXPacZvDUireiYJOissnqN1iSysnIQGC8RSZ6FNMK82Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024457; c=relaxed/simple;
	bh=DOphXfirH2F31WL2uqYucmME86XcMutyVUWtIXPl7gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gnX3N+693i1ezG+0Ty1FGMUcewDVIQStHBLJdrWLClMVN/2rtmnlRn77IpqomvOHs51aFC9N13eeDlik0OTdBqjaoaBuvUnAPzvavWSqvXWIptrLXHSgGTHNzhy+9WgnMiLG+OjnzZUjIJ2a/RdDha09UiLUYxBn/UPnmm4QD1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCYOcLzM; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a27b5ad832so1980977e87.2
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 09:34:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774024454; cv=none;
        d=google.com; s=arc-20240605;
        b=fUS4bYaMBPHcD8GytSX9KxbQovKpgdLbSoGmn9exiDobH9lm1dE4irhhuBJNfL7393
         qo8KVl6LSjKLDidXdysfjbWkprgMZqw4LyKGdxm/ofYKlaP27ecJ0XrsFqiWpN71Apph
         Mt2Lp19sGB/cLRldhPQ6O68rrF0Oo+rVruIpXLzCh5G1O3ZBfKMT8zb2ZuhOdy3GKo2M
         DmpVGynbv3fICPPKRGI351p2/X9VGn5Pmh+jRSaER9q2P1nhT9oa4UwgvFOPQSuNLvs7
         h2uYAJ4XBHBaqweQ9INh1jEEb6ebCilOVm087H+7MlAPBHtu2UPii9MyO0+BJQGAxcHr
         W6pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H8qpsLo6JCO1BfmoZlP2l5F+fI7lej/in3jWBkiFLwg=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=SgjnE1z5IJYZhfDJ0G33vk01SSzPY2UMHkxAg4rSWJY0iPOqxZ0aykzJ67jkyc8J12
         xdNVRHD27IlmUOik/pn8yuj8oRNRe99EkD5hzDAB9x9gB5RrVaO6Sb0S+SdE5E5x5x0Q
         yY+uxpWegqsz3XWQXbvStBJMnsJZar/utg6N8JtvcPzGMdBdleH6UxDiJqXwIn0JlCQt
         OzJBWny7Uh6pGPjQgkIeJtU9/ifFxUrGr+2rl00MkUy2GlzBvo+srF1BpiW9j45HkqVN
         v+mmo63ezfnGw/Tn7R00fz+xb4hXA3TgWBDr/MsQrpIbluKBxzPzZ3XDs7y0a6wOuwvN
         k0Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774024454; x=1774629254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8qpsLo6JCO1BfmoZlP2l5F+fI7lej/in3jWBkiFLwg=;
        b=HCYOcLzMCFMIzeLZCCzI+H1xeomaTmwe1qH79sJVPWQzZf+FFBFFtoOlXYj+eMIe9B
         BqGe/dPwlR9lPRfPTHSd/Dl3iDwgzDxBBRj3brCCF1o38FQSN1Wqk+AgaXMKwKoQGPH6
         yovCvLRmYn3kYYja8df5hAW0v+LPkKKgkFBG9QIhJtXdgGQHifs7138MCkofPhCA47VH
         eQg9nX68OfkH0LAGP1sTdyCQ1scO09iYwZGZFXgP/13+tAYZDpYIAy+RIZH3TkAwsBzy
         APgPgSDz6PaHW5PfKRRSqw2sf3Bm8tykoKLdiRTSsxXSULdrbOtVMmAXWz5Ao6RmCLTs
         XEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774024454; x=1774629254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H8qpsLo6JCO1BfmoZlP2l5F+fI7lej/in3jWBkiFLwg=;
        b=I5EEpDGY0/Tzhkqxkm9WeDzgm6q0VjEksViBTNvCkheVMM9ZUMqa6E7AtnVH5ED3pQ
         kEtAHSy/Zy4gteU0MLv0jtmKeZcQHV/zp0puAuQDFG8VB/9QHXUEiEDgRA3qA4zovGYV
         1GvNhW8w7dSzPTC90PWt32XSvDyRis1mxv5iHR1FNLQUwbRjYTKqoouITv0jhRa9vEiY
         0CZ5ghhmJQYGv9gfdOskCSejWd18VrU3Q5zLOq48PsA+muPtl4ZpWpt801hS/A6Kj9Te
         3gkAMqq3Te5wJhFh+YbHI1m3WcsXS9Ib8Kte0DTtTu7Wf+Pi/ZJfsH3eZIjdA4WdYuC/
         7XyQ==
X-Gm-Message-State: AOJu0YycC8aJnZWrHsKqKWw4Rq0C2i11h2sPPbY7eWnIo1ebhZIVDxxZ
	Iat8NuN7ziBMitCgOx5G4WmcA2ioSl4P6F5OCyQkn6sy//nOwmnVbxzVn/guJXLMz34tp3NY752
	cYQAQsWChYe427NNkZ590Uf37dZ7cNKA=
X-Gm-Gg: ATEYQzwfMLqp1vjcZfJ1TUuwHgOzmnTl6rS+jzp8V4BO8dhtohvUTwduoViWBQp3Zlm
	Mv7QwPR+/BVBTHr/9NRnG6J2h+sh6s14Czur8h7Z9jl8yLAkhCuLddxd3+GIoYaBj+GXBDcsa9J
	f0hFQYFJvy/jjSaVI40qd/qfiE9N9HEVLxa2bXVz0LMnNm9CwmRt3fQQdTeusipMC1XxSC8TiCu
	M1xYzXo6eSpnd5Euyv/ikJVWAVzLG/mvfMIbGn+wyOfTIJENlWxS8M8igevHpjJQEbNqLv+myKL
	eP25NqAJ45qrmUYjJ37D5l9Y/RGwEB1dWFuBMeXX
X-Received: by 2002:a05:6512:3193:b0:5a2:820a:3844 with SMTP id
 2adb3069b0e04-5a285b5d3b8mr1572683e87.38.1774024453737; Fri, 20 Mar 2026
 09:34:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318122547.233850204@linuxfoundation.org>
In-Reply-To: <20260318122547.233850204@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 20 Mar 2026 22:04:00 +0530
X-Gm-Features: AaiRm51G2yy0fhKyarz6O_yzpjAq25qCzPl_UUVFnMjAb1fnUFGyEBW_Tgqmt7c
Message-ID: <CAC-m1roU9AoCk6Eo+C9xB1o1XCKtSoeb+nU0M304iQYJ8ckwsw@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/379] 6.19.9-rc2 review
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227569-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.554];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 30B472DD7C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 5:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.9 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Mar 2026 12:24:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.9-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and Boot Report for 6.19.9

Build and boot testing was performed on version 6.19.9 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 08e4691d3bc050704d7ef71a30f4143485833f1e

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

