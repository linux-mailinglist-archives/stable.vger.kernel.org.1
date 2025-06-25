Return-Path: <stable+bounces-158599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C63AE868B
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B70E51893482
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FF224A06F;
	Wed, 25 Jun 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=ciq.com header.i=@ciq.com header.b="cEnMhSXm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749A14A4F9
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861933; cv=none; b=l1PILMBunW8UzN/Vpk+JVZKDm1ZeqH6hDgvj1yHveiqcpxC41V2/D3OE+X5MZ/ClL0ejXKg1We7pg0M6nzX538At1KQs5OGWxZ9yCI4uAFVCzpVuZtAGo7PGunkPVsEVawo4cc/e4qnvOehdznLXXnImjRTuNgsxkTIRmSi7IQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861933; c=relaxed/simple;
	bh=36jFcNi5AMtDfDUxJWLv7FOPyUhXdgiBwK1gip+Y68Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUbCSnshKUuVuoqOBzXH3V8r3l9yEahrFAlZtp4RhtqdW434buk18zZGVGBh+Yun9L1WiWPDh0NmCY24c1+HQvRghWOoI6adE2e+o0EwirasGRuaAITmqMpqmVpaMuYXv7v7LUfdFZvVR9sP6AUjus2yvbtAOjhX2g69eFqOjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=temperror (0-bit key) header.d=ciq.com header.i=@ciq.com header.b=cEnMhSXm; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d412988b14so155392485a.3
        for <stable@vger.kernel.org>; Wed, 25 Jun 2025 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1750861930; x=1751466730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Vaw6UAlGLmX5XnFTSQ9UINLTAG+KGTITiCt0APsbtY=;
        b=cEnMhSXm4Qrow3qjuFrrGoU9hl8V+b1Nh408VG+rRctAkJyPwriYwVRujj2S5ZyUFh
         CemZvHJH/9HzqQ/yStLSOJgXQNCUkDN10Qyerl6v3VaA93Z0/ohrhE8wyvCqC8wTS2VU
         OxMlaRj2FGAXzoAZzG9PDHRfCplvomcBpt60toBkKkzN/celChdoLikWX5cjusxcrJgt
         wVNEkx4r2I6mCy0xi+5NIQeae0IRbYJ4zYuLdlb/mIaxusI9QTnKs0DuAtqD86LyRpHK
         rBCZjzjenLrM5yVhONG1r8XOZmR1qENCYrr8NgGuvE7NQHoBAOwIKMr90rSEE4qFCJsg
         lpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750861930; x=1751466730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Vaw6UAlGLmX5XnFTSQ9UINLTAG+KGTITiCt0APsbtY=;
        b=ScAAV+bfVgq497bdYbqjyjZ3cBCKAgW21adIKphbP8ymIvcKA9+5rzOTkVSQ/w2TJU
         ZcuPhmJTqgpgRn3znjHViF1kNlxs9T21wEhxKP4idq2WuedgGUjRpsaXVo0IP8rglI2e
         CD9hvwhN7XG+sHV6HPK5zRGa7T8mK/1dSsQ/BzVB4wsFZQ+OuSCVMMCZtEeEPR5oZhom
         MtrCIylRcQAGjtFIQDfUoPAUFCYMhY4gbeURi5Sfm9kOfyWCe6XN5nHtiNicoL0wiuRm
         krhQBRheq725N2ZQ30wLTWC2+ia8gF+/5EMZN7X3ektK7MI343GhbIjt5NhwU8ViemtI
         URnQ==
X-Gm-Message-State: AOJu0Yz3ZD5F0Iyg783vBNqH+vAfUFNVPmeFXVxpyWzoJPIiwm60qmb9
	E3rG2wAI82c0lMYJBwiKrYNLTxeeAGF9pcN0wJ4Nt70YdWxNCi6qlapCetHhG9yPmyTu/ZGeR30
	S8ohCiphbRDbeQOlV1Ndy7EhfhMm8uf9qgEMcaxvmg9GpppfImmxM+krNBA==
X-Gm-Gg: ASbGnctuiYwEf+IJYWfmWBGNP5hQtrmRyu7D8jmHgvjmm0MUz1/8DukRTvTb0tnIno4
	ETo5Q7uzGTwrdfTtdAOwf0u73ZEdBBT/QyKu1IKimihxbGzNzgwYNQnwocHX0ZSANKKN+EZfDqW
	p0d7UY7f00PVflQfyygDvwGOds66YfIzkRAgAFUxPh7Ck=
X-Google-Smtp-Source: AGHT+IF2FmBWl6hqQSw2dIMa/iN1L0L/HGqhMRXMl7b4jLmd44qi6m3OJaL1JIBpTME2CDDJL00MZsFOUSwKBfmsMZw=
X-Received: by 2002:a05:622a:1105:b0:4a6:bd99:5b30 with SMTP id
 d75a77b69052e-4a7c05f9cbdmr46296431cf.1.1750861929919; Wed, 25 Jun 2025
 07:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624121426.466976226@linuxfoundation.org>
In-Reply-To: <20250624121426.466976226@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 25 Jun 2025 10:31:58 -0400
X-Gm-Features: Ac12FXwA-ei6dK0JEz1zZ0PaTcCEPi5wGhoiU2mqpDM_OzesGNEGCpdmM0EPskk
Message-ID: <CAOBMUvhnQ+ijRh839SUT4g0-y0zy0E_Nx65xpqOx1=2fF14nRg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/413] 6.12.35-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 8:31=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.35 release.
> There are 413 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 26 Jun 2025 12:13:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.35-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

