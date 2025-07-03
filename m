Return-Path: <stable+bounces-159719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22208AF7A09
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83E117680C
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89762EE5EB;
	Thu,  3 Jul 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b="jZwTphvQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-gw02.astralinux.ru (mail-gw02.astralinux.ru [93.188.205.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE8101DE;
	Thu,  3 Jul 2025 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.188.205.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555123; cv=none; b=cydnUTmB+tCFEXxsumeGySRfNJCfkgjFe0GOGxbFaULhxEjuV6uZ9KPaOWur4c8xscnA5KLPyRBgtoksw0jGpkziqq9SYFdyiMcxwMugUDpE/ZSjfJGKq4f9aj7ht1/QAB1EcciMqrL8sqwvYm+yb4AZdwZEGp/KolMGT8xZN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555123; c=relaxed/simple;
	bh=21nH79OEA5YuSUMPqX+Yz8pUzt3vDT+TpG6pnD/y1iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xq6A/3Giv7PKTGXQIXuvg+bc7uym9cxljHMKKHXzXnpGCviygvQPbNUNKM3Fpb0pyeO1deTa9RXh3jj+2SefdYU80LcXek+TIDXJbec52JjOEO69Uh5Q6wgIWkPNMmNQNGeldMtKrJazm75o+Qkc7Ny7vp+NObnSqYkHphOwiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=jZwTphvQ; arc=none smtp.client-ip=93.188.205.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1751555111;
	bh=21nH79OEA5YuSUMPqX+Yz8pUzt3vDT+TpG6pnD/y1iQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jZwTphvQVlkYlwkXC/eUOiUmQtHlprBcWXnpLA2RQYPEr/uwnHiCXWA3M5ta1Jep7
	 tAANUWaNtI+1DtBrE62jiQ4PqFntITkRbUmvOmrkdA0OQdbKRHTWcIU3dxcMii2Dw6
	 peqlLUDst2zmXlg+igFteAXOXfQyBk+TGxG6NNeecaqPwzIlvFRiK8fUt4jC8dhQiD
	 jvZji+GHwoLNwGVVjLXq4hMdBTldloSl+kbRNneKOU5FcntUH3nBiF3POtt8dgxc0H
	 AzpTNOpP/IAEBP+2PWPWIPHIk2hJSqx/OPOmJO/tIWIcTiMbTEewMQZE6kdNWypjJy
	 RFxHdDQ1untIg==
Received: from gca-msk-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw02.astralinux.ru (Postfix) with ESMTP id 5A8C91FA52;
	Thu,  3 Jul 2025 18:05:11 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.177.185.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw02.astralinux.ru (Postfix) with ESMTPS;
	Thu,  3 Jul 2025 18:05:07 +0300 (MSK)
Received: from localhost.localdomain (unknown [10.198.59.101])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4bY0RP4nGqz16Hny;
	Thu,  3 Jul 2025 18:04:33 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anastasia Belova <abelova@astralinux.ru>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@linux.ie>,
	Daniel Vetter <daniel@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Anand K Mistry <amistry@google.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 5.10] drm/prime: Fix use after free in mmap with drm_gem_ttm_mmap
Date: Thu,  3 Jul 2025 18:04:24 +0300
Message-ID: <20250703150425.31556-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2025/07/03 14:02:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: abelova@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 63 0.3.63 9cc2b4b18bf16653fda093d2c494e542ac094a39, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, patchwork.freedesktop.org:7.1.1;astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 194539 [Jul 03 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2025/07/03 12:05:00 #27614572
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2025/07/03 14:02:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Anand K Mistry <amistry@google.com>

commit 8244a3bc27b3efd057da154b8d7e414670d5044f upstream.

drm_gem_ttm_mmap() drops a reference to the gem object on success. If
the gem object's refcount == 1 on entry to drm_gem_prime_mmap(), that
drop will free the gem object, and the subsequent drm_gem_object_get()
will be a UAF. Fix by grabbing a reference before calling the mmap
helper.

This issue was forseen when the reference dropping was adding in
commit 9786b65bc61ac ("drm/ttm: fix mmap refcounting"):
  "For that to work properly the drm_gem_object_get() call in
  drm_gem_ttm_mmap() must be moved so it happens before calling
  obj->funcs->mmap(), otherwise the gem refcount would go down
  to zero."

Signed-off-by: Anand K Mistry <amistry@google.com>
Fixes: 9786b65bc61a ("drm/ttm: fix mmap refcounting")
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v5.5+
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20210930085932.1.I8043d61cc238e0168e2f4ca5f4783223434aa587@changeid
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
Backport fix for CVE-2021-47200
 drivers/gpu/drm/drm_prime.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index 825499ea3ff5..893421d81e1e 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -724,11 +724,13 @@ int drm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 	vma->vm_pgoff += drm_vma_node_start(&obj->vma_node);
 
 	if (obj->funcs && obj->funcs->mmap) {
+		drm_gem_object_get(obj);
 		ret = obj->funcs->mmap(obj, vma);
-		if (ret)
+		if (ret) {
+			drm_gem_object_put(obj);
 			return ret;
+		}
 		vma->vm_private_data = obj;
-		drm_gem_object_get(obj);
 		return 0;
 	}
 
-- 
2.43.0


