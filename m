Return-Path: <stable+bounces-181607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98471B9A1ED
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 15:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7324A161F
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 13:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD009304971;
	Wed, 24 Sep 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biIpIQMr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0719F17B418
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722160; cv=none; b=bSMNqcfvo2EDQbv6HD49xQ8DqrDtAtZe8zQx9Pe6aEO6GFCyn4XWy613j6J5nPR32XkMkrSer0ok5H09BstPyQnXZbF+Wus9CzbA8TWwr50bZ8wZV20ZrrUArRiVRIfAPDzYRiSWlUZv1nPF1gH3GWvBDuSYLStfariyFaB3h6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722160; c=relaxed/simple;
	bh=DcpJ689quYGtSVJ/jZ50x9baeFfRVXjVK6frpcghcfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjSFT7hiygPquIbehRaljHPbVCHX8PS84FNbNVtOI87zGswJ2kdOogo8SNtrHJxO4sDeKHkB6/HLZkULB4LvTQ6jmEJW+wXc942RCwtlRAVDm3XA0ss1Xeva8OBmeeLA86g4WcZmdDhg/jiX9Z+G5b/zkeQVULrLb7OO5KEK8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biIpIQMr; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57db15eeb11so4329711e87.2
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 06:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758722157; x=1759326957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZpCdxXN+Lj5Wtx0PEqxVxK+0pszwy0+LCFjR3ki0Po=;
        b=biIpIQMrF4TaUkg6rBPvACClC/j4cy4SwIWwmLA3rCb7ltLj0AZCuHItI/pC3HJ0ul
         3wJ977BgMlQ39W68QF+J4sONffg9pW727zOyFJG8pmDmNuZRXTauufu6vKQTRt9p+H/Q
         mGdHHo+oQYgTaVq7IKQ2rSGx8hPYUvc2c0PGdkip2cYVMiJ3BQlx+pLSilXMqXU5earQ
         0Zcz6HaSSipBi3uHjIl9KNe7znWQ3DpPu0olWUT1cdcmusPaBTaV89jGHwb45r5BI1IL
         N9BTJOo3dh8jFXBLByC5EQUmJIUJ1aLfguqKGfTCjjiIA44heOZicGAwIgzL3A3y8/un
         udzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758722157; x=1759326957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pZpCdxXN+Lj5Wtx0PEqxVxK+0pszwy0+LCFjR3ki0Po=;
        b=FBP4fQUG9lvk8z7uKeiPEFhKGzvny/TTQbQOPdhs6es246O8DvUlVbq+wZ9EixDDY4
         iBvZKYbTgX1Zl+6faPDF91/Kak/n570lsy6OhHFGruXmI2xxbMGA57ZYDvqcqbjyowR6
         fcGgRXKfJDR1lX9xsCX2uLF6Ybw/voeYm9fxKemksNzPoAl6Nvq2dpL63dUms4/GmZk4
         cHQxwe3/eGrEr7cEib83xmbX95C4gZNSACtqcc+deQD9nKR58oiHucvrAapoi4q17Tzq
         H3gCOh5eXaoots8eCIWaIO4F1aRiwj4rlAL/BpMwN3Cm7p/QXppA1cagmjbVSWkHeB4E
         gYXw==
X-Gm-Message-State: AOJu0YwAkrBqbjzttDKa6ZEhUAHWDvrJRJ0VVmROhFdyxwYkH7Ghd6bv
	q5NAPbYww1dqoZ59TSoo6zN4DpcSGCnS81DiPtb2sPSsVyg8B72AFQUdZehGb8Rk7unJxNJM2gX
	sI/ts1bMx74j8IYFO5QJNZGBrh52a5BA=
X-Gm-Gg: ASbGncstNvbMz8953pBQMdLtfTUi+PAA8KvHDgcprvAqbYPvUpimPwGNOz1dFFD0ean
	rUHljq709vNlReU3QCj+wSug964njwlEmgRmYz6QUbJyVs46oTtQqxA2RRceIk74aGZlK4LOoaM
	edGRLqVQFIytrpQilVJ69zNEdVSS4tjXhEtYOdgvGwLxJKVBv3hRy38GDbCNATCAPpabGtA/SAk
	QkxHNQH9mucxf7F7QbYdCp/3IbT8GAvtwh47fNbfA==
X-Google-Smtp-Source: AGHT+IFFrQiSJq3sO4DDheNScCAZEm7ChSSXL0OrRgD+E9nQCbhqy0d6xm+S7jAokm2e7jUsgL24742yoK4fyiXLJlA=
X-Received: by 2002:a05:6512:2903:b0:577:1168:5e44 with SMTP id
 2adb3069b0e04-580732fc04cmr1917640e87.38.1758722156813; Wed, 24 Sep 2025
 06:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922192412.885919229@linuxfoundation.org>
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 24 Sep 2025 19:25:44 +0530
X-Gm-Features: AS18NWBDacVBK1YPgwur6lrJBXLhApl2Qt6ZIWcyrgcUSkgfBZfG1VuayMkdzxc
Message-ID: <CAC-m1rryCr1KGcCWYWkd47sy92-SP0+3WFqsU2mPSxmesQr4yg@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/149] 6.16.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:12=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.9 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Sep 2025 19:23:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and boot tested 6.16.9-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without
issues.

Build
kernel: 6.16.9-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: fef8d1e3eca6557cae4f0149eb2071123c473c26

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

