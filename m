Return-Path: <stable+bounces-41818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540738B6CB4
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD554284523
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF77605D;
	Tue, 30 Apr 2024 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uxdz1u9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271A74E11
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465371; cv=none; b=HjBO2w7DDQEDyMXNHx/jiKejsa7QVdWEGo183D8x5C7iryeg4Awk4wgIm9sEuE8zvcj4+/LC/kzBtARaYgJKZhTh+aJ4u6IyNplf+brCMiugfhPjKD4OoinzQawdrKmAbTWrM5ai9AxR+PjK90rEo5dXge9f3W+dAJtSIM+tfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465371; c=relaxed/simple;
	bh=kQ9tGvbi+YUhRLTprOqdUfsKjJlCroHO+yCWt55ivKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QR3DYSfzkVLly3TySU6ftXRRBo1J9YbidJvvnNYyr+S3CQhKMTQwUebJ7Ochfy4cw9L6a6lxovGvWLUqv/8nWgMni+oPyWj7Ph0e/HZ+N99SeFWSPf0IoxGKEWDWgGLHpmq3txvanSnkYmpFoaV+WSzUOjz6OYWQ5xmA2Ooel+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uxdz1u9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D316C2BBFC;
	Tue, 30 Apr 2024 08:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714465370;
	bh=kQ9tGvbi+YUhRLTprOqdUfsKjJlCroHO+yCWt55ivKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uxdz1u9aE8va2I+VqOHqDVsKSGWN37QNGwLizNgf6lMnaxkzEY0EQrSfSKqpUKIkl
	 MZhMKNHYPeGK7XoDUVonpRGzIWNONixenGYCe6rZzs28e7kog4zJkpUsoXw2J0BNHq
	 +R7l3L+msZIbrTlvfOr4kOrkvZhlEEFaIam3RHOk=
Date: Tue, 30 Apr 2024 10:22:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yick Xie <yick.xie@gmail.com>
Cc: stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 4.19.y] udp: preserve the connected status if only UDP
 cmsg
Message-ID: <2024043057-gloss-sustainer-601f@gregkh>
References: <2024042925-enrich-charbroil-ce36@gregkh>
 <20240430080923.3154753-1-yick.xie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430080923.3154753-1-yick.xie@gmail.com>

On Tue, Apr 30, 2024 at 04:09:23PM +0800, Yick Xie wrote:
> If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
> "connected" should not be set to 0. Otherwise it stops
> the connected socket from using the cached route.
> 
> Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
> Signed-off-by: Yick Xie <yick.xie@gmail.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Link: https://lore.kernel.org/r/20240418170610.867084-1-yick.xie@gmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> (cherry picked from commit 680d11f6e5427b6af1321932286722d24a8b16c1)
> Signed-off-by: Yick Xie <yick.xie@gmail.com>
> ---
>  net/ipv4/udp.c | 5 +++--
>  net/ipv6/udp.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Sorry, but we can not take a 4.19.y only patch, without it also being
present in newer stable kernels.  If you provide versions for 5.4.y,
5.10.y, and 5.15.y then we can take this one.

thanks,

greg k-h

