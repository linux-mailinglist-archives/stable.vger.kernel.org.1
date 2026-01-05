Return-Path: <stable+bounces-204850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D15B5CF4CA0
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EE2C306396B
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 16:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5163033985B;
	Mon,  5 Jan 2026 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AmeksH49"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0908333A9FE
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630644; cv=none; b=immKJvlTyOco/sVkNJw46/aN1WUAjNwuTs4Zn/eAc02WTjIkDhr2Djwx/RNnvqm+dyx4OPKFLOsUy1Ue3k1gGDW6XdqHfTaFTzVqCApHo7Ku+GoEmv82Q1tVi+D/TI0DwxyvvlqdJU6lzc3sLSMNRNTt7EB30157fTtihnmgW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630644; c=relaxed/simple;
	bh=Q5XpRHbFzyQERGWpBH3sJiBw5pwXkf0YdOsVgNgyJBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qogm+KPMDFwC7ql+xWjBRXynk5re0HoeIIyryWi9P2stLcPvdm7T5v9x61DZhcmIZRnx0aLrsS6VNDiTILXrOhDv8u0F9MXXeOU/rC5we21LLk/aiMN9Ugy2tKdSADOYwCZc9a+hm50Lfn8xPPUbZjvG1F7jzRvzoBR350pQij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AmeksH49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66EEC116D0;
	Mon,  5 Jan 2026 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767630643;
	bh=Q5XpRHbFzyQERGWpBH3sJiBw5pwXkf0YdOsVgNgyJBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmeksH49TEdwK0IZY1a5z4jVLEqwNlXY4pJlqUyTvefZ3ufjq5l/TZ8Q2493htgVi
	 RnEQXV8bF/5VZrCxD6DYUsmPI+/QHvmn78665ttrM48nBYH8Mwvx1tLRhYC3Z5Z8/D
	 gYTEKWNb6pYd18BfNuU5ABhXnNOjCKfj7xb/thYU=
Date: Mon, 5 Jan 2026 17:30:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: dianders@chromium.org, luca.ceresoli@bootlin.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/tilcdc: Fix removal actions in case
 of failed probe" failed to apply to 6.12-stable tree
Message-ID: <2026010512-flame-zips-0374@gregkh>
References: <2026010529-certainty-unguided-7d41@gregkh>
 <20260105154701.5bc5d143@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105154701.5bc5d143@kmaincent-XPS-13-7390>

On Mon, Jan 05, 2026 at 03:47:01PM +0100, Kory Maincent wrote:
> On Mon, 05 Jan 2026 14:26:29 +0100
> <gregkh@linuxfoundation.org> wrote:
> 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> 
> No conflict on my side on current linux-6.12.y.
> Have you more informations?

Did you try building it?  I don't remember why this failed, sorry.

greg k-h

