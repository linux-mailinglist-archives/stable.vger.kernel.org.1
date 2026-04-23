Return-Path: <stable+bounces-240539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPh1Fvp76mmqzwIAu9opvQ
	(envelope-from <stable+bounces-240539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:07:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B83457247
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 22:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A61303060C87
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 20:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EE2221FCD;
	Thu, 23 Apr 2026 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNh4oWwv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4D129ACF6
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776974798; cv=none; b=Fp18fbbg4JvNqqeU34qGeMtOvL+Qg8BBOPd44+nSD4z8tA1jBcl0y36rPymb46RIkvCJ+d00xhOxcfKuwVZYBJpUQ7fotM0HqMWxge2cTy7M+ice0LfBDPFo5d00bD+acf9wuv2LmmDnCPUkaovUW4Z1Xz5DWVEY9sRLcXFZlaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776974798; c=relaxed/simple;
	bh=irMnp7k8TSFUT5cNFPN0LKBkCkN9KcJEK3rHVag8CKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bp0uZsj9dRor+6mer/tuzx1jkRins1WY1lj6IlvWgwrsV/NNfggAUyDHtmchCsT/XSaF/7ngyq1VDwnZUvGLzHA1+XHsmPtZnq5yi2UhtKxuduhyba34PLT1KKOg/nMoBPLKFc8lBVkXFsfElSE/BVVd1VLZdvLjbruuEuUd3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNh4oWwv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b150559bso56400005e9.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776974795; x=1777579595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miy/V1Ssd8oZVcXvrSSNRZJTWkLzXKYl4wR7b24pcBU=;
        b=VNh4oWwvmDrGRloogEy2/DO4CSRXDAoDDxQ8eEr5LW6K36gWHkscP32Kie3cshoc53
         YwurxfVgiL4QErswRuZTGjYgEdKKysvLzOtyZ73Qx1ET3DcbzXoiN3DuvJj6c54kKckl
         HJdpW+rfp992RTUnTfbTkPrBUG+mFmibR7tlo1Qlp3KaRyL7DGrdufJDSr+488O5ynSM
         tK+USAbXfC0uM0Tugo5302d2WJy7PXpoYhkbdTPNvLKiVul8BHvRlVaiV/n/KWFTqHUa
         561jFnZMF7OmpQwgkJcOF481EAiStjlEOBmSNfaJOu0QmYZqe+alQUCC+I1fPIBd2F3c
         lCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776974795; x=1777579595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miy/V1Ssd8oZVcXvrSSNRZJTWkLzXKYl4wR7b24pcBU=;
        b=P1oaZC3213rU+c19Oc5A3FOBvBaBiIRKgEsX1PrqNiVtHac8nHM1f3emsmQmpz/pSh
         1NVbmBg3yIEZugXH6mL78C1jP++zp5UAbVCefXB9S5jAwlIcsyfu/Zm3cK05rb8v6X92
         yZKRD1xs7tQB21ETD4Gv1b9fxILp0dKJAqdWCRbbGctXsTufhoGVYj4fSFU6HwXD934L
         tlRKiSrmYSIk+coDjqPmGxGpXPapEXNLQW4i1YWHYS4gHb6VvLoeCFELWFH4CnUsXBZL
         O/m8Q8o5jiLDVRgQS+uZvwuTC80HzJfzkdU3uLMtpAuYeV7+jQNaT2beIsX6E3uNECuR
         qi1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8mHd5KCFQmS+Loy9bw0wDHftbMHudpggpapE51iElp3a8+Ddg5qd/cKm6zG+0pJ9y47akqrhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI0zTQmxSWxlbVRzmrZT+w8C9lKAHvnS7evRPy2Q56DFnLnPyc
	clJ7J8G5wW5r7W4aNIgWNhPFjbkJELObQ1i5q6SyplWOW2jn6dGAJzMM
X-Gm-Gg: AeBDieu7Vt/PrmDY6qRCHhDDENqgQLNROIKK3V5dnudGafLIak68YoXMX1rnog+Qsow
	dNBJ26cDjEgYCi6vf/nRrZEhAco0ZQ3CSHBekxK3FnvRdxr52k/7F4kY6ybWOWawlP8NBSeaYCK
	LRTJEZmW+54LxsxJP5eWaFlKxyHJ/tLKkx42aXtFKipHyb7pvuDTsrYY9JpphdVbfXoYb/c9cts
	g9fP/8MaDjQSoL0dyZeUePEZokDMW8/nf6m6mbuHIiHcQTEAnbEBY5nhC/FE2VDDOIxRp/MTEPj
	NmUOkM+uZL+PyR2OZ2WobHyJjo+yXVT034SfBxC2onwvpkX1R7tOMGXomHknJeS0n+x1xrHEypa
	bkBMjNl73yoJhh1G5Bu+9hwy5WZ+tVFC811WtUxATKdoNIg/euRJC0QQGDU2wT2jnP+hly/MU7l
	b8KuZ88g85QOxuCEcsyZVXwNwfNFsRy1z7wfzO9NJmEdfWzGjNM8/teuPC3Uo7DAu3J1kJHKI=
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id 5b1f17b1804b1-48a56d5179amr182114795e9.7.1776974794828;
        Thu, 23 Apr 2026 13:06:34 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:5f44:38d2:bccf:b54f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb75ab25sm167658815e9.11.2026.04.23.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 13:06:34 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com,
	Inki Dae <inki.dae@samsung.com>,
	Seung-Woo Kim <sw0312.kim@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Hoegeun Kwon <hoegeun.kwon@samsung.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] drm/exynos: remove bridge when component_add fails
Date: Thu, 23 Apr 2026 22:06:20 +0200
Message-ID: <20260423200622.325076-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
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
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-240539-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[bootlin.com,samsung.com,gmail.com,ffwll.ch,kernel.org,intel.com,lists.freedesktop.org,lists.infradead.org,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[osamaabdelkader@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1B83457247
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use devm_drm_bridge_add() so the bridge is released if probe fails after
registration, and drop the manual drm_bridge_remove() in remove().

Check the return value of devm_drm_bridge_add().

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
Fixes: 576d72fbfb45 ("drm/exynos: mic: add a bridge at probe")
Cc: stable@vger.kernel.org
---
v3: add Fixes and Cc tags
v2: devm_drm_bridge_add instead of drm_bridge_add + goto remove_bridge
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 29a8366513fa..e68c954ec3e6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -423,7 +423,9 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 	mic->bridge.of_node = dev->of_node;
 
-	drm_bridge_add(&mic->bridge);
+	ret = devm_drm_bridge_add(dev, &mic->bridge);
+	if (ret)
+		goto err;
 
 	pm_runtime_enable(dev);
 
@@ -443,12 +445,8 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 static void exynos_mic_remove(struct platform_device *pdev)
 {
-	struct exynos_mic *mic = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &exynos_mic_component_ops);
 	pm_runtime_disable(&pdev->dev);
-
-	drm_bridge_remove(&mic->bridge);
 }
 
 static const struct of_device_id exynos_mic_of_match[] = {
-- 
2.43.0


