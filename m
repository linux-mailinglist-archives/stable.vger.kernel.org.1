Return-Path: <stable+bounces-35658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB48961AA
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 02:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 412C6B23E7D
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFE1DDC9;
	Wed,  3 Apr 2024 00:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="DjQCMkeR"
X-Original-To: stable@vger.kernel.org
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A250D527;
	Wed,  3 Apr 2024 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712105507; cv=none; b=TjXHhtsS1DAct6odZ7sHwMNFTQU3nYBxxODTxU4H3geS/jqSUj0m9KPpK+fiyJ2bpvGhlwfIQLo6w9kmZDtVOJHFqaTTZdfSgqNhtkeicqZSGAmpW8gqgCZQogX5HoTBIgeipGtT6L022OYozuCOYR8obrhcNreq3WHshoaLtx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712105507; c=relaxed/simple;
	bh=0LTPYSw44WsDE4pa3i358RNIip66M8KhRlr0vkaofZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk39fP6AEtbpngQbFkBOewkpdInAybvjb44UalQBZTUvpG9g4djUV0Dd4o7jzpnhAxrCH83/04zSZQlkvSgx5O3BDIn4gzrQ5kF9ba01hKNJRJPGAL5U2kBeCG7cP39czxcuf0UUEaxZkmqaKLCNwm8WGiHGkVNoinhdnnBOhWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=DjQCMkeR; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=XuqRIUsAYoHr2TDz/+3tfRgApnmVBxS19Xv6rBUE0Hc=;
	b=DjQCMkeRGCMEjOJzSCjRwH0lxz/Uo9S1C7UzdA3CL69GUttiENqSL1lURRKQ5/
	e3P37nq61eXwRP3PAD2kpbDvsf9GbmhEOO9Ab55BswxsZci+SHfGE2Vw85hXvDa3
	1rUaYinzhBfqstCmLXBrzs6a4iE5AePe066EkTw9tcEJk=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrABHzw4HqAxmit2sAQ--.56935S3;
	Wed, 03 Apr 2024 08:51:21 +0800 (CST)
Date: Wed, 3 Apr 2024 08:51:19 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Fabio Estevam <festevam@gmail.com>
Cc: shawnguo@kernel.org, sakari.ailus@linux.intel.com, hdegoede@redhat.com,
	robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx7s-warp: Pass OV2680 link-frequencies
Message-ID: <ZgyoB752a5R9PU0G@dragon>
References: <20240328151954.2517368-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328151954.2517368-1-festevam@gmail.com>
X-CM-TRANSID:ClUQrABHzw4HqAxmit2sAQ--.56935S3
X-Coremail-Antispam: 1Uf129KBjvdXoWruw1fJw18KFWDuF1DWrWkXrb_yoW3Awc_Ca
	1rJryfGrWUXFs7W34YyF1xZrsYv3yxCrykAF1ftw4a9F1rKrs0qF4agr4Fyr1kXa9Ygr1U
	ta4kAr90qr1kGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0D8nUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGA61ZV6NnqoMcQABsd

On Thu, Mar 28, 2024 at 12:19:54PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint
> property verification") the ov2680 no longer probes on a imx7s-warp7:
> 
> ov2680 1-0036: error -EINVAL: supported link freq 330000000 not found
> ov2680 1-0036: probe with driver ov2680 failed with error -22
> 
> Fix it by passing the required 'link-frequencies' property as
> recommended by:
> 
> https://www.kernel.org/doc/html/v6.9-rc1/driver-api/media/camera-sensor.html#handling-clocks
> 
> Cc: stable@vger.kernel.org
> Fixes: 63b0cd30b78e ("media: ov2680: Add bus-cfg / endpoint property verification") 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Applied, thanks!


