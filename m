Return-Path: <stable+bounces-245398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDUEOAnMAmo+wwEAu9opvQ
	(envelope-from <stable+bounces-245398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:43:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC8351B2F3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3716C307BCD8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 06:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F4E4DD6DC;
	Tue, 12 May 2026 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8Q3x8gf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4431361DA7
	for <stable@vger.kernel.org>; Tue, 12 May 2026 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567834; cv=none; b=b2fEW7l9DJVKE8JaIVWozPi1/xc+nUF4p6QNANW8v07sZVmDDf0ZyokhaO8dpkeGV7p9ZYDECZQn3I2v053NYSofxkEOulKFmEuA3ykFtXhaBY2ZcAvF69xIFnOmV/+Q2vKHW5g8Gz0o81hTf6OEY51XKWP0SaWIeU3eAEVmb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567834; c=relaxed/simple;
	bh=RQ7+iXrY7i1K+ENsdW2g5Fgz71dWa89XrsybQogv9vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2IP31NO6EgM1MNxiE2J5lkftE/jWPCELfFriJebklX+2CBemYRgTo8KD0dxtbJ7hbLTQV53CkHtU/I/QgMLwTVYHCl1HgZDXA2+XkFE182bbbsrArIu+jO5BgIPqDdAVTBlL5vT4VwJ6cv3oLZ0fyOqaEHzWRWpP9uigbkqozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8Q3x8gf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8367df48711so2361568b3a.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 23:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778567823; x=1779172623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/Io3R6L2sxqqwxZ2xN7qSJG+cD+zBc4qCZ/FGPLMyU=;
        b=X8Q3x8gfhTDjyBCKRl8adypy87EY2S5T1iQ+53nMBFhOJ+P9+8ZwrPkqUwgVA+7HZ6
         1+7GnxLUEe26l3a3L8SdEYsm5g9B7f2jRHcngj2DWXDNdFZJ7AHYv1OdqzyPsNd5/2d6
         l9rThW/LKjfsAYnLyi7bmBoFp+WQt4mqXupkiGcH19qH1TDEPLHP7OKqXOZJ1YO2U3cJ
         5OqENAsHyks/fVB4sMc55j8u7OsNhRH6sUBbtBesu6+LCBJb/h/oDY5gbNwOqnJnSR7B
         u28N3xBLMYztNYb4OyIKP8O/E6SH+X+1EYmC3TZKlfzOrtKGI7Z/dNtAmviLsqCfJlr9
         i+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778567823; x=1779172623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/Io3R6L2sxqqwxZ2xN7qSJG+cD+zBc4qCZ/FGPLMyU=;
        b=ozUmvT5px30OzT/ZsHDJUI8B/Rba7M+ozk181N3nKXjvW7kKBt6cQxfz+tUa9NbMae
         lPBVIcp6Yi/5KKiJZbNbiAYOVEKCDVU+3qu5GQUHvm9uX1XKLDxpKOUgurSIM87hbKbg
         MdfBqFd9rHTezioA30ELuZtIAhO/KhsRRtDLwBDh8ngeHJk0C64xsvlOkgdRGhiFAepv
         q3FR1IOPF29UzVii3eDilNA+GG3ieg1XBimTAAU6XPqz9xL2th/faNfm6itvalf8k0Vl
         VGouuoH4bpIe8mO9THcGEZ9rJX9ugN00BYIkd1Gp+eZJ4cFXPZvFx01wsaHax56Vxdr1
         x16w==
X-Forwarded-Encrypted: i=1; AFNElJ97MprwxtMKrGmiPLyLziEwBOrhkpByTRbQQR0xbZrlHhG/iU4fFE0QbHm6ZyH2h1iwTVAd4II=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIJtubVeJi7WRCN/qk7hT9F0kllRF9hQBL6iTQH4tmDs4JNXN
	WLzMBvK6unqeAtmKR0vuacONa21jjKrdwmsI9Cx0iBLycSoD3P+YT5c=
X-Gm-Gg: Acq92OF2pvskKozearDjlSQETQ1D3TGP39e2EQabxpAxKHInFhbnZ4aijtYfj6zVt5a
	Qewpoc8H1kDj4Y/vbL4SiOj6uL+mTnBsS8JK/4vPMycrf8c8N+hguDIfMkehMEQ7nWcJgUTobP5
	Y23WvlabEhwDGkcBA2a9KVOyaR9NBtBSKzXfVIyXpqOVdZrRj+6ezzuSKcc+5E20htQCjGdWh7E
	hW3PZoVvZlYGI75R+r2BPIWVtzR6W8GgSMbkoYYf2aahhae2JmZZVwuF38URvM0OflT/lN/Lq4n
	uOwACR6K9eXQMQ/6oD4VOFyW4vHYRnBwDAS9W4FubTJ2hjtr2Tdxd2R49/HRJgDOBE6/6ZRCcAE
	76hMTj36qEHUV+vtSH4VjcqEwK31QgU43+XzUecOjsErshfyvX8pq9sXd0B+DHQEiVvxlWYdsJq
	+aSDI/yN8agaufv6Jni2Kj9kwBwOln1iR6vaRsW7yaCAqNBa/4NbEG2353QIk6fW+HLsJyzLy8w
	Q==
X-Received: by 2002:a05:6a00:429a:b0:838:c01a:7a50 with SMTP id d2e1a72fcca58-83eebc24f3bmr1610402b3a.30.1778567822961;
        Mon, 11 May 2026 23:37:02 -0700 (PDT)
Received: from localhost.localdomain ([211.198.234.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf7d2sm29996163b3a.49.2026.05.11.23.36.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 23:37:02 -0700 (PDT)
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
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] drm/loongson: use managed KMS polling
Date: Tue, 12 May 2026 15:36:51 +0900
Message-ID: <20260512063657.53100-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3AC8351B2F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,iscas.ac.cn,suse.de,loongson.cn,kernel.org,aosc.io,xry111.site,linux.intel.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245398-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
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
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
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


