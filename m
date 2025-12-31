Return-Path: <stable+bounces-204359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA1CEC1BB
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 15:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E0603007CA3
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCED2773F4;
	Wed, 31 Dec 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mze1LWNs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A96195811
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767192112; cv=none; b=nRjFavBxh1Vut41L/FowbbOQr7Z6KZWTL8W8v0xdhN+W4B0oIYwTUNGINmb4YK+c+VcdIRaMyNdZ+oeGx5nAbvRf8UjLiuk5FpU5VxkG/qPWVw3euL37yGiOEuKmMReRlgL8VSJRmeVmn2gPzm5dj1xx6l3U1LETxdnpdMUM9Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767192112; c=relaxed/simple;
	bh=JWtZZOP75gkYf9I3WDfHYLZ0J1D4OB5LFiqOaPQ762A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YVYfz2tJn4PBCyN9aPQmkiS71qp3k9Y764iK2EOti075yA8uS7vhJfearrnK9VrjdKweeRzKGkZeaK9uFlRjjtJZQTVFcYpB8m7LwenYClmYefvYTqNGQITXB5BI3YiwGDB6+OOBF7qmE6E4ulW7I0VcNpg3R7pkBHWkMvcbmMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mze1LWNs; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso1431718666b.3
        for <stable@vger.kernel.org>; Wed, 31 Dec 2025 06:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767192108; x=1767796908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6n3OW5NUfOZx0lkTNPzw5JAKuD6biTxM7bek7HtmsL4=;
        b=mze1LWNsM0FB1bCCfIv1T1G6KRsy4DPVQu9do7JmhY34per29DmyDj5JGZKC6Xgckc
         tI08iNswU9PbsBa7nkvfuJHm//45iKOEPXefdILZoDNCfHA5MAYQMUH0we3Aqm/vzGeH
         BYgtvZAXiQ9PTyl6BKvlxZA4IrABAbNwxe5crJUmHokajTQSig6XPXM8/5fD+mdQQYaV
         mWhWqa/mWILtQLBuupz4Y8kDqn0Szq/9D/UykVLR87QFU2TSfEp7126hIPcZkT9EULrO
         GrvPAXg8S96xOshfWyeKKK++904ndqsiRlUA8VpfGzWlKnWxoeXFAHAF7YtOaEw5d9U/
         XoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767192108; x=1767796908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n3OW5NUfOZx0lkTNPzw5JAKuD6biTxM7bek7HtmsL4=;
        b=ht5pWaSragfj28f8RttJ6tTCj7gKNGCwo//Y/+2S5CpXPCE7d13yaWp/Hv4II8WBPH
         irD64G++68UbVrAKdY3RqS48bd3+G7nmNpPTftvBJKQusjBEZ9hG1k+fC2lUMIWvqqwz
         6X6v2WfyEOwOBp0X+dxgg4RYzieVNxhp3jRfGt9q3ZvncRUYWHsIZ6LGUhjCWGmVOM8N
         NWLj4guvtGbev9z8V1M6J/bzAPKhZtJJ6/NIRIFSqKSsA9pXxm17FxGW61ZUXrkQ7TNF
         Ds56t/wa31HfhF1dPk+NrO4kB9DR571TsKBHRaCNnOeDE+XYGDZ/xhbksSmO5HpInK6k
         J6HA==
X-Forwarded-Encrypted: i=1; AJvYcCVIsIRlcYg7jrsDb6WOnBQ9AN7T3/7fmvqmNSCxF67hoIndoRzd19XRYNkomWT3NpQwRQbyrM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJpCvlC4IJ4Gq+m3ITTCf8iM04Tt8mLlab7x7Tou/xBdGQYzH
	zHuxZ7pn0Bpo1gYOYVjwE4LmhrJ1Q+1buf5ctV5rNmHkvOeRyAmWdsyE
X-Gm-Gg: AY/fxX6EUUCqEOun7BGtG9Xy4iJvL5vJ/l5fwOFY6pb+7NhI+X97fVtK+ziH+JotHH3
	8NPb3ypuft87pujh5a+JnyD+LNHqEG6c2Hkoy50b/bACXGjR5syZ4fbtwYMU8XrBm77RDbbOizo
	XKF4qS8hKR96O/pfABR1BwPWSHXqysdG3qMi6cbQw5XAF2eXd4TFG4+U5LUv5zBno1jiaEmtTx/
	VAtJO+eUSpkj7c4zWhyrc54D/bpc3vNp9avOUYcZ74GSw1UDLghgIgsQQHtOcU8aJwKOpS4XY/G
	kvNcNHhiBtRSk+p1MsIjBGJLAz8c4m/qn+gQihNqCJt8ox+LIWxsck3G+lBwrIfsliBp0hZon1p
	m73NkYL4svJw+P8MJNbJEsv7OuziCZI3VYMm2Jee8sevtuj0628D0PBwTPpwf8JwM+iniwjaojA
	uIXNfED5kFrELPXfs=
X-Google-Smtp-Source: AGHT+IEUPzBdPCEuEHiEfsb+kEeP0YSRVpplBMnvJmaPjfjYKXuuxhE3L0J+JXeCfF8KIokhLTjB0w==
X-Received: by 2002:a17:907:984:b0:b72:3765:eda9 with SMTP id a640c23a62f3a-b8037256c76mr3755521366b.60.1767192108066;
        Wed, 31 Dec 2025 06:41:48 -0800 (PST)
Received: from osama.. ([2a02:908:1b4:dac0:75b2:7ca6:1e15:d2e6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0cc52sm3909242066b.52.2025.12.31.06.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 06:41:47 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Andy Yan <andy.yan@rock-chips.com>
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org,
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
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: synopsys: dw-dp: return when attach bridge fail
Date: Wed, 31 Dec 2025 15:41:14 +0100
Message-ID: <20251231144115.65968-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When drm_bridge_attach() fails, the function should return an error
instead of continuing execution.

Fixes: 86eecc3a9c2e ("drm/bridge: synopsys: Add DW DPTX Controller support library")
Cc: stable@vger.kernel.org

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
use concise error message
add Fixes and Cc tags
---
 drivers/gpu/drm/bridge/synopsys/dw-dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 82aaf74e1bc0..bc311a596dff 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -2063,7 +2063,7 @@ struct dw_dp *dw_dp_bind(struct device *dev, struct drm_encoder *encoder,
 
 	ret = drm_bridge_attach(encoder, bridge, NULL, DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 	if (ret)
-		dev_err_probe(dev, ret, "Failed to attach bridge\n");
+		return ERR_PTR(dev_err_probe(dev, ret, "Failed to attach bridge\n"));
 
 	dw_dp_init_hw(dp);
 
-- 
2.43.0


