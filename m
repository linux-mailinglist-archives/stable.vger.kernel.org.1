Return-Path: <stable+bounces-110790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE1A1CC9E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78D9E162A8D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D693D1487FA;
	Sun, 26 Jan 2025 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="LwhHDw74"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B523C17;
	Sun, 26 Jan 2025 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737908920; cv=none; b=nHQhF8I8B3YjLQe/ePjFh3arQx+lSRzgDMDEoJieQB58vIHVJZHBdBOkD2fXtBug8IV/wDqZfhkwAGl8sDtm8dUgtuegZlXzQn7uTtiY43A9brhNcWkRwOJp/vZCB3cMSFPzEkfb3i2cdDqbz54t6mgZ3g6p0HG5wer/VhjkYO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737908920; c=relaxed/simple;
	bh=YMNOtfXRHqQdVvk11GYm4yQXjj+3NcjgEEgDiKYLnYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyS8C/S6kY9s44ChC8B1muO7NHWRFnouA0BFBryk7VaoL1E0j+dYZFvbL2UwFflfmrvcmrlV27D7WPNypRhMPzEamqtxVATcAQWDW5Ks6UGfnJ9PEWCPJ6l+4ORRyKX+cUtrNjIc4a3hdv33KJoQVy7axv6srEJyeefSP/ROLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=LwhHDw74; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737908907;
	bh=YMNOtfXRHqQdVvk11GYm4yQXjj+3NcjgEEgDiKYLnYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwhHDw7463BsJ47z8j496K0QJxJsX+5T3NyWQxZCHRk7uNGsV8IpIbBAZHpz57ypq
	 +GUVQfdyzhLNiB+SlzN+NkTbeZ4cGzBMlaJGfdYpwUZlea+knAtRGJeXetXzWF2BGH
	 zAgRWcS7z3LTKGzlzMBXnylAXjFLtjO0ITy2QV9o=
Date: Sun, 26 Jan 2025 17:28:27 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	"Dustin L . Howett" <dustin@howett.net>, Mario Limonciello <mario.limonciello@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, corbet@lwn.net, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.12 02/31] drm: Add panel backlight quirks
Message-ID: <93a9e956-9572-410e-947c-36aeba4965bf@t-8ch.de>
References: <20250126145448.930220-1-sashal@kernel.org>
 <20250126145448.930220-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126145448.930220-2-sashal@kernel.org>

Hi Sasha,

On 2025-01-26 09:54:18-0500, Sasha Levin wrote:
> From: Thomas Weißschuh <linux@weissschuh.net>
> 
> [ Upstream commit 22e5c7ae12145af13785e3ff138395d5b1a22116 ]
> 
> Panels using a PWM-controlled backlight source do not have a standard
> way to communicate their valid PWM ranges.
> On x86 the ranges are read from ACPI through driver-specific tables.
> The built-in ranges are not necessarily correct, or may grow stale if an
> older device can be retrofitted with newer panels.
> 
> Add a quirk infrastructure with which the minimum valid backlight value
> can be maintained as part of the kernel.

This series [0] has been applied to the 6.12 and 6.13 stable trees.
However it is introducing new functionality and not fixing any bug.
Furthermore, for 6.12 the patch for drm/amd/display enabling the new
functionality was not even applied, making all of it dead code.

[0] https://lore.kernel.org/lkml/20241111-amdgpu-min-backlight-quirk-v7-0-f662851fda69@weissschuh.net/

	Patches:
	drm: Add panel backlight quirks
	drm/amd/display: Add support for minimum backlight quirk
	drm: panel-backlight-quirks: Add Framework 13 matte panel
	drm: panel-backlight-quirks: Add Framework 13 glossy and 2.8k panels


Regards,
Thomas

