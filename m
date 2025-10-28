Return-Path: <stable+bounces-191424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 200C4C140FC
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 11:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0BC156449F
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 10:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757F82E8B86;
	Tue, 28 Oct 2025 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IShrimE7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9841BC5C;
	Tue, 28 Oct 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646657; cv=none; b=QVvBCGBT7i3SZ/W0nDNcDs+sp/oCPzQG91hDO7anbm78NyVEiOJWca1m3HarbZqTnkrlAarxktGaLcVqQo5pub25849BZid6PK/f5J+iUI0JqCiRr4qTEV+uDl7RAbQnLeU7DDMFkHY9NFvFG1P+C4FKw/d64I3wxDB9TmfT+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646657; c=relaxed/simple;
	bh=VJm5ppskrkPPf3nRfEgvoMvvIklrrttFGp5m0NBmnyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XK4tUJo5ds0pw+8oIWJnIVBSc0p2Uq0tTYzOxBmDpH5mvjW9GSS5RNpGwm8V6ZBHcq98XsBK9C3SmFNoHKvmFRG+Y0Ock1ygOZCcUv1Rqx5djIYx+OHh09+VHoKpA3WUOifRbmsvKryi+JQkh0UVIamU+d8G9cNUIWo4mUjFsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IShrimE7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4334C4CEE7;
	Tue, 28 Oct 2025 10:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761646656;
	bh=VJm5ppskrkPPf3nRfEgvoMvvIklrrttFGp5m0NBmnyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IShrimE7H1813z47FHt13K47u5BgdRj9iyDRKicWAJd0tX1h0kwskOGZA6tOHtZI6
	 rQVhfGpamswikSuJ1o3da8aJfnTExSR4gMRm0CRruhqJT9w0VHzVCo7mwdhCVppv42
	 mMWd7LH77DxttYQ+CMtoyJH9OknGxrFB929qZaRw0Rb//TdiZS5pN/u+Hq9CA2I227
	 Mx1MdYIPgLin/4McNNL9OyCzdbLBlMhx+7KzfoKJlVlKGQu/ymL+YmtktkSlF29GyI
	 Fe7QSRJO5XSLMp7yq+ME2Ztnu1wccztg+1DdQNUpelQ8TMsSnXqeeH7zu109hYytmX
	 iBufrhfsU4lEw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDgln-000000001Hj-3XDT;
	Tue, 28 Oct 2025 11:17:40 +0100
Date: Tue, 28 Oct 2025 11:17:39 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roger Quadros <rogerq@ti.com>, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] phy: ti: omap-usb2: Fix device node reference leak in
 omap_usb2_probe
Message-ID: <aQCYQ8NY3iaC4G_E@hovoldconsulting.com>
References: <20251028062508.69382-1-linmq006@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028062508.69382-1-linmq006@gmail.com>

On Tue, Oct 28, 2025 at 02:25:06PM +0800, Miaoqian Lin wrote:
> In omap_usb2_probe(), of_parse_phandle() returns a device node with its
> reference count incremented. The caller is responsible for releasing this
> reference when the node is no longer needed.
> 
> Add of_node_put(control_node) after usage to fix the
> reference leak.
> 
> Found via static analysis.
> 
> Fixes: 478b6c7436c2 ("usb: phy: omap-usb2: Don't use omap_get_control_dev()")
> Cc: stable@vger.kernel.org

There should not be any need to backport this one.

> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Other than that, looks good:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan

