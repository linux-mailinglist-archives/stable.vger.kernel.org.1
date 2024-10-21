Return-Path: <stable+bounces-86999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2B9A5CC9
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C05B1F210C7
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 07:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E4D1D1F6B;
	Mon, 21 Oct 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrH2EkE4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FC01D1F4B;
	Mon, 21 Oct 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495396; cv=none; b=MPWiLGWWSOUD+5yLHzjHsXgDdEH/J9gG1bfr49lxrBi1AJa0YISkc26EZxQ85jvQXp5fhPoUCsUYIdyTCINt0vwzxpoxVBfaAKlV48JRdNPlNdYMlA26I8FAL9/hO/BGidisWTY8snQSsCqNvpDQqUQTW2hlhsD+u3nXrFTYyAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495396; c=relaxed/simple;
	bh=i+ZM98WbX8bvbIdFM1Cl6eJjG8VMAfXbodXE91rExiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crFvF5GonqikG/+1SvRNX6pLNZhi07vBxabMc9rACNr1UEuk7Vuh8sICfq1J5QiKDd++GR04UTNy3Lp6Xy6J9mFEAkEc9bkgcith/SoL/O3Ka9qP8YBWZrJc3cWA8uCoSKEBy4K3o3mU+2wdIzL/BKczZ1Sp36X3ESyJmhs3MK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrH2EkE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDBAC4CECD;
	Mon, 21 Oct 2024 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729495395;
	bh=i+ZM98WbX8bvbIdFM1Cl6eJjG8VMAfXbodXE91rExiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrH2EkE4pbfuVAIAgU+Z1UlZ0NFNOWiIYBPGw5As6g+xF5r1wTRr+UzZNYZFaB3Zy
	 iCpjv2HswcqOypSukb90m8TwK0Y3C0QjlfDeAPLpwVWosNDJUYEZ0RsQeVt5DRf6Gw
	 9+4bTA7P1O2S3GVPhjhcPjBh7OSVME+irgERAVvAIAJCtDTIvGRhOa49vZJOTASzwz
	 Ql+l1GMU681/CeXW8g8XwrbWUgP+J0lUIBI2rCsCN5qWsGQ8MImIE40Ju3qy9fLoT3
	 7W00w6x1XQQd9/QZhK/3a4FwpiutU40jClUCDlgBcUYzC32rpoeBU43gOHZqsj7vSW
	 u1rcu6bZRP+Xg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t2ml9-000000001jR-1CxS;
	Mon, 21 Oct 2024 09:23:24 +0200
Date: Mon, 21 Oct 2024 09:23:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
Message-ID: <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>

On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> The assignment of the of_node to the aux bridge needs to mark the
> of_node as reused as well, otherwise resource providers like pinctrl will
> report a gpio as already requested by a different device when both pinconf
> and gpios property are present.

I don't think you need a gpio property for that to happen, right? And
this causes probe to fail IIRC?

> Fix that by using the device_set_of_node_from_dev() helper instead.
> 
> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")

This is not the commit that introduced the issue.

> Cc: stable@vger.kernel.org      # 6.8

I assume there are no existing devicetrees that need this since then we
would have heard about it sooner. Do we still need to backport it?

When exactly are you hitting this?

> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v2:
> - Re-worded commit to be more explicit of what it fixes, as Johan suggested
> - Used device_set_of_node_from_dev() helper, as per Johan's suggestion
> - Added Fixes tag and cc'ed stable
> - Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org

Patch itself looks good now.

Johan

