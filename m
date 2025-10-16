Return-Path: <stable+bounces-186168-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A6BE3EA5
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D92A3BB88D
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9D033A005;
	Thu, 16 Oct 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jermhdt4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBDE33A024
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625033; cv=none; b=AgGLYWZsFu3Wjp5hCOA7pfdYvB0RyyCo2SLcRDhlIrR7Swnbn8PVjcgfCDwjj0VvzBn4ZjLtomCWS4BFcvP0A0YxIHV/E8Z3bNtA+DLMsxmv0KglwyfksJshSycoRwVNCTO2Vnz2Mfv2YDOE5iQOQjJhPS8dD/5eQ5eM8u6134w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625033; c=relaxed/simple;
	bh=SDVCyoS+iTR8CIGKP4i10KLznYjEnv85LB0Z92Bv0dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D5tqrxW12OgCCRkvXaRcYCtmrWlMJhqF1TcUzQ4YlerVbqnALUyMg+vdSG9da4gG7hZHOph+r8eSx623vLCFGnUqFMMI12qhHhE3tuEEcFmSSds/WXzkRQORkDWMRVbvPu3n344h0+aINlAfH6kVSgm74xbHMg2+XT+x9EnWPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jermhdt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C514C4AF0C
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760625033;
	bh=SDVCyoS+iTR8CIGKP4i10KLznYjEnv85LB0Z92Bv0dc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Jermhdt40ckFJwzTKBXSHgzjU3WmBTiWjVcZ+5/4RRGsZ2JmAcPd91Hum+wAkIhVf
	 CEQQxnQOuH7c259kr4206UVX6TUogcEP8Tmf5Uc4eLc2EpnG7zhFwKcvNRZWdzCCDW
	 Qjf9Q3r6CceVW0rzltNLIFBF0ZDO4LqqVXJz0udQOQm5zzAQ/A2H+WyVD1z1e2Ux3G
	 mnU5L/h9MFLWBcKChWkpt8mFR++XFDux6fxUW282NQhJHzlEKphLgGKXx74nTRD62+
	 8lvz2xbtvZC5RBsrASRDfc6lCzpRsQrdw2RRHDrVIf0t+58sEzWG80/vwYFCFzRXEg
	 IUAuplj/CO90Q==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b457d93c155so113524766b.1
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 07:30:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx9SLeucan/+5qUqj7moB/asZ5RaFwf2lAb7uF0SvD+Ctw9Ra1M
	/0AxmqRf58Mna0EMQRKNAa7hFs+pPhuUXdnZ1gBYD8JIU9D3cNFFs57OT5LTB1FEtSgCChZW2i+
	Da3kj2Fs9K6TkYoTo6KKIRDmdpGet7dQ=
X-Google-Smtp-Source: AGHT+IEju+8+BHCr9mV+PTdt9dw+1aCkbxLPcVbyiS6k/BWwB4+iHGZRuxMOalZtbMzhw7GW7Q3sdpvS64LE+wDETK4=
X-Received: by 2002:a17:907:2d93:b0:b41:27ca:6701 with SMTP id
 a640c23a62f3a-b6472a6a12amr17046766b.24.1760625031620; Thu, 16 Oct 2025
 07:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015114243.1341568-1-sashal@kernel.org>
In-Reply-To: <20251015114243.1341568-1-sashal@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 16 Oct 2025 22:30:20 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5ph0b3pf2PQV3hw83vPxKO-9Vba=XUCFRON1BUh7Y4oQ@mail.gmail.com>
X-Gm-Features: AS18NWCtAYrGizI8jr3lp-JdbRHC2jbfTCXTvAct8CCRO0IGxJH-7CbZfdqsnD0
Message-ID: <CAAhV-H5ph0b3pf2PQV3hw83vPxKO-9Vba=XUCFRON1BUh7Y4oQ@mail.gmail.com>
Subject: Re: Patch "LoongArch: Init acpi_gbl_use_global_lock to false" has
 been added to the 6.12-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Sasha,

On Wed, Oct 15, 2025 at 7:42=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> This is a note to let you know that I've just added the patch titled
>
>     LoongArch: Init acpi_gbl_use_global_lock to false
>
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      loongarch-init-acpi_gbl_use_global_lock-to-false.patch
> and it can be found in the queue-6.12 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
Please also backport feb8ae81b2378b75a99c81d3156 ("ACPICA: Allow to
skip Global Lock initialization") as a dependency for all stable
branches.


Huacai

>
>
> commit abbcba805d220623909699cbeb81b739d3dd5a06
> Author: Huacai Chen <chenhuacai@kernel.org>
> Date:   Thu Oct 2 22:38:57 2025 +0800
>
>     LoongArch: Init acpi_gbl_use_global_lock to false
>
>     [ Upstream commit 98662be7ef20d2b88b598f72e7ce9b6ac26a40f9 ]
>
>     Init acpi_gbl_use_global_lock to false, in order to void error messag=
es
>     during boot phase:
>
>      ACPI Error: Could not enable GlobalLock event (20240827/evxfevnt-182=
)
>      ACPI Error: No response from Global Lock hardware, disabling lock (2=
0240827/evglock-59)
>
>     Fixes: 628c3bb40e9a8cefc0a6 ("LoongArch: Add boot and setup routines"=
)
>     Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 1fa6a604734ef..2ceb198ae8c80 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -354,6 +354,7 @@ void __init platform_init(void)
>
>  #ifdef CONFIG_ACPI
>         acpi_table_upgrade();
> +       acpi_gbl_use_global_lock =3D false;
>         acpi_gbl_use_default_register_widths =3D false;
>         acpi_boot_table_init();
>  #endif

