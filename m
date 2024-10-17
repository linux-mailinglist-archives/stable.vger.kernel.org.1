Return-Path: <stable+bounces-86685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5919A2D4C
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 21:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0211EB2323F
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 19:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508021C18B;
	Thu, 17 Oct 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVBuHu+3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85921BAFB
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192075; cv=none; b=clwJbBPN/6VRU9DK7D5aIxzW2kK6mfOlKBUbFsrNIrfGMhURUINZm1NSng06XWSL26yWB/SoX6XIfel6UXWtjlZAvTx5xFzprdjzl9z6TZT+OxlPn0TdzBMdCgimroBlWEdjuDiA3NIaRBPGxv5ej18dOb4sFnmzNpwN9hZRDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192075; c=relaxed/simple;
	bh=4+ixJyekF1jl6uiAyjfdWox0tZfOmu1tTOx5QFEdE0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2ex9w0ESSbfmcu8rfntJnggh32aFJyVWtk+l5rphgjTzBFyYA4iZp1vhEaFxAWlqINO1OlucmxJvN4r6CCNUeb0ciq8Uu4r2dPZ7fIXbvVDim84vhcpT8UyEA6RXdP77lbRBWHgy/mhTxs02OkvOW29hSezydf8Kla0DKvrAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVBuHu+3; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso3875a12.1
        for <stable@vger.kernel.org>; Thu, 17 Oct 2024 12:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729192067; x=1729796867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uixfl2jtVqbJqFwF+ymcJ/PUl6a3StJk/DrSTA+CVC0=;
        b=eVBuHu+3iIsWKuaLIQweQNQ6zGI9Ek5ZllO41IKg3KRNgGfDumdXWGf9JZLWU0d9JF
         FYaM5BatJ3Sgh8YD1fWV8Vute3gbEdyyKkK54vSPNqsD1tC3aEfUXu6HKsIIP/dwAe+5
         d1dJTD1qb7vNjX7CaK19thK3es6jUuVtCXB5zF+PZdgBFNlE2hC1VyMSZiYvFk7qfZHw
         j7LiTEE/c4oCWtg94qW+KQ5KwzhVtXidwhlTa6NtiWbBsdIBexWvOpXHKd3EsO4tH5rQ
         O4+iD4fn96Fw8OiDhu39edtw2Q5HO4AbiYzXziR8gPJO1VMzLTCKBNYXQ/iqEobxn75e
         ALSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729192067; x=1729796867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uixfl2jtVqbJqFwF+ymcJ/PUl6a3StJk/DrSTA+CVC0=;
        b=AT+5daQut5O0CDZuE/OJ8BSOK+yks2vy1x6ErrZDDhu5gODxj7F5+aQwKeu3OzkMKk
         VHkAzYyu+zOn1RqaEeube57Enxwl/Er3Keltv+QJJKm5YbThgHVjdlxUaHVYF9G3EkQ8
         ws1roOazDgmykfLXNtUEwKW1m4ipcXBfFCUOIa3mkIveX9cwrXw/Vl3B1A/sUhkiQdVd
         fyeyc1Dfue5ICeWCUMXQra0bxE4vhtV+xfWdsk47oZQTvwPvMfpVSpw7636Q7NDftYrn
         XUuCHXzpBVgnJeieHBWkKM0IxMpZl0Ou3BPURSyx56eamrqXgB/Y3CSQpgoDpZkJOiAl
         I07A==
X-Forwarded-Encrypted: i=1; AJvYcCX9EXUu0s/5bW6WrblcIpHp9rGee5fZgE1pb8fH+RziPYme0/zpZVlOI1SwxkRzh7uSl8uaLGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM5Dse/481uouNitJZakYjNHQ4k6zrwuXf3crE/BQGMMr8tdjR
	brBzIljalrMgmRo4wxckwTzDpK4h7fXlcEqXN+fbzyVTXdELxhll4yE7FPFB73bjUcTki9GiSWY
	NBz386zFHT4lCYoGMNUTLVzypz+zJU8ildTGx
X-Google-Smtp-Source: AGHT+IGJ5bOtzlZwtV+s5IaY9jBglbZpjiJuoBwT3AgW89JKzeUwi0aGlcdr06htRSmxbUTs1hCk4iI1TzT9Wa0QxxI=
X-Received: by 2002:a05:6402:2709:b0:5c8:84b5:7e78 with SMTP id
 4fb4d7f45d1cf-5ca0a186b93mr58751a12.4.1729192066673; Thu, 17 Oct 2024
 12:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-comedi-tlb-v2-1-cafb0e27dd9a@google.com>
 <202410170111.K30oyTWa-lkp@intel.com> <CAG48ez2T7i_qCAcGi3nZqQeT8A3x42YSdL=rWqXOUDy5Eyaf6A@mail.gmail.com>
 <ccc4e0a3-34f5-4793-bd05-ee0955c9c87b@mev.co.uk> <cf1a2818-1b78-4422-bb76-421732c428c0@mev.co.uk>
In-Reply-To: <cf1a2818-1b78-4422-bb76-421732c428c0@mev.co.uk>
From: Jann Horn <jannh@google.com>
Date: Thu, 17 Oct 2024 21:07:10 +0200
Message-ID: <CAG48ez1RWTEW_ZJBYbt6WWJX90haM61pwqqb3u9Pq8C_q71bQQ@mail.gmail.com>
Subject: Re: [PATCH v2] comedi: Flush partial mappings in error case
To: Ian Abbott <abbotti@mev.co.uk>
Cc: kernel test robot <lkp@intel.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Frank Mori Hess <fmh6jj@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:48=E2=80=AFAM Ian Abbott <abbotti@mev.co.uk> wro=
te:
> On 17/10/2024 10:29, Ian Abbott wrote:
> > On 16/10/2024 23:05, Jann Horn wrote:
> >> On Wed, Oct 16, 2024 at 8:05=E2=80=AFPM kernel test robot <lkp@intel.c=
om> wrote:
> >>> [auto build test ERROR on 6485cf5ea253d40d507cd71253c9568c5470cd27]
> >>>
> >>> url:    https://github.com/intel-lab-lkp/linux/commits/Jann-Horn/
> >>> comedi-Flush-partial-mappings-in-error-case/20241016-022809
> >>> base:   6485cf5ea253d40d507cd71253c9568c5470cd27
> >>> patch link:    https://lore.kernel.org/r/20241015-comedi-tlb-v2-1-
> >>> cafb0e27dd9a%40google.com
> >>> patch subject: [PATCH v2] comedi: Flush partial mappings in error cas=
e
> >>> config: arm-randconfig-004-20241016 (https://download.01.org/0day-ci/
> >>> archive/20241017/202410170111.K30oyTWa-lkp@intel.com/config)
> >>> compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
> >>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/
> >>> archive/20241017/202410170111.K30oyTWa-lkp@intel.com/reproduce)
> >>>
> >>> If you fix the issue in a separate patch/commit (i.e. not just a new
> >>> version of
> >>> the same patch/commit), kindly add following tags
> >>> | Reported-by: kernel test robot <lkp@intel.com>
> >>> | Closes: https://lore.kernel.org/oe-kbuild-
> >>> all/202410170111.K30oyTWa-lkp@intel.com/
> >>>
> >>> All errors (new ones prefixed by >>):
> >>>
> >>>     arm-linux-gnueabi-ld: drivers/comedi/comedi_fops.o: in function
> >>> `comedi_mmap':
> >>>>> comedi_fops.c:(.text+0x4be): undefined reference to `zap_vma_ptes'
> >>
> >> Ugh, this one is from a nommu build ("# CONFIG_MMU is not set"), it
> >> makes sense that you can't zap PTEs when you don't have any PTEs at
> >> all... what really impresses me about this is that the rest of the
> >> code compiles on nommu. I'm pretty sure this codepath wouldn't
> >> actually _work_ on nommu, but apparently compiling it works?
> >>
> >> I don't know what the right fix is here - should the entire comedi
> >> driver be gated on CONFIG_MMU, or only a subset of the mmap handler,
> >> or something else?
> >
> > Given that it would also affect a lot of fbdev drivers that would also
> > benefit from zapping partial mappings, I suggest that gating on
> > CONFIG_MMU would not be the correct fix.
>
> Perhaps just add an #ifdef CONFIG_MMU around the affected call for now?

Sure, I guess that works, though it's not particularly pretty.
(And this codepath looks like it won't really work on nommu either way...)

I'll change it that way for now.

