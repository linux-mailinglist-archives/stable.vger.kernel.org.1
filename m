Return-Path: <stable+bounces-65119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64322943F6D
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B2EB23914
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6906B1DB43E;
	Thu,  1 Aug 2024 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVwm62Qu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264171DB439;
	Thu,  1 Aug 2024 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472494; cv=none; b=ohCIXpHbWO3gEz8gL0ylJDErji5e6ERXRIwCuHHg1sqZepdxCAV0baAalO3BT8zyxpWW4yDBmMfoCb3k7PAk8tPX62lpVdYK8ktatPenX6R6I8i/um6mlv2eBh/Pr0YtSCGJtqJyXH6IXxaGRKbczKrw5TphzAVEcrQEHYTvYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472494; c=relaxed/simple;
	bh=chRThpXcXW9d/iADq8PkvJaTDxn7N/vVPE1MpBGR3lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3TeI8eogjy7WZxxAVUVWWz9VhmqHkanMvnXVZ/fNspD0SDwfY82KpXx2nxTjID3W1GahoDKioaHPSZTTTxElECOaRRO9Y1QXKtSZA/H7k8FgZiWznwNP+JVhq4KQHWmBHayG1R0o9Cm5WRBiThJTHGhJLiMkgFRmqgQ4ZjHvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVwm62Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D1C4AF12;
	Thu,  1 Aug 2024 00:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472493;
	bh=chRThpXcXW9d/iADq8PkvJaTDxn7N/vVPE1MpBGR3lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVwm62QuHxu97g9FgLg6O82k1bpExGNqXf6SMXdC+M9W52B7DRHBhE+nFJNxWRm1r
	 oEPrVxdlV0gEShM85Mb47nkOd195SgTKyZ5/hpw0uy22ZRyZ71zgeJCun/C0iG3lVD
	 /AWQ7bwpbid8uJurlQUTnDqZRQBK8g7vRMRYtq+JJodIYInTgNic78VQ2eOZNu0qvJ
	 uSVczPP/PnXSPoxj4t3pDw5zJL9l1IKX8bFP+Yr4Ns9in+kxMo+44x1oqO81a+PmAm
	 Lsw6rY6VONBJIvsN9Rrw/XkUuB0rq/mC2VXkOn3ct8HNHTiSJuP7nTsmGHZ4OeiC5k
	 B4IPUQF4SoieQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Robert Foss <rfoss@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.15 29/47] drm/bridge: tc358767: Check if fully initialized before signalling HPD event via IRQ
Date: Wed, 31 Jul 2024 20:31:19 -0400
Message-ID: <20240801003256.3937416-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003256.3937416-1-sashal@kernel.org>
References: <20240801003256.3937416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
Content-Transfer-Encoding: 8bit

From: Marek Vasut <marex@denx.de>

[ Upstream commit 162e48cb1d84c2c966b649b8ac5c9d4f75f6d44f ]

Make sure the connector is fully initialized before signalling any
HPD events via drm_kms_helper_hotplug_event(), otherwise this may
lead to NULL pointer dereference.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240531203333.277476-1-marex@denx.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 4c6f3052156bd..3436d39c90b4c 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1527,7 +1527,7 @@ static irqreturn_t tc_irq_handler(int irq, void *arg)
 		dev_err(tc->dev, "syserr %x\n", stat);
 	}
 
-	if (tc->hpd_pin >= 0 && tc->bridge.dev) {
+	if (tc->hpd_pin >= 0 && tc->bridge.dev && tc->aux.drm_dev) {
 		/*
 		 * H is triggered when the GPIO goes high.
 		 *
-- 
2.43.0


