Return-Path: <stable+bounces-3218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27BC7FF036
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCA4282131
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054A747A6E;
	Thu, 30 Nov 2023 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CKCsrxcP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E738F9C
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41B4C433C8;
	Thu, 30 Nov 2023 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701351194;
	bh=NdmIZiVwPEBx/3l+IeegFMEl2spLROeUXcbJJx4Oses=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKCsrxcP3j+L/DIN8Ela4CMVZi7Zr9J+rQMw5A/JXJUciwTDH6EjYhCd/1H9BSdhW
	 5th3kfCPCP+IaPnyZ6x6SwXYQg865JDruh6VicTwKUoVVszUGfoq0kn5/Moxg+Xq9i
	 mpAFCAK4lpRw+j0YaW7taw33Y5FD3YKvezIZPVXs=
Date: Thu, 30 Nov 2023 13:33:11 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: stable@vger.kernel.org
Subject: Re: arm64: dts: imx8mn-var-som: add 20ms delay to ethernet regulator
 enable
Message-ID: <2023113028-petal-persevere-2618@gregkh>
References: <20231128131501.3a3345477530cfdeeb2f0c62@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128131501.3a3345477530cfdeeb2f0c62@hugovil.com>

On Tue, Nov 28, 2023 at 01:15:01PM -0500, Hugo Villeneuve wrote:
> Hi,
> the following patch:
> 
> 26ca44bdbd13 arm64: dts: imx8mn-var-som: add 20ms delay to ethernet
> regulator enable
> 
> Was introduced in kernel 6.5.
> 
> It needs to be applied to the stable kernels:
>   6.1
>   6.2
>   6.3
>   6.4

Only 6.1.y is still an active kernel, all others are end-of-life as the
front page of kernel.org shows.

I'll go queue it up for 6.1.y now, thanks.

greg k-h

