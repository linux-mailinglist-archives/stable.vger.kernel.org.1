Return-Path: <stable+bounces-224051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPyyIGP+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F6824A68F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53D2F31F2381
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49875386425;
	Tue, 10 Mar 2026 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StzmQk0r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB44352C4F;
	Tue, 10 Mar 2026 11:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141185; cv=none; b=Hs0xHLAnB+8j6Zm/tPR+iFgf/jwNOaIdThyVyoeiOhUEeOneGS7A7AFMZYOxDGTqUAQo9fNSgqwNgoEdYahkr7HZfDlFj0iCwzDmGCHfIYJ2b/1cmOmZec5ejx7brAdBC/dI1xLZl3yhRRA+5TWXqgvN0De9Z1CkIghP3irWvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141185; c=relaxed/simple;
	bh=02ia4o4fo5jA3M5Jc9DNnw0fyDtdZOZ+MyxiUUBSKdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulSjAYn93jx8rLUzk/uypwCN+V6/k/5jIZNXuzjUizP4ROKS9KZoqKSEldDiC+yFEhjb/HXiDPDIt4f77eoGtJLA+FXHCCGGTcCOn/JN3Gs5s1p6u8Rf/W45CiSd9JxaPw4hTKx38hREQVfmZZyhooThZ1SAXbcdaEMfEwal5bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StzmQk0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58969C2BC86;
	Tue, 10 Mar 2026 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141184;
	bh=02ia4o4fo5jA3M5Jc9DNnw0fyDtdZOZ+MyxiUUBSKdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StzmQk0rFSGDv4puegVRsA7cwIlrMNXUEscI7OD9Hc+rdeVtD+090oL3/+LWs5VU/
	 MzUooc4AprRrRXVpLPaTNG60tvnxWNO3H14jkY4AnyPo4Ca1LXgFt3jc4EdXBcJqek
	 ed7qrxjtKqxF9Of+cg2XNyQ6VOCkvUTiXoggPUPPP/mpXu/KhB5jklW0e/yRd0PAYH
	 PKrmVXUoPcF5XQst44+elymPOmCqe+a4bCeObRBgv0g14CbcVe9fTQ6gXUnUWeuHH5
	 DxV3SllQISKP/enBgrLOm9BkWs1xkCoMbZZxY7aBI2ZV5/4ahZKzX9RqSvh8/eSkjY
	 7GQJo4WosyscQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 186/311] HID: multitouch: new class MT_CLS_EGALAX_P80H84
Date: Tue, 10 Mar 2026 07:03:53 -0400
Message-ID: <588add0440e7515205978449902721cba045cc2d.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E7F6824A68F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224051-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,gehealthcare.com:email]
X-Rspamd-Action: no action

From: Ian Ray <ian.ray@gehealthcare.com>

[ Upstream commit a2e70a89fa58133521b2deae4427d35776bda935 ]

Fixes: f9e82295eec1 ("HID: multitouch: add eGalaxTouch P80H84 support")
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index dde15d131a73e..b8a748bbf0fd8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -235,6 +235,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_SMART_TECH			0x0113
 #define MT_CLS_APPLE_TOUCHBAR			0x0114
 #define MT_CLS_YOGABOOK9I			0x0115
+#define MT_CLS_EGALAX_P80H84			0x0116
 #define MT_CLS_SIS				0x0457
 
 #define MT_DEFAULT_MAXCONTACT	10
@@ -449,6 +450,11 @@ static const struct mt_class mt_classes[] = {
 			MT_QUIRK_YOGABOOK9I,
 		.export_all_inputs = true
 	},
+	{ .name = MT_CLS_EGALAX_P80H84,
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_IGNORE_DUPLICATES |
+			MT_QUIRK_CONTACT_CNT_ACCURATE,
+	},
 	{ }
 };
 
@@ -2233,8 +2239,9 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C000) },
-	{ .driver_data = MT_CLS_EGALAX,
-		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
+	{ .driver_data = MT_CLS_EGALAX_P80H84,
+		HID_DEVICE(HID_BUS_ANY, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002) },
 
 	/* Elan devices */
-- 
2.51.0


