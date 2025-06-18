Return-Path: <stable+bounces-154628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B27ADE362
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 08:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA9D3B8521
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 06:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F01A9B3D;
	Wed, 18 Jun 2025 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VklVQwL4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4818027
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750226746; cv=none; b=WQwLiLnazTqmP3rEieRXwRGMW8OFZ++ZMZcBNOWmMkbktrH4yvukybdcgtSrot+85xZ/CDG0ATkyrWe/xR1WGlFoh0eB3n9y8NgylnimQXi8+M9NJlB+4bNkj1f/FYmrLtX5e9G8QOysv4r9B2TFV+3RLI/Mhchp98JjQkFA80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750226746; c=relaxed/simple;
	bh=gEYJM/fNTfyG9MY1SlDYx1IpKB881AqSuCAbLZXvBKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjEu/UfCCuk5RH4fFBeH1mTrBiSR/0HHyorqU4lp/WV+OBsM4zMcSYcLOj5E1uxmVz06sUWwxs67lnngDcNC4Lu8tzZ+Is2bO5/LpsaQNJXBIWJOBNiMz/URseTnVamdki61b5HsPWtaIwUlRgiZMRzrQ/xm6Qef7Yx4/ixog0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VklVQwL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6EAC4CEE7;
	Wed, 18 Jun 2025 06:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750226745;
	bh=gEYJM/fNTfyG9MY1SlDYx1IpKB881AqSuCAbLZXvBKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VklVQwL4+jr8tsDxRKnH+42aQfUPMvW/scXOv1keAh1j5V7r5Mp697jFFZ2GuuMDt
	 2xPiIupD3cC3zaQzvpWRAzJZA0Kg8iXVoel1phLRwwibO7C25X0VWjO4XdhfQhrwQw
	 xpfhqLZmyPzN6ssexbFh7KlOpGCf9FdXzGtlJOVk=
Date: Wed, 18 Jun 2025 08:05:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/appletbdrm: Make appletbdrm depend on X86
Message-ID: <2025061824-catcall-gestate-2279@gregkh>
References: <PN3PR01MB95974E38ACEDEB167BAA2BFBB872A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN3PR01MB95974E38ACEDEB167BAA2BFBB872A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

On Wed, Jun 18, 2025 at 11:27:36AM +0530, Aditya Garg wrote:
> commit de5fbbe1531f645c8b56098be8d1faf31e46f7f0 upstream
> 
> The appletbdrm driver is exclusively for Touch Bars on x86 Intel Macs.
> The M1 Macs have a separate driver. So, lets avoid compiling it for
> other architectures.
> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Link: https://lore.kernel.org/r/PN3PR01MB95970778982F28E4A3751392B8B72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
> Sending this since https://lore.kernel.org/stable/20250617152509.019353397@linuxfoundation.org/
> was also backported to 6.15

What stable tree(s) is this for?

thanks,

greg k-h

