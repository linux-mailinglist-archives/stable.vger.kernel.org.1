Return-Path: <stable+bounces-3781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 730A580245E
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC2D1F21107
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D6611733;
	Sun,  3 Dec 2023 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="slmpUpXH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A819471
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:56:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0954C433C7;
	Sun,  3 Dec 2023 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701611789;
	bh=mBO5NEL5Cc3JXf1XzPU5yE75NUrA94C70jDCIx/qgVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slmpUpXHtU+p5eKFxooU0piOoR0QDL97weOvIgOKGlVx2VLPaWzW/xZO01FbNR6/a
	 urhjU2JPn+ezMbVz9VNu0cS+dW095Bd24QEp+0/4JtOcFMhErpCuPei9vRkEbSljLL
	 xd0/UZj3yZJiCylV8PFVPif44hQSq9OjkZRxR5RA=
Date: Sun, 3 Dec 2023 14:56:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Olivier Matz <olivier.matz@6wind.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15 0/2] vlan: fix netdev refcount leak
Message-ID: <2023120319-moonlike-directory-8bb9@gregkh>
References: <20231201133004.3853933-1-olivier.matz@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201133004.3853933-1-olivier.matz@6wind.com>

On Fri, Dec 01, 2023 at 02:30:02PM +0100, Olivier Matz wrote:
> The backport of commit 21032425c36f ("net: vlan: fix a UAF in
> vlan_dev_real_dev()") in v5.15.3 introduced a netdevice refcount leak
> that was fixed upstream.
> 
> The first commit is trivial and helps to limit conflicts when applying
> the second commit, which fixes the issue.
> 
> The last conflict is solved by using dev_put() instead of
> dev_put_track(), as the latter was introduced in 5.17 and does not
> exist in 5.15.x.
> 
> Xin Long (2):
>   vlan: introduce vlan_dev_free_egress_priority
>   vlan: move dev_put into vlan_dev_uninit
> 
>  net/8021q/vlan.h         |  2 +-
>  net/8021q/vlan_dev.c     | 15 +++++++++++----
>  net/8021q/vlan_netlink.c |  7 ++++---
>  3 files changed, 16 insertions(+), 8 deletions(-)
> 
> -- 
> 2.30.2
> 
> 

Both now queued up, thanks.

greg k-h

