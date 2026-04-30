Return-Path: <stable+bounces-242200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEboHyi082kg6QEAu9opvQ
	(envelope-from <stable+bounces-242200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:57:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9F44A7817
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 21:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2372300B8E0
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 19:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF04382380;
	Thu, 30 Apr 2026 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRfraDgE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE29381AF1
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579036; cv=none; b=t/7fMMlFBrWNwn4HdagCyCxYwBahHQzriTJ3IZ5D1pKyQ2iw5zV6xQg4yf3zh+YovLeTDPd1kWrShejy42bronef0mCW1N/wgZFZcb/D5rAZjt8+5pmy8eQ8JM7Gm7sGnp6xCp9VgaEirsy/B1+5XHAORmwx9Bb5C2K+3SXwX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579036; c=relaxed/simple;
	bh=IamWvDL/vfzrLrP055VymOxe9MPDgKdr9LOvSE+KKa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5pe8Uuo6F+PKxfJAQpr1SLgr9awJFKZBClyqAYVAfxNU6NWEipfm0KzLqTfaucESaWCuMn8k65mrG8XhR90TCCnNxb4lWy2ODCfbX2M0bOtRPpul30GekwQnhFz52amNOBcYsBb+Ax/dA08AkS1U1N5EfppMBACQxnucOLfgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRfraDgE; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43fe608cb92so821947f8f.2
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777579033; x=1778183833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xXo4GTKuApdH2855i6VQmTYDmGzNNitfMak3tWGUlss=;
        b=GRfraDgE5l3pb5/OT5SeaM05MWot4xQ1AMGjibQIHaIwl+Z3vQD84sQmM2ulCOaP+r
         Jt4gSF6CDqZXnVJZN4Q+P4/GF9ZznMA6VmQyaaHr1Vjb7RxQIibAurQABFFSzc/3uVbX
         zcAgBtkwe/i2L9GS4sVJyP81iO1ARbYM73ed6NbeYFJjmLNpBZuvsp0OC4+OIlJyTtOw
         1TqIbKb4kPugBrOJLgoWjh+yG94hSGE8zCWkWiH6OSkP6k8rNehfiq8JEuOsoPmkMn5L
         VSWv5ADuIvHUl4SlZB+QPjziEyR8fdG7VSHlUjsejZ0hoCRk49B5X7bqrWNd8YgcSE0F
         tLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777579033; x=1778183833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXo4GTKuApdH2855i6VQmTYDmGzNNitfMak3tWGUlss=;
        b=HOc2QdzHjGHdXvorVot/XxCI1b5nRL08MYTPVdwViLw3pdTRdmoTSInHMrQ1JkW5dE
         Zi51SZU6Ivhs9IOgEfN+dhhJn5wkQcOnFVkU7QSif0ZK1cmC/aW+j4EOoZKZyZvBNWSR
         9eX9mJmbyIuGIH8Y3yUYWSB7EKRbNYVzH3VhVQdzkNUtfahPG0GSS2iovZmTDAauLisv
         wG3+UQXynFLJTZDeUE+agzrwMADtD6XEklETN2jt/oJQFwDKYyBLRvzNlErQLvkAEgLV
         8iIA7+jVyBCghGPr8xVl3iG+olvCIc952S2ApCzwqwa3q2Juwnh9HhzIV32Aw7l3X/lb
         Q4qA==
X-Forwarded-Encrypted: i=1; AFNElJ8h7D6kwoGH6syuY9dKc0rUm1JUepeP1L/hqzcrQihIxnjVnpKuUbLV4Hh4U8oUdrAp8/1ifJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7yurUy9NETdDxaEJQPODaLst2VyerjoJ/zfYAEVNCOJ43ix8
	UWlQW89QHG8pYOPZn0g82U9V8PexF4Mg6G8rJnDZGHphLQiXJr8nYnJC4OZJMhczJ6g=
X-Gm-Gg: AeBDiesH69o1WapicRjP1D1V6n4+BEFypGQw9GD0oY5wNonZ2zId+J/k8xgBwE5GtQX
	T8aj4M4sgey8Zf8GLtJdjipz6XRYB+JQs9cZwAmFCVr8UjQX/f4xCqP157gP/E/UcTPrJ2seuKe
	qcGX1zEwRtQs2a5JkXniMQSdAo6q9+VbNWKmm575zfkCQ/tTgtTTiGzp/OdxDRYo+XtqrsWeQWo
	7te6YuFIt/ohpZCMJjK7klw/8CqTAmkLnvarXzXWFnRarrl8zsO0vp8ojQ1m9Ss+R9aeDd7yP44
	9utTCcL6ja77iuw3OyONCWDIuaq1GZIvzGF7TLhEMlk4lnV+n2mYovxrDSe1RAfyr5njswTgJGr
	Jf/82zgOV2YFoYtruM/g34ZN4jtppcfun8eUfThA3382DifVTKz+zq421sygUX2hi4U3CBEeZ8M
	RqYXoVsEtX9RAseHDYsuDPYrrhrA/pzukn8pbXrocvJZfSKGsKasjH8u5UO/NQ/krKECEjNMA=
X-Received: by 2002:a05:6000:2c11:b0:43d:775b:c9bd with SMTP id ffacd0b85a97d-4493cc3f4e1mr7237459f8f.10.1777579032765;
        Thu, 30 Apr 2026 12:57:12 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:55a4:d495:8d6f:1416])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5afesm13003924f8f.30.2026.04.30.12.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:57:12 -0700 (PDT)
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
Subject: [PATCH v4 3/3] drm/bridge: megachips: remove bridge when irq request fails
Date: Thu, 30 Apr 2026 21:56:59 +0200
Message-ID: <20260430195700.80317-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F9F44A7817
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-242200-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,ge.com,collabora.co.uk,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,codeaurora.org,lists.freedesktop.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
bridge before returning.

Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
tied to the STDP4028 device while ge_b850v3_register() may complete from
either I2C probe; devm would not unwind the bridge if the other client's
probe fails.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: fcfa0ddc18ed ("drm/bridge: Drivers for megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)")
Cc: stable@vger.kernel.org
---
v4: update Fixes tag
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


