Return-Path: <stable+bounces-163489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20279B0B9AC
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 03:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BED7A3B48
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 00:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CB314D70E;
	Mon, 21 Jul 2025 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="uRC9ACyA";
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="fJKBMeER"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD47260A
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753059597; cv=none; b=MhFjUqRPvF6KYxra10OM3tKfSVolP7amTNOKsKFaPYbPUsqYuRqu8bf3e2ODuPIyjWo4gB6U34yXGZ78pQYoKPwIo3wUnBuAaAO44Ktg22ooAmAgfLOav9NzkEqnaecnY1LXb38cpb8O2sK6RgYieL0Sb58ib1cbulcXQ+z8QT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753059597; c=relaxed/simple;
	bh=lufO/SfGrebt1Uvbo8PEo5A3P1gKInv82B1zFvN3hUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tEx1r/UmRAsZA7VYn8Lr+Tw5iZUkJ358478hSyVLf+r+cXGjXan8ihIgjGz9TgMiZKe7QnSSwImD5kPhbbUMZlU1WDJnxcg/ONfPijCadqIljUeKQLuDfYTrF6vv9NGR4MtwPTydmMdyop7q91UueSe07hKKg8xzpnh1BfJKty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi; spf=pass smtp.mailfrom=hacktheplanet.fi; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=uRC9ACyA; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=fJKBMeER; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktheplanet.fi
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=lufO/SfGrebt1
	Uvbo8PEo5A3P1gKInv82B1zFvN3hUo=; h=subject:cc:to:from:date;
	d=hacktheplanet.fi; b=uRC9ACyAEhafmE4EN5ocUEoH4WADgLMkktPTudXKK3zuAatS
	m3m++bZ718wNzXXJ3kZQVx4wyCprjiHquLB1NJJCB42gIRIKCw/SD/LCWDrMCK7+/B8cLQ
	n02qwSMeoBOtPjDUMHKlZX98JIlwP+4aHKMquOO6HZ1tlDjj4KbHhtaJmeDzwIq7qBdJC9
	vgNojPA+4u3XxYpKo9usAJPS2fsvVaHDtpD1FHlAG6PE03T1DkH+TzrBSjvlWl/xdNAh14
	L6uZsV/gWzjSQ4DRQkkCjr7RCcqyIlUnTuQwAhPJEt5qLGMASPdGiKx/gvuwHz1APgJBcY
	MpMDuyHmXqd6Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
	s=key1; t=1753059583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=//RALJ2DG6eoPJ8kGoGEizkYKrZ/iIm2f0PKjGpS5XM=;
	b=fJKBMeERTYdiWXnm6lLcp0iNaf+qL7mgXRqsi0b5iQdyRDzjnLX3x5ONU6ymnyShoYEe7q
	/sb5x676LLe08M0Za0yROcqC/4VJGRwTdceUGfOdHA0cibJB1LqARvLukQ+zpZILjKmoKY
	JhH83xpSq5sMu6RsvnaUvzWkBFgqTQDxTHOH0IneHSy6rxMeqj6+M/thUDn26D8+1w+YRh
	whKGq00PBRcenrF2dUyETfhSN0RuYxAR3pcsBJUJ8NKLmTJJYo4McuwCj1X0T3GI5at0zK
	wdxZzN/WkIcphMFE0sdi+dOhlWToFmSJh/5Gxx/4u11pbBoAZ2Uoyhw7EB1sHg==
Date: Mon, 21 Jul 2025 09:59:40 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Mario Limonciello <superm1@kernel.org>,
	amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] [PATCH v2] drm/amd/display: fix initial backlight
 brightness calculation
Message-ID: <aH2Q_HJvxKbW74vU@hacktheplanet.fi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
division needs to be performed after the multiplication and not the
other way around, to properly scale the value.

Fixes: 8b5f3a229a70 ("drm/amd/display: Fix default DC and AC levels")
Signed-off-by: Lauri Tirkkonen <lauri@hacktheplanet.fi>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f58fa5da7fe5..8a5b5dfad1ab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4941,9 +4941,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 	caps = &dm->backlight_caps[aconnector->bl_idx];
 	if (get_brightness_range(caps, &min, &max)) {
 		if (power_supply_is_system_supplied() > 0)
-			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->ac_level, 100);
+			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
 		else
-			props.brightness = (max - min) * DIV_ROUND_CLOSEST(caps->dc_level, 100);
+			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->dc_level, 100);
 		/* min is zero, so max needs to be adjusted */
 		props.max_brightness = max - min;
 		drm_dbg(drm, "Backlight caps: min: %d, max: %d, ac %d, dc %d\n", min, max,
-- 
2.50.1

-- 
Lauri Tirkkonen | lotheac @ IRCnet

