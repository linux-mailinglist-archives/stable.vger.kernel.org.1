Return-Path: <stable+bounces-88971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4629B2846
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C347B20855
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA318E03D;
	Mon, 28 Oct 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P+9PpYou"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766318E05D
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 06:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098536; cv=none; b=GIllKLlhCp9dqH38RKjafmRrNyGvdXm0pt2qjC0SZXzJieSYShG3ObsQqClIZLkQesuPeFcNXwRzeEKV/kJVi8NITjsawENib7DFvwHKjB/5IMINCiHY2aK8z5xod0tHsm7F4f/lS2NTS2siuy8RQUxBQQfp7xCIqV6yH4s8mEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098536; c=relaxed/simple;
	bh=OVGinUkP8rhCFfSkYkOW8qBTUitqvzirIBFM61wYPH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVBAlWjVD+rSY7By7yJvQpbRJlf/RpkKh5qUPbe+p9G2FzWmrD/rrbkbqYbaoDbia6qGq6nDnaHMerfP5BJAnLu0uBxjQ7jO7GbXijuKesSL4PApwFeZtWcAIBjIHC+xAqJYKMGdvFxsZUMkKHcgo66/VOq01kBhQUispABGtUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P+9PpYou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CDEC4CEC3;
	Mon, 28 Oct 2024 06:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098536;
	bh=OVGinUkP8rhCFfSkYkOW8qBTUitqvzirIBFM61wYPH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+9PpYouCCR4w7jiIsOmjVKUsNmpndXEF7eax8hXcsb2714YvuBIDK79J6u7GEU+6
	 nngS7BS2USaJZT5AyfPYzXASwq1s4mXfOYZbb2N5UXMTgiJ6WMsTfTc4+xh0jj0omA
	 QjBsQD4YHBfq8MtVN9dQ1M99jL0BwvQR+mXO6I/I=
Date: Mon, 28 Oct 2024 07:33:06 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: "saravanak@google.com" <saravanak@google.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Seiya Wang =?utf-8?B?KOeOi+i/uuWQmyk=?= <seiya.wang@mediatek.com>,
	Singo Chang =?utf-8?B?KOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Message-ID: <2024102801-canopy-cruelness-ee23@gregkh>
References: <20241024-fixup-5-15-v1-1-62f21a32b5a5@mediatek.com>
 <2024102847-enrage-cavalier-77e2@gregkh>
 <0e2fa50d4eee77f310362248cb2f95457ba341ad.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e2fa50d4eee77f310362248cb2f95457ba341ad.camel@mediatek.com>

On Mon, Oct 28, 2024 at 06:08:15AM +0000, Jason-JH Lin (林睿祥) wrote:
> On Mon, 2024-10-28 at 06:38 +0100, Greg KH wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > On Thu, Oct 24, 2024 at 06:30:01PM +0800, Jason-JH.Lin via B4 Relay
> > wrote:
> > > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > > 
> > > This reverts commit ac88a1f41f93499df6f50fd18ea835e6ff4f3200.
> > > 
> > > Reason for revert:
> > > 1. The commit [1] does not land on linux-5.15, so this patch does
> > > not
> > > fix anything.
> > > 
> > > 2. Since the fw_device improvements series [2] does not land on
> > > linux-5.15, using device_set_fwnode() causes the panel to flash
> > > during
> > > bootup.
> > > 
> > > Incorrect link management may lead to incorrect device
> > > initialization,
> > > affecting firmware node links and consumer relationships.
> > > The fwnode setting of panel to the DSI device would cause a DSI
> > > initialization error without series[2], so this patch was reverted
> > > to
> > > avoid using the incomplete fw_devlink functionality.
> > > 
> > > [1] commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> > > detection more robust")
> > > [2] Link: 
> > > https://lore.kernel.org/all/20230207014207.1678715-1-saravanak@google.com
> > > 
> > > Cc: stable@vger.kernel.org # 5.15.169
> > 
> > What about 5.10.y and 5.4.y as well?  Aren't those also affected?
> 
> Oh, Yes.
> 
> I'll send v3 for these versions as well.

Thank you.

> BTW, how can I know what other branches should I revert the patch as
> well? Just in case I missed it in another branch.

You can look at all the branches to verify if it has been applied or
not.  There are some tools that do this for you, I use the one I created
that can be found at:
	https://git.sr.ht/~gregkh/linux-stable_commit_tree

thanks,

greg k-h

