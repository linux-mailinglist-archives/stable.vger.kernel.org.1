Return-Path: <stable+bounces-3221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F41B47FF066
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93473B20E75
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA13482C9;
	Thu, 30 Nov 2023 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SoYyVwv+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53AD38DE3
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 13:42:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1382CC433C8;
	Thu, 30 Nov 2023 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701351751;
	bh=hQ/RagFiP8S7jcAu4xKFuWQvjo1jYf9ATTjsPi8zRN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoYyVwv+YAX+XpiEXzB4bFYMQhZmN57ExLH64rUSOV4SW8/QFJXrQxz+MCsuCjG6e
	 yfOGes/ycUfxYURxLwHR32fAj+GJJkWj6mhFaDiWJZo/M5FVMkS6rYxJE1JnPSxXd4
	 U2Q5iQnh1zYcjlsfJ57+vmeeSKcRKcIrzRzHwHaE=
Date: Thu, 30 Nov 2023 13:42:27 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Yuta Hayama <hayama@lineo.co.jp>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Claire Lin <claire.lin@broadcom.com>,
	Ray Jui <ray.jui@broadcom.com>, Kamal Dasu <kdasu.kdev@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH 4.14] mtd: rawnand: brcmnand: Fix ecc chunk calculation
 for erased page bitfips
Message-ID: <2023113017-dictator-rotting-6bbe@gregkh>
References: <1dfa7e7f-233b-43da-b0ea-0ad3b1f69a37@lineo.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dfa7e7f-233b-43da-b0ea-0ad3b1f69a37@lineo.co.jp>

On Wed, Nov 29, 2023 at 05:29:13PM +0900, Yuta Hayama wrote:
> From: Claire Lin <claire.lin@broadcom.com>
> 
> commit 7f852cc1579297fd763789f8cd370639d0c654b6 upstream.
> 
> In brcmstb_nand_verify_erased_page(), the ECC chunk pointer calculation
> while correcting erased page bitflips is wrong, fix it.
> 
> Fixes: 02b88eea9f9c ("mtd: brcmnand: Add check for erased page bitflips")
> Signed-off-by: Claire Lin <claire.lin@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Yuta Hayama <hayama@lineo.co.jp>
> ---
> After applying e44b9a9c1357 ("mtd: nand: brcmnand: Zero bitflip is not an
> error"), the return value 0 of brcmstb_nand_verify_erased_page() is
> *correctly* interpreted as "no bit flips, no errors". However, that
> function still has the issue that it may incorrectly return 0 for a page
> that contains bitflips. Without this patch, the data buffer of the erased
> page could be passed to a upper layer (e.g. UBIFS) without bitflips being
> detected and corrected.
> 
> In active stable, 4.14.y and 4.19.y seem to have a same issue.

Both now queued up, thanks.

greg k-h

