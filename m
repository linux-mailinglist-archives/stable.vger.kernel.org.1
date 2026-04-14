Return-Path: <stable+bounces-237820-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GlcMcEk3mm5oAkAu9opvQ
	(envelope-from <stable+bounces-237820-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:28:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2A53F9561
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC17301F98C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD55A3D9DBC;
	Tue, 14 Apr 2026 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="njagFLoL"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F22BEFEE
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776165996; cv=pass; b=LI9P3+ztxl5JQ04dSukP+j4FYJvRBysfckwSlln5hwVfQcGnSA1cNT69Z6t3oTu/qGhyxM22J8TlNgbNy9sBlyzZBMi1n27HxnEtmOGsDzM9zSS++Du1FAaS1V9s+3tyNgzQVOc9BfiG86aK1fdcxX8DNh8ZVTQOUwYgryOMC4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776165996; c=relaxed/simple;
	bh=U87Ve3F+slIiDwwj/zfGyU5acKLqTAX+27VOZ4zryEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jti9t8DWRLEAh/94zqksEwev3TbuS7/wobgEOPog6k8RvKkC6ew5mqFY5zqntFQgO/bROGkseV5PiWvbuB4RO/NPmwahVxX5btr8nhJJvbHPUNnR4hBC0fbcNMgspZ+gbcpsKX8dnkNmUF85IQE8ACf/Pf1B/Vis5i9Li4A/mtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=njagFLoL; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c1fcce8f8so10308108c88.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:26:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776165994; cv=none;
        d=google.com; s=arc-20240605;
        b=bOBWsJZ+kbUwnNwusmHf/dgW/ZZNx1Y6ZMLIZyAgu2vYHC0NSCmSemlfFGei6P6dKP
         +TuQY0jJWF5taTIhNZaRysBPAd5HmChlzibI3S8W7BDdp3o+74JXDjwOAMaChHskw4h6
         4OXzh09HekbUtg2/D50iVYKbBpqvWgncH2hT1+nV7hy8CoYvO9l0veGr21oTs+fqMQ3j
         wZrjBqX49nrjW66SYQma8lLurVczKINoJAF9JLYVZ9RT6+hIZ12Izke+c1rAZr4m1UIn
         PZeUz+WLlLkNF8Eq9SKV2B1XfWtsoWruabRD84DAEUC0zFsxxVziRCiSPaslNU39VQL/
         xJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZ2t8Ae1TdyBWLVMYN0Qww4hRu4fpS7X7Z7GGfCKD04=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=NI8qwjF3L2zMbIs7vePmxuMVdzMvIQohwAlQEhCzvmCIZCaIqgiABnl+BVxf5NKMhE
         Bb510jSz3G0jlwAzkY09Jt5qqLzG8LJGPN0ILFygKDLokHiezjzgozcQ57ZM6aADm14s
         hZLGTCbN35t5/K9LBaRuxETVSe8x5xd/EYXSlzOwBJPK15pr9iZiNCtMBUIcNzOQqoly
         KeasluUYxmDyAFJxHlIcGlqaTjf3AajvRGP/QrsNxU60u6ravaNzKhh93APoWM6532I5
         +8BO8IjD53kAbNMpllg5BehQOerQLjEsHLQblPaS4V0aiu/eRtY3JpExMi7zvO7BSv0V
         ZFYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1776165994; x=1776770794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ2t8Ae1TdyBWLVMYN0Qww4hRu4fpS7X7Z7GGfCKD04=;
        b=njagFLoL+MxsUztgftXLDDVnHFnALHvx6h2S4w9KtERkdgVHYOSFyDuCZEYuhLd8nC
         ne31QyHWNqVyAr0fKWILttXYKVkXT/JVySK0NnFUlcjwt3KxoxcAqgIv3jhDT8naeagX
         tGHD1Ma2ZMsO+KuwrhSi6ryjE7Na4SSILb0rhCXJFZK/DY6BFB+GR+LTTnLkGZn42gBN
         epczBNQLJMprjnu5vyyt6fwARfKIrNNc+m1iMCAkEduLdYevstdmmQzctFXGJlZ0g637
         6EPkyqZ8TkCm5h/GH5M+7AtNzM2Tokuzuph24AfqrNDCyi4tcahYUXSDrsMbBrqfRe3x
         gjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776165994; x=1776770794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IZ2t8Ae1TdyBWLVMYN0Qww4hRu4fpS7X7Z7GGfCKD04=;
        b=CUnVCqove/LObI65Zv7qGEs3jI3Vpy/ZjkbKw8LkLLiI5Uw9xEaMJhzssSnFBOq/QC
         QMzfpE0qVlxDlZAllbNWaoTB237SO7g2LTb/59ZLuFuO/TMm7FmRA8R4gc/SA+SFSuuw
         gu9gfffpPwXzHTgWY1XxUXvmcxwjReqrB318zcS+dAoTqmLtd9naZwy4RCptIj+VTNUW
         sJ0uEVl1KNWEaJaGbXS3KOVxEVrWlEkcJsjwMuVmlNPcL3h7y5kR5THodHmS0OyEzP+f
         +9SyIMWO8kfQF5o/TghXzI735wFSKdrXTstC3RcalxAk6RBJWHauVKl36SOu6Mr6+hhO
         U5Lw==
X-Gm-Message-State: AOJu0Yyp6fmUewE5hLEPQiXU8IiSP0Xvrl7B/HEOBFKiOvz6P/pnyQSh
	csXWilpDzs3nBtt5n9KBwefipOv8EJO2hTUpvBN8PgNTqaFvuecH2FiekanIVEpZo5EYVtS7U80
	C5iy2S0x5Q2FMnzvbImv6Hknfx8uN7xJadlW1QWEb+Q==
X-Gm-Gg: AeBDievGevQJ9zFNdKLVmcPwbYnq/8c9+uyJ4czRsiCulQA4HWB7ntfyODaqn6276n3
	tOBMy5J+U4EiRbdwuLhXa0uiVqa7C2D8g2rwdKkuGL3UJ+9xi9Ky8qlmAC0HCVe38ckxxFiq82S
	Vj9r8QpvHiQCCoY5Bh+ktR2f7h/Bz2qo4TZekkYclzI1xawXuCU1FTKD1oKGHmMQk5J8Ia2rYI0
	vwIY2U1VEFuVqRSIbbLxpgUfFuDVMJKV8U9n2wv9aYjV9p1k8ctyyMTHdCqGAIxGGLwDrAdHjsL
	UWvHcSQn
X-Received: by 2002:a05:7022:60a0:b0:128:d51a:5161 with SMTP id
 a92af1059eb24-12c34eeb884mr8941610c88.27.1776165994246; Tue, 14 Apr 2026
 04:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413155731.568515178@linuxfoundation.org>
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 14 Apr 2026 20:26:18 +0900
X-Gm-Features: AQROBzCxrSiw-mnC-3e-VB4zdM2rQE4hYWXDBBBLHtPC6QAKGrRqP97m9UDgQUU
Message-ID: <CAKL4bV7Uec+rF_21MuQEpGcX9i9LVeBpqVR-HX3J5LUR88mzuw@mail.gmail.com>
Subject: Re: [PATCH 6.19 00/86] 6.19.13-rc1 review
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
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237820-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[futuring-girl.com:dkim,futuring-girl.com:email,linuxfoundation.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6C2A53F9561
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Tue, Apr 14, 2026 at 1:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.13 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.13-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.19.13-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.13-rc1rv-g425b22d9f3ed
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Tue Apr 14 19:32:50 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

