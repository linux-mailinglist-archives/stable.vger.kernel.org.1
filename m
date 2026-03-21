Return-Path: <stable+bounces-227655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMc/IVkvvmn3IgMAu9opvQ
	(envelope-from <stable+bounces-227655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:40:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD1C2E36E6
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 06:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2DC53038160
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 05:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8D359A7C;
	Sat, 21 Mar 2026 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5RgWuaK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAD2848AA
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774071580; cv=none; b=O87liwgSZlMG4JILGTm8D527CuQPGdbqiIbljDWPkMhYYVAlWsGOThCIQzD8dcuLckEHuAUcF8VCkiDdH3GYOrsfozvO02q8q9lNjVJmwloHs9GLXNBfyGDusf9AHVI1ChleseF4M6d/M7z9rxwBagt96EQgaJVePhASqsynsMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774071580; c=relaxed/simple;
	bh=HYPV5+I8fH/ypfF2AgO784OuRVVErSIU/yP/DXliX8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXXyD1rGOtVcbPZNRWsqmz2z9mekgN8Yydxcct9dcmxE1oO2iLJSRkABncmF+LzBe1hvlMSP83kzithbH6kLD7n+CvW5Cio6C/E2fCHkeAM80iR6n5WPWIOIxgYh4daa4m9zZhMm0rEFFw3mVyQ6pnivQwp+NbWzJhkLsScWOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5RgWuaK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a1230c60eso613133a91.3
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774071578; x=1774676378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vLQwDdr1oGsaR2KdQZstZjQxIdivEgvuuhjfe9IBVw=;
        b=l5RgWuaK8nGr3MfLf5HRHrRqSweWoTQ8Fd263KKjtuQHl2Wme/pUs7mA0CyvAoxWVP
         nHRs4Crn7SJRVgFIfRJv2uaZOMYYNoj3oe2RO+A21NBQnsYQF1Qt0CHn7d6PSbX+4ehj
         pQktXM6ZvoJzfClFxPCfiGfgrpELfntjKNKMfiqihB8Ul5g2O4yyNOPmyXN7g72JcOPa
         g9AgZwZ0utmhAv/7CCNDlL/jH9+O/ahYBLwGdTDzpNlJnOc3mGz1vSz7DlNMFQHEPr+/
         r0skttNVEivTtfXdtjbdsWoXV4hL9C2qWY9cBeYtT9pmzZcESjYv7Nt+DLCAr7IWzds3
         ssvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774071578; x=1774676378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7vLQwDdr1oGsaR2KdQZstZjQxIdivEgvuuhjfe9IBVw=;
        b=jgyzsSP1Ujtthf/FXt22ZqL7QGN9fSbRS/s7K6Z9SICpTgPgoALNB/HiV8Wms0oSez
         l6rTdKxy/5ielW/L3UpZNBN3W7dkhnwiOTDGwZ6qVcHcwcknBnWZeq81R7ktGeOqB4wo
         VE4y04P/ztcwNi/TnvJUkKruBj2MesCW+Nv1PbgOu961mII+sWmcnPcqDcBWmitrcipa
         uNhs62lgW8j8nbsRe9HrbpFAmqT/jXgYTrnnVul8MaycV8+9oTyQrUNtvaHfZWrchknU
         FmDPp1iQGeG4vldSKKKUiviPJFDJ2ke2dNI4OltytanYeHOjX6nUOEXvk1W+uwM3AqEf
         mfWA==
X-Forwarded-Encrypted: i=1; AJvYcCVAhFtZfVRRe6jhCJnLlvNZYzR5WuSPEtbHGUuwptBjh2A2Y4TUqiKYzVBrBwafxkRZPjQJSKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJtgNT55xQolCocjzE8/WFmnu3KO95XIyuocG/vIdpVvIdCA+6
	w97bBQ/RqAdDU4oP4NRgl+I2OaA019+UXh3QPi8JVyNTOAy9njTghar7
X-Gm-Gg: ATEYQzzkl3G5ChU/tQoD7i8bWkTh5QtlwQlSQ2P1hZr8YtR1vwEQXgoizbb070L8pSo
	tcVCVYn0Yzg+L/w71IwzpYYxNVEKDsfn+4hnvkBv53fSwxeOSZrZlNdpNEbvKrKpND4B0w4HJuF
	0F9Y4MONBc8EvnmKmsBfSySg5R5tiS0765vs60e6UI8RGInlTExrq8uGTLsLMl+BwXnpBdoJRdi
	1oqCG7mgqI3MfSfetC63/eOMVnbUIxFh1Ta52kfPMi8ogASfWL0QJ9/wFRm0zNAHVpLvyTseClV
	mVghrFez9w9ZDvSxZg1lhrXYdw5YdjT/MCYbtWrmEFy3tOHBhYlYuv0wC/AaVWzC8+aruzAlmSL
	rcOhgtAOyjJuHol/Y2X3bX+lfcacxOLP0w29gD7hvKDLqVmq1VNanEzILK9/p6y2MOQEnmPtArq
	zwq0mzadFAso7edjUbXRNT
X-Received: by 2002:a17:90b:2884:b0:359:f77f:8cff with SMTP id 98e67ed59e1d1-35bd2c9b202mr4116462a91.19.1774071577781;
        Fri, 20 Mar 2026 22:39:37 -0700 (PDT)
Received: from lgs.. ([223.80.110.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd36bc5desm1294856a91.13.2026.03.20.22.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:39:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: mana: fix use-after-free in add_adev() error path
Date: Sat, 21 Mar 2026 13:39:18 +0800
Message-ID: <20260321053918.791068-1-lgs201920130244@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-227655-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AD1C2E36E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If auxiliary_device_add() fails, add_adev() jumps to add_fail and calls
auxiliary_device_uninit(adev).

The auxiliary device has its release callback set to adev_release(),
which frees the containing struct mana_adev. Since adev is embedded in
struct mana_adev, the subsequent fall-through to init_fail and access
to adev->id may result in a use-after-free.

Fix this by saving the allocated auxiliary device id in a local
variable before calling auxiliary_device_add(), and use that saved id
in the cleanup path after auxiliary_device_uninit().

Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
Cc: stable@vger.kernel.org
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - explain the UAF in more detail
  - retarget to net
  - preserve reverse xmas tree order for local variables

 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 1ad154f9db1a..70d71594c599 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3362,6 +3362,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 {
 	struct auxiliary_device *adev;
 	struct mana_adev *madev;
+	int id;
 	int ret;
 
 	madev = kzalloc(sizeof(*madev), GFP_KERNEL);
@@ -3372,7 +3373,8 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	ret = mana_adev_idx_alloc();
 	if (ret < 0)
 		goto idx_fail;
-	adev->id = ret;
+	id = ret;
+	adev->id = id;
 
 	adev->name = name;
 	adev->dev.parent = gd->gdma_context->dev;
@@ -3398,7 +3400,7 @@ static int add_adev(struct gdma_dev *gd, const char *name)
 	auxiliary_device_uninit(adev);
 
 init_fail:
-	mana_adev_idx_free(adev->id);
+	mana_adev_idx_free(id);
 
 idx_fail:
 	kfree(madev);
-- 
2.43.0


