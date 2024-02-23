Return-Path: <stable+bounces-23428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79C28608B4
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 03:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A99DB2266A
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 02:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAA38F66;
	Fri, 23 Feb 2024 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PT8ViY0b"
X-Original-To: stable@vger.kernel.org
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4854B653
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 02:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708654218; cv=none; b=Y0sT4Q9UeELrgbyviG/Vr8ErvSExaYX7GnZLA9MlmZhlcIsL0B5c2fdG4bE6YMfRH9bO3kWZwXBg3FcUmZ9ccGgP1Uyd7sBlPegD7d2HPFwJhv17Sh0+VACYx4U2Hw2HTjxmpCJg5Z+hxp5knCF1DaRAiYwve+fcRnQmWvpXscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708654218; c=relaxed/simple;
	bh=AC8GLroEE/mfyl8d66gGfPlLhH/uQP/BIlOFPrsoABU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXozM0asOJANTiprR1htfLgqOdTSjL3wZqr3dSAQ1PNiulKN5mEkFrIWEHY+RfS7Q2RMBvmnn91+vqeiUAxHc/BBE1GSEMLtKnWehLJ6rXGfNopGRmS1e2p8KBi3VmH6qK16/bo1QdFabztIlhUKXrNbC7QQS7pUHooFgNJaQWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PT8ViY0b; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=O4jQCkrIue+a7CDBd2IdF0BDjP3gyKYKtwU+yBN/8g0=;
	b=PT8ViY0bWYZP0pwZqUCzyQrUyAzv6IuDTVAKIaotdwbDX6I/cuERrE95+HPN3g
	5Xlzxrg5mi0CjQFiXcxB7qFEfbX2stM0ULw9QZXj6td4H1Uxh6N2Y1IbGVK5tv2u
	X6sm99w8TTSxCTj9KX8LRp2T9bv145+xN4GgdHNUedV2s=
Received: from dragon (unknown [183.213.196.200])
	by smtp2 (Coremail) with SMTP id C1UQrACnr37t+9dlOH0sBA--.12015S3;
	Fri, 23 Feb 2024 09:59:10 +0800 (CST)
Date: Fri, 23 Feb 2024 09:59:09 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawnguo@kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: imx_v6_v7_defconfig: Restore
 CONFIG_BACKLIGHT_CLASS_DEVICE
Message-ID: <Zdf77f97P0GPpfi4@dragon>
References: <20240201180054.3869350-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201180054.3869350-1-festevam@gmail.com>
X-CM-TRANSID:C1UQrACnr37t+9dlOH0sBA--.12015S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrCr1xuw4ftFWUZr4xGw1DAwb_yoWxArcEyF
	40yrn7XFWDXF47uwnrJFs2vrWI9w4UAFykZwnYka9IganxK3Wvq3WaqrWkZFW3Z3y5CFsx
	Za18Jw4Fyw4xXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbcAw7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGA6NZV6Nni7qbQAAsa

On Thu, Feb 01, 2024 at 03:00:54PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit bfac19e239a7 ("fbdev: mx3fb: Remove the driver") backlight
> is no longer functional.
> 
> The fbdev mx3fb driver used to automatically select 
> CONFIG_BACKLIGHT_CLASS_DEVICE.
> 
> Now that the mx3fb driver has been removed, enable the
> CONFIG_BACKLIGHT_CLASS_DEVICE option so that backlight can still work
> by default.
> 
> Tested on a imx6dl-sabresd board.
> 
> Cc: stable@vger.kernel.org
> Fixes: bfac19e239a7 ("fbdev: mx3fb: Remove the driver")
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks!


