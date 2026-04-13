Return-Path: <stable+bounces-236102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJIeHif63GnXYgkAu9opvQ
	(envelope-from <stable+bounces-236102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 789223ED294
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74C50300C3A4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B133D811E;
	Mon, 13 Apr 2026 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBN90tUb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D623D88E9
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089622; cv=none; b=RdA4CWEL5nGVGtEkAUmgGHyswIGU9pAGTjOeuZ6Iu5kVbXEHMshlM0QP5DNYSFGDsq0blenjS1/jcI6j6DTvhSpGCyjBZS35z+JQEPzFfU1fbyFlldiEPKmjAo+OC6r8D15P0Cm9VhTIHhYg74bYykKynLxZnMtSqk0+uPlwTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089622; c=relaxed/simple;
	bh=5S3YAVKId+04a0qvuN0YFuWomUi+TppqBBWCt03upfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chagq4c4xEQJ4CUpI+ibY0+TvyoXruw8TotloQAI9j8BB2F4vlj5ywLZZeCN3mHkWPf4KcBdTqfw4UOvirBr1IURh2TOq2ggaHu0qPgcFd99mQppDC6c5xexQst+b9M5ol6oux2nve9EFdMOH2hNXIpNanwNFunVe/MzfRseaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBN90tUb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76c60c7502so1723895a12.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776089621; x=1776694421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+qqSEWuusa4ngNGb7Rrw9FBrzRc6uTBdINaFH/HdeE=;
        b=GBN90tUbaSJDVDCerN87/RzUxkuYqEzHz5DWs2XPwWhyMX1QPasgpng/hxAeyFCpey
         ngimKXmf/VkhzBu0j3SgtUr6PopDfksyUcIsSpyaD3Mw/jQ+1zCp6PBUS/yFsB4OHqwX
         Dvf3lnSRahlVJGHIQ11rQRVAJ1KzPKhBFQB76EmP6iU3r3hG08DIvy/pALCXW+0jYFp9
         xacD/ZsA34uVvaCi4p32JifjuoNeBvBaK1mZM1vjCv72zsUrPkUiyFuA3lTVhZ3d65Ar
         hnn9M9TbL5SmTNtL4zg2dDSY1T1hq/F3rIDZ/Dv9pAPNZeq1ndXHoIUXF45P4HwC3OZf
         pYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776089621; x=1776694421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+qqSEWuusa4ngNGb7Rrw9FBrzRc6uTBdINaFH/HdeE=;
        b=HEgy9OQjQZSy1WVeMEIj43xo8G7zAsW6TaDa2MW6NEOtNUQAmTxS2CZ/QWa2zI5334
         PK19HqG+fNO9R4/Ny1vb3dlosplmKH1bdpkWHsr/7e/z35HxxKppEzY//rQZtW6Fnfib
         h89n06iNjEogFc4fSWAqU7p/pkDLrEA8zvIa+zBhCn9a+C1c6GrP0XaH66fwl9Thq/BP
         5NnqIFQwg5xqOLusBQPJusAObBcb/vuTD3CT9h04/aYgI9fKcEnSLalyt/CdwaUan60s
         cq+4M8N6M5DsMfn7w+lBRlTac7bxRFbxh8BjwvbPVS0o5SVT3dIZl1uc5GKZ7dB8gH9G
         Mhww==
X-Gm-Message-State: AOJu0YxZcafGqKR+rZJRtMhobzNM10prekf7v2K8X45QWD0ISB/U7jnt
	U0HJMNpkyDH02kQeXOInU3ANdq7jZCOB49kQOqgQagMil31X4WpciHru
X-Gm-Gg: AeBDietuaLqqIE1ScV4BwGZvy+mFBKZVY7mvGfNZgyS19spwVW1vy3njys27M5fXxUZ
	OdzO/An9ukIqlCPVyiHeV1CjAuyVZvXMAKgmmwk5vXTMOJ6rx0OLVKULCaE2+GoHfjq70n8TlYH
	avzZAwdebjHcFvYB6/RMvnE+Qo9cIPbHmlQDGYe45kIakioK5xYVEdeF4WIlTinjV1NAlR5kVTo
	no7cpa6GBlacpl1KNsgpbQ81tzvIHmxYCbGv4tGLzobz86xLrvS3YtbD6TU1rKnVUBgtb9L4wbe
	mt6p47jL1cP/TDk5XOHZoJhY0EQj4j8xvrDfp32A3kb17wc1kOZ5Ug0ULPIc7Un+Kvuobb+UqkS
	wYkA1nE8BUx6/oqfIK+s7yPhj4LcwGKlOz8spMMrYawCxkOgTAFO/mlAOrltKmLoYqdmCVzpJ8Z
	WyHrykUILdXQ0kNaNKOdAuD0SFIX8kDEoAK9A361LBRA==
X-Received: by 2002:a17:902:e78e:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2b2d5d0e8b6mr126999785ad.14.1776089620819;
        Mon, 13 Apr 2026 07:13:40 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4dd5cfasm144226695ad.18.2026.04.13.07.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 07:13:40 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Vamsee Vardhan Thummala <vthummala@nvidia.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2] gpu: host1x: Fix device reference leak in device_add() error path
Date: Mon, 13 Apr 2026 22:13:28 +0800
Message-ID: <20260413141328.2954939-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,nvidia.com,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236102-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 789223ED294
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the embedded struct device in struct
host1x_device should be released through the device core with
put_device().

In host1x_device_add(), the empty-subdevice path calls
device_add(&device->dev), but if that fails it only logs the error and
continues without dropping the device reference. That leaks the
reference held on the embedded struct device.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by removing the device from host1x->devices and calling
put_device() when device_add() fails.

Fixes: fab823d82ee50 ("gpu: host1x: Allow loading tegra-drm without enabled engines")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/firmware/edd.c   | 2 +-
 drivers/gpu/host1x/bus.c | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 55dec4eb2c00..82b326ce83ce 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -748,7 +748,7 @@ edd_init(void)
 
 		rc = edd_device_register(edev, i);
 		if (rc) {
-			kfree(edev);
+			kobject_put(&edev->kobj);
 			goto out;
 		}
 		edd_devices[i] = edev;
diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 723a80895cd4..63fe037c3b65 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -477,8 +477,12 @@ static int host1x_device_add(struct host1x *host1x,
 	 */
 	if (list_empty(&device->subdevs)) {
 		err = device_add(&device->dev);
-		if (err < 0)
+		if (err < 0) {
 			dev_err(&device->dev, "failed to add device: %d\n", err);
+			list_del(&device->list);
+			put_device(&device->dev);
+			return err;
+		}
 		else
 			device->registered = true;
 	}
-- 
2.43.0


