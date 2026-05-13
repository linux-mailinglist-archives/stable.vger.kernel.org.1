Return-Path: <stable+bounces-246764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME5/IN8gBGpyEAIAu9opvQ
	(envelope-from <stable+bounces-246764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:57:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61452E566
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8EB530684CE
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3360D39FCD0;
	Wed, 13 May 2026 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1RoJxwO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBD3D5643
	for <stable@vger.kernel.org>; Wed, 13 May 2026 06:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655453; cv=none; b=KfqtcdTu1RmIOxKJ/cvX6jtPxTscON2KQUzWCSFW0UKcZsflvBGb1Pb7lkZe6B5Y4yxSKtt37AGw+VYMksmZylfmSTGkGbKA/hb1uBH1A7GAg7NcYoF0K7fb5Qu3myZlp+7i0V1wQoxPc54jgdbSQ6DzhqByAOCDeS1FustaFMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655453; c=relaxed/simple;
	bh=D+rXkpNbYM57iw66//z9yFnWXidsQpnxHALfm7NCx7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGsyAPIAHLzsZaBotKfVatRqxXDIzBd6mE75SBVKAD7wqo3mSGL1TiNhzWIZ47/zia63jXotidXJs3PfWnSqR8ho3H2gUeFsg5khcFp+vQMKYnXAe8ZxYxclquO6CggqwZ1euqAiqd1vT9RZ/d1PVlvPjBv3HeqKFH3Xwy2TqdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1RoJxwO; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3664df32e91so5137960a91.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 23:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778655450; x=1779260250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lpyhgMOndReaAQGfFDlhOvUXYhINkrL7L3hO9NJYJ10=;
        b=s1RoJxwOF1kcvY1d7SVj3EJ26I6vmTtJy2pETN1FRdkK/yOxVMSTTRoVbpWfONtNXo
         O7HyTkt5eu6BR9vHmp+9bksg0wPzdx94ndZ8eoKPVXLTxEFfX6H1H/jWuIDk4J0ONRPN
         l6NXMDLDl717K0Cow2uTBo2qA7PIeOogLhl06dDeg7+lvuUiYZcH9FW7z+4hq3eTEPO5
         C7eOpWUH+Se0XR/ySEmo/HSv/2yW0E969k5WGBGJIf7H3lQWU/pWmZTGacmDGxr6STMz
         irhyDy2aIOPa2BycXxaZ+KLc28BdLevJh6T03+VaC7LOXyci7Yr4gmzB2Z0NiKM9F3Fm
         B3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778655450; x=1779260250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpyhgMOndReaAQGfFDlhOvUXYhINkrL7L3hO9NJYJ10=;
        b=Z5RbvfajNLIHw6yGmUQ5rYxj641bBgbarnSQdxfhJgH2Oxo8uBqwgOfoJqPKIRCxps
         WA+cIuYI0V4m/mA5Kf+MIvzM44M2wxY5HnvrmFKV6n6p3J2RgFl/xvep7vypesuMKyMq
         Uqi0wACPtOr9Elf1QWga68jgrd5bR7d9Kfv7ZDubLbg0wz3i0XFYN9kN82HBsBzVJF5C
         cpiKAUk1d8UBAuXfn/DYDUG2SB1NmBsdHgXQ7V76lC1CCJSGCc4TBISaXY683tbmSSOW
         3tErj94ZGgQ3g+syfTTryRriIEkaXygwYOuxOs7ZZfNnmz/K2eh9XbnPAkG7jXOf069B
         t8Xw==
X-Forwarded-Encrypted: i=1; AFNElJ+3CZvTsYHSLNBRWXyrDCm1yxWzuKGNYa6CsRYRuRe6w81qOB99CnP8fYp47Y7xe5k8bSbuUJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMfFPA0A8dUagFiWs8qcJt3/4r114S7lBc4YYQQqgAQX1LspE
	1yhMLpNpQdE25UBjrb9e3vqkeDgcrRoZqkGMtkdhLtxnO+3VnCEUqUA=
X-Gm-Gg: Acq92OFR/Qulwc2uyHDPfe2oynKVc17Ic6KqKBleV/6meReOKGkm3R+sBYboFUmCo72
	m93FKeLJMgmODxY2o6ch+ey7Lyx3Dj4g4b0XmwmkD71u43/uEd1Qhg+2SnLzHq3bG40f1y/crHT
	2f4exxqzBMaOQkwuYxH+Ai/UbXjw3QBmNogF1NDv233o8b24GIP1KAUxmuEW6OJPMssic5zT0D0
	Hvz5YGkyIA3kLpVJTX/QNDGsBSw5skGyp9ITDuYkrbzGWLurJgf6pAfuKILRCmKPj6+yJqaA7uc
	q5archhcZ2BawbSwV4hnSX9IEToAf8bGwYfe9RuKpup6gfOF/5ownOPUow5gsz58N42dSTRZ+U1
	ISFFeQQmUbACqRth37n0f6Slwa3Fh6/hRBcDA9nntr6WjLJG7hGyUepWIjtdpF6XOrbZDHg94sr
	3swMPEjRmKEMsFrQKRtZlpaIzJgKDZmKzJPkemG+HQjLz4GV+RtmoJwNzpWop+H5pd7Uwt+F/o3
	g==
X-Received: by 2002:a17:90b:3a8e:b0:35f:b5df:463 with SMTP id 98e67ed59e1d1-368f3d1fa46mr2326543a91.14.1778655450438;
        Tue, 12 May 2026 23:57:30 -0700 (PDT)
Received: from localhost.localdomain ([211.198.234.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b07163d0sm1945647a91.11.2026.05.12.23.57.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 May 2026 23:57:29 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v3] drm/loongson: Use managed KMS polling
Date: Wed, 13 May 2026 15:57:00 +0900
Message-ID: <20260513065706.23803-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA61452E566
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,iscas.ac.cn,suse.de,loongson.cn,kernel.org,aosc.io,xry111.site,linux.intel.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-246764-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,loongson.cn:email]
X-Rspamd-Action: no action

lsdc_pci_probe() initializes KMS polling before setting up vblank support,
requesting the IRQ and registering the DRM device. If any of those later
steps fails, probe returns without finalizing polling. The driver also
never finalizes polling on regular removal.

Use drmm_kms_helper_poll_init() so polling is tied to the DRM device
lifetime and automatically finalized on probe failure and device removal.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Jianmin Lv <lvjianmin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v3:
- Capitalize the subject as suggested by Huacai Chen.
- Add Reviewed-by and Acked-by tags.

Changes in v2:
- Switch to drmm_kms_helper_poll_init() as suggested by Icenowy Zheng
  and Thomas Zimmermann instead of adding manual cleanup paths.

 drivers/gpu/drm/loongson/lsdc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_drv.c b/drivers/gpu/drm/loongson/lsdc_drv.c
index abf5bf68ee..4b97750897 100644
--- a/drivers/gpu/drm/loongson/lsdc_drv.c
+++ b/drivers/gpu/drm/loongson/lsdc_drv.c
@@ -292,7 +292,7 @@ static int lsdc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	vga_client_register(pdev, lsdc_vga_set_decode);
 
-	drm_kms_helper_poll_init(ddev);
+	drmm_kms_helper_poll_init(ddev);
 
 	if (loongson_vblank) {
 		ret = drm_vblank_init(ddev, descp->num_of_crtc);
-- 
2.47.1


