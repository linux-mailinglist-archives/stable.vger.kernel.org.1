Return-Path: <stable+bounces-220284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO7MH0Mvo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBC81C5777
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CA3330B2D6B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00156384D26;
	Sat, 28 Feb 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDRJ6WhH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729D384D1C;
	Sat, 28 Feb 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300188; cv=none; b=n8AS/fLJDuAwQ7yjPJTo9JwaZmEpC1w3Z/WmULDvso2fGEsd5wXlTDyiomApYkGq2ZpFBzUVpWYfBGGxCgriRxgO6bMlOZdsv5idea3fmBOMtk1R67lbkJZolmsLHhyODQPueHrPfgIVp2k2it6V7ltmgQxi+86oSf/2FuaXncw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300188; c=relaxed/simple;
	bh=d/KTjjlDxSA0FL17SjDeVXUNReYvuVcoOwSy9+Uuh8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j055OGp7JvBkeOfJa69tdQVEcUA0F8CMy/F/+2vilcspQYJXZWWO+7Lo3ToBuQLOY6r8j8rF+QqXJy7mw6yx/L86N/z7mzXGuRFzMEoCak6b9Y1fpWxg8T+FUI1S7r2QER4lvvyhHUVzWlQQ/w8+s/2RLPd6fQq6YFJ++N0QFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDRJ6WhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCE2C19423;
	Sat, 28 Feb 2026 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300188;
	bh=d/KTjjlDxSA0FL17SjDeVXUNReYvuVcoOwSy9+Uuh8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDRJ6WhH6oRwWmxd99LcWJTlL5gz4xObjImlPVfipO4ppwY9ji4p7B7BE/E1xAdXq
	 wFSIwmqnvJVIKBaPTwLj/gAfhTgYplYwrd41AFOJqOlb63htCMn91Ea9jQcM2Xw2vT
	 qjSjnPAcJ9KxEbi+iasmDI5Bz/GINozVM+1YGbHvIYbTbVaeLjJ55ZxsBBh4oamZAz
	 NQs2qRgrqOY6RNOXHs36Rz2n7pPhFxePR+S6toFKeiZQzTi6N814FQ0YqRGR0neCr3
	 QNBS+8Ic+2btFzzkOR90uSbsfjgZlLrz82hh0MGv0i8rfJd+WtyOLIZbEDt0aMzvcM
	 LrayEztp2Im2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Manikandan Muralidharan <manikandan.m@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 206/844] drm/atmel-hlcdc: fix memory leak from the atomic_destroy_state callback
Date: Sat, 28 Feb 2026 12:21:59 -0500
Message-ID: <20260228173244.1509663-207-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220284-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,microchip.com:email]
X-Rspamd-Queue-Id: 2BBC81C5777
X-Rspamd-Action: no action

From: Ludovic Desroches <ludovic.desroches@microchip.com>

[ Upstream commit f12352471061df83a36edf54bbb16284793284e4 ]

After several commits, the slab memory increases. Some drm_crtc_commit
objects are not freed. The atomic_destroy_state callback only put the
framebuffer. Use the __drm_atomic_helper_plane_destroy_state() function
to put all the objects that are no longer needed.

It has been seen after hours of usage of a graphics application or using
kmemleak:

unreferenced object 0xc63a6580 (size 64):
  comm "egt_basic", pid 171, jiffies 4294940784
  hex dump (first 32 bytes):
    40 50 34 c5 01 00 00 00 ff ff ff ff 8c 65 3a c6  @P4..........e:.
    8c 65 3a c6 ff ff ff ff 98 65 3a c6 98 65 3a c6  .e:......e:..e:.
  backtrace (crc c25aa925):
    kmemleak_alloc+0x34/0x3c
    __kmalloc_cache_noprof+0x150/0x1a4
    drm_atomic_helper_setup_commit+0x1e8/0x7bc
    drm_atomic_helper_commit+0x3c/0x15c
    drm_atomic_commit+0xc0/0xf4
    drm_atomic_helper_set_config+0x84/0xb8
    drm_mode_setcrtc+0x32c/0x810
    drm_ioctl+0x20c/0x488
    sys_ioctl+0x14c/0xc20
    ret_fast_syscall+0x0/0x54

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Reviewed-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Link: https://patch.msgid.link/20251024-lcd_fixes_mainlining-v1-1-79b615130dc3@microchip.com
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 0ffec44c6d317..c0075894dc422 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1190,8 +1190,7 @@ static void atmel_hlcdc_plane_atomic_destroy_state(struct drm_plane *p,
 			      state->dscrs[i]->self);
 	}
 
-	if (s->fb)
-		drm_framebuffer_put(s->fb);
+	__drm_atomic_helper_plane_destroy_state(s);
 
 	kfree(state);
 }
-- 
2.51.0


