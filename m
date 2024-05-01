Return-Path: <stable+bounces-42885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4088B8BD5
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE241C211EA
	for <lists+stable@lfdr.de>; Wed,  1 May 2024 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE5412F375;
	Wed,  1 May 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp+scjXb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC812E1D5
	for <stable@vger.kernel.org>; Wed,  1 May 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573572; cv=none; b=OuQYS34H8+AcOHapi8CNeC4fDLTa4nSKoH7i9t/+AyCVtxcd20a/s1Ceusp34hMZxXx+F49Dt+8+DRZt103JS/usPNOG77VLRPz+aTi7Rm/7jwCxoi4D0TZwVIyxnBnBKEfNU0Xl9AbsyK5fEMLiJE/FEF5M7/NwqlNdkVYlre0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573572; c=relaxed/simple;
	bh=IzZxlvH5A6Ld0u3O9rcBqF58sOu5nVuUiSmU0xInPu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXmUsk3Twjr9IzNfRWPqdBE0DnocZJLP/i/ddaUZtUqH+SSU6fke0hyo8di+3gn3hjPlDouq8qGfYil0whmxXMsNWODp8xTrV1WuqSmcDDlbbrUDhyEXWN5H+WRa6y4DnnKQ8zGiSAzrJdUjxjV1piGqb0TPnUnSa6yJEjab7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp+scjXb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3926271a12.2
        for <stable@vger.kernel.org>; Wed, 01 May 2024 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714573570; x=1715178370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzZxlvH5A6Ld0u3O9rcBqF58sOu5nVuUiSmU0xInPu0=;
        b=Xp+scjXbtWXzbUi5YAM3e/PJ0ApL8denImJO/f86EXLIIV50FyuD10l0UkGzpbDa7F
         twN9V9x+Q36DFekQ32AvpyD5E/7Udu5tkFMD9CXaYoyHBokOE6FoMdPO0yCac1ygUFjB
         +FYXD8QweDFQk3WtrIuVGv8q3wWKIjKLex9dS42ETF4PRL35hveVOzC6JarU46l80P6O
         /WAkQeTnIiM6jNR371odB2GnOTPGWNC6FCRUfaihbDcTIhYMVN24gNqTiDv+xxq6Stfe
         RAYf+iec5E+pC8kfSnS+2q9yYFatk20rpCFM+6ndcT5+E9Ao2xcxptpkkgKYgOVCIulg
         IhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714573570; x=1715178370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzZxlvH5A6Ld0u3O9rcBqF58sOu5nVuUiSmU0xInPu0=;
        b=Lfnln2sO8AaXKPE1ZonyheycGHf1U7WEphRoRm6zECzWkjQRMNrRkm7gFI7JAPEv4Q
         V9Osd2KvtS7rkGnBmt2+8WhVGCDVBgJ8vSFJYJcPQ0Ewae19rcl0QO17YAy9ygFdTeO/
         yTempLt6SgRQ9Uqh5KsFGjnovAfxPb6/lzVCXeH+DeEOwWdpUC4M01WMcdIub7RySCEW
         EXzwUnQ3suOGlF3kLGT0fVpcjaBEeD1rFOXddsrCIhRq/fO4lv9LpyJIuQPK2sbDot+3
         zvEkexz62V3ev2zpOd1BTJazldblvdHt46FhneM6w32AGYgL/kTKnsEpH9ufY0DEK6F+
         xi/A==
X-Forwarded-Encrypted: i=1; AJvYcCUcHlkZ7pMi+hbMezDJ+n9c8AxbsjbpQ7VIYCRDipn6EQEMVwyvF02iT1+ZEPAIWK7lR7S9GTQzp3zN8Kx2VvqBMlAR0PWr
X-Gm-Message-State: AOJu0Yw7DwbCWhLNH/PcB6SS/UUWnnqGkHCpuMUQS+OspZR9uutN4yDB
	Stv8bguWx6irBOXqz/q+LszAoelGy9NtTX1fPtrZvNh1nMXJhqzLTQDJAkYoZPwJJo3MKvI8gXV
	ZE1Mf9jGYc42dQ8Vb34snF90ic9JTEg==
X-Google-Smtp-Source: AGHT+IFmqKNThiASiJSJyf6Ed/Z7SqWVCGc3tt4iXxMXhMcpCoUfK8r9QjN113WFQZBhOTRffC3h4wYBTXxc+H4I160=
X-Received: by 2002:a17:90b:3a89:b0:2ab:9819:64bc with SMTP id
 om9-20020a17090b3a8900b002ab981964bcmr2284354pjb.32.1714573570083; Wed, 01
 May 2024 07:26:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024042939-ended-heavily-2e5c@gregkh>
In-Reply-To: <2024042939-ended-heavily-2e5c@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 May 2024 16:24:51 +0200
Message-ID: <CANiq72nKnAkgg8iGb3k0km6-kj-ux+161VaQHZYHPmOGFQQw3Q@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] rust: macros: fix soundness issue in
 `module!` macro" failed to apply to 6.6-stable tree
To: gregkh@linuxfoundation.org
Cc: benno.lossin@proton.me, bjorn3_gh@protonmail.com, ojeda@kernel.org, 
	walmeida@microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 1:21=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
> Possible dependencies:
>
> 7044dcff8301 ("rust: macros: fix soundness issue in `module!` macro")
> 1b6170ff7a20 ("rust: module: place generated init_module() function in .i=
nit.text")

For 6.6, this can be indeed resolved by applying the two dependencies above=
:

git cherry-pick 1b6170ff7a203a5e8354f19b7839fe8b897a9c0d
git cherry-pick 7044dcff8301b29269016ebd17df27c4736140d2

Thanks!

Cheers,
Miguel

