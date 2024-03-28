Return-Path: <stable+bounces-27144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FB487617F
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 11:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F31F23248
	for <lists+stable@lfdr.de>; Fri,  8 Mar 2024 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CE953800;
	Fri,  8 Mar 2024 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIwjXijo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEFA3BB38
	for <stable@vger.kernel.org>; Fri,  8 Mar 2024 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892384; cv=none; b=Ua166//EC1JjHXA8pGT9JPFdhlbhF4PRllM8Pmka7G1kETAYClBMm1GgiKQ+Mh5vIrFG4keCexAc9S5mmuxpVTT0Ef16m7Mj4d2GoJKzFOoFO7UnDKR+avcE7mPc1lZNP6Wzcptz8WMW4adHVInmjt3SG15xsOA1p8YWkb5Iukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892384; c=relaxed/simple;
	bh=p3WwAG3WVoEaRSFhyT6KFmCZKNv2/Ta/xpiFesEDm/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puJ51plAuRnujyFpKlqehnYk2mWmkQxqJn27scFgmNnnXj1CvM1ag1ETKV8KlGp0EVquvnLES8nJE06rUO10vB3VghlhcOE7lHhPKls1XH+Osl3eFAR8LlQQtQdATrw5BABSpOAHd5D1CPwoFLsBdsELIedXaBvN4vu1x0s4YNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aIwjXijo; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51380c106d9so769741e87.3
        for <stable@vger.kernel.org>; Fri, 08 Mar 2024 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709892381; x=1710497181; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1YWE8/ChqbavlPpjk6acCkoAkbMFNoSIIc24MbZHBbw=;
        b=aIwjXijo569S7WvwkICs8GGMPJBr1slpJbSt2XASPRNTxUuIMj/pToAessTT0dhkSn
         oYN1Qh7fiTmO2HKRzd+CQsfiwCvaMxDgRSYWoRrL8SbzQpxzU9egAu81fTu0fNHBtQln
         J7Rt9q0316+HAO8eSFCr05GZk2Qs1hn79mI3c1I3iv//9BB1wk8J2pg9EhHzXyZua9Ay
         +Xd/2CuskH5nfItq1z5S6+EYNH1Trjhvd9Pfw+pkZ2gHVAKwIzBSWpXMvBAoSyRq2CHs
         hBG2LDM+TrGlXhBS4yaUG/u4a6SsxK0TTkAu4TcgYhcA8TOg0kCHBPIYwR5+x/kogxII
         v80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892381; x=1710497181;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YWE8/ChqbavlPpjk6acCkoAkbMFNoSIIc24MbZHBbw=;
        b=qK0PKvPU4Bdpn0nbhOgKLU2S7MPtHzvKQTq+GDP89c4G3j7/dpsHS6gWna+li6RWDv
         JX9pH5X/ODG0MJ75pavb2xxBVW0b9Q6pxD84+y4b1HvLP1ClQxVF3SruZglVqHKcVAkD
         KKic0/XYH8xDboiCcBjk1+/wGf97ghZHPRpJa67wcfWs67MDL69xGJ5bVyaNG75cDXSO
         wMhNtdc8LQUYEpa8vbvCUqm9s0BiKQAGUx/x/YR7X0LOJDLVpBlxVvUIwpOtXavBEEph
         Fo575OO7qU46d9tSX5NNnuEzGVvOxzFMyluezpJr/4hf56ciOOc6UqfTD8+U9Yijn38K
         6DUA==
X-Forwarded-Encrypted: i=1; AJvYcCV/1PlhWjDZ/eOouAk2CzHfsb6b6lvfjgc6vhlIzASGaYL0thYcGbwAOgOju6NrC+t7QztGYJ9sSR5TJ/GzaZgJxFnIi7fw
X-Gm-Message-State: AOJu0YwXxcMUEdPf5NRlXOucr0Je2SNaG1z0lsqETwCnA7LpO3FKhU6K
	GF9IqUMMImUhFyiAYSa2raJihkHPMOY20h8K81dA6Gbh2ByGNzdgB8Blzw4NPyeQ8ujfvCX+O4G
	OcqUYIox/mPYdozZWcD57KueFENP9y69pdQgcjQ==
X-Google-Smtp-Source: AGHT+IECDY4AAtrYeVWioHkwpNMOTKZI5B7RvnRtpjCcZQVpAYyJuAGnh6RAEd9S2D5ezQu0x+dxrvuo6rekvMG4264=
X-Received: by 2002:a2e:960c:0:b0:2d2:869a:55af with SMTP id
 v12-20020a2e960c000000b002d2869a55afmr3268538ljh.17.1709892381111; Fri, 08
 Mar 2024 02:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308085754.476197-7-ardb+git@google.com> <20240308085754.476197-8-ardb+git@google.com>
 <CAC_iWjJgV+wrgKUQsVYvCdvE5Qer2B-ieJC894b+wjKVhdDH8Q@mail.gmail.com> <CAMj1kXFab6MqG+BZ64OSdfzcb-88-N0cwMGZ_bn3vC6NOhgCFw@mail.gmail.com>
In-Reply-To: <CAMj1kXFab6MqG+BZ64OSdfzcb-88-N0cwMGZ_bn3vC6NOhgCFw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 8 Mar 2024 12:05:44 +0200
Message-ID: <CAC_iWjL3yHt16vrwCh8V3FWqLRHJ07wt-pL2scB+2B8Y2AHgvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] efi/libstub: Use correct event size when measuring
 data into the TPM
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-efi@vger.kernel.org, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Mar 2024 at 11:43, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Fri, 8 Mar 2024 at 10:38, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Ard
> >
> > On Fri, 8 Mar 2024 at 10:58, Ard Biesheuvel <ardb+git@google.com> wrote:
> > >
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > Our efi_tcg2_tagged_event is not defined in the EFI spec, but it is not
> > > a local invention either: it was taken from the TCG PC Client spec,
> > > where it is called TCG_PCClientTaggedEvent.
> > >
> > > This spec also contains some guidance on how to populate it, which
> > > is not being followed closely at the moment; the event size should cover
> > > the TCG_PCClientTaggedEvent and its payload only, but it currently
> > > covers the preceding efi_tcg2_event too, and this may result in trailing
> > > garbage being measured into the TPM.
> >
> > I think there's a confusion here and the current code we have is correct.
> > The EFI TCG spec [0] says that the tdEFI_TCG2_EVENT size is:
> > "Total size of the event including the Size component, the header and the
> > Event data." which obviously contradicts the definition of the tagged
> > event in the PC client spec.
> > But given the fact that TCG_PCClientTaggedEvent has its own size field
> > I think we should use what we already have.
> >
> >
> > [0] https://trustedcomputinggroup.org/wp-content/uploads/EFI-Protocol-Specification-rev13-160330final.pdf
> > page 33
> >
>
> Fair enough.
>
> It is rather disappointing that the TCG2 specs contradict each other,

Indeed

> but a quick inspection of the EDK2 implementation shows that it
> follows your interpretation.
>
> For example, in Tcg2HashLogExtendEvent()
> [SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.c], we have a check
>
> if (Event->Size < Event->Header.HeaderSize + sizeof (UINT32)) {
>   return EFI_INVALID_PARAMETER;
> }
>
> which ensures that the event size covers at least the EFI_TCG2_EVENT,
> which obviously implies that 'size' is expected to include it.
>

FWIW the same principle applies in the u-boot implementation as well.
As far as this series is concerned, keeping the
TCG_PCClientTaggedEvent will make reading the code & spec in parallel
easier, but I don't have any strong opinions -- I am fine with both

Cheers
/Ilias

> So please disregard this series

