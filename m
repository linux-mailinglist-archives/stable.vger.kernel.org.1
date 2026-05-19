Return-Path: <stable+bounces-249501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FDfFh8xDGpuZAUAu9opvQ
	(envelope-from <stable+bounces-249501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:45:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 729AB57B892
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 425783020E1F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 09:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE773F5BFA;
	Tue, 19 May 2026 09:24:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7D3F54D0;
	Tue, 19 May 2026 09:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182685; cv=none; b=c6RbQ36375nVtpszLs7ztE0GE9d03rkqFTtlBZ5QrLfsdnHX8WDyxfmsORCEtpQ1CPNFT1jfeUEGXRLs8V8DtYctgvYQTDQ5Omx5xDEy0oo9/Vb2IMh/urm5YPXHh9PELw+0xndiqCsYMvppLk0acPm3sbst/M2ev55b7KHtCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182685; c=relaxed/simple;
	bh=JJ1/equMYm7nVfvvibccLA9XJV+g6SrPVvB04YdTxqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6WEpjV7lT9rRUuJxrAWj9oOYi/DFF0SynTNNQtuGy1NwRARrbonIw1gpuVo3YdlivITLJDebfJffc+iWGyJvIFJKgm6vp8WbmQKhnmU80Y4rtHMRAxmsiDtBGgZjF2nXiXaR9XT5ukXF+bUX7KVAvezhML7m/vpmdWlSUqx+mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
	by APP-01 (Coremail) with SMTP id qwCowAAnzGdFLAxqTtTAEA--.55S2;
	Tue, 19 May 2026 17:24:22 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/client: check whether CRTC is active before waiting for vblank
Date: Tue, 19 May 2026 17:24:20 +0800
Message-ID: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnzGdFLAxqTtTAEA--.55S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1rXry3JFWkCw4rXFyfXrb_yoW8ur17pF
	43GryYyFWktFZxKanrZa4xZF1FgayrJFWxGry7Kwnxu3Z0vwnFyryFyr9FgFW7Jr9xXay7
	Xr4UtFy5uF1UCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,ravnborg.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249501-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhengxingda@iscas.ac.cn,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 729AB57B892
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the implementaion of drm_client_modeset_wait_for_vblank()
assumes drm_vblank_get() will fail when the CRTC isn't active. However
it seems that this is not true, and running fbcon on a device with the
first CRTC inactive will lead to kernel warning in some cases (which
could be reproduced with the loongson driver).

Change the implementation to add a check for the active state (atomic) /
enabled state (non-atomic) before calling drm_vblank_get(). As the
assumption of drm_vblank_get() failing for inactive CRTC isn't met, the
error status of drm_vblank_get() can now be exported too.

Cc: stable@vger.kernel.org
Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with vblank")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index bb49b8361271a..1b03bf351256e 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
 {
 	struct drm_device *dev = client->dev;
 	struct drm_crtc *crtc;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Rate-limit update frequency to vblank. If there's a DRM master
@@ -1326,15 +1326,24 @@ int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigned i
 	 * Only wait for a vblank event if the CRTC is enabled, otherwise
 	 * just don't do anything, not even report an error.
 	 */
+	if (drm_drv_uses_atomic_modeset(dev)) {
+		if (!crtc->state || !crtc->state->active)
+			goto out;
+	} else {
+		if (!crtc->enabled)
+			goto out;
+	}
+
 	ret = drm_crtc_vblank_get(crtc);
 	if (!ret) {
 		drm_crtc_wait_one_vblank(crtc);
 		drm_crtc_vblank_put(crtc);
 	}
 
+out:
 	drm_master_internal_release(dev);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);
 
-- 
2.52.0


