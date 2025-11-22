Return-Path: <stable+bounces-196578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FEDC7C6BC
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 05:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 403A54E3E64
	for <lists+stable@lfdr.de>; Sat, 22 Nov 2025 04:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA068248C;
	Sat, 22 Nov 2025 04:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYdWUMia"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68136D4F6
	for <stable@vger.kernel.org>; Sat, 22 Nov 2025 04:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786783; cv=none; b=uA4Hyuca6fwfFGbkWrzOAkVGmHpZgepwadqeTHGlNbNRyjdtlz0AmHBdTcM4CTmPP/QYCXYZydjkEGU2GqsHi1aiHHOksJ5FqisSXTtjvhy/tQV0ygl/rqagnaxYZJBe3vnxFl8a0tfq6kVA3iKP+ebhzcsPOv1dqclEZElNock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786783; c=relaxed/simple;
	bh=fNOZXHfJRCZg56SrQDUBpc1032dLG/xeP8MlTEGiRG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJOPzPheFNohJZMXb9waNPAkafjik7ebIfRkei/lxig8PP9VVFgRf6sbmiFLpKfdPVqYgWWOYN5New0yLWftModw19+TB9qul0qUhXA2dtix2xqUq9uzmEoy8orDzxTGYwOWAiIDVsS/HbhO1cNybAWiSoxIee5LUejUO4+952A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gYdWUMia; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b553412a19bso2441551a12.1
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 20:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763786781; x=1764391581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jFD4F63S1jKHIhSd+FauKFk8n/SSK6ModuLxc9Mx/wI=;
        b=gYdWUMiadjQOfEHCwzSnZmxZnQVA1QOIf720+a8Xm3R8fRFGWG1J1Fds/U25diLdlp
         4I7hexKpGFxNABZMnjwOPvR+9fspHhtuW2o6NYrFKi5ct1/F0oFzFDG86Sk4HTObGGOb
         8T8suVfYblNzwn2HwyFMQAXeRZMXe14cj8tT4fdTl9zcj4Hw6ocCZ1L9PmtdJ8tw+cna
         OfOmUhZ/aCl6V1D/sVjyMkHSl8nr0eWXDegO+SoeoqmvuV+Rg10lqT/RtZIMXkT+32GW
         SEcrzivtO+rwV2Hkw855jcxyKKAAJycD91PJ8phYh7db/OP1IWaFWtL5/r+jFZeaA9IB
         QNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763786781; x=1764391581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFD4F63S1jKHIhSd+FauKFk8n/SSK6ModuLxc9Mx/wI=;
        b=j3w+wBoDKHv744ouanIg1SWg0PLZQqpuNI36PlTtVnFhpWZvm2PUWdy2gPgJm+K669
         oUD6+Zjnpgd3vpWg+/DegzHFcX5LlzEJ+z+S/R5AVE5a311zJHMwbh6WDE3mODjvJC/T
         323ciId7B/pAfmvFPHuSijmWeoQXsO2+5nYkrZzQ1EJxmwr2prtw1tTCr4v9YhEpyU7f
         haqO5LXiRGQWknSAHdI0OkkbfEpoLX9uMtrwi+V0wOXcloOx8PDjd/hY61iKiZyTLtla
         /zufk/AQAPFEioMjSQgHe/jHpRlND+iFH5FQ7aZBkFAfHu6Od8UdDc8s64t/iNp6BSd5
         dQ5Q==
X-Gm-Message-State: AOJu0YzYc27N/QJ3yeJJfx8DvAN3YNeZ0R5AXHBbgeGWSoBk2qMi62uW
	IuNp4NpALcQblrlPcasCN75v3Vd5XmI9zy6v10vwKNsc9b9KjwhfJn6M/A7X8aI61U2BC5MnMLN
	iD0WDiuGNfrBlu2BvnkVqOzqVH05K01O9o8xmoge7wg==
X-Gm-Gg: ASbGncuycA5gfO3xZnp2oyehaLSk5o1lMV/XuC2PZa5jouTG4/Y0HgCXed1W8P/AcxL
	Eg7mZ18imdmT61VaGu/q5E/Dd05rwUvMwWkQD/SzUwluT/nHNPTLKeFbIzxydO3LAqT9Trw8TCz
	UKLLJ1fPtgnHKGsbZcCxIZhWeJjzhbNH64jUpguDhf19MKYC29jjAeyEgF70MvRI4sr7o5vIbtr
	zWY08ZLC8S6XxZSTSya0hM7klyL6ygNE+E05s/K9GZTUh/PpfAxbYJDqk6xmIHmndXLOCocKtRH
	qxKDlEn6BDAyjukWQcSEK5ZKH5oX
X-Google-Smtp-Source: AGHT+IF7Ky6fXLLPTBbyKFdOUnaF5L5Jmh6zpXpleeR/UXJjpMyZWNLPmIdueA/UUorx2LfkZ2wN6SM8GdJbO61H920=
X-Received: by 2002:a05:7301:d189:b0:2a4:3593:6468 with SMTP id
 5a478bee46e88-2a719296c49mr1718921eec.24.1763786780767; Fri, 21 Nov 2025
 20:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121130143.857798067@linuxfoundation.org>
In-Reply-To: <20251121130143.857798067@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 22 Nov 2025 10:16:09 +0530
X-Gm-Features: AWmQ_bkopVWMkJW5a1VrVVai9150DadJbk_p7WPf2ggQRUZW-tDWIpMe9O62a0s
Message-ID: <CA+G9fYvyiLxwGFN-3QuK4PR2nAmFSp8whe6yfTMXB+FoKHhjrw@mail.gmail.com>
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

On Fri, 21 Nov 2025 at 18:56, Greg Kroah-Hartman
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
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.59-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The LTP syscalls listmount04 failures noticed across the 6.18.0-rc6,
Linux next-20251120, stable-rc 6.17.9-rc1, 6.17.9-rc2 and 6.12.59-rc1.

First seen on 6.12.59-rc1
Good: v6.12.56
Bad: 6.12.59-rc1

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: listmount04.c:128: TFAIL: invalid mnt_id_req.spare
expected EINVAL: EBADF (9)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log,
<8>[  467.451816] <LAVA_SIGNAL_STARTTC listmount04>
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:2021: TINFO: LTP version: 20250930
tst_test.c:2024: TINFO: Tested kernel: 6.17.9-rc1 #1 SMP PREEMPT
@1763732790 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
listmount04.c:128: TPASS: request points to unaccessible memory : EFAULT (14)
listmount04.c:128: TPASS: mnt_ids points to unaccessible memory : EFAULT (14)
listmount04.c:128: TPASS: invalid flags : EINVAL (22)
listmount04.c:128: TPASS: insufficient mnt_id_req.size : EINVAL (22)
listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)
listmount04.c:128: TPASS: invalid mnt_id_req.param : EINVAL (22)
listmount04.c:128: TPASS: invalid mnt_id_req.mnt_id : EINVAL (22)
listmount04.c:128: TPASS: non-existant mnt_id : ENOENT (2)

Summary:
passed   7
failed   1
broken   0
skipped  0
warnings 0

## Build
* kernel: 6.12.59-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 92f6b4140c17182e28e19312fce7c6ee90cd3077
* git describe: v6.12.56-790-g92f6b4140c17
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.56-790-g92f6b4140c17


## Test
* Test details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.56-790-g92f6b4140c17/ltp-syscalls/listmount04/
* Test log: https://lkft.validation.linaro.org/scheduler/job/8532397#L26259
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/35n4IGltUEJH9dNtMu47XsPdqo4
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/35n4GHe84Of9RjprzsxRkq6NEho/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/35n4GHe84Of9RjprzsxRkq6NEho/config

--
Linaro LKFT
https://lkft.linaro.org

