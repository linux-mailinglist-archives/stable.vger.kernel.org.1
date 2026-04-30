Return-Path: <stable+bounces-242083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ71BUoz82mZyQEAu9opvQ
	(envelope-from <stable+bounces-242083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:47:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7354A1017
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0ACE93019C9A
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 10:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBEE3B47E0;
	Thu, 30 Apr 2026 10:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SyR31FxA"
X-Original-To: stable@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9168027281D;
	Thu, 30 Apr 2026 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777546037; cv=none; b=uQa8o61bnK025haGz4/gBIG9nRDtTZvQYbZB/dWXHOQSaEjoSTlFiDmAccOepw6CURHkatv3rumScp8iDBYar5BDtMwZslTG5AStIArKSRjSIspBlfl3QlXQk5FWpXAI1+wNQSD7UQ9oE/a+gcUA1Aw1sGrhNaENGnbjQPV0R6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777546037; c=relaxed/simple;
	bh=h8hYeYKqiYnxee1+Bomfx4Bc50aDkLo2wPAk9eb4Nc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsRzYphCBdFN1OynulfsRxUzVQczGEdYmh/ok4IFz5YGhXWJ3ijbiNKkhQzvUvvm7I0+3BpqW1kR65ng0VihWY3qVXBV0tPShFBII9E3UINfJd+Wfet8BFcn/y/Zr0ZjIThZ7HuUw1B7urYB8Grj12Cux3vCTQ6kxrXYZ2gA+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SyR31FxA; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:1ba8:0:640:1638:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 3A5B4C00A6;
	Thu, 30 Apr 2026 13:47:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net (smtp) with ESMTPSA id jkYvs17QISw0-3jKAYhKh;
	Thu, 30 Apr 2026 13:47:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1777546025; bh=XK8fhHHhN8C7AZWTsdc+3Jx084S2B5DKpyixkH26TpE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=SyR31FxAyv/4EHWsum+z02yw7yCr13aMdUa9TPXrbuHbygNGTdp6QrzMqTd8we5Mu
	 SUe4CaILLmNu7I6IUPW0A27wzCxLK6xVASWklcIoiZOOk0HbER7JBLO/Nbmiw2isFI
	 RKWYA3FObdjqE/vUnnJIo+edKMFKc72ATemCjjeE=
Authentication-Results: mail-nwsmtp-smtp-production-main-98.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgenii Burenchev <evg28bur@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Evgenii Burenchev <evg28bur@yandex.ru>,
	kernel test robot <lkp@intel.com>,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon/rs780: prevent division by zero in refresh rate calculation
Date: Thu, 30 Apr 2026 13:46:25 +0300
Message-ID: <20260430104626.16230-1-evg28bur@yandex.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B7354A1017
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[yandex.ru,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[yandex.ru:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[yandex.ru,intel.com,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-242083-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[evg28bur@yandex.ru,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[yandex.ru:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[yandex.ru];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]

drm_mode_vrefresh() may return zero when mode clock is zero even if
htotal and vtotal are non-zero. Current code checks only htotal and
vtotal, allowing refresh_rate to become zero and subsequently causing
division by zero in rs780_program_at().

Fix by adding mode clock validation and fallback to default 60Hz in
rs780_get_pm_mode_parameters(). Add WARN_ON in rs780_program_at() to
catch such cases during development, ensuring safe fallback in all
scenarios.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604300508.yXci8rey-lkp@intel.com/

Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
---
 drivers/gpu/drm/radeon/rs780_dpm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/rs780_dpm.c b/drivers/gpu/drm/radeon/rs780_dpm.c
index 64bb4cafb8b5..8713f3fd6268 100644
--- a/drivers/gpu/drm/radeon/rs780_dpm.c
+++ b/drivers/gpu/drm/radeon/rs780_dpm.c
@@ -63,8 +63,11 @@ static void rs780_get_pm_mode_parameters(struct radeon_device *rdev)
 		if (crtc && crtc->enabled) {
 			radeon_crtc = to_radeon_crtc(crtc);
 			pi->crtc_id = radeon_crtc->crtc_id;
-			if (crtc->mode.htotal && crtc->mode.vtotal)
+			if (crtc->mode.htotal && crtc->mode.vtotal) {
 				pi->refresh_rate = drm_mode_vrefresh(&crtc->mode);
+				if (pi->refresh_rate == 0)
+					pi->refresh_rate = 60;
+			}
 			break;
 		}
 	}
@@ -363,6 +366,8 @@ static void rs780_program_at(struct radeon_device *rdev)
 {
 	struct igp_power_info *pi = rs780_get_pi(rdev);
 
+	WARN_ON(pi->refresh_rate == 0);
+
 	WREG32(FVTHROT_TARGET_REG, 30000000 / pi->refresh_rate);
 	WREG32(FVTHROT_CB1, 1000000 * 5 / pi->refresh_rate);
 	WREG32(FVTHROT_CB2, 1000000 * 10 / pi->refresh_rate);

base-commit: a5640267d6d35b89ebe6418da90a952a247215a5
-- 
2.43.0


