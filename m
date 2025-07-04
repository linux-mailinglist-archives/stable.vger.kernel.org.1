Return-Path: <stable+bounces-160169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B400AF8E95
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 11:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FEB1BC5F32
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BFD29E0ED;
	Fri,  4 Jul 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ifJdvXwa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEA2BE65;
	Fri,  4 Jul 2025 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621396; cv=none; b=EocgS+m0t4NG+vzik8joUgZtzsmpkOfRMZpWPTdgp5V8wYffYNDH5cOLkeCGdQsgMeih2DSQAlEM6p9qE6RT9GvDsc20/zL67LDGSEOoir7MaSG8QkfCIEZLLXlY56ur+Mk0UeVuzil5LblJR/I2RYrODJ1hQ0IDm2en00Cms0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621396; c=relaxed/simple;
	bh=P3P7xCUdvGtcquxpwUfzH79QF42FdpWlBbIZMlYMj7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QggJ476phufgzm0qSjlgRT9rnNKPHWoE7YNBkuPfyYjuBGmH6alGmOKdoqBEy1hNWif79RPp+GMGcs1F1G7mKEKuWahly9fnJiYcw8HWg2glErO5livrX0f0YWOGUXmxCyo2mDOprwimm9MiMLQ2PbBlZrnw336mH1ZZEZXGLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ifJdvXwa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1F3C4CEE3;
	Fri,  4 Jul 2025 09:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751621396;
	bh=P3P7xCUdvGtcquxpwUfzH79QF42FdpWlBbIZMlYMj7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ifJdvXwaOFNhh/dKbR5AKvxKU58d6aiNogqDFamrZooJwHmhYRbgFGgrk3VhjRvHz
	 Fkvi7nXkeailGJhaVu/wGocm4zc83jF7YTiq5handzq0Tn9/tKn68/QGpGDZl0Fju8
	 O2QECQ5huYPde6ncEpgmVubPXFRgq4h2BZxXUJS4=
Date: Fri, 4 Jul 2025 11:29:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.15 250/263] drm/amd/display: Fix default DC and AC
 levels
Message-ID: <2025070416-amuck-mutual-b436@gregkh>
References: <20250703144004.276210867@linuxfoundation.org>
 <20250703144014.438570401@linuxfoundation.org>
 <c0e8caef-f8b8-433c-a697-9b808b2f87f3@kernel.org>
 <2025070411-trace-enrage-ac79@gregkh>
 <786942aa-3b8e-4b7c-90db-0e710e0674cb@kernel.org>
 <916ed6a6-a052-42ea-a694-b13ffa3a44c1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <916ed6a6-a052-42ea-a694-b13ffa3a44c1@kernel.org>

On Fri, Jul 04, 2025 at 11:17:15AM +0200, Jiri Slaby wrote:
> On 04. 07. 25, 11:14, Jiri Slaby wrote:
> > On 04. 07. 25, 11:06, Greg Kroah-Hartman wrote:
> > > On Fri, Jul 04, 2025 at 07:00:06AM +0200, Jiri Slaby wrote:
> > > > On 03. 07. 25, 16:42, Greg Kroah-Hartman wrote:
> > > > > 6.15-stable review patch.  If anyone has any objections,
> > > > > please let me know.
> > > > > 
> > > > > ------------------
> > > > > 
> > > > > From: Mario Limonciello <mario.limonciello@amd.com>
> > > > > 
> > > > > [ Upstream commit 8b5f3a229a70d242322b78c8e13744ca00212def ]
> > > > 
> > > > This is actually 8b5f3a229a70d242322b78c8e13744ca00212def squashed with
> > > > 4b61b8a390511a1864f26cc42bab72881e93468d -- why?
> > > 
> > > Ick, I don't know.  Let me go drop it now, good catch!  Let me go verify
> > > these other drm backports too, the drm stable patch mess is never fun...
> > > 
> > > Yeah, something went wrong with Sasha's backports, some of these didn't
> > > even have an upstream commit id in them :(
> > > 
> > > I've dropped this one, and the ones after this as they weren't correct,
> > > thanks for the review!
> > 
> > Actually, we have the two (8b5f3a229a+4b61b8a39) in our tree as they fix:
> > https://bugzilla.suse.com/show_bug.cgi?id=1236415
> 
> No, this one:
> https://bugzilla.suse.com/show_bug.cgi?id=1240650

Thanks, now both added, and I figured out the others that Sasha had
applied without git ids and then added yet-another-fix for those that
was also needed.

I'll go push out a -rc2 soon with all of these in them, thanks.

greg k-h

