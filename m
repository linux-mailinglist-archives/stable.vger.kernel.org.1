Return-Path: <stable+bounces-255583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBraGU2kGGoQlwgAu9opvQ
	(envelope-from <stable+bounces-255583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D01885F88C2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4336632280E6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768F42580D7;
	Thu, 28 May 2026 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BvFIwnaP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCB2257855;
	Thu, 28 May 2026 20:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999320; cv=none; b=d9fbaSWOrxUIuIE72et0dqtYsK6PpHUMp/EpuPNhoeLhX0jh78IV4LtRFRxYFJJwhOMOlPN9ypWeDVJhse6U/bxWRCqIV5teIiFZiq0WV6ZLiy1O3kn4v3ku7fInnSe/XV16HjxCUH8oQm0YtXRFbenbqhoXpZr7iaJt3DcrA7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999320; c=relaxed/simple;
	bh=UH4Sz9wdYB6F00kxoyARpf+H9rA5SDx95mniN7MQN4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkKvOMiMr/B3MHH7MMWC56XPyNsR7OqqVdvVydMAmPU7B5w28dLJ86M4j7F7Kd7mSQk39unqKR1X97H9225D6UfSq7PhcBjimk5js7osfjr1BX5gERwe1TjAS2hPeUWwczXoJNRrg0URi9+esjvX8JIBKPC6Y2xaA4vAOIO5B5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BvFIwnaP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15931F000E9;
	Thu, 28 May 2026 20:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999319;
	bh=L260MgSoE5/qqJ42/caDlKmfNy17EtqFBvvRwSmPsnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BvFIwnaPCaPUJkdF4bwcY2kwGqg+fin9NSCQ/YVxUNAR1SXk9Mc/RSap5l68x6tn8
	 EjNZorR2rh0aP/TzvUpytW5fl1fmJU+gOD93tDJ9bGMp1om9uzb7QDDFU0B5vRD0QK
	 ytv/etZfndCRenWpAmjuaNa9le4FLaVcsXUlAzww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	syzbot+fcede535e7eb57cf5b43@syzkaller.appspotmail.com,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 024/377] drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks()
Date: Thu, 28 May 2026 21:44:22 +0200
Message-ID: <20260528194639.086627873@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255583-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,fcede535e7eb57cf5b43];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,appspotmail.com:email]
X-Rspamd-Queue-Id: D01885F88C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 79ae8510b5b81b9500370f89c619b50ca9c0990f ]

Increase the timeout for vblank events from 100 ms to 1000 ms. This
is the same fix as in commit f050da08a4ed ("drm/vblank: Increase
timeout in drm_wait_one_vblank()") for another vblank timeout.

After merging generic DRM vblank timers [1] and converting several
DRM drivers for virtual hardware, these drivers synchronize their
vblank events to the display refresh rate. This can trigger timeouts
within the DRM framework.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://lore.kernel.org/dri-devel/20250904145806.430568-1-tzimmermann@suse.de/ # [1]
Reported-by: syzbot+fcede535e7eb57cf5b43@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/dri-devel/69381d6c.050a0220.4004e.0017.GAE@google.com/
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Link: https://patch.msgid.link/20251209143325.102056-1-tzimmermann@suse.de
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_atomic_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index bbec1c184f652..b06a5cba52958 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1913,7 +1913,7 @@ drm_atomic_helper_wait_for_vblanks(struct drm_device *dev,
 		ret = wait_event_timeout(dev->vblank[i].queue,
 					 state->crtcs[i].last_vblank_count !=
 						drm_crtc_vblank_count(crtc),
-					 msecs_to_jiffies(100));
+					 msecs_to_jiffies(1000));
 
 		WARN(!ret, "[CRTC:%d:%s] vblank wait timed out\n",
 		     crtc->base.id, crtc->name);
-- 
2.53.0




