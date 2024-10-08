Return-Path: <stable+bounces-82955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3BA994FB7
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB2B2223F
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0951DE4CB;
	Tue,  8 Oct 2024 13:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DVyZpqZY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B741DF279;
	Tue,  8 Oct 2024 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393994; cv=none; b=WtHEF2XPFWwPdWXnIBAW3bi9BBkMk1JBC9heRQaDx0SpfrDFN3VxFOPiwosjQxGBXPiagp2LbNd3uFBUOTZ+k2YXPWbZ1DxJ8FWTebaYfOJIcxJLRVXMW9WgKmVCuR52s1CcV0sCJqXFmwO63KSb0P07wLwRw1ZSx/1CS5MvjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393994; c=relaxed/simple;
	bh=tVexk1nnju/QyFiwjtzByPSseQIbr9UsWMs5kKcUYsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMDzHvHNlggM/TxjnGs87EZ3+s3IEaMq7oBMrsL0/l5vYur/EbPkbaDOArko8bI2ZDdTtdz1Xn8gqcqHrDbQWahcMZUd0heJevzeiUgBbS4nrq2E/Na6MnGte46tp9U1PkGg6ptA0rmkhYe1hVcrU9SW7JGnj7sfQQUqS37Gf70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DVyZpqZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312E3C4CECC;
	Tue,  8 Oct 2024 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393994;
	bh=tVexk1nnju/QyFiwjtzByPSseQIbr9UsWMs5kKcUYsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DVyZpqZY1ETXOEtHqygYtHViPnalTJiDQAJ483Q6gYuhh2f4sNVnl2ygm44dRAyJc
	 mgAS0tBhjEFpcj4rGqiepKwHyEXgvJXv47OsZ0zDNS/f/I0Llo6ITggb0gLgQWHbQR
	 667ctTrTaoTEzma9DP2OP8dyP9lQGYkWLKMrqdOI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiawei Ye <jiawei.ye@foxmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 6.6 315/386] mac802154: Fix potential RCU dereference issue in mac802154_scan_worker
Date: Tue,  8 Oct 2024 14:09:20 +0200
Message-ID: <20241008115641.782061456@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiawei Ye <jiawei.ye@foxmail.com>

commit bff1709b3980bd7f80be6786f64cc9a9ee9e56da upstream.

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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://lore.kernel.org/tencent_3B2F4F2B4DA30FAE2F51A9634A16B3AD4908@qq.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac802154/scan.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -176,6 +176,7 @@ void mac802154_scan_worker(struct work_s
 	struct ieee802154_local *local =
 		container_of(work, struct ieee802154_local, scan_work.work);
 	struct cfg802154_scan_request *scan_req;
+	enum nl802154_scan_types scan_req_type;
 	struct ieee802154_sub_if_data *sdata;
 	unsigned int scan_duration = 0;
 	struct wpan_phy *wpan_phy;
@@ -209,6 +210,7 @@ void mac802154_scan_worker(struct work_s
 	}
 
 	wpan_phy = scan_req->wpan_phy;
+	scan_req_type = scan_req->type;
 	scan_req_duration = scan_req->duration;
 
 	/* Look for the next valid chan */
@@ -246,7 +248,7 @@ void mac802154_scan_worker(struct work_s
 		goto end_scan;
 	}
 
-	if (scan_req->type == NL802154_SCAN_ACTIVE) {
+	if (scan_req_type == NL802154_SCAN_ACTIVE) {
 		ret = mac802154_transmit_beacon_req(local, sdata);
 		if (ret)
 			dev_err(&sdata->dev->dev,



