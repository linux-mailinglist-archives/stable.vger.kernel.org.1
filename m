Return-Path: <stable+bounces-56884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E849246DE
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 20:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C61F266AC
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 18:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD20B1C230C;
	Tue,  2 Jul 2024 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmpIGeUY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743061C0076;
	Tue,  2 Jul 2024 18:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943346; cv=none; b=SV2MMKGEIGhoXRTwSHipzkPViGR5s1uBc/3IuhIV7wX0EU67JG3ls1XBuiUDywwB2O/7BFQpmCW14wPrL9BpL79HACriNVlxfYugxUjN6IHZhvLp+/9v+AI+HTNHmi03HtxkJTb1MB17w6/91HUF871FPoYXe0LEWI90MPbJUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943346; c=relaxed/simple;
	bh=3I5R4eg4Zq3QWN7/2sDahE3dHxNDQxWwiNfojeOQsmE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pObcfaLXq5aUdwhZiouXS6iFZSCmg/lqK3BAHEgPIUYYSc5iVopXoswV9V1f/4IF04oLw86R3vYvbMzw/p9L1J9KQor51Gvo26LTM9bazXyl3LTML+61H5JSN6q5FIdzduLkRMjxYbdYFM6a9VgdA0VcM0qRJ7dp7qZ2r8kFh9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmpIGeUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB84C116B1;
	Tue,  2 Jul 2024 18:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719943346;
	bh=3I5R4eg4Zq3QWN7/2sDahE3dHxNDQxWwiNfojeOQsmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nmpIGeUYd/+hJ0mr7LFvX8LNQn8dl+k16XwQFFarHYJ8LK5kIJRXebXIr249xaYcK
	 RVe2pJv9bRhYS0WZKozDfqdDeARpqyrralgv8TaudMzfVVpR/Ixz8YYx1w+yJI6iDD
	 5Y9LQr7aa1nnlqcKpTnI71eQUAi/a6yfRqqoYhbWRZi501b/ZAsdFs7bwxcZY5EIHj
	 sjyWH4k08Z6eVBNcKhAicr4vzPdybyzNV6/1t8XYaoYnSuxSOaGZ9EyEg23TL11Hsu
	 KInmuLOh54VRhIZLBQPCxS3usuqewJs4ped4MvEOruZC2Yv12K1uDxrzwoloKL/L7R
	 zh8thhtmxEnfQ==
Date: Tue, 2 Jul 2024 11:02:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 lorenzo@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, pablo@netfilter.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, Elad Yifee <eladwf@gmail.com>
Subject: Re: [PATCH v2] net: ethernet: mtk_ppe: Change PPE entries number to
 16K
Message-ID: <20240702110224.74abfcea@kernel.org>
In-Reply-To: <TY3P286MB2611AD036755E0BC411847FC98D52@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <TY3P286MB2611AD036755E0BC411847FC98D52@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 19:16:54 +0800 Shengyu Qu wrote:
> MT7981,7986 and 7988 all supports 32768 PPE entries, and MT7621/MT7620
> supports 16384 PPE entries, but only set to 8192 entries in driver. So
> incrase max entries to 16384 instead.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Elad Yifee <eladwf@gmail.com>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> Fixes: ba37b7caf1ed ("net: ethernet: mtk_eth_soc: add support for initializing the PPE")

nit: Fixes tag usually goes before the sign-offs

This doesn't strike me as a bug fix, tho. What's the user-visible
impact? We can't utilize HW to its full abilities?
-- 
pw-bot: cr

