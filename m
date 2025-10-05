Return-Path: <stable+bounces-183398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126D3BB9954
	for <lists+stable@lfdr.de>; Sun, 05 Oct 2025 18:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE5518912DB
	for <lists+stable@lfdr.de>; Sun,  5 Oct 2025 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3448B67A;
	Sun,  5 Oct 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqp3vaJd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B727461
	for <stable@vger.kernel.org>; Sun,  5 Oct 2025 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759681013; cv=none; b=DQGC/iyHafk/eYq+Q0LtrwRQKlNeKonOJHnDvdpv28ptDJNqQRMGGHSSZ/IC8ldrKQGzqOBJfdVj05f98uznGmY+XSc2zT2uQAgTb2bSSmZ3008w7TQCZMxCI/Iz6ISP3SnhG+ll2WAhqMQ2hUdRjmIBZiK1OxWT7mzUPHdMMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759681013; c=relaxed/simple;
	bh=dty90F1rwneZJconV3QOpe/vTPtclXy/p4MVSEe8Yn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mrUynFvNRCayL+RzyeBa6Z+JzykSrC5ClrAmnNrAh2g7JcpHZasYIKgl1THrZiHx0Ts2gdzQqm5l8KTa16lJrnt8Uv+IGYyTM3aDNbUi/T+3USHqIE5xmz9zfh1kln/vZJ6r/pCycNn5Vz2kTr1KQ6k0dGZpgvGuuGtOBrfRGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqp3vaJd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so49744231fa.2
        for <stable@vger.kernel.org>; Sun, 05 Oct 2025 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759681010; x=1760285810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZ/Xe3yLnVX9DMsOGPDjCo4xUIUON52FJicpdmr9Qi8=;
        b=gqp3vaJdGPtMfAnsFzAqGPHyg73XjRABwRbWKcZhuwCm4pWVCyjo3mdmCPFTlq/HMK
         a4jUVsS6+g2PBsGkWUGiT+TXD9erK2mU6sggHkSbt7jNpP9+6BhW1eCk2KLk9kSAKMwV
         BNojlNwW4R8YXD9rZ6JwAjxN1VJg/ERNjIRpgql+sHuVSn7mPAHYVEuJrYRehbuafpJM
         nEMXBpMYwYZyBFKX0adAEHPm7MIKWUv60RRDJmLkQYajreg1iLrduVtFgJu5kxrJ+U0O
         iIU2jmBY3yebVqXPpxPH6R3eT3Zvr1ssM21rBfOKx4Zt6dRN854O8dcyZ4+gWtTVxtHb
         m9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759681010; x=1760285810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ/Xe3yLnVX9DMsOGPDjCo4xUIUON52FJicpdmr9Qi8=;
        b=qw1nvC/3VTzPXdkphuxF4w2IdVu1l5Wn16kjQZz7TAndKqdeiGEfMXixx70YvwEQSB
         wQfoD+HIGwoqPGGnmmlE5gur5bVz49Nz6snXpKZi8iiECfOl8Ar27xNkv9UNcJW/VB/e
         f7Zv78XHco6l2tqMeZDbJJUgxSQYVwdmbuyPRrM1Tvcam+uGckhHRtH+/9nQM/ri9WUT
         Qxg5wDwOq0sFITemocMvtcokl9X9KyENA801pxTE5XveIR+28ZvrjqXwH3Q/TYF255LK
         P0of5iBmjICaOR9o3bBG3OiFxbG+rdb34Eisrzus7wKwKgtWqSyK5XDz6Kw7T+xXNL/V
         2x6Q==
X-Gm-Message-State: AOJu0YyunfBqa+3v3y4jM8vd7kTJuLyEpgNXVfstss0vg4v2zW6hPlpI
	8FVGLZrDKjVKhxyCYXz1wQwy7CVV7D2QznDtcuHMtO98kl0M705QCvZTLw26zJ74XlroQ6kmYJK
	lUqVexkvhdgGvwRbonrrit1rg9b3Vclc=
X-Gm-Gg: ASbGncttNzgBJY3xP1Q1lRsq0HvsfcFg043pe4B0xZl4QPKQqPxC94iZwnT9NdsU/qx
	KYENk7WFrqSB/D1eAs7sH8tmxKg8e7vqXECs37V8oK2pJwm1a7XaqPFWAESdXtgof1AX33WsAO+
	6Go6Wwn6G+43mVYjYYB0aUEri+eCRyAKgsBGLk3fI6Fy65TdcpkEscefNQ+OZ49oVamJ9xR/+9i
	v9UcGad47aohJZGoGhHoBoTS1yTD634F7vqqzM5a43h6sb6uhsxa1RectOIUA0=
X-Google-Smtp-Source: AGHT+IE/dRLMfEuaRQqy5I4fZVpH7vF/19UAx7JrGRcujK2n+IGuU86xj7rH5QbW3nldnCI8sGQ+vovSwKvXg6cab/A=
X-Received: by 2002:a05:6512:2383:b0:587:b4f2:7f2 with SMTP id
 2adb3069b0e04-58cbc67fd14mr2692880e87.57.1759681009447; Sun, 05 Oct 2025
 09:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160359.831046052@linuxfoundation.org>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sun, 5 Oct 2025 21:46:37 +0530
X-Gm-Features: AS18NWD3xFJTRgNFUfQnn3MOQsNtm_4XFNOYW88C6cthLJM2mf2PXFq2mY54q_Q
Message-ID: <CAC-m1rrzZ31hvy2r1b=UpCtb=n8dqOxb3CMRL-eFP6F1A-fExg@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:37=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
Build and boot tested 6.17.1-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.17.1-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: e7da5b86b53db5f0fb8e2a4e0936eab2e6491ec7

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

