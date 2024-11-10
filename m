Return-Path: <stable+bounces-92045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F399C32D5
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 15:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDD61C209D2
	for <lists+stable@lfdr.de>; Sun, 10 Nov 2024 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7C739ACC;
	Sun, 10 Nov 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuZxxufi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686B7322B;
	Sun, 10 Nov 2024 14:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731249841; cv=none; b=jahD1sWK/ZJxTxzlikIMMqPowgMqqrZ8oLz+yqNvByWfzjFajM26Qj1FjU3MW5Ij+NidtjImXmpHcMivAMi64g7Rcy+Tnnb9qrtGUIpxcYKJqnEDJJM3BgnX97GrGZxu6X3SX/lEdov3lfNdg11v+R/XUaokUy65cJd4RwC2z28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731249841; c=relaxed/simple;
	bh=x0dLFVFwwgPAJrBiWJRBh6DZ9bipzieEb94nWiORQqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdRuM0j63Q6ji5v2KC+mk4vQzTyhcS+1OLGrfq8qheiOk+PBBG9mt93fXQ/3H11LiHLxjQaiOWyyAq8Frv7Xql4+7Sb5kMdk5cMOqQjca1w5UmqSi//52rDMQUzt7jcr84AsVTx1Pnr4XDamyOsj0MaHT7b40NA/1TNDMIqNDG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuZxxufi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B5DC4CECD;
	Sun, 10 Nov 2024 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731249840;
	bh=x0dLFVFwwgPAJrBiWJRBh6DZ9bipzieEb94nWiORQqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kuZxxufi+1/CaWf2jVlwgQIhaLfF8ZmXqakGCnFrQR1H3vvJklnB3SalUP81HSCB2
	 4NReGYNhNEJc5xE8lpx2cZwytS66zOZjUw8EZpR0q3BH72TiptlnMZnVJYrHBgKOXj
	 zOYQDhBFm/0mMLmnb6aAw71fVkovJehldoinKmv94KSw2X219sYZDOiyv6YpjawDfn
	 CDkQliBIl46n+7rimmVGNfQmFz1bY/wHtWtYFo/OLx2QWG0IEj8e2hy+ANSpZsCFet
	 dziRV1AvGZ24lM8MZxVA4LkKXP7nDusVW1cbxb+uvXs8NUcfSq54dZPHV4t8Lb7hrc
	 ahyw2T7U6UdaA==
Date: Sun, 10 Nov 2024 14:43:54 +0000
From: Simon Horman <horms@kernel.org>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, stable@vger.kernel.org, pabeni@redhat.com,
	pkaligineedi@google.com, shailend@google.com, andrew+netdev@lunn.ch,
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com
Subject: Re: [PATCH net] gve: Flow steering trigger reset only for timeout
 error
Message-ID: <20241110144354.GT4507@kernel.org>
References: <20241107183431.1270772-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107183431.1270772-1-jeroendb@google.com>

On Thu, Nov 07, 2024 at 10:34:31AM -0800, Jeroen de Borst wrote:
> From: Ziwei Xiao <ziweixiao@google.com>
> 
> When configuring flow steering rules, the driver is currently going
> through a reset for all errors from the device. Instead, the driver
> should only reset when there's a timeout error from the device.
> 
> Fixes: 57718b60df9b ("gve: Add flow steering adminq commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

Hi Jeroen,

As you are posting this patch your Signed-off-by line needs to go here.

--
pw-bot: changes-requested

