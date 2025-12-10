Return-Path: <stable+bounces-200741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B8DCB3DDB
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 20:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F22B7300FA06
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636742E7BDD;
	Wed, 10 Dec 2025 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CUUyc3ib"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F718C2C
	for <stable@vger.kernel.org>; Wed, 10 Dec 2025 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765395084; cv=none; b=iMWrM9oNSm8bajAap2J7v+CeGun1t3+Yg7FtDSvCblrq24ZSYa1gX9ZucxWJnX8NBWwQi90JSMWK+iQ98Z14nWA6cZMue+mEq00TByQfkWjPkV+bj3WZMVINbilK98wCwvlwDvPf+/0r5kr9SuIO4V+jPrzK6tov/fx1V4T6VHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765395084; c=relaxed/simple;
	bh=jAI/cZ8/Risj2obasGTbiOljtvLuJxNQ2nILXsO9Bxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ADEI3Wa+k+MEpaoHUZAy8UwYynFqbFAq7j8biEyla32zwGouukVvEv69eRXbwdvfrC4yRAPMlUTpJvf5IqISBOms0PB2hmGGZHAz5obbb2dM1yAmkir4DgqWUz2ypodCp2wXROHUSLeozy3zGnv8adj1CMIBdMqY0MlxXdsg5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CUUyc3ib; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso110035b3a.2
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1765395082; x=1765999882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F6ybH5P0ZqP5MXm6M6ozs1e/SZAmwiNIl7gbv5z43yI=;
        b=CUUyc3ibGLDMI7LX2Jc5Iqs1fvDvfpERE667yXBBlcD/THB9Zf8s7CR+65F9jsYE+h
         nNn27DFBmNOPjlSA/oG3rMKHIjh16JncQwNhrU7zoXnWhY5QI4+ldFZSGCW1QNcE2gLE
         j+HHPP7IW+mpCsG3YxnF1SWHDlFiOE6efFFvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765395082; x=1765999882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6ybH5P0ZqP5MXm6M6ozs1e/SZAmwiNIl7gbv5z43yI=;
        b=oCyqeCzngD4hkMnVeEnQblclLDVxIM59q8dWSaeg9d0bLHAm6hgz/Q789EYURyKHgy
         BjTBM3k6fMsEedKo1JWSpwoXlzR8apAtObEP2szXGqP7u2WBUuPLzUCalZT2AfdCFPW4
         Y3cHEe7wor2AVkmNFPrddjRyEWta2HbXE5vHanpreEg7Mr3G2gU6mKzg1pjvtZV4HTFW
         icGu22aZSUb9Vn0Lw/UtY73NzBHAFMcbrSrPdfmHHnnY+5iHG2oMrpylxuZRi73bnbKL
         rm798x8D2bG4K34eiBHaU/8YBAuds95qwS5uTQ79mdgV0cF7NIjrOLatGyynBZoE7Po1
         3Rzg==
X-Forwarded-Encrypted: i=1; AJvYcCWUF2nLPfAe7h42V9iYYR1RP7SsUNEp+U/U/SMWKVDjUe7jmsyvVYoC/K09fOsZV3F0C7ST0ZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxktIH0NSngyNLjlKZcRrlozdt7vt99xSj9sriAowi+e+vrjlnJ
	Gba6t+O5WkgbNN+udRgGM/Oiq2HdqxkX3kmW/FxrrsT0giL+TvVKkC/sbf1J76FQWw==
X-Gm-Gg: ASbGncteUlW2NpQCUIVUIn+i4FUDGRfiKixI6Jb0C09KFqz7PsFn2XxJRAgfLTWrrEP
	bBoZlu13LI8kB5uBBrTZ+pefOgwMdcks17HXt1AnLlZF1zTIzwMj8/7A4yJitMMPAcDjMlf5al6
	S4tTOYWkL20vcMHbUCV9ucLAH+Xvh3uDCpjotRLxjN0qhJKVEFYmFsWqP85tcOEKd6CY7aH2LWC
	k6k7gLkvSevP00Zj7+IcSKEuFw8Hi0N6NLkZQPwvxvOcV2mm4am45tyS35u+7/xLHducQzsRBHK
	aGnK3IPsNbF05zNnKjlfJWk6JOFsCGtl5IgsceqlYDG9ZKN/w882+5Z27O1ylBoRssugJP5n8o0
	0S2y0QRcy+KM5wIRKJ1tSybfQweAZVAhR29fbLJSVH9fimlVjCPO3s7IK9GefzxEGysiC3VMnA4
	tTfGB8jR4SfcDaWY9H5eMzD/96PjERm95jgd0AiPwDvodzGym5V7JNKKEXX3uLlehQeBTR+u4=
X-Google-Smtp-Source: AGHT+IHfmJbB7s5a1YoDz1FXkh0zlCZli9b00q9Np/CI/Vyd9tLtbPt7EUsePWimkahEhv0KewcvFQ==
X-Received: by 2002:a05:7022:128d:b0:11b:9386:8255 with SMTP id a92af1059eb24-11f296b4370mr2779334c88.42.1765395081844;
        Wed, 10 Dec 2025 11:31:21 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:2eae:c894:7aaa:937f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb2f4sm972592c88.3.2025.12.10.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 11:31:20 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: core: Add locking around `mfd_of_node_list`
Date: Wed, 10 Dec 2025 11:30:03 -0800
Message-ID: <20251210113002.1.I6ceaca2cfb7eb25737012b166671f516696be4fd@changeid>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Manipulating a list in the kernel isn't safe without some sort of
mutual exclusion. Add a mutex any time we access / modify
`mfd_of_node_list` to prevent possible crashes.

Cc: <stable@vger.kernel.org>
Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
While I have no definitive way to reproduce the crash we've been
seeing, it's clear that the `mfd_of_node_list` isn't right at the time
of the crash. Code inspection shows the lack of locking.

 drivers/mfd/mfd-core.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 7d14a1e7631e..c55223ce4327 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -22,6 +22,7 @@
 #include <linux/regulator/consumer.h>
 
 static LIST_HEAD(mfd_of_node_list);
+static DEFINE_MUTEX(mfd_of_node_mutex);
 
 struct mfd_of_node_entry {
 	struct list_head list;
@@ -105,9 +106,11 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 	u64 of_node_addr;
 
 	/* Skip if OF node has previously been allocated to a device */
-	list_for_each_entry(of_entry, &mfd_of_node_list, list)
-		if (of_entry->np == np)
-			return -EAGAIN;
+	scoped_guard(mutex, &mfd_of_node_mutex) {
+		list_for_each_entry(of_entry, &mfd_of_node_list, list)
+			if (of_entry->np == np)
+				return -EAGAIN;
+	}
 
 	if (!cell->use_of_reg)
 		/* No of_reg defined - allocate first free compatible match */
@@ -129,7 +132,8 @@ static int mfd_match_of_node_to_dev(struct platform_device *pdev,
 
 	of_entry->dev = &pdev->dev;
 	of_entry->np = np;
-	list_add_tail(&of_entry->list, &mfd_of_node_list);
+	scoped_guard(mutex, &mfd_of_node_mutex)
+		list_add_tail(&of_entry->list, &mfd_of_node_list);
 
 	of_node_get(np);
 	device_set_node(&pdev->dev, of_fwnode_handle(np));
@@ -286,11 +290,13 @@ static int mfd_add_device(struct device *parent, int id,
 	if (cell->swnode)
 		device_remove_software_node(&pdev->dev);
 fail_of_entry:
-	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
-		if (of_entry->dev == &pdev->dev) {
-			list_del(&of_entry->list);
-			kfree(of_entry);
-		}
+	scoped_guard(mutex, &mfd_of_node_mutex) {
+		list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
+			if (of_entry->dev == &pdev->dev) {
+				list_del(&of_entry->list);
+				kfree(of_entry);
+			}
+	}
 fail_alias:
 	regulator_bulk_unregister_supply_alias(&pdev->dev,
 					       cell->parent_supplies,
@@ -360,11 +366,13 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	if (cell->swnode)
 		device_remove_software_node(&pdev->dev);
 
-	list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
-		if (of_entry->dev == &pdev->dev) {
-			list_del(&of_entry->list);
-			kfree(of_entry);
-		}
+	scoped_guard(mutex, &mfd_of_node_mutex) {
+		list_for_each_entry_safe(of_entry, tmp, &mfd_of_node_list, list)
+			if (of_entry->dev == &pdev->dev) {
+				list_del(&of_entry->list);
+				kfree(of_entry);
+			}
+	}
 
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
-- 
2.52.0.223.gf5cc29aaa4-goog


