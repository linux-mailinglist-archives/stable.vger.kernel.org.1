Return-Path: <stable+bounces-78330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4A98B593
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 09:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E4CB21567
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D41BC094;
	Tue,  1 Oct 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nR/rvGyK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED18CB67D
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 07:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767920; cv=none; b=tU+fLabKlNpwr8jIUOtebqqPi2HyqHdi4ZITA1/033kQ9dAvkXoHhuVT1RhObBi6EQ4qniu1yG8GzWh7fXOzA0R0VqjM4XK/ertqXywqf1uHq98sJ16E8pRz/UHPe8MDySxxhWuqYzM+smcp9u2AqTPfKcSfl93oJQS6Cw9hZ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767920; c=relaxed/simple;
	bh=Vnm4L06FdS+6J2FCoup///sqzxFDyYNBCxPr5pk+Z68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8R6ag0IL1w2YbiZP2JCPbLk3bG9ZNPWXmaUuXD9aVlfHb8r3NNs5WpbCuiJgwqo+Gu6dF3rbH18vilBEWqH5ORuFZlooV9PBAoVhYH3eaOvY80CZjsCBdnMhNSE9XlZCTaQx1eWUCRxKMZF/szdPKnh2+GmMd0cDojaNuVYDN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nR/rvGyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D67AC4CEC6;
	Tue,  1 Oct 2024 07:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727767919;
	bh=Vnm4L06FdS+6J2FCoup///sqzxFDyYNBCxPr5pk+Z68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nR/rvGyKKSm7BBzBIc8OnvaOd7+jAn17egVQY5oIXuG3xIees6hHvaQe0/D8VF5ed
	 gMd1zTOH509+yyqTGY9lEYxxpVnu2wFpPkz0Lw6xprnYvYiS1SqFSpMXxbn4J0QgLE
	 Y/RKdcfgj73aPgQ7qiWK8mZMU3k2hetgJly4FpUY=
Date: Tue, 1 Oct 2024 09:31:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: Fix regression from "drm/amd/display: Fix MST BW calculation
 Regression"
Message-ID: <2024100129-wolf-turbojet-2af1@gregkh>
References: <9c551c15-b23d-4911-99ee-352fad143295@kernel.org>
 <2024092752-taunt-pushing-7654@gregkh>
 <652c0f61-450c-415f-9520-68cc596fabb0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652c0f61-450c-415f-9520-68cc596fabb0@kernel.org>

On Fri, Sep 27, 2024 at 09:14:40AM -0500, Mario Limonciello wrote:
> On 9/27/2024 02:41, Greg KH wrote:
> > On Mon, Sep 23, 2024 at 11:23:57PM -0500, Mario Limonciello wrote:
> > > Hello,
> > > 
> > > The commit 338567d17627 ("drm/amd/display: Fix MST BW calculation
> > > Regression") caused a regression with some MST displays due to a mistake.
> > > 
> > > For 6.11.y here is the series of commits that fixes it:
> > > 
> > > commit 4599aef0c97b ("drm/amd/display: Fix Synaptics Cascaded Panamera DSC
> > > Determination")
> > 
> > I don't see this commit in Linus's tree :(
> 
> Gah; sorry I have a lot of remotes and didn't realize which one I was on
> when regressing this.  Here's the right hashes.
> 
> 4437936c6b69 ("drm/amd/display: Fix Synaptics Cascaded Panamera DSC
> Determination")
> 
> > 
> > > commit ecc4038ec1de ("drm/amd/display: Add DSC Debug Log")
> > > commit b2b4afb9cf07 ("drm/amdgpu/display: Fix a mistake in revert commit")
> > 
> > Nor either of these :(
> 
> commit 3715112c1b35 ("drm/amd/display: Add DSC Debug Log")
> commit 7745a1dee0a6 ("drm/amdgpu/display: Fix a mistake in revert commit")

All now queued up, thanks.

greg k-h

