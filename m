Return-Path: <stable+bounces-20835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A4385BF3B
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E509A2818F4
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE64F6BB3A;
	Tue, 20 Feb 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aaYib0aX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60F43AD3
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441136; cv=none; b=RLvWFMx0NzsLh/ikdqoq0A6eRVJl3F0rb64CC53NUYH6d5E/fqbfbtDCd0vMid28H0qwLqfqQqjGeeDPA0u5ZG0RCNmFLWn+O4uPnbCbWihy0t6ZQ76tkeINUduCl43c308O8J+eweeXd3CVfewl8TE7vtvoqi1JEzEl+SmcKk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441136; c=relaxed/simple;
	bh=SXQuAz/r0LQReYMRL3pY1qlb7V9lh/QATpvVX/+cm/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljjDOszDfkC7AFMTyhltYpcLJHCcZrCUWBEW2dAH65PGYJKdCCdW5G/zBEjUuhVRXIzvytgUlNCYQbGLAMjImzRkPhu8sW3GaE9Nax7w3QsRtLTmKsWhu6RnxzmE7nw4qo1i58sbSmBGG8/pyv6fJiqeaxUtqhYggWXQHHdFhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aaYib0aX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE3EC433C7;
	Tue, 20 Feb 2024 14:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708441136;
	bh=SXQuAz/r0LQReYMRL3pY1qlb7V9lh/QATpvVX/+cm/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aaYib0aX41+aoIWwA4znbppyZ8a8o6g3IW2Nq9JWtW0SeljzxjWVmTbn7XE9WNXTu
	 HmoL4hMPxRvrBqjYiPVV9hx9YY3JGOXzS4HTNMuNcsXyxKybAzdnbhvMPb0AxJwCPR
	 r/JBAqByY/POfWCw2aU14zVmBoZ8VF1FRiaxorTc=
Date: Tue, 20 Feb 2024 15:58:53 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"Kiszka, Jan" <jan.kiszka@siemens.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"Ivanov, Petr" <petr.ivanov@siemens.com>
Subject: Re: [PATCH v2][5.10, 5.15, 6.1][1/1] hrtimer: Ignore slack time for
 RT tasks in schedule_hrtimeout_range()
Message-ID: <2024022019-donated-daringly-c9af@gregkh>
References: <20240220123403.85403-1-felix.moessbauer@siemens.com>
 <20240220123403.85403-2-felix.moessbauer@siemens.com>
 <2024022057-slit-herself-a4d8@gregkh>
 <89eef284bd0fb1f60dbfc62decd2a0438d436c6e.camel@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89eef284bd0fb1f60dbfc62decd2a0438d436c6e.camel@siemens.com>

On Tue, Feb 20, 2024 at 02:49:00PM +0000, MOESSBAUER, Felix wrote:
> On Tue, 2024-02-20 at 15:32 +0100, Greg KH wrote:
> > On Tue, Feb 20, 2024 at 01:34:03PM +0100, Felix Moessbauer wrote:
> > > From: Davidlohr Bueso <dave@stgolabs.net>
> > > 
> > > commit 0c52310f260014d95c1310364379772cb74cf82d upstream.
> > > 
> > > While in theory the timer can be triggered before expires + delta,
> > > for the
> > > cases of RT tasks they really have no business giving any lenience
> > > for
> > > extra slack time, so override any passed value by the user and
> > > always use
> > > zero for schedule_hrtimeout_range() calls. Furthermore, this is
> > > similar to
> > > what the nanosleep(2) family already does with current-
> > > >timer_slack_ns.
> > > 
> > > Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Link:
> > > https://lore.kernel.org/r/20230123173206.6764-3-dave@stgolabs.net
> > 
> > You can't forward on a patch without signing off on it as well :(
> 
> Ok, thanks for the info. I'll add the signoff and send a v3.
> 
> > 
> > And this is already in the 6.1.53 release, why apply it again?
> 
> I can't find it there and also the change is not included in linux-
> 6.1.y or 6.1.53. There is another commit referencing this patch (linux-
> 6.1.y, fd4d61f85e7625cb21a7eff4efa1de46503ed2c3), but the "hrtimer:
> Ignore slack time ..." patch did not get backported so far.
> I also checked the source of v6.1.y and could not find the related
> change. Which commit exactly are you referring to?

Ah, yes, that's my fault, my scripts picked up the full sha being
referenced there as normally that's not how anyone does it in a
changelog.

So it will be needed for 6.1.y, thanks!

greg k-h

