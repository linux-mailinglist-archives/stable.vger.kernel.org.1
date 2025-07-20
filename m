Return-Path: <stable+bounces-163456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 465E4B0B499
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 11:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B832188C3E5
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 09:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ED31D5ACE;
	Sun, 20 Jul 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="DPu8M6z0";
	dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b="Y4D1PXcF"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911B61CBEAA
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004221; cv=none; b=Iq12pbC7/CdhnS5XD7nBg2KQitCaiq/+63CMYq+vUMWak+XwZ7KDrfsqZ9GnCwgJPLmPipVq2zZFWJV6ED2GEZtcGNzTsVYy6PltlMleDPnOstyZ5g0+I0VqU5z7KvFYHaSIWZsyhEtI9KTZ5FaS0puhl6VA+ZPjmeohiw1OH/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004221; c=relaxed/simple;
	bh=5WwKJC/pA+KQE9BiPxw7Jp5rJNjTu5pV2zon5c4Bf50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+ZFvqb+upQtjJj10n4u6ETFbLSqOYUKd24oHZNWGMAaS+3KwzZ5CHnQ9ECEWQwZAIoUvpw9+60n+tXQE7qdesvIIwZ67bA/4s1/84s56t6BcOIlTwoskqLDAKrrlWo6LuuRt7jkawHH6cTvA6Pk6yG+ZjifSN6Qpf1PCkgLfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi; spf=pass smtp.mailfrom=hacktheplanet.fi; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=DPu8M6z0; dkim=pass (2048-bit key) header.d=hacktheplanet.fi header.i=@hacktheplanet.fi header.b=Y4D1PXcF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hacktheplanet.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktheplanet.fi
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=gibson; bh=5WwKJC/pA+KQE
	9BiPxw7Jp5rJNjTu5pV2zon5c4Bf50=; h=in-reply-to:references:subject:cc:
	to:from:date; d=hacktheplanet.fi; b=DPu8M6z0aSs0JZFPMY4afnxF0+4rcCjiVw
	nieiIlvDOzzxfcanBlP5+hDBF6r4EAVk4zllc3t4bOPwQblmsL4YGxSVU2oNg/CeYk+pu7
	jPTlogFGo0QwntpYD9sUUMEqLeP6/oo63iHQY7h7AG6uqIAtjJpGzX7fdyUAkhSB5FZoPZ
	JA4Nl1vP+13fDMLUYovGNwr7rkBuqEmUIHvVTJ8G3gAhApJTbUVtrXKqmwSU8OBBBd8KcR
	yrxbxlsrseNU0OCuqJmigHHaEr9QpwBx4oLAr23KGzPbcZGHwfLcLO4aJ6jgm2+nx/QgPJ
	C9BnrHGTOZE6u+uwsMtUf9rOmSOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hacktheplanet.fi;
	s=key1; t=1753004216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uo3up7xHbQdZ4cTvJkUzgyG6dvFoOoIIwJEm7dCbrAM=;
	b=Y4D1PXcFxzRDcd8LiwhteMWfO0QExe1YQtKrDtC8fs2Ia3XW4h2yA21d0i6lwaoFWPo1qX
	yAq2vXYHkU2ZWw4lAwtGHBeXhFMHSt6bkc8vggn1dqcnw1kfyYT7dZaeuSbd8pz58CwsBF
	81FuOCyE1CoxPKrUIj7EZAcqaJpEZeyVzXd+ka0DLdWYZREeMqjtuR4K5+tiVGLQkSNgrP
	AUH/pK6t/GQbVODxsckUTdnTsrtd2k7fgfHC0RncVsbmL8jJwMXm1E94HeZDK9zKQ4pgv0
	UsJw6blKmIlFM+HOnG9iYRez+VJeJTCk8QQ85BY448/MTSQn3Nj6Fwj7SH3dkw==
Date: Sun, 20 Jul 2025 18:36:54 +0900
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lauri Tirkkonen <lauri@hacktheplanet.fi>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	amd-gfx@lists.freedesktop.org, Wayne Lin <wayne.lin@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [REGRESSION] [PATCH] drm/amd/display: fix initial backlight
 brightness calculation
Message-ID: <aHy4tohvbwd1HpxI@hacktheplanet.fi>
References: <aHn33vgj8bM4s073@hacktheplanet.fi>
 <d92458bf-fc2b-47bf-b664-9609a3978646@kernel.org>
 <aHpb4ZTZ5FoOBUrZ@hacktheplanet.fi>
 <46de4f2a-8836-42cd-a621-ae3e782bf253@kernel.org>
 <aHru-sP7S2ufH7Im@hacktheplanet.fi>
 <664c5661-0fa8-41db-b55d-7f1f58e40142@kernel.org>
 <aHr--GxhKNj023fg@hacktheplanet.fi>
 <f12cfe85-3597-4cf7-9236-3e00f16c3c38@kernel.org>
 <cc7a41dc-066a-41c8-a271-7e4c92088d65@kernel.org>
 <aHy4Ols-BZ3_UgQQ@hacktheplanet.fi>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHy4Ols-BZ3_UgQQ@hacktheplanet.fi>
X-Migadu-Flow: FLOW_OUT

DIV_ROUND_CLOSEST(x, 100) returns either 0 or 1 if 0<x<=100, so the
division needs to be performed after the multiplication and not the
other way around, to properly scale the value.

Fixes: 6c56c8ec6f97 ("drm/amd/display: Fix default DC and AC levels")
Signed-off-by: Lauri Tirkkonen <lauri@hacktheplanet.fi>
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

