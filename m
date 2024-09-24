Return-Path: <stable+bounces-76960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E540983D6F
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 08:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617C82817B8
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 06:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A544B81745;
	Tue, 24 Sep 2024 06:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="FeRr9gCj"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDFE481B3
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727161096; cv=none; b=TIKzz5gMZr/nvxkW3DScKEPYwg5EBN9N3uD7CX+OY1j0BY23rpbMpcu9gwmdmJm7cbWvVpIpWsQZMeDcWJsHnqHTqIP6wQomK9tXo0b6TAraVDhCEOY3ylzirD/QPxeLM1NVlzPNewkUNcgsdtu1z8AU4tkt7k0rCsII5k1sgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727161096; c=relaxed/simple;
	bh=7PqOZ2exGA950VzYSvAYI+wOZWeCtIvMo1PDwY6ibqM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=JWw+IjFO3Gma5xfu3WHGjMtiviqnADJFS7xghZHiKb96Pe21USrpy+hQtPlhU4BP6idg/WReA/3K1yq9eTDZKsQjAtID3EH/h59iNIYtVsTCd04oQt03BsetxVOKQmw5jS0JrTN866xQedEItqHwvi/bOcTkIv+8wkP8AAsI4og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=FeRr9gCj; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1727161089;
	bh=6nLDi1GI6gjWb57haYeBALrQCo0jbnuR0Q8IBtjPb6k=;
	h=From:To:Cc:Subject:Date;
	b=FeRr9gCjqrj5bZPk35yoEAxkwlOvcX7uX+gLl1xTaYPf07MyaB0vManyBOmf8U4vD
	 o6yl2+gTDqBzWpMJSirOAcVCsUKWjyT+xNGhUYH73woxkFmB0IMN3n05yM62kKoZmC
	 aQz2d9JQc71/bRkyskBfxa1vmsdO3u2aayxzSo8c=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id E851F86C; Tue, 24 Sep 2024 14:58:05 +0800
X-QQ-mid: xmsmtpt1727161085tvessbuja
Message-ID: <tencent_3B2F4F2B4DA30FAE2F51A9634A16B3AD4908@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8h3BDT/nk5cUn7vudnWTLFitphfOtfD6IgKl+cJ+ovaa6iG8p6x
	 u+9PxjL2EYRBujeEJYANg9ACEaBBZprTnzje/UDCUqlsiLe/fxLnatFS2lUqJM8ZF1/UUn5js2Pe
	 sblq3oqoclwq1OsoSv+6Byh1CY3Jy5vUeHO2pGqiC0DtjuIGqkrPhpkn8spukHU9EuXbdYpA8M0o
	 jrd9Y5pUunzeOlVj3aGnufkqxrXptsDk6Tfa0lJy9SBkZKnisSOfaFQFGy95tTUhszHYSlwrIPgs
	 z/YzdagMwRMyDDa0LkKcqz1GRRoJIBX5E9G6QqUV2RXNZ+qddG9nDamuhiShWbjeX6w6+V08auIR
	 AnL6u1GKyDkS13c3BVvdzdXUnSfhzlY2YnlMHkKW8t35rVzJTQHvPxLlhjgKZ+WPl1A+2BTlCTQI
	 2mAqGE6xb4VOLzRDo7xz6F8v1ClJqYhJ/B+Uy+MyEP0BZiIv1/4ni3Wj6fwe5xV1mLWpTYZX0mzk
	 4aYwRlLONT6NbPXHbwW9+mNRkOC/8PlYsBqgJV/43ejcUBpAlbz2e14MyBaKJpfeiT3nWlkrVRWG
	 CR9bzAhaH0bT+HbL2GMH+Q3+voNGdJOyr/mW1hWYA7tvnAcmmVR4hqDQvc0an/Catvnf94xwP5s7
	 Oh+8xy/xxdOnQPdeixZkgWZ0jSPelSf8zvc3NzVBDdfiPyhfqBWOaGicGWhShS044QoJ9M1Rg+RY
	 0CruCcraxzimgC4dpMjpk55TzvLFl6IL+TvoFteNO5YfBCMC5k6KOaJH+9s69WVevTg356oZxtPZ
	 hOqv/qUFgqWB2Xiu+Lv4cdFmqnGIDW5HCnAL3MHbDhM1zXEnMli3kfZ3v/QSGoDCymTuz+CBtAys
	 p1a6B/Udcy6u62POmvPMVO1bcLQ+q1S0d2eohdrw4IGoXaTP02jfvaqu6dBeTnI7OiH+gprhY+j5
	 ZF25raOutUklObzxc8MnTvyGkp87m4+hj3+lGYuAOCxh1yQ3mRdgHoV6kCVSzCSBi0ccBj9/HLQp
	 6MLXYsPwN2A0JbMfVViMjhkoVTGeo=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: stefan@datenfreihafen.org
Cc: alex.aring@gmail.com,
	davem@davemloft.net,
	david.girault@qorvo.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wpan@vger.kernel.org,
	miquel.raynal@bootlin.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v3] mac802154: Fix potential RCU dereference issue in mac802154_scan_worker
Date: Tue, 24 Sep 2024 06:58:05 +0000
X-OQ-MSGID: <20240924065805.2106689-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the `mac802154_scan_worker` function, the `scan_req->type` field was
accessed after the RCU read-side critical section was unlocked. According
to RCU usage rules, this is illegal and can lead to unpredictable
behavior, such as accessing memory that has been updated or causing
use-after-free issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this, the `scan_req->type` value is now stored in a local
variable `scan_req_type` while still within the RCU read-side critical
section. The `scan_req_type` is then used after the RCU lock is released,
ensuring that the type value is safely accessed without violating RCU
rules.

Fixes: e2c3e6f53a7a ("mac802154: Handle active scanning")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changelog:

v1 -> v2:
- Repositioned the enum nl802154_scan_types scan_req_type declaration
between struct cfg802154_scan_request *scan_req and struct
ieee802154_sub_if_data *sdata to comply with the reverse Christmas tree
rule.

v2 -> v3:
- Add Cc stable tag and Acked-by.
---
 net/mac802154/scan.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index 1c0eeaa76560..a6dab3cc3ad8 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -176,6 +176,7 @@ void mac802154_scan_worker(struct work_struct *work)
 	struct ieee802154_local *local =
 		container_of(work, struct ieee802154_local, scan_work.work);
 	struct cfg802154_scan_request *scan_req;
+	enum nl802154_scan_types scan_req_type;
 	struct ieee802154_sub_if_data *sdata;
 	unsigned int scan_duration = 0;
 	struct wpan_phy *wpan_phy;
@@ -209,6 +210,7 @@ void mac802154_scan_worker(struct work_struct *work)
 	}
 
 	wpan_phy = scan_req->wpan_phy;
+	scan_req_type = scan_req->type;
 	scan_req_duration = scan_req->duration;
 
 	/* Look for the next valid chan */
@@ -246,7 +248,7 @@ void mac802154_scan_worker(struct work_struct *work)
 		goto end_scan;
 	}
 
-	if (scan_req->type == NL802154_SCAN_ACTIVE) {
+	if (scan_req_type == NL802154_SCAN_ACTIVE) {
 		ret = mac802154_transmit_beacon_req(local, sdata);
 		if (ret)
 			dev_err(&sdata->dev->dev,
-- 
2.34.1


