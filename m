Return-Path: <stable+bounces-240540-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOveMhN86mmqzwIAu9opvQ
	(envelope-from <stable+bounces-240540-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:07:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0C457265
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA5AD3070190
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9170C29ACF6;
	Thu, 23 Apr 2026 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZbT85v3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BA2F546D
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974800; cv=none; b=WSdxEYxH2eW8qPY2ANxM7U2eNy1dMNxxfBk50RyYK7dB3XOdQJTTuLZ0So+aYWAhBW2Za65UzddjXxpxCs7vIRbD9+00GtQn4ohg2kMd9jURe7qPUV1XszIWFffV3Ng0PurUGCOzyVTWBje3i4It4OPBe0bxjTpX6x+ODAKzPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974800; c=relaxed/simple;
	bh=dXyiylolUmGsOzz5jmiXCkRFK6IboLObEsTCyuc3+Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td2Spqbaw4xH9qd/Gi54CdPwWbeAthqmY3j8nHhxTyF2UdLIiuixf9U4+5y5sA5OpwRpcggVfbZY18Z3BE0sPMd54nwgJsqnjk3w45iM33u/r9mVR8l8p0/P4qtA7l9DwjGTls+zc/xkqzY7i+9WKRgkXgdRu9FwCAY06JOcVIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KZbT85v3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48896199cbaso69565585e9.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776974797; x=1777579597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6o8bMAHlpjyh3M9xmgw9hNhMm4y74iIizZKcNnRu+9s=;
        b=KZbT85v3SQsbSsqGvT3oAaY3MC+V+0QysHARkmIzVwPiDai98TV8TuaaD5xV9nmI6o
         njA1j0vz/bJVl0mMhTnXqSYDBcmJ+P0bbZzA+cMyIfOPg2BMwXoagJpO6hOFW6C8VBFK
         OVyOBRN057TSwRJEkt9TpCXmSJgZvxMTjpT3tpo2xT0mFUIU9EShAe9hwXR9MAWReDCv
         SUlZ8ybzOMq4eaLA6U3Wye9BOzej7ZW+vSH20vWdM+WhBwaNAdjd6MeCGQgrDjyUrzZA
         F4lLsZrKq247boZZairzZdPvxzIyikGhCUpjQRRYkfikVVyIUUA6gK4HrnP9fdzzRG/V
         Q5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776974797; x=1777579597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6o8bMAHlpjyh3M9xmgw9hNhMm4y74iIizZKcNnRu+9s=;
        b=WDs+NYENW7atec7namxYCyeEiUsqA80x+qv8fmxKkdebCR2w95uI6uQzkjVJoOD4fk
         J7S6i3EAVrY61ib/IIFy9xrN9WoS1dVc8E/SdCYsD8x4rjQFv9bscLFFc1YhLRpv+uoX
         dYD8vEeyvfE1/cbt6fEjW0casnIotycMBe6n2V7q2Sg36jjTapMLlU96yNeCyG3ClZNU
         m1jc2d0NqXeLhyXJMKQpnMgLQBM+C8V8ATq33MAw4mll7UU7QykIlRwFRGaHOYcVVP+1
         UJo37lTjykEYPUUtOVQK1bOMMvCmt/ijarZwOCMwlLSyVTswJVco87OqSP5V+zxNPPpF
         ozTg==
X-Forwarded-Encrypted: i=1; AFNElJ/jWqYsEJ55x5247H/7k9XcDaQbY7/pJWQ89kIBVSjg8shmcaBenTO7U2u7PS1C+k8yVISbMJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQWyPbbo27ETGwf9umK7VK/0bSbOzq5pu6FeJQh8eBCMaP8QWV
	BzqzB2/wqGTgYCf3FnTDyeFV7sO6YH7aHw+cKL0W/6NqySbksJ7tpiO+
X-Gm-Gg: AeBDieuaZmsuquQ8i8xub+DLWivapn/hJbcABkRZ80fCFitlVSdyLvXawizA/i0NNgC
	JtBFDhcuqkh5dY9oUvR73QYpT0pgRVxei34Z/jjZKKRGs6YZCa061/6/XNaRuiR9GlwnzD94r+U
	fjCH26L0gaBGnYX5HV0rP2uf6Ip7f9cUpnPoLCG73cT1PhI/X053WrBOHrbRoIgqG1hV489dr+o
	DndOYiKigHaMW6D2+vKMIfmOq+qQQLtJj/xvepNr+L7+rqbu/NGN+izHrtps/obc+VIedy+XHqU
	5eRgqeyYEL+m8f0StDA6OFLYqfhc1sFq/T/Zab376O5DHUj/y34gJ4tncQNoVk+d+cfJTpe7s7m
	tusnV9EP3oay15pRLurZSSTidIsG0R5Gdpqy2ABnGXVTagIl9JE5KrVdjvBGsFgK+Wu3orEDfzx
	MOItSnWBF6GNRb5yimzbsuEks4We5JQMEt1wQTA4eAU058BuPeFsqRYiPaTaquN5MgbNTcLuQ=
X-Received: by 2002:a05:600c:c10e:b0:488:9439:880d with SMTP id 5b1f17b1804b1-488fb792c69mr299890125e9.29.1776974797287;
        Thu, 23 Apr 2026 13:06:37 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75ab25sm167658815e9.11.2026.04.23.13.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:06:36 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com,
	Peter Senna Tschudin <peter.senna@gmail.com>,
	Ian Ray <ian.ray@ge.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Archit Taneja <architt@codeaurora.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] drm/bridge: megachips: remove bridge when irq request fails
Date: Thu, 23 Apr 2026 22:06:21 +0200
Message-ID: <20260423200622.325076-3-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-240540-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,ge.com,collabora.co.uk,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,codeaurora.org,lists.freedesktop.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48B0C457265
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
bridge before returning.

Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
tied to the STDP4028 device while ge_b850v3_register() may complete from
either I2C probe; devm would not unwind the bridge if the other client's
probe fails.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: a68ee76f4a28 ("drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Fix bridge initialization")
Cc: stable@vger.kernel.org
---
v3: add Fixes and Cc tags
v2: IRQ failure path only (explicit drm_bridge_remove)
---
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index c9e6505cbd88..2d02cc69f237 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -251,7 +251,6 @@ static void ge_b850v3_lvds_remove(void)
 		goto out;
 
 	drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
-
 	ge_b850v3_lvds_ptr = NULL;
 out:
 	mutex_unlock(&ge_b850v3_lvds_dev_mutex);
@@ -261,6 +260,7 @@ static int ge_b850v3_register(void)
 {
 	struct i2c_client *stdp4028_i2c = ge_b850v3_lvds_ptr->stdp4028_i2c;
 	struct device *dev = &stdp4028_i2c->dev;
+	int ret;
 
 	/* drm bridge initialization */
 	ge_b850v3_lvds_ptr->bridge.ops = DRM_BRIDGE_OP_DETECT |
@@ -277,11 +277,15 @@ static int ge_b850v3_register(void)
 	if (!stdp4028_i2c->irq)
 		return 0;
 
-	return devm_request_threaded_irq(&stdp4028_i2c->dev,
-			stdp4028_i2c->irq, NULL,
-			ge_b850v3_lvds_irq_handler,
-			IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-			"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
+	ret = devm_request_threaded_irq(&stdp4028_i2c->dev,
+					stdp4028_i2c->irq, NULL,
+					ge_b850v3_lvds_irq_handler,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"ge-b850v3-lvds-dp", ge_b850v3_lvds_ptr);
+	if (ret)
+		drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
+
+	return ret;
 }
 
 static int stdp4028_ge_b850v3_fw_probe(struct i2c_client *stdp4028_i2c)
-- 
2.43.0


