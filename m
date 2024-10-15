Return-Path: <stable+bounces-85120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F5F99E4D2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49F42824D9
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BE11EABD6;
	Tue, 15 Oct 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmQQoh4Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FDC1EBA14;
	Tue, 15 Oct 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989831; cv=none; b=iqRZtB+qTp69CpDRR5Cf7FiyUNCQJy8hMifBE6quIrCeXOT7v2wBtPSP4oxSCFLZXV19k70/3k57OvFRvvheT1Qla+Lw8T4LGG9WJEw6AOPQ6Jbra46nXtV8SXVWXgmYPAB8sWuZY7Q1TYqqK7C8uptYv7HbpVabkQH/ExDVl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989831; c=relaxed/simple;
	bh=mBWDy+/1LsU2mdwv1xP65UODLZMmvWYLMSfi4wfkJQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQIppIEBuYWxkmUxSiNkmRZOskftZ3XaobF0NA1IFs6cLTXh5tub8RkjwQJ0hc++9klHsjbtlfx1sGZnqHJC1oIHjoi18ITLxJFIacvtzo3aBortudMV+goQ0eTNCWNEXBmjvltK60+lbFcgvejnauGl/v1WGNw5HdRSMwn/BYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmQQoh4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8487CC4CEC6;
	Tue, 15 Oct 2024 10:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728989830;
	bh=mBWDy+/1LsU2mdwv1xP65UODLZMmvWYLMSfi4wfkJQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kmQQoh4YxBvbkgspgx/X973q8Bmnwb/dxh0QPJgtrtv4OL6LV1HiiqItFg8p8vNuU
	 WDckni2cX6kck54UNdTc5ptOBGtVzPy2j7x7uNmUwNAgCbgn6zep12SgPqOFLHiqgu
	 FVChmW1hYmKKgfLfdVBLApUp+1i130fdXK47Q93WZ5qfLuOq6v95Aw84pl4a5O/HKk
	 VigB64Fhopnb9x8lHMVIcBCID+vI8d52T6NNs7rCT+qfxoJ28Yztr5cnzkGkvNUPz4
	 dXloIa6rMCxrsRFz8Ue4JQHcQNoGK49JtdtRTN6T8mk408GISGsT9f9ON9idQiMeub
	 tVQcnVTOD+IKA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539fe76e802so826427e87.1;
        Tue, 15 Oct 2024 03:57:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBLs/XcXNxgdNHJi/6wd6yKFNCVtxJnONKAyony5DKwrdMoz8/32enXCBnCVRLdrE044oqKwPH@vger.kernel.org, AJvYcCVyH6AsXyhdPi9iFny2EhDCFn/Bsrho7Mf8LU/51q/lZdxTqB9iUpw3x42xlH9+e3zJ4hbLWQ8fqF+s/MHaE2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXSDnIImQSA15KnduRbZZFVC2kMZr3kBHhsYQx+hm/BE9QTe0x
	y3rNZNAPmDPNH4CFPoVxntlPk7oU4Y23Va1tP3lcdGbM4YpOjyfeXvuvDSssF8eTmGLogRHtrIN
	713SzoLrTf5hpolxm/x/5MohkdAo=
X-Google-Smtp-Source: AGHT+IHDatbRRWflHG79t76g/ZmQOloSnfcbXHBgCIHWzrSGdpAhWGwB4xFU17eSKij3R1NnXzvhVTbId4qaUTC+x1c=
X-Received: by 2002:a05:6512:2398:b0:52c:9468:c991 with SMTP id
 2adb3069b0e04-539e54e72a2mr5276430e87.14.1728989828934; Tue, 15 Oct 2024
 03:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009124352.3105119-2-ardb+git@google.com> <202410141357.3B2A71A340@keescook>
In-Reply-To: <202410141357.3B2A71A340@keescook>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 15 Oct 2024 12:56:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF7aFyBOOxQQsvsAsnvo3FYrkU=KA1BiMeSuKq1KHC1qA@mail.gmail.com>
Message-ID: <CAMj1kXF7aFyBOOxQQsvsAsnvo3FYrkU=KA1BiMeSuKq1KHC1qA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/stackprotector: Work around strict Clang TLS
 symbol requirements
To: Kees Cook <kees@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, x86@kernel.org, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, stable@vger.kernel.org, 
	Fangrui Song <i@maskray.me>, Brian Gerst <brgerst@gmail.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 22:59, Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 09, 2024 at 02:43:53PM +0200, Ard Biesheuvel wrote:
> > However, if a non-TLS definition of the symbol in question is visible in
> > the same compilation unit (which amounts to the whole of vmlinux if LTO
> > is enabled), it will drop the per-CPU prefix and emit a load from a
> > bogus address.
>
> I take this to mean that x86 32-bit kernels built with the stack
> protector and using Clang LTO will crash very quickly?
>

Yeah. The linked issue is not quite clear, but it does suggest things
are pretty broken in that case.

