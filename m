Return-Path: <stable+bounces-41720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7F08B599B
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9232B2F9CB
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D5B71B24;
	Mon, 29 Apr 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lnexAkSI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCA7172F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396352; cv=none; b=p2taeUTFTXPiag32+xL38fRchbFHx2uANg5bsygudZjKEW104oSgh4IsztexxQ7y7yUaPzaA6EEOMISDrKF8IgGaBDrotojUf7NQ2DlSalqvFd1MWcIbg07++/ksOGs+R80HawcpWAcFcyD2jh5Cefnlu/WrOl08W/UmHMqJEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396352; c=relaxed/simple;
	bh=pUN1LLUS04uECEDGh/sUavyuQOugzQekov9nUKETC84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8ZMta8zMjoBiPWVbwm8wlQ1xrlnImxoZZXVdp86LfsURK0ESzjo4Uxd865o3NzuKBDKpGa/paN2jrDehVrbDuT0jPbqY1xaHJUV5cU+aelpWMhSB8jYYhTC39PAcbt+fg8lNsZWfxLLiCPmxt49uAD7GOmt9BlWhB2Seex/FN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lnexAkSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D806AC113CD;
	Mon, 29 Apr 2024 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714396352;
	bh=pUN1LLUS04uECEDGh/sUavyuQOugzQekov9nUKETC84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lnexAkSIsbhTRGm8uAZgK+JeA8simn9zFF/2bPw0ffR3Ye9hSr5eqce+OZCxyl9qM
	 UeJbosCPDfy96kxZiieyAdeext7GDbXwOClg6OMaczXNeynz/lkpXFW0oF7Vnb9mx5
	 rQokBGeqt+RW9mofWCcz+5roiC0Hyl7GVn04TZhk=
Date: Mon, 29 Apr 2024 15:12:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
	gary@garyguo.net, julian.stecklina@cyberus-technology.de,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] kbuild: rust: force `alloc` extern to
 allow "empty" Rust" failed to apply to 6.1-stable tree
Message-ID: <2024042951-coaster-parasail-a66c@gregkh>
References: <2024042909-whimsical-drapery-40d1@gregkh>
 <CANiq72ndLzts-KzUv_22vHF0tYkPvROv=oG+KP2KhbCvHkn60g@mail.gmail.com>
 <2024042901-wired-monsoon-010b@gregkh>
 <CANiq72nLGum-AqCW=xfHZ5fNw5xQ+Cnmab3VZ+NeHEN1tSNpzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nLGum-AqCW=xfHZ5fNw5xQ+Cnmab3VZ+NeHEN1tSNpzw@mail.gmail.com>

On Mon, Apr 29, 2024 at 02:22:13PM +0200, Miguel Ojeda wrote:
> On Mon, Apr 29, 2024 at 1:37 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > That was, but you also say:
> >         Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
> > which is in 6.1, so what am I supposed to believe?
> >
> > Hence the email :)
> 
> Ah, I see. I thought the annotation "overrides" what could be found
> automatically via the `Fixes`.

When things are confusing, I punt and ask for what to do, especially
because people put commit ids in Fixes and don't always know how far
back those commits really were applied to.

thanks,

greg k-h

