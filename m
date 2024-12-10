Return-Path: <stable+bounces-100437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B619EB324
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 15:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0119E164513
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7C1B394F;
	Tue, 10 Dec 2024 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T6Wnr/Nk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95871B219F;
	Tue, 10 Dec 2024 14:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840753; cv=none; b=LJZmt0Xx7/5E31+p6AyNfEZsylSIAi9IItcqxYtWPAew7+qEemERlK5bsYaH09qzlBTF5Zu17+HRR1S3TvzufBzSU5c11U7ivPRccBvENyCk84qW8Ug6hFjro5EyCEf1QrClsEP12OWRMrd7FTJza2+HIa1skYoi/1Kp3K7XLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840753; c=relaxed/simple;
	bh=mlDGfhaWS1q8ZGab27Xs3j9ugz6feCvic5MUD0SxWUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqS34335gl5m1YHgI3JiXq3AD2NCzV9Hj6Lyqrv43B6+8tzzU6zMnueIPIfOpAhPBd2MP+n1dZ1JM3gMRfAsf/L1nx1K+34MbLI5pB33dQAKGUppKy0dkJg6wRLx/2ij0creKDhpzk6GnjyPdYV/WpBik+M0rjyyRWFAh1L1TuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T6Wnr/Nk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB31C4CEDF;
	Tue, 10 Dec 2024 14:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733840752;
	bh=mlDGfhaWS1q8ZGab27Xs3j9ugz6feCvic5MUD0SxWUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6Wnr/Nk3W+3py0cN+M2G6SP4IVRZ2JlKZzADfNSNiszW1l+u62WdN11yqHbM0qYa
	 KjK/AgTlhAAsz7jLsxCeIRLyZm5HzXHnrh+O1fNXZDA5/ha63VDZ7zB0Yd+kATftcD
	 tQZLuC41VXm77LA6/xGXxmeNZV9RAtGCwIm+7SBw=
Date: Tue, 10 Dec 2024 15:25:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: quic_jjohnson@quicinc.com, kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
Message-ID: <2024121054-pregnant-verse-d8d5@gregkh>
References: <CGME20241208152338epcas5p4fde427bb4467414417083221067ac7ab@epcas5p4.samsung.com>
 <20241208152322.1653-1-selvarasu.g@samsung.com>
 <6b3b314e-20a3-4b3f-a3ab-bb2df21de4f5@samsung.com>
 <2024121035-manicure-defiling-e92c@gregkh>
 <e3f45175-a17d-4b88-b6e4-5c75e91132be@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3f45175-a17d-4b88-b6e4-5c75e91132be@samsung.com>

On Tue, Dec 10, 2024 at 07:41:53PM +0530, Selvarasu Ganesan wrote:
> 
> On 12/10/2024 3:48 PM, Greg KH wrote:
> > On Tue, Dec 10, 2024 at 03:23:22PM +0530, Selvarasu Ganesan wrote:
> >> Hello Maintainers.
> >>
> >> Gentle remainder for review.
> > You sent this 2 days ago, right?
> >
> > Please take the time to review other commits on the miailing list if you
> > wish to see your patches get reviewed faster, to help reduce the
> > workload of people reviewing your changes.
> >
> > Otherwise just wait for people to get to it, what is the rush here?
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Hi Greg,
> 
> 
> There is no rush. I understand that the review will take time and I 
> apologize for any inconvenience caused by sending the reminder email.

Great, during that time, please do some patch reviews of the changes on
the mailing list to help us out.

thanks,

greg k-h

