Return-Path: <stable+bounces-41553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED538B4696
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 16:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C211C215A5
	for <lists+stable@lfdr.de>; Sat, 27 Apr 2024 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559B54F8A0;
	Sat, 27 Apr 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy+GlREh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC43A1C7;
	Sat, 27 Apr 2024 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714227381; cv=none; b=JER8DkS0RxuIkJujZ8mSJ/4a4Iypp7qKH0WCclGA5/FuICBsxSAoCPav3MBtIb3Je/tPSvAnNfGmLSdmpRp8invj7yfcjIMjdWVv1T58WIgb/gBCth7RzW3d/2GZxmUIc1ID1vODXQq+Ren8LP+1Jse0JHgOa/5PFCPjeiz4NZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714227381; c=relaxed/simple;
	bh=elTIV90iF+gVydQggfWzxK0FxlGGxTMeXqH1soQ263o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IodWcin4ZJorDKFrXqy75koYahH349EouWHc+POLLKJBNZYtrht3SyNRYpuHeZ8Xf+53rWnpCqh4wmrqky+DSPXwxm4ia6Hq0if0Z4db9CegN1JsGuPsKi5dc0ZcRFSMJrztoF+UWYKM8hoqUhO/QUV3rzkwDn+vH5qnupKJEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy+GlREh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8FEC113CE;
	Sat, 27 Apr 2024 14:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714227380;
	bh=elTIV90iF+gVydQggfWzxK0FxlGGxTMeXqH1soQ263o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sy+GlREhK1GvGVYCWt30QMN5PTWPGvSCQ/mPfm+OuQq4xxyQgFmPilN+bg3HE7ROi
	 MKqLleJeY4Xc6y3JDDqlLqEL1Rj0BJqM2pwf/HkEDUtKqmo6TV8rLqogqET7072b8U
	 t3xz+8fG+T7wEspdmJfpD53I51kSjibGh1MJmphq4lxCo1ev7HwolrQD4AYeEYEPLo
	 2KVuS5oBM6ongFJlOXiJNrqcOpI2LD8Rqi2+pfdwXzblu5Y183EXVExNMA2PCNTRbh
	 2AL08/eAwM3DvJlJ7n47bxnAlGH9Y6fHl1ExufjJObwX7P98I3XTfYEf95h+akKvC8
	 7Bj+GeUf4sH4g==
Date: Sat, 27 Apr 2024 15:16:17 +0100
From: Simon Horman <horms@kernel.org>
To: Doug Berger <opendmb@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
Message-ID: <20240427141617.GK516117@kernel.org>
References: <20240425221007.2140041-1-opendmb@gmail.com>
 <20240425221007.2140041-2-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425221007.2140041-2-opendmb@gmail.com>

On Thu, Apr 25, 2024 at 03:10:05PM -0700, Doug Berger wrote:
> The EXT_RGMII_OOB_CTRL register can be written from different
> contexts. It is predominantly written from the adjust_link
> handler which is synchronized by the phydev->lock, but can
> also be written from a different context when configuring the
> mii in bcmgenet_mii_config().
> 
> The chances of contention are quite low, but it is conceivable
> that adjust_link could occur during resume when WoL is enabled
> so use the phydev->lock synchronizer in bcmgenet_mii_config()
> to be sure.
> 
> Fixes: afe3f907d20f ("net: bcmgenet: power on MII block for all MII modes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


