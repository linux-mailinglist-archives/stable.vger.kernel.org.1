Return-Path: <stable+bounces-50248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C4E9052C8
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453A528390F
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07234171E5C;
	Wed, 12 Jun 2024 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3/3TOJ3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3416F8F6;
	Wed, 12 Jun 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196172; cv=none; b=s4+DUgZ+UfBwIOK8QeL8t0/vsXnpOhJWwu0wqoo4jvWLofWStjrWyKsdPEilywHVzmK6dxXVfcLNTNI7Ezyj0DCvrDHezXDKKpEQ0O1LiILVOTOZWTIo/5ocQbc0MYwIzF1svJo0Jg6+gS6tw7H4L3CdC9hvdtnZ38p7AW4Btfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196172; c=relaxed/simple;
	bh=CPuifqh98G2l75z+l3JYlHceu0A62gH/OKzww4ARjrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5m8B/yWmhrpEhfpg1bGoOam7GjPCd2gEDPWrMM4g68tJD34+3+Njr57S8SdzwcxOb8H9cKtg+dsTOIxiCJSdUcfxa7Yk3obcRQ9rGRRrKoxDJ1fJ4QaqKojgE+AZFFw7KjGxlZqtwrEpXr8j8VNBMegd1NMLmRh5/W6ruoIHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B3/3TOJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D44C32789;
	Wed, 12 Jun 2024 12:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196172;
	bh=CPuifqh98G2l75z+l3JYlHceu0A62gH/OKzww4ARjrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3/3TOJ3f6PDCP2+ojzaZYqKW1WLrmUd7ck51P8eEbmIhWJ2JSUWklx3indQSpihf
	 HAE6yNIDElsdLmGNwWmk7jKvwt1xRd1KcqVP0vie4OzX8M3LTgxnhoeIfzZxVMQEfm
	 yWjzOtjxTx5Cre/dSXF2ZCv2RVG3zAlq6MWW8OjE=
Date: Wed, 12 Jun 2024 14:42:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>
Subject: Re: Patch "drm: zynqmp_dpsub: Always register bridge" has been added
 to the 6.9-stable tree
Message-ID: <2024061237-unisexual-unawake-1efe@gregkh>
References: <20240603114605.1823279-1-sashal@kernel.org>
 <12c2adcf-cc18-48a8-8411-0ba9ec3551e0@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c2adcf-cc18-48a8-8411-0ba9ec3551e0@linux.dev>

On Mon, Jun 03, 2024 at 11:04:28AM -0400, Sean Anderson wrote:
> Hi Sasha,
> 
> Please also pick [1] when it is applied.
> 
> --Sean
> 
> [1] https://lore.kernel.org/all/974d1b062d7c61ee6db00d16fa7c69aa1218ee02.1716198025.git.christophe.jaillet@wanadoo.fr/

Please let us know when this hits Linus's tree.

thanks,

greg k-h

