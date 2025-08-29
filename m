Return-Path: <stable+bounces-176688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8C9B3B4C5
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 09:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02956983C58
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 07:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7836D28505C;
	Fri, 29 Aug 2025 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGOt9k6J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A40285040;
	Fri, 29 Aug 2025 07:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454019; cv=none; b=Xc7YVLYMierNgBEBX/NXtO+DAg59gkVsBBw4TaxwdFzQ404Msvj4EKeFq8LFLQHpVdOqK2vVL2jZNBh2ZU6YhTK+EFXnLrvZvvzPRL1KhiwPlNvlKQNjNkxw+JrZC5hrGS8VWa2P4vP/0b1KZXfS99d0rcMbQDoOJkn0PNb0QX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454019; c=relaxed/simple;
	bh=lGnjYgv5elXMwfPyxfMjkMn1zViVKrlNZ159H/ar7Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsCvG/W1sL6mB/16TdwlgiG6wDTs9nQ8mY4spVuywlplrBC9FtbAs5ySeCCaGOM2Awr1B2k0DOSMwGeRqo5IRmsy3XoIuRVn56C4+SlZURaJFqKxbPr86fJjnz+MdY/1+fYVgr2cjnB2gwgzTR5rjW2sXp1lDbJrLljiv0zQCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGOt9k6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C5FC4CEF0;
	Fri, 29 Aug 2025 07:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756454018;
	bh=lGnjYgv5elXMwfPyxfMjkMn1zViVKrlNZ159H/ar7Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KGOt9k6JGUZm/s/BiB2row7YwILB1Wv9QyejLhNWD2L1ohpPgQtX52KGXrGK1Trd1
	 C+WV3xgYVoOVvrGKjrDxxZ9DXMIkAu9wg5pc/QWoZImosfpFINNXIfEHNb6MV4XxsL
	 i3Jyh6T+vdnEi26V2a1CQlNksFjbyCgzEybK7NydCv2Rx+TIIf/7jmqAUV0IsG9aX4
	 DvejgTIDG3gV8I+89DKvFjUK4wZpQkcdhWOiNKs1H+riOkIzIUr47oY6TFWjYPvn2P
	 jBzvaMohNV0D3/pWSGgdSgNpBScQbXwcZWfPMpzV/xrKX9/RXAPIkp6KoeZe6p29oR
	 h1Ka89zJ+O5PA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1urtvL-000000000g6-3mNQ;
	Fri, 29 Aug 2025 09:53:27 +0200
Date: Fri, 29 Aug 2025 09:53:27 +0200
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
Message-ID: <aLFcd1ZLr0HUm-CM@hovoldconsulting.com>
References: <20250722092722.425-1-johan@kernel.org>
 <aK7VCJ9yOKntjgKX@hovoldconsulting.com>
 <CAAOTY_-CijzQqrRUf_=cQbTUSybN3GT46q0vx1139mmZub_OfQ@mail.gmail.com>
 <aLFbcznLUutbMo6r@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLFbcznLUutbMo6r@hovoldconsulting.com>

On Fri, Aug 29, 2025 at 09:49:07AM +0200, Johan Hovold wrote:
> On Fri, Aug 29, 2025 at 07:51:23AM +0800, Chun-Kuang Hu wrote:
> > Johan Hovold <johan@kernel.org> 於 2025年8月27日 週三 下午5:51寫道：
> 
> > > On Tue, Jul 22, 2025 at 11:27:22AM +0200, Johan Hovold wrote:
> > > > Make sure to drop the references to the sibling platform devices and
> > > > their child drm devices taken by of_find_device_by_node() and
> > > > device_find_child() when initialising the driver data during bind().
> > > >
> > > > Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195 multi mmsys support")
> > > > Cc: stable@vger.kernel.org    # 6.4
> > > > Cc: Nancy.Lin <nancy.lin@mediatek.com>
> > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > >
> > > Can this one be picked up?
> > 
> > Ma Ke has sent a similar patch [1] before you. And that patch fix more things.
> > I've already pick up the final version [2].
> > 
> > [1] https://patchwork.kernel.org/project/dri-devel/patch/20250718033226.3390054-1-make24@iscas.ac.cn/
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?h=mediatek-drm-fixes-20250825&id=1f403699c40f0806a707a9a6eed3b8904224021a
> 
> I'm afraid that patch is completely broken and introduces a potential
> use-after-free by adding a bogus decrement of the OF node refcount.
> 
> I suggest you drop that one and pick up mine instead which is correct
> and cleaner.

I see now that that patch was included in a drm pull request for rc4.
I'll send an incremental fix instead.

Johan

