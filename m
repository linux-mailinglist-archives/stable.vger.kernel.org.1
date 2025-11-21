Return-Path: <stable+bounces-196540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25530C7AFF8
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F043A4DAD
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063CE342523;
	Fri, 21 Nov 2025 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="A8J0UwJs"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D734F248
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744770; cv=none; b=eIlhXJ9v7CwzriLYSL6S0cue2KqfT/RoM0nPZOg3jxepyEvPoZ5hD3qa3THA13YjZNS7gkreC1bqfvNrKNz/SDpIivOjks4xHY9X1qI/dn4cWaNbb4ZAeAL9xupRAat5SmbeGYykWTjnxbKhwQoMIuMf55Fh+o4+yL5qe1ZWJqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744770; c=relaxed/simple;
	bh=g0mfsY0BmjhW4/dF/KhvEKYszrj7C7YT3gH+KjbQ+8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ri4akvi6puhtBdbsf/CxXLjNBJJNwpgx6xP6l1mWWpew5XeLExSMGab+tnSXw/qxARRxFoQaAhT7BgUer7uA00arL1pwcoQznZ1fqz08qKN6v2JXUFdbQxz6/TQSXnxXVOs8mu2kreHV2cROp6zFf/9+6h5rT3tX+DWp/gvE/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=A8J0UwJs; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b2148ca40eso301654085a.1
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 09:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1763744746; x=1764349546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wij9Xntwahn42XWWuPVoXt9ccQi9c/pGIOq4xQ7R7ns=;
        b=A8J0UwJsN9iYkyye1D56/XZNh7GcX2er7EhVd8kfaQmJ7McSzzQ2eEWaysEhhdz/RS
         uHgFPOU1oM8Z0ZhOiGKS/j+rqDSPz/kSD7x0a4P7Ia5dJWluRvDFtLXEMAU33BketYQa
         kzbEtoBSH9LeFOEP688wNTgYR78KpnqRJbfoFTLezDl8Gy19aYCMlB1EmoLxS64BG735
         cuWf1YLapdgZhefYTXLW4n2ZECIvAbAYpnJv1n9hPz8jojY4mn2NY45kgS1W9ndXHPaR
         JkXi+ZZiEW8uDMoI5jJ3X8ptElUSp1Oom5uOIvpxNH2hcL0XGGMjszIZYiJD2D56pyCk
         LldA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763744746; x=1764349546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wij9Xntwahn42XWWuPVoXt9ccQi9c/pGIOq4xQ7R7ns=;
        b=VMIcNijoceYgSLHhrAo/VFDj65ISNir3GgQGgMvmbna8FbUQH15EiDgiLjbGdv31/N
         5YV2wYaEZ1rHZTlBk+gsFsHgf/ZKAjyTv9avc6YRwWoewoYK3pQQmFFEQ4+b7/AwfgT1
         zg5i7wNYtddYsbRLbSvQupUrHQnYwaToVHiWnWbVbXn2WpmMteiEo/fRRgGAP8L+nD9T
         33m8WxpXGPQ4IdErL5CIcq4ekW7JndKyJvoS0L8ZsFlga6R1u6ru3U6HsN8Fbo7u21cU
         cg2scE/3Qf8Kb31LwLtuyogxvR6NjuYB9KXxJPccq1ZpykpabUqBUl8lVD5fFip3Llfw
         VlXw==
X-Gm-Message-State: AOJu0YwA7bb3YadWgVdH2q5jo4b1zy0yd/GIzmVi4Jhc16p6AhjZVh1I
	JX/DY/pI/bxmuPsGLaZMlWuIL46MH6sOaspU0vUIGKqhe+ZglR/Tmdidap83KeQ8EQCCGirs0Et
	AaCKYbR7MFPGfUQBj2MV0PAkHeEeIZLhmpuF9Tj7+CQ==
X-Gm-Gg: ASbGncvph8hEgsrUxINejy5bmw0XjeWqIEkk5OeNDjyU/E0Td6+qSbfl6nC3rL5aOrD
	LtNYqzgrgHlGIPH3LHV0xPp5ymCv+z+M4w//BPtXMRlJ4tQ7U9hRScz+xFLvAgC97eIgOx1VE2d
	S7GBpyIOTPbB8h5idk6gGtGUshy8ysaK9ae8DekktweYhmGxgKUbn4p9u5tLSt5E+ac+yN1BtcT
	GKQwUrGViMofxqPSGQSW/Ab+ubmSnGpsB3bVTFC9VroPB93DCnNBOo50a/hloYqnbxXP5G2Bchd
	JjfDRyjaYtBOZW1GVZ8tLUbGDeyxew==
X-Google-Smtp-Source: AGHT+IFyBPJMF8miaqm3J9SeysyAeoBZfngbCeF1gqSOLxlti0idn6DI6f+6z9hfXCs7YYDitoNDIPf15wDpSdSL1ow=
X-Received: by 2002:a05:620a:45a7:b0:89f:8bb8:c103 with SMTP id
 af79cd13be357-8b33d478a7amr355225385a.49.1763744745585; Fri, 21 Nov 2025
 09:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121130143.857798067@linuxfoundation.org>
In-Reply-To: <20251121130143.857798067@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 21 Nov 2025 12:05:34 -0500
X-Gm-Features: AWmQ_bn3hUma6F2fPIPPqFRfcMUsz1CIgpb4y0PU7vh2cBVNCFWZg4gJ3dFTi64
Message-ID: <CAOBMUvj7h2K5n44e=pRZraE5gSw=Ndej4nCf5sPONqnaFStB6g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/185] 6.12.59-rc1 review
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

On Fri, Nov 21, 2025 at 8:32=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.59 release.
> There are 185 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Nov 2025 13:01:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.59-rc1.gz
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

