Return-Path: <stable+bounces-254043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMr2Ky4iE2qv8AYAu9opvQ
	(envelope-from <stable+bounces-254043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 18:07:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD615C3099
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B91300A743
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E683A63EC;
	Sun, 24 May 2026 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBzNKn6R"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22E023D297
	for <stable@vger.kernel.org>; Sun, 24 May 2026 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779638826; cv=none; b=kMbY4CGt6zFMVXN1XozA/zna5HlVOdD5pStcO/YLHd1uz4vkik3cpLpCYu6pjqk6ww4YVs9tQXI+viQaZtHFk/shcd6LVS9gX2YJtvyCQEpfKylcO5Uk0/Nrxws82ltDmcn6liTTvz38lJCdfBt8FaKbZ/jw51gzDfzMMVjhVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779638826; c=relaxed/simple;
	bh=oFecsmdHD5Cq5W5MDU8nNRtON2oDakO8PkdvCnvCWfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V++rQ9qYMJHmV5yF86c3hKIiZXpO/488mORSawaGF7hTIyxRKFYj0rn7bKzrepku+4J7uK1LvUOexarGyJTu4/+gxOJDPA1KdsPBQmpZIEJxc428TBGMFAB9kf0K6mZyCBgV2KkwjMtsEDWcchjU+k9u5RpcHNVVaihn6g0arLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBzNKn6R; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36936dcf19dso4310482a91.0
        for <stable@vger.kernel.org>; Sun, 24 May 2026 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779638824; x=1780243624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18MxIR0tdVmzmTTCjfqveL+dgh6nwJgg/2YQDWJQQr8=;
        b=LBzNKn6Rl+YurdChLp+7qoPPZUGzmmxtMB4CQsSnh7eM1jaafMZ94USmZDxs4JFEg7
         1wEkqusXooU7zIMRgsqr4VCbEi28VKNw9XqUuZh6MRFY8J6Cg24MhvtcvAZSe8QZcbaq
         ejGt34bV08cJG90EBssiNPqfrckxJcX2lBqKwryypTHWeyN/jcwWWZBe9cZHYPFIM6Vw
         +Oze503Rv1v1kSPDtHjppQnIJoBf7/PTOwG5I6/zBcRVils3t/TotaYGXRZ4qTr8HVve
         k8sYWESwOnKMbcRPOq9YKiqR949YXKFMT9NK41fubkkNJwPg+dfxgGMDcYbcDTVdLkHF
         aydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779638824; x=1780243624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18MxIR0tdVmzmTTCjfqveL+dgh6nwJgg/2YQDWJQQr8=;
        b=PSjC2DYkef1P0SJquAbLg5jMk7PLpChnusXF/CnXaVqrugyBVyN/ZxhvUXzF8AKS/q
         lW980Or7UBeEW8Zy+x8WBFdLR9yFJPFHL39taQLGddm9TSFHyZL/KYVJO/kVCj2tifO3
         NiZh0TIyPX/jk6b2TlOFf6kc2q9Mt/QhwsAHmFbjCh2lBM3Pmm4IFsNlBmSwWrxPP65a
         Zqd+aBq0yMcjwUHXOqvUrsfKVpH3z5NPiY4OpxNz/0tSO+SMAbbff9Vvq6wOWFh4dfvR
         f82kONLaa9cJ5tzooK5NBjT+dvcCRxP+0LzX6XnAPvhmVX53bOzCMN319hu9WCWD0NZ1
         vV2g==
X-Forwarded-Encrypted: i=1; AFNElJ/YZG5DRqNsJaBo5/Zw6ZLoTR7tRFrvXvjyVwRWtFQbUTVpOSj9nXNHpl6qq3Ri9xaG0riT7vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf0w4tmvgR16rYtiEYVfx+Px8rQMq1ON1kIiBXxNwY8vuhvq61
	33rbV2aoRgxY/9y+hGP24uUWMVCJBxl6Eflw7SDqD5mHf2X/eTahRJc=
X-Gm-Gg: Acq92OGBuPFVtkcXc92qyBCfm9GDb+YfffmdUBHGyAO1VOc1WQOikGuyux8OALzcgAm
	xy5joOb4PB8Kou/hn7SRWtDGKKU9o9NrFIuMEPwheF2NLSjwsQVxSf/AtgYRS7yOz581xxbHLJM
	LJRdCAEir386cyJgsgsdkUH+JtjYynSS0euw/VcCgHsZlHs1DufdXVUNSTMlpw+aDJEHfNxzeqF
	0+TIEbbacoelq+bPdU8BMhSVLY4P3EdZQseYmrmYFuxMs0L7L1fKKLZDCxljWewu81uXL186O9Z
	xdRjtAcGN23DGfJL1quklVAH2PO35ciK08//zWQUzrcL30jHwjm7fDEGI2/Bc0eUU5MMY5dwx4X
	B75NKl93dCsG/zERgl6F2WtsFs6I2XyGwlRaZqpxlUPJ73YnSQmE/culTHsgNaHU10zz0uIoodu
	KkjQ105D7piii1erW8TGtpq4No1BG6NrEqDH/GacCyHf2bSiWwMh4UlhRMPn+j1OQfceDk4Tc=
X-Received: by 2002:a17:90b:2585:b0:366:3ac:f730 with SMTP id 98e67ed59e1d1-36a6788e0abmr10212406a91.25.1779638824285;
        Sun, 24 May 2026 09:07:04 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36aa73da32dsm2082541a91.4.2026.05.24.09.07.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 09:07:03 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/meson: clean up KMS polling on register failure
Date: Mon, 25 May 2026 01:01:39 +0900
Message-ID: <20260524160657.17802-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,baylibre.com,googlemail.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-254043-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0AD615C3099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

meson_drv_bind_master() starts the KMS polling helper before registering
the DRM device. If drm_dev_register() fails, probe unwinds the IRQ and
DRM device without stopping the polling helper.

Call drm_kms_helper_poll_fini() on that failure path before freeing the
IRQ.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/meson/meson_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 49ff9f1f16..e49de5df73 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -352,12 +352,14 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
-		goto uninstall_irq;
+		goto uninstall_poll;
 
 	drm_client_setup(drm, NULL);
 
 	return 0;
 
+uninstall_poll:
+	drm_kms_helper_poll_fini(drm);
 uninstall_irq:
 	free_irq(priv->vsync_irq, drm);
 exit_afbcd:
-- 
2.47.1


