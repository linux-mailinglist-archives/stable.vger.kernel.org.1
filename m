Return-Path: <stable+bounces-245402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEUUHsfOAmq7xAEAu9opvQ
	(envelope-from <stable+bounces-245402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:55:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0A651B576
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 08:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2237930066BB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 06:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B823357CE4;
	Tue, 12 May 2026 06:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+MqsNWl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2B42F6596
	for <stable@vger.kernel.org>; Tue, 12 May 2026 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778568894; cv=none; b=Wq9mzo24hZRRiHpNKDQbm1PTBhvnD8gpkWuIVtHfiW+VBse0vjqeFPhOgpyooq25aABzjuVCK2N4MtoRE/rPCHKhZNiNuuYt5PEBpnGlIqVzRCnOOYJO6SAh026x2PpJMpc3orE7ST7Hfb3CZogPx79x5h93/wpTxjhnWaDCX+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778568894; c=relaxed/simple;
	bh=RQ7+iXrY7i1K+ENsdW2g5Fgz71dWa89XrsybQogv9vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ovv9PQO3wicNExL8j5MlQ1bn0NvttGKjsMIlsgrOtbrLguDL98cc11M2dbUN1NRBgj2wmnyCzJ9pEBSnO2ZW7c7zWLfrlWQQI04LRfjzu2L+ZA/poLn2LBZmJc/aJ4cXJTS78NXQ8BgBrahd0C5yoAkbDEtTuWtQmszyhP0Qcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+MqsNWl; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so2213862b3a.2
        for <stable@vger.kernel.org>; Mon, 11 May 2026 23:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778568883; x=1779173683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/Io3R6L2sxqqwxZ2xN7qSJG+cD+zBc4qCZ/FGPLMyU=;
        b=P+MqsNWlwS7ahnh6h1NFUF7s+r4dSN7igoC5tLiLAFQMs0Tb9IuBfTPQ66StgqXNHY
         nKdtFVBOLJmhay+108ngz0ZSKG2x/kgQXhCyMjJyGMd92MPZKM9rZ0ShMM7SUOZlsEqg
         fN4ZEe7NV1jMMJ2edBS4lva8F1jvXIxcexdNbNUPj3PXFRYbbKNP+SIqKCX4umwFjarW
         hFtHEFXLion6SakZTq6qIR4D15ImJIWxqcOdyEc6NwU36uhHYtRsx+iji8BHoOuf0LOC
         RlrodkjlmnJsnpke94kFdeoGIZ6M0s0nyaGAkJgcS7a0uzvkZfd2ZE1yTN4bZBPC7HgN
         dTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778568883; x=1779173683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/Io3R6L2sxqqwxZ2xN7qSJG+cD+zBc4qCZ/FGPLMyU=;
        b=Ky447rKfxKfcp2I+2cdeYLZxPDoaccYxNupuAQmcGgLysKYU3bsZz49Wa1N1ya1NX8
         iSAta02CtM7z0ltZq8rGW8iowAZu0GtkHMEXsL3ofqPtXTxYPsi6pW8H2cdnUWp+TgqV
         Tc3Q2vhSAjFg3CkR7y1/hWQlWH8vT9DuWXEhoSjCFx4B6P53KAEV2IuyFma8TUJkSTg7
         X15Fqg6rG0AeaeoyQycrLJrmmOfuOsIZuxauMKrW34vUreFVTtz4lo48qVh894pSXEl/
         5ERJ6pYA4oaS7DeJU7tMytaet82W512OJ0hBWSmYluf1c4VEpBs5eP6SXkfA2caFcVuF
         72Lw==
X-Forwarded-Encrypted: i=1; AFNElJ8ggQXJwdHyrJZ3skHHk0ZjbUCggCpxy2/bWWTMsu313wrUBlWbiexd74EZlVVcTc+LgHlLn7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJ3N8ptuyUyxRlFc09fB7PtHA6i3NswLs2+4OdaR9XRy+Dd9o
	uaCo4iZm5In7jJWAALbxsxchuPqeHmSoLhrm7Bo+eSwrDNELqjscVuo=
X-Gm-Gg: Acq92OFNOKgYMqbTNbd3lsB4gKWnRdri1QjmLHIwq+p8Egt4msxGzpZpsBbL9bONXZa
	7nPR0ruoDew6CPRx2Q4Tz++466q79Qj/gGIzSVWoIa2NJO7XS0jcOrZjjfR07BnilnnV4sZ2WvI
	q8olmew+qbPkfhgTYaK34DY3LcA8AoEoZ8suKhLkKx2uxwBdRkJlUY+oJwUr15t8cil+fwYF7ru
	o+uY3hVw6iFGcSp1pMrw3uDYkzRPtNcKTD5+y3NjlbOUwt3sgwCT2YHRVm3VFjVpxACizvyOTTg
	vBoUW4ELCoyDWwZZMx4S7Koas0fkPjYjxWZK9OQNgQ9dnVFPEcAM7jL1EIkty3o3bCLfZhPJAFN
	AHaJCMxSJ5f4ttWYby8QrMqKvx4zUuUujqEg3OiqnGOr91/vXWmHz1b81SY11SPTkZX+oMvVNBx
	udPuj2hUqIz/kHQWfgzclDE+RDmzxhG/grToGjjMRDjSoWqSopwll10iBETNuLhxio6a2eroi7N
	uJqWmwUrCtE
X-Received: by 2002:aa7:88d6:0:b0:837:e9cc:d470 with SMTP id d2e1a72fcca58-83eebb5004dmr1861920b3a.20.1778568882988;
        Mon, 11 May 2026 23:54:42 -0700 (PDT)
Received: from localhost.localdomain ([211.198.234.66])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965646254sm23272580b3a.10.2026.05.11.23.54.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 May 2026 23:54:42 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tobias Klauser <tklauser@distanz.ch>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	dri-devel@lists.freedesktop.org
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
Date: Tue, 12 May 2026 15:53:31 +0900
Message-ID: <20260512065436.74729-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3E0A651B576
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,iscas.ac.cn,suse.de,loongson.cn,kernel.org,aosc.io,xry111.site,linux.intel.com,ffwll.ch,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-245402-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
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


