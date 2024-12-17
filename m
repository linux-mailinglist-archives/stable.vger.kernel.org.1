Return-Path: <stable+bounces-104461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02849F46BE
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 10:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1D0168657
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D419A1805B;
	Tue, 17 Dec 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b1EMon/a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920DF1DE4DC
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 09:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426079; cv=none; b=EfXh62EWXj1Q2ab4zByhEKKJmwYyeQhrFCzkSPVU7OiG8M2zYjbOivGMI9ugVZVXk2opOdygX+AcBsDZC3b5hM8Zt2jRognnNSjZIfJIyXJdYqYyYHMCEozH372s6Uslz0sv+4RhedfYl15Q90h/BMu+kW+Owx+Zg9Xjg2LPBdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426079; c=relaxed/simple;
	bh=U8IlvGu6EwbsSdR55l9G5cu1zmhwJv+50VXMReo99J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMrmU/5c4H+O8u9KLz5XlJWIIVzVtIdqCt4d8M3i6mbHVdKtRomzidtN+b/yx6N1XjsiHpnkc3pAh10pY+0+/pGiu1rUyUeqX6EdKpnysRUxTjvSFLwZY4oR9Denp+Ab7OLyfh95+ilR6OXDgcLiBrfPciw8CS+YlgG7jwbmEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b1EMon/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACECC4CED6;
	Tue, 17 Dec 2024 09:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734426079;
	bh=U8IlvGu6EwbsSdR55l9G5cu1zmhwJv+50VXMReo99J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1EMon/aANi9AWe3Zgcr+4LMmTKl+xPN0wJ2ZaWfb2dsKI9+KzrVSHlzsSnaZ2K96
	 Vc0qNEMiNzbjUFxRGlqXC5egTMtH547VW0KU6NeI4FDTnoiF1sr3fsuRAwGjKSgKkK
	 D7+jQojHn4dWXc+S2Pc7y6IlLlxgUaWv/q00ZhIc=
Date: Tue, 17 Dec 2024 10:01:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y] drm/i915: Fix memory leak by correcting cache
 object name in error handler
Message-ID: <2024121749-errant-existing-a587@gregkh>
References: <2024121517-deserve-wharf-c2d0@gregkh>
 <20241216161840.4815-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216161840.4815-1-jiashengjiangcool@gmail.com>

On Mon, Dec 16, 2024 at 04:18:40PM +0000, Jiasheng Jiang wrote:
> Replace "slab_priorities" with "slab_dependencies" in the error handler
> to avoid memory leak.
> 
> Fixes: 32eb6bcfdda9 ("drm/i915: Make request allocation caches global")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

You also forgot to keep all the original signed-off-by lines, and cc:
them :(

I've fixed it up, but next time be more careful please.

thanks,

greg k-h

