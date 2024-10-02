Return-Path: <stable+bounces-78610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2015D98D0BF
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC381C2150F
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 10:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9B91E4930;
	Wed,  2 Oct 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W5tCDJq+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7B1E4120
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727863431; cv=none; b=JY51rcwUhgf+s5WVLY0oKh6QeIn3s1FWI5B+YcZM+ofptjgqSyvoREjhNiGZ64+BBvzwf8kFg36TTQ1YPAbzLgIFLW0Bh2UCkqvE1C+T/6dSxegjVRyG+2UF3ryqlVi4lY7q0HkWeyiljlyitQKxejE1RZDXYkfz73gx8aYtjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727863431; c=relaxed/simple;
	bh=x3NmnW2QbFn46e30z9BtTtr86b451IOUt6jwjakQuRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kzwolwo6x/Ezu2Mjt60ZtgHERlL6aGpYccB+S97pNWGKRwAZsnnUL+jnDlUFPmVFtAo4YfqxEdnjXzkhv/HyC5exFr649uZLDvRbkcSHFc3negjbOeIb+QsxUoZ57dXBBWNwL2IfqeT2/Qms4g74xsupuVyRMFnCYKHw5tx98KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W5tCDJq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7962EC4CEC5;
	Wed,  2 Oct 2024 10:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727863430;
	bh=x3NmnW2QbFn46e30z9BtTtr86b451IOUt6jwjakQuRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5tCDJq+nfbEUzUKnDeFCP3ziknnopzDUNkuyFnLzo1u/pdHEL8ZIrgEjIyCSe0g8
	 dylUEdmDs7YpcCg4B5dKZZ+QCPrRIML7aojrAkxlqKKyHo3deo51e3jG4M4PAAX6lK
	 eIDpvcx+u1pWSNZ5z+MWCMsHbUGVjiKULaQpNcL4=
Date: Wed, 2 Oct 2024 12:03:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>
Cc: brauner@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] debugfs show actual source in
 /proc/mounts" failed to apply to 6.10-stable tree
Message-ID: <2024100232-kinship-stomp-1629@gregkh>
References: <2024100128-prison-ploy-dfd6@gregkh>
 <723a6bec-0c41-a81a-c8f4-b8e1b20dc724@tuyoix.net>
 <alpine.WNT.2.20.2410011036090.3332@CLUIJ>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.WNT.2.20.2410011036090.3332@CLUIJ>

On Tue, Oct 01, 2024 at 10:38:22AM -0600, Marc Aurèle La France wrote:
> On Tue, 2024-Oct-01, Marc Aurèle La France wrote:
> > On Tue, 2024-Oct-01, gregkh@linuxfoundation.org wrote:
> 
> > > The patch below does not apply to the 6.10-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/
> > > linux-6.10.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 3a987b88a42593875f6345188ca33731c7df728c
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to
> > > '2024100128-prison-ploy-dfd6@gregkh' --subject-prefix 'PATCH 6.10.y'
> > > HEAD^..
> 
> > > Possible dependencies:
> 
> > > 3a987b88a425 ("debugfs show actual source in /proc/mounts")
> > > 49abee5991e1 ("debugfs: Convert to new uid/gid option parsing helpers")
> 
> > > thanks,
> 
> > > greg k-h
> 
> > > ------------------ original commit in Linus's tree ------------------
> 
> > > From 3a987b88a42593875f6345188ca33731c7df728c Mon Sep 17 00:00:00 2001
> > > From: =?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>
> > > Date: Sat, 10 Aug 2024 13:25:27 -0600
> > > Subject: [PATCH] debugfs show actual source in /proc/mounts
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=UTF-8
> > > Content-Transfer-Encoding: 8bit
> 
> > > After its conversion to the new mount API, debugfs displays "none" in
> > > /proc/mounts instead of the actual source.  Fix this by recognising its
> > > "source" mount option.
> 
> > > Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> > > Link:
> > > https://lore.kernel.org/r/e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net
> > > Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
> > > Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new
> > > uid/gid option parsing helpers
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> > ... elided.
> 
> > This is because the commit message should have instead read ...
> 
> > After commit 0c07c273a5fe ("debugfs: continue to ignore unknown mount
> > options"), debugfs displays "none" in /proc/mounts instead of the actual
> > source.  Fix this by recognising its "source" mount option.
> 
> > Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
> > Fixes: 0c07c273a5fe ("debugfs: continue to ignore unknown mount options")
> > Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid
> > option option parsing helpers
> > Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new
> > uid/gid option parsing helpers
> 
> > ... along with ...
> 
> > Link:
> > https://lore.kernel.org/r/e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Oops.  That link should be ...
> 
> Link: https://lore.kernel.org/all/883a7548-9e67-ccf6-23b7-c4e37934f840@tuyoix.net

Thanks, looks like Sasha picked these up now.

greg k-h

