Return-Path: <stable+bounces-206298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C900D03CBB
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 16:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4631D306C2F0
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD3544302D;
	Thu,  8 Jan 2026 10:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vdZ6HL2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BB42E010;
	Thu,  8 Jan 2026 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867065; cv=none; b=D53zYMqmazWyw2SAf8TXBwkr4K4BcefqgTVVq3sjulbmGrTfLMNm9CxiA8XtaOsuS63KVOSJgnYGW/GGM3cecdVJMAeEDWqDj8PNfFEFdrU/jPsqVAq6SprANJS6N8KPEj3EVg5gemwCwRyBmKRF2wzh6G4edRRovhpZ5APNccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867065; c=relaxed/simple;
	bh=JTIoFtxGDXJO3F5xPSMzSd+Nucb8pQ0hTaMoh3f/6N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AwavDTNpHfrsNIbmPJ7HD818MehmBNLgyCYngL/TCyBgAte1ugRJiTAVE+CsB8xS/b6dHRaYOp5VRLsBdTLxF4Lzjdp/RGc2i7qtfkI0hNYW5572mRNYPQaXbUn+Qp3cGcc99nO1OLsXACqNwJo7upz0SX+ANqCVe1gdcxHe1tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vdZ6HL2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16201C116C6;
	Thu,  8 Jan 2026 10:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767867061;
	bh=JTIoFtxGDXJO3F5xPSMzSd+Nucb8pQ0hTaMoh3f/6N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vdZ6HL2uEroMjwIYsozQd4pN7kLprzu55qEVBR3f5hCoy62AgmYOnvxWtSMtXx4ve
	 By+FmX/dmok2Jxw0d5DrUzfbG8BcDMXwNKRo89eW4Sd/VBJ82La6+NZ/6MYsiH1Fq/
	 cvPqI5jvv59bAJexRGCgYu+EHo8Sca2LdEkxosLI=
Date: Thu, 8 Jan 2026 11:10:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: stable@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: Re: [PATCH v6.12 0/4] sched: The newidle balance regression
Message-ID: <2026010851-achiness-clustered-2cac@gregkh>
References: <20251203112027.1738141-1-ajay.kaher@broadcom.com>
 <CAD2QZ9bGLRL5NyUak-=dDPyTkmrzu-22Q2tURfxUmM9Rs+c72Q@mail.gmail.com>
 <2025120310-likeness-subscript-f811@gregkh>
 <CAD2QZ9YieLCTC2Xmo_f3VDgyFOYTbOMbvW8QCWMoHjf6Co17nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD2QZ9YieLCTC2Xmo_f3VDgyFOYTbOMbvW8QCWMoHjf6Co17nQ@mail.gmail.com>

On Thu, Dec 04, 2025 at 10:36:02AM +0530, Ajay Kaher wrote:
> On Wed, Dec 3, 2025 at 6:46 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Dec 03, 2025 at 05:23:05PM +0530, Ajay Kaher wrote:
> > > Greg, following upstream patches will directly apply to v6.17, so I am
> > > not sending for v6.17:
> > >
> > > https://github.com/torvalds/linux/commit/d206fbad9328ddb68ebabd7cf7413392acd38081.patch
> > > https://github.com/torvalds/linux/commit/e78e70dbf603c1425f15f32b455ca148c932f6c1.patch
> > > https://github.com/torvalds/linux/commit/08d473dd8718e4a4d698b1113a14a40ad64a909b.patch
> > > https://github.com/torvalds/linux/commit/33cf66d88306663d16e4759e9d24766b0aaa2e17.patch
> >
> > Please don't use github for kernel stuff....
> 
> ok.
> 
> > Anyway, these are not in a -rc kernel yet, so I really shouldn't be
> > taking them unless the author/maintainer agrees they should go in
> > "right now".  And given that these weren't even marked as cc: stable in
> > the first place, why the rush?
> 
> Agree. No rush.
> 
> > Also, you forgot about 6.18.y, right?
> 
> Yes. However, upstream patches will directly apply till v6.17.

Sorry for the delay, now queued up.

greg k-h

