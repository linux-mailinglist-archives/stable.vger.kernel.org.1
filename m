Return-Path: <stable+bounces-161829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888EBB03CD9
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 13:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FD0167F32
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 11:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C7124503C;
	Mon, 14 Jul 2025 11:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPQ2QyAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31181DDC2B;
	Mon, 14 Jul 2025 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491165; cv=none; b=Uk+8Qd24jWG3p3vUSz/G+XO5mTryV7xAiC0/bx2kfVdC8Ua+NWjvDGCCySA3MFC3YSO99IxitIwyNLZ5i8ZPesryC6VvWuIceRuW1JfRk0/S/IAoAih5yCS0Sx9w4LOkkqqgqxvlqZdxwHZPR72jvGAqqSDg0HNbLK1JWrmQKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491165; c=relaxed/simple;
	bh=cPgCiLWJbDjvKBCL1h2VP20MYSDoLy/FVbPzrkJT1cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9Yy7xvBfjQIA3XLYbRI9S4w3kRFwd3Bcz/KH30b8/f+N+pEYUgGERFZfHwswuUx1sEDPfPY0IYUYdlQJWN/80pwTDWq7ASOQrnj4G99c22aKAE679LSQMbTvKtZif4Q4mBVOV2wBzndbPeCKJ8Xu+8sGKa0g0ScJm4tGmVR7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPQ2QyAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE99CC4CEED;
	Mon, 14 Jul 2025 11:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491164;
	bh=cPgCiLWJbDjvKBCL1h2VP20MYSDoLy/FVbPzrkJT1cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPQ2QyAU8v7LxTlyouulXMHR9nqdcTOONxlr7t5eRBiMvcieI+cSp2NO73gMmdZgF
	 9g+CC3gBXPsUrZjg4R9A9axMuhRyC70Z0Lh8cWiULuqZphxIhX/dRmUEQWOGJVybT8
	 PCQ/ZRHhsGlInuWcUpSl1xcLfbHnEnsxY3X6Y0RWpqN6j/oO5ycXyvp+9qJDUumIAZ
	 c/xGOSJneL0RWOT5c1219OwOWowFocB3yBq0+4LNAdlP5Sz5Izd7PLeOAGn7FJi/u0
	 p4492Hl2qa4SjMq+Son3SseJIdIzNK/12zkU+SEnrB7yEGx7y+dsRVwX13G/wYh9M1
	 ySL9C4sqK5OOA==
Date: Mon, 14 Jul 2025 12:06:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: libwx: fix multicast packets received count
Message-ID: <20250714110600.GK721198@horms.kernel.org>
References: <DA229A4F58B70E51+20250714015656.91772-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DA229A4F58B70E51+20250714015656.91772-1-jiawenwu@trustnetic.com>

On Mon, Jul 14, 2025 at 09:56:56AM +0800, Jiawen Wu wrote:
> Multicast good packets received by PF rings that pass ethternet MAC
> address filtering are counted for rtnl_link_stats64.multicast. The
> counter is not cleared on read. Fix the duplicate counting on updating
> statistics.
> 
> Fixes: 46b92e10d631 ("net: libwx: support hardware statistics")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
> v1 -> v2:
> - add code comment

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

