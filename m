Return-Path: <stable+bounces-11877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB82183164C
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 10:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B989B28272C
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 09:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0491F959;
	Thu, 18 Jan 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gTgLgHMG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D654200AC
	for <stable@vger.kernel.org>; Thu, 18 Jan 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571853; cv=none; b=siIgB+kS+ZVJuEQUf/0pwbBTw/0sQ5nw5qw+kzEB0iXTo/ItvPydwqt4s1fXUchyIrDqFbUaa9q7ySiwMxZhSaC7GreR2u5wH4ELBFxjeYAH3sdl23GHQ7ofMdx8yeqG62ENvCXYxzu4Rkv8NSvSYYBSh0PWRC8eER8ev6xChp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571853; c=relaxed/simple;
	bh=0YwnoqKFcC2rNWjKNKy28MM27uJ5tkgjUFt5rBX43+I=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=iCfoeIJ9439+9kngYN/kMLN0og/xI0KuGjkxxCzc8XXtXLaUGfhjyYGoSctilUeKXHb6940owH0g1SgKc0vM4Dy7ioFNMOBbkwrpSea9nTivJrVdRmZ2r+Zi2VmJWjDQUl/9bkg3uKxTNlJpqnc31OX/290xVau/foiNH8P19CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gTgLgHMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF2DC433F1;
	Thu, 18 Jan 2024 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705571853;
	bh=0YwnoqKFcC2rNWjKNKy28MM27uJ5tkgjUFt5rBX43+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTgLgHMGT6bdGjpxmA1MRcUmR7dZNl9QWacLDVlMP1nyMthnvLXQ9lX49jrRQVHk5
	 /GBbVwlKUiRffAfwahkynndKFWWfSy22JNzfe6Qy4IPXoTAYp1SymTq1yTn9LlPCv5
	 e76wmVSsUPxNFPdHBm0536Bi56FM/Z55H7dgG6FQ=
Date: Thu, 18 Jan 2024 10:57:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	"Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: drm/amd/display: Pass pwrseq inst for backlight and ABM
Message-ID: <2024011822-swell-living-0e94@gregkh>
References: <CADnq5_PCqgDS=2Gh3QScfhutgY4wf4hoS15fW5Ox-nziXWGnBg@mail.gmail.com>
 <2024011750-outhouse-overbid-9139@gregkh>
 <CADnq5_OsYC2aAo-m5DS+0nPrQ6UfZGCGBDHaYEsvswVVO2+oYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_OsYC2aAo-m5DS+0nPrQ6UfZGCGBDHaYEsvswVVO2+oYg@mail.gmail.com>

On Wed, Jan 17, 2024 at 12:21:27PM -0500, Alex Deucher wrote:
> On Wed, Jan 17, 2024 at 11:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 17, 2024 at 11:16:27AM -0500, Alex Deucher wrote:
> > > Hi Greg, Sasha,
> > >
> > > Please cherry pick upstream commit b17ef04bf3a4 ("drm/amd/display:
> > > Pass pwrseq inst for backlight and ABM") to stable kernel 6.6.x and
> > > newer.
> >
> > It does not apply to 6.6.y, how did you test this?  I've applied it to
> > 6.7.y now.
> >
> > For 6.6.y, we need a backported, and tested, version of the commit to do
> > anything here.
> 
> Weird.  `git cherry-pick -x b17ef04bf3a4346d66404454d6a646343ddc9749`
> worked fine here and we tested that.
> 
> Oh, I see, there is an unused variable warning in the cherry-pick
> depending on the config.  That must have been what failed.  Attached
> patch should resolve that.  Sorry for the confusion.

Thanks, now queued up.

greg k-h

