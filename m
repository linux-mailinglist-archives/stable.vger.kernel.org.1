Return-Path: <stable+bounces-163379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE5B0A67E
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 16:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADB71C426F3
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D7B2DCC03;
	Fri, 18 Jul 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGDQn2BW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6015A86352;
	Fri, 18 Jul 2025 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849755; cv=none; b=tVUxp6qs6isNbLRHujGjJfLrjTkFMNOXF9y4MsYkZItXD7dqeibXc1LOl55OjYsZtaZPeUCf2IE5Ypuodyca5rr6vilyh2piESg0RY9YMKzLBY3Q7/6gYF7Mz28WC+48rETXpann+bokMccy1fJdon7e+I/KGCxtesi7RcLeaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849755; c=relaxed/simple;
	bh=1//bOgGrlcwx6rGRdmOwNwlbt1ABy5JkfcQrWXx5Dp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIDs6BvVFrF4QVQlkEDwUCHlPehTvJsoQI0Cj1x2bUUSWZ2zE/V9lgnwU2XAn85jc7djq56i5IGPG7bElGgkKZLEYe/+0kdCg6YV9GXs3rXt6GyaJ8UkDITTKbAu1QnfF0Zy3Hg2lAhvIeymeG/ATpuiNn4HR63men7TDhRmWco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGDQn2BW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C950EC4CEEB;
	Fri, 18 Jul 2025 14:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752849753;
	bh=1//bOgGrlcwx6rGRdmOwNwlbt1ABy5JkfcQrWXx5Dp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGDQn2BW7PXKjts3/RMkZcVeO1Kz7c5CV15Z3xuYdKXof0IL+yUlFNg0XCwpNC9cK
	 xFuZtsDxZTyIOhakFN1IfbkDwLJF/atCVjgyhXAveZklomDLc3HK7zJkb1o9mDZJpv
	 +82Kw7qjSzsBYa7Ah7xVEaiJ+PzfYaICpccUrH9SlPYMxPtukNvryZQUHTwBbeVGmi
	 cWYWdSrxy4G0AznxHaQDwschoyFLWR0ym0nPSFFZDn4UEmCZ4c7dgBd05M7W8DQtvu
	 J1qx30aaphMalbJhNbK2ieR+J7615tu7A4Z034H91PARdfQavc2GLPsvIdNo+tG0SO
	 UGjcRghUM750w==
Date: Fri, 18 Jul 2025 15:42:29 +0100
From: Simon Horman <horms@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: ioana.ciornei@nxp.com, davem@davemloft.net, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] dpaa2-eth: Fix device reference count leak in
 MAC endpoint handling
Message-ID: <20250718144229.GG2459@horms.kernel.org>
References: <20250717022309.3339976-1-make24@iscas.ac.cn>
 <20250717022309.3339976-2-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717022309.3339976-2-make24@iscas.ac.cn>

On Thu, Jul 17, 2025 at 10:23:08AM +0800, Ma Ke wrote:
> The fsl_mc_get_endpoint() function uses device_find_child() for
> localization, which implicitly calls get_device() to increment the
> device's reference count before returning the pointer. However, the
> caller dpaa2_eth_connect_mac() fails to properly release this 
> reference in multiple scenarios. We should call put_device() to 
> decrement reference count properly.
> 
> As comment of device_find_child() says, 'NOTE: you will need to drop
> the reference with put_device() after use'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 719479230893 ("dpaa2-eth: add MAC/PHY support through phylink")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


