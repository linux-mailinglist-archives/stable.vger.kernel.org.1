Return-Path: <stable+bounces-19399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE8850156
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 01:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487C91C224C2
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 00:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22311FDA;
	Sat, 10 Feb 2024 00:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hlUkaadt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EDBEAEE
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 00:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526142; cv=none; b=JOD7Uajxhus23EiqXNiwRxv4uLgSEJiq0Ndk7mWXAwcxHpryMvkIgBUg71FzF6KD5tV/TZojPdDCq7cl46gJR5sYxIuvTX2B5hLbARsEmzRUGaGs1XHwMCkfEp/Jw3HvRK4+hi5z8jPerz98Uwxqg6C1owF9cdUaq4yCG2N8Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526142; c=relaxed/simple;
	bh=hrEhIt0za4zXX+4YcZvr59C24AojcEa8uuOYHTznHjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIqI6jjbZe+Lra7p7dEFNx32lzc1uAEz+H/vUKO8W4iVAPJ2moKj/lpLavs+mVFO5MiwsyuZl3DrAeruv8Y1HW+ZRO8haftHQOKdEH831NYL38t9Nl/Hy1OGKJyYHJcUfhUsTFpFHeKlGBsHC9yHEgVXJSNpNPGwSZpp9LRQkWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hlUkaadt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d95d67ff45so12438485ad.2
        for <stable@vger.kernel.org>; Fri, 09 Feb 2024 16:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707526141; x=1708130941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhIOsBixkq6X+I5UtLFYmEvlA1q4nQi2Uk71zOMtrW4=;
        b=hlUkaadtwYDpofzNbUrSFlSfW4QPT7DehDRAeXEGwQQ3YKAh66LeMQaUf2u9raSBwn
         hurC/Y7sOQ+PyWV+fz8A00w2KaTAkkTpfRfGrRJBRjzFcJS5yHvRT6785IFQcq8W+1Im
         oZ6oZ7XLhZ4RIPUMEq1o6d2SowNNHktGoh4OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707526141; x=1708130941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhIOsBixkq6X+I5UtLFYmEvlA1q4nQi2Uk71zOMtrW4=;
        b=jerLd7wnYDKxW5abvv5eb3vY9JCjTna2t0g/lQdCJAMl0b1j4p1zhk4EAfgez0+yqL
         6OSZ80yJnd9N3lmiQgUIBv7HTQ4L/VBW86ha51jpcAah+fyO07pYNGnlt2wKh98JfqqG
         xfZX+kfoXNypAYBWrvOMgx4CxVYsknR5yvNzIkAUogiuHLyl0fot7nEAZYwcWsmJwY3p
         jH1EFCjIWuYVY7rviCWjxDF//YPtvtjcA6FOxjgAhrXHfEdF6Ngy6K4Aho1p0ZIKIWEU
         X5SuirRduDtAjOHdbOZFYlWFSHmEpmM9SPGs9hIP1GnyFhgnid+/zn8BYjj6A/PkKUuz
         E9sw==
X-Gm-Message-State: AOJu0Yy5hQJT5nnMS/s06mgz3STRxjMzQVQl9knrdvjGWAPB/xiavWrv
	D4LbmO2xp7xQPcq0gwg2N3luLdGi11OgxpKz3/HlK9IsgrAe5IOZHESE9wL/WA==
X-Google-Smtp-Source: AGHT+IGqFQmp48EV/HeK/ohKlHb7zxUA5fEEZHeG+9UTzYyujZAJTn94wWRhwDxrqBopNav53lCKsg==
X-Received: by 2002:a17:902:ea09:b0:1d9:b8cb:3665 with SMTP id s9-20020a170902ea0900b001d9b8cb3665mr1167619plg.36.1707526140735;
        Fri, 09 Feb 2024 16:49:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVI0SOI2E3VC0AE0of9/MYFRR0yVYQzthkFmv0JW7fA/SJQhhnnI3Nj5OEsNvrtNcdRFhHpOf5u+C3DGYEj7y1QmZKG9DqmJxhSLGKUmKRtiym081eBwXvmlPvnPoRFbYozaBCVcEzpfdzvKL5XsE6na+cvYGSIz8z/iw3GGz5NgMjZyC8x1ylmlUU500p9eC7PsDUz3qdjaUJ4lDemv8WJ00f0xgTx30k9IBXOA4ukuDuItip5wN0tqF2XRRURTeOK4zFlkc/U1xMHtLiGXHCiJxbOfRkGuI6qbhSgFvTKnpkPDxwJIq+B0WYaKEtx/pSF/bhP69oEmAjzAfeoA5ZDA9/FFXosjMJlFihIuYBkey/d
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902748300b001d9eef9892asm2062122pll.174.2024.02.09.16.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:49:00 -0800 (PST)
Date: Fri, 9 Feb 2024 16:48:59 -0800
From: Kees Cook <keescook@chromium.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: masahiroy@kernel.org, nicolas@fjasle.eu, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, maskray@google.com,
	linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] kbuild: Fix changing ELF file type for output of gen_btf
 for big endian
Message-ID: <202402091648.2B8D95062B@keescook>
References: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208-fix-elf-type-btf-vmlinux-bin-o-big-endian-v1-1-cb3112491edc@kernel.org>

On Thu, Feb 08, 2024 at 01:21:06PM -0700, Nathan Chancellor wrote:
> Commit 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> changed the ELF type of .btf.vmlinux.bin.o from ET_EXEC to ET_REL via
> dd, which works fine for little endian platforms:
> 
>    00000000  7f 45 4c 46 02 01 01 00  00 00 00 00 00 00 00 00  |.ELF............|
>   -00000010  03 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |................|
>   +00000010  01 00 b7 00 01 00 00 00  00 00 00 80 00 80 ff ff  |................|
> 
> However, for big endian platforms, it changes the wrong byte, resulting
> in an invalid ELF file type, which ld.lld rejects:
> 
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF............|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
>   +00000010  01 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
> 
>   Type:                              <unknown>: 103
> 
>   ld.lld: error: .btf.vmlinux.bin.o: unknown file type
> 
> Fix this by using a different seek value for dd when targeting big
> endian, so that the correct byte gets changed and everything works
> correctly for all linkers.
> 
>    00000000  7f 45 4c 46 02 02 01 00  00 00 00 00 00 00 00 00  |.ELF............|
>   -00000010  00 03 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
>   +00000010  00 01 00 16 00 00 00 01  00 00 00 00 00 10 00 00  |................|
> 
>   Type:                              REL (Relocatable file)
> 
> Cc: stable@vger.kernel.org
> Fixes: 90ceddcb4950 ("bpf: Support llvm-objcopy for vmlinux BTF")
> Link: https://github.com/llvm/llvm-project/pull/75643
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Yeah, looks good to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

