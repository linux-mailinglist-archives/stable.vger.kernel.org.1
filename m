Return-Path: <stable+bounces-116493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837DAA36E16
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 13:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE087A1DC3
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 12:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F14B1AAE2E;
	Sat, 15 Feb 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jsdH3dqj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4E748D;
	Sat, 15 Feb 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739622847; cv=none; b=YXAagu96IcATis9RS5H8y26jNCdN3VXLD06RF79HBIpdwUGJwJgGItz2XtDvfiNsAahllkBDjsI8yIwDj0hihiLPImB8x7Vz6itu3n5gZ7Tv39HYT7LknznsWTTdaFoQk3vYmR7heGtlhTPEmhGN8y3sL056i/qWLiggGRWzySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739622847; c=relaxed/simple;
	bh=NnRZ74pVR86hV7lGrabOr8uvrPWBnexcNXQ4+Gj4un4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYyCg+SWZXv5nlxfbkg2U6hj7JFZPVnNMat+ow4SdQu30/jti6IxtiwSJ7GW/KVvzAZhwRF/gHfAsCXHm2iEOdmM2y6vAn5ujfZmibLGgMtNSvEVOPQivCnqHnfwxatM0f2Q0Q0UjLsrc9WSneZFFLKTVeaoBdgEY0TU2otXAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jsdH3dqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1C5C4CEDF;
	Sat, 15 Feb 2025 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739622847;
	bh=NnRZ74pVR86hV7lGrabOr8uvrPWBnexcNXQ4+Gj4un4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsdH3dqjBgyKQpZGu4eSmCTyOBbV6n8HhRO0RfAx8xWtu5cGcojyLCZorzTZ5xrum
	 UKk62Mff7INTEpuU6Asje8FMeb7vnW+XPxfdX78zfHZFdKZ6ds6ICucd3SQuIvphSj
	 8ae1NXoaqGGn6vLbyOIdHRjh3qWttl5Xw7AB16mk=
Date: Sat, 15 Feb 2025 13:34:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	Radoslav =?iso-8859-1?Q?Bod=F3?= <radoslav.bodo@igalileo.cz>,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [6.1.y] Regression from b1e6e80a1b42 ("xen/swiotlb: add
 alignment check for dma buffers") when booting with Xen and mpt3sas_cm0
 _scsih_probe failures
Message-ID: <2025021548-amiss-duffel-9dcf@gregkh>
References: <Z6d-l2nCO1mB4_wx@eldamar.lan>
 <fd650c88-9888-46bc-a448-9c1ddcf2b066@oracle.com>
 <Z6ukbNnyQVdw4kh0@eldamar.lan>
 <716f186d-924a-4f2c-828a-2080729abfe9@oracle.com>
 <6d7ed6bf-f8ad-438a-a368-724055b4f04c@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d7ed6bf-f8ad-438a-a368-724055b4f04c@suse.com>

On Sat, Feb 15, 2025 at 12:47:57PM +0100, Jürgen Groß wrote:
> On 12.02.25 16:12, Harshit Mogalapalli wrote:
> > Hi Salvatore,
> > 
> > On 12/02/25 00:56, Salvatore Bonaccorso wrote:
> > > Hi Harshit,
> > > 
> > > On Sun, Feb 09, 2025 at 01:45:38AM +0530, Harshit Mogalapalli wrote:
> > > > Hi Salvatore,
> > > > 
> > > > On 08/02/25 21:26, Salvatore Bonaccorso wrote:
> > > > > Hi Juergen, hi all,
> > > > > 
> > > > > Radoslav Bodó reported in Debian an issue after updating our kernel
> > > > > from 6.1.112 to 6.1.115. His report in full is at:
> > > > > 
> > > > > https://bugs.debian.org/1088159
> > > > > 
> > > > 
> > > > Note:
> > > > We have seen this on 5.4.y kernel: More details here:
> > > > https://lore.kernel.org/all/9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com/
> > > 
> > > Thanks for the pointer, so looking at that thread I suspect the three
> > > referenced bugs in Debian are in the end all releated. We have one as
> > > well relating to the megasas_sas driver, this one for the mpt3sas
> > > driver and one for the i40e driver).
> > > 
> > > AFAICS, there is not yet a patch which has landed upstream which I can
> > > redirect to a affected user to test?
> > > 
> > 
> > Konrad pointed me at this thread: https://lore.kernel.org/
> > all/20250211120432.29493-1-jgross@suse.com/
> > 
> > This has some fixes, but not landed upstream yet.
> 
> Patches are upstream now. In case you still experience any problems, please
> speak up.

What specific commits should be backported here?

thanks,

greg k-h

