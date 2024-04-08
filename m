Return-Path: <stable+bounces-36336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257C489BB4E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 11:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8AC1F21DBB
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 09:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19163BBDD;
	Mon,  8 Apr 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MGP6Mtr7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87A64595C;
	Mon,  8 Apr 2024 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567555; cv=none; b=FzIwBmMrzPxkCB+CEl4eZkAbBN8yA/tywq5GshI41Kj38+/K8rgu7ISHjhpmdmWFqPW/AjEDcr1bmFVJCP4mesoF/hLxcRXmNQowFAeseatE8xLEfWU0eTKpkW1pRPzVKScaVrJBps6aZvOU7ZGzmULuZZsQ7YdLBdqFCvvkOJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567555; c=relaxed/simple;
	bh=pdGjtxbx8UX0wR0m8bLXc3/x6v+AO9XEEFCO4MQ6ZDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPHlKL7UynuJxfPq8Ovb8yP3CvcLG0+VUjND+1E+J5xmCQpcxLCl//e+yeLM6o4DgBVWnwNcq7rGqd3v7Y+6OxahIwH9b6W+GXLrLgV+7if6PYczjQhu+HE2d7AmU58Ro75b+zDryXK0Lsf4j3KhIdawDc5MSLnqzxhNrZLGE4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MGP6Mtr7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57CFAC433C7;
	Mon,  8 Apr 2024 09:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712567555;
	bh=pdGjtxbx8UX0wR0m8bLXc3/x6v+AO9XEEFCO4MQ6ZDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MGP6Mtr7hpKO2cw7DJ8qlSD9rh2qeKrih06FBrA+AACUHw35YWtrxDQQJamyKTwll
	 c5ui3M4g9xTzqtqoKS3dGBc4ozDyv932/PhiziwuHtfTUJQCh8FdpxUA4n37afhROj
	 IQoshuyXOl/3wkzmLPIUUYNCopYbvUjs8z9EVuRA=
Date: Mon, 8 Apr 2024 11:12:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: Patch "ASoC: tas2781: mark dvc_tlv with __maybe_unused" has been
 added to the 6.8-stable tree
Message-ID: <2024040821-moonlike-bagful-df6d@gregkh>
References: <20240407201311.1155107-1-sashal@kernel.org>
 <890d28a0578a42333c2f63b5feb086bd8d1c98e9.camel@irl.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <890d28a0578a42333c2f63b5feb086bd8d1c98e9.camel@irl.hu>

On Sun, Apr 07, 2024 at 10:31:21PM +0200, Gergo Koteles wrote:
> Hi,
> 
> On Sun, 2024-04-07 at 16:13 -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     ASoC: tas2781: mark dvc_tlv with __maybe_unused
> > 
> > to the 6.8-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      asoc-tas2781-mark-dvc_tlv-with-__maybe_unused.patch
> > and it can be found in the queue-6.8 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> 
> Is this necessary for stable? It only fixes a W=1 build warning.

Good point, now dropped, thanks for the review!

greg k-h

