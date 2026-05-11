Return-Path: <stable+bounces-245301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKw1GbQPAmplngEAu9opvQ
	(envelope-from <stable+bounces-245301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:19:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CC35134B3
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBEF43124F18
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0951D43E4BF;
	Mon, 11 May 2026 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS7DY41r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3E2DA75B
	for <stable@vger.kernel.org>; Mon, 11 May 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518924; cv=none; b=ExbXak/98Rho7SYtrAeS04pcG5/fjtl7ecHUxvQh79KSd38He1BM7tVc+cQXRmMdpJblMkIbyBZvta8HnjPUH5QHMh9Fuax6c41bUlUMk7fg8CFK7hBYyTfR5KqZ4P0PX1YzkzM40bIWVMhNX7Iio6XE5B31oZOJdx4fjKL27js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518924; c=relaxed/simple;
	bh=VOc+Wayii74xrxQlC1QoXgEhDx6pTCCZ0YyuwFTjpqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gn5AxRoNpOb/8Nl/VjG03utqAGZaa0BuyNwc07eXsAQN5zbWp+UchgjYJi4M7fryfa8Pu4eoQ+SM6CVAzRpKxiiDGrSF6CiqHgmJz1hUtk9vpU9FfT5vYMnLuYoWXvGj/bfndUroKCydToaPnOg0LGB475JzfnSNtzEQ2I9kVX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS7DY41r; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so2313124b3a.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518923; x=1779123723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oB4TtcqxvRLjMRr1fJG7J4uzFOlt2Uo+LQk87OI5Vsc=;
        b=LS7DY41rmFvuyhzgONoohJccSFtSeawG1AuLesnDwCxxJ6GtNB9s/9TppmQWEEKbDX
         sATmr2WCKGklmuNHyp7Ot8ncHh725I0Smgqwooq8Q1EfGarD+akXhiKmlfIBsOjYmnKS
         DYCs5ogizGHSA84RNCpMCXM/vU9yGNCHPiR13qlJ4g7HRcb7th7bHcEtub72fMA7LGu0
         MlMxk4iwT4X9mSgpMqtO5doyO3pXFf7R2r7AB4H7FwB9VOjqRTwKmFQluXU9QWgEFLUo
         YyhS9Uvc57ArOaI1pX/2wmlIZVmDiGY3kZKEEzRO1Uf4e9IuDbvUJqsCoi/YEBcQWfMi
         y/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518923; x=1779123723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB4TtcqxvRLjMRr1fJG7J4uzFOlt2Uo+LQk87OI5Vsc=;
        b=QBXA74N3rsnXzZfYZPpICEAVO3/R23vEfpdPUEZlG9hxHo5DslBqxQ6WJOV9/MAk6x
         HpgHuTI4IOKIiXGhRWwVQwUmWZ3a1Hq/bqnrO1eiztLpHD5YEATD5bGmpv3/8lI1u9X6
         Heg6PT/CHAYHcRuZ/09/0T5+C3THnb1M9lV2JwezbW6Mhw0QZXPgbQW7vu/XABV3lm4a
         Z2aMfN34N6ffIkZSt17z62Z8ocP1vgfZopG7g2kuVv9eVFs8q38oCqiTYUUucUSRg1SX
         fr9NkcURaJZN/q1MCWOXb4lcjnQaipcHGw+KTQEOryp7a71VyU9DbqMZ4BR8+4mNsJFt
         upFg==
X-Forwarded-Encrypted: i=1; AFNElJ8c1YxU1JWddusVg1WxSO7PMSfA+SaWQGgDfzDoXkiKHyc9TRDWDgw2MG81ktk4zPYh2yENDso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7bjmFIISx0AtCvK5fsOOG+ddeTkQLgSvfw81c0l9J0uJ5KSY
	mh1wzFsPF0TNsgHOomGUoKCvT+kGFlUFTnraG3d76mkJNeojHLkGAKM=
X-Gm-Gg: Acq92OEYZGMBzENjdcQ4ghaWuA1CnPZBCOPzi/4wtTOH0eC9SMPwF4iSPNLKBFrhjvd
	9PLoz9eOxzl9tQjhYKPzqQAY6oV1HvGfG2udK47gfRGKQOzrSKI4VrLHLP4C1vEyfMZAVgWxFz7
	7hnf1aWkczFL2nyap26DLN/+42phmuPrPAVTPzMYr1opHfw71rvKt7rYLXU1/gwoJdDcp2p5ZA+
	Xk8Fz5RmmLNRv1gMtpB52PclMXWHcswekI3AEx552FQUskiXB72r86Dhdg1ZPupf0jjDPLcG1Ck
	hwmJGzG66j/9K07r7GhLd/MMOlEAFq8v2yf2eOzox3q56OLNv5+vPk2BNWO1Sz4N1IGplb1Hi6T
	rMt2gTc7eUcSSyZRjGTpPf79uQLibkbC1uVYH7poZAvHaDmL0a6yOOt+SdWoR4N10I4UaLB4nT6
	SfoNEQIeNvkhMPU+oXxp6U1xfFs6S9sG7SdfJmx/NF2gZi5iFA9zSzCFl1ZhHhl2RbTTYmUYg=
X-Received: by 2002:a05:6a00:2394:b0:837:8a0c:8f70 with SMTP id d2e1a72fcca58-83ee83ec7cdmr272378b3a.28.1778518922808;
        Mon, 11 May 2026 10:02:02 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf7d2sm28032387b3a.49.2026.05.11.10.01.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 10:02:02 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/loongson: clean up KMS polling on probe failure
Date: Tue, 12 May 2026 02:01:40 +0900
Message-ID: <20260511170152.16957-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 10CC35134B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,aosc.io,xry111.site,iscas.ac.cn,linux.intel.com,suse.de,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245301-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

lsdc_pci_probe() initializes KMS polling before setting up vblank support,
requesting the IRQ and registering the DRM device. If any of those later
steps fails, probe returns without finalizing polling. The remove path has
the same lifetime gap when tearing down a successfully registered device.

Route those probe failures through a poll cleanup label. Also finalize
polling from remove before unregistering the DRM device.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/loongson/lsdc_drv.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index abf5bf68ee..3db1f8690a 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -297,7 +297,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (loongson_vblank) {
 		ret = drm_vblank_init(ddev, descp->num_of_crtc);
 		if (ret)
-			return ret;
+			goto err_poll_fini;
 
 		ret = devm_request_irq(&pdev->dev, pdev->irq,
 				       descp->funcs->irq_handler,
@@ -305,7 +305,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 				       dev_name(&pdev->dev), ddev);
 		if (ret) {
 			drm_err(ddev, "Failed to register interrupt: %d\n", ret);
-			return ret;
+			goto err_poll_fini;
 		}
 
 		drm_info(ddev, "registered irq: %u\n", pdev->irq);
@@ -313,17 +313,22 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
-		return ret;
+		goto err_poll_fini;
 
 	drm_client_setup(ddev, NULL);
 
 	return 0;
+
+err_poll_fini:
+	drm_kms_helper_poll_fini(ddev);
+	return ret;
 }
 
 static void lsdc_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *ddev = pci_get_drvdata(pdev);
 
+	drm_kms_helper_poll_fini(ddev);
 	drm_dev_unregister(ddev);
 	drm_atomic_helper_shutdown(ddev);
 }
-- 
2.47.1

