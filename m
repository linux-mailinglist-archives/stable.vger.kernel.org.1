Return-Path: <stable+bounces-194607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A510AC51D77
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923134E5FDB
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 11:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E393081C7;
	Wed, 12 Nov 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2j4SKZeb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B34257851;
	Wed, 12 Nov 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945382; cv=none; b=Wc6fPZqqjMJ7c6rsThcAwr8dBLXHt4WLG3M7BVzrdoLgW4Cznsd0gZCALHoeifr0cZz6rxTy1WSoyv2qk6CNyDNyhi+uX/7fRtI4cb1c7t/1o2oyW6shzsT5PKEGJBQ2XxVMmigp01MzDpMouyvN4cn+ZAPEQHxrThlnBBwm/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945382; c=relaxed/simple;
	bh=/u5MnjnF3/Bu8KkRAgxPegIr1lenIvjObOB7SUzMzFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMVwE9XTRKMRsP52+K/HzlJ9CwIjPT9Wz85Iy9GnI/5xgtbR7D6jIhu4u4ZE74yXQ3reD+SBzs2YKj1uLoUiRYz42jNiOrv7daECZGWMmpgmTGCCUp1COGiO7yQoXm8+1egpZfSZ/9pHefygYk0pKDpksAk0p+8HhuZmQfCJdH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2j4SKZeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77639C16AAE;
	Wed, 12 Nov 2025 11:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762945381;
	bh=/u5MnjnF3/Bu8KkRAgxPegIr1lenIvjObOB7SUzMzFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2j4SKZebb1k3Ets95RWpyujnTQgY4mn24TzJuDb5sk4zBq0BYOsV7g88Q9L/muWLQ
	 urqWLyLq1/JtUIsCirsnvbAe1UC6LrK+mUE5XRW6MSK4zj0JCz6JhyQIFpm1fMGEfG
	 YtMqRamUQrYD6ydGiWzSXEm/QklV3+la/7nzEWRg=
Date: Wed, 12 Nov 2025 06:03:00 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/3] rust_binder: fix unsoundness due to combining
 List::remove with mem:take
Message-ID: <2025111251-discern-secluded-4cfb@gregkh>
References: <20251111-binder-fix-list-remove-v1-0-8ed14a0da63d@google.com>
 <CANiq72kCxh=Zen_fRrU8dVffGpNtsfNwMO1agC+muHd8ixMTpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kCxh=Zen_fRrU8dVffGpNtsfNwMO1agC+muHd8ixMTpA@mail.gmail.com>

On Wed, Nov 12, 2025 at 11:22:25AM +0100, Miguel Ojeda wrote:
> On Tue, Nov 11, 2025 at 3:23 PM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> >       rust_binder: fix race condition on death_list
> >       rust_binder: avoid mem::take on delivered_deaths
> >       rust: list: add warning to List::remove docs about mem::take
> 
> Greg et al.: please let me know if you are not taking the last one
> together with the fixes (so that I pick it up). Otherwise, if you do:
> 
> Acked-by: Miguel Ojeda <ojeda@kernel.org>

I'll take all of these, thanks for the ack!

greg k-h

