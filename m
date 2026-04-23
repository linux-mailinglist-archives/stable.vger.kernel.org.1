Return-Path: <stable+bounces-240537-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHrVJ7Z76mmqzwIAu9opvQ
	(envelope-from <stable+bounces-240537-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:06:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3C3457206
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3897B303A6F0
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9130F816;
	Thu, 23 Apr 2026 20:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHLgdsWJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ED927603C
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 20:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974755; cv=none; b=ObLCCPkl3BMjTx+zCrfPgT6YtNvC6p1U3hDv+dujnXc1DNiMhg8Lk/6SxGX4RS/C7JuOs2PaiDAAw05mjhw8vJstJcuGQEnhABcpUACDMAkzYGtlOxfZ4qc8W/JHv9k7Bf2Z7tm+Ln11DCGP0R/Jbcrr+wL8OfjRTOWKH64t8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974755; c=relaxed/simple;
	bh=3o67tNBartiKtCDxZC5jrEXgLBAEj7xBtAGcp6wrC5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ksbt5NC9iGV1JCVXIBlkzd//NJS3ok+7jZbKpdnV3K8euKEfIvMIR66g8a0S+rOY7AnZQDMlmkfWcMCHbm1RmavmmbDeSvxoUgx4qUQrjlj6jeauUWkjlHfeRQ/BvgeqFimsUfipxmb79AwIkrrnn8GA+ib8t+9xcXRxZX9cEM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHLgdsWJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso66538415e9.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776974751; x=1777579551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0yq3naw4P7KBF3HnI/5iYacHkrIr5+a/lmsEJuzBgA=;
        b=EHLgdsWJfPxqYI19Ymm12ASi0KvT479qoq2UmyC7A7bISUo/Vw2DInYIkoccYV2rxJ
         07tZT6pPiekYsRnOanGRV/CsNy4yx4mzylE5hkOjvn0YhwIuNzjy5nD1CGseTaDJg7Ev
         6DZ41i2J9WUwDO5021I4ip3yztZ4072fwAwiOqbyv5XedngqdMztPRhZckdhQg0/xD8K
         Um0ujIxpbdjnFi5jHTG5gGmPXp3Nz74wIAcJyosE3z9U3Ri0ozEe2jf9VLjUUnEZV3BW
         d9bYaMzxomSo0kXwv7Lyx1Biz5DHD4VbaC+OGQ3DnmS6y1G1dmjXawrZHsharuii0ppX
         i81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776974751; x=1777579551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0yq3naw4P7KBF3HnI/5iYacHkrIr5+a/lmsEJuzBgA=;
        b=rCTmKv9hFH+UoX+wDO/YwUIIFIwxcM9tXejSUODJeZDCInuj4uRgZdM7pqS+8HtrzI
         QQqb/FtR8rjL5nHl2DRt875Y+aYTcqekfnrJtNyfw2DDZSKa+1+s+cLH+57pY2u+nf4a
         1vLArzFRj/ZXXQNynNnL0hTp2KwbCciyCGSlpF8+VBLW1tfyDsPfPROq/YfrKNT0Nn7E
         79Gz2rFwhSXeaxJXzUDAeRyDU1cjVfBxZx6zCV3U+mU6IzO/R0QF36kHUgdZHlpfWSd6
         /qgADcwZXB09fbwPZtksw1xfvdA9wSU5F5xcrry6V2+uP0jN/nYRdBkETef77fmra2w8
         BJYA==
X-Forwarded-Encrypted: i=1; AFNElJ9GMhVwYlwpnTg+VfgVbHabRDIfypAJROcF10MRlaRTGqfojeeNrwegAvI2ebrcIY/iMiS9B7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKxGp8diyrvtP7/M7BkEOoJNWKvyK7wF75qLu6EnH8n1mKVgO
	Lj0ZT/KbuTac56+eHYgfT/0WJjQueQUNUx5vVQwU8Wm3Rhf4zje+dhku
X-Gm-Gg: AeBDietrolxEkQ6prOD51nIsZ7PmzpL8E8nqVSJHsTcL5F+ArPGHXcTE2oJu9pFQRjA
	LLyzmLl5658mzyh1lnG12eYVTmNvJ9oN4x0ALbVO0jt6OYpPoUO0dnJ14FFEB4pb6gCYcyturmY
	dq7CHhIiU1hicraJE8w8f516mcETYEV3meXiNn/TrVhhCLYWcZK4JOk5kwwZ+UC2jPzkJP1qd+D
	bZxDSdc9rv5Iei+dRec1rszneDsoVSpCgBZm7jQDqeDjQYV4Exsatf5P7sn6V8cLOLdYAVl3YWW
	+Br1DaBBp4yiQLpbyEvf6OuAeY0dCfzZ+EjdpHIb8aXNEhFaWsbdjNafwOMq/mdxqo2r3PObcDY
	34Af3O63SDF5BVy2zv3mGy8AB0xn0hkZyBTYHAk7ETmLQCqc77cTTCZ5NTJAIEBQN3smJF9OqOl
	XYnceovHxfVVILvC+U88YXN88pgwxaWl8LDNzJhgzCGL/znYDVcCVLGxmOt5Rfe2d9RejnwA8=
X-Received: by 2002:a05:600c:c177:b0:488:a82f:bba9 with SMTP id 5b1f17b1804b1-488fb7804f3mr383647975e9.22.1776974750505;
        Thu, 23 Apr 2026 13:05:50 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb135asm59683343f8f.6.2026.04.23.13.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:05:49 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com,
	Jagan Teki <jagan@amarulasolutions.com>,
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
	Marek Vasut <marex@denx.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] drm/bridge: chipone-icn6211: use devm_drm_bridge_add in i2c probe
Date: Thu, 23 Apr 2026 22:05:46 +0200
Message-ID: <20260423200546.324187-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-240537-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,amarulasolutions.com,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,denx.de,lists.freedesktop.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1C3C3457206
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use devm_drm_bridge_add() so the bridge is released if probe fails after
registration, and drop drm_bridge_remove() in chipone_i2c_probe.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: 8dde6f7452a1 ("drm: bridge: icn6211: Add I2C configuration support")
Cc: stable@vger.kernel.org
---
v3: split the patch into two, one for i2c probe (bugfix) and one for dsi probe,
    and add Fixes and Cc tags
v2: devm_drm_bridge_add instead of drm_bridge_add
---

 drivers/gpu/drm/bridge/chipone-icn6211.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 5bee10c64265..4d76e1bd5e78 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -758,12 +758,12 @@ static int chipone_i2c_probe(struct i2c_client *client)
 	dev_set_drvdata(dev, icn);
 	i2c_set_clientdata(client, icn);
 
-	drm_bridge_add(&icn->bridge);
-
-	ret = chipone_dsi_host_attach(icn);
+	ret = devm_drm_bridge_add(dev, &icn->bridge);
 	if (ret)
-		drm_bridge_remove(&icn->bridge);
-	return ret;
+		return ret;
+
+	return chipone_dsi_host_attach(icn);
+
 }
 
 static void chipone_dsi_remove(struct mipi_dsi_device *dsi)
-- 
2.43.0


