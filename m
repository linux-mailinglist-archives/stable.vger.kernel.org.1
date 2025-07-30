Return-Path: <stable+bounces-165203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC8B15B2C
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906C33A7D59
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 09:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6756266B66;
	Wed, 30 Jul 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msAu1NXX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A319D065
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866217; cv=none; b=XtqIT//ltKtVA/ITDSyx5WDepEB4GbJ/Q2Tjn77/A1MYx7+LKpSVnXPx7mK9WOLEzkht5A0FtUaMfFqAzTbiaU0K1RQ+xy1VEt5MlP4Y8evx/aevtSO8DcCbjY3ZjR6qkkHqp3zd6WdXy4d/FInwpsyKmVFa5CmPYU/Tk6teUvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866217; c=relaxed/simple;
	bh=rpUXLjFgouFug6BoRpKzR6ROMRP86sWKSEvgWHsFRnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzg/x/osYB1AX3Wyv/6Jvn940PllMsJgmFRJDo42rdycqUgvBhx83fJoqB2uHq2CoTpu8W78lt4F7A1qBrV3gN+EJKmBGPN4yEmX7sDhLIxn+w2EimhxYtm9zClDia0eLITZI4k9e+IqjaI+g6McXlpBbbV0/gWMe051awAL0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msAu1NXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B42C4CEE7;
	Wed, 30 Jul 2025 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753866217;
	bh=rpUXLjFgouFug6BoRpKzR6ROMRP86sWKSEvgWHsFRnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=msAu1NXXwg22E31wfW/APfmdHn9LtQ0xH2NUVe0APtO78M0kZsL+x1G7S21bdI0pD
	 O+8F3m5IB/yuBY7y+RkbQIJLgYVMxJVb0o1KiLKMUY5YwRLdUWlbLMmZrs+8sjolZX
	 ExCwjP1ZtuPH32VshUetp9hTg2ncvdp5n3/dGI6Y=
Date: Wed, 30 Jul 2025 11:03:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH 6.6.y 5/6] i2c: stm32: fix the device used for the DMA map
Message-ID: <2025073007-swapping-upcountry-fd02@gregkh>
References: <2025072104-bacteria-resend-dcff@gregkh>
 <20250723001942.1010722-1-sashal@kernel.org>
 <20250723001942.1010722-5-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723001942.1010722-5-sashal@kernel.org>

On Tue, Jul 22, 2025 at 08:19:41PM -0400, Sasha Levin wrote:
> From: Clément Le Goffic <clement.legoffic@foss.st.com>
> 
> [ Upstream commit c870cbbd71fccda71d575f0acd4a8d2b7cd88861 ]
> 
> If the DMA mapping failed, it produced an error log with the wrong
> device name:
> "stm32-dma3 40400000.dma-controller: rejecting DMA map of vmalloc memory"
> Fix this issue by replacing the dev with the I2C dev.
> 
> Fixes: bb8822cbbc53 ("i2c: i2c-stm32: Add generic DMA API")
> Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
> Cc: <stable@vger.kernel.org> # v4.18+
> Acked-by: Alain Volmat <alain.volmat@foss.st.com>
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> Link: https://lore.kernel.org/r/20250704-i2c-upstream-v4-1-84a095a2c728@foss.st.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/i2c/busses/i2c-stm32.c   | 8 +++-----
>  drivers/i2c/busses/i2c-stm32f7.c | 4 ++--
>  2 files changed, 5 insertions(+), 7 deletions(-)

This is already in 6.6.100, so are you sure you want it again?  :)

Care to redo this series?

thanks,

greg k-h

