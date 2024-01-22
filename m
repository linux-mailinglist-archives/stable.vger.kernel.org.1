Return-Path: <stable+bounces-12717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFCD836F86
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774D4287EC6
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86D481B8;
	Mon, 22 Jan 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZvAomMzF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056F481A5
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945544; cv=none; b=W8U1SqqjlsZKyltxZYLvipicB5Wd4tfk8SK0gH6lYZe1cFLhnXxplb2a4siGoSWn6OcHvXMV/XJipoTkf7zmOCq0YB3YGXNmsOVRhsh9SLJElOQ+bvRPLhoT2iAz4Uk4N/aG0W8eJOOaylv0y2E3TG9CFYBgJywvHqQJAGDfDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945544; c=relaxed/simple;
	bh=edDM7lfGqltMa9Izn2Q7exVxd+SiKBQ341jD5qmdL2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DawpIYVOe/WMWMPN0T0qYKzmYuQznSgDSjTKSNKRGxXOlFXjlsZUaX31W7pg74G9q5W7+oS/I+zMQfoAxtlHBW0o6YN4zZOteLXOqz+DhmT16rFgbFEa1k4hXL8+4hzP0R2YthcBffEQWWS4Ooo23iVSc7S21WA5WS2iSWnbMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZvAomMzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155C4C433C7;
	Mon, 22 Jan 2024 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705945544;
	bh=edDM7lfGqltMa9Izn2Q7exVxd+SiKBQ341jD5qmdL2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvAomMzFpKuOuUs2LXelYpPMpmhUNaJprpgmh/DPwRn3eydJiDrfRrXbwvYv/n0FJ
	 bG6Lnxl7gJ7qTlODFEIwNTKSwcmk+ihyPoqfEjPF1Sd4f2d3Hlw6FtG9EH+4cfiW9e
	 HYVrTe1SW5Bj5i1UoxtAB8up5RrFNNvRy+gWLHNo=
Date: Mon, 22 Jan 2024 09:45:43 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, kernelci-results@groups.io,
	bot@kernelci.org, stable@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: kernelci/kernelci.org bisection:
 baseline-nfs.bootrr.deferred-probe-empty on at91sam9g20ek
Message-ID: <2024012226-probably-politely-0343@gregkh>
References: <65a6ca18.170a0220.9f7f3.fa9a@mx.google.com>
 <845b3053-d47b-4717-9665-79b120da133b@sirena.org.uk>
 <2024011716-undocked-external-9eae@gregkh>
 <82cda3d4-2e46-4690-8317-855ca80fd013@sirena.org.uk>
 <2024011816-overstate-move-4df8@gregkh>
 <3c7cf19d-cd94-4d94-b4f5-1e0946fd0963@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c7cf19d-cd94-4d94-b4f5-1e0946fd0963@sirena.org.uk>

On Thu, Jan 18, 2024 at 02:33:17PM +0000, Mark Brown wrote:
> On Thu, Jan 18, 2024 at 11:16:29AM +0100, Greg Kroah-Hartman wrote:
> > On Wed, Jan 17, 2024 at 01:52:59PM +0000, Mark Brown wrote:
> 
> > > > I'll be glad to revert, but should I also revert for 4.19.y and 5.4.y
> > > > and 5.10.y?
> 
> > > I'd be tempted to, though it's possible it's some other related issue so
> > > it might be safest to hold off until there's an explicit report.  Up to
> > > you.
> 
> > I'll just drop it from 5.15.y for now, thanks!
> 
> Thanks.  I've actually just seen that it's also failing on v4.19, and
> went looking and found that v5.4 and v5.10 look like they never passed
> which means it didn't trigger as a report there.

Now queued up the revert for the other branches as well, thanks.

greg k-h

