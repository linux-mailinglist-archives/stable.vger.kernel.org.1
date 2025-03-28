Return-Path: <stable+bounces-126920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34252A74638
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 10:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81E817BDE1
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9417212FB1;
	Fri, 28 Mar 2025 09:21:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DF820E003
	for <stable@vger.kernel.org>; Fri, 28 Mar 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743153716; cv=none; b=YKb6tqQYNLePKDDQ8Nq/tvhrqQd/F1oncXaLf620DrljkTvVECIstXa+fkbNbPVK58m0GX704eXdLQZs2MZV6mmQZTy3R12DTK4ArwuQ9qNY5joJTo7nDiUVnN/h3qA56aWgg9rFoHGC5UPfjoXj8VZdJ+npRE+TfO+IyTDZZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743153716; c=relaxed/simple;
	bh=+c3KWfMyOeKG4hTsfgZ2z7P4nJ8D0MVbUnSd4ytyLrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea6mCrDz5xYn5pizWxRJxJKM5e9rwqAStSdanrfvmlo37R3VTsTk0ZK/68n5uM6tjiCtqypNAwNihfhOxv5BPBta33Du8TffhjFftkl/CaDuL6uQ27H+5KkBguFY2QxHCHq/WRNHhLTmjIhiNBSIuKnkshkEqwkgWED6GQtCnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEDCB1F394;
	Fri, 28 Mar 2025 09:21:52 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81A7313A52;
	Fri, 28 Mar 2025 09:21:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yKNIHjBq5mciEwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 28 Mar 2025 09:21:52 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	airlied@redhat.com
Cc: virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Adam Jackson <ajax@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] drm/cirrus-qemu: Fix pitch programming
Date: Fri, 28 Mar 2025 10:17:05 +0100
Message-ID: <20250328091821.195061-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250328091821.195061-1-tzimmermann@suse.de>
References: <20250328091821.195061-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BEDCB1F394
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Do not set CR1B[6] when programming the pitch. The bit effects VGA
text mode and is not interpreted by qemu. [1] It has no affect on
the scanline pitch.

The scanline bit that is set into CR1B[6] belongs into CR13[7], which
the driver sets up correctly.

This bug goes back to the driver's initial commit.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Link: https://gitlab.com/qemu-project/qemu/-/blob/stable-9.2/hw/display/cirrus_vga.c?ref_type=heads#L1112 # 1
Fixes: f9aa76a85248 ("drm/kms: driver for virtual cirrus under qemu")
Cc: Adam Jackson <ajax@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v3.5+
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 52ec1e4ea9e51..a00d3b7ded6c5 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -318,7 +318,6 @@ static void cirrus_pitch_set(struct cirrus_device *cirrus, unsigned int pitch)
 	/* Enable extended blanking and pitch bits, and enable full memory */
 	cr1b = 0x22;
 	cr1b |= (pitch >> 7) & 0x10;
-	cr1b |= (pitch >> 6) & 0x40;
 	wreg_crt(cirrus, 0x1b, cr1b);
 
 	cirrus_set_start_address(cirrus, 0);
-- 
2.48.1


