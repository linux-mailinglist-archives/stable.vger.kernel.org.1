Return-Path: <stable+bounces-184232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52744BD3378
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F212634392D
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E536307AE8;
	Mon, 13 Oct 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KOlefu5k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80251547D2;
	Mon, 13 Oct 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362383; cv=none; b=Ya97ZdG343RaGo4vvvC/xLkEobUpKIj7SShaPHpWyW1Bfnt4OOGldhlZTiatjhWjKGCMG52fGVfDWYynRJoL8kgJp6gKYn7nEC8dqjqs9xXruUT8B4rHlaBZrOw5dZXeJ+B0S3/SIeNETtJXDXyOoiYzumAxFNWnd/YwEeFeDxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362383; c=relaxed/simple;
	bh=DatnOKqJ2fnUJmlSe5SILMkuuoHPEqRsg4UupK82IlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6IzKaZAIJMz9QMZZnOBS/JDzn/O4DVyRE3FhNsw8QwMb0c5hQfJSwXqOgBhmb93IgI0FmsH57C/fiMcp7yOnznlepvZEsHgH5nYjwRRCFzW7LwIQuleILUnLP1AIS3xS1YsZlslig8lY903FfQF9QxvBHSRpig32VhCp4z4eNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KOlefu5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C119C4CEE7;
	Mon, 13 Oct 2025 13:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760362383;
	bh=DatnOKqJ2fnUJmlSe5SILMkuuoHPEqRsg4UupK82IlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KOlefu5kmZHavDQselQYXEIXk6mTvxWRjX/B/sLANfveTxO8iTvlmXPm9NLbaxhRA
	 UWNyDklYd3G+AgO+V3ziaE/vZW3LHt4h6cTNgeS/6OR1jqNZxwL1JEIiwXFJOKclXr
	 WKkS5+TSc+RTf8kxFHtVJ7F1OFi3V8F0kRnc0VB8=
Date: Mon, 13 Oct 2025 15:33:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Patch "PCI: Preserve bridge window resource type flags" has been
 added to the 6.17-stable tree
Message-ID: <2025101348-conjuror-drapery-9fc1@gregkh>
References: <20251012141317.2894025-1-sashal@kernel.org>
 <78ea57b6-5bc8-b357-c37c-bd327785e825@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78ea57b6-5bc8-b357-c37c-bd327785e825@linux.intel.com>

On Mon, Oct 13, 2025 at 12:11:01PM +0300, Ilpo Järvinen wrote:
> On Sun, 12 Oct 2025, Sasha Levin wrote:
> 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     PCI: Preserve bridge window resource type flags
> > 
> > to the 6.17-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      pci-preserve-bridge-window-resource-type-flags.patch
> > and it can be found in the queue-6.17 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Hi Sasha and other stable maintainers,
> 
> While I agree the assessment that this is stable material, could we 
> postpone queueing to stable a bit more? This change has relatively high 
> regression potential and high impact for individual system that regresses, 
> and is complicated change no matter what already given the diffstat alone.
> 
> So try e.g. after 6.18 is released would seem more prudent for me as it 
> would give more time to iron out problems in the rc-phase before any 
> stable sees this change.

Ok, now dropped.

thanks,

greg k-h

