Return-Path: <stable+bounces-111963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED3A24E2A
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 14:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D5B1886105
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0101D5AC6;
	Sun,  2 Feb 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRzl/92c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81253111AD;
	Sun,  2 Feb 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738502238; cv=none; b=AOiIua3ErM8dOiGAHRvo7NpVloDVlQIL/parfUQaubIVs23I6FZXW48stlaZCXN6heFAvhBR80pXLMR3LOfX+LcR9IcdBfsvDRlj3xfNFr6hemDd6J1vitBO8tir85K7PqXytxFRgpVlGru+LrO13YpciJU1ipepjuiCBqrx/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738502238; c=relaxed/simple;
	bh=8UrPfxMtDnWsMHLUMKQKXz0vYo+9DheouFS1PPIHyzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dewKPwCl+QrdU66SY6zWDE/hzor1MwOOCi/PALChr6bCGgpkD2RLH1fpQtk0ZfYvRBqczP+meA/jh6ZV0h7KZb5ppz7idVWzqywtcO/bSepTprql3g2d1Uzj5Q0tLpeR6SpUiVrZ8gnM5zR3T1a4JR0tSfzI1nltFhbJ990kBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRzl/92c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC167C4CEE0;
	Sun,  2 Feb 2025 13:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738502237;
	bh=8UrPfxMtDnWsMHLUMKQKXz0vYo+9DheouFS1PPIHyzo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lRzl/92cnA0AlY/Z2lnNY2oqHRgq3+UFWTMvMHSG92DE63CzHBTu7tsbIYtE3dhXh
	 t2AqyldlqgZbSXRXbukW6v0Pf5Txi+iuzg5tF1TeVkdU1aAJragMEC8KCe7cpbw5ZH
	 BIoIgcr6CbIXs9Exjeaok1p9Pn8ylLFWPV8O5dPThlAQtL+Xw1T2SFSqDFx8WT7zBy
	 9ooD3YiGt6gljha2No85hFfbwwgpoxDGJ9YxX3nOR4cM7Qx2dNfqosKzS3fSA2l2gy
	 ZGTwsNvqfMiiKlfIBxvygu9Xss3wb5BG6a6SUBN7xu8VvteinOMNXjP2RbAy6ex62N
	 v2zjmI7jCr4AA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5db689a87cbso6816096a12.3;
        Sun, 02 Feb 2025 05:17:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqFUttChvl2c2qppibYvLlu1GRjbCbPxSF+5dXf2tIOT/RKqvbXNan8ZCtJAr5+JYcw8vnxE4RIMX24JE=@vger.kernel.org, AJvYcCW53oK0Y2kZoYLTRR9rQTn8MLLb3kTWQ0PhqxRhQCxSrl0x24dvJqordvugVUaMxd0qrZ48UPI3rCDM@vger.kernel.org, AJvYcCXnQQjzEfsl9U1B09V7I/iIfR3beu/MhkzEeQEODK8jTACVRsFYqAS159Ch1DtoFP/L0/+18TL8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6/9NY4CUVdGTFEjG8HCWznQ86ntXbi7Zc9pLvqqzgfmbJh9m7
	PtBqCs/kjTkJRTUdYppnRsSMrTeNlYOuIT0NPRhfRov4vNPyfaCWc2Z5qNDW7NfqGne5GRvjI/F
	c+rmQ4GaRh8dorSm8bKXsA+adumY=
X-Google-Smtp-Source: AGHT+IEcCHQwc64WJozEkaMXmEDy2HFBAH6BbK3SCy6igyHLf2o/aw68ipkYDN+2M3aYu4oGA2xTuiQk1rKkhbNdBRs=
X-Received: by 2002:a05:6402:50ce:b0:5d1:1f2:1143 with SMTP id
 4fb4d7f45d1cf-5dc5efc70ebmr21454482a12.18.1738502236473; Sun, 02 Feb 2025
 05:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202124935.480500-1-chenhuacai@loongson.cn> <0d647c3f-703f-47ac-9c13-3f78a3bee0f6@assembler.cz>
In-Reply-To: <0d647c3f-703f-47ac-9c13-3f78a3bee0f6@assembler.cz>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 2 Feb 2025 21:17:07 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6eT=8XEoo4Bb3iF6RqOq0BFutW5nXYn7_9gd8ZsLytnA@mail.gmail.com>
X-Gm-Features: AWEUYZkmZZjTcXjZ2Sh-8IEQVBRM14skuQz_970BTrKD1A6g6z1vbwnkdKOlF-c
Message-ID: <CAAhV-H6eT=8XEoo4Bb3iF6RqOq0BFutW5nXYn7_9gd8ZsLytnA@mail.gmail.com>
Subject: Re: [PATCH V2] USB: pci-quirks: Fix HCCPARAMS register error for LS7A EHCI
To: ruik <r.marek@assembler.cz>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Baoqi Zhang <zhangbaoqi@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 9:12=E2=80=AFPM ruik <r.marek@assembler.cz> wrote:
>
> Hi,
>
> Dne 02. 02. 25 v 13:49 Huacai Chen napsal(a):
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_LOONGSON && pdev->device =
=3D=3D 0x7a14)
> > +             hcc_params &=3D ~(0xffL << 8);
> > +
>
> If it would be fixed in the future, would it make sense to check for revi=
sion ID as well?
Next revision still has no extended capability, and the register reads
as 0x0, so the result is the same. New revisions after the next
revision are no plan now.

Huacai

>
> Thanks,
> Rudolf
>

