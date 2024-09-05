Return-Path: <stable+bounces-73131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D11596CFC5
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 08:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBA0281676
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2F518BC24;
	Thu,  5 Sep 2024 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SpXB4yMw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1EB42C0B
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 06:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519067; cv=none; b=HPdfzqC4b03B4Y1Zc1fMFXnsHc0Ke7sJF9c2W/bJZQd+cUnI598ru+4vRTtXUBL0wK5EgT4hzj968rKab/fKvQeK3BrmqEDS3QQGcyhvHZN33WFG12Iu482j0qgvI3WOpnZBrwRCUXBLLQlJ+8d9dAUXZkHLy4sf/vdyYHG2Ww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519067; c=relaxed/simple;
	bh=FnOdCo/floJbxGzv9I7wv+kq44slSbckJT8DSvrE5Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWSKd8J9R4zWNcakYE3PZ2QRetp6d7epl1snn5layeNs0xM3cOITgu3SRBx3PZQKLOr6KgG7TaVTHvctb4CJdHmydIVxv6OPe/xzrkWQTg3dylMRywMlyLV2iByYulrjmnT5lERfIHjhTYEtxa2g12f1K9IojaVOEa5ixECTf+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SpXB4yMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C937C4CEC4;
	Thu,  5 Sep 2024 06:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725519066;
	bh=FnOdCo/floJbxGzv9I7wv+kq44slSbckJT8DSvrE5Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SpXB4yMw6HPNCP9SrFONF0wbGy1g9UMM/Xb4+ebEIztEOAYtaYeL4AXljhfZcSNbp
	 pMsnpIMtxb8DqgU9R8oVJX7tiS8mYln8SYDCvP8p0FwnoMiuCFzk1WzxhQFxpd1IXc
	 zaylluyNZjLJlJOZHJY5afT9CYBwx15wmrAiXvIE=
Date: Thu, 5 Sep 2024 08:51:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pascal Ernster <git@hardfalcon.net>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: Re: Patch "drm/drm-bridge: Drop conditionals around of_node
 pointers" has been added to the 6.6-stable t
Message-ID: <2024090557-darkness-crayfish-ebc6@gregkh>
References: <20240904175026.1165330-1-sashalkernel!org>
 <3f2c3ed8-bbdb-45e0-9463-ffffdad0f37b@hardfalcon.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f2c3ed8-bbdb-45e0-9463-ffffdad0f37b@hardfalcon.net>

On Thu, Sep 05, 2024 at 06:21:00AM +0200, Pascal Ernster wrote:
> [2024-09-04 19:50] Sasha Levin:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      drm/drm-bridge: Drop conditionals around of_node pointers
> > 
> > to the 6.6-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       drm-drm-bridge-drop-conditionals-around-of_node-poin.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 74f5f42c35daf9aedbc96283321c30fc591c634f
> > Author: Sui Jingfeng <sui.jingfeng@linux.dev>
> > Date:   Wed May 8 02:00:00 2024 +0800
> > 
> >      drm/drm-bridge: Drop conditionals around of_node pointers
> >      [ Upstream commit ad3323a6ccb7d43bbeeaa46d5311c43d5d361fc7 ]
> >      Having conditional around the of_node pointer of the drm_bridge structure
> >      is not necessary, since drm_bridge structure always has the of_node as its
> >      member.
> >      Let's drop the conditional to get a better looks, please also note that
> >      this is following the already accepted commitments. see commit d8dfccde2709
> >      ("drm/bridge: Drop conditionals around of_node pointers") for reference.
> >      Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> >      Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >      Signed-off-by: Robert Foss <rfoss@kernel.org>
> >      Link: https://patchwork.freedesktop.org/patch/msgid/20240507180001.1358816-1-sui.jingfeng@linux.dev
> >      Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index 62d8a291c49c..70b05582e616 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -353,13 +353,8 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> >   	bridge->encoder = NULL;
> >   	list_del(&bridge->chain_node);
> > -#ifdef CONFIG_OF
> >   	DRM_ERROR("failed to attach bridge %pOF to encoder %s: %d\n",
> >   		  bridge->of_node, encoder->name, ret);
> > -#else
> > -	DRM_ERROR("failed to attach bridge to encoder %s: %d\n",
> > -		  encoder->name, ret);
> > -#endif
> >   	return ret;
> >   }
> 
> 
> Hi Sasha,
> 
> 
> this breaks the x86_64 build for me.
> 
> AFAICT this patch cannot work without commit
> d8dfccde2709de4327c3d62b50e5dc012f08836f "drm/bridge: Drop conditionals
> around of_node pointers", but that commit is only present in Linux >= 6.7.
> 
> This issue affects the 6.6, 6.1 and 5.15 branches.

Now dropped, thanks!

greg k-h

