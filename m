Return-Path: <stable+bounces-80738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40259903B4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D791C21488
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 13:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36064210183;
	Fri,  4 Oct 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0nEwFMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECBC156872;
	Fri,  4 Oct 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728047874; cv=none; b=PUpN0mtdTxYF3Pz587AbD58Ld2WcWbSGeCE8S3el7jUNJ7F+I8aH3S2R0EgT8rY7ZXuRK00i8cHNr69jPdmuPSO6JLXvWk/qTPdv6YatwXm78Um7Xp64emjw/7MleCYjTDTCDk4N9x2b6/Z56IHAM6Wz5CT682pag/CJEz125OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728047874; c=relaxed/simple;
	bh=+BMi8p2VPJ0k07UMh8XhjkiYB9Jq/ZpP3dhU9HbsOm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwah7mokKt8QmDP5pmaeNmb3Mbpid0fepMFi1W+rjtAmgFLXPOOwH77Opf71QVhISoF5781f9b/YwtYrkc+XKMEjhdFOZl9UnN5UsHrkpqIUZQJ3WjANUUPT0Y3g9qgB1DRTidxqoCh8A4YRNiQzd09JtS8C5nISS4nGSFluqQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0nEwFMn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E8BC4CEC6;
	Fri,  4 Oct 2024 13:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728047873;
	bh=+BMi8p2VPJ0k07UMh8XhjkiYB9Jq/ZpP3dhU9HbsOm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0nEwFMn2JKK5SEUmowprmHdY0IX/EbHdubE0S43srCgOjcwfyAiyvHHBKVD46t4x
	 tKwRlfT87Nhh9OOMLLEDu7xbcdkcw2Qa01o8b9ejCrajUqbNndau3H3q915tJD7GDL
	 wbrk32DWpLnj9zzmdgXtr/9JTqBnVrO2r03mSm5g=
Date: Fri, 4 Oct 2024 15:17:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: keithp@keithp.com, stable@vger.kernel.org, linux-usb@vger.kernel.org,
	syzbot+422188bce66e76020e55@syzkaller.appspotmail.com
Subject: Re: [PATCH] USB: chaoskey: fail open after removal
Message-ID: <2024100408-cedar-debug-5b28@gregkh>
References: <20241002132201.552578-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002132201.552578-1-oneukum@suse.com>

On Wed, Oct 02, 2024 at 03:21:41PM +0200, Oliver Neukum wrote:
> chaoskey_open() takes the lock only to increase the
> counter of openings. That means that the mutual exclusion
> with chaoskey_disconnect() cannot prevent an increase
> of the counter and chaoskey_open() returning a success.
> 
> If that race is hit, chaoskey_disconnect() will happily
> free all resources associated with the device after
> it has dropped the lock, as it has read the counter
> as zero.
> 
> To prevent this race chaoskey_open() has to check
> the presence of the device under the lock.
> However, the current per device lock cannot be used,
> because it is a part of the data structure to be
> freed. Hence an additional global mutex is needed.
> The issue is as old as the driver.

I'll take this, but really, the driver should not care about how many
times it is opened.  That change can happen later, I'll try to dig up
the device I have for this driver so that I can test it out...

thanks,

greg k-h

