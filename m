Return-Path: <stable+bounces-200745-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2C3CB3EC8
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 21:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1894C307315D
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 20:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B45C32B990;
	Wed, 10 Dec 2025 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="CdHHNVPM"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF1730F7F0
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765397566; cv=none; b=UDF8Cbe6Z0O2XNZdlOM7sqBuun4LrZSVt5f5hwgoLVKNfI5rbNvn6BZ4VmIydphvexOJFjyjUyMjCQIBzrgh6I2vGqxoE965PvNysdd98dhh2JjaDUp89VX0alA1c334WHL9rPSrM4vy5xdjrd2QcJZrGarlfQMWOD4gPSkkBp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765397566; c=relaxed/simple;
	bh=/vqf8B3VOiHUz8HK91xOa+WuYkkvvl0yRf7Mp0HlYMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNwJMudebKGXbVhnrt9dl32Zg1vvvPn/ITG9JPbWiUHAA+K7HVHbUpoNAXSRjr3f+DjpAMMm6Pn1NYoD6i23icA0z+UscAMAmZ9DG/XJaaBbkzjyqN5iBsiuu75ff8uKB7GCqDnUCka6teH+uXOF6RaiOp5yQuLpUsJIELPpcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=CdHHNVPM; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so2031141cf.3
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 12:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1765397562; x=1766002362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX7xdu9y9mJPk8s588MHVub57pdeM7pGfuNwpdBj3Ls=;
        b=CdHHNVPMNxSO7MVDO75FTzXx9KdJtW9GfhxI6PBDJcTg9m58Zy+nddZppXaXkuMs8S
         p10z39EWTQUZUuApFt9+TtWW01z4TFh4hd77XuK00J5c5D3EuDHAdN1dRGbfGFLbzzEz
         H+NlLZIS2yUyF7RpVdgqoLHpcFXYLazENECOnQ336I4uiheJoGnCbNb7j/l6OqcSqwfA
         ioMItX2aRaroayVHqd/Z+IX6uYNy+M++5l+G7mUNZP2ZHVZ4SmujiDbzEWIe+Iqqm42K
         QpvR1fOFSC/AZeSLMfb5ihlMKAxg0HJd50L7nUAs0EASHI0gSPeA3VsyefNFifByj1bp
         4ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765397562; x=1766002362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IX7xdu9y9mJPk8s588MHVub57pdeM7pGfuNwpdBj3Ls=;
        b=T/42IiApGapDPr0nOObz3+ZseJo8A8+rLPdKCpz058Oz/z6dbGp3GSnkJpaiPWtehs
         3+HRoygGE7xgt8OFXZ4DfUwhj5v8Z1XDLf3ktd1/QrIPHLRZr9FNGriIfq+RMUFASiRZ
         QVi4OdxBJckEj4Bw+SW3WehNtMq9y1ligFAZ164jzxCxD7Cp+q2Bd1i6Eka3v2lo2S50
         Q7dSNAWozpsImp5AMX4NiPRkExHLDwpDzT8mhvhepyXuww5qrFUu6UslPyBgfQZK5DYl
         1L9NfQ4TLTD03a4RyW3uEUEDMlAcAtVU7d/8AxFzvU5f50DMGWYgeS/NdBOyG8IFSEJg
         wong==
X-Gm-Message-State: AOJu0Ywhl553T9DD6qMHIqvLXUSYz2OMPe0wXmuCCAwWBRGUP7xVlUpV
	DC2Ci8aR3cXQnpUOuD3x3ht950qsixHe0L2HiOSuQN0X8zrcA3uCW2B6Nuq4NGkOyL2MEUhJwMn
	Bf6nQC/xIFwQO13fPPVGPJEDRG7zT4Sx7pZ7lDrjgSQ==
X-Gm-Gg: ASbGncsjCugQ6CIw9nnGCq9yl/9B3P7iXJXesORIhKT+sopVhEkKR2U+Q7NV0kOj6vK
	S0rGbOBaDsiM3AF6h0rHSYTKU/FIDzZTV4LVZVWiDDr8Ik8INRsc1fEYbQAILu9KI5xMBamjNlj
	R83B1of1yW5S12TkgcEWScBWZ4UdDecdzLbYwO/r8eS57O5QvR6o2hNdgs4mRfKceXw5DyK5V3h
	Zy96Rmk2HOuLb6eour60+n4bY4JrcAgjidgqlEp1uYAVMSq2RDGpQOO7NNBqjrSeyjO4kzaSZd3
	AZNn4bM=
X-Google-Smtp-Source: AGHT+IF6beW/FTQQ7sngK/DU1tUniqhX+cg5rzzfofzYLtiePPogSjjZLPMyZMXWF+zJPlOshlGeLXNvAdNE2XywNtM=
X-Received: by 2002:a05:622a:1e05:b0:4e8:b446:c01b with SMTP id
 d75a77b69052e-4f1b1aa7b84mr47097291cf.61.1765397562358; Wed, 10 Dec 2025
 12:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210072948.125620687@linuxfoundation.org>
In-Reply-To: <20251210072948.125620687@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Wed, 10 Dec 2025 15:12:31 -0500
X-Gm-Features: AQt7F2qAPAE15_F1zEglUDRcRtJPoNPc50UUqoV-4xo4tO7GO-lk2vWhShSlXE0
Message-ID: <CAOBMUvhCuDJa50FXJtAvCVVu764ue=T5x+Up9jCHh29Mw76rtA@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/49] 6.12.62-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 2:32=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.62 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 12 Dec 2025 07:29:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.62-rc1.gz
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

