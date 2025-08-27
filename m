Return-Path: <stable+bounces-176513-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF0BB3866F
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 17:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E861C21006
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 15:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B2278143;
	Wed, 27 Aug 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="EcscZGRo"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DBE14F9FB;
	Wed, 27 Aug 2025 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308082; cv=none; b=ubCvKkgDDGPvW+d89sufFz1WCz52IAOR1oyMmHAxsmZgNyO7tRQSaPCb4RN8iDpINUKKmRZpVXNwZjMMCnwipuC5ZdEu2D2u3hgKMYCKukpv9IkkgB4v+DF3FU+Cay5qXWzlNVyIardSF8vIONk6aySmG+usrJgPRweVbtxskTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308082; c=relaxed/simple;
	bh=9WL9h4EBmvUK8XGVE7GWN3wkJwzRORrd+h0CmUVwyEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZUgRUz5jgRQxChLPzABZc5dz6zQvxoP8h1mHQ+hIYXjVKkAw3PNejxuYpwZR8rGDSq8CACj63PhD8DNWX7BBd+7wgb33lgRwqy6oRWXwgsAquepvc1IIHHvy2znYVww4EMtvCFjgtPS2ymw+CgqsuE12DEA5picfR7uaUBL5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=EcscZGRo; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9A701406C3E1;
	Wed, 27 Aug 2025 15:21:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9A701406C3E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756308078;
	bh=02QJmS1dDrR4T+qTKViGS18HgwiGbUD6zmXE+BBvH9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcscZGRoCXK2oeKOxF7rUusSMur019GncOpUWsY+SCDR3yuOVgPcWve761DlQ7m9k
	 +duxIVCwNsr1RNBmwoGYGG2PJgvoJQY8JtvZ7GFSWIeuqu68gtEXAckd+NbQJ9WH0M
	 acVwhFuqk8GU9y4DLIKXXmRcO6/gI5AL4UvhinvI=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alex Deucher <alexander.deucher@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Harry Wentland <harry.wentland@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Hans de Goede <hansg@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] drm/amd/display: fix leak of probed modes
Date: Wed, 27 Aug 2025 18:21:05 +0300
Message-ID: <20250827152107.785477-3-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827152107.785477-1-pchelkin@ispras.ru>
References: <20250827152107.785477-1-pchelkin@ispras.ru>
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

v3: drop INIT_LIST_HEAD and use drm_edid_connector_update() (Melissa Wen)
v2: use exported drm_mode_remove() (Mario Limonciello)

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a0ca3b2c6bd8..12685966186b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8230,10 +8230,14 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
 			to_amdgpu_dm_connector(connector);
+	struct drm_display_mode *mode, *t;
 
 	if (drm_edid) {
 		/* empty probed_modes */
-		INIT_LIST_HEAD(&connector->probed_modes);
+		list_for_each_entry_safe(mode, t, &connector->probed_modes, head)
+			drm_mode_remove(connector, mode);
+
+		drm_edid_connector_update(connector, drm_edid);
 		amdgpu_dm_connector->num_modes =
 				drm_edid_connector_add_modes(connector);
 
-- 
2.50.1


