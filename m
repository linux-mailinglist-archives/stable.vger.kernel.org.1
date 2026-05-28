Return-Path: <stable+bounces-255584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKk/EkukGGrClggAu9opvQ
	(envelope-from <stable+bounces-255584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F525F88AC
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6463228D1A
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685B92580D7;
	Thu, 28 May 2026 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGnTJWYt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955B2459D1;
	Thu, 28 May 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999323; cv=none; b=cZOf1HLnU00NjsVTEgGCXG93da7B7ZjquEva3oJ4mxl3fyFrA4TMhZ8lnKtZIqljPB8tDojW4EKpBMHQ1NUTIuYIVD3UN8fnKfX4HkLZqP8DXHWrmoY4ipgh3BCPxVaE6S4xZIeAdz06tZxIVvFl5EhOvHiY2/il7cuucU12n6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999323; c=relaxed/simple;
	bh=UGpfaOL0Jf6JFDFiDWIQ/U6pERqYTU9Wt73zLINsswM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDy1Dl+KYmmXAPV0QyQCG+/J3en8Nhq1yPy5t+Z+R/A1WAfKZ1HSAxuei7Ckubyu4e0xxz1XvQDUFsQjhBsWn8jNusJY/Djnnud7qD+H2UGqaaqilt1UEbx9zawBWvP1KznspJF9g1K9m9lSzvvBjazu8EtxJ9Lu4ky5+/AobPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGnTJWYt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443431F000E9;
	Thu, 28 May 2026 20:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999321;
	bh=wngop8rY/CemTIB4JW0B/JXyJl0KO6CCakAUSNB/adM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VGnTJWYtlyzszgLldQUVQGeSu27iEVwTyiygVETRa1qZ9/YGIMFQ3ex73HEOb/CtN
	 V7bO81ZzwaCq/O5fbdDEpMqdvQA0cn3ZisASKqCt7mStH2LdbCLRX/bEY7+qKaiQu3
	 cfAxMfT1y1xnJi7hlJP/FsbbaKzsqHPdm/YYm2yo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Louis Chauvet <louis.chauvet@bootlin.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 025/377] drm/vblank: Fix kernel docs for vblank timer
Date: Thu, 28 May 2026 21:44:23 +0200
Message-ID: <20260528194639.114698063@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255584-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.de,canb.auug.org.au,bootlin.com,redhat.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,lists.freedesktop.org,stu.xidian.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A6F525F88AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 3946d3ba99342f3b9996e621f05e7003d4308171 ]

Fix documentation for drm_crtc_vblank_start_timer(), which referred
to drm_crtc_vblank_cancel_timer().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/dri-devel/20251106152201.6f248c09@canb.auug.org.au/
Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Link: https://patch.msgid.link/20251106073207.11192-1-tzimmermann@suse.de
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 61e211fd3c9c8..451ec96202266 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2258,7 +2258,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 EXPORT_SYMBOL(drm_crtc_vblank_start_timer);
 
 /**
- * drm_crtc_vblank_start_timer - Cancels the given CRTC's vblank timer
+ * drm_crtc_vblank_cancel_timer - Cancels the given CRTC's vblank timer
  * @crtc: the CRTC
  *
  * Drivers should call this function from their CRTC's disable_vblank
-- 
2.53.0




