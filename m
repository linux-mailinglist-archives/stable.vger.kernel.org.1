Return-Path: <stable+bounces-206034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E12CFAAC4
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 20:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4795300CF0C
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 19:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5332A34D4E4;
	Tue,  6 Jan 2026 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYcFeQad"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6E34DCCC
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727862; cv=none; b=BoxCRM5pLaRV9+ZwMI0WgJDc2lWR634KFW2JdsoLdLZbe1f6ho4h+EPWl38wa6J8Ix6OyA/jebFNudu5/M3j69fIK2vLRR5vjq+Ue5ssiJq2DlVo+yl1MpZzTAJdwlxa88VYV7ebpFD3Y5S1pvNNt8n+C17tQ4lOw2TBPOFRAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727862; c=relaxed/simple;
	bh=6PEsWTJf0Vop6Q+1C1+DQ9N0VfM6GSa6BS4JsqEp9/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxtVVjzGSbzXYTaAb3/zSgaCW2Eypfc5YB5oVwUECM07buOgtrqAMzuCpBIFsDDRaNNOSz3hKFwZrVAGNQKz+GvAvKUWqhKoo/vl8HwDni02CLNSzLUJVYUn1AT9FhtLSMwjtfGfv8kQrWM4j1teL4HnoSOrBvBLd7vwsgMtM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYcFeQad; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e7f68df436so114387fac.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 11:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767727859; x=1768332659; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ovwe6jVk+HZeAM9NHqCv6Ojkd+cynp9coM0xfvK8awk=;
        b=IYcFeQadWhTrNsMNNg4mriCUNzQijazkDaQR6pVwHYQX+14zo3lq6K38axWYZXkWfT
         Wd+myo0ONZw38YN+E4LcKyR++TROzJMYrLsGKbTsDNaDJFzH9qvMOo+S5pp5U793b+oY
         NsOps7sn81WOjGGU86Oe0Ku+PTPzEP7kT48mFVJUfbtPrXyindMf2uE7CLeTqY7yM1H/
         ZaiABGIP0LVbMytuTdCdnJE36cFvop3mDGfwdCneXx2hB/Ns1NWoscwwz+/oXrGWobc/
         oIrB1d5HLkiju7kf6Ij52pYhs9aUSgWuXzqhwhFkWbP2YIlRGfTgPXlaMjjrHoWXhN12
         vD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767727859; x=1768332659;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovwe6jVk+HZeAM9NHqCv6Ojkd+cynp9coM0xfvK8awk=;
        b=YWu+w23ZteMC21O+2HEFSeQno5s2EtSpoahDG1NdWgCHDqmKLiDPBNMHnyDyhTpxGT
         jFdfCce6eMIF3ZEXfVO94ztea8SDPTgicvQEsQKtN9WxDUEUZKCUJUT5WqhCePfs+ZtB
         gAGItx49t7TCEpgQPm7qZYl0MsxlHSvybYuX/+9vpnRT1558gWlvqeFyVJC4n91CJ629
         gMMigW0z9qzdkYJKpo9u50qIgVJ0UfCHAk+LAb3LAI7YHUM7CVsWEppME7P0cG+spmeP
         Nh1K7cPr3E/LweLjE9tzTZ65XDiknEqpfCvCL3acaGwgo7TQicHkLE5sC4+X10JP43sn
         O6Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVFdeRvg5frey1F9JR3WwmnObQUz6cK/0sZhBwrrY3SSmd/HYYgXHnvAgcOz33rZDw00DcHB9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdniu5+zqWbFp+3XdI5YW8MJJ63avKky/5c/vpEoWfkijHpcAx
	1voHspXDXOBF4xgvT89cfyfY5Cd46GEaMDsMhWM4ewIy1dNkCNZRt23cEMUp7Q==
X-Gm-Gg: AY/fxX4PkMn0vEY3OnzrQfC5eQUVMR+INvj3Hjyc+Idu07tjlOyWWgyufWbMRYoO1y2
	kyRog7ZR6+JaGyu0X0+qZwo7gYv1yUkASFmqY8iVfrdizseA2KjLSp4HWDJnPFnulPs59l1ix0N
	wqcB7bulDhMPtcbqZo6GkdA9K3WJswFJ5Xlp7vTDz4O28bsHWcEbjaHfCVVijNE5NyB4NekHq/+
	VBtZVNG92zjsOQGz7D4nqBtGK+/z+pjd4IA5lhRKAvpwLZndH9sVjC4Rh+ZTZUSSyUR7hXfu2uE
	Tmu8utAuPLjCBd7pZoY9rQyvFGTOnpLo4U36oefye5Xxev1c29//3jpIZO+iG0d/dDAB1L/Qzf8
	zM41qrTScMJdS2NkgiwbqAOfwl8TGgmZS2yWinPwY7b3lqxTN1u6L7X5Ts13qOhre/0vIAonw6y
	C5qTbdSpU=
X-Google-Smtp-Source: AGHT+IEbARtwYBCflrCWKTw53xNWRQrwwKMztLSlcqOR+PG0C4vOryHl1746rHcmK2MtQJpFKJixLQ==
X-Received: by 2002:a05:690c:ed5:b0:787:a126:5619 with SMTP id 00721157ae682-790a962f54emr28940977b3.11.1767721117146;
        Tue, 06 Jan 2026 09:38:37 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:6398:4432:5113:2b75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790ae603282sm5749857b3.13.2026.01.06.09.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:38:36 -0800 (PST)
Date: Tue, 6 Jan 2026 12:38:36 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Burak Emir <bqe@google.com>, Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] rust: bitops: fix missing _find_* functions on 32-bit
 ARM
Message-ID: <aV1InE2bnTLYnMAC@yury>
References: <20260105-bitops-find-helper-v2-1-ae70b4fc9ecc@google.com>
 <aVvu3zF2rYKR3XC0@yury>
 <CAH5fLgjtXHH40Pcw=ZoOKPzvJzDA8fohNtC6W6DsfkcE-6vtrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjtXHH40Pcw=ZoOKPzvJzDA8fohNtC6W6DsfkcE-6vtrQ@mail.gmail.com>

On Tue, Jan 06, 2026 at 10:03:10AM +0100, Alice Ryhl wrote:
> On Mon, Jan 5, 2026 at 6:03 PM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Mon, Jan 05, 2026 at 10:44:06AM +0000, Alice Ryhl wrote:
> > > atus: O
> > > Content-Length: 4697
> > > Lines: 121
> > >
> > > On 32-bit ARM, you may encounter linker errors such as this one:
> > >
> > >       ld.lld: error: undefined symbol: _find_next_zero_bit
> > >       >>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
> > >       >>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
> > >       >>> referenced by rust_binder_main.43196037ba7bcee1-cgu.0
> > >       >>>               drivers/android/binder/rust_binder_main.o:(<rust_binder_main::process::Process>::insert_or_update_handle) in archive vmlinux.a
> > >
> > > This error occurs because even though the functions are declared by
> > > include/linux/find.h, the definition is #ifdef'd out on 32-bit ARM. This
> > > is because arch/arm/include/asm/bitops.h contains:
> > >
> > >       #define find_first_zero_bit(p,sz)       _find_first_zero_bit_le(p,sz)
> > >       #define find_next_zero_bit(p,sz,off)    _find_next_zero_bit_le(p,sz,off)
> > >       #define find_first_bit(p,sz)            _find_first_bit_le(p,sz)
> > >       #define find_next_bit(p,sz,off)         _find_next_bit_le(p,sz,off)
> > >
> > > And the underscore-prefixed function is conditional on #ifndef of the
> > > non-underscore-prefixed name, but the declaration in find.h is *not*
> > > conditional on that #ifndef.
> > >
> > > To fix the linker error, we ensure that the symbols in question exist
> > > when compiling Rust code. We do this by definining them in rust/helpers/
> > > whenever the normal definition is #ifndef'd out.
> > >
> > > Note that these helpers are somewhat unusual in that they do not have
> > > the rust_helper_ prefix that most helpers have. Adding the rust_helper_
> > > prefix does not compile, as 'bindings::_find_next_zero_bit()' will
> > > result in a call to a symbol called _find_next_zero_bit as defined by
> > > include/linux/find.h rather than a symbol with the rust_helper_ prefix.
> > > This is because when a symbol is present in both include/ and
> > > rust/helpers/, the one from include/ wins under the assumption that the
> > > current configuration is one where that helper is unnecessary. This
> > > heuristic fails for _find_next_zero_bit() because the header file always
> > > declares it even if the symbol does not exist.
> > >
> > > The functions still use the __rust_helper annotation. This lets the
> > > wrapper function be inlined into Rust code even if full kernel LTO is
> > > not used once the patch series for that feature lands.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 6cf93a9ed39e ("rust: add bindings for bitops.h")
> > > Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> > > Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/x/topic/x/near/561677301
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >
> > Which means, you're running active testing, which in turn means that
> > Rust is in a good shape indeed. Thanks to you and Andreas for the work.
> 
> I've put together this collection of GitHub actions jobs that build
> and test a few common configurations, which I used to test this:
> https://github.com/Darksonn/linux
> 
> > Before I merge it, can you also test m68k build? Arm and m68k are the
> > only arches implementing custom API there.
> 
> I ran a gcc build for m68k with these patches applied and it built
> successfully for me.

Thanks, Alice! Added in -next for testing. I'm going to send PR with the
next -rc as it's a real build fix.

Dirk and everyone, please send your tags before the end of the week, if
you want.

Thanks,
Yury

