Return-Path: <stable+bounces-26953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59887373D
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 14:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616241F2829E
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 13:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCC112FB0F;
	Wed,  6 Mar 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7rLAIdH"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F89126F3B
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730241; cv=none; b=o3AxSvjggEj2hfxQK5aNNucBUpajcKu43z5LE/kvF7OyAi0/W0jHR2zNPFk+2bbKBUeuiOAcXH5YFcnpq0Jckp8orWwREPbC5V71RHxAXMQJnzdK3Hs6dBawxYElxqfaffRx8+8wUke8awT5zvbNIOnAUc8+DhHlEjYaN0KPA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730241; c=relaxed/simple;
	bh=0SzVCSc+6IVgdLQjBVikpTpZ5IdNQX3I6EMVPlgDMbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psE/oHcL6iGjfoY/mfNZPFi+Hrfx1/y2ufb5K2J4PhD/boLc3t6SLjhO1ju6Q6F3LtcLPKWA1CXCLMKnz6+zoP/Bq2dS2BMsESjX223/IWF5uicI9Mtw4ZfS4y3KYAdKhWLARzkQfMpwVkdwbxC359mouphjUzhKVXYgYpUEtV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7rLAIdH; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so7378704276.3
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 05:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709730239; x=1710335039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBiDejV3EtOMJmuMxDeh773rkjpBFgTE/mtHVi8J4f4=;
        b=D7rLAIdH2G5/jUCqjM1rkWiWQLQ/DgFRDS9MXjPcuiXudanm5mQJErhiDT5dmExSbV
         YujPOOJFWTrri1ZrgDugdTp6kok3Jc7fGS5TcSmbmxxfu+c1TlZS/0fbmjTGG0/NF4uE
         PGLF47GjeV8T6C8YUAwrigc6HoRj4s+Ow31mBHqkPse3AL603YBp9PsJbNZ7fpiWAZSS
         HZ9kiUiEEZhbWoxZI48MgycEXqAItAvM4T4sh/9sccibVTRGhcqVCEqhcaCVXylpHQVr
         R7/4OheYnaRSRi10ygpsaWTl4xwYL8x3FJKYpw1X5bTl4CyE2tQIhszFnZsGzNtByWZv
         dCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730239; x=1710335039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBiDejV3EtOMJmuMxDeh773rkjpBFgTE/mtHVi8J4f4=;
        b=AE/U5kOPisqjFUkdMlrl0GP8Zpe8VOIijcXRQjIfVvtK0ra4B3Dp3DmfuNV4oYlgXU
         rSfDyDQfvPmtgTa51VZu2ph1oiA2wSecQ19UI3jgHty+bM66YKR+cgPnFrAZ2LjFO1kP
         y2tpK/4h6MFVu/6MAR9o+XE6y8Fo9s6WfUkrstzFV3ufi37sUikq4jjyLkvmT0nmehBz
         l2miH9odxy61RTf9mB73CcqaRAEzOffAY/zirSfw01mcS3wfUkcQpOryMqG+1fD1Ljq4
         DgGeGWDbatekDy+2/jxarQnKG5Z3xvjBGtnTni19SXB5S5xmeM/crWvdQyiea2syZEXk
         m8/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2hVr6kVNKC7LG+uQ+f5mlG5713xDlxKOMh0V+VVO328j8gUwzl+WgTHAdJ/6+dizkNy/l+AhWKJBOrAK6/3eGqUbngGhj
X-Gm-Message-State: AOJu0Yx6DY4SXBRdwt849DkukGueAQrf+m39F4GGM2bik0DGppGQBPME
	1qcIRorrsF1OeYX9tZwhKfvKrP6/xvH76ZlroLrXwnh3zLX3XORQov6cdlxOfXRldsEJH8v7K/P
	eP/+fdcu6Qab04otHIGk/X/+Mp+SyGnJREfVZIw==
X-Google-Smtp-Source: AGHT+IGoznzaO9Xw4qNyGRElOSvHFz7f8QVovTmZFfDUeysoa5V9mZ6cAUmshhXwf2lLcYtw5uLKyTLOhjYMd2NX47k=
X-Received: by 2002:a25:290:0:b0:dcc:2da:e44e with SMTP id 138-20020a250290000000b00dcc02dae44emr10903650ybc.61.1709730238839;
 Wed, 06 Mar 2024 05:03:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org> <Zegx5PCtg6hs8zyp@trax>
In-Reply-To: <Zegx5PCtg6hs8zyp@trax>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 14:03:47 +0100
Message-ID: <CACRpkdYS-5mDjNP2zJ2J=_k_uboyVGK61Z1XWHcUh26HT6WKmQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 10:05=E2=80=AFAM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:

> That looked strange as there should be support for 4 GP but this code
> kind of convinced me of the opposite.
>
>         if (idata->rpmb) {
>                 /* Support multiple RPMB partitions */
>                 target_part =3D idata->rpmb->part_index;
>                 target_part |=3D EXT_CSD_PART_CONFIG_ACC_RPMB;
>         }
>
> So if we apply the fix that you propose, how are multiple RPMB
> partitions (ie, 4) going to be identified as RPMB? Unless there can't be
> more than 3?

Sorry for writing bad code comments.

This comment means:

"support multiple RPMB partitions [on the same Linux system]"

not:

"support multiple RPMB partitions [on the same eMMC device]"

Yours,
Linus Walleij

