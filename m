Return-Path: <stable+bounces-50072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D17E901E86
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 11:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C341F24CE1
	for <lists+stable@lfdr.de>; Mon, 10 Jun 2024 09:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65C175817;
	Mon, 10 Jun 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9eYEZah"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC2275811
	for <stable@vger.kernel.org>; Mon, 10 Jun 2024 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718012634; cv=none; b=ZPZnBPa+uAP0rk78lGLOORunrQhhrGg20IyRwlo/D8tP2p0dTpZgE1bU2uYMEskb2vTBu/ZZIRWUdTDft5PzhZe7M2c6F1YU2bsMvv4M2SsGPYlv6qOjJyy+Tb2VOcJdUSv11SdD79np/MlQRPLXTbBxGhbBJtAkHhsUrJOQwAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718012634; c=relaxed/simple;
	bh=bS5RlvgxIgcjRqjmYWH6qB32WZu/LwYze/3RpeQ2ypM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6kIGiD9T7hRlKKHbj2O5KUn6n24oQx3Bv4BK1wahsMz29w/Mtw4pvsKB5VJ7su3E//ZaTXjb34PVQ+TKY9So4KilHBlaBnITa7V+yXqR0ejrmUs7r/h8iUDHDHxkOX5gnD5daVUZXQM3uXOXngV+FTgKAzNRcCWyVEf8zE5i40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M9eYEZah; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4eb1233862dso1423814e0c.2
        for <stable@vger.kernel.org>; Mon, 10 Jun 2024 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718012632; x=1718617432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xjhpNNupYWVZWKcUvHP1lyKNkdexlWuohzaYbXqZdQg=;
        b=M9eYEZahAt9kIC38bmUjOYlZ/ICqNz40VuR2a0zqZ6UpaeAhxmnhPf7uYFqq3H937L
         Aaq7NtwUzWext9/ZkqG/tVMeCA1mPejVScqMpzC7p8qDOn+QzlyrHc0MoI3eVX9OFQMD
         7JNmySegS6Ujl+4rlGGdIwSQoQDpcNwdL2lBjVqZKzVsPlmHXhG2SwYIuPtq1yEMRcck
         lxnLcKQCQoUxgDFNR6rB/AJT5hzNVzPrTlnpVQS1z7zPycNzmapUi11+ANZt4Z2TWZcX
         agNQCBw+OZwWJ8CoJ6y9xReT645mM8HkGdmQC0DKtp5om/z9TzUkIjP8vF7+G7J+mPrr
         I6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718012632; x=1718617432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjhpNNupYWVZWKcUvHP1lyKNkdexlWuohzaYbXqZdQg=;
        b=gHd5mhrKEvFxekaru/PyX2x2Q+27tHNwKj65GEYF7NTJc/y5JtqTyrUSv5EMsz9dR1
         TYgmWAd46BM41SzqpV+ZV+GgpWNoICXcP685sPNDuHyiMWGR1j9cQij2niIR6i6lM2AT
         OGpyW9qiLkrVyI0NPgPv/KWLlq5Cq2xewFCzdcIeN4UI9Iumnf+5hUI60kjWD5z/sBR6
         Zto9DgdHTmttsBMLHyRBu8fqkRrjGkmjCoLGaqJunssQ0nCzrwmdv09Hy2Ojx7/KQItZ
         EbpCbM5mg/NpwzzH2dxZBKQtzUHMbXESLbEBZPFATHA2i8pirucBquu6WLmCCKzzf8i8
         6gtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeI/9w/CCzFYT9Aqu2LnWuaeHwi3xDzE9DNtksjtGqz6+OoRJh3ivq+Xw7TrjCtdWI5VDXc4VUh2z1PJiICkbLV5n7wxvI
X-Gm-Message-State: AOJu0YxPpBd9Zs1/1LJOrg6kY1J/J2HgNO3Am1wpBihR0rdSuGK6Eo/q
	sS5/88xhu9OEx9uxllPBxOk8YtLxQlRet9kvsEZEZykDVQmVYaCU6hR/E0biR0fgbctrinLbXgE
	AUI/Uo17WOMsff3E/P03ffiamlN71mBFachAZsg==
X-Google-Smtp-Source: AGHT+IGsldTxg6rRfZyz1ipYFZ2s2KO6v7Z4ILO2JX+E0oYUdd+a45WFPOs1q7SluiHdxBw4X8zaRbxU1Xtk02Z0Mks=
X-Received: by 2002:a05:6122:1799:b0:4eb:5fb9:1654 with SMTP id
 71dfb90a1353d-4eb5fb91857mr6829841e0c.8.1718012632207; Mon, 10 Jun 2024
 02:43:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609113903.732882729@linuxfoundation.org> <ZmYDquU9rsJ2HG9g@duo.ucw.cz>
In-Reply-To: <ZmYDquU9rsJ2HG9g@duo.ucw.cz>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 10 Jun 2024 15:13:40 +0530
Message-ID: <CA+G9fYvW+FmBVJO+3928H8_tBKKLQMa9bBdEKnUMd56G0f_itA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/741] 6.6.33-rc2 review
To: Pavel Machek <pavel@denx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 01:04, Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > This is the start of the stable review cycle for the 6.6.33 release.
> > There are 741 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
>
> 6.6 seems to have build problem on risc-v:
>
>   CC      kernel/locking/qrwlock.o
> 690
>   CC      lib/bug.o
> 691
>   CC      block/blk-rq-qos.o
> 692
> arch/riscv/kernel/suspend.c: In function 'suspend_save_csrs':
> 693
> arch/riscv/kernel/suspend.c:14:66: error: 'RISCV_ISA_EXT_XLINUXENVCFG' undeclared (first use in this function); did you mean 'RISCV_ISA_EXT_ZIFENCEI'?
> 694
>    14 |         if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_XLINUXENVCFG))
> 695
>       |                                                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 696
>       |                                                                  RISCV_ISA_EXT_ZIFENCEI
> 697

Thanks for the report I do see these Riscv build failures.

 - Naresh

