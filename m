Return-Path: <stable+bounces-161453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E139EAFEA7F
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 15:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B71174747
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A428C2D6;
	Wed,  9 Jul 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nWiPE0p3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257892874E0
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 13:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068508; cv=none; b=CEtXdvbf/VV6jQVuBBhM7b/hOlOi2OmntzOSsUhNdjvMC6LQfTcjjxgVz/pp41LtKw9ba0V82VEiHNipoZEiss+CLyrr4DO9VMVeZGGh1CPwN/nvDjOmfBlDP/WwxS7lVj7RnKNfPKe7a1a3A1n9koWyOwuzCCeHPZoO8oUwWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068508; c=relaxed/simple;
	bh=uVkeISDeNrIS8hoBic1aQDqms12RJu1n3vMPDw+cq/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFyCaI/V10l3pQ3FZgPFVFCbG/oXdVZR2vyLLe3WB/3WgwAb+OGWX1WxxQHbNPIgkmWFBNN/WKgOVwHALCoOkUmBF/xfgmK3gqVKpb7L0pBDfQWbc9lTmt1v2XGwA6AIkVVkcuth9L5O/IPzBkfy+HRWTOPwWjRDnGwrwU/+be4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nWiPE0p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48119C4CEEF;
	Wed,  9 Jul 2025 13:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752068507;
	bh=uVkeISDeNrIS8hoBic1aQDqms12RJu1n3vMPDw+cq/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWiPE0p3+Sl/Vd4m+mESDEQuSU5+Cm7LHgBUtR5+8B3VlP4rV+xSCVh2M9ly+UhSG
	 ncwmP2DUhSJVNJIfLX5wGJKVSm4W0uw2v7i6RBty/8j6Ov7hSWFHPf7Mra9pUBxdXm
	 VdY37kyC8TU35QKnxzDK26zpT9PKdwdqRf7wzaqE=
Date: Wed, 9 Jul 2025 15:41:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>
Cc: stable@vger.kernel.org, luca.ceresoli@bootlin.com,
	olivier.benjamin@bootlin.com, thomas.petazzoni@bootlin.com
Subject: Re: Backport perf makefile fix to linux-6.6.y
Message-ID: <2025070955-discover-tree-644c@gregkh>
References: <DB7G4ZS920XB.1I7M44B53YY6Y@bootlin.com>
 <2025070906-john-uncouple-3760@gregkh>
 <DB7KBHKKHY3R.OG18BA9316QV@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7KBHKKHY3R.OG18BA9316QV@bootlin.com>

On Wed, Jul 09, 2025 at 03:35:34PM +0200, Alexis Lothoré wrote:
> On Wed Jul 9, 2025 at 12:39 PM CEST, Greg KH wrote:
> > On Wed, Jul 09, 2025 at 12:19:01PM +0200, Alexis Lothoré wrote:
> >> Hello stable team,
> >> 
> >> could you please backport commit 440cf77625e3 ("perf: build: Setup
> >> PKG_CONFIG_LIBDIR for cross compilation") to linux-6.6.y ?
> >> 
> >> Its absence prevents some people from building the perf tool in cross-compile
> >> environment with this kernel. The patch applies cleanly on linux-6.6.y
> >
> > Is this a regression from older kernels that was broken in 6.6.y, or is
> > this a new feature?  If a new feature, why not just use perf from a
> > newer kernel version instead?
> 
> I manage to build perf with a 5.15.x kernel, while I can't in 6.6 (with the
> same parameters), so yes, I would call it a regression.
> To clarify my wording, when I say that missing this patch prevents from
> building perf, it actually _breaks_ perf build, when trying to build it
> with libtraceevent support:
>  
> In file included from /home/alexis/src/buildroot/output/build/linux-6.6.94/tools/perf//util/session.h:5,
>                  from builtin-c2c.c:29:
> /home/alexis/src/buildroot/output/build/linux-6.6.94/tools/perf//util/trace-event.h:149:62: error: operator '&&' has no right operand
>   149 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)

Fair enough, thanks!

Note, I never can seem to build perf in the "older" LTS kernels, so I'm
amazed it works at all for you :)

I'll queue this up after this round of releases goes out later this
week.

greg k-h

