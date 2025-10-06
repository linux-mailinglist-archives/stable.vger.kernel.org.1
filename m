Return-Path: <stable+bounces-183409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356CBBD6D3
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 11:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D303A57EE
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C571C264F81;
	Mon,  6 Oct 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VA3uEPwF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640C189F5C;
	Mon,  6 Oct 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759742659; cv=none; b=CeK1Mq38rusfXazb/hRW3FirH9zQK2Bb1ZIWVP3eyTyaumt3v3hv6vC6ooKwV8XI/Hg+YEq+y+ielbrKkT2lT1xFY5Lc5B/nHoKTkwR3+GD7/+5KppK2I2t8VXnOkqvkioX1Ohvb5i9K30XKRrm8i5vp3QZeZq1IntG5SajsvjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759742659; c=relaxed/simple;
	bh=HQO3BghtODWv879KhWCgZnbHiA4tn37XW6G/0phmyiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut5BfhlVpUatK/ZR8WiVsBeQZePq2DH7ut/kdsoiNDQkjFbVIDFsBpouKls+r6ircMwiddauLJzXdxEi5gKl6fAVXBpDV7ZDUwTinTJjigL+NAPrgHUaoygPwwqBPl0XNOPhpdqeze8ZnTlqoauvTwrE5aabH0wEzZS7TspREWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VA3uEPwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654C2C4CEF5;
	Mon,  6 Oct 2025 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759742658;
	bh=HQO3BghtODWv879KhWCgZnbHiA4tn37XW6G/0phmyiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VA3uEPwFkNliMXoB/m6c7pfq6D1t9SI6qJhehWlhberWyJMjEggmJ5zXNZ8KXSgxp
	 OsmmLouSqojpfzzBZ67hp+0ZHnJc1wviJnsS0DnFFGXYn+y6jJQLkT/O3cjjyST6Id
	 UqH+b7kXINz76cn9gUtVG5MlwzCfNbegJGQX3fdQ=
Date: Mon, 6 Oct 2025 11:24:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>
Subject: Re: [PATCH] devcoredump: Fix circular locking dependency with
 devcd->mutex.
Message-ID: <2025100655-prankish-parking-9059@gregkh>
References: <20250723142416.1020423-1-dev@lankhorst.se>
 <20251003180052.wpx4d5mqs6tmmber@hu-mojha-hyd.qualcomm.com>
 <977e15c2-ad91-45c4-be99-0390ae7f8315@lankhorst.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977e15c2-ad91-45c4-be99-0390ae7f8315@lankhorst.se>

On Mon, Oct 06, 2025 at 11:11:01AM +0200, Maarten Lankhorst wrote:
> >> @@ -401,13 +424,20 @@ void dev_coredumpm_timeout(struct device *dev, struct module *owner,
> >>  
> >>  	dev_set_uevent_suppress(&devcd->devcd_dev, false);
> >>  	kobject_uevent(&devcd->devcd_dev.kobj, KOBJ_ADD);
> >> -	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
> >> -	schedule_delayed_work(&devcd->del_wk, timeout);
> >> +
> >> +	/*
> >> +	 * Safe to run devcd_del() now that we are done with devcd_dev.
> >> +	 * Alternatively we could have taken a ref on devcd_dev before
> >> +	 * dropping the lock.
> >> +	 */
> >> +	devcd->init_completed = true;
> >>  	mutex_unlock(&devcd->mutex);
> >>  	return;
> >>   put_device:
> >> -	put_device(&devcd->devcd_dev);
> >>  	mutex_unlock(&devcd->mutex);
> >> +	cancel_delayed_work_sync(&devcd->del_wk);
> >> +	put_device(&devcd->devcd_dev);
> >> +
> > 
> > Acked-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Thanks, through what tree can this be merged?

I can look into doing that after -rc1 is out.

thanks,

greg k-h

