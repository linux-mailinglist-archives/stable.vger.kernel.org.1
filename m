Return-Path: <stable+bounces-169878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948C4B29280
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 11:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6C91897CFA
	for <lists+stable@lfdr.de>; Sun, 17 Aug 2025 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E57C224AEF;
	Sun, 17 Aug 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="C0mWIhP/"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BBB78F4A;
	Sun, 17 Aug 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423851; cv=none; b=oepkJr/Z9gGcPC8gwuWfbVApV45yfOgYl9YVn7usElZYOtTuwGha+w1EhispvDLH5Aa+pDfErlreMisDiDmugp3AK/sG08MSiknIrFK56/MzqgInXcZ4XdSM1zk3SOke1XD1biYr9YWcU/rY6G9TdhsqvQ5OO+aNFHctc1AFUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423851; c=relaxed/simple;
	bh=0ZzXwhSUp+yKdjkZXPF2ybtpvaBidhUS/vfB5zvwtO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FLK5S+l/vi6GAQpvOg5ZpqIFeEWv+4yPgkTKuLAkac4SSzQq1hwxyGNchm4UNdZFIQENgDd+mG7ERjBUzpgzXddhyHsOqH4PNGYO1sRCy0UkUuWTELya6ISpifDgwAdHhO0S2lZVkjr1j/nIS/ApI7rLJejU5ny6dP2WC/YcJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=C0mWIhP/; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 11A674015902;
	Sun, 17 Aug 2025 09:43:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 11A674015902
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1755423839;
	bh=q3j929XTS7MHtT8FjC0KMj3QSOP2XSJZz7av2UMajwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=C0mWIhP/70USttf3raA1CkYxuoNg+tNvAUoamBcX7XTvMVAO7ku9I0sZCIGKO3hoP
	 PoW6QMJxiSE/zDgkTc8UKZMNUyRf1ByJ0+zmeF9G8NlXoZmH+8Jum2tdV4qYfiwFaa
	 Ae5z3xJIjlQsSBned2eEbCGhPeKzKBfVg28rqbfY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alex Deucher <alexander.deucher@amd.com>,
	Melissa Wen <mwen@igalia.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Harry Wentland <harry.wentland@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix leak of probed modes
Date: Sun, 17 Aug 2025 12:43:45 +0300
Message-ID: <20250817094346.15740-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amdgpu_dm_connector_ddc_get_modes() reinitializes a connector's probed
modes list without cleaning it up. First time it is called during the
driver's initialization phase, then via drm_mode_getconnector() ioctl.
The leaks observed with Kmemleak are as following:

unreferenced object 0xffff88812f91b200 (size 128):
  comm "(udev-worker)", pid 388, jiffies 4294695475
  hex dump (first 32 bytes):
    ac dd 07 00 80 02 70 0b 90 0b e0 0b 00 00 e0 01  ......p.........
    0b 07 10 07 5c 07 00 00 0a 00 00 00 00 00 00 00  ....\...........
  backtrace (crc 89db554f):
    __kmalloc_cache_noprof+0x3a3/0x490
    drm_mode_duplicate+0x8e/0x2b0
    amdgpu_dm_create_common_mode+0x40/0x150 [amdgpu]
    amdgpu_dm_connector_add_common_modes+0x336/0x488 [amdgpu]
    amdgpu_dm_connector_get_modes+0x428/0x8a0 [amdgpu]
    amdgpu_dm_initialize_drm_device+0x1389/0x17b4 [amdgpu]
    amdgpu_dm_init.cold+0x157b/0x1a1e [amdgpu]
    dm_hw_init+0x3f/0x110 [amdgpu]
    amdgpu_device_ip_init+0xcf4/0x1180 [amdgpu]
    amdgpu_device_init.cold+0xb84/0x1863 [amdgpu]
    amdgpu_driver_load_kms+0x15/0x90 [amdgpu]
    amdgpu_pci_probe+0x391/0xce0 [amdgpu]
    local_pci_probe+0xd9/0x190
    pci_call_probe+0x183/0x540
    pci_device_probe+0x171/0x2c0
    really_probe+0x1e1/0x890

Found by Linux Verification Center (linuxtesting.org).

Fixes: acc96ae0d127 ("drm/amd/display: set panel orientation before drm_dev_register")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

I can't reproduce the issue before the commit in Fixes which placed that
extra amdgpu_dm_connector_get_modes() call. Though the reinitializing part

	/* empty probed_modes */
	INIT_LIST_HEAD(&connector->probed_modes);

was added years before and it looks OK since drm_connector_list_update()
should shake the list in between drm_mode_getconnector() ioctl calls.


For what the patch does there exists a drm_mode_remove() helper but it's
static at drivers/gpu/drm/drm_connector.c and requires to be exported
first. This probably looks like a subject for an independent for-next
patch, if needed.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cd0e2976e268..4b84f944f066 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8227,9 +8227,14 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 			to_amdgpu_dm_connector(connector);
+	struct drm_display_mode *mode, *t;
 
 	if (drm_edid) {
 		/* empty probed_modes */
+		list_for_each_entry_safe(mode, t, &connector->probed_modes, head) {
+			list_del(&mode->head);
+			drm_mode_destroy(connector->dev, mode);
+		}
 		INIT_LIST_HEAD(&connector->probed_modes);
 		amdgpu_dm_connector->num_modes =
 				drm_edid_connector_add_modes(connector);
-- 
2.50.1


