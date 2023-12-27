Return-Path: <stable+bounces-8597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B36181ED10
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 08:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DA861C2122E
	for <lists+stable@lfdr.de>; Wed, 27 Dec 2023 07:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAE75671;
	Wed, 27 Dec 2023 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bh0adTOs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3BD6AA8
	for <stable@vger.kernel.org>; Wed, 27 Dec 2023 07:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B371C433C7;
	Wed, 27 Dec 2023 07:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703663878;
	bh=J8GGbHU6mAI50X0ItHZM9bh5WJvKeKB4yjcKNzH8uAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bh0adTOs1N8Eea7BsJXyWZ2o4uGr81L4MxY1WhpQ3YfnnfYcauShLJUFkjPaj30CD
	 GsMCJMbCCr3X3OLtykImBLvLzJZwLoC39sVb0zmFHPrk4vrzpz7DhR4yjo0xsgteGF
	 T4CgvsLq/HBFgNE1yNKBZ+1/ztqFoI+IFLI76sas=
Date: Wed, 27 Dec 2023 07:57:54 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaime Liao <jaimeliao.tw@gmail.com>
Cc: sashal@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
	stable@vger.kernel.org, jaimeliao@mxic.com.tw
Subject: Re: [PATCH] mtd: spinand: macronix: Correct faulty page size of
 MX35LF4GE4AD
Message-ID: <2023122748-paving-willfully-f53b@gregkh>
References: <20231225092138.114149-1-jaimeliao.tw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231225092138.114149-1-jaimeliao.tw@gmail.com>

On Mon, Dec 25, 2023 at 05:21:38PM +0800, Jaime Liao wrote:
> From: JaimeLiao <jaimeliao@mxic.com.tw>
> 
> Correct page size of MX35LF4GE4AD to 4096.
> 
> Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
> ---
>  drivers/mtd/nand/spi/macronix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

