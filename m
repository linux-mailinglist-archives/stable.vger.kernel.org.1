Return-Path: <stable+bounces-38054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E18A0993
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39D0B22A0B
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 07:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E4013DBB1;
	Thu, 11 Apr 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H9FiktJx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676D2032C
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820127; cv=none; b=YG6WpN14nH70TzlxKwHDTv6IrHwG0FAgMW12060rIptTZr4ju9rqqUIgDCXoh5VKQtVXJrSOLNRiJDpxicSujljOsJj0G4WO4fNWT8ksLAuBUKl6q29h3lmNncjVQIIM26R8OiFhu+0JilpqCTBS8w3vuucwdC1WckBnj7LaSNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820127; c=relaxed/simple;
	bh=7y48VHQL6EawnGE/bpdvuH9OC0KhFGfWCh+oPp4QTBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGQey7oPOToFHsBrv5gLUUcg2zcHwAOaoI8DoFPO59wAPfCrEyCRTOkEjAg4h523GIIUJzC76jHR91W8f6V4aO6IycO6Es0aL6SXA0/KDorGY7kywZIjKm5Qm16jS2/glz11NeE4SYGC5LBJfBENlGiyKfjjRWmd1dO8IvQMFzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H9FiktJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CFBC433F1;
	Thu, 11 Apr 2024 07:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712820127;
	bh=7y48VHQL6EawnGE/bpdvuH9OC0KhFGfWCh+oPp4QTBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H9FiktJxdHQBBG8iLUit/eafEkxh+1GW7prYd5QJSPFFYzsIXayfTzJ19GS9dhOEg
	 T3QJ1COtZIStI687CGm4xd9EBvPhKhMAVfn0nZTVlkaLZ1Gk4VOe/fuQ07W/dbF3f3
	 WFgtodcjel/mC60sSsZNQmx0COo6hdH44j2j5u90=
Date: Thu, 11 Apr 2024 09:22:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Leah Rumancik <lrumancik@google.com>
Subject: Re: [PATCH 6.1 0/6] backport xfs fix patches reported by
 xfs/179/270/557/606
Message-ID: <2024041144-curly-unscrew-bbb0@gregkh>
References: <20240403125949.33676-1-mngyadam@amazon.com>
 <20240403181834.GA6414@frogsfrogsfrogs>
 <CAOQ4uxjFxVXga5tmJ0YvQ-rQdRhoG89r5yzwh7NAjLQTNKDQFw@mail.gmail.com>
 <lrkyqh6ghcwuq.fsf@dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com>
 <2024040512-selected-prognosis-88a0@gregkh>
 <CAOQ4uxg32LW0mmH=j9f6yoFOPOAVDaeJ2bLqz=yQ-LJOxWRiBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg32LW0mmH=j9f6yoFOPOAVDaeJ2bLqz=yQ-LJOxWRiBg@mail.gmail.com>

On Fri, Apr 05, 2024 at 12:55:41PM +0300, Amir Goldstein wrote:
> On Fri, Apr 5, 2024 at 12:27 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Apr 04, 2024 at 11:15:25AM +0200, Mahmoud Adam wrote:
> > > Amir Goldstein <amir73il@gmail.com> writes:
> > >
> > > > On Wed, Apr 3, 2024 at 9:18 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > >> To the group: Who's the appropriate person to handle these?
> > > >>
> > > >> Mahmoud: If the answer to the above is "???" or silence, would you be
> > > >> willing to take on stable testing and maintenance?
> > >
> > > Probably there is an answer now :). But Yes, I'm okay with doing that,
> > > Xfstests is already part for our nightly 6.1 testing.
> 
> Let's wait for Leah to chime in and then decide.
> Leah's test coverage is larger than the tests that Mahmoud ran.

Ok, I'll drop these from my review queue now, when they are "good
enough" can someone resend them please?

thanks,

greg k-h

