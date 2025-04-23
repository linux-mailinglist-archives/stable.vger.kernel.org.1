Return-Path: <stable+bounces-136281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064E4A9937D
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C80D1B82FBD
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D24280CD1;
	Wed, 23 Apr 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="skoI6Aqf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8172B26A082;
	Wed, 23 Apr 2025 15:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422133; cv=none; b=hBrnY1G+I6Pi/dpzh2qho194ilH1A5gxVILir1Y1cyuPN6gDQEGJzF81EF04DLeCV86cmMkoVX1dMowsY3GQUM3vOXqAtghse8I9QCWirMkeqS28CdNB2Khqvkp62f4C6L1GTVVltJrAeYHeYH4oPaxAuqgurE+eTzhvgGWPhZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422133; c=relaxed/simple;
	bh=7o2noUH7fVOMAwUY9i2GAPvok+5TNrxvWXu8NzID/9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTqrGZI4wwws+A8APCH8YaAhdd7dDb17SwkPoNy1aEw62NbN0yjJFucE9svhEesAF2RKSM1WwVHfsdTHBVCDyTBSYC2RZ69oMA+aBFKqOMIy+sAStPrJBIHA37AeGP5a6JXafCTTBzi2NOhC0+Wm36CXVur/Y1syyavbanTJBj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=skoI6Aqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1408CC4CEED;
	Wed, 23 Apr 2025 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422133;
	bh=7o2noUH7fVOMAwUY9i2GAPvok+5TNrxvWXu8NzID/9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=skoI6Aqf1OgF/2H8otIHVbXLeO6Q7TmB4vTsQbHRtf3266PFOhRTkgtSRs6Bn/Kvy
	 tV5cZD6w2OjrWBD6akBa1xuTZqtZWeY4KTQDYM6SVh7c09NJLOYrRQaJXPOdvVV9Qd
	 ffnP0cFcNEsV+pVVoCfLZu5/nV9Pq1dSDVqmX17Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 284/393] net: dsa: mv88e6xxx: avoid unregistering devlink regions which were never registered
Date: Wed, 23 Apr 2025 16:43:00 +0200
Message-ID: <20250423142655.074885010@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit c84f6ce918a9e6f4996597cbc62536bbf2247c96 ]

Russell King reports that a system with mv88e6xxx dereferences a NULL
pointer when unbinding this driver:
https://lore.kernel.org/netdev/Z_lRkMlTJ1KQ0kVX@shell.armlinux.org.uk/

The crash seems to be in devlink_region_destroy(), which is not NULL
tolerant but is given a NULL devlink global region pointer.

At least on some chips, some devlink regions are conditionally registered
since the blamed commit, see mv88e6xxx_setup_devlink_regions_global():

		if (cond && !cond(chip))
			continue;

These are MV88E6XXX_REGION_STU and MV88E6XXX_REGION_PVT. If the chip
does not have an STU or PVT, it should crash like this.

To fix the issue, avoid unregistering those regions which are NULL, i.e.
were skipped at mv88e6xxx_setup_devlink_regions_global() time.

Fixes: 836021a2d0e0 ("net: dsa: mv88e6xxx: Export cross-chip PVT as devlink region")
Tested-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20250414212850.2953957-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/devlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/devlink.c b/drivers/net/dsa/mv88e6xxx/devlink.c
index a08dab75e0c0c..f57fde02077d2 100644
--- a/drivers/net/dsa/mv88e6xxx/devlink.c
+++ b/drivers/net/dsa/mv88e6xxx/devlink.c
@@ -743,7 +743,8 @@ void mv88e6xxx_teardown_devlink_regions_global(struct dsa_switch *ds)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6xxx_regions); i++)
-		dsa_devlink_region_destroy(chip->regions[i]);
+		if (chip->regions[i])
+			dsa_devlink_region_destroy(chip->regions[i]);
 }
 
 void mv88e6xxx_teardown_devlink_regions_port(struct dsa_switch *ds, int port)
-- 
2.39.5




