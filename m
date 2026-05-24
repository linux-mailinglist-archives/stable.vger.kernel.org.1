Return-Path: <stable+bounces-254044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WImgBWEpE2pE8gYAu9opvQ
	(envelope-from <stable+bounces-254044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 18:37:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 730FC5C3298
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 18:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DE3D3008762
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 16:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2882399013;
	Sun, 24 May 2026 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7ZvLD1B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF25390989
	for <stable@vger.kernel.org>; Sun, 24 May 2026 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779640645; cv=none; b=mkk8AUw+TiEoZAT9y4hae0QmBWrJBd8XGsNta9MXPrDBqtL/+r6W8SL8/KEoTkug4GFtdapwdl/n2kI/UjsB7bE6nGvVyvwGY2BkHc9jic6kXvXcz1vfMttcSROzDMdHEEA1CYYwrsdY/CUhdiFdMvBfWeEQQ164GpsbvV6lYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779640645; c=relaxed/simple;
	bh=bB3CujSeqc2lDIe/xKJczcQy7sGOZm3Ot4aNOWG6aCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghc4sORxgxrEa1y3UJitU57IBJcsdZJD1kRO2Wvd+6RKSPb/MdlINKZVnRH12FUNmvBpR45R58jlsa7A9/GfTE0LDT0Ad9dhb/SeNXWWZ4vdD5pPlZ+Olih4tc/GFQU0DkY4+fEjkuaspQROxDPsuuX8oiOh5YXvBDWWTqzHaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7ZvLD1B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bc763e2ba8so44436495ad.3
        for <stable@vger.kernel.org>; Sun, 24 May 2026 09:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779640644; x=1780245444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Bbs8ogJDyCawp6DJ+gyS+VxxLyhjXWQ/w4tp1r61OM=;
        b=Q7ZvLD1BFVu4x0ccJqSxARE2YkVbevzKyPsLEfQyWYnUdaurCoSIlmxateKrGmTJPN
         K5ZQmPNhhqaSVYiIhKP4q83YCAOhUSPluWvBrE+IbXZ3PFWiMMqMHEzpskgh7uZnoHPQ
         sD4yVYZ20exry1Cd4zqMibpV+tgxKP6zG8AWuWqcKuy5YBXHke/PBjcOWyloUDJhkQA6
         LlSVuRa+8txlz1U/1mYodwfkW+jzd3nmvh8TChZnylDWHOH+mr/rwPQtWEPi9PisEsVK
         dKjSwVvP/XoykXgcOLZYQm2OZtpxEdpTR5blwgvW6GWbZkEf1vXeMDtA6uGB89us72Db
         TS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779640644; x=1780245444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Bbs8ogJDyCawp6DJ+gyS+VxxLyhjXWQ/w4tp1r61OM=;
        b=R5FCbfRPmgKrrt42luudL471tWxKq2eEBJFMmagV3FFICi8A5M/94vMh3WdVKEQDn+
         LOUuxjwIh9SuXmKqTsFNjYo61x6Z+fpnWFJ7YNs7takiMZtMF0RuwcDB6JGeGihJv6tI
         dws/8bz56KXnQRsnM7R6Tjc8B47M2bJFgS2qc537MGGv8CvaLytHOm5qsojAIsJetmZH
         8Z2m2t1ItJ0vdUD8l1z5+ACvtmofdDJnM+W/S6qogkeZQxAaqJjcy7jMIA2ermzXFOGV
         oZ65G5XAxYVbpvVgEJS2nyXP4wXsAYY4/UY4+L6y9zg+m+O0mEmqKsEJS0SvW2xN5tiN
         Oufw==
X-Forwarded-Encrypted: i=1; AFNElJ8DVeNJcTiSBdDPNZt04mJgHG2W5BjzkmKZ0qiGDgz7x8nYzgJP98Tq50TJGiKw0lw46XWvkus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9w7nyO9Uy4r6hCGCWhfp1rdJspoZZFWm+T9WqbPZz9RiCpMXM
	KXusiq5+Ltfr6jtNXQqNZHzcgneV70HVWXp26fSpk9dTe1nf2vDs+EE=
X-Gm-Gg: Acq92OFMj7dSW8NTzKFYa3XKWETR6tlqP/dZOBMpM+Ddvy/NiHizT84WUS3Xpg/Ji1c
	I3l1iNX1OCrsf+V/UfCz/UFzom15+QfXtVaSbc1xd44HvHY9kzTybNsAYgRa5TXCWc45QYIhaRc
	TMgS1cA6sm8TgtcIqtlnX9sZG1L3CIHpH1IBVT/v5zq2h87U+KiJCKatKOcAnsdCTS43LZ5Nuh5
	cLZ4gCDMd5LwnpCytdbQ2SZ+XRS+xLJrlFq8wDvmVVLK3vEi4yHbZPih8+at7kahj4o+zPl0ddt
	2PlF3J7hXmFNPEbZN70mtIX4+jPoMzwmcNSxG2FSA/TrmKVhsusEzv7dGT8V2f8wwsXIUYNgktQ
	1ZCcr5mT0oS96hMeYhe2EaYe17P+P9frLS76Y11nBlI9oImLA2YAQDGo7CWy7Sq7LTVa/Uy5cJX
	fnZMoZoAblpnzCKai8zUqIlr0AO5WrQK7oOMkt1pNwahhQfA+rtYYOwnIFVF5krb7j7Nwrfnjms
	YasCOaeww==
X-Received: by 2002:a17:902:e548:b0:2bc:ac76:c1d3 with SMTP id d9443c01a7336-2beb0770aebmr131579575ad.29.1779640643652;
        Sun, 24 May 2026 09:37:23 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b309bsm73017325ad.51.2026.05.24.09.37.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 24 May 2026 09:37:22 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jianhua Lu <lujianhua000@gmail.com>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH 1/2] drm/panel: boe-bf060y8m-aj0: use devm_drm_panel_add()
Date: Mon, 25 May 2026 01:36:32 +0900
Message-ID: <f7407c121909b6da415d4b91f62669ea250a42de.1779640137.git.mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1779640137.git.mhun512@gmail.com>
References: <cover.1779640137.git.mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254044-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 730FC5C3298
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

boe_bf060y8m_aj0_probe() adds the panel before attaching the DSI
device. If mipi_dsi_attach() fails, probe returns with the panel still
registered.

drm-misc-next has devm_drm_panel_add(), so use it to register the panel
with devres-managed cleanup. This removes the need for open-coded
drm_panel_remove() handling on later probe failures and on the remove
path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: a19125a28112 ("drm/panel: Add BOE BF060Y8M-AJ0 5.99" AMOLED panel driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
index 84c21c62a4..a6d765b402 100644
--- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
+++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
@@ -357,7 +357,9 @@ static int boe_bf060y8m_aj0_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(boe->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&boe->panel);
+	ret = devm_drm_panel_add(dev, &boe->panel);
+	if (ret)
+		return ret;
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
@@ -376,8 +378,6 @@ static void boe_bf060y8m_aj0_remove(struct mipi_dsi_device *dsi)
 	ret = mipi_dsi_detach(dsi);
 	if (ret < 0)
 		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&boe->panel);
 }
 
 static const struct of_device_id boe_bf060y8m_aj0_of_match[] = {
-- 
2.47.1


