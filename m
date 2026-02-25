Return-Path: <stable+bounces-218297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBJcKjlSnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A7A18F293
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B64183077027
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02EF2417E0;
	Wed, 25 Feb 2026 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0D8RwkIS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307B1E2834;
	Wed, 25 Feb 2026 01:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983098; cv=none; b=a1m2fsC4algI2fiDz1PQtTWm+tDd+yGQq/Ob2qMuO1r+Koq4FIphPP8Ggth6HkXcnTFU0Ny7VyHbaXcdOCf1bXOgyXBwvwcIHL99q8auuWxvpxQmtMEvnZj0wybkESSgSUfeMAwoh6z3r6HH7obl9FH3tuPBY9sKdiEO/wCe4Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983098; c=relaxed/simple;
	bh=AC8ykLs61JpiKGJG7ywuCdJlb5uDJShi8S6e/mwCQwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0kLf92US5JzFvZ7/uXI4knPbp+x/0c97yEwqor5f+gNIw65Pok4q9Oxi2SbV9uhgpLayfY1sm3NGOdnDW9cwxi9LC2fJNQi3iqHYKqPViIB0gdVjfDQoGEZ87C6tCIHxZ5AP+lb6yb32zXm7hi4xFbsb1QMjW6brafwJUObNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0D8RwkIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3340BC19423;
	Wed, 25 Feb 2026 01:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983098;
	bh=AC8ykLs61JpiKGJG7ywuCdJlb5uDJShi8S6e/mwCQwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0D8RwkIS+wQjgZ8Cr8u09vKfjN63xZnrEZpqq5zd+bT/dOD6wQxshkRswKvTFcgAA
	 89Mds2sTOa5y4fqkycBkAY/F6YMFzdLLcGlcHWsU/yG5P0ln9fZ1K6sYF73vxmIcGY
	 IHfh6JieKlMUadwu5gpfhfP8YlQb+s+5Zn6LAzWY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Ser <contact@emersion.fr>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 206/781] drm/plane: Fix IS_ERR() vs NULL bug drm_plane_create_color_pipeline_property()
Date: Tue, 24 Feb 2026 17:15:15 -0800
Message-ID: <20260225012404.770186602@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218297-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linaro.org:email]
X-Rspamd-Queue-Id: D1A7A18F293
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 470cb09a2936d3c1ff8aeff46e3c14dcc4314e9b ]

The drm_property_create_enum() function returns NULL on error, it never
returns error pointers.  Fix the error checking to match.

Fixes: 2afc3184f3b3 ("drm/plane: Add COLOR PIPELINE property")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Simon Ser <contact@emersion.fr>
Link: https://patch.msgid.link/aTK9ZR0sMgqSACow@stanley.mountain
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_plane.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
index b143589717e64..bed2562bf911b 100644
--- a/drivers/gpu/drm/drm_plane.c
+++ b/drivers/gpu/drm/drm_plane.c
@@ -1867,9 +1867,9 @@ int drm_plane_create_color_pipeline_property(struct drm_plane *plane,
 	prop = drm_property_create_enum(plane->dev, DRM_MODE_PROP_ATOMIC,
 					"COLOR_PIPELINE",
 					all_pipelines, len);
-	if (IS_ERR(prop)) {
+	if (!prop) {
 		kfree(all_pipelines);
-		return PTR_ERR(prop);
+		return -ENOMEM;
 	}
 
 	drm_object_attach_property(&plane->base, prop, 0);
-- 
2.51.0




