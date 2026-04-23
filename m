Return-Path: <stable+bounces-240538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2L+VDt976mmqzwIAu9opvQ
	(envelope-from <stable+bounces-240538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:06:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CDA457240
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6250F302F25D
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3E927FB3A;
	Thu, 23 Apr 2026 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSm/yEil"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA50221FCD
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 20:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974794; cv=none; b=JRVxL3/Q1owVnMqC1yux0gwQvfvWOwA1uFbIu+bZDxQb+QTjR2BODHDwPS0eosu5fbeSI7a/MeHhnjmOJe1pFezjQPWXbgRFmsAjsGDyBFPDCz3X1mgVMMxGNkrR5fI7O//cRbPiBZ0acBAPml5FVZSixOgso9lAncp8Hy+drL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974794; c=relaxed/simple;
	bh=gBUdYt8F9vwf7fIJJjN8lVFsQUrEL5iOBH05KEmqFVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4zEtTflOfNDSP69/PjsYZzeU0zitUTGQqyFzPQQgSFSLNOkxpDbucCLbg70Jc/NCHV2sk+MvO9dofAnslJuwy66PxHepasjkbXcRb+CvdqZgk4mB0/OZGeqtVAe2BGTM5Gk8NQY1NycBt9U86xot/O6g6APaZ2daRQyihaSIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSm/yEil; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso51724945e9.2
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776974792; x=1777579592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pr8ZXEmD5yrFHrl2Ct33Ap6JH6uM0Ws47D8sKfOxOo4=;
        b=hSm/yEilJRvyw/kP0TJkBcqBBMkBpCbOV347ldsJ2E2xBPpSvivdNZ3aXwvdZw1/qo
         AQKvQ9yB3cjuE7SXftCymdA9SNNrUd7yCldn9hgZ3+C9MGKyarmJZRqJ5g2NcEuvhEVJ
         HiQQ4XZHVzwwOOzslWQSwN0wAs8eYaH6AvRlUbTaZv5Gl0o62i9eMXnboLeFg3bik/bY
         m5NrKHBRzu7Y5w4HlrjYSbqMRoZKE/b96Ppmvucz+UKBb4Z3REN/EjoJbvZ1jpiwMT/r
         K0rwy03qdGRoYqUreWrJ4+qn5jKdVVsaPDlAEysyphJruzFjHAE9kq9exkrA5my9DnEK
         Bh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776974792; x=1777579592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pr8ZXEmD5yrFHrl2Ct33Ap6JH6uM0Ws47D8sKfOxOo4=;
        b=blL4sH3Y9hl11OiQRyaPnIeb1A9Yb/cZRiI1heTPVoSWQufcbDdjl2b53QKPDq125O
         PH9z46asV9zTQWzLFrqcRvn9KB9kqOBajhE2JxnJ6VGuVkpgFTLUEe3NJk/a0FMS+Ati
         eAcufR9vFWvBwWoxlbqJecIHljJ5JSaZvC+c0DYk9BLtz0lkC2OJ0xGkyIwc6WcJfmA/
         zAqA3ehSPgJYAO2Z4jLwz3peK/92s9UvKTwbEPmaqpoQE0ubfXx9QkdcmNdO7mNUYPIP
         4CDreVmhARC2pHqdhvFzjA/tCr3lapTPHcKGBPZA+Cp2ksWXUkL6UWHPQIV+Y8mcAC/0
         BFSw==
X-Forwarded-Encrypted: i=1; AFNElJ9D50z5nHUsSHd5L1Ld867BBDHHgwa8AsgKlkDTVpY3Ml02HKRJHpA3UQqblQynxEB9bIfOvqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/QBTVhk+8WrAqes07YKadFrosbwLs0HQa0Aga2hjlWbKOXsDI
	F7zTVtv/ny6rodTsFSdJW3IB4vf4ShaJXUwJnztkhx6XqTH60KSEcrAw
X-Gm-Gg: AeBDievsqxMwDEoespq2maF47daD2viy0ZDBbBl3aiykM9Ha95VzqZp6CLpteEQQTrq
	oxGDpfXq4uBseMAd4Xg3Xz568LmOcn9Ae7/GHuO1CDZ0u3QNR+KhIufH8GWu3+QaOq21XJNN1wG
	qp8XYeDZlcj2ebWPD0JFYVfU1lPHOfAu6sgLd5837GZLONNSLy1nuuJbKlUc/cRAG+xFTrgVsoC
	o6yKGcYVuIwuA6vF94GMxtmV7cTnIJhLygj7ivOtMjcYLQMhGiXmjd74FDCWKaEtyk6kOFVIaTO
	G+H9NSo6IgA+WoY4mxl+pI9tidd6piCiPql81vvsr8bmHQCIhg5S2371AqeMe2HGdS8WxiF4z33
	6Vv/IEuHJF96OqRsqBscdMiDzsDKa9AECAWb06a6iQ9pczXsBlgLmyCjgVMDt4E+0Ibmv2bpOTn
	L8cYetgQcOmOcxW+W6RlhPBNt3u6F9ccT3oR3W4BNNN0F/DorH1n2fMky+EixZNUP3MzV+aIU=
X-Received: by 2002:a05:600c:8587:b0:488:a797:f0ac with SMTP id 5b1f17b1804b1-488fb7880bdmr289804935e9.28.1776974791551;
        Thu, 23 Apr 2026 13:06:31 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75ab25sm167658815e9.11.2026.04.23.13.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:06:31 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com,
	Alain Volmat <alain.volmat@foss.st.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] drm/sti: remove bridge when sti_hda component_add fails
Date: Thu, 23 Apr 2026 22:06:19 +0200
Message-ID: <20260423200622.325076-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240538-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,foss.st.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C5CDA457240
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use devm_drm_bridge_add() so the bridge is released if probe fails after
registration, and drop the manual drm_bridge_remove() in remove().

Check the return value of devm_drm_bridge_add().

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: d28726efc637 ("drm/sti: hda: add bridge before attaching")
Cc: stable@vger.kernel.org
---
v3: add Fixes and Cc tags
v2: devm_drm_bridge_add instead of drm_bridge_add + goto remove_bridge
---
 drivers/gpu/drm/sti/sti_hda.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index b7397827889c..360a88ca8f0c 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -741,6 +741,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sti_hda *hda;
 	struct resource *res;
+	int ret;
 
 	DRM_INFO("%s\n", __func__);
 
@@ -779,7 +780,9 @@ static int sti_hda_probe(struct platform_device *pdev)
 		return PTR_ERR(hda->clk_hddac);
 	}
 
-	drm_bridge_add(&hda->bridge);
+	ret = devm_drm_bridge_add(dev, &hda->bridge);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, hda);
 
@@ -788,10 +791,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 
 static void sti_hda_remove(struct platform_device *pdev)
 {
-	struct sti_hda *hda = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &sti_hda_ops);
-	drm_bridge_remove(&hda->bridge);
 }
 
 static const struct of_device_id hda_of_match[] = {
-- 
2.43.0


