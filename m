Return-Path: <stable+bounces-65999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14C494B6D5
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 08:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E539281A90
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F281E187856;
	Thu,  8 Aug 2024 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dtrU4Mxp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D6D18757C;
	Thu,  8 Aug 2024 06:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099112; cv=none; b=MQyGpj/gb22eR7bRf4uGrJsnD+xyaEYzi2lP5MbXlR6qmCEu9GL2XWP5Os2kLUHasefq/hBpyUwUne//3RV1tkxAJ6tA5vlc9SbOM1ee2LgKKna4hwN4xUii/41qq+7TJ2rgeR/3a8Fk7ML5WI0sJCbXcZ68xHs12+PzMK4h94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099112; c=relaxed/simple;
	bh=sltp8FW1TRqY1ziUM0nTi5rw01iPql7cX9cKrTj4b7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4wfq6baFFoEskdtpiISUVylTo6UFddxlpLmhQoKssCw2+iPH4c/mSnArkWASu3vYSU3XPgLeerALjzIGoK6A31lyg+Q6ognikd/67OvLXCoqaypz7+sabP7oVRAoas4vNQJvx2iEEEhXVX7HE/wwaIbFuoA8Iuy98sd4/b6crY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dtrU4Mxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D21DC32782;
	Thu,  8 Aug 2024 06:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723099112;
	bh=sltp8FW1TRqY1ziUM0nTi5rw01iPql7cX9cKrTj4b7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtrU4MxpldT9i+91+oe0uGGpwKCFfGxdaYwQq3tbjLQ9Zn5KYM8nE2SFC4mjZdjXZ
	 uVdhRwnawBjVvavp68R28NtXx1/qxwrXErjcGfS41pQxw5dqeRN2i3W8A3FqGF0TPE
	 MH/bcb3spvRWdR66LQGreIPaCibkSkBRpW187BOI=
Date: Thu, 8 Aug 2024 08:38:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Heusel <christian@heusel.eu>
Cc: avladu@cloudbasesolutions.com, willemdebruijn.kernel@gmail.com,
	alexander.duyck@gmail.com, arefev@swemel.ru, davem@davemloft.net,
	edumazet@google.com, jasowang@redhat.com, kuba@kernel.org,
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com,
	stable@vger.kernel.org, willemb@google.com
Subject: Re: [PATCH net] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <2024080857-contusion-womb-aae1@gregkh>
References: <20240726023359.879166-1-willemdebruijn.kernel@gmail.com>
 <20240805212829.527616-1-avladu@cloudbasesolutions.com>
 <2024080703-unafraid-chastise-acf0@gregkh>
 <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <146d2c9f-f2c3-4891-ac48-a3e50c863530@heusel.eu>

On Wed, Aug 07, 2024 at 08:34:48PM +0200, Christian Heusel wrote:
> On 24/08/07 04:12PM, Greg KH wrote:
> > On Mon, Aug 05, 2024 at 09:28:29PM +0000, avladu@cloudbasesolutions.com wrote:
> > > Hello,
> > > 
> > > This patch needs to be backported to the stable 6.1.x and 6.64.x branches, as the initial patch https://github.com/torvalds/linux/commit/e269d79c7d35aa3808b1f3c1737d63dab504ddc8 was backported a few days ago: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/virtio_net.h?h=3Dv6.1.103&id=3D5b1997487a3f3373b0f580c8a20b56c1b64b0775
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/include/linux/virtio_net.h?h=3Dv6.6.44&id=3D90d41ebe0cd4635f6410471efc1dd71b33e894cf
> > 
> > Please provide a working backport, the change does not properly
> > cherry-pick.
> > 
> > greg k-h
> 
> Hey Greg, hey Sasha,
> 
> this patch also needs backporting to the 6.6.y and 6.10.y series as the
> buggy commit was backported to to all three series.

What buggy commit?

And how was this tested, it does not apply cleanly to the trees for me
at all.

confused,

greg k-h

