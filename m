Return-Path: <stable+bounces-86444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D789A04AD
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 10:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2177B1C21742
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 08:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A4203706;
	Wed, 16 Oct 2024 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szMAFNSK"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E1156665
	for <stable@vger.kernel.org>; Wed, 16 Oct 2024 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068667; cv=none; b=Y6TY7JAjpvAaV2VSEq0zPw7RCEJB2YAGLk2ia7dp2hlZf5wRF2NSA1wKryTNAXC3Iw+6eX/KcXadPGTBEWdV+TpDyqfYF+3u9ADH8zcfC7sL7Pgu3W+BZDjmhcQ+Eu3Cm0tELODwQUThLJPPB37vdNEL6FKZtxMVUfzXJxpHHqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068667; c=relaxed/simple;
	bh=8NydIpP6V+e+N8ggMR7M80MrPzVoop16b/UyH2Qmok0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6gt2GxzpWv5Pve0C1xa0eqdCnB+J/6tz6/EoLdcmKXCCF9lIi3J6rsH2FFoJqTU1CyI3BwZizKpqr8qT2xx1va0Kn5Hg4fJNs9nuMTKEKRKEavYi2F+8Y4xNhMQzALtLkLoyv+lKcRTJqWYfdlpk+6qXoKItfoT5l7RK6GyeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=szMAFNSK; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-50d3365c29cso380513e0c.0
        for <stable@vger.kernel.org>; Wed, 16 Oct 2024 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729068664; x=1729673464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ANHELgOaoT88BOZwA8pHzeo9xESw2DEE11rjn4SfNE=;
        b=szMAFNSKYN8PIss3GjPrUceWpzMpHtiVR8Z0x073qzjUj38GM2X8JQYEWpKFJuvDnF
         WnmkL3ker1N7TgQlp47i/BR0hra8UySapmNR0am/xPOz7Z2cYbt1Huh7fKCZC2l1+mDd
         9Qn04uMJ4KXYEo64xsBMRZnGND4AAZaMkvr2L/C6MIaMPpSrTHcZBEX0qdTV3QRwiSLq
         CXG/85Uq4kFYwG14JZM5iDsPwMXQVs2vJeZnyOikd0mteS0hC1C5McgZarz2K1ybRr/T
         YOjrrSCVEjrgSSphv76BiotALsSUgWnjFABVufIpssJvQF/BAinz2j5AdatmjgM0+pAK
         zonA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729068664; x=1729673464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ANHELgOaoT88BOZwA8pHzeo9xESw2DEE11rjn4SfNE=;
        b=WhKhYPJb0SMUybNulTq84ZBGgJy3cPaVAf9nXiyEuiHkyJsViRf3VljRMvGw28K0pm
         rjOaeWtz543lQyXEucb4vI5zqEweuThG4clK76KsWQOgbO6RIBE4mAU4A8UufLxpFreZ
         yb+YQX6INNVG85pjbi7+RtnOLGUJXIwcZFiIFJsdznQiwvwe1jamy+MFuOx2ga/ZDwjJ
         srGJfv6v6BlaWOojv2epfHo3rbD35YfTrTcgcgeh4F1vofVjiPbH/7tJByzOOj15osbN
         7iaxMp+7mDJFCI82SJ3y9wuWyZ07zsW+QlsmfM0jY5mNURVu+rGlWlxP3WGWZgSc+8Fk
         1lsw==
X-Gm-Message-State: AOJu0YzQgMvdcLwIppAGD7+TMRg1/qUTjz7J3E/FdXbxlmmGRglJx2MR
	agL9HhfFx0ThsHTCIUqZjnlhkAPJD86KKSqlA5bO6A4FSSKDjAIE1rOt2WATrjL+0LjXV0miqRq
	oUSLDgRnauOAkJVyT9GMC+sbTTbFcxnvTl79VlQ==
X-Google-Smtp-Source: AGHT+IGVdvndE6DwHCl5J6Bx21l+qKZV4+9g/LmWrxs09SV5bTqLudTXO07JdxM9UxTa7+v8ReLIVtv+66nQOC8lm9A=
X-Received: by 2002:a05:6122:17a6:b0:50d:6cfc:ac4d with SMTP id
 71dfb90a1353d-50d6cfcc2d5mr5461175e0c.5.1729068664655; Wed, 16 Oct 2024
 01:51:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015112501.498328041@linuxfoundation.org>
In-Reply-To: <20241015112501.498328041@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Oct 2024 14:20:53 +0530
Message-ID: <CA+G9fYtG=-cqLSb5utqMT4FuT=yHrcgr0UCf1pkUbECfDLdO=Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/791] 6.1.113-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 16:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 791 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.113-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

From last week's regressions reports,
The LTP syscalls fanotify22 test failed (broken).
This regression is noticed on linux.6.10.y [1], linux.6.11.y, linux.6.6.y and
the Linus mainline and next master branch.

Now this has started failing on two additional branches linux.6.1.y and
linux.5.15.y.

 ltp-syscalls
  - fanotify22

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected to patch
  b1a855f8a4fd ("ext4: don't set SB_RDONLY after filesystem errors")
    [ Upstream commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8 ]

There is a fix discussed and posted in these upstream links,
  - https://lore.kernel.org/linux-ext4/20241004221556.19222-1-jack@suse.cz/
  - https://lists.linux.it/pipermail/ltp/2024-October/040433.html

The stable-rc 6.1. (6.1.113-rc1 and 6.1.113-rc2)
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.112-792-g7e3aa874350e/testrun/25467530/suite/ltp-syscalls/test/fanotify22/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.112-792-g7e3aa874350e/testrun/25468775/suite/ltp-syscalls/test/fanotify22/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.112-792-g7e3aa874350e/testrun/25468775/suite/ltp-syscalls/test/fanotify22/details/

[1] https://lore.kernel.org/stable/CADYN=9KBXFJA1oU6KVJU66vcEej5p+6NcVYO0=SUrWW1nqJ8jQ@mail.gmail.com/

--
Linaro LKFT
https://lkft.linaro.org

