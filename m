Return-Path: <stable+bounces-50277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D61905586
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333011C21CD1
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6568B17E911;
	Wed, 12 Jun 2024 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWxb2qoQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65B17E46F;
	Wed, 12 Jun 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203546; cv=none; b=ljVtdQglRXlS5Mt67AXaq5vT01fW0ODcU3xNWu0ywwvk6S8AVaDfHO3cq7kG1sqgvX4Z2QfKTgAdfilk70ZLfMDAT7sjuWBCpGH4MfwIAfKRJbI8pzzSSEjbRF8l+Yol7MI4vltT4b5tW2YfDmucNCWbZT9exJd7mGaRukB7Y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203546; c=relaxed/simple;
	bh=gyrNWe9KzLBAJMK5rRHPXMaZ3/0hf4xbjg1wOTVTEEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nllKzhPnoQYt8+AnZ24giad9U0MJjGHj2mrqGKNqbkUPr5lZDrZNpjsCw9K0U8UIOYW1kWZFU2QERU9Mpu7RXAlXdP/JmYWga00nUGMzeA9/pnHBUJpjLNCSVGCKqi+vjFw75DQbIiHVxCmIWRB8MxFNtOyvrSpahaSsQZRxIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWxb2qoQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB693C3277B;
	Wed, 12 Jun 2024 14:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718203545;
	bh=gyrNWe9KzLBAJMK5rRHPXMaZ3/0hf4xbjg1wOTVTEEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vWxb2qoQZKs/68gSQtchZahCUcBhYXM+pIELKkjbWZlrVX4GC2xf/wYNHnMHI9uz7
	 S/mw5Axnhz8MJ/06gffXEvbC/w8c7E/bKt1L1/HThZS4C8dchJJLGvKthv5hosda40
	 Rle0fbwg4I+ExecB+tMyckMnh73Q859EJa+M9HVg=
Date: Wed, 12 Jun 2024 16:45:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: miquel.raynal@bootlin.com, dwmw2@infradead.org,
	computersforpeace@gmail.com, marek.vasut@gmail.com, vigneshr@ti.com,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	richard@nod.at, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spinand: macronix: Add support for serial NAND
 flash
Message-ID: <2024061250-contend-citadel-7d03@gregkh>
References: <20240605054858.37560-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605054858.37560-1-linchengming884@gmail.com>

On Wed, Jun 05, 2024 at 01:48:58PM +0800, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> commit c374839f9b4475173e536d1eaddff45cb481dbdf upstream.

No, this isn't that commit, it's just a portion of it :(

Please backport the whole thing, and leave the original signed-off-by
lines and text in it.

Also, this is needed for 5.10.y kernels, right?  Please provide a
backported version for there, otherwise you would upgrade your kernel
and have a regression.

thanks,

greg k-h

