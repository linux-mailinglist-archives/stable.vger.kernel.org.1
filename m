Return-Path: <stable+bounces-9607-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A98823437
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 19:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52E62B21D00
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471D71C68A;
	Wed,  3 Jan 2024 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w0J+NpZV"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F27F1C692
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 18:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rdbabiera.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee11c69bb8so116815457b3.2
        for <stable@vger.kernel.org>; Wed, 03 Jan 2024 10:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704305891; x=1704910691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hkEKCd3hfJt11nDh66LSbCsxJT+mibJ96mLmzkQOVZU=;
        b=w0J+NpZV4f14GEvQaykiXt+kcCYd8gBvEjzZGRuZSFP9MPnOHN496zy/XqJHUscLgV
         oia5ognNoWTz1u62YOI+ORC8oewrqTASxk48s8KE5v65V7BIhwcBHCYzG7DISh3OJOFL
         Fsc//byuEtGHyMiquZMGfVcJ2ugDYlORO+cRJGEEpi3oMC/OY1Hs/ReIqgRbsFuA9HxX
         PVA+b3oaQIWaNmbafBz7q9ETl1BjuBnF1OrxXT1W7FxS464ln6T4A4XV/7Gc+I8WMspK
         lhWzZhjA/1QLQom96jwoR7etWhQ0IFhqPlStXTu6t9jXz8TwFlnNCS9ua3aTOHPgRR6V
         d1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704305891; x=1704910691;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkEKCd3hfJt11nDh66LSbCsxJT+mibJ96mLmzkQOVZU=;
        b=Yj3PvWqncdWdZvyrPx1jctq3p17ibPg4f1OMUUUrr2A2IxFwnHP7dfdO59Dex0ywYZ
         gdgmbGchMs0sLykIBYLtHHr2SgjeJv7HST6+UUZnul1Yx45zKOppH1jHEdAOYlTneL1C
         Jo3SnQPASpXWepY+71oxjNA4hvWUHoaV2I+VZOemFpe8eLDlihhXCbIaSB2sTeRGQJJp
         LUjhxvZESUDDx9evb3enHhS0cx30sEb8EunoCCVdLdVNXkxZEJk08mwq0LkTNaLJBfZN
         BW/vwoY2x+4Vogm4Wr1BPVV60NLxXqX7EJbWDCTmbzkmdwIrXalsj7WkM+/rDUVAcdgT
         bXrw==
X-Gm-Message-State: AOJu0YxtDVEDfPsrE7MmRIaMfzL8jOuga3y5LI2dvuz+hba0slPdbegq
	kKKbhcZ2dwmIWmJ2H/kRkGmmbsvhhVyVbUgkimNiCg==
X-Google-Smtp-Source: AGHT+IFPjMb17ktehTSQ5NY3znE/uBD/7sluSbUuieDlJgR51oh9RcB1qZ79Nw2YFuu2jw1b6VwzfUVXIsDpTyc=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:3615:0:b0:dbe:4fc2:d6ef with SMTP id
 d21-20020a253615000000b00dbe4fc2d6efmr3752440yba.12.1704305891319; Wed, 03
 Jan 2024 10:18:11 -0800 (PST)
Date: Wed,  3 Jan 2024 18:17:55 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399; i=rdbabiera@google.com;
 h=from:subject; bh=oBFeip/LM4aBno41GVoLnDbWo+8hqDg3PdImBIJkdSA=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKlTl1zKfd5xQdj/ksQzXfbVqdK3Es3Vp5/Tl9rTl8G07
 rmJnO6ejlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACby6TAjwyfel1y7H67XveLW
 uT94+VGvSS6FM9cyNS467xLsEp/6di0jw7bdh+4x92RkSU8z7X35e/VMbwmDBHWZF+u/fLz1+qC BDD8A
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240103181754.2492492-2-rdbabiera@google.com>
Subject: [PATCH v4] usb: typec: class: fix typec_altmode_put_partner to put plugs
From: RD Babiera <rdbabiera@google.com>
To: rdbabiera@google.com, lk@c--e.de, heikki.krogerus@linux.intel.com, 
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When typec_altmode_put_partner is called by a plug altmode upon release,
the port altmode the plug belongs to will not remove its reference to the
plug. The check to see if the altmode being released is a plug evaluates
against the released altmode's partner instead of the calling altmode, so
change adev in typec_altmode_put_partner to properly refer to the altmode
being released.

Because typec_altmode_set_partner calls get_device() on the port altmode,
add partner_adev that points to the port altmode in typec_put_partner to
call put_device() on. typec_altmode_set_partner is not called for port
altmodes, so add a check in typec_altmode_release to prevent
typec_altmode_put_partner() calls on port altmode release.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Cc: stable@vger.kernel.org
Co-developed-by: Christian A. Ehrhardt <lk@c--e.de>
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Changes since v3:
* added partner_adev to properly put_device() on port altmode.
---
 drivers/usb/typec/class.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 4d11f2b536fa..015aa9253353 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -263,11 +263,13 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 {
 	struct altmode *partner = altmode->partner;
 	struct typec_altmode *adev;
+	struct typec_altmode *partner_adev;
 
 	if (!partner)
 		return;
 
-	adev = &partner->adev;
+	adev = &altmode->adev;
+	partner_adev = &partner->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -276,7 +278,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	} else {
 		partner->partner = NULL;
 	}
-	put_device(&adev->dev);
+	put_device(&partner_adev->dev);
 }
 
 /**
@@ -497,7 +499,8 @@ static void typec_altmode_release(struct device *dev)
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	typec_altmode_put_partner(alt);
+	if (!is_typec_port(dev->parent))
+		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);

base-commit: e7d3b9f28654dbfce7e09f8028210489adaf6a33
-- 
2.43.0.472.g3155946c3a-goog


