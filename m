Return-Path: <stable+bounces-7978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D6F81A147
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 15:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C17EB22F8B
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 14:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E673D39B;
	Wed, 20 Dec 2023 14:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eS0mA/42"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3F3D38F
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 14:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BCBC433C8;
	Wed, 20 Dec 2023 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703083238;
	bh=4N9EFqunbvVGnESNYlaOt0ocZmCcZWACLiBhSgZ9o6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eS0mA/42GNp8pNT6gasQUcdVzOJxXZ1XeG/sThy0VHPbpurdf34CRd7dyInE4p4Cg
	 OkmoVqgqei9to5fov2Pxb0sfpUX8vjQ8RGVVrJsjUgH4Fhr30mFGrTHsIRVjpU/ljU
	 SHMz8R8uk18HKAoZXrUUZZsIbMT+gmueJIbTpclg=
Date: Wed, 20 Dec 2023 15:40:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Fabian Godehardt <fg@emlix.com>
Cc: stable@vger.kernel.org
Subject: Re: [4.19] please include b65ba0c362be665192381cc59e3ac3ef6f0dd1e1
Message-ID: <2023122014-defendant-breezy-5e93@gregkh>
References: <20231219075640.163128-1-fg@emlix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219075640.163128-1-fg@emlix.com>

On Tue, Dec 19, 2023 at 08:56:41AM +0100, Fabian Godehardt wrote:
> Hi all,
> 
> please include b65ba0c362be665192381cc59e3ac3ef6f0dd1e1 also on the
> stable-trees up to v5.10 (i think v5.13 was the first fixed tree).
> 
> Serial gadget on AM335X is also affected, breaks with NULL pointer
> references and needs this patch. Here is the patch for the v4.19
> tree, cherry picked and manually applied from original commit
> b65ba0c362be665192381cc59e3ac3ef6f0dd1e1:
> 
> >From 483d904168b08cf1497c73516c432bde9ae94055 Mon Sep 17 00:00:00 2001
> From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Date: Fri, 28 May 2021 16:04:46 +0200
> Subject: [PATCH] usb: musb: fix MUSB_QUIRK_B_DISCONNECT_99 handling
> 
> In commit 92af4fc6ec33 ("usb: musb: Fix suspend with devices
> connected for a64"), the logic to support the
> MUSB_QUIRK_B_DISCONNECT_99 quirk was modified to only conditionally
> schedule the musb->irq_work delayed work.
> 
> This commit badly breaks ECM Gadget on AM335X. Indeed, with this
> commit, one can observe massive packet loss:
> 
> $ ping 192.168.0.100
> ...
> 15 packets transmitted, 3 received, 80% packet loss, time 14316ms
> 
> Reverting this commit brings back a properly functioning ECM
> Gadget. An analysis of the commit seems to indicate that a mistake was
> made: the previous code was not falling through into the
> MUSB_QUIRK_B_INVALID_VBUS_91, but now it is, unless the condition is
> taken.
> 
> Changing the logic to be as it was before the problematic commit *and*
> only conditionally scheduling musb->irq_work resolves the regression:
> 
> $ ping 192.168.0.100
> ...
> 64 packets transmitted, 64 received, 0% packet loss, time 64475ms
> 
> Fixes: 92af4fc6ec33 ("usb: musb: Fix suspend with devices connected for a64")
> Cc: stable@vger.kernel.org
> Tested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Tested-by: Drew Fustini <drew@beagleboard.org>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Link: https://lore.kernel.org/r/20210528140446.278076-1-thomas.petazzoni@bootlin.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

As you did the backport, you too need to sign off on this. Can you
resend this with that properly added?

thanks,

greg k-h

