Return-Path: <stable+bounces-3177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B00E7FE044
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 20:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB741C20B05
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 19:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE95DF3B;
	Wed, 29 Nov 2023 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2J163aE8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76057D66
	for <stable@vger.kernel.org>; Wed, 29 Nov 2023 11:24:10 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c941936f7fso10354017b3.0
        for <stable@vger.kernel.org>; Wed, 29 Nov 2023 11:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701285849; x=1701890649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nbRm4suVWbGsrLER/c9C6n/j7Z59bcCi6w3YIA8nGRc=;
        b=2J163aE8jjyj0sr3zrcjukKraBevaXgTTOisII0DUqXCwcJgbVAm8Id2McJt+QKNEe
         3AxNz/xo1ka2x9YeOuuYZaaFxaqBePbRHqvTek4BRjbsrJkW1lOAaMZEsu2mrJsqh+NL
         o6orkRdif1g2GtDdSLZINZHBKr2f3mRBs7Xz06ALgQdsr7Sv7jWIQrU2kJq14Mkga1pA
         Cs9PTMwspjScCZRQ9cq15byNA8tXAmhZKoqR32QEPTifByqKBxXt0tGjzOPcSfYsZQQI
         YZlFgwsOS76aEnXGW9c1JemvAl9pxjRqzC28Q/NjpkBouoyJdGB5wWvC0x7/AQorfs5X
         0z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701285849; x=1701890649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nbRm4suVWbGsrLER/c9C6n/j7Z59bcCi6w3YIA8nGRc=;
        b=t5/D1Rko2Kd8xoj4DDS2W2r0OZQ7iMYaGWtityFcLqA/Fdz9GBOAeGzPrN5LK/MU0m
         0ing8gbLkIvmOFClKdFvAhsOOxzPBF70dngtoCWC/KNKQ+rpNUYmr5hN+RchoQqstzig
         MVxCDl+0f/u2YA139k/g8YA8bY9QJctMg/8lk3oYfvJkkSDJoF36Tez+fM6mbAGT1woE
         8iqA6k7K4W8DHBuiTCIN/AvtAlw1QhM6nnuQCo81OvWdzucfXrO+KEdKHC8jHuH4uNaN
         g0XT9IrLi8iMUSss92x9unLSggaE21WsCoFO0HWEOoMx69rIpo68sDvWcSIwstEr7K/K
         qXEA==
X-Gm-Message-State: AOJu0YztGhxdH/GnbBq/LvuVDRFl6OXFdCDp8hCCA63kgwzMjv/iVBQV
	fAKYRksCK6GiYczBHnI7nBe4+xD4Dx0TRlA=
X-Google-Smtp-Source: AGHT+IGUV2ky/TT9mGRYJ5pFVrh0jASDhJCBwvPWpjpt765Xg0YWTSmEZ4rYKzsMus2sqZK7XZEPar97Iz/z6uI=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a81:fe03:0:b0:5c1:4b36:85bf with SMTP id
 j3-20020a81fe03000000b005c14b3685bfmr805785ywn.1.1701285849740; Wed, 29 Nov
 2023 11:24:09 -0800 (PST)
Date: Wed, 29 Nov 2023 19:23:50 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=rdbabiera@google.com;
 h=from:subject; bh=zyy9vTRp0NQrUD3/z05jR9WXsk12rtwCGm6eizGKGaM=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKnp/Uf1mm2Z7pxYbhr7MqNxfdfdL3POX+H3rL4WuD7xY
 dyinDSXjlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACbi5szI8GjjmS8hl0J9volM
 2PR14dd95032SSRde1B8kPne2XkeOg2MDNNsjjJniLzf01z3UYYv1vV86+uJ+Z6xUbJ1/CueHA8 NYwMA
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231129192349.1773623-2-rdbabiera@google.com>
Subject: [PATCH v3] usb: typec: class: fix typec_altmode_put_partner to put plugs
From: RD Babiera <rdbabiera@google.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, badhri@google.com, 
	RD Babiera <rdbabiera@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When typec_altmode_put_partner is called by a plug altmode upon release,
the port altmode the plug belongs to will not remove its reference to the
plug. The check to see if the altmode being released evaluates against the
released altmode's partner instead of the calling altmode itself, so change
adev in typec_altmode_put_partner to properly refer to the altmode being
released.

typec_altmode_set_partner is not run for port altmodes, so also add a check
in typec_altmode_release to prevent typec_altmode_put_partner() calls on
port altmode release.

Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
Cc: stable@vger.kernel.org
Signed-off-by: RD Babiera <rdbabiera@google.com>
---
Changes since v2:
* Moved changelog under "Signed-off-by" tag

Changes since v1:
* Changed commit message for clarity
* Added check to typec_altmode_release to only call put_partner if altmode
belongs to port partner or plug
---
 drivers/usb/typec/class.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 2e0451bd336e..16a670828dde 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -267,7 +267,7 @@ static void typec_altmode_put_partner(struct altmode *altmode)
 	if (!partner)
 		return;
 
-	adev = &partner->adev;
+	adev = &altmode->adev;
 
 	if (is_typec_plug(adev->dev.parent)) {
 		struct typec_plug *plug = to_typec_plug(adev->dev.parent);
@@ -497,7 +497,8 @@ static void typec_altmode_release(struct device *dev)
 {
 	struct altmode *alt = to_altmode(to_typec_altmode(dev));
 
-	typec_altmode_put_partner(alt);
+	if (!is_typec_port(dev->parent))
+		typec_altmode_put_partner(alt);
 
 	altmode_id_remove(alt->adev.dev.parent, alt->id);
 	kfree(alt);

base-commit: 24af68a0ed53629bdde7b53ef8c2be72580d293b
-- 
2.43.0.rc1.413.gea7ed67945-goog


