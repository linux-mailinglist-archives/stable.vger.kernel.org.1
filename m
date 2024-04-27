Return-Path: <stable+bounces-41554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C09B8B4698
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7571C218E3
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 14:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A84E4F8A2;
	Sat, 27 Apr 2024 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMOhNz4C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAE3A1C7;
	Sat, 27 Apr 2024 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714227392; cv=none; b=UBiR6KCw3d0AUl5kEMV61s4qeMU2gtJLFzNIr+hvOaLgU8JOMS9AxGXqtC043/2PpHPXwnQV+c/4Vacl71yrVLdHiJwwBsI43f/ZKvjsmJqbp/nomxkP9rqy+2Ts8At/RdieHVDwhnmzTJYyyt9nJELAFTFairUXjziqFSmhjU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714227392; c=relaxed/simple;
	bh=xQKi0Z31TWa/MxE8QEGBp5M+3QYWxt7acba9tI9Qhbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT9aEFlNWbrTvpPaRI86Dxx7jSRF6VAgmG5AZEZ6SsYunraNyj6XNCW+FMpVsY8z5y2T6dHcPI4ZuZKOJYAZYMdfS0BzU93hUSIDvCIRF/nElBOpOLi6M14qcgwvczWFhVY5c2Eukn4NIX+6+VvnGdPnHI0PZbL9A03kFnB9/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMOhNz4C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBE1C113CE;
	Sat, 27 Apr 2024 14:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714227391;
	bh=xQKi0Z31TWa/MxE8QEGBp5M+3QYWxt7acba9tI9Qhbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMOhNz4C+xXv2Zdvu5/HhLdlQhPKNbr8koB0fqwpkFbRmZq9Lmiwru9XiwMnyNTKi
	 5P2qOIvV9YXFiWEdMDBz0N7QvCouZOMnz7ka7uIoToegilWxSZpDNFHT8n8llvozXr
	 5pVgkPLdcKmuFS3uWwB2QubcZYLVGXTa/Rl2PIRi6QghBnlP1HNaSfhINkIu8QFr2q
	 2uaGO9dW5OY2yl3J1r7ieJmachgfgoNBQgJfxCYuNK/sHG4AAjZzXYq0/8tmWAyZY/
	 zlInH9qcp2RGLb3am+lnaJJ56sLi44blTGuCbiuBLOirRIl1nh/tRTYb2NzTx25z7X
	 AdvMjBgtitWJw==
Date: Sat, 27 Apr 2024 15:16:28 +0100
From: Simon Horman <horms@kernel.org>
To: Doug Berger <opendmb@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] net: bcmgenet: synchronize use of
 bcmgenet_set_rx_mode()
Message-ID: <20240427141628.GL516117@kernel.org>
References: <20240425221007.2140041-1-opendmb@gmail.com>
 <20240425221007.2140041-3-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425221007.2140041-3-opendmb@gmail.com>

On Thu, Apr 25, 2024 at 03:10:06PM -0700, Doug Berger wrote:
> The ndo_set_rx_mode function is synchronized with the
> netif_addr_lock spinlock and BHs disabled. Since this
> function is also invoked directly from the driver the
> same synchronization should be applied.
> 
> Fixes: 72f96347628e ("net: bcmgenet: set Rx mode before starting netif")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


