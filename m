Return-Path: <stable+bounces-176687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6B6B3B4B0
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 09:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48C7C7B71F5
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 07:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4CA284B4C;
	Fri, 29 Aug 2025 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh7eyiPa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F023ABBD;
	Fri, 29 Aug 2025 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453758; cv=none; b=rjg1L0tziqTN6Dqk6mNRRM8qwhfcd5ED7UUzI6bPd0i+/yHyA5IHvL/u6ghBReIPp42jeZKp/hn/T4xP/l7ccRx/0F/m+b/4JakfGUjDCw9XfTXZRbnk5Mon5B2x9RPO7ZyFLal4wjmtDp71g8Qg8hyTN9BKJzupc22kAoKOhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453758; c=relaxed/simple;
	bh=dF+v6pBPXAEvo6aOXOvywP1ufSrZor0h7MkaWLQK5dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqTML+xOpSNyLgppIm7av5Ez0mU2bshX610YHrRI/W1c/1w1V9pkIuH+V8nJmM9sircuFfUmtWf7/1EKc5ukLcsfAYu+KCxEXkIvLRofBDcomXN256FjSEiEdjjz8Spg0CnIG/igHYLp/6Mgqk414EzB5wZ/pjsy6jbEmsIu7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh7eyiPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF26DC4CEF0;
	Fri, 29 Aug 2025 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756453758;
	bh=dF+v6pBPXAEvo6aOXOvywP1ufSrZor0h7MkaWLQK5dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jh7eyiPa+eTuVCyVjfAOPherneBnYDfNTkkbV3vRkFZt+w3aJYb3ZgmwsHTGBeCV8
	 9opq4JF0YiaNpyxxy4hJGoP0ArtNLmEfS3K2BNjPgFUWeJpngtBvF1sfX9P19pIC24
	 q0Ji295VEt2zSosrb/wFyYW8l/S8w56yvuEsyiXH5Nvy6DgTYWEwvreqjwDTDotVaI
	 +AJgHkhAiEKMcXw8F2FG2loRDBSqa5z8+sPBTJsKFkuOwQFMHyAMubkbs8lfyIqbEY
	 m7lIpT/gqMkddw2gO5F2hbZLpSwVLCaLew3c61ViQFr3EVP2zo4r//rxrpYVVLQGwE
	 p7tqkgo4TLyfA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urtr9-000000000Zj-07S0;
	Fri, 29 Aug 2025 09:49:07 +0200
Date: Fri, 29 Aug 2025 09:49:07 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, "Nancy.Lin" <nancy.lin@mediatek.com>
Subject: Re: [PATCH] drm/mediatek: fix device leaks at bind
Message-ID: <aLFbcznLUutbMo6r@hovoldconsulting.com>
References: <20250722092722.425-1-johan@kernel.org>
 <aK7VCJ9yOKntjgKX@hovoldconsulting.com>
 <CAAOTY_-CijzQqrRUf_=cQbTUSybN3GT46q0vx1139mmZub_OfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAOTY_-CijzQqrRUf_=cQbTUSybN3GT46q0vx1139mmZub_OfQ@mail.gmail.com>

On Fri, Aug 29, 2025 at 07:51:23AM +0800, Chun-Kuang Hu wrote:
> Johan Hovold <johan@kernel.org> 於 2025年8月27日 週三 下午5:51寫道：

> > On Tue, Jul 22, 2025 at 11:27:22AM +0200, Johan Hovold wrote:
> > > Make sure to drop the references to the sibling platform devices and
> > > their child drm devices taken by of_find_device_by_node() and
> > > device_find_child() when initialising the driver data during bind().
> > >
> > > Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
> > > Cc: stable@vger.kernel.org    # 6.4
> > > Cc: Nancy.Lin <nancy.lin@mediatek.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> >
> > Can this one be picked up?
> 
> Ma Ke has sent a similar patch [1] before you. And that patch fix more things.
> I've already pick up the final version [2].
> 
> [1] https://patchwork.kernel.org/project/dri-devel/patch/20250718033226.3390054-1-make24@iscas.ac.cn/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?h=mediatek-drm-fixes-20250825&id=1f403699c40f0806a707a9a6eed3b8904224021a

I'm afraid that patch is completely broken and introduces a potential
use-after-free by adding a bogus decrement of the OF node refcount.

I suggest you drop that one and pick up mine instead which is correct
and cleaner.

Johan

