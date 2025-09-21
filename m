Return-Path: <stable+bounces-180820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE0CB8DFB3
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 18:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 766704E1480
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A534A23D28C;
	Sun, 21 Sep 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rCy+3+mD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5854C23D7C5
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758472173; cv=none; b=F7GZEuTIHf/bgPqCADC6q+mvORPAeevTVilJyf8qRiduwUq3qi/lSKkDzDWcwyUEsjRPJ0iUbvvBMbw0mbbvqTdKosww/UVhNdsfo/cZEZqdyIV/5WRyHK6aFm9t99JOTEJiriA2gH+eixQH2wE1kqykTXJ1CFFzJipmCCPFyn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758472173; c=relaxed/simple;
	bh=4ZTkc6cIEVDZFWiFGLxs0OsyhFvT5lYslGsloWiqdA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYrsfe5bgDOLGZeBer+r78VTG7qv0pvzocHn47/gHMz6M9FTOOZVQjOu/oNnbdlM/uj+XEw8XUF2B+NCcyls92hoE3WKlG0RH3DahpqlUk3b0CF/vwt21jbr8mgGpu1WbpiEuosrhG3PXCGnt8Ebya6RNVhvLI7jm8RxRWjiweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rCy+3+mD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99CFC4CEE7;
	Sun, 21 Sep 2025 16:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758472173;
	bh=4ZTkc6cIEVDZFWiFGLxs0OsyhFvT5lYslGsloWiqdA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCy+3+mDittxQA9mYF6qSyVBB1AuOPOQCnQdVm/e6S3qBGgovc4Uh+XSs+0oiZp9N
	 IWCNIM6KP7jJq5jlxxL7z9hrUg3NhvV9VeCny7K8v/MOwvG2O741pupsaX0ZAVPQX0
	 zmnvkKjvO8bxAUUzbuDN/VO/8y2VamxKPL6+KsuY=
Date: Sun, 21 Sep 2025 18:29:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: ilpo.jarvinen@linux.intel.com, rahul@chandra.net,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] platform/x86: asus-wmi: Re-add extra keys
 to ignore_key_wlan" failed to apply to 6.12-stable tree
Message-ID: <2025092134-snazzy-saved-1ef4@gregkh>
References: <2025092126-upstream-favorite-2f89@gregkh>
 <CAGwozwE-wBt2fiDyFPjX2tR9VySQJyXn1zLtEQFCRHnxNS=fWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGwozwE-wBt2fiDyFPjX2tR9VySQJyXn1zLtEQFCRHnxNS=fWw@mail.gmail.com>

On Sun, Sep 21, 2025 at 03:57:25PM +0200, Antheas Kapenekakis wrote:
> On Sun, 21 Sept 2025 at 14:34, <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 225d1ee0f5ba3218d1814d36564fdb5f37b50474
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092126-upstream-favorite-2f89@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> >
> > Possible dependencies:
> >
> 
> Is commit 1c1d0401d1b8 ("platform/x86: asus-wmi: Fix ROG button
> mapping, tablet mode on ASUS ROG Z13") eligible for backport to
> stable? If yes it fixes the apply conflict. Z13 users would appreciate
> in any case.

I don't see that git commit in Linus's tree, are you sure it is correct?

thanks,

greg k-h

