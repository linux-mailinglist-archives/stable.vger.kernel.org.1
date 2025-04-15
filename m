Return-Path: <stable+bounces-132754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E24A8A24C
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 17:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C91A319011B5
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E702BE119;
	Tue, 15 Apr 2025 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NXfOtEg5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD12BE10B;
	Tue, 15 Apr 2025 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729143; cv=none; b=AANoE9ADUZC/M066R4aSUogTJEwnf6DhvF5o6jbtG2r8BOaVEw2ViaH+1TMIimoCA+MD4MXoNziK+zq7npOOaru6pnMNGaUHGG6S5qJCtqjkYASxJcoEdV/POHvm8s3G+BYsaJMitMDGUhHCU1LtmfMo2hKmCHtEfyKodGQSMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729143; c=relaxed/simple;
	bh=TBOwh/hCuJxSGzWw0YDqV+Q0VUxiPOw6ohSLltySmJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/BSkgAZB+c8Q7k1OZCLZrpJYsqXhxnae968LyPKTrsADzt/T1IjMtD/RVUbMg2M5Mz23HFLujtS0L5n8RPzwZBv6eLfN844EdAvXf9HYe0zSPXVAoG2tBIAlF7cYw9HA5gunVJmBdOgIbz5JqD83RcLUHSs2LUcCaRyXJ5Q33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NXfOtEg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DEEC4CEEC;
	Tue, 15 Apr 2025 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744729143;
	bh=TBOwh/hCuJxSGzWw0YDqV+Q0VUxiPOw6ohSLltySmJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXfOtEg5tjAsnTrT2t7RidtiBmknkimF3OsXWMRNC8fm5bPZX+GyfOvaxZ8FDbLaT
	 9F2gFacDgd6vrn1vSx3j57ThxJ69l+oKXfbksw46pyOHClWF/Ddp+vN9+NsMMD4zhL
	 u558xskXB2297+G31sv9dyyd6L9QzGstS32s/FJU=
Date: Tue, 15 Apr 2025 16:59:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] rust: Use `ffi::c_char` type in firmware abstraction
 `FwFunc`
Message-ID: <2025041551-cadillac-refutable-637a@gregkh>
References: <20250413-rust_arm_fix_fw_abstaction-v3-1-8dd7c0bbcd47@gmail.com>
 <CANiq72kJ+tv-P6+Yq7Bg+J73q93m+EKV_4E-GR=sdY5KRgCs6w@mail.gmail.com>
 <2025041537-refusal-suspense-3e7b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025041537-refusal-suspense-3e7b@gregkh>

On Tue, Apr 15, 2025 at 04:57:45PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Apr 13, 2025 at 10:21:01PM +0200, Miguel Ojeda wrote:
> > On Sun, Apr 13, 2025 at 9:27 PM Christian Schrefl
> > <chrisi.schrefl@gmail.com> wrote:
> > >
> > > The `FwFunc` struct contains an function with a char pointer argument,
> > > for which a `*const u8` pointer was used. This is not really the
> > > "proper" type for this, so use a `*const kernel::ffi::c_char` pointer
> > > instead.
> > 
> > If I don't take it:
> > 
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Thanks, I'll take it now.

Oops, it's already in the driver-core tree :)

