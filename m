Return-Path: <stable+bounces-163593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E3B0C5AF
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828A41AA3F6A
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C572D9ED7;
	Mon, 21 Jul 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GlZWQYyl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815602D8DD6
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106339; cv=none; b=gVwFhgqeVY/a9qkMQmTtwwJwCipzBmvxukWmsK+tw+kaCag3huh824FDCktyR6S4OIbtE+sqng5tGkVMFYVLQoEUSPBMRlzrRsuCoDSzucqHXCP2haumVhB//V1nSFQ+man8zNphZUnuFBwbZA0hbFMM5xPnKeAxJP1W+6xhbVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106339; c=relaxed/simple;
	bh=vQDAl2sBJCladK86Q5kacRtPVwD8fhPX2F6rpjVBFQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2Rvs1c1NAAsLECpfKh6E1n+PSsjhWxZDpbzsR1pMVic4T38MnqY+7aH09lHcraU3J6SoyncAk1VAhmU2U1/F9uLWjJgEpMxaiCTy6QR7JxzvTUPhuR9uJ3hWsdT3xdFfecBGakOgOwqxHaTtFyc099U9BN2X2wYbABNmV2kLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GlZWQYyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6D5C4CEF7;
	Mon, 21 Jul 2025 13:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753106339;
	bh=vQDAl2sBJCladK86Q5kacRtPVwD8fhPX2F6rpjVBFQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlZWQYylTN6b2AAqMRM8kyLUgx9ts+GrtuxGvfvz8kQT5odRI3A2FfTbTHqxRjC05
	 0dTqSmzngoc3QxLAA1LjOuZtd+W6s6OUY7bS/u74k8QXqRknQ3sSOdyJVMe1hCd6PX
	 HhEwAHo5KXZT8Mnr005bMpf+ssgiUndAXgLGfIjE=
Date: Mon, 21 Jul 2025 15:58:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus =?iso-8859-1?Q?Bl=F6chl?= <markus@blochl.de>
Cc: stable@vger.kernel.org
Subject: Re: Backport a5a441ae283d ("ice/ptp: fix crosstimestamp reporting")
Message-ID: <2025072127-commotion-relapsing-900d@gregkh>
References: <g2bzkfszeaajy4ehjodyg646fvgjih3gesgrq4duhoqcnkdbef@dmquxweqdzwq>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <g2bzkfszeaajy4ehjodyg646fvgjih3gesgrq4duhoqcnkdbef@dmquxweqdzwq>

On Wed, Jul 16, 2025 at 11:08:58PM +0200, Markus Blöchl wrote:
> Hi Greg,
> 
> please consider backporting
> 
>     a5a441ae283d ("ice/ptp: fix crosstimestamp reporting")
> 
> into linux-6.12.y
> 
> It fixes a regression from the series around
> d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")
> which affected multiple drivers and occasionally
> caused phc2sys to fail on ioctl(fd, PTP_SYS_OFFSET_PRECISE, ...).
> 
> This was the initial fix for ice but apparently tagging it
> for stable was forgotten during submission.
> 
> A similar fix for e1000e can be found here:
> 
> Link: https://lore.kernel.org/lkml/20250709-e1000e_crossts-v2-1-2aae94384c59@blochl.de/
> 
> The hunk was moved around slightly in the upstream commit 
> 92456e795ac6 ("ice: Add unified ice_capture_crosststamp").
> Let me know if you therefore want a separate patch,
> I just didn't want to to steal the credits here.

Please send a properly backported patch and we will be glad to queue it
up that way.  As-is, it does not apply cleanly.

thanks,

greg k-h

