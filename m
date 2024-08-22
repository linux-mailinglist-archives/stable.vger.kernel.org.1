Return-Path: <stable+bounces-69855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4ACC95A890
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 02:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4C031C21707
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A93237E;
	Thu, 22 Aug 2024 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IqMA4a0v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C718E
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 00:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285070; cv=none; b=NTXkvIEukj7DRYqeQaU03BcvsD3KiklOlRdK2zhakMgwp1X9RasqysNb6ovI/zXUxO1EcyMGwkXnxDoRkKaq0B04RvnmgTE1F7c2wfk45/Lbx4umo4GBeScNv5VFlEDiCO5Os9WqMvu5Ig5JazRNTp7t28pEWIHi17SASZVOAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285070; c=relaxed/simple;
	bh=p7e9kpSjZy6gCRWogAgen/0OW4/VBMqzTxpr1qKS9hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=le94xC6UncYh6QhRKyOVeSHQio5YpFhrTGD/Xr5R0IZMhGcdCgvmDI7gPQWqFNFuFMAvr4I7sRHI+LscyhQdGvUUd7gRnlG8DOJqGleHLL+LRVadR661A6YEJ3MdyoL2y5XePw6TXnPrilAixPK6cyKgdp3MPNEzkoA0XcvH1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IqMA4a0v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636F2C32781;
	Thu, 22 Aug 2024 00:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724285070;
	bh=p7e9kpSjZy6gCRWogAgen/0OW4/VBMqzTxpr1qKS9hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IqMA4a0vVUypRxaaVh5Gmrfdz57CqvdmsAMoLKkz7TIi3TvnsfI5c8hm0m2AGHs+9
	 gF56pibxopIdAHbBvaCAhvXxwSVJ0PTx9W7TLtnmLAIWd2Nt7k5fITiMKx9jwOBluQ
	 ORxYgB+WyhUb9y7zEpTsIVCkkV7++HvvmfNTz4gw=
Date: Thu, 22 Aug 2024 08:04:28 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 6.6.y] stm32mp15: WARNING after poweroff command
Message-ID: <2024082217-securely-anybody-ff17@gregkh>
References: <1c1c2afd73b14a9bbdc918cfd5813558@dh-electronics.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1c2afd73b14a9bbdc918cfd5813558@dh-electronics.com>

On Thu, Aug 15, 2024 at 03:00:47PM +0000, Christoph Niedermaier wrote:
> Hi stable team,
> 
> I would suggest to apply the patch
> 470a66268856 ("i2c: stm32f7: Add atomic_xfer method to driver")
> from 6.7-rc1 to the stable Kernel 6.6.y.

Now queued up, thanks.

greg k-h

