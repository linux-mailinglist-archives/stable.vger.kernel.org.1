Return-Path: <stable+bounces-58055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A966F9277C4
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 16:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAC81C20EE0
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41A21AED50;
	Thu,  4 Jul 2024 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfL5cptN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7E41A81;
	Thu,  4 Jul 2024 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720102038; cv=none; b=B9mczxcJx79zeTF8nPNP8xZiinFLa4oD+p4df9GphhfZL2VIWusT14rFi1Z74H35wagBrbLyte5jyqN48fHYWwZUjbz9bMzlH1nte1RQ24zkvn5xp6UnW7jpv16e/Gv76zb3JJwyViDp7/IZGLF7eWZaytN52u9p+l5MBRcn2+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720102038; c=relaxed/simple;
	bh=3/qvQlW/P53Rcj1MyrqxxazGgI/iuShcKu8AoUpghDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H98lBKF5kOmI8wCC61u0fOJ2vrAvYJ21fUgA63BJrdZs75Vhxug4PatKWKI1vd81fXBR2X3x9JkHM/0TtLtuap7UKGNTKftPElbK9sEUwDQi/k1TMK4gAoHX1hSjJVF+/AZappD3E8Me24Hqaz8lKd0tIcGQuU66MPvPxvkbtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfL5cptN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3269CC3277B;
	Thu,  4 Jul 2024 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720102037;
	bh=3/qvQlW/P53Rcj1MyrqxxazGgI/iuShcKu8AoUpghDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rfL5cptNuZ1YXnB62bWt+Nix3Ap9MUcZ1ZS6o33/TFp2HtT1tSecrsssyaAOTFt4A
	 EmBOicavSpHCQqARXP8ijEakwx3vcZb0SpRXdteOmMTstGl/Yc30eZHor+U37INq+g
	 wQCoKiie3eZ8m5+VD2/CPIEDNJjIZ4xAoJhR1DNpVl0U6KMZhGzb4HAWy6GV6e8Rvv
	 lg3I1UA1GpZQ2WoO1NTAoNwDUBQy4Yw+FR5UHxwHy/CkmUxJKs/ziwnCoEgTu7s+XO
	 c79QPdkoKv4/GClBqovNm7VWINTlMs3I8HJNkCrtaCKkw1BPctvUau984hSnls4vqS
	 99lDnNEETrKyA==
Date: Thu, 4 Jul 2024 07:07:16 -0700
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
Message-ID: <20240704070716.118db29e@kernel.org>
In-Reply-To: <TY3P286MB261180E580D838704E6123B598DE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <TY3P286MB2611AD036755E0BC411847FC98D52@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
	<20240702110224.74abfcea@kernel.org>
	<TY3P286MB26119C0A14621AD8D411466A98DD2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
	<20240703164818.13e1d33c@kernel.org>
	<TY3P286MB261180E580D838704E6123B598DE2@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 19:06:29 +0800 Shengyu Qu wrote:
> PCDN means P2P CDN[1]; This modification already exists in a heavily
> modified openwrt fork here[2] for over 2 years so it should be working
> with to regression. Although a higher limit would be better for PCDN use
> case, but only newer devices like MT7986 supports 32768 max entries.
> Setting to 16384 would keep old devices working.
> 
> [1] https://www.w3.org/wiki/Networks/P2P_CDN
> [2] https://github.com/coolsnowwolf/lede/blob/2ef8b6a6142798b5e58501fe12ffd10b0961947f/target/linux/ramips/files/drivers/net/ethernet/mtk/mtk_hnat/hnat.h#L604

Makes sense but not a fix, please resend without CC stable and without
the fixes tag.

