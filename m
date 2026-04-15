Return-Path: <stable+bounces-238152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDJVLMC432mOYQAAu9opvQ
	(envelope-from <stable+bounces-238152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:11:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 389BB4064A3
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF07D3080A4E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BA13DE452;
	Wed, 15 Apr 2026 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9ENnJDl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0E3DBD70
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269417; cv=none; b=TrENOuDLmp4sK8c7XJ27jSVk62Q/XnnK8UIiLTHHFzaeN7e5LIBi3G1zU7PVifaVYgtmw1OmpdnATDSkNmXwHIC5+GL6n7+19GG+IglbEOF7CG+9wYTJqfik4ycIO/Sdlk4ufRUzWwN8foNW+QGTxnz5447y41GQIbBPE1a5uPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269417; c=relaxed/simple;
	bh=2w3KOA8yk7Qww0r6vlP8QuGutHFJJRfR+W+DcVcyKkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0HIzHWveYXIJz7KkGtWLgjiR75f/+hUWKdSKi2FuuQ0myCVSId3H3tKjgSD7nsL2z2tVGxh94udRUcT6fjLm7K4edrI9CEnCU2yDdeVEqfc14rwzpmMXwJBAWQ91Nr4NJGZA/66oJ8wOU+/rznZ5BY6LqHEK+hago9OVRKfQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9ENnJDl; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so6181594a91.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776269416; x=1776874216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uvfnqSOHR6vjb0scxZvmU791071WtEtmpn2rGjggRIE=;
        b=l9ENnJDlYOLhjEW9ONq6JooYpp1H+dEyNuUxtBaddg+FP469OA9Vzqlk6GlpKl37iv
         w3V1VIvC9dBqZCOAVGtpat2g5p5rdvQWbzCMUoOuXCguOLsWUbCXwrBaOqH8R6+5tQaO
         PUj4VSNWaohkuG5hu03t0z5yzlNv6RCbrgKcXg+t153cjhPt2jiu78OLs51z2GCElgXW
         1mh53WLjrww0I/KWKlNpFtRBkOhHqMn75Cu+BPJAT57vhedxI4CMX3PU3tLZAbSe4p4w
         Meu6/fZnceN1Pr/bsp6pcxUWUOzi9ceZxQxMkBilRQ6fzEKFMXwjnrkH0bd1d+dIyDqs
         1syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776269416; x=1776874216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvfnqSOHR6vjb0scxZvmU791071WtEtmpn2rGjggRIE=;
        b=iSowQb2WC2Lg6P+E7smzU6YAvIsOo4fzFW/prdP1vnz7jT5CvQq0FJLUDvyQVznbQj
         R3JEypMmSt9g2+IxB208k+DSPj47GG+0gvGE2eR2k50K0RsGFcDTdxVOfVRhVtmo9k3N
         11W7HciDkr+8gNIdOxg/oSa/s6AET8KXIFR9pba44IcUWETNF0KQB45TJDHTXoF/9WCu
         FNf+tdK9GlYUFX17zQH2IQexE+S3BiAm9wiXFOYxVXKfUkDKGwTSaxSO+nZKv9Hijh6p
         yeOj01w/I6eyhIWiuw60is0yk1R5jy+qygf8CZSO5CbYjDE7l+9p3tBhJUe+1PAQWTOk
         Z3KA==
X-Forwarded-Encrypted: i=1; AFNElJ+pie3gpal23nZMfXY7bCBjvXaI5Gg2IZZbP6o3MGQDiUM1GxfOHkWNB5VdePSEMUxMXLL7etU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRrUjqDt1Jt1Se1tYXpRcYSRxFU60rNflc+xIjdqiyKgvX9T6e
	Ek512pezRlDKTxQNV6K8I9Pc6WMfPbj5mEl26XMoHQp03jDsWi2HsOch
X-Gm-Gg: AeBDiestmeggVEfnanGZjnnFOyU37oDY+Xe25rqprFFSX1Nb0VRDeCnJTpe3T1gwvSp
	o+1KliXFzDKvJGi1/jRKt/215LxI80RONthXhQ7XDqVW09xEiK5jN1Y5BrTdXepMRgzbrJ7PGxy
	AzkcP4IVtXDvKBsR4QTkJAkGuMHHY43UmYo9Zxwfu4fRGwACvXL64CScOl0pvJpOkyfEucFREm7
	gPpKWErG2fTAfomLGiA4MpyhlHyZNBN3t6ywlqkXk27AL+BlIRL3NvxeWUVre10tEv2disVtX+t
	rtbUhN2AnfH+w2AfxOoIgZ6fpvD42qLU1EsyEvM5sLuhD2WPaqRKgvSsphptlr7HPT9c2V7H6hQ
	qPHPNiiAL97RbIPXCLbaDsUUWdvqPhnDUmgRHCQVEhGzIobEk8JmtJrlV7AUKAbc3u9iTL/mplL
	d2negD3Pl3otRjhzE3JSojMC03zFLuzZxelOEh
X-Received: by 2002:a17:90b:28cc:b0:35d:aeb2:25b2 with SMTP id 98e67ed59e1d1-35e428cda1bmr22964275a91.27.1776269415554;
        Wed, 15 Apr 2026 09:10:15 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:3836:7c38:e5c1:4b6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fce8d7cd2sm1066496a91.4.2026.04.15.09.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:10:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: visl: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 00:10:04 +0800
Message-ID: <20260415161004.3542108-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238152-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 389BB4064A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in visl_init(), the embedded
struct device in visl_pdev has already been initialized by
device_initialize(), but the failure path returns the error without
dropping the device reference for the current platform device:

  visl_init()
    -> platform_device_register(&visl_pdev)
       -> device_initialize(&visl_pdev.dev)
       -> setup_pdev_dma_masks(&visl_pdev)
       -> platform_device_add(&visl_pdev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before returning the error.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 0c078e310b6d1 ("media: visl: add virtual stateless decoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/test-drivers/visl/visl-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index 127ab18bce99..15e4f05d5ec9 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -558,8 +558,11 @@ static int __init visl_init(void)
 	int ret;
 
 	ret = platform_device_register(&visl_pdev);
-	if (ret)
+	if (ret) {
+		platform_device_put(&visl_pdev);
 		return ret;
+	}
+
 
 	ret = platform_driver_register(&visl_pdrv);
 	if (ret)
-- 
2.43.0


