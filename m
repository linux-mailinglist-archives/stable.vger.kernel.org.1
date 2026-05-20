Return-Path: <stable+bounces-251006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WInZOjL2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB600594FF9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 39BA031CEFDE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FC53F4DF4;
	Wed, 20 May 2026 17:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B/pk979w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF63EE1FD;
	Wed, 20 May 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296857; cv=none; b=gaYhdGe0US3tLuEYP3gGzsyOq1lE5Q2C/MAB3cvTW1Ckd7tc61BCzRGNwtbwPAqNMB5Txp9jEQIhEkohvSCW6yjp9DPn6TvM9a1cs8QRWwwUIftQ3yb2bLIuIox5XpsY7hIIxgS08g9rx6XYOXZV2giHQCLxFJbg5mLne8Z0Ndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296857; c=relaxed/simple;
	bh=w12xz5OLbkKX0UbO31SyDhWTemcPFLnWwyiig0vlHBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oTBWOrGfWMBzkpG/oudDka7+Js/Bwe0z5ukCuxqKbAjh7d/2jIHX6kmePQ+eOxx87qF4S67MixtkqHkPqXJZwsGFGrMqXFRbV2SLSgkbEC+wYa+GHyJ5ZphLfJvKeIWJs2ldxtzKdPJ/27O2eI7/NelCuT2A+MmhsevaqkQzsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B/pk979w; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1651D1F000E9;
	Wed, 20 May 2026 17:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296856;
	bh=lZF2eZLHuQWsAFy3csHM8Gk741qwfRIbdoG/uDY8wg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B/pk979wRKVTw7vxxb+PryFblF4/Oi3efDnPRS213Ks0KDWmFSATlQs1LvG/d1GfJ
	 1J63GIEs+rUdCGx7ouj9zWUAbxAkcnwLf2Hi9ybjOo6wMiS2xZKJ1HEsVQpbZeMtpp
	 KZiSSoAaRMvmJ9sXP49EY/IMc6EXbb/PotsZy6Tg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0917/1146] drm/color-mgmt: Typo s/R332/RGB332/
Date: Wed, 20 May 2026 18:19:27 +0200
Message-ID: <20260520162208.993784561@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-251006-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,glider.be:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: EB600594FF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 9d5a2b8f6281f6090002517fb9272ea07038afe8 ]

Fix a typo of "RGB332" in kerneldoc for the drm_crtc_fill_palette_332()
helper.

Fixes: 7ff61177b7116825 ("drm/color-mgmt: Prepare for RGB332 palettes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/c413e45c8f752a532a4ff377f7a8b9eaab4a082a.1776757681.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_color_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index c598b99673fc1..e7db4e4ea700f 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -831,7 +831,7 @@ static void fill_palette_332(struct drm_crtc *crtc, u16 r, u16 g, u16 b,
 }
 
 /**
- * drm_crtc_fill_palette_332 - Programs a default palette for R332-like formats
+ * drm_crtc_fill_palette_332 - Programs a default palette for RGB332-like formats
  * @crtc: The displaying CRTC
  * @set_palette: Callback for programming the hardware gamma LUT
  *
-- 
2.53.0




