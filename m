Return-Path: <stable+bounces-192546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CF0C381C3
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 22:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F74E4AC8
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 21:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F142DC341;
	Wed,  5 Nov 2025 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b="WYkRQoHm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1382DCF7C
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762379597; cv=none; b=pZ4HuSRvOdvw/ZaYpotXpUYB/P0sBBACDs7DnNFNjes5azX7RUohcCAIHhdxJbruC3jgsPI7h6cIMfNvO3os35V61yeHPaSCUrL7R3v0XhywPoW46Y3f4K6XUCrRkyuw2S3P287GJ+k+tOGFhqvCAlL8nQHt+8AxmfA9Vgl42Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762379597; c=relaxed/simple;
	bh=roR+iHl5+yKbGXMgn+r+Uy/w3fFO0IOAH40xnQ+p/4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jb7pPPSaW4Xcz4cJDYEvEe1fXho6LdX/jrKlxzRlboG3Ni7H9nOT+xIK9gqP8Smvcbk1e1IYeAFiryZ93d5+owKOn2VejWB9xhpwBh8NdAELvk3SNIxe5AFAUyVkP0BlMJMXxVyJ6olcjTd0ufNJHA4C+aGpBql8T8LPxXoPcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com; spf=none smtp.mailfrom=osandov.com; dkim=pass (2048-bit key) header.d=osandov-com.20230601.gappssmtp.com header.i=@osandov-com.20230601.gappssmtp.com header.b=WYkRQoHm; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=osandov.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32ebcef552eso53132a91.0
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20230601.gappssmtp.com; s=20230601; t=1762379595; x=1762984395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXYPCL23ES9Iyb1NQ2+5KG+FblnpsKPGwtWMhH2bakQ=;
        b=WYkRQoHmw3VBywzUB+zNfAcc9p+MOWN27p9a0PCgMY7RnvfSuiX+fYrUSVMPvaGZ2P
         25pCinmce4kL4B5fFSs+8e9GLJd0BvRhAhg/my/UnkDxCeJwl0LHgg7W+L9L4iiN7jXv
         sh2sVKm/e5fkfUXXs24zjyfaRLmePqeoehCmhVrRI1qw7Mf/bKOaREPW3smOm+KDJzbD
         +Hf1TpEmOiO3cF7z/paR5SM5xPhB4HbxB2XN+XA3QCJHcSXq1WK3pk+2sL34Kldpw+Of
         TTgvGbvY9F+zWW4Y9dZSiQJk5LRwCwGVQcC17igMhu30jYUyyfPmWsdrZB4lzdCTALYG
         wWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762379595; x=1762984395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXYPCL23ES9Iyb1NQ2+5KG+FblnpsKPGwtWMhH2bakQ=;
        b=LN5C9z3GjPc9/l5kGf5XUTp7QarSU+fqqEtV12wpApJqd2BAfnqdS9mCD/c4lD9j9+
         V15MNh3wZ9AlvS+vls0nMu15f8SensgKG1v/mozMx3zeuyERD80gYwc5vmsf3GXPOvWM
         gFZ+lQeyud/q473L6y0rn52+UEQA9p3QfGsGinSqF2By92hDAeP4Jy/SFXZ27GkQIsOW
         PVuHhUx7/TTgS/CV94HsQg8NyFTEOMRNBIP+I5CYCBf6huv8h4WwFCls22wwcLf60LKk
         UyUprHFE4Yr/Zv+/ruPe2DQznceiHvTHMARpRx0eIqPV/ufYysQgfJbjViY6Vc2d3GvM
         47pA==
X-Forwarded-Encrypted: i=1; AJvYcCVfGbwDh1hi8JPVTE5IRNKT1ZJxlONXK9WfH4fmOiacnuMf17qogsonq7eQTeQXLzARmCJOVXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy82FEN7ARMOg6xc11s0JBYVLOeL0O53vm2lFHedAi3NWxcO9oj
	7+gKWlJiZCA2b4U/Cg6LeU6J0p1j1ukFHULswVEWfgBTjiu/gY+8bAz/w/kk6p/DQrA=
X-Gm-Gg: ASbGncsq5/beppEXHsjWV/hpVmvl0au1Rup+11L4YTCLFK1cyz82ZUT6nPRzmJe8enj
	sLrsjWfOrrbJZ8kPJ8qu8YnN2SnEiK5Ssg9Yy57uoArUOeSXSeFCQKx4ROuQ4LRTvPm5Cpm3AuP
	FSmngPFZF+kWIewvYB9MIW4MqFn1Y9BZ+VjPlxKIZjyajkqHHB5z3o7mFdswKuHTlId+iV98oKk
	x7SJZLmbTJdMo7C8f3pilQ1M+7to0+AXGfxjIOBCew7w85uovhEBw9N9ZGVkJgUfVfADHEbJEny
	lFrEbZhKRqcYFWoykcx3QoUZlIOanwaW7NSWCot7CpC+B63GNfHXF3cqLwfoq2wH9AN3zC7FCud
	8p6ctkA79njwhDTIqPthpRITmlM4rd3ELdjCDP3fYYvuFtZJ2xd2HETd2qDo+7KLtE8+27g==
X-Google-Smtp-Source: AGHT+IGY0r/CwQ4uYP5m9fphBTj5UtPwNG1Wco2SGrHkrgNEwj6b42fgxZjgQDbYi9yCWcOKFr/ugw==
X-Received: by 2002:a17:90b:1811:b0:340:b501:3ae2 with SMTP id 98e67ed59e1d1-341a6b0d5a4mr3477066a91.0.1762379595410;
        Wed, 05 Nov 2025 13:53:15 -0800 (PST)
Received: from telecaster ([2620:10d:c090:500::7:5bbb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d048e1d9sm221963a91.6.2025.11.05.13.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:53:14 -0800 (PST)
Date: Wed, 5 Nov 2025 13:53:13 -0800
From: Omar Sandoval <osandov@osandov.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>,
	linux-kbuild@vger.kernel.org, Samir M <samir@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	linux-debuggers@vger.kernel.org, Nicolas Schier <nsc@kernel.org>,
	Alexey Gladkov <legion@kernel.org>
Subject: Re: [mainline]Error while running make modules_install command
Message-ID: <aQvHSVXbOdiN_J5D@telecaster>
References: <7fef7507-ad64-4e51-9bb8-c9fb6532e51e@linux.ibm.com>
 <56905387-ec43-4f89-9146-0db6889e46ab@linux.ibm.com>
 <aQpCE_XTU-bZHFbk@telecaster>
 <CANBHLUhJ5UVsN4-JN2PG=jq63yGttB9BD6Qm8MgvYirTvg_stw@mail.gmail.com>
 <20251105011548.GB769905@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105011548.GB769905@ax162>

On Tue, Nov 04, 2025 at 06:15:48PM -0700, Nathan Chancellor wrote:
> On Tue, Nov 04, 2025 at 08:35:57PM +0000, Dimitri John Ledkov wrote:
> > On Tue, 4 Nov 2025 at 18:12, Omar Sandoval <osandov@osandov.com> wrote:
> > > drgn's CI hit this same failure. FWIW, the commit fixed by this bisected
> > > commit, 3e86e4d74c04 ("kbuild: keep .modinfo section in
> > > vmlinux.unstripped"), also results in ELF segments of size 0 in vmlinux
> > > for some configurations, which confused drgn until I added a workaround
> > > (https://github.com/osandov/drgn/commit/2a9053de8796af866fd720a3c8c23013595d391a).
> > > So there's some funkiness in this area.
> 
> Omar, could you provide me with a configuration file that reproduces
> this for you? Is there an easy way to check for this situation on the
> command line?

Here's a script that reproduces it:

```
#!/bin/sh

set -e

host_arch=x86_64
compiler_version="12.4.0"

compiler_dir="/tmp/arm64-gcc-$compiler_version"
if [ ! -e "$compiler_dir" ]; then
	rm -rf "$compiler_dir.tmp"
	mkdir "$compiler_dir.tmp"
	curl -L "https://mirrors.kernel.org/pub/tools/crosstool/files/bin/$host_arch/$compiler_version/$host_arch-gcc-$compiler_version-nolibc-aarch64-linux.tar.xz" | tar -C "$compiler_dir.tmp" -Jx
	mv "$compiler_dir.tmp" "$compiler_dir"
fi

export PATH="$compiler_dir/gcc-$compiler_version-nolibc/aarch64-linux/bin:$PATH"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux- tinyconfig
make ARCH=arm64 CROSS_COMPILE=aarch64-linux- -j$(nproc) vmlinux
readelf -W -l vmlinux | awk '$1 == "LOAD" && $6 ~ /0x0+\>/'
```

It prints something like:

  LOAD           0x1ef008 0x0000000000000000 0xffff800080220000 0x000000 0x000000 R   0x10000

I.e., a segment with FileSiz and MemSiz 0.

Using a newer crosstool version fixes it, so maybe this was a GCC or
binutils bug.

Thanks,
Omar

