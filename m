Return-Path: <stable+bounces-273935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AcWdD6MoVWqokgAAu9opvQ
	(envelope-from <stable+bounces-273935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:04:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A84C74E471
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:04:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=astralinux.ru header.s=mail header.b=ZstIlkRU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273935-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273935-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=astralinux.ru;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10EEB306AEB9
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 18:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A548B34D3B0;
	Mon, 13 Jul 2026 18:02:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417BE33E36A;
	Mon, 13 Jul 2026 18:02:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965732; cv=none; b=tjqGQRuNtJx+KSjWPlXMBXo4kZ5y51gbYxeaWaTbYyZjuJWq5+9f/MICUsthA7qWxZ0XESlh6BjGT8+EsoBQtEitTDN55R93nUDIpZgTNtJGr8xVenoe5kuJdMoBwFYIDjqaXjLT0taUEmV0uVsgxvmvwjMHqBs8LpYaj4t1GKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965732; c=relaxed/simple;
	bh=qTFbrJO1EIURj5coHE7P8jfs+T3R57WvmR8hoGJitbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a3FAbyroIjTV6TLo5a8NMwfDl8T9+Xz4zKhYGNszS03/Ms11eaTUItBclq7pkhHxUIi321OJ7lPH8YWxxPVy41lTB88YuM1tBPlgWD7MykL75fQtjdB733cKAx7xh27uF41RyXOAjKmNncWMQaIU68YWTR6En8dexuVkHcYI+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru; spf=pass smtp.mailfrom=astralinux.ru; dkim=pass (2048-bit key) header.d=astralinux.ru header.i=@astralinux.ru header.b=ZstIlkRU; arc=none smtp.client-ip=37.230.196.243
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1783965174;
	bh=qTFbrJO1EIURj5coHE7P8jfs+T3R57WvmR8hoGJitbA=;
	h=From:To:Cc:Subject:Date:From;
	b=ZstIlkRUUKnGElVKoX+VXKqW/ZCcdaYL9K0C8NptQI04CCWLg6skHvRWVwN4hvVxw
	 AtXlTUkZjwuPyrLHyraOorUqq5fARQKq/PnNvJt9zSsZK2M+/aXVEVPJ0XoK6BGmut
	 fbx4LSUyDm1xYXVuiOwgrtbR+3RM9zt10s92N8R12vO9qGClVWHBk9uepx9ePWDhaF
	 alyGrQOA8GiThkO9E8ejQqkrAiSU9wKy6C1QuicS/Okg682M3/HKtz3Dr9MUIHofQm
	 tDbUAzMe3NvxBo+RJH3Vyn8SiCy/Hx9Y4GYahgQCrGeNCJAKXnBvqsQm8bQh0iqnBn
	 k+LoE3rhl85Mw==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 934B425596;
	Mon, 13 Jul 2026 20:52:54 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon, 13 Jul 2026 20:52:50 +0300 (MSK)
Received: from rbta-spb-lt-115149.astralinux.ru (rbta-spb-lt-115149.astralinux.ru [10.198.24.8])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4gzVQT3vP9z4lNf;
	Mon, 13 Jul 2026 20:52:49 +0300 (MSK)
From: Elizaveta Tereshkina <etereshkina@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Elizaveta Tereshkina <etereshkina@astralinux.ru>,
	Chen-Yu Tsai <wens@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 5.10/5.15] drm/sun4i: backend: fix error pointer dereference
Date: Mon, 13 Jul 2026 20:52:37 +0300
Message-Id: <20260713175238.715526-1-etereshkina@astralinux.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected, bases: 2026/07/13 17:19:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: etereshkina@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 112 0.3.112 7c8d497b0e572fbfa504a2ee62037c045a8cb4ec, {Tracking_ml_letters}, {Tracking_one_susp_tld}, {Tracking_uf_ne_domains}, {Tracking_internal2}, {Tracking_from_domain_doesnt_match_to}, patch.msgid.link:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 204404 [Jul 13 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/07/13 15:36:00 #28439953
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected, bases: 2026/07/13 17:19:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[astralinux.ru,quarantine];
	R_DKIM_ALLOW(-0.20)[astralinux.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[astralinux.ru,kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,sholland.org,linaro.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev,vger.kernel.org,linuxtesting.org];
	TAGGED_FROM(0.00)[bounces-273935-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:etereshkina@astralinux.ru,m:wens@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:neil.armstrong@linaro.org,m:dri-devel@lists.freedesktop.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:ethantidmore06@gmail.com,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[etereshkina@astralinux.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[etereshkina@astralinux.ru,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[astralinux.ru:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A84C74E471

From: Ethan Tidmore <ethantidmore06@gmail.com>

commit 06277983eca4a31d3c2114fa33d99a6e82484b11 upstream.

The function drm_atomic_get_plane_state() can return an error pointer
and is not checked for it. Add error pointer check.

Detected by Smatch:
drivers/gpu/drm/sun4i/sun4i_backend.c:496 sun4i_backend_atomic_check() error:
'plane_state' dereferencing possible ERR_PTR()

Fixes: 96180dde23b79 ("drm/sun4i: backend: Add a custom atomic_check for the frontend")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Link: https://patch.msgid.link/20260217014801.60760-1-ethantidmore06@gmail.com
Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
---
Backport fix for CVE-2026-53066
 drivers/gpu/drm/sun4i/sun4i_backend.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index d935f36a24dd..b3741827c6c3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -507,6 +507,9 @@ static int sun4i_backend_atomic_check(struct sunxi_engine *engine,
 	drm_for_each_plane_mask(plane, drm, crtc_state->plane_mask) {
 		struct drm_plane_state *plane_state =
 			drm_atomic_get_plane_state(state, plane);
+		if (IS_ERR(plane_state))
+			return PTR_ERR(plane_state);
+
 		struct sun4i_layer_state *layer_state =
 			state_to_sun4i_layer_state(plane_state);
 		struct drm_framebuffer *fb = plane_state->fb;
-- 
2.39.2


