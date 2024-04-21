Return-Path: <stable+bounces-40351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF5F8ABDCC
	for <lists+stable@lfdr.de>; Sun, 21 Apr 2024 02:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F81C1F21442
	for <lists+stable@lfdr.de>; Sun, 21 Apr 2024 00:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D8D1FBA;
	Sun, 21 Apr 2024 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zEOpJYwv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81152205E07
	for <stable@vger.kernel.org>; Sun, 21 Apr 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713657637; cv=none; b=D5F1850W6zL35BaJMop6X72bdfhCq8SWPi++45ALq0eD/OHvMDhU+vKzHJUBxjF/u3rRbHdWfLZtX8CSbK6L97JoMDkB2xdvOjNbs/SuUWAyn//FeCzY63TPVNDO7tFHtHcmaX42jFKa6JlQzq1TVGLJ8hSMffz5bd7NpjbSBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713657637; c=relaxed/simple;
	bh=0H9fOBBCoY5g2gdmsJAilkNhmk7pDmb/337HauY6yM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBKTrbfDn6PhdiCNUqlY0BT62tLKqNi0KErGAwrG866pmzNmb/su7uvny12XBNLtaNPWsDLi4iCZY40EiccglCazUQnz1gmqaOlo14LBfzqOLri/TAW47q3bo+BJYrZrDBoksy2YppKMVpa/4DmZkTMAuPFHjlqYN59X+nwOJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zEOpJYwv; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6effe9c852eso2688562b3a.3
        for <stable@vger.kernel.org>; Sat, 20 Apr 2024 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713657636; x=1714262436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pbbNzG6RR7ekxyfxB+geoIx5fClIv1DY5BuwyLNUvn4=;
        b=zEOpJYwvsLuHQG+OudaD2xjL0nNYpOS90bdUuD18l1d7uZfK6zzCSUdtwss8TjoEFz
         urPbLwekIUAjBvMehYdIpezPjuqJVsmwj5FUznsjN/MrHCmUFrsBLYnzSzMdu9kIgKnI
         Dj9pokiVEM+xnBW2JDufQrjiLyfRaWaWJMR7AhbK/T4VmYYOKJX/EoJyebKbzhrZeQtM
         fxXTWk2ZlvHtea2xxXuwGCYc4NFQcOUhaVnILEcxBG6WeOFvuhh+DauNZ51/7ljLjaQJ
         Xhdz+di8ujQ14UYWfa8jvi1TBO/+LUde985ErKkP4awzyc0DUuwyKpMJ0kwOH2ZTKyRv
         PxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713657636; x=1714262436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbbNzG6RR7ekxyfxB+geoIx5fClIv1DY5BuwyLNUvn4=;
        b=OMX2qWGwJtvnxjHhLtMINDXDZqoiOFkOg5IJdaFkdrMjjxXKgMWDikIyR6Fqra8qX6
         O7bLExGMiO3W5Bacy2NfkvCZzBZQcH+s4ukhbt56/nUPfbro5s9sc/yJtKMUZzJ4c/cJ
         c07EHVyp4Jf39VDA9m7nafo8C+wJhhoz/2HN5TuZBy/Dx0NKunihtMGKSf5M6mwRFuJV
         cl0/aLyx3mIOjn/rwIKoQpnWa6aGh3THjsuwT13rtMTJ2VvB5zY+Na3g/LS0W1X7pQfX
         Bd4PIo9XoWu8rK5Du+oB1FZ3qgG/cCP9SFOfsG7+n4d8/vqAZk6/z590LGnBp0wqA1Pz
         VOHA==
X-Forwarded-Encrypted: i=1; AJvYcCUUraggJTIKmPXILsu+b065KLCUN17WyRnD1wOechCHmpqUJdRZncqV2IzX7ZS4PgyXGSfUjardAO6r9FZqBUHrhkDoimJG
X-Gm-Message-State: AOJu0YxevMVJ38HrXbZdjnKhM6nMbGclDR3fnYO9Fyw+cHHHtlTUrQuv
	uD0KEhmE+qJyNmbw3FMRDHttC5PWsO5r9AD4hn3PZPHgGxw9Qnh2MnLof10w1w==
X-Google-Smtp-Source: AGHT+IGKrCn5lJjwZzmLFl99+WUKiZhw2WYlWdCXA/kRIfdcUb0ATIVldr7Mbw+xyb6iOQbxEtKHuQ==
X-Received: by 2002:a05:6a00:10cb:b0:6ed:1c7:8c5e with SMTP id d11-20020a056a0010cb00b006ed01c78c5emr6822584pfu.12.1713657635554;
        Sat, 20 Apr 2024 17:00:35 -0700 (PDT)
Received: from google.com (139.69.82.34.bc.googleusercontent.com. [34.82.69.139])
        by smtp.gmail.com with ESMTPSA id ei55-20020a056a0080f700b006ead47a65d1sm5384191pfb.109.2024.04.20.17.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 17:00:34 -0700 (PDT)
Date: Sun, 21 Apr 2024 00:00:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Serban Constantinescu <serban.constantinescu@arm.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] binder: fix max_thread type inconsistency
Message-ID: <ZiRXHs9_Uszd7xzS@google.com>
References: <20240417191418.1341988-1-cmllamas@google.com>
 <20240417191418.1341988-5-cmllamas@google.com>
 <2024041858-unwoven-craziness-13a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024041858-unwoven-craziness-13a6@gregkh>

On Thu, Apr 18, 2024 at 06:40:52AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 17, 2024 at 07:13:44PM +0000, Carlos Llamas wrote:
> > The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
> > size_t to __u32 in order to avoid incompatibility issues between 32 and
> > 64-bit kernels. However, the internal types used to copy from user and
> > store the value were never updated. Use u32 to fix the inconsistency.
> > 
> > Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS declaration")
> > Reported-by: Arve Hjønnevåg <arve@android.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder.c          | 2 +-
> >  drivers/android/binder_internal.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Why does only patch 4/4 need to go into the tree now, and as a stable
> backport, but the first 3 do not?  Shouldn't this be two different
> series of patches, one 3 long, and one 1 long, to go to the different
> branches (next and linus)?

Yes, that is correct. Only patch 4/4 would need to be picked for linus
now and for stable. The others would go to next. Sorry, I was not aware
that sending them separately would be preferred.

I'll drop 4/4 patch from the series in v2. Let me know if you still need
me to send it again separately.

Thanks,
Carlos Llamas

