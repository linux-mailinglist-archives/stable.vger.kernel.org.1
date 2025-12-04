Return-Path: <stable+bounces-199996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA39FCA33FE
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 11:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 294753041991
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD5E2E06EA;
	Thu,  4 Dec 2025 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUoOxsNr"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAA2E5D17
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764844620; cv=none; b=UdfC5zU6GnKRsYIvLNM//jvv41mPCPOvVN+/KOAM+DuH81PDKohy5UQ91IyTNERonRygPRgiRSEC+6zeRODChrsHl/gb+V3Ma6EbEgaElTCd6OP3SFQ3MPGy6gZivUqL/cszaM3Y6maFT9s1HDK8mxxkp0kEfvlPQ4qsPbSF00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764844620; c=relaxed/simple;
	bh=lrjZPFjgyVL44DP0moQzfy6qI7PEQfOdr5dPz8u7Tv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RG9CWCM+TgqVaVkCLK1c7TnQNDyjJ7HargqhZXG9laVEU46g/7LH+MKwCJNr0Ukhp5nwW0bELyBwENzViuaP14umfa/0JBYOypY15gE+gvrvzi6cz6p+a/iDfoxaH8+ebges+8Qwi2eIdCceZepKokTSpsZPt7OWCGbEdWxMEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUoOxsNr; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5957c929a5eso950046e87.1
        for <stable@vger.kernel.org>; Thu, 04 Dec 2025 02:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764844617; x=1765449417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz/DUdZu/VR0x2tWVsO5f455WgB1CFxzk30p+t2jHuU=;
        b=EUoOxsNrv2icb+kRa3gvr70vmiQR+1ChdYMAcCKZY+NTBLVjWja4ZQhyehjEUEgpYe
         3rsZpaXIymcG8kazZQigPYTbOfY9N/7PF90RfZbStr5MjcIvCyeOAzF0ds8okKRarpVc
         lT+UgpEJB1O06T3KRcc9THZLZE0s/c+OTCXkERkWZKM9Yv+MZGRum4WumSfSYZWJVKRt
         bPQIyWeneIrGqaT4D1/q+ZStIVGmtgvgwuDhLEonAtz1tll6xHy6rt7J0OcyzvliGSWC
         Rj9DlgTSI48xBHGNnKvidHQQE9LfIAuV837B+9bN+yjeXSv/LAsIY44V/7CODuV/4Uer
         DagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764844617; x=1765449417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rz/DUdZu/VR0x2tWVsO5f455WgB1CFxzk30p+t2jHuU=;
        b=VUmNy3yA0ZdlFvcoeiDMhu5lDRdHWqhYA2P8S2rfBXWV3EkvGPAZw954w3tTWr0KkW
         4NbQVTbTXL49512qyVODKwDkax9WbEZ70WoII8MkwOt7vF804GA4pE4mCz3fqQvbKCeS
         8SjlL11b7wQwT8A+Y+b/HCcP74ukmIXr+br0xRLilKnsAI7YY6IcxycpEUN4PZg2ieF8
         VNNG5EZLXepFfewBshC38naj9bb87kpEyk+jkQSqn9uTErQ9aA+vpR67OstXqLPjG71+
         FU1NOSZdoEftaB9UQJ7qpUbzmPdfSFOADENVFFm30uwtAM7vrQXBxTxJUoyQAFGck0zS
         nB9w==
X-Gm-Message-State: AOJu0YyPDfMTnTSvYspqOM50btMwxuMB/dc+Xm6nUP931crxWi5QttRO
	HMcdWl3fG0Z01uoinfRPBBa/O1Rewsk6wnKlpA3nCjulITZAoOqGyAg4b+UyW4Dnva/jHMlbF+2
	LD/Xjjfkjhe/soTlu/oNVqFeVr/uIWRZJqM0D
X-Gm-Gg: ASbGnctm0hF+ppuyKZ7CYn1BI82UagCy9o55vkUIbWa+HDKAXM11Fb3QpNzJqu29QhI
	aaWYvFu5uG6qRJ1jLFUHrrw8OhNaVACn8idJAFWLSaCmpfLLCAHhXCmd/VnCH2NiOpk5Q3Tb06J
	Aqlhy2+6R5KvaMNIe2rAfWwQvJgBpl6c3Cl42lwfa01RD4/CaNlYBjYdyOjFqpU35tEJ6GsFh6c
	2WY9X38bC/Z+aonhe0fQbOMOk2zmCY0gbXx2vnuVHxFRQAZpBPqkKueLBapTiA6jpa4JbqbWaBr
	tsnAu0ru1xL44/UdrKyqAY62hqI=
X-Google-Smtp-Source: AGHT+IGCDplgOWSHwWEUtYZYEpDzV8McadoBxWWzIbpwjt53uVEbDGIeTBPh1m7eaEHjlgibDwuIGfHYvo7rYHhEvsU=
X-Received: by 2002:ac2:4f0e:0:b0:592:f818:9bde with SMTP id
 2adb3069b0e04-597d66828eemr855045e87.1.1764844616416; Thu, 04 Dec 2025
 02:36:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203152346.456176474@linuxfoundation.org>
In-Reply-To: <20251203152346.456176474@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 4 Dec 2025 16:06:44 +0530
X-Gm-Features: AWmQ_bnG3sVwyWhsRMRVaD9us28WTWuQXY2pjHQwmf455QkfvCZNcKk-6fGTdts
Message-ID: <CAC-m1rpCXmbMOS0AgZYq_f40om-UK2r=RCh=k-TfhGYhUtHm5g@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/146] 6.17.11-rc1 review
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

On Wed, Dec 3, 2025 at 9:44=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.11 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Dec 2025 15:23:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Build and Boot Report for 6.17.11-rc1

The kernel version 6.17.11 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.
No dmesg regressions found.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.17.11
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit :

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu.

