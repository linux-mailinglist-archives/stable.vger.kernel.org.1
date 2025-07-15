Return-Path: <stable+bounces-162992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A795B06373
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDA0A1AA5164
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7CE24A069;
	Tue, 15 Jul 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mz91Bl6W"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABDA24337B
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594617; cv=none; b=YzZ55hUNaLXxKyT5VhrTKdoST/s0A78z6A4piEQbIFx1y9ju98jSVwNHSwpWJOFg1KWQzsQ+ZRl5C+ChC6/MUXbk+dba0XT86BLb0f9MAHI9rmbdxhSaXz6nAV4esFfpPskLk4K3Zv1EvhiJGE9HZkwr9iI+lmjy8yljLCLLSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594617; c=relaxed/simple;
	bh=FHNYoF/IQm3NSjCxvVug5AzXG/Jrr3TW1MTDfbczAZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjJNGCWTP845ZsT9tq0vuToDzeBSrVCRjoNdWCD9KxwOjcCGJscyg5K05E7xyxwxSmW3GJLi+D91bil3nt6KrLeQijrkIaH3e/xfi4iFhiV9OyJskYmzfjphisjEJYwaJrRNYA61yVlBXgZZG7fvorwFHw4WVd5Ez6/gjZH0c8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mz91Bl6W; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b34ab678931so4170512a12.0
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752594615; x=1753199415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UIIjN1tqZmWeaG1/hcRkxBvRGWhZvdkRZb14oJrNFAE=;
        b=mz91Bl6WMoMQwcONIbZ+p1IpZEgp6DGFdRbAeUc/vMzt4XwKJSoz6UziObD7U0CU/P
         rAfkQJ2gkbAyGqmVZRVbelv0CY6VjlRDhRWz5BkI3xSt7oHy1bimOAj8rBB7iLGgLzBU
         fpkf6y4MSFXHm04x8xwNT+NOMPO/GTv5UKdP39MffHbMowZ9renIeSR7dfbleaMkUOe+
         URc1e2Yl9kKmhE2SxKhgAvsdTTsevaLM3by3FRj9QWEio/0uyDaPw/DI4gZ9KYZkmOwI
         dXWuu2SUnhNafHF04gRrmXLo2CP/EjnnVJfzHyJ5a4Eowm2N0ktWuHZEvDmicVeoXjac
         S5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594615; x=1753199415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIIjN1tqZmWeaG1/hcRkxBvRGWhZvdkRZb14oJrNFAE=;
        b=C27ltc+SofUcj8V4LZ7zugaQSbTHGcU5mAk5Q6rD/OJkuEZTg7PDbmdeV1dJEyW2V+
         PKfzaAe9FSYRBpJmOWk92H4Gt5dT4RcuJovS9mHKgDD3pN3PPZk48mlPdP7eLEbrxsZ7
         nD+RDLV+zYdH07hKHfDam1nvdMYy1Y1xp/4FoXpcIxDLka7tKsoKLqRodO5+IlRNo725
         ix7KMe5gLZqP0w6OAWiMX3lQixbr0dx45WTOSOd4+x/Wx8BhDeEBs6/PO9FNBVQRZz10
         m0kJ9myw28mla5YOP0HthIvtvBfk8uONkBW97sBupSxbrJp8S4Zp5HFOxHQTQCyqZoBV
         c+Jw==
X-Gm-Message-State: AOJu0YzCfD7tD+f94NP7SYH+k0VbdeDKOVgKe7If0oum1tlM7dLgW4Xc
	LJXWcY9NB9qwwpry/7r+El8IiYVDkYnK1K7keQyQe6U+JusSvfTG4AWTFsTScQl//qvsgqawTCI
	zhHy9naRjpgLGnjZgkisBgmBRA6kqkawsJhtmxslDpA==
X-Gm-Gg: ASbGncsuYTsltqvT4Etg6w86DGhN2wW/oXFWmQbKkzKqfl9C5V1W3g2vnc/tgpxdITT
	K05YH89OW1XmBvACuZX/GrxalcsZ2WcfhCjGj7hAV6sSEjKPu8fBzVnINNgNjQ/YX3Uv8A6kWSn
	EF6XgSojivOfOSfn6hykQ5xkxUHpfRLviziyEJ5HgnqDx8r+Ui6X8ybvBTc8WRt5ESi0CHz8ghn
	f2MsTMrLDcx+LVdqF17XrHjzRM6cBh9/8aUpNG+
X-Google-Smtp-Source: AGHT+IH2GHXAddytBVzHlzZlUwWfVVizUg3Mdfrc+tcbn2GstC4n4ER7+JBt8opcBUiP2rYzqVGpfM22XG6oLoXJSWs=
X-Received: by 2002:a17:90b:4c4a:b0:311:eb85:96f0 with SMTP id
 98e67ed59e1d1-31c4cda5bdbmr26421022a91.29.1752594614605; Tue, 15 Jul 2025
 08:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715130810.830580412@linuxfoundation.org>
In-Reply-To: <20250715130810.830580412@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Jul 2025 21:20:00 +0530
X-Gm-Features: Ac12FXxAa1vyHVydMmn1zKgiK1rEAJyfq1LsZRFvEdK5Vf5oHcOwb7L5DrB1big
Message-ID: <CA+G9fYugxp3W1-0Q2QNruE9r_a65M0gaE=1bgb-q+JS5GogAfg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/208] 5.10.240-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Borislav Petkov <bp@kernel.org>, Kim Phillips <kim.phillips@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 19:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.240 release.
> There are 208 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Jul 2025 13:07:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.240-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The following build regressions are noticed on the stable -rc 5.10.240-rc1
with gcc-12 and clang-20 toolchains for the arm, arm64, powerpc and s390.

First seen on the tag 5.10.240-rc1.
Good: 5.10.239
Bad:  5.10.240-rc1

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Build regression: arm arm64 powerpc s390 drivers base cpu.c undefined
reference to `cpu_show_tsa'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
drivers/clk/qcom/clk-rpmh.c: In function 'clk_rpmh_bcm_send_cmd':
include/linux/minmax.h:20:35: warning: comparison of distinct pointer
types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                                   ^~
include/linux/minmax.h:26:18: note: in expansion of macro '__typecheck'
   26 |                 (__typecheck(x, y) && __no_side_effects(x, y))
      |                  ^~~~~~~~~~~
include/linux/minmax.h:36:31: note: in expansion of macro '__safe_cmp'
   36 |         __builtin_choose_expr(__safe_cmp(x, y), \
      |                               ^~~~~~~~~~
include/linux/minmax.h:45:25: note: in expansion of macro '__careful_cmp'
   45 | #define min(x, y)       __careful_cmp(x, y, <)
      |                         ^~~~~~~~~~~~~
drivers/clk/qcom/clk-rpmh.c:273:21: note: in expansion of macro 'min'
  273 |         cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
      |                     ^~~
aarch64-linux-gnu-ld: drivers/base/cpu.o:(.data+0x178): undefined
reference to `cpu_show_tsa'
make[1]: *** [Makefile:1226: vmlinux] Error 1


## Source
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Project: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.239-209-g5baac0406819/
* Git describe: v5.10.239-209-g5baac0406819
* kernel version: 5.10.240-rc1
* Architectures: arm arm64 powerpc s390
* Toolchains: clang-20 gcc-12
* Kconfigs: defconfig

## Build
* Test details: https://qa-reports.linaro.org/api/testruns/29133328/log_file/
* Test run: https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.10.y/v5.10.239-209-g5baac0406819/build/gcc-12-defconfig/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2zuksckfjhEl6lBDDB8nn2ne019
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zuksckfjhEl6lBDDB8nn2ne019/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2zuksckfjhEl6lBDDB8nn2ne019/config

## Steps to reproduce
 * tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org

