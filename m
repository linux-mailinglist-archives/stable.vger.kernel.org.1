Return-Path: <stable+bounces-64650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71D0941ED5
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7A71F214B9
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285E1898F6;
	Tue, 30 Jul 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KFOJgb6t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C04189B97;
	Tue, 30 Jul 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360814; cv=none; b=Wo8fRZG+hi7dTZN7H+ZluQdnmLi/7+ZPRy/ilzfju62paULFSm2HQr2HLAFFJK8XWw7bQyidhVHQV9lSjdqYZl6DYcRHbP4QgReQvBOIMbzPZe/UCPUwJaFX2cBSzIlW4ZFJco4FGd2LMN96pCnwwaNLlm1lsjf1RBoWw0WWJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360814; c=relaxed/simple;
	bh=PFvNgfFuH4GuKkSz5g1Fe3r4WMaxmrJrHGa5fhT+TmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE2HoTHTGgJ6w3hIPuEV29wz9oesVByb4GxZv2RBsUgeY2OXc+I2PuTCC/dkqXKyShrjHuty9LETVLInjlAOcMyeGO5piZ6IxfMsDKBFhFFw9C6Sn1LMCqbjhxLM/2tEzBRFkUipHkuje/jDR2wuhDJFRFgxKBEnfHdRbkmgPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KFOJgb6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB38C32782;
	Tue, 30 Jul 2024 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360814;
	bh=PFvNgfFuH4GuKkSz5g1Fe3r4WMaxmrJrHGa5fhT+TmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KFOJgb6tCjEd4Sjlxkjti6/r0H8Xf/jl+fnY95kdLwPLFYLQw+SDFlJ5BR1/xlo1R
	 YuUSQWJGDvzkwdkI1tHSZc9K60Pz0zNQV+DzqN9CMVX0nJBrui8rn5tEg/QK8LlNeN
	 dCmiDbMEqNafWpGhu47svOReMO/pkP73B/GZ8fxE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 800/809] thermal: trip: Split thermal_zone_device_set_mode()
Date: Tue, 30 Jul 2024 17:51:16 +0200
Message-ID: <20240730151756.577501316@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit e5f98896efb3b6350cb6f1c241394966dcbcf240 ]

Pull a wrapper around thermal zone .change_mode() callback out of
thermal_zone_device_set_mode() because it will be used elsewhere
subsequently.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/2206793.irdbgypaU6@rjwysocki.net
Stable-dep-of: f7c1b0e4ae47 ("thermal: core: Back off when polling thermal zones on errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4e7fec406ee59..657c57a40b4d4 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -272,6 +272,22 @@ static int __init thermal_register_governors(void)
 	return ret;
 }
 
+static int __thermal_zone_device_set_mode(struct thermal_zone_device *tz,
+					  enum thermal_device_mode mode)
+{
+	if (tz->ops.change_mode) {
+		int ret;
+
+		ret = tz->ops.change_mode(tz, mode);
+		if (ret)
+			return ret;
+	}
+
+	tz->mode = mode;
+
+	return 0;
+}
+
 /*
  * Zone update section: main control loop applied to each zone while monitoring
  * in polling mode. The monitoring is done using a workqueue.
@@ -537,7 +553,7 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
 {
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&tz->lock);
 
@@ -545,14 +561,15 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 	if (mode == tz->mode) {
 		mutex_unlock(&tz->lock);
 
-		return ret;
+		return 0;
 	}
 
-	if (tz->ops.change_mode)
-		ret = tz->ops.change_mode(tz, mode);
+	ret = __thermal_zone_device_set_mode(tz, mode);
+	if (ret) {
+		mutex_unlock(&tz->lock);
 
-	if (!ret)
-		tz->mode = mode;
+		return ret;
+	}
 
 	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
 
@@ -563,7 +580,7 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 	else
 		thermal_notify_tz_disable(tz);
 
-	return ret;
+	return 0;
 }
 
 int thermal_zone_device_enable(struct thermal_zone_device *tz)
-- 
2.43.0




