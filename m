Return-Path: <stable+bounces-169407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF62B24C38
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 16:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFB016C937
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246171D5CC7;
	Wed, 13 Aug 2025 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qm6K/qJP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19DD1A2C06;
	Wed, 13 Aug 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095982; cv=none; b=jwgKunhE8sXl712G+Iqq2kCKx/Qx5avcSDez/iufG/5c16i3lmH6H7A10mtQgKqjok2xiSzKrx/7C+6ZCMGIWSKREr+iwg+ztHkb/rY+tt6urI0rGiZjDQmNAEQl8Bi+qAmWSWAhXoj2AXU5I6whvZOBynv3XxRWZpKOiLdY9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095982; c=relaxed/simple;
	bh=1DxJ0yXU34ckoh7vdyqg5tNuqTpL7aVDJ2gqkAAqqA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxb6awC0lW7owCxsBJHLmCAwCONDTECDME07EyfJnBY8NkJjnIF4ZWg1/5gJNLc1Kh+secCDuiAH92z1qNIabGSFrMVe7RsiZsCSCZi63RSYvtGUaUSGfnPW6Uxp2NmfHnnEZpmElNrFF79lQFJKTB0b70PjqToaJLdpuggutSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qm6K/qJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04CAC4CEEB;
	Wed, 13 Aug 2025 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755095982;
	bh=1DxJ0yXU34ckoh7vdyqg5tNuqTpL7aVDJ2gqkAAqqA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qm6K/qJPbB3c8GG+i0EDFaWqK8v/gAhORkqiMgo4eL9IFi8kY/beZpAwST+NmiW7u
	 0KeeHeORw1HjcpnX/8VId1TMGq3AiA/3+MtjF6NyrOoaaR+yMdmwSw+F2lFGMNvt8a
	 cdYs/BYoZNWczl2FSHIruuo2ErkTFYPyKUBG3FeI=
Date: Wed, 13 Aug 2025 16:39:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alan Stern <stern@rowland.harvard.edu>, wwang <wei_wang@realsil.com.cn>,
	stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: storage: realtek_cr: Use correct byte order for
 bcs->Residue
Message-ID: <2025081358-posted-ritzy-bd3f@gregkh>
References: <20250813101249.158270-2-thorsten.blum@linux.dev>
 <20250813101249.158270-6-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813101249.158270-6-thorsten.blum@linux.dev>

On Wed, Aug 13, 2025 at 12:12:51PM +0200, Thorsten Blum wrote:
> Since 'bcs->Residue' has the data type '__le32', we must convert it to
> the correct byte order of the CPU using this driver when assigning it to
> the local variable 'residue'.
> 
> Cc: stable@vger.kernel.org

When you have a bugfix, don't put it last in the patch series, as that
doesn't make much sense if you want to backport it anywhere, like you
are asking to do here.

Please just send this as a separate patch, and do the cleanups in a
different series.

thanks,

greg k-h

