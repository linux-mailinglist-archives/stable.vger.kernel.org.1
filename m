Return-Path: <stable+bounces-238200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJo/CFDj32n9ZwAAu9opvQ
	(envelope-from <stable+bounces-238200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:13:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E544074E4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EF7C3025C77
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063093859CC;
	Wed, 15 Apr 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nv7P6FY7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7F385520
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280396; cv=none; b=uXqEFWF+K6C5mOYAoTB25xhx6RaJyfHRHNnWtNYUOLjUqCFeV19VM6yDD+zT4Hz/ZZuJqiYzqxxDBZEESg7g0h6D5WY0jSvGEfWPSfSHuYXEU/JoMewKJBWv8G8yEB9pwVV18oGz5YNoOJXj7zpzsBQj9/TginDzAo3zXPEA7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280396; c=relaxed/simple;
	bh=QlduOW42d2EffleOxDkxogb+jCXsqBEYC48mTTvHmVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Faa5EMCaz1me+JNQQwmXiA8zlE1PBiKLuj2kqIKHjunxDNg8xCebeFD4DOTCtpyo5q5SPCo61T1t1zZPfdg8dym4HMRhiqLQ1GwdTxenOR63vHFX9seVXALHMx0UHo49xEGb2B/noQWfdDymX4i+3k86xJGUwJVuFBdNYmw9Tfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nv7P6FY7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f68b3aaf7so454770b3a.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280395; x=1776885195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jBcpP2Xf91EXqMzxfz4ls9MLPGhLhWDU+QsE/IF+8uQ=;
        b=nv7P6FY7CyKmdwNaTxZ3dmk/QPCRI226/mRw1G2mVDJQHjxTdG41g9PvLHTXS0bCcp
         C5dADNCJp3muA8dXvja6fjmp+3akwPh+X2qtWOgUd9mvhpaJFzUgSybkgfzAdDKN9Hcd
         PPJmCYGh67SMN6TBxHWDE2EKlFMExN2Cuf5nIzN8b8tv7ZIaK2kbOMIRKAwXYdPpArYL
         C06ruc7QAhlY2betlyK8YO1YRE+NAv19vpQXkmtxnnUCdc/ni9cIps6nFoEhZhpzE88U
         FSVq5gH2TZoo+PtcJSg/aJIxrKp5agVAepsbuL3Hnr2MdmFcQMMQPIo/C2/AUtcRS5c7
         Ds3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280395; x=1776885195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBcpP2Xf91EXqMzxfz4ls9MLPGhLhWDU+QsE/IF+8uQ=;
        b=QfqWQug32i3Ajs/vlSSgK7Q3q/CyZn8b1mHEMiQGzh5Vy8LvxL4sTKtwlVez6koaKq
         hwyiFYtnvPgQ+LGXhVuUUKoWduXbRFmDQrNZzlMSlZ0fj4eRWoUps6CUH38A0YjjVlq7
         YmFxHF2YLwEUFtLiVIA0xEbS5IZYhUPFlU/zKEKfUo6gwnqxtEn37GlJXvbT5rfxkFxu
         k6jPTUOcnDRzoKxP5dOB3bNdjJwSD/iTtStPXMHawgokUASvEoPdMCxhm5EBgWWcFc+D
         Bv1suHUFl7+52krAAHSQ10L/6QvKRNGcrju8pT7Tbu9Y1GH2P9oEOgO08M/8O3aAPYR4
         x1NA==
X-Gm-Message-State: AOJu0YxXS4HKLrgQsSyO6Axj6kdpQkq5CPS6bMDKkck/zPajktLoXIgx
	at6sfDYOdS1pRa7+E3LC+2lMCzhHvVl9Wm0KvGYsTCeQkxtbmu38nMWC
X-Gm-Gg: AeBDievbQP5dNGc9CPLlYLdB7pdJeYj4G338oo6D3qUk9cS6iIXMlw/F04jR5032JNr
	m19YP7+mDkFdhcfsM+jRAjvfH+2qLLS8fa3kxeHltFUGWlaC4QContN8txRAKsSGnzflR7zKCN1
	rbXNRiBawptWFdprseyohYHSxhX57k9Vk8AWPmV5IMci98trvjHIAzQkZgJwwUqoVa+GRMjT6oD
	NrvCHoSDcyGlTdSVhzU8GbFCicpr2+9lvBLZeqqu9Xk4qnvCVeM0hRmK0m+jPAJLCT/EzWF9tAx
	pedvQYMyebdqwK1dNcW80JB7yWuwusva2C2f1PWwJTwC+gzGUKENLAf2ZSNBGD0bEFmJu6cfKYj
	GRHLzorW58meKitEOLg1kwad7HnzVlYTI0De/Pvb2MoGk00Z/AIuNYyjIVP1PnWYnuLj7GLVsOJ
	h3YnpYow4qkriXdLSpn8SENUYAgFei9rsvsBA=
X-Received: by 2002:a05:6a00:3485:b0:82c:e5d0:5249 with SMTP id d2e1a72fcca58-82f0c25abe9mr21497068b3a.8.1776280395057;
        Wed, 15 Apr 2026 12:13:15 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6747541bsm2934574b3a.59.2026.04.15.12.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:13:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] fbdev: q40fb: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 03:13:06 +0800
Message-ID: <20260415191306.3837839-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238200-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87E544074E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in q40fb_init(), the embedded
struct device in q40fb_device has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  q40fb_init()
    -> platform_device_register(&q40fb_device)
       -> device_initialize(&q40fb_device.dev)
       -> setup_pdev_dma_masks(&q40fb_device)
       -> platform_device_add(&q40fb_device)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/video/fbdev/q40fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/q40fb.c b/drivers/video/fbdev/q40fb.c
index 1ff8fa176124..0151a41267b3 100644
--- a/drivers/video/fbdev/q40fb.c
+++ b/drivers/video/fbdev/q40fb.c
@@ -141,8 +141,10 @@ static int __init q40fb_init(void)
 
 	if (!ret) {
 		ret = platform_device_register(&q40fb_device);
-		if (ret)
+		if (ret) {
+			platform_device_put(&q40fb_device);
 			platform_driver_unregister(&q40fb_driver);
+		}
 	}
 	return ret;
 }
-- 
2.43.0


