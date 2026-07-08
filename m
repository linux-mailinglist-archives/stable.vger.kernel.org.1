Return-Path: <stable+bounces-272683-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zKlgLUd3TmpHNQIAu9opvQ
	(envelope-from <stable+bounces-272683-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:13:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C67D728871
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:13:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RHnPqqJZ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272683-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272683-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E57B9331011D
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2D4409285;
	Wed,  8 Jul 2026 15:49:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1103B41735F
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:49:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525742; cv=none; b=mLbhqCwfCaLxZafCOzAJJMPuOS4GgUmt7zQVgscGAtHnRaViuw9IiUYzD0ymeyJJSpGXmMB2JfJZ2jCXIedXOyqVeqPnAvzDPfYbv1Js/DGtu2c4bkT/jwWiW/9UPR2clhjhTMir8Wq90Tv8wCtQrm0f5Rde+G7YcPTz7/TBtB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525742; c=relaxed/simple;
	bh=4NG8zneOYe7p0UrTp9P9R7HnMyKE7GyM9DN8ppk6JVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo5vurQpR9V7Mq6vkQ7tk7x1AWw4n0WICoIv+5eWj2nEh7hQUJ0gWvuW4xqCBScTiqNwq6ZqfMiXDLdUJ/i5TyGrkrHB56ctSFSCv5xS99FMuk2SzBgtDw7w/KQl64XDgih48brLIEpljTuT7hvteXrXypcwVeDdS204U5vP8Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHnPqqJZ; arc=none smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698b558a792so1043983a12.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783525739; x=1784130539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMhE6Jch/T1UvoknEZxvYaZzdpc2xBp5cw8Z7tMZGzI=;
        b=RHnPqqJZoenkw9rgfcxvey6riVEQ0Mw/Fe3+usArOtXO8EQotDJIZRr+uVAaOkYRhl
         wJFIqs6f+HphBy7JzeLwgv7l0f/VoG+R0h+w/o4gV970HENwUlEj2YA9d8klESOuNoCC
         JN5oc6NTu2dFkagMtChC+jiEqkhdfbxWTCYNeWFJ5CdQ3vUWoZ1H3iRz32bSngEbTuNH
         eh7NqLUBIvljkS8M6z5m8LLkhsfECkxz4yoT/1qnOO+gPKmdqMIYXOh8vwwof/8GwmhT
         hk3aW/PtrDGmn1YeCeLAQs1dUZgdcy5qhyF8h/1tCCR48c7gNSr7JyABXIpFuwfr7HyX
         oYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525739; x=1784130539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMhE6Jch/T1UvoknEZxvYaZzdpc2xBp5cw8Z7tMZGzI=;
        b=a3DbXB36urQlK6pWeWdp63LTMZBCPtum6JgleibRyGp7PPTsbld+uqKskv/gJEht1S
         IWSxYfL6Wh4EbNwkPIhjRR0EIHXB9BtN8i7VejHmYpuuT0M8ATYHhySfvfdGQfkxM63G
         AUSBEqddy/13Rtl18tF5DNbDvgaxc2xCwy7jCDHWg2THz9SymGAeYlO4jnMQ11IPhTJ+
         7wEcVzX8uRMbW9fSHRMqonTVJUcsEIWU5sut60VYbr2dMUmuIJeNvQmGmD/oLpeKA186
         W5LjcHlKf2hiMKCo6Ceo46hCC7mIbSuciz8sWHyhDNmiZd2z6/PsNWxKvGIEVPVFaKMZ
         zdIg==
X-Gm-Message-State: AOJu0Yza15iNapQ5lqYI6+J9w67fSUsSja679Vj86a//DxD3OpBEjmOY
	Zd0dEFF65BeM28lIjdONLM4Zg7feox+QqTGEIMqQmTSRDYoNtDUbYXaT
X-Gm-Gg: AfdE7cmGbvrzQzs81LaTzxpub91bNnh7UWS/erovKh+JMP/aSLhn9XtO2sk8eSg3vyo
	nlHHuL9EyB4P1+qJZcBwtsor0msbGRRAjam4ZAkEfMr0bZbNQYy2wbvY/6Z9ziRzltvvSC7uimQ
	EU/rmErYSPXh+q/ZeDCh1ISmn3JgSeJBgaCzPD2XJy1QkiiWqPApG1iWc6YQSy8NPRwCZXXs6mI
	HKv9bo9QyBppX1Q3xe7DJc96VsdeMf9oNA7cpQGqmBXXdB+d/oWpcSdHelCdY8C8VuqdEBe3B3T
	a2ZJyNRCLHD805IRg8hTqUm/87rzopBY9mcjPhWv1aaOgzx1GBIja7KufisPpToLHaPy44cGXMN
	B8LpySvgvhfGaC6EaUn0MbDgCqBlQ8oIzBvZW6u2Cn4XnbP+CKVWZnrKBzhZsxDkMQWdp2JuRUf
	tKX0sqZYbWRdDpiTeOxjgMLKUtyzXIUTd2dtJr+wtWAo79XIBNgnDY+DOYIBFRtx7r//fX4eFth
	A==
X-Received: by 2002:a05:6402:449b:b0:698:c11b:b180 with SMTP id 4fb4d7f45d1cf-69ab44534bamr1247834a12.3.1783525739146;
        Wed, 08 Jul 2026 08:48:59 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69ac41d7ceesm945125a12.23.2026.07.08.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:48:58 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jorge.lopez2@hp.com,
	linux@weissschuh.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	Armin Wolf <W_Armin@gmx.de>,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH v4 3/4] platform/x86: hp-bioscfg: accept reduced ACPI packages from older HP BIOS
Date: Wed,  8 Jul 2026 20:48:44 +0500
Message-ID: <20260708154846.12356-4-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708154846.12356-1-meatuni001@gmail.com>
References: <20260708154846.12356-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmx.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272683-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hansg@kernel.org,m:ilpo.jarvinen@linux.intel.com,m:jorge.lopez2@hp.com,m:linux@weissschuh.net,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:superm1@kernel.org,m:W_Armin@gmx.de,m:meatuni001@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C67D728871

hp_init_bios_package_attribute() hard-fails when a WMI ACPI package
contains fewer elements than the type-specific expected count (e.g. 11
elements instead of 13 for INTEGER or ENUMERATION attributes). This
causes the entire hp_bioscfg driver to skip attribute enumeration on
older HP hardware whose BIOS returns shortened packages when optional
fields like prerequisites or possible values are absent.

Observed on HP EliteBook 840 G2 (BIOS M71 Ver. 01.31):

  hp_bioscfg: ACPI-package does not have enough elements: 11 < 13

The element layout has two tiers:
  - Elements 0-9 (SECURITY_LEVEL+1 = 10): common to all attribute types
  - Elements 10-N: type-specific (bounds, values, encodings, ...)

The per-type populate functions (hp_populate_*_elements_from_package)
already handle sparse packages correctly via their own elem < count
loop guards and inner-loop bounds checks. The only unsafe case is when
we lack even the common elements needed to register the attribute.

Fix by introducing COMMON_ELEM_CNT to mark the hard minimum (10), and
splitting the check into two tiers:
  - Fewer than COMMON_ELEM_CNT elements: hard fail, can't proceed.
  - Fewer than expected type-specific elements: warn, but let the
    populate function parse what is available.

Fixes: a34fc329b189 ("platform/x86: hp-bioscfg: bioscfg")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 11 ++++++++---
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 768330d291da8..78019644ec358 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -661,12 +661,17 @@ static int hp_init_bios_package_attribute(enum hp_wmi_data_type attr_type,
 	int ret = 0;
 
 	/* Take action appropriate to each ACPI TYPE */
-	if (obj->package.count < min_elements) {
-		pr_err("ACPI-package does not have enough elements: %d < %d\n",
-		       obj->package.count, min_elements);
+	if (obj->package.count < COMMON_ELEM_CNT) {
+		pr_err("ACPI-package is missing common elements: %d < %d\n",
+		       obj->package.count, COMMON_ELEM_CNT);
 		goto pack_attr_exit;
 	}
 
+	if (obj->package.count < min_elements) {
+		pr_warn("ACPI-package has fewer elements than expected: %d < %d, parsing available elements\n",
+			obj->package.count, min_elements);
+	}
+
 	elements = obj->package.elements;
 
 	/* sanity checking */
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
index 416d7e7aaaae3..ac57d6eab4c35 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.h
@@ -279,6 +279,9 @@ enum hp_wmi_data_elements {
 	PSWD_ENCODINGS = 13,
 	PSWD_IS_SET = 14,
 	PSWD_ELEM_CNT = 15,
+
+	/* Minimum elements shared by all attribute types (NAME..SECURITY_LEVEL) */
+	COMMON_ELEM_CNT = SECURITY_LEVEL + 1,
 };
 
 #define GET_INSTANCE_ID(type)						\
-- 
2.55.0


