Return-Path: <stable+bounces-100895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC69EE543
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 12:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CA71166DD2
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C820B211A19;
	Thu, 12 Dec 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GHQCuHn7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C941F0E57;
	Thu, 12 Dec 2024 11:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003671; cv=none; b=dLBIjRqWTkziMYdld2CN63ilLoFU+mq5hfqasZE4BhRAX4sXjeaa5yk/f3X9x3wDNTddDig8Yp6MU9Oj1tQIc8NyU0wDKND3XvjfoQJUOuHIhrOrxyhQXcvGWb4K+cZ0YXERxhvXEKUWc375newQzJWYSYrzASqHjqU4s2e7jfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003671; c=relaxed/simple;
	bh=yjN5gAfgJEvsKoN4I07EU3mWVHEO0v1/sjixcblkjzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYRAFfolmkowRU+5rHChOKn+lYjpifYXqT3S52Sho3zDzNuGhonsWrixQkxWdL5wgvqH+nV7CX0BtvHCxjNik3Vx+Bi8gqvjv/iN3r84UTuAkIIWoPSwY1mxd/D+Y/AIQfiKw8GO05uL6BNB16fiRalsvsYNy5uvh0JHU+3fSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GHQCuHn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D347AC4CECE;
	Thu, 12 Dec 2024 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734003671;
	bh=yjN5gAfgJEvsKoN4I07EU3mWVHEO0v1/sjixcblkjzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GHQCuHn7ZnTwP71SxJMpzijM72xzdQ/HcRyg4pNF45d5wPxBfhz/3KytGN2I5j9QN
	 Y61i+fzVH48eVp/s8ewAzrT+QBJK+GCa8RwXLR0sSQGg3hzl0khCQasoO8jXKGXJv0
	 +Y+DvjLVZ+f4WzG0fK0aePg1Yta15YnnzceHzTl0=
Date: Thu, 12 Dec 2024 12:41:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: stable@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sashal@kernel.org,
	jamie.bainbridge@gmail.com, jdamato@fastly.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] net: napi: Prevent overflow of napi_defer_hard_irqs
Message-ID: <2024121250-preschool-napping-502e@gregkh>
References: <20241211040304.3212711-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211040304.3212711-1-jianqi.ren.cn@windriver.com>

On Wed, Dec 11, 2024 at 12:03:04PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Joe Damato <jdamato@fastly.com>
> 
> [ Upstream commit 08062af0a52107a243f7608fd972edb54ca5b7f8 ]

You can't ignore the 6.6.y tree :(

Dropping from my review queue now.

greg k-h

