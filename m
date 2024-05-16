Return-Path: <stable+bounces-45329-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B2F8C7C91
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 20:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E87E1F218D7
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 18:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4318156F28;
	Thu, 16 May 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JeXGh+LG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9F3156997
	for <stable@vger.kernel.org>; Thu, 16 May 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885107; cv=none; b=PPtnx9eTBf8WlHk+sILFUk73RQgU5M59uJwrlfnSQPZvJDDVG2Y5+9E0acQOeqahXeU8XWm2rvdb9dmLXT1v9VIEyWimbHTPM2zGBdoAUWGuEQLKKXADfQxlEuQgwrXr82eD7NGwWIuoCWhiHhKrSLPHx/d7c+sov0XNj7yWqoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885107; c=relaxed/simple;
	bh=ua0sH8yFISF+rwZPw+ODc9OsV/Q84Q1pFnvbPSpizjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9bWcBNdZ4uBYYDw5sK4ZaiKS6b7jmSv35lXSluqoLvdmSUSCXAiWyzXCf8tUDDdF5ZVAPEiCDbBpwFVcVu0pX++iW8axn0yspEUWVxe651E7McAVKihdDLoWNuN5O79vB7uLboXHYdnYEwo48iEmpTA4fsbmYBqyRqd+tPhYwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JeXGh+LG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1eecc71311eso70976715ad.3
        for <stable@vger.kernel.org>; Thu, 16 May 2024 11:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715885105; x=1716489905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1u0A/jvFC/WJVL7Tt9g9n1qwfCwFzV7mLCVMuWvZLc4=;
        b=JeXGh+LGN0Schm8km4tbHxku3VQwzgB3HuXhhkr8hVJcySSuT9rvpSkqZWZwCJ3cMm
         OYCEMpZxn3irrY8NOAGJerRWLZvcuc1i9vRGHovErpj6L2xGbtjOXW3kvLmNoUDwjPr6
         ByOqrPiclAilLoHgmmb1XPeSkf9sJ24iczz4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885105; x=1716489905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1u0A/jvFC/WJVL7Tt9g9n1qwfCwFzV7mLCVMuWvZLc4=;
        b=d1g0akeICigCyd8VYczVMtt5la+zN7TGGJd4CoRm1kDveLmJ00IgaR7ML1satW5/26
         lHoVBrp/oX/fc3H4qigr5BKtyz6Cy8ACNk7HxxA+oHsonsfxwqx0XGZx0NeeCbN41zq/
         iMJuEDhohYjHbb2T/mOeQPZvw1HH6A3hZXrBljhmzRAw2i0UT4LWJQFtLNXgyrfu7YC9
         di+2N9ljKg7TvSCo2MCZfZ17WgKOIS9tg6/cmd8u2hpm7rPZ8LOi7bAAi8rTQOX0pdEZ
         tzfOwe0t4TGTe9oJ4DjQGPhH8ygkyDfJetJDimAXGrHU36pYJDKSKn+deeu5+zs3f6H6
         PlEw==
X-Forwarded-Encrypted: i=1; AJvYcCXgk+eJLIQL9RWYVmkE3HpUjrFsXuFUKlLXSQVTARs+2mg5rrf3AsJRWBD2qaRM7AB0MdiYmHAKWJka5FP/d6zWzpqEUp3i
X-Gm-Message-State: AOJu0Yx6FkZAu/mzWa5ZnvwTJcbHPTtsZFNF2DgmjEZdVz4eZg0LljNd
	hvmLnA09vkfkzvDFaDil8L5oCIKSqCrb7ItRZw/iKNfUBdSN7L0tJVWBlysIPLqu9aJsTpvh4+0
	=
X-Google-Smtp-Source: AGHT+IHR0nuruZsamFp7ocrMNfq/zZwmTWSTKBs6nVmMbL85kUHjdVSPBM0KXVIfHpZDMNCuGJZDKw==
X-Received: by 2002:a17:902:7b82:b0:1dd:e114:121c with SMTP id d9443c01a7336-1ef4404c175mr236312515ad.56.1715885105493;
        Thu, 16 May 2024 11:45:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d168esm142177905ad.32.2024.05.16.11.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 11:45:04 -0700 (PDT)
Date: Thu, 16 May 2024 11:45:03 -0700
From: Kees Cook <keescook@chromium.org>
To: "Chaney, Ben" <bchaney@akamai.com>
Cc: Ard Biesheuvel <ardb+git@google.com>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/efistub: Omit physical KASLR when memory
 reservations exist
Message-ID: <202405161142.A62A23A9@keescook>
References: <20240516090541.4164270-2-ardb+git@google.com>
 <FBF468D5-18D6-4D29-B6A2-83A0A1998A05@akamai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FBF468D5-18D6-4D29-B6A2-83A0A1998A05@akamai.com>

On Thu, May 16, 2024 at 05:29:11PM +0000, Chaney, Ben wrote:
> > +static efi_status_t parse_options(const char *cmdline)
> > +{
> > + static const char opts[][14] = {
> > + "mem=", "memmap=", "efi_fake_mem=", "hugepages="
> > + };
> > +
> 
> I think we probably want to include both crashkernel and pstore as arguments that can disable this randomization.

The carve-outs that pstore uses should already appear in the physical
memory mapping that EFI has. (i.e. those things get listed in e820 as
non-RAM, etc)

I don't know anything about crashkernel, but if we really do have a lot
of these, we likely need to find a way to express them to EFI...

-- 
Kees Cook

