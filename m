Return-Path: <stable+bounces-186246-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2220BE6DD1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 09:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F7835616DE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 06:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF67F310771;
	Fri, 17 Oct 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JLZw6nJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6830FC02;
	Fri, 17 Oct 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684308; cv=none; b=ZawKqbmc4Alu/+7ymNs3ZM+VrlM82TKYB5DzMPuvQ1cXWHgRBOeYrRTmjtwC2CZ0iGhPz2EYBmSiUsZKADa3t4oZtg/BLAndYRhNQWNJjUTHBBbq1GaBjpxjUh9rbbe06Ou3z6v6UGaCO2JaELRkpSB3Awec+KSBwdyFDIN5h5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684308; c=relaxed/simple;
	bh=txiS2fzRpAtZ3ixsn4X1uL9bpibNoFY5ICjDtzT2Y44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXcJd/uNhHSmeW0n9Z38sEcyEFMnDiGuORRvkWfLKGNn3J7x5ECHFqG3d8wb8m8jcqGUHt1d5hn7zUVgXcWDOOeo8lDDPr3RxtDR0LVfF2CLTHU72CoyKokVVQ4lYDRG2sU6Z9m4On3gekg/yKIOAu89y2s7mHFOiLJDxRxEMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JLZw6nJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB41C4CEE7;
	Fri, 17 Oct 2025 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760684308;
	bh=txiS2fzRpAtZ3ixsn4X1uL9bpibNoFY5ICjDtzT2Y44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLZw6nJa04q6Ze5DoquVEjZbCgQIosndmoIYhMVIbsTMjqnHELRnDlfoynml0ezop
	 6ld/XojkoOBBMPE1xCbkSh3FDNT370z+RoRbeOiyV/XPKTREwN2M3Ww+rxn773YKEC
	 I5syflvWHX0s7nOS+vZCbsTUgsaTkilSq398fgQA=
Date: Fri, 17 Oct 2025 08:58:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brian Norris <briannorris@chromium.org>
Cc: bhelgaas@google.com, stable-commits@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Patch "PCI/sysfs: Ensure devices are powered for config reads"
 has been added to the 6.6-stable tree
Message-ID: <2025101714-headstand-wasp-855c@gregkh>
References: <2025101627-purifier-crewless-0d52@gregkh>
 <aPEMIreBYZ7yk3cm@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPEMIreBYZ7yk3cm@google.com>

On Thu, Oct 16, 2025 at 08:15:46AM -0700, Brian Norris wrote:
> Hi,
> 
> On Thu, Oct 16, 2025 at 03:09:27PM +0200, Greg Kroah-Hartman wrote:
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     PCI/sysfs: Ensure devices are powered for config reads
> > 
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      pci-sysfs-ensure-devices-are-powered-for-config-reads.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Adding to the stable tree is good IMO, but one note about exactly how to
> do so below:
> 
> > Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> > rest of the similar sysfs attributes.
> > 
> > Notably, "max_link_speed" does not access config registers; it returns a
> > cached value since d2bd39c0456b ("PCI: Store all PCIe Supported Link
> > Speeds").
> 
> ^^ This note about commit d2bd39c0456b was specifically to provide hints
> about backporting. Without commit d2bd39c0456b, the solution is somewhat
> incomplete. We should either backport commit d2bd39c0456b as well, or we
> should adapt the change to add pci_config_pm_runtime_{get,put}() in
> max_link_speed_show() too.

I missed that "hint", you need to make it bindingly obvious as I churn
through the giant "-rc1 merge dump" very quickly as obviously those are
changes that were not serious enough to make it into -final :)

> Commit d2bd39c0456b was already ported to 6.12.y, but seemingly no
> further.
> 
> If adapting this change to pre-commit-d2bd39c0456b is better, I can
> submit an updated version here.
> 
> Without commit d2bd39c0456b, it just means that the 'max_link_speed'
> sysfs attribute is still susceptible to accessing a powered-down
> device/link. We're in no worse state than we were without this patch.
> And frankly, people are not likely to notice if they haven't already,
> since I'd guess most systems don't suspend devices this aggressively.

I'll gladly accept a fixed up patch for this, thanks.

greg k-h

