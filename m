Return-Path: <stable+bounces-73605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A79696DAC6
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 15:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300751F21421
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 13:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DC119DF43;
	Thu,  5 Sep 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gAQBkSHI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611119D891
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725544157; cv=none; b=YNoxV9f9oU6g03uuDJd7yOQ4WvDUNuDJL3pJOIqEWLAoYTv/TFMn3v3LijzQuuPoVQr8aoTxifqXNFovaImVtwg2UP6oQNaNtCigkTgX+9v8JlR0bmje41+Iiodi+KJQkRx/XqGkecKxWqsgi7+ZlbCnhXrYQ9dD/4pTDTYg5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725544157; c=relaxed/simple;
	bh=LL6kx6gnwTS9GRQRN5p194tBfC1yDnR4bRNil7zEfR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZLIQmIfFSKmAJTWyQ4QDEHKPD+rd/4N8vyYvkmJoRdyj2JzydJnMG8ZtFpC+LjuYPvj1sxZ02+qC57BNzR0tr/U69YYdzttQ4KAO76fmGWOPdiTKDD1FYVNj6Y9olNmq0nRdSqxcFe2srJGGygeGf+RIbZlBNbzFkmqBqYoV+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gAQBkSHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCD6C4CEC3;
	Thu,  5 Sep 2024 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725544157;
	bh=LL6kx6gnwTS9GRQRN5p194tBfC1yDnR4bRNil7zEfR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gAQBkSHIF8Cp+SydugIUMDOfiGwhDofiVXbry+VlYI0p3L9OPftNczBBZz/kGXBPG
	 mNHAoq3d6uF1ukdVjJC+016WHtyT5t06ZftOEc5d7tjNRg1G9zhXxqvPT1C6lkJ5Ib
	 KGPDhvVVvXzwOul8xV7NwOqF/c+sJS2JS2Lum3mU=
Date: Thu, 5 Sep 2024 15:49:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Hillf Danton <hdanton@sina.com>, alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2 4.19.y] ALSA: usb-audio: Sanity checks for each pipe
 and EP types
Message-ID: <2024090557-hurry-armful-dbe0@gregkh>
References: <76c0ef6b-f4bf-41f7-ad36-55f5b4b3180a@stanley.mountain>
 <599b79d0-0c0f-425e-b2a2-1af9f81539b8@stanley.mountain>
 <2adfa671-cb11-4463-8840-a175caf0d210@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2adfa671-cb11-4463-8840-a175caf0d210@stanley.mountain>

On Thu, Sep 05, 2024 at 04:34:45PM +0300, Dan Carpenter wrote:
> Sorry,
> 
> I completely messed these emails up.  It has Takashi Iwai and Hillf Danton's
> names instead of mine in the From header.  It still has my email address, but
> just the names are wrong.
> 
> Also I should have used a From header in the body of the email.
> 
> Also the threading is messed up.
> 
> Will try again tomorrow.

It looks good to me, now queued up.

thanks,

greg k-h

