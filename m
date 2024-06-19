Return-Path: <stable+bounces-54173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEA290ED06
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A457B25B03
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF93143C43;
	Wed, 19 Jun 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKHkGTg+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91711143C65
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718802800; cv=none; b=aDXNM9dLW5t9zPDqAHjK0pVkwo8xpHTj9QlbX5blz7sSfhC37ciMPf0XmVb8m2qbxut7yusn8+VOu69mDIkVtYvkIwmn6/SX61ynY2cy4lr4VR3o9L+QrARBlIraGkiq7D/exgFqPXK5CyKXI2S7dQv/AVHSOfM48ewMcTD9dlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718802800; c=relaxed/simple;
	bh=x87XbuUOLM4l6IIR37/SA8gOlZnCNmy14Y7uDmMb92I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tU6GZXZ/Mjbb3/ODSSzH0GL7axj/faspRzxBqsDDmaIm0cbTrkypv6aTxT4Ftd3HfP2eC6FQTzc7vADtDa5mNCOjX41CnsDT7g3PXynBZXd5w9CtnHFQS14OW9uL+ZPAkptKKoT6bjcK+8OC1/c2Ga9hyOx9Xe4foI6U4rPe6GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKHkGTg+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c036a14583so1231531a91.1
        for <stable@vger.kernel.org>; Wed, 19 Jun 2024 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718802797; x=1719407597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x87XbuUOLM4l6IIR37/SA8gOlZnCNmy14Y7uDmMb92I=;
        b=nKHkGTg+PKoPniuJkzbhrs/4nRkcqgOAp9rqeBk6KOiUfxiXV0r2cZ3MZN7VUTCaeG
         0wBTW3k9Bf9MTbEtlrrZMqA026Na5zMgLbqZ1Ds6CWHbBK1iJoirgsHnSmuSsCoXS7eI
         /Jhk0vwk2uKFa4A+t41kWcJdkf5f7cay3HP9Y/bUkwP2ScguGZglToiR0G/0wBS/CEID
         CBkbI+AQwj3sFqTEvc2PGKSH7cAunkh58dHNDY4xFi7NqTpP5lstNlrLlGGEcvD0GZq8
         hiCZRpDvxh2W39GOs2KD739eax3aCZ1H8c96iKWjTSeEEIqozqBZ4rzAkSQiyQvImSMF
         zeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718802797; x=1719407597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x87XbuUOLM4l6IIR37/SA8gOlZnCNmy14Y7uDmMb92I=;
        b=llGOJqZgqjJSmcmyUZGd9TYOGGEg/9m77f2buWcIEE6kuLLfYZhM7Rx0eRWP5pF2wr
         0zgm5BDmmmTlv12lCt7HopVCM8Z7upQx7VpEtDgIRWBxfnMDg0d+GE7c8F/67fhcXvd7
         ci3TqeRrhlwmVhVOb6CstbYH3rKZvH9ZApLM3MRn1K4dwA69jLL3mWybh02iLuQx4Olk
         HLMfJWyPl2/RGF7mKyE6DiJ42fEeOGQTUc/mKdmg1ENqclBA9E/62FyYVmBTV8CD7gzQ
         XC60JdFNuV80UvVBHchUaKMd4DLDzDgUWyQcNh3lC91DvKnMjYR2pspRBPMcUYlAUKXf
         WGEQ==
X-Gm-Message-State: AOJu0YzCyVfMA1bx9PCqn66GYRlR3blvSLtDcKhv3/V9OuNvWOg9XEP1
	3xXibGCwFVojMEnJ/giHniWJloonjVPPpGEjRBW7Ch0VUIRpJDBVIxsunq1wohFvLI7RqGeBfoH
	mmHeVZU5OrnzbceiyC+uzaTOZMNaAtA==
X-Google-Smtp-Source: AGHT+IGksV4IvadOjR4/aQV9ZKLQ5FzyWvCyoNDZ2bKR/MmOkYhp/3vMAZUXR+z2XTXwhhhBFEBtGNaXR+uYuESCodY=
X-Received: by 2002:a17:90a:ee85:b0:2c7:af56:fbdc with SMTP id
 98e67ed59e1d1-2c7b5dcd75fmr2373911a91.4.1718802797503; Wed, 19 Jun 2024
 06:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604181043.3481032-1-festevam@gmail.com>
In-Reply-To: <20240604181043.3481032-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 19 Jun 2024 10:13:06 -0300
Message-ID: <CAOMZO5C1ghUi2a-G3vn-r326_j_4S2n8LR89NFZqSoX7XUtdNA@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: enable the vf610 gpio driver
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Martin Kaiser <martin@kaiser.cx>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Jun 4, 2024 at 3:10=E2=80=AFPM Fabio Estevam <festevam@gmail.com> w=
rote:
>
> From: Martin Kaiser <martin@kaiser.cx>
>
> commit a73bda63a102a5f1feb730d4d809de098a3d1886 upstream.
>
> The vf610 gpio driver is used in i.MX8QM, DXL, ULP and i.MX93 chips.
> Enable it in arm64 defconfig.
>
> (vf610 gpio used to be enabled by default for all i.MX chips. This was
> changed recently as most i.MX chips don't need this driver.)
>
> Cc: <stable@vger.kernel.org> # 6.6.x
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
> Hi,
>
> This fixes a boot regression on imx93-evk running 6.6.32.
>
> Please apply it to the 6.6.y stable tree.

A gentle ping.

Please consider applying this one to 6.6 stable as it fixes a boot regressi=
on.

Thanks

