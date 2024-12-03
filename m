Return-Path: <stable+bounces-96207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB59E162A
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E01281A5D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968EE1DB375;
	Tue,  3 Dec 2024 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZSldQku3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03C1DACA7
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215698; cv=none; b=VV+O5BMpbRE5L9TvDdg7QhvOvFyPEzVffZ2l6RZDbiLTXZxQDgvmsAFFWPaqo8D6axFS9rnE1YhWttIrN4Cx6vorukWzXzCf2Wp9Ac6Bl9A/BllNmq2FKYz8Cdjuq1elU3kJKTODw6JtaeLKJ3GgO5tU1f2H3N8IzpIO0PnxJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215698; c=relaxed/simple;
	bh=/BZfKV39MiIrOlB78Z2fOogGBflai2uhBhBvWjnvXsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjO+OO8MdtMC1NtZBCWPECEQe3bRO12Mb46NOipatWJwVzcyslXW+TV7/tj0DGdyVR5t+OBpr/+vIqN0ccNKFFSouPFyO21sfCnSq5BhsftwL4mAph/aMxmdiZUNlLCutEGFFCm3xnQ005TA01Knq+elAF8ND4/NPLVpMB4N7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZSldQku3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6FAC4CED6;
	Tue,  3 Dec 2024 08:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733215697;
	bh=/BZfKV39MiIrOlB78Z2fOogGBflai2uhBhBvWjnvXsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZSldQku3uRBVRSG3W7jL74h+gdN05VcjKmJsIY1PvE1InTwodjfAFsjhy4FoH4pZy
	 N4mkIYFGDw0YizpbnxG/AceyjUBqVzYSCv3BjFKBE58+HvSh2OF8BMQvK1r8qHFS2p
	 HMZ5Gszk2jGOwH3sE0J1mT84UapoxrwISX9KCqlE=
Date: Tue, 3 Dec 2024 09:48:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bin Lan <bin.lan.cn@windriver.com>
Cc: bin.lan.cn@eng.windriver.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.6] crypto: starfive - Do not free stack buffer
Message-ID: <2024120328-magnify-brisket-23e4@gregkh>
References: <20241203065213.67046-1-bin.lan.cn@eng.windriver.com>
 <2024120340-vessel-pelican-1721@gregkh>
 <1674ed4c-1e86-4d7e-8840-3b7d14f9987c@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1674ed4c-1e86-4d7e-8840-3b7d14f9987c@windriver.com>

On Tue, Dec 03, 2024 at 04:34:25PM +0800, Bin Lan wrote:
> 
> On 12/3/2024 4:23 PM, Greg KH wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Tue, Dec 03, 2024 at 02:52:13PM +0800, bin.lan.cn@eng.windriver.com wrote:
> > > From: Jia Jie Ho <jiajie.ho@starfivetech.com>
> > > 
> > > [ Upstream commit d7f01649f4eaf1878472d3d3f480ae1e50d98f6c ]
> > > 
> > > RSA text data uses variable length buffer allocated in software stack.
> > > Calling kfree on it causes undefined behaviour in subsequent operations.
> > > 
> > > Cc: <stable@vger.kernel.org> #6.7+
> > The cc: says 6.7 and newer, and yet you are wanting this for 6.6.y?
> > Why?  Why ignore what the author asked for?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I want to backport it to fix CVE-2024-39478.

Again, how do you know that that CVE is relevant for kernels older than
6.7.y?  Have you tested this?  Have you proved that 6.6.y needs this?
If not, there's no way we can take it, nor would you want us to take it,
right?

thanks,

greg k-h

