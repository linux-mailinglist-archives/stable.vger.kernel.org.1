Return-Path: <stable+bounces-88267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8819B247E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763FC1F2153D
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 05:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7420418CBFC;
	Mon, 28 Oct 2024 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4qe0Zda"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3360D18C928
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 05:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730093899; cv=none; b=OBbqvI+dS27jrA1dNl4BL4idODvtXOOU7X8OOuQ0C+PGsYduytCfAUEB2M49MKKUL+jDxqfzuYnZSn7nF5lhSBLu5clB82p/c9edC1jieLMQy3G9QWcjw1evIure1Ql3j86l0guVbti6/Pzo9y8SAdiGZ6BhN13VkfeuwLJI0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730093899; c=relaxed/simple;
	bh=KkGiltvB2syBm1xu3ITNqGSLPtRXU0T4HdY3Pb7kodc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biWdge7JbMHXWgY7QL5wB5AWvcD2yZl43/51yWOaRVwC6bgC5H3ymMF1wYlnnCAPtQ3mY1yUE1e+B5WLg0IwGmo5xFlqaspvoUBXdue4WDVjuDxWZM4AGx5CCmBd8Ae0ujMBDSz0epBkx3m5fEkJlyIV3B3yBIogFvShrFAYQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4qe0Zda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8552EC4AF09;
	Mon, 28 Oct 2024 05:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730093898;
	bh=KkGiltvB2syBm1xu3ITNqGSLPtRXU0T4HdY3Pb7kodc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4qe0ZdaMdpj69qBpYpNnUpK1e81w8VeCBogJ5d+QCrxOWMYpSKPUN/Gvhd5J4Hjh
	 s0ierfhVsh1370pT2+mBJRcvhiPz1sySscbIkaduaosXej4TUeuXZGYKyUCWRka5SG
	 hyPIW//d1ic6S6IIT5YwBLDHQ8H6iVFYC1a6uW/8=
Date: Mon, 28 Oct 2024 06:38:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jason-jh.lin@mediatek.com
Cc: stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
	Seiya Wang <seiya.wang@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>
Subject: Re: [PATCH] Revert "drm/mipi-dsi: Set the fwnode for mipi_dsi_device"
Message-ID: <2024102847-enrage-cavalier-77e2@gregkh>
References: <20241024-fixup-5-15-v1-1-62f21a32b5a5@mediatek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-fixup-5-15-v1-1-62f21a32b5a5@mediatek.com>

On Thu, Oct 24, 2024 at 06:30:01PM +0800, Jason-JH.Lin via B4 Relay wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> 
> This reverts commit ac88a1f41f93499df6f50fd18ea835e6ff4f3200.
> 
> Reason for revert:
> 1. The commit [1] does not land on linux-5.15, so this patch does not
> fix anything.
> 
> 2. Since the fw_device improvements series [2] does not land on
> linux-5.15, using device_set_fwnode() causes the panel to flash during
> bootup.
> 
> Incorrect link management may lead to incorrect device initialization,
> affecting firmware node links and consumer relationships.
> The fwnode setting of panel to the DSI device would cause a DSI
> initialization error without series[2], so this patch was reverted to
> avoid using the incomplete fw_devlink functionality.
> 
> [1] commit 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
> [2] Link: https://lore.kernel.org/all/20230207014207.1678715-1-saravanak@google.com
> 
> Cc: stable@vger.kernel.org # 5.15.169

What about 5.10.y and 5.4.y as well?  Aren't those also affected?

thanks,

greg k-h

