Return-Path: <stable+bounces-2541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9D7F84CD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397B81C260E1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E142E84B;
	Fri, 24 Nov 2023 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAzrCabc"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A911C2
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:39:56 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45d9ceeb8b8so630351137.1
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 11:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700854795; x=1701459595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IFaoM2nPbmC77v3546G+DOzaGeOySECW/jienI0R7po=;
        b=hAzrCabcbfi1UkpCvkuH7hXVt7tjgF/PcHDFTV+d2CMEFykgm9ACSN+M6L+YMDYgJl
         MacB1tzlDNiE4bO9k6e6FNsCifZeJ3kfSQGXLP7MCQ/lnmjmlEdquCWwbIGWVZVIjzH6
         9DYjGncwAgPgiBhQjH4j/29C1o9iKs85hFeS6MgOH8LAn07kgC0Vb8JT12LoXsqAbifF
         Uc8m13VqrRQTdwB40QRl9Yl3EXJSPFwha4DuaOyyqoMY/GYUtZHlsN8tlLR1BVZb81iJ
         aAriv++MkCEZBsBMeljbKP7vBes6bGEvcN5YGsV+46zTxVsU9vCHE+DQ2j4H9DTsMP05
         WrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700854795; x=1701459595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IFaoM2nPbmC77v3546G+DOzaGeOySECW/jienI0R7po=;
        b=l31cfwSIhidsdVG6WinRbev4sEzhFwmiuJLrAG17q8fL0OnZ2XQ153K1TEYQ4Vu+uY
         krG+FxH55/pCPp1ihK9Y5hBdUd5wjy8tCvuagSTA9x1R5CTWZUF/dmIW6VwCDI7599Lh
         d9KYEUTftnXfbG4YYEVVoipz1bYIbMOpg/3wWyEX592tiHv59brE1t9Dw5R7SoXxoZfu
         C6sOjiVQpvD2QThw+ivT4S6t65nl8ZacZZJrYcTVHn8Y9FIT2K/v0OMChMA7Smol2LFe
         /Lp0sAGE3gcWmuG4Tb31gAQCjb8NC04B271HHDq7jNDH6Ff0Zly0n/C4mFH+B4ztUh/H
         Z39w==
X-Gm-Message-State: AOJu0YybYyX/knMFFwa67OefaJ2uj+GsybIu94HlfCClMDeszf+prtEV
	l/tJyHho2zpqRq+zP/gOjYgxh1WBQjZFZK07EJsT8Q==
X-Google-Smtp-Source: AGHT+IGE2G3fpION1Xr2Bdv7ckqaMoBQrZm3R4iwiuD1S/Gq234WQt/q1WgcB8s0vAQggepOJ+sFLXYnm7wW+HS0NTg=
X-Received: by 2002:a67:af01:0:b0:462:ac9d:fffb with SMTP id
 v1-20020a67af01000000b00462ac9dfffbmr4041899vsl.13.1700854795287; Fri, 24 Nov
 2023 11:39:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124171941.909624388@linuxfoundation.org>
In-Reply-To: <20231124171941.909624388@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 25 Nov 2023 01:09:43 +0530
Message-ID: <CA+G9fYuVgqVc57YAwfA8MK6_Q86wD=RznCYKHDf_tD3foM9Y5w@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/159] 5.4.262-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, 
	=?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>, dima@arista.com, 
	linux-amlogic@lists.infradead.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Nov 2023 at 00:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.262 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.262-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


As Daniel replied on 4.19 build failures,
Following build warning / errors occurred on arm and arm64 on the
stable-rc linux.5.4.y and linux-4.19.y.

tty/serial: Migrate meson_uart to use has_sysrq
[ Upstream commit dca3ac8d3bc9436eb5fd35b80cdcad762fbfa518 ]

drivers/tty/serial/meson_uart.c: In function 'meson_uart_probe':
drivers/tty/serial/meson_uart.c:728:13: error: 'struct uart_port' has
no member named 'has_sysrq'
  728 |         port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MESON_CONSOLE);
      |             ^~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

