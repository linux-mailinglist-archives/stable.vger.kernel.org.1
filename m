Return-Path: <stable+bounces-220205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEkTJRAso2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB481C5366
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031FE30FAB2D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15C24D90B8;
	Sat, 28 Feb 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hABZIGlt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933144D90B1;
	Sat, 28 Feb 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300110; cv=none; b=pWeFm5W/g0g34vbpXevVx+oJaLORFybcxOKpjY64wrP+seCqB0+HGmdib3RherXK3oS6gZslaFibz+kc2g1UtmvfHcgpx81fSADqEPl+xwXt30Xiz6h8TjvbM6J4UzwzLifY+1IqhiWoiPNzP77P8MgRXz6+ileim1qoOpy6C04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300110; c=relaxed/simple;
	bh=LXPnYFyjecgtFc/ffRpGlEF9xDMmt3tX7KpNWgiAbYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+a+VX52QsM5HJrjIPrvXsXa3WR2HqpK9dbBt6ffLows/39fMzEtcYjKj2OcppI5mE6lNALcBFEdmO17AvqL2J0zlZwaf/1LhnWuaU2MAJFIhcDr5GqyAClrlK///IRp/MSYefCinJ8hUiXRK7t1HNhHLNilhpwkrULurx+zKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hABZIGlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC352C19423;
	Sat, 28 Feb 2026 17:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300110;
	bh=LXPnYFyjecgtFc/ffRpGlEF9xDMmt3tX7KpNWgiAbYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hABZIGltr0Huw9E9Plr2omWdLW8DY5y2DjFxZj04+5LKkRZVhBSicw7Dp+mIsMjl/
	 kFM9LvdsudLeLHBZZbm6e67asXzyKYeYdZk08CAqPKf/brfq2bYD2UfAeB3IEJ+knw
	 fqxRBwtkc929ymeEoFc1RfRKSLqx1wtuW2HBXd1d65WyFb6spT/bZadsfvzIyDR7m8
	 fZd7G9Ok8MqKn83zcGRLvinHFk0+mUWO0a5alXB6BR9pqqD9zqQJIWuqma7vOAb9f8
	 jqOvBBJld8aTRfbsEoceBMfgm52q1B9stH6Ek5A9i4Tq7CdEO7TRymQqm/QVgrSczl
	 R25P+2hARAwOg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 127/844] drm/panel-edp: Add CSW MNE007QB3-1
Date: Sat, 28 Feb 2026 12:20:40 -0500
Message-ID: <20260228173244.1509663-128-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220205-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,chromium.org:email]
X-Rspamd-Queue-Id: EBB481C5366
X-Rspamd-Action: no action

From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>

[ Upstream commit b1ea3babb67dcb8b0881c2ab49dfba88b1445856 ]

Add support for the CSW MNE007QB3-1, pleace the EDID here for
subsequent reference.

00 ff ff ff ff ff ff 00 0e 77 7c 14 00 00 00 00
00 23 01 04 a5 1e 13 78 07 ee 95 a3 54 4c 99 26
0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 35 3c 80 a0 70 b0 23 40 30 20
36 00 2d bc 10 00 00 18 2b 30 80 a0 70 b0 23 40
30 20 36 00 2d bc 10 00 00 18 00 00 00 fd 00 28
3c 4a 4a 0f 01 0a 20 20 20 20 20 20 00 00 00 fc
00 4d 4e 45 30 30 37 51 42 33 2d 31 0a 20 01 5b

70 20 79 02 00 21 00 1d c8 0b 5d 07 80 07 b0 04
00 3d 8a 54 cd a4 99 66 62 0f 02 45 54 40 5e 40
5e 00 44 12 78 2e 00 06 00 44 40 5e 40 5e 81 00
20 74 1a 00 00 03 01 28 3c 00 00 00 00 00 00 3c
00 00 00 00 8d 00 e3 05 04 00 e6 06 01 00 60 60
ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 68 90

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20251127121601.1608379-1-yelangyan@huaqin.corp-partner.google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 415b894890ad7..023fbbb10eb4f 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2033,6 +2033,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1462, &delay_200_500_e50, "MNE007QS5-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1468, &delay_200_500_e50, "MNE007QB2-2"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x146e, &delay_80_500_e50_d50, "MNE007QB3-1"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x147c, &delay_200_500_e50_d100, "MNE007QB3-1"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1519, &delay_200_500_e80_d50, "MNF601BS1-3"),
 
 	EDP_PANEL_ENTRY('E', 'T', 'C', 0x0000, &delay_50_500_e200_d200_po2e335, "LP079QX1-SP0V"),
-- 
2.51.0


