Return-Path: <stable+bounces-49959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A979000B7
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 12:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5E21F25300
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90A15B99E;
	Fri,  7 Jun 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0SSi/mT5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2173468
	for <stable@vger.kernel.org>; Fri,  7 Jun 2024 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755822; cv=none; b=o5gU5igNcOBtZTEVJijy03KewqzYQGPeQpA0etqfZWZ6RnHSYRy7sDSRPfkXhfuLWXKb/XDIDqu/eppqQGZTBuqD6JQCTPxro+x8WhGmp/EOOMBCEpoMq8t5nfZEqWmt+XrrGFnXJCV4I4FnuxRctRBoPujQIREAVhBSXfSB/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755822; c=relaxed/simple;
	bh=OzEsMYgslb8+HI8J2oXKEIdbquntLkUaBvzB+ObWNU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxWZsWkvRmc8iUNihMPclHraSQlXTVnjP5kAZPUwvwemIdajWMviDRvHCTkwab+tr3iNUVg1gesDA+ZU+xoliomP5bl6F+tB9a7nbHk4M2FVpC+uW2UzK5ngTZ0OPsErr4srnoEf/RKZ1ye+5l8GNh2zkGm6YUnPwvCFmKb13dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0SSi/mT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0F1C2BBFC;
	Fri,  7 Jun 2024 10:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717755822;
	bh=OzEsMYgslb8+HI8J2oXKEIdbquntLkUaBvzB+ObWNU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0SSi/mT5VCXSK65AE7Fx26Sl+RQTAmumUIws4zMWZRZJLiR2Ut8pkxrro0U8tdMOX
	 w5NBd9gILxrDPv1EqKf61UIy98H5pmZ9aFOpgoBLDDKd4skjGeKmoAK/LhteGANSQK
	 WdL+e+Xino8PDjoHyMmCXKYFahvww+6y/XS33sWg=
Date: Fri, 7 Jun 2024 12:23:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: backport request
Message-ID: <2024060733-publisher-tingly-e928@gregkh>
References: <CAMj1kXE3OuzR3kcyn_3pr4M3=QaV4Dqj=X6StUnRk9gM-1MQaw@mail.gmail.com>
 <2024060602-reacquire-nineteen-57aa@gregkh>
 <CAMj1kXEpLeQWTPBXpapAmqax0KRSodjK6zUX8UWtdgJUkbf__Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEpLeQWTPBXpapAmqax0KRSodjK6zUX8UWtdgJUkbf__Q@mail.gmail.com>

On Fri, Jun 07, 2024 at 10:43:19AM +0200, Ard Biesheuvel wrote:
> On Thu, 6 Jun 2024 at 15:10, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, May 29, 2024 at 10:50:04AM +0200, Ard Biesheuvel wrote:
> > > Please consider commit
> > >
> > > 15aa8fb852f995dd
> > > x86/efistub: Omit physical KASLR when memory reservations exist
> > >
> > > for backporting to v6.1 and later.
> >
> > Now queued up,t hanks.
> >
> 
> Thanks.
> 
> I don't see it in v6.1 though - was there a problem applying it there?

Nope, it's right here:
	https://lore.kernel.org/all/20240606131701.442284898@linuxfoundation.org/

