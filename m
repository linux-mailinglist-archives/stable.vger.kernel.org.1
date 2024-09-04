Return-Path: <stable+bounces-73065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5686B96C04D
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 16:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F5428ED9C
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB9E1DCB38;
	Wed,  4 Sep 2024 14:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A3Qc/M+g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF61DC04A;
	Wed,  4 Sep 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459825; cv=none; b=YfpHOyvmpwz+0Q9CL04o5lLsmY8d5qmnOr9DEDnITrQOWtyCGVJGZaBtn61Y3eLKe/JkfdszUVvaGXbBpvMVq+PBcNiruok63v/xAgbTQVXKO1IlgLixk2Aj4TM5NBuAKqUBX5JXcyRMP3oeVJA1yZw+f5uNruSRuwVKuGMb15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459825; c=relaxed/simple;
	bh=upyMFhK2PT2U7+0NWGDIv0m1IqeBZy+daOSAhTHxgec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f67753J6XhGs96XpIPZ8jinIX71Y8EzfVQ+b/+06S36qoreLkWHcepFag1kJ/5MVdjjJ3ahpVaPeylHeojpl8ETULU5U6NtNeZ6D/iNtzjHtiJA+KLUauuFsTbRHpNz+G4MO3SoZNMlj140fQxJD6D2g/SVBFQH95pmp0GNRPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A3Qc/M+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C84AC4CEC2;
	Wed,  4 Sep 2024 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725459825;
	bh=upyMFhK2PT2U7+0NWGDIv0m1IqeBZy+daOSAhTHxgec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A3Qc/M+gEmKz7lWfvOBFjTNaY0JATLI3xxWYhw9DIf7cxKEWTyNA1g/W1ILhwVeKd
	 DLqApFksvp/PPYuneJqwWioAP6pTolRgqxX3SxijUBHP9YjkiRAY+piN1nNhNZMjEp
	 eeLDk57jvbLgj7kzgwX66osETYWGSUNhFvqzAQ9I=
Date: Wed, 4 Sep 2024 16:23:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Narron <richard@aaazen.com>
Cc: Linux stable <stable@vger.kernel.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5.15 000/215] 5.15.166-rc1 review
Message-ID: <2024090413-unwed-ranging-befe@gregkh>
References: <8c0d05-19e-de6d-4f21-9af4229a7e@aaazen.com>
 <2024090419-repent-resonant-14c1@gregkh>
 <fc713222-f7b1-d1c0-2aa2-c15f42d3873e@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc713222-f7b1-d1c0-2aa2-c15f42d3873e@aaazen.com>

On Wed, Sep 04, 2024 at 05:48:09AM -0700, Richard Narron wrote:
> On Wed, 4 Sep 2024, Greg KH wrote:
> 
> > On Mon, Sep 02, 2024 at 03:39:49PM -0700, Richard Narron wrote:
> > > I get an "out of memory" error when building Linux kernels 5.15.164,
> > > 5.15.165 and 5.15.166-rc1:
> > > ...
> > > cc1: out of memory allocating 180705472 bytes after a total of 283914240
> > > bytes
> > > ...
> > > make[4]: *** [scripts/Makefile.build:289:
> > > drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o]
> > > Error 1
> > > ...
> > >
> > > I found a work around for this problem.
> > >
> > > Remove the six minmax patches introduced with kernel 5.15.164:
> > >
> > > minmax: allow comparisons of 'int' against 'unsigned char/short'
> > > minmax: allow min()/max()/clamp() if the arguments have the same
> > > minmax: clamp more efficiently by avoiding extra comparison
> > > minmax: fix header inclusions
> > > minmax: relax check to allow comparison between unsigned arguments
> > > minmax: sanity check constant bounds when clamping
> > >
> > > Can these 6 patches be removed or fixed?
> >
> > It's a bit late, as we rely on them for other changes.
> >
> > Perhaps just fixes for the files that you are seeing build crashes on?
> > I know a bunch of them went into Linus's tree for this issue, but we
> > didn't backport them as I didn't know what was, and was not, needed.  If
> > you can pinpoint the files that cause crashes, I can dig them up.
> >
> 
> The first one to fail on 5.15.164 was:
> drivers/media/pci/solo6x10/solo6x10-core.o
> 
> So I found and applied this patch to 5.15.164:
> [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)

What is the git commit id of that change?  I can't seem to find it.

> Then the next to fail on 5.15.164 was:
> drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o

What .c file is this happening for?

thanks,

greg k-h

