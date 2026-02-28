Return-Path: <stable+bounces-220263-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBTyMzQvo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220263-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 385CC1C5760
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6942D3210394
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8DE47DD54;
	Sat, 28 Feb 2026 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyQ1YbP1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E0D37D7A1;
	Sat, 28 Feb 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300166; cv=none; b=aBGR+ahu9x71/FBWHvR/3c1BPZN+wb5FazQ7PBviZVzFWFryybXjK0ZvAMGe4uPFZ4t0oFDg/K9F/VTEMkggU+A+2l3SkfVO3BGy6qmKSf43aH2a/6wNiJyxeVqGQY1nc3iJVR8qTx7iQzq4mhTJBWdSAf2UU5T2ibilH7l+gMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300166; c=relaxed/simple;
	bh=CYMxtiBY6+W5eiUXskeWyFEavQ9L2866Ci7dWzcUohk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHcOKHJlOrBXX9clo3OXboWGMIDWaH7hRKkRs88lV3cXIi4nmRPsyylSY3Q55G7sF4PUAiVdj233Lp0GogCWyQbESMLvTLdH7pTxYBTXE7h89bnx2i9Z/pT+yE/ls11KMzHXINCgCtVb6IBvnMjs2OHtGsvNgJv/N63ZryBhk9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyQ1YbP1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8A5C116D0;
	Sat, 28 Feb 2026 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300166;
	bh=CYMxtiBY6+W5eiUXskeWyFEavQ9L2866Ci7dWzcUohk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyQ1YbP1x6Q8LyR8PlBkBMp6IXqaUxkdd5Lds1lI7iVBeaGqAuVi77oW/Wg/v1cg4
	 mZgnPIsFKdjnskpVvKfhf3Nax8Xm/iU1eZLq3bEEI5k24W36CySHftdg3KJoLV6CDC
	 5hGiCyLDDerECTwx8B5wuYUW+8Y2Mo1nkcyIlfkuyuNmybt1Cq42NaIQWB+JiNV50U
	 ulRear1hfIgn4zerqxFBDw1InzgSVGyyycSRZ2imrCa/pw37NJrcuUUkTnlGV1AMzf
	 bHSXKchnkj4GrtMFaI2ZHoMRgahrkDbXTtQcAdNZW6uk/8gE+yzJRUd9SId5X2vBoo
	 DTCTnkZQhW7IQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 185/844] media: mt9m114: Return -EPROBE_DEFER if no endpoint is found
Date: Sat, 28 Feb 2026 12:21:38 -0500
Message-ID: <20260228173244.1509663-186-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220263-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 385CC1C5760
X-Rspamd-Action: no action

From: Hans de Goede <johannes.goede@oss.qualcomm.com>

[ Upstream commit 437e1f6a960035166495a5117aacbc596115eeb6 ]

With IPU# bridges, endpoints may only be created when the IPU bridge is
initialized. This may happen after the sensor driver's first probe().

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/mt9m114.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/mt9m114.c b/drivers/media/i2c/mt9m114.c
index 554f25071cca6..b1325e2cd1321 100644
--- a/drivers/media/i2c/mt9m114.c
+++ b/drivers/media/i2c/mt9m114.c
@@ -2360,11 +2360,17 @@ static int mt9m114_parse_dt(struct mt9m114 *sensor)
 	struct fwnode_handle *ep;
 	int ret;
 
+	/*
+	 * On ACPI systems the fwnode graph can be initialized by a bridge
+	 * driver, which may not have probed yet. Wait for this.
+	 *
+	 * TODO: Return an error once bridge driver code will have moved
+	 * to the ACPI core.
+	 */
 	ep = fwnode_graph_get_next_endpoint(fwnode, NULL);
-	if (!ep) {
-		dev_err(&sensor->client->dev, "No endpoint found\n");
-		return -EINVAL;
-	}
+	if (!ep)
+		return dev_err_probe(&sensor->client->dev, -EPROBE_DEFER,
+				     "waiting for fwnode graph endpoint\n");
 
 	sensor->bus_cfg.bus_type = V4L2_MBUS_UNKNOWN;
 	ret = v4l2_fwnode_endpoint_alloc_parse(ep, &sensor->bus_cfg);
-- 
2.51.0


