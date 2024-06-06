Return-Path: <stable+bounces-48302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978228FE759
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9B51F25F52
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 13:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCDC196429;
	Thu,  6 Jun 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdUfp16q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54483196425;
	Thu,  6 Jun 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679608; cv=none; b=Zhs2v+sN6Dn+yYseEhdjZy7KU5HHqfglnfyOFAGb0KcLq9Ye57Lb5txq/aAJ23ZlufMGdoGOrSeJhmqp4YpVwXUa+07ser9/OXCLbVMQkK6OLPs8ugqiqSDVQ/S/yiL8nSJCWokOX2uEIZ9xxssIIEgrwwzsykOiXNLaKU8if+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679608; c=relaxed/simple;
	bh=6ua93QaCXNe8okA4DyPSNOla4FXV5pncClBL6hR5yro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaoJYJrVegNHmbFJlqVFrvk3jvE0R08Imx1hcEYkfy8gmcKsuv2Kl0SJ1z+TUFiFeB1ad4C0oo8Cgd82bltXk/O3NEMvrGUSppzGxCFVKd7LM8wcWQhip5Au9NZycyFEPMzb70PZ+silgkJBxZ8oSlGegAnDRch/SHWbz0UsBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdUfp16q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9260C3277B;
	Thu,  6 Jun 2024 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717679607;
	bh=6ua93QaCXNe8okA4DyPSNOla4FXV5pncClBL6hR5yro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TdUfp16qfwbqW4qkcZeWHPnpwnT+O2/VJN+kWPVB07GpTvFMEyqEEb9edeJ7vyq1U
	 nwv8n7oMWJ3rYZfbawnwCfE9cFYD/p0YR1Qwq7WRWShl9eCsCgH0Ro811fs3jYB6tw
	 ldtn05ZulA6wK6chZj7kDlH1T8oRNh6KX4QnU5rTDvlVZHKzxoBqNWXwZJpvSBjXN6
	 U0JCfTbR3yX5b7g/I1/M2aimD8iJ6SpgaEAxAjjjX0tuO1qH1amwv5fPKcAmPtXUWy
	 om0tzbHIyseFpdLJsNJOxsh56AigTG1VDpmj8qgSdKq05OnuTSzVJDZz5c9fSnq3pg
	 GvPSn49wPXUpw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eaa5cd9f0bso19997601fa.1;
        Thu, 06 Jun 2024 06:13:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUc/Gj11kc9nP/wVViktCY7R7yYSKAchGxXI2Xtz0Y5L2nXamDSAzSJneTxSuXvsQEimVD5ENpTazC6zcgOf41vvH9VfMsD0cGr7wnnP9I=
X-Gm-Message-State: AOJu0YybL3gYesYXdtKtldvTHSn14c4c7LfdWlr4T2bdArUtG1zCda4x
	b9Mp4OW+GFLA/FzDNgfxE90yLn2DkXzVE7QhoCA/qM+PkVjMI5HQrDhU3ECz3O64gP+EQFoEgDF
	GlAVdXCaG26+QxXvQK6mGHnyOxVg=
X-Google-Smtp-Source: AGHT+IHTopggCfukXB7nec0Y65rhkikkhcJIHG7YAcsVZ+TzONWZRruTcSz5Ej2XN+l7Gwd6rKxvEYAQv3n6NfoLYj4=
X-Received: by 2002:a2e:320c:0:b0:2d8:79d6:454d with SMTP id
 38308e7fff4ca-2ead00d5c09mr7884391fa.23.1717679606333; Thu, 06 Jun 2024
 06:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530191110.24847-1-sashal@kernel.org> <CAMj1kXH7rfoV_rsxHrwgY5++OuqTXHYdN_Zje4+HxTeQiwx1NA@mail.gmail.com>
 <2024060623-endorphin-gallstone-bf81@gregkh>
In-Reply-To: <2024060623-endorphin-gallstone-bf81@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 6 Jun 2024 15:13:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEHRDCucONDVfe65k+O5kT0zrkLtuFh49pr-UvRh=Z-2A@mail.gmail.com>
Message-ID: <CAMj1kXEHRDCucONDVfe65k+O5kT0zrkLtuFh49pr-UvRh=Z-2A@mail.gmail.com>
Subject: Re: Patch "arm64: fpsimd: Drop unneeded 'busy' flag" has been added
 to the 6.6-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 15:10, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 31, 2024 at 08:16:56AM +0200, Ard Biesheuvel wrote:
> > On Thu, 30 May 2024 at 21:11, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > This is a note to let you know that I've just added the patch titled
> > >
> > >     arm64: fpsimd: Drop unneeded 'busy' flag
> > >
> > > to the 6.6-stable tree
> >
> > Why?
>
> Because:
>
> > >     Stable-dep-of: b8995a184170 ("Revert "arm64: fpsimd: Implement lazy restore for kernel mode FPSIMD"")
>
> It's needed for the revert?
>

No it is not - the revert itself is not needed, given that the patch
being reverted does not belong in v6.6 either.

