Return-Path: <stable+bounces-241763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL6LMqUG8WnhbwEAu9opvQ
	(envelope-from <stable+bounces-241763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 21:12:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAEF48B0DE
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 21:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A7230B6611
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146333921C6;
	Tue, 28 Apr 2026 19:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="aNrmgChc"
X-Original-To: stable@vger.kernel.org
Received: from forward206a.mail.yandex.net (forward206a.mail.yandex.net [178.154.239.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4F37C114;
	Tue, 28 Apr 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777403516; cv=none; b=EJfpOAVDYXKeQhSxhqF7jCx8bFzPdOz/wraG35+4rDg2HTyjP7sBpkZWcLWg3Yjl7qP8bx8HEj4Mp+SUMXhcWA9PPqQ2i6cHlOcT/y+FD6If2XTW5qrG5QSpfmqiDjAyQXr+ehA6+topfTaAJsxWpYjWk0PzjWVlvLDRqe1OTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777403516; c=relaxed/simple;
	bh=tzeN+5vQKmJfzBrB9+yS40yGju5ExPsoV+j0FcDO09o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MLzcQNR3TIMbXs7kpN5ZXTGYQw5zazi+34f4xH5LVh1/uBdsYMssjfnUZJWsvx3riE0/AkAYq8L8BjXUdsvyI4GTEHu/1Dh0waCaHdHhiUCDZ/0PYqIAqqN9N55974pl/BjhiqP9bhu1jp/XplFT3coYvZE4dTkJ7u7WGEgsGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=aNrmgChc; arc=none smtp.client-ip=178.154.239.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward206a.mail.yandex.net (Yandex) with ESMTPS id C9AB186B33;
	Tue, 28 Apr 2026 22:04:10 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:6281:0:640:c935:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 52E1F806AD;
	Tue, 28 Apr 2026 22:04:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp) with ESMTPSA id i3f98gObjmI0-kMIkEECX;
	Tue, 28 Apr 2026 22:04:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1777403041; bh=tr9ncHDLQsp/htwG5JIQTALMzIL3/WgOspiEBUJqEko=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=aNrmgChc8Uj4xd9AlRNV1rVyvXv1Hfj3u7RQtuXI6XNxd+/rZZ1L8vTcz1MPo4b+U
	 cvOBt3o6gp8fam6uxhWXtahexc2YMgVue1Rg4ewLQRSFlwO0MbiEHYuSHHTDfgkDJU
	 MmPzkwJv8XBbR0r9rUou8K1BsQfy0C9webtLwmG4=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon/rs780: prevent division by zero in refresh rate calculation
Date: Tue, 28 Apr 2026 22:03:18 +0300
Message-ID: <20260428190318.34413-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5DAEF48B0DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[yandex.ru,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-241763-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex.ru:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

drm_mode_vrefresh() may return zero when mode clock is zero even if
htotal and vtotal are non-zero. Current code checks only htotal and
vtotal, allowing refresh_rate to become zero and subsequently causing
division by zero in rs780_program_at().

Fix by adding mode clock validation and fallback to default 60Hz in
rs780_get_pm_mode_parameters(). Add WARN_ON in rs780_program_at() to
catch such cases during development, ensuring safe fallback in all
scenarios.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/gpu/drm/radeon/rs780_dpm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/rs780_dpm.c b/drivers/gpu/drm/radeon/rs780_dpm.c
index 64bb4cafb8b5..fe45b7dac9f4 100644
--- a/drivers/gpu/drm/radeon/rs780_dpm.c
+++ b/drivers/gpu/drm/radeon/rs780_dpm.c
@@ -65,6 +65,8 @@ static void rs780_get_pm_mode_parameters(struct radeon_device *rdev)
 			pi->crtc_id = radeon_crtc->crtc_id;
 			if (crtc->mode.htotal && crtc->mode.vtotal)
 				pi->refresh_rate = drm_mode_vrefresh(&crtc->mode);
+				if (pi->refresh_rate == 0)
+					pi->refresh_rate = 60;
 			break;
 		}
 	}
@@ -363,6 +365,8 @@ static void rs780_program_at(struct radeon_device *rdev)
 {
 	struct igp_power_info *pi = rs780_get_pi(rdev);
 
+	WARN_ON(pi->refresh_rate == 0);
+
 	WREG32(FVTHROT_TARGET_REG, 30000000 / pi->refresh_rate);
 	WREG32(FVTHROT_CB1, 1000000 * 5 / pi->refresh_rate);
 	WREG32(FVTHROT_CB2, 1000000 * 10 / pi->refresh_rate);
-- 
2.43.0


