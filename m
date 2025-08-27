Return-Path: <stable+bounces-176486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D38B37F40
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 11:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE641BA1E00
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717502ECE91;
	Wed, 27 Aug 2025 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgVKXSLi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2256428371;
	Wed, 27 Aug 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288278; cv=none; b=bW6ACoy7QROhB1e2lneNvgSQO1GamLbesGhvVnysVgK2gunhr0GatnB79AHi/VVatyE3l5QnBSnVaFXfsf8be2jBRd73gDtCvG+8RJgYARX+YDzb00MTKMMcOG2I422mnl2OLxyaB1otDNvQs9H4A+W5ukXg+lmi2VLWF/45xsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288278; c=relaxed/simple;
	bh=D1p7DvGbiFBfaeO1vt0gRq3Y5mYuYPgPSQ3cdG7XHY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0Xe4aB9A7Y08tnRRKp7QyxEV3te5d1wORIUZ9ILgiLzgB3XbwBSLUTP0qiMmE8XnIzp/X5YABXRW+JJq6AvT0HrExCJMlYQW6U/ja7c+2EM9k8lNf/RTt5DiokQlBF60xnntZUdAuCuv1jJAMPdCCqJaKTHAlt5q4UEpEGm4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgVKXSLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98173C4CEEB;
	Wed, 27 Aug 2025 09:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756288277;
	bh=D1p7DvGbiFBfaeO1vt0gRq3Y5mYuYPgPSQ3cdG7XHY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgVKXSLiK7hhnCMIXJzEVcBtEe3aiX0qjTk1xb2DobiK+GD7gPbjx01v7uScAWk6T
	 hS+M4Z3Pl2JwJlFCBhlaPHKrSArciSnQaDIdyrVqQsuDLR30xVR/7Z6WhbzbXTVMjU
	 dzhLO42XIAIJVAqIaWUUksN9SVeczIOXITfD+HOfrf/Sgc1Qu3iRh2CnzjY+baJy2z
	 DnaogPyOeHTukqUIGveVYiav/q6q7jxJg/uYtYfjvA0+Wa8FkjLRLQFaKPYmcf+YRn
	 RkUm9o0DLf4gsv+l/eNRZIsmy7Ij3lEP5gATSSWN221e6bgLvwzxhQGW9+xB4UVmkP
	 JxtD43Q5TjtXg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urCo4-000000002LW-3dx2;
	Wed, 27 Aug 2025 11:51:04 +0200
Date: Wed, 27 Aug 2025 11:51:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, "Nancy.Lin" <nancy.lin@mediatek.com>
Subject: Re: [PATCH] drm/mediatek: fix device leaks at bind
Message-ID: <aK7VCJ9yOKntjgKX@hovoldconsulting.com>
References: <20250722092722.425-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722092722.425-1-johan@kernel.org>

On Tue, Jul 22, 2025 at 11:27:22AM +0200, Johan Hovold wrote:
> Make sure to drop the references to the sibling platform devices and
> their child drm devices taken by of_find_device_by_node() and
> device_find_child() when initialising the driver data during bind().
> 
> Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
> Cc: stable@vger.kernel.org	# 6.4
> Cc: Nancy.Lin <nancy.lin@mediatek.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Can this one be picked up?

Johan

