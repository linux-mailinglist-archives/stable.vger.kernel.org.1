Return-Path: <stable+bounces-116411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4974A35E5E
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D173C175CEB
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B955D2676C4;
	Fri, 14 Feb 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFn52Xgm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A952673B9;
	Fri, 14 Feb 2025 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537947; cv=none; b=O0PYcGMJNENdg4vnfJSutKVePHeQG0siK+Vk2tq/ctlLuH085stK9fIWdxlC82kGlu95RE4/c5tiUiWJzuKsSVWCAk/ijahFXZ+A9K33BH3x+G/hIM96BMzHOTJT7iAlyRj+MjIq5Nf240q6iJr5KEXw0EHmGb2XFVruHGFD8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537947; c=relaxed/simple;
	bh=0t4EN5GnlE4WyRk4DynmYLIny9UltXQDQoRGx9PjTqM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jclIXD2re7/PK5Ylgno2E0xve/xQgWksP/mZJOGkEGo3KaT3j68sMAJOWFm9zD2omYKN5HEYvnVktmUDaIVkBa4NRnHXPYhw96DJQvlFA//g9DH8njx/+oNuyY/lQHYYAB/znuyzbXFiMAtyTn5Efsqmby89TI3sora+Qp1ifIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFn52Xgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B032DC4CEDF;
	Fri, 14 Feb 2025 12:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739537946;
	bh=0t4EN5GnlE4WyRk4DynmYLIny9UltXQDQoRGx9PjTqM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XFn52XgmS1epWC9hOxanEtt3L0FzrhAuLYpbr//o3xOV1xQ7wwp2UJKeuI49v1NnH
	 ohjJRu/OQe6b5U0LutbcBtN7hMVhXUGHi012QyPt8H89EYSmTRFr+CFfw7FBzDuSqK
	 jOfYe9sQDDqLxtLzyEnXYaudKgSsVFFra32F6YGZ31K77CqZ58lPshXeGbeLmlRW5P
	 vp5UMALK/gu45HotLdB3l615ZhAA5Z9gzOCWUtZBs2Uc5Gv9Yva2gP5OpCF+giR01A
	 BMAZnHDxsYxjVPC0OQOe9d3SjxUUTzxpAVC9/EEdpIj5Y4bu7ZrFES+nwVUcmVdW5Z
	 Htm1dg2WKQ87Q==
From: Vinod Koul <vkoul@kernel.org>
To: JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Henry Lin <henryl@nvidia.com>
Cc: linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, BH Hsieh <bhsieh@nvidia.com>, 
 stable@vger.kernel.org
In-Reply-To: <20250122105943.8057-1-henryl@nvidia.com>
References: <20250122105943.8057-1-henryl@nvidia.com>
Subject: Re: [PATCH v2] phy: tegra: xusb: reset VBUS & ID OVERRIDE
Message-Id: <173953794334.323038.6276165864210863274.b4-ty@kernel.org>
Date: Fri, 14 Feb 2025 18:29:03 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 22 Jan 2025 18:59:43 +0800, Henry Lin wrote:
> Observed VBUS_OVERRIDE & ID_OVERRIDE might be programmed
> with unexpected value prior to XUSB PADCTL driver, this
> could also occur in virtualization scenario.
> 
> For example, UEFI firmware programs ID_OVERRIDE=GROUNDED to set
> a type-c port to host mode and keeps the value to kernel.
> If the type-c port is connected a usb host, below errors can be
> observed right after usb host mode driver gets probed. The errors
> would keep until usb role class driver detects the type-c port
> as device mode and notifies usb device mode driver to set both
> ID_OVERRIDE and VBUS_OVERRIDE to correct value by XUSB PADCTL
> driver.
> 
> [...]

Applied, thanks!

[1/1] phy: tegra: xusb: reset VBUS & ID OVERRIDE
      commit: 55f1a5f7c97c3c92ba469e16991a09274410ceb7

Best regards,
-- 
~Vinod



