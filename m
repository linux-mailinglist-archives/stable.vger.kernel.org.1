Return-Path: <stable+bounces-132711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5382A89804
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 11:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009351892ED1
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71141EF37F;
	Tue, 15 Apr 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AfGdYt5K"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3681BEF87
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709463; cv=none; b=gCRrFsrYOW3WK3SEPfZvUC3XQL2Am8VdDox/B8Y7HgISJJAJgxcQbt++hSNfUaHpELSMw2WjH4U0gmHvfFNTRuvswjZzQz0jMDMm3GsNfS3y2uAnDqshweuzUIranTRwEMHWMAg0aVIoLR7cjzKjTXr9CdfWUlPdFLiiJmG5tj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709463; c=relaxed/simple;
	bh=COsaRIuvxnkua8HwmzqjmXwFKFAVEQs3llUnp+yyRGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4uew/iOeJg9K5gmUOcHJ8WyP6C8jd30tZSg8LVgjaOhrFRC6pru5LwHurM4n1uXqwo7/d++eOMCHjqpA3rz/fmLVBvb7j1VpJkqRoAsYyHRrcHkLGORtIYFd6zOcEGK2b8WctWcXIBkXBR2uldxeQ5dL5hTG7AmLyDGp+b4d0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AfGdYt5K; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39ac9aea656so5271808f8f.3
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744709458; x=1745314258; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t5p/bRbKfGu9zt0PYKNZNkRZvCOD+RuypWosHSES6Sk=;
        b=AfGdYt5KwMeDqSr3flGaW594aFpTelPBvMu5r9km71F2xNro+xZ56Gx8w6TcFLoA2L
         gwhwzS96IhpFHzPG+aRJEIRsWDMGWJz+S3i05o1TOBpgenn5XPRcYcVnwXEhc8hvZBaF
         t+mdE8nDFk7zXUlgVQscaRDlNpTCFpy/QbSrvYcDct1B+FMXAjFsxCh3brHpsA4eXFvW
         CJSiyvL7Bh0QTftP+gTgfMK5Ztv5AHJjE1qpyLNPzdOHdYQ6pDTG5ACvat96qREntjJE
         9DwgiJ1QhXFK62fZNgthuQUfNciXC64ZtHqdpHXVJz45Nt+Ivy55yqs/4wZ/hwQJkzcL
         F0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744709458; x=1745314258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5p/bRbKfGu9zt0PYKNZNkRZvCOD+RuypWosHSES6Sk=;
        b=SZ/mbZuLwfQUtg1RCCxVDmYQvjparQiQp+Pw76K2RJLw+ZXP4Ss/wwOD6EcGwDi9Rg
         d30c8mzHwWiBEPInwOiVui8HWrAUgUFlqP9m6+zO6USp+dhZx4tV0JiGp+0TMrUO88Pl
         304j2HMWyhp1DgoRoRe4n7qLkBIEgPe605gPUZPGB4RJ20tiX6XKLz+UnqUAkDjPIBiG
         y7lv2JrrvAEsoGOLxjM5U0NnV1yFSxWxOuQghaK074L54dOSk9fK2eYn+vWhl5RPIUTL
         I5iLJ4yp+4OCzOuctrqDjqAX9SRGjpQIeRgDSM6pvDAr1zAqMFa0sogq5r1gblOIYrd2
         PJsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSM5/8d9Lg/cGjCTP6pcQUMcx6AP+ATzjFPBqKouEQbrN8OIUTcnrOQ953r7QJpfGO3Y8OXqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuwcpv9foTfMllIL6BsgS/a73O5+k5mXuLdAm0osxXCjy/B5SQ
	nHC6mGMeqDdO347JhYukX9sUS5dZA38l97EpRXZ2drKa0LBkzavy5xndLmjmH50=
X-Gm-Gg: ASbGncuSMzIBlfsgiO5z4G+HxI0ChCXUlgauq6i3iF8ftFyutshwPwWeNmDN2dgVNHd
	WBbgSggUNuFThzWh7mTXGfheCyaZFDAe6loDeMO/buEWZOsiCnp14/FfEmME988CFGgMmZDG2WP
	00VWn41Exk/++C5s22NpzC3T0oiG4c3PlWZgw5yZrEm/jRpxhB3QLjWrIg4SkW1+Qeok2gFy4rd
	W5aTlTLmPe6XH9s8QH9BuHL7bInP8/RnJ0mL/5pVxqAMO0yCnrKRx6mzrF0sL7CHsVO4Tv6MbnW
	qGfVs5Dc4/qeO5d4IEyhVLIajZGyBMW41QCGXztBMsBU3A==
X-Google-Smtp-Source: AGHT+IFP/8/ehvnOlG0x/DX32B7q3RBAFlaoRAWXR6v+kbGywYJdun4oe9Fh5KKW2bpD3AzaY3WOhg==
X-Received: by 2002:a05:6000:430a:b0:39c:1257:cd3e with SMTP id ffacd0b85a97d-39eaaedcf62mr13305491f8f.56.1744709458272;
        Tue, 15 Apr 2025 02:30:58 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:75f9:2464:4043:4f92:fce])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c95c8esm112943125ad.145.2025.04.15.02.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 02:30:57 -0700 (PDT)
Date: Tue, 15 Apr 2025 17:30:30 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, lmarch2 <2524158037@qq.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH bpf v2] libbpf: Fix buffer overflow in
 bpf_object__init_prog
Message-ID: <gaebflcrzdszes6febvrf43dgllpemg3ghcgbwmd2klfaj7p4t@cmg2los3ahla>
References: <20250410095517.141271-1-vmalik@redhat.com>
 <CAEf4Bzb2S+1TonOp9UH86r0e6aGG2LEA4kwbQhJWr=9Xju=NEw@mail.gmail.com>
 <d87e3ed0-5731-4738-a1c6-420c557c3048@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d87e3ed0-5731-4738-a1c6-420c557c3048@redhat.com>

On Mon, Apr 14, 2025 at 06:59:31AM +0200, Viktor Malik wrote:
> On 4/11/25 18:22, Andrii Nakryiko wrote:
> > On Thu, Apr 10, 2025 at 2:55 AM Viktor Malik <vmalik@redhat.com> wrote:
> >> As reported by CVE-2025-29481 [1], it is possible to corrupt a BPF ELF
> >> file such that arbitrary BPF instructions are loaded by libbpf. This can
> >> be done by setting a symbol (BPF program) section offset to a large
> >> (unsigned) number such that <section start + symbol offset> overflows
> >> and points before the section data in the memory.
...
> >> Cc: stable@vger.kernel.org
> > 
> > Libbpf is packaged and consumed from Github mirror, which is produced
> > from latest bpf-next and bpf trees, so there is no point in
> > backporting fixes like this to stable kernel branches. Please drop the
> > CC: stable in the next revision.
> 
> Ack, will drop it.

Sorry for blindly suggesting the CC. I'll keep that in mind.

> >> Fixes: 6245947c1b3c ("libbpf: Allow gaps in BPF program sections to support overriden weak functions")
> >> Link: https://github.com/lmarch2/poc/blob/main/libbpf/libbpf.md
> >> Link: https://www.cve.org/CVERecord?id=CVE-2025-29481
> > 
> > libbpf is meant to load BPF programs under root. It's a
> > highly-privileged operation, and libbpf is not meant, designed, and
> > actually explicitly discouraged from loading untrusted ELF files. As
> > such, this is just a normal bug fix, like lots of others. So let's
> > drop the CVE link as well.
> > 
> > Again, no one in their sane mind should be passing untrusted ELF files
> > into libbpf while running under root. Period.
> > 
> > All production use cases load ELF that they generated and control
> > (usually embedded into their memory through BPF skeleton header). And
> > if that ELF file is corrupted, you have problems somewhere else,
> > libbpf is not a culprit.
> 
> While I couldn't agree more, I'm a bit on the fence here. On one hand,
> unless the CVE is revoked (see the other thread), people may still run
> across it and, without sufficient knowledge of libbpf, think that they
> are vulnerable. Having a CVE reference in the patch could help them
> recognize that they are using a patched version of libbpf or at least
> read an explanation why the vulnerability is not real.
> 
> On the other hand, since it's just a bug, I agree that it doesn't make
> much sense to reference a CVE from it. So, I'm ok both ways. I can
> reference the CVE and provide some better explanation why this should
> not be considered a vulnerability.

While I also see other colleagues that reference CVE number in the
commit message in other subsystems, personally I would drop CVE
reference here. This CVE entry doesn't have techinical detail in itself
beside mentioning that the issue being buffer overflow, and is
disputed/on the way to being rejected as far as this thread is
concerned.

...

