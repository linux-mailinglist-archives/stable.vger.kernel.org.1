Return-Path: <stable+bounces-132753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D52A2A8A240
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 17:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61271901071
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B1529E049;
	Tue, 15 Apr 2025 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1hNI3GnO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A59297A7A;
	Tue, 15 Apr 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729068; cv=none; b=ofn8AbLxuHLHXH3GoATtTve7FIW+0k2BtW+0rGJyBcaLUYj4ORAAB/nwp9ewpOqZQKpX/Ix3B7EAJkEGwBtUUlfuzZkNHN67pGhb3Vr0jw051N7fKuCJsGAwkT1M613KLCseNW9wHtg1SqmepEgjaatQ+BilwfAsrxIZDb69A3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729068; c=relaxed/simple;
	bh=Xu0Lfj3qVS490qwXsrOvCFELI/PgRTiNfF9fLZfjkzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKERleCsYY4I3Jjszul2E4IMvxdkZwpFTESL8BVXOSk2+cV4s0hyyNFicmLFpNh4Ao70LsGhtoRd2ebmXi6qz85f6IC9u1q1OwqA78lXl6NxsxZNHr+Z6s+6IGQ4alSQZALL++a6nPfJbLMRIuqjLnk4gm/QL1HnjCr9HJ7FXV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1hNI3GnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48216C4CEEB;
	Tue, 15 Apr 2025 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744729067;
	bh=Xu0Lfj3qVS490qwXsrOvCFELI/PgRTiNfF9fLZfjkzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1hNI3GnOkhzVmzLkPxnYfQGia7kt7cuxGPj7wZHxorvojkfPOA7vKN2R19WVqU2Hc
	 k0eusGy9+P7caDG59NrOnXjnVOtb6TwlJq8qV3sqJVuzL6HiqcYlDHqiySZv0dUOuD
	 Eo7WCWCFUiKKAhaDhTmuzFsvoxVVE/KFJLJJCjw0=
Date: Tue, 15 Apr 2025 16:57:45 +0200
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
Message-ID: <2025041537-refusal-suspense-3e7b@gregkh>
References: <20250413-rust_arm_fix_fw_abstaction-v3-1-8dd7c0bbcd47@gmail.com>
 <CANiq72kJ+tv-P6+Yq7Bg+J73q93m+EKV_4E-GR=sdY5KRgCs6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kJ+tv-P6+Yq7Bg+J73q93m+EKV_4E-GR=sdY5KRgCs6w@mail.gmail.com>

On Sun, Apr 13, 2025 at 10:21:01PM +0200, Miguel Ojeda wrote:
> On Sun, Apr 13, 2025 at 9:27 PM Christian Schrefl
> <chrisi.schrefl@gmail.com> wrote:
> >
> > The `FwFunc` struct contains an function with a char pointer argument,
> > for which a `*const u8` pointer was used. This is not really the
> > "proper" type for this, so use a `*const kernel::ffi::c_char` pointer
> > instead.
> 
> If I don't take it:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks, I'll take it now.

greg k-h

