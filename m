Return-Path: <stable+bounces-187927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DCDBEF573
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 07:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88DF24EB374
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 05:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C062BE034;
	Mon, 20 Oct 2025 05:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/3ujguI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7518C26;
	Mon, 20 Oct 2025 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760936536; cv=none; b=arAASpRJ379iByaYBIZ8fGY6tmjhOPSkVaHEE2VodufC59U4usUMEWGNXt+5AbP57sfY3ccxfLU68uuFTriMAWmFyEtJ2fuFXLTOHILVM6W6yY65EoXoK+CSgYyxxhyxJ6HZ7LzapIxI0sSLM65jARU6/GNJsQTRw84j4LXdvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760936536; c=relaxed/simple;
	bh=JFWu/tb37fC0mWHoh013DMndU7LT3ziUW19WztFa44E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tE6Q/zj4yMhVLuRIlmSJC/STInIgwq81xAw7iKPIp0pZWrh4QMGjz8MCwhb7HHl2TR3Z2iUJWKA5iC4jQ3K7MEM5MFGr32wOfUPdCEsHcENmVZxF3b2AC5E2OIT8b1ex9Tl4NDQlqs2t9qufYJdK34JDfLfrMa5Y5snC3XMr5Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/3ujguI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A5AC4CEF9;
	Mon, 20 Oct 2025 05:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760936535;
	bh=JFWu/tb37fC0mWHoh013DMndU7LT3ziUW19WztFa44E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a/3ujguIQyAZl82wbKcI/tCITzC0HRq5Jlef+9KQ1FRwYgGyJAPgi1fgaSs5qryYG
	 yOy0qkj6MuYOqhIUk16IGRT2iioDUnFG7mEjXU9ujv+8ezAlvLtxrpJgFvLz/ibkF7
	 fyNPg20MNLUaSNvSXxYoMNNQFpNb8cslledLluqT3EEfNnYDmHHEr7C/ATBlbXQvZj
	 Nkjk90tnFmIa3DfG1qqh+BJ78GzTMD3PhlUEo0PbflR0xBf606pjmzQnqVpdx1oLOr
	 FvQbU4688jWrWO2BytpCSKoUQckyhV9GKXjZ62BDI6sMxgnOSi7kaCbd/AZ2Y50gCt
	 3ALVw+l1jaYwg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vAi2F-0000000089o-1NrX;
	Mon, 20 Oct 2025 07:02:19 +0200
Date: Mon, 20 Oct 2025 07:02:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Yong Wu =?utf-8?B?KOWQtOWLhyk=?= <Yong.Wu@mediatek.com>
Cc: "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"j@jannau.net" <j@jannau.net>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"wens@csie.org" <wens@csie.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"robin.clark@oss.qualcomm.com" <robin.clark@oss.qualcomm.com>,
	"sven@kernel.org" <sven@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 06/14] iommu/mediatek: fix device leaks on probe()
Message-ID: <aPXCW43vFExjkVpq@hovoldconsulting.com>
References: <20251007094327.11734-1-johan@kernel.org>
 <20251007094327.11734-7-johan@kernel.org>
 <aeec9ee86b63ee892d84ab0232f372bdeccc780f.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeec9ee86b63ee892d84ab0232f372bdeccc780f.camel@mediatek.com>

On Sat, Oct 18, 2025 at 06:54:39AM +0000, Yong Wu (吴勇) wrote:
> On Tue, 2025-10-07 at 11:43 +0200, Johan Hovold wrote:

> > Make sure to drop the references taken to the larb devices during
> > probe on probe failure (e.g. probe deferral) and on driver unbind.
> > 
> > Note that commit 26593928564c ("iommu/mediatek: Add error path for
> > loop
> > of mm_dts_parse") fixed the leaks in a couple of error paths, but the
> > references are still leaking on success and late failures.

> > @@ -1216,13 +1216,17 @@ static int mtk_iommu_mm_dts_parse(struct
> > device *dev, struct component_match **m
> >                 platform_device_put(plarbdev);
> >         }
> > 
> > -       if (!frst_avail_smicomm_node)
> > -               return -EINVAL;
> > +       if (!frst_avail_smicomm_node) {
> > +               ret = -EINVAL;
> > +               goto err_larbdev_put;
> 
> There already is a "platform_device_put(plarbdev);" at the end of "for"
> loop, then no need put_device for it outside the "for" loop or outside
> this function?

You're right, thanks for catching that.

But this means that we have an existing potential use-after-free as if,
for example, the driver probe defers we would put the reference to any
previously looked up larbs twice.

I've just sent a v3 which fixes this by dropping the
platform_device_put() after successful lookup as it is expected that the
driver keeps the references while it uses the larb devices:

	https://lore.kernel.org/lkml/20251020045318.30690-1-johan@kernel.org/

Johan

