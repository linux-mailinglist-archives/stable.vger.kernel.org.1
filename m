Return-Path: <stable+bounces-106773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6BA01D0C
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 02:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0E61882C96
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123E738FB9;
	Mon,  6 Jan 2025 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eB6+EggR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC817C
	for <stable@vger.kernel.org>; Mon,  6 Jan 2025 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736127457; cv=none; b=hmWIVwa44P3qEHV1ylF9Rq2A8MNuBpUPza/KpP7Dgo9eGKzd4m8/g0GM/6EQ8ONCWfpyAPQJcjyghsrq7H2HQy2/6DAxxaAU3+s9fNdE2/KPiUmZCSMgqNEyS+IAh+kvOwZZ0HGEYQvmr8klQ6AXGqPf/waGcxE2moavbM3XCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736127457; c=relaxed/simple;
	bh=lNcHVK16RCYxl5F5nWEn/ll7HwC3Us7SLZrfeMrpgs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYi3PSq0KwPFfUNiwpxAfPlOXtzhO/lqUrwn4yoToGIscNA6DJdtwNS56T6YwfJiJjsHxruLjQ9yxcRv0LOELmeZmZbvlnkEPeVxOnHLS9BGCqqS+bCO3hmy+Lobg7vBvw/t56gNao6DhGLfZoZSF79wG2ogNC8a+p2eMn/nj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eB6+EggR; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-aaf8f0ea963so651250066b.3
        for <stable@vger.kernel.org>; Sun, 05 Jan 2025 17:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736127454; x=1736732254; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G71jT3v407xdfDk/TCMUFLwJMc0zXheYyvkQJ26Y7W8=;
        b=eB6+EggR+JSzM+xrpS+vorvKJIh+o8XgE2ZkFhquAivfxihisQAyqDEFEmnpintIx8
         o79e0nkDrlpQOSzPosU2WKxPxw0jBryDXVFyI2dAIpo27y+C4nuI/GtvDtekXq6/2bXg
         JhQYThCmUZe1McLplLD2NCusZk8PGB/czJuUn8ufAQCO6iDjK0dwf/wH7uiv2TCXZ6OL
         IBSRunnIO0RGaeNGsO4b2QRwF+OcZkchFVbJtk2RYx5Kz/1lXjFhwdX/uzHFm0swW+H6
         Qeqe36ldCB9JVbn9nVxC50KiZT4brLMG9FWn10y2q+675qGodB+9rnPdH5v2OztBYLj8
         zJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736127454; x=1736732254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G71jT3v407xdfDk/TCMUFLwJMc0zXheYyvkQJ26Y7W8=;
        b=ftC+srFJ/T+co4AiDVqxz7HwftE1sGT+R5SNCE+aNnHXjFsoEtyBOuUJ/AdYYBVzGF
         J+ECnQV7AtN9sRWJrk09R/3GrQq7V0yeMFBUv7rq32f0tubS7ah0MoCRffIi1/G2sxM0
         xplXkuC6s0GwKB1bStHcObDrvNZSbeK/E/VPQH3jDUpIngplYcnfJBjXWqvWTncexJj3
         tf/buW/0VqlegXD6i3PZK6KjnapMQCfhYzvjg4qjI6icMi0KicTuDRdL4je+PP49A1hu
         u8HXQZdeNWH/f8X4YC7Br+svvUocYVGOgJov64g7ul6gg1tcZLATItsosqJDD6BLVhk5
         z3Dw==
X-Gm-Message-State: AOJu0YxJQD1TuKVva4PLIPBXjKETTjH3A+ljlXmaIQSrB4e3ijevgQi+
	fWlhvsdMeEEeQXv/VuEJ/fKCNuwdYOEYky9KB5zdKJrzgO6llZpDQXsP4+aqtR8=
X-Gm-Gg: ASbGncsHJGVuEr93lEUD7udLeZqUbfhy/5HcUO8tOPHi+/1YQXcJ5keDrCm2uyu3vp6
	2o2jm2JikzHIhlDhXiWTRYIV90naiqtfAlSUFpfsGJvhXy5t/YCHIjie+Y183NuEK7JA6fgo5pi
	0AbiW1HdHkTqGcr4JYrwXF8hQDOK4X3UKKqflMdybD56IqqHrp9jxreRr6n36fLxq+rVnPdsXFD
	H5CSHvb4mo3yFGpjMZpVK+7b9t50O9uhO2vjQNj+SM0VbRQ/7c0
X-Google-Smtp-Source: AGHT+IHdRo/b9pc4goaEckEFK5ikbGCllrc7MMgOw7KBOiYYky68K1B9TvPhvOBh68Cbjcq7/7oxpw==
X-Received: by 2002:a17:906:6a24:b0:aab:7467:3f6a with SMTP id a640c23a62f3a-aac2ad8446emr4573865666b.21.1736127453882;
        Sun, 05 Jan 2025 17:37:33 -0800 (PST)
Received: from u94a ([2401:e180:88f8:1bfc:25d6:159f:360e:20ec])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478accb3sm32342474a91.51.2025.01.05.17.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 17:37:33 -0800 (PST)
Date: Mon, 6 Jan 2025 09:37:26 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Levi Zim <rsworktech@outlook.com>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.6] bpf: support non-r10 register spill/fill
 to/from stack in precision tracking
Message-ID: <k32rq5abffq5kss5ejrzj3yx2dgn4c2ken2hrudws52mwuua4k@j64qawub3icu>
References: <20241126073710.852888-1-shung-hsi.yu@suse.com>
 <MEYP282MB2312C3C8801476C4F262D6E1C6162@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
 <fz5bo35ahmtygtbwhbit7vobn6beg3gnlkdd6wvrv4bf3z3ixy@vim77gb777mk>
 <MEYP282MB2312577632CB3812D002FEE6C6172@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MEYP282MB2312577632CB3812D002FEE6C6172@MEYP282MB2312.AUSP282.PROD.OUTLOOK.COM>

On Sun, Jan 05, 2025 at 03:29:08PM +0800, Levi Zim wrote:
[...]
> > > I think there's some problem with this backport.
> > > 
> > > My eBPF program fails to load due to this backport with a "BPF program is
> > > too large." error. But it could successfully load on 6.13-rc5 and a kernel
> > > built directly from 41f6f64e6999 ("bpf: support non-r10 register spill/fill
> > > to/from stack in precision tracking").
> > Can confirm. I think it's probably because missed opportunity of state
> > pruning without patches from the same series[1].
> 
> Hi Shung-Hsi,
> 
> Given that 41f6f64e6999 is the first commit from that series and my program
> can successfully load
> on a kernel directly built from upstream commit 41f6f64e6999.
> 
> I think it is unlikely that it is caused by missing patches from the same
> series.

Ah, I missed that you tested at 41f6f64e6999 as well. However I think
there's still a decent chance that the missing dependency is from the
same series.

The reason is that I tried cherry-picking 41f6f64e6999 it directly on
top of v6.6 (ffc253263a13), and there the eBPF program in your
reproducer loads fine. It was since ff4d6006870f (~v6.6.22), backport of
commit e9a8e5a587ca ("bpf: check bpf_func_state->callback_depth when
pruning states"), does cherry-picking 41f6f64e6999 cause the eBPF
program to fail to load. Which kind of make sense, with state pruning
restricted, the verifier would have to traverse more states and likely
to hit the 1 million instruction limit.

So my guess is we need some patch(es) between 41f6f64e6999 and
e9a8e5a587ca that helps with state pruning:

  ab125ed3ec1c bpf: fix check for attempt to corrupt spilled pointer
  eaf18febd6eb bpf: preserve STACK_ZERO slots on partial reg spills
  e322f0bcb8d3 bpf: preserve constant zero when doing partial register restore
  18a433b62061 bpf: track aligned STACK_ZERO cases as imprecise spilled registers
  8062fb12de99 bpf: consistently use BPF token throughout BPF verifier logic
  a833a17aeac7 bpf: Fix verification of indirect var-off stack access
  1d38a9ee8157 bpf: Guard stack limits against 32bit overflow
  6b4a64bafd10 bpf: Fix accesses to uninit stack slots
  2929bfac006d bpf: Minor cleanup around stack bounds
  482d548d40b0 bpf: handle fake register spill to stack with BPF_ST_MEM instruction
  1a1ad782dcbb bpf: tidy up exception callback management a bit
  56c26d5ad86d bpf: Remove unused backtrack_state helper functions
  745e03113065 bpf: Comment on check_mem_size_reg
  8e432e6197ce bpf: Ensure precise is reset to false in __mark_reg_const_zero()
  d17aff807f84 Revert BPF token-related functionality
  d028f87517d6 bpf: make the verifier tracks the "not equal" for regs
  4ba1d0f23414 bpf: abstract away global subprog arg preparation logic from reg state setup
  5eccd2db42d7 bpf: reuse btf_prepare_func_args() check for main program BTF validation
  e26080d0da87 bpf: prepare btf_prepare_func_args() for handling static subprogs
  c5a7244759b1 bpf: move subprog call logic back to verifier.c
  f18c3d88deed bpf: reuse subprog argument parsing logic for subprog call checks
  94e1c70a3452 bpf: support 'arg:xxx' btf_decl_tag-based hints for global subprog args
  a64bfe618665 bpf: add support for passing dynptr pointer to global subprog
  5abde6246522 bpf: Avoid unnecessary use of comma operator in verifier
  8a021e7fa105 bpf: Simplify checking size of helper accesses
  c39aa3b289e9 bpf: Allow per unit prefill for non-fix-size percpu memory allocator
  5c1a37653260 bpf: Limit up to 512 bytes for bpf_global_percpu_ma allocation
  19bfcdf9498a bpf: Relax tracing prog recursive attach rules
  22c7fa171a02 bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
  11f522256e90 bpf: Fix warning for bpf_cpumask in verifier

I'll further test them out.

> Probably there are some dependent patches for 41f6f64e6999 not present in
> LTS 6.6 but present in v6.8.x
> where 41f6f64e6999 comes from.
> 
> > Given it's a regression, I'll sent a revert patch and try to figure out
> > the rest later.
> Thanks!
> 
> Levi
[...]
> > > To reproduce, run  ./tracexec ebpf log -- /bin/ls
> > > 
> > > Prebuilt binary: https://github.com/kxxt/tracexec/releases/download/v0.8.0/tracexec-x86_64-unknown-linux-gnu-static.tar.gz
> > > Source code: https://github.com/kxxt/tracexec/
> > > 
> > > Best regards,
> > > Levi
> > [...]

