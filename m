Return-Path: <stable+bounces-189985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1CC0E227
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 14:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD913ADB2F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C51E308F0C;
	Mon, 27 Oct 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbruydx+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036C305946;
	Mon, 27 Oct 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572182; cv=none; b=YZBpSWCZ+soLULSyqtRRqvSZrwqkTU+mU03EZ4F5f/ezjZMr2+XhV7Q6z9anZTsDJ6al4Od+P/HbrsPPHE5FXhMu0O7/eI6UhCsjOoza6Y9pIjZzenpfoO2otXLZDHvSRxOH8OocdSjRLm4VzYXQ1uQE2lLfNbtKOfKe2/N9nLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572182; c=relaxed/simple;
	bh=9gkc51HKyIGzpsiSokYYslNBHWpyEyG9Ffyln4h27oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvn09mPJAHTksoPmKs7Y+73YU26L+6bpj3T/KGq2Ol8fsQn2/fiXfk0d1SX58eEnAh4OXwycrFdVkAkoA4NPCOTS9dKyYYkBtH1oaux0FVRIXzWkHkTGGhnrHBuRZJM1aO2An+MgTwTsHU8gAdqlTmOmJioHIZKazmhrtkm3fgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbruydx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AEDC4CEF1;
	Mon, 27 Oct 2025 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572181;
	bh=9gkc51HKyIGzpsiSokYYslNBHWpyEyG9Ffyln4h27oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xbruydx+db5r1jHlh07/my5RnAn05zlmS3pRDwbS+gXzLEA8b1WQQanvl1YEwX325
	 2FZbYXimrbVzYfBsaF8iLvTFMB+2bMXHdU1j8qLjAHB4+K1gljpiyWtm33dNQz4OYs
	 unyTvaOe/ni42NafFcE/X3x8dOXb63CVxC9AnLpIaygx2Jcdb8lJoXag+Dd3mfSvL0
	 FD/bCgCsiR5nCbrBxYH164GRfSyvOKlD0M1jTsmq4wYRBoGtjOP3eKYH0IhQbMtg6l
	 RKpcblsgG6XTgu5hSaTLhD4S6kIuI5k8FhHlp/yZHKPDZqQmHY6A1Fd4Bb77yycmjT
	 cIMfb4kTs55AQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vDNOb-000000000IK-0dDL;
	Mon, 27 Oct 2025 14:36:25 +0100
Date: Mon, 27 Oct 2025 14:36:25 +0100
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/imx/tve: fix probe device leak
Message-ID: <aP91WYeEEvEFIrfe@hovoldconsulting.com>
References: <20250923151346.17512-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923151346.17512-1-johan@kernel.org>

On Tue, Sep 23, 2025 at 05:13:46PM +0200, Johan Hovold wrote:
> Make sure to drop the reference taken to the DDC device during probe on
> probe failure (e.g. probe deferral) and on driver unbind.
> 
> Fixes: fcbc51e54d2a ("staging: drm/imx: Add support for Television Encoder (TVEv2)")
> Cc: stable@vger.kernel.org	# 3.10
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---

Can this one be picked up for 6.19?

Johan

