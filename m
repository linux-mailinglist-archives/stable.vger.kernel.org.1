Return-Path: <stable+bounces-235705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5KZ8BuEd2mmdyggAu9opvQ
	(envelope-from <stable+bounces-235705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:09:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 909EB3DF3A8
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 12:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62808300D341
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5EB33A711;
	Sat, 11 Apr 2026 10:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUE1fy8/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D822425B
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775902173; cv=none; b=JRSo3gg6rgC/Ae+i1zupQ0iEJRpH7LiGrpWLKIrOFAfuzYutabwquogWm9eEpao70+GATmKQ1IDqShrPL3LSzsI/0i6u/vjeiPAxD4cfE9iBtDXCetOuMg0tNZBUdD+7JRyOI/GRESSvBgGcMR2pjYjzGyX99aJLAxWnJzaBJR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775902173; c=relaxed/simple;
	bh=puAg1PH9gNxn0enq37DgTWM3U45cvpnO/Tob4vSV9tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDPIwepJnIxtgQp+/SNMA1Y/6pe1KFIeMy9N+ZUzb5Zcx2f3ibz/6ZxGE4iAKemscniKcMO0VaumeU2w/eYg7nIsG/6k+DfRdVvnlY7KJoyToZxCSbSMlISCe7Ph0mtKVrpdk5BQskBTHmh3mAAH/6ZcTyjJMyjzxNDPzRm9glw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUE1fy8/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2696839a91.3
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 03:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775902171; x=1776506971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IYUywUOo7YYuo8bk+o5cGUlmZfbEJGcfbPVStvAYnNY=;
        b=qUE1fy8/1eDNNDNWkOBBEnemCvDHUa4BeCZdQes3mAJGB/5WLW1awtK6TJn3+3Yx6v
         bL75H3/qHMXWw3zBhMtE2r3fPajVCGv8HW8IFiBU9eLFewfDv09TFrQW2EhnKwLHtdcw
         2Ygz2RH20+ERU7KNbXmEi6wVhZPj3vCNmfMyODG0afnZ6GtA1NTJqbAMwCExEJk92XmQ
         9rdG3sr8bNW1KukbvdBRFoHs7zMG9DNV5aaBIodnf5sU4gFYI4/fEbqVxWb3WEZHSuP+
         j3idizpuAqb90cs+UzyM7IDzKJc11/GR4mDseorABfRt8aLzhXNMD6hevTsLFQfFn9EZ
         zjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775902171; x=1776506971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYUywUOo7YYuo8bk+o5cGUlmZfbEJGcfbPVStvAYnNY=;
        b=a8AzsGlAsrQlRYXWQWW1PqCgwjHbrWs6z14+yDialRfhb0vvD0wUVEYsRFn5dH9xey
         I9YwOqSjdXoMwWWBrPalBMc7AFdDvXEzpMiifCbwtuufpall4/SeyOF8CMsE4aloXZw3
         5tjvK0Nq26Kd0uxUMc3niEZ2ClLD5GLG450y0y6CKUibSp24j5pF8rXHpkHPygZKM+oK
         3WF6w3SFUpjba+iBnGwqsxgmk3PPwsjN1Vn8l7NVUetxfqfgHG77YSDgXrVVm2BJo1H5
         BhTyu+pbi+aTDKXJPP7Yu5IweBHwV/2J9g2a6mXkDfYx1et5XbYsaY837g5IW+9hrEwR
         /kCg==
X-Forwarded-Encrypted: i=1; AJvYcCWc5HUWIXkIROtdp6lqa4onWb3pUd0Id5GyYYOmt/8BIflp8PERQSQG0iWRhRZTuMMQO3/2WTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrQBepDyaY9TiBfSO3rjJ9QNeLi4OwYYuom+J9wW1SfIyR2khb
	8nfo/d1kEacNbNkcWDlLndAMyF3CiQHQCASZglbCtc6bY+oMIMGMbVC5Qwfy+17/mCw=
X-Gm-Gg: AeBDiesogQn+ZqDTlhDuRno3Sepoo3i6jWUYOYQEw/c4MuVeUA/d7WJiWor++8sPNEf
	VHXdW8sul0ypHrcHmzw6sPnNlAxZbaqODNGsTmLZiZYIm2GdHCAqzEGbP0GHYjllxJEdVjaYcEU
	bD+KYfqTj0CbB45d/kF1THzrMx3RXUgtqGmEOkQzNeQXO3arlO4GmOPStt014ltmJWy6HcjUW4I
	ti+8AP6xfhOo5EnbN0LHDtXP0FWNNrNMBEGV8Gz8IqyWgB5ABGJJM9RKwOGv7nJV9M3bNJXjeQX
	otnMdq+xvfdxFRbcsDKNE/xomUdBDYpsZZlQuz8VOIjbzFOdCOanHVQj5bdOV72GMk5vRy4SyRr
	s766XAXtN2Gyb0I7nvJ2DACpGYUMOcFbVe57xhrg7H4tQ5is0sNwXIgpke4RTresP2VMQlkho/R
	P0csanc90HTE/S/iFufFqWSw==
X-Received: by 2002:a17:90a:e7ca:b0:359:974a:3d65 with SMTP id 98e67ed59e1d1-35e4285280dmr6940463a91.16.1775902171065;
        Sat, 11 Apr 2026 03:09:31 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e35156445sm9145443a91.14.2026.04.11.03.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 03:09:30 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tony Jones <tonyj@suse.de>,
	Kay Sievers <kay.sievers@vrfy.org>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] enclosure: Fix refcount leak in enclosure_register() error path
Date: Sat, 11 Apr 2026 18:09:19 +0800
Message-ID: <20260411100919.2160169-1-lgs201920130244@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235705-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 909EB3DF3A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_register(), the lifetime of the embedded struct device is
expected to be managed through the device core reference counting.

In enclosure_register(), if device_register() fails, the error path
drops the parent device reference and frees edev directly instead of
releasing the device reference with put_device(&edev->edev). This
bypasses the normal device lifetime rules and may leave the reference
count of the embedded struct device unbalanced, resulting in a refcount
leak and potentially leading to a use-after-free.

Fix this by using put_device(&edev->edev) in the failure path and let
enclosure_release() handle the final cleanup.

Fixes: ee959b00c335 ("SCSI: convert struct class_device to struct device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/misc/enclosure.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index ca4c420e4a2f..9532ad8f8b4e 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -148,8 +148,7 @@ enclosure_register(struct device *dev, const char *name, int components,
 	return edev;
 
  err:
-	put_device(edev->edev.parent);
-	kfree(edev);
+	put_device(&edev->edev);
 	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(enclosure_register);
-- 
2.43.0


