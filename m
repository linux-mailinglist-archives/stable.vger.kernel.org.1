Return-Path: <stable+bounces-224392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEAeLLsDsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:42:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 468D024B621
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55D1A31C9761
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE73A4525;
	Tue, 10 Mar 2026 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy/KkJ9l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52953803CD;
	Tue, 10 Mar 2026 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142124; cv=none; b=q9Z29hQv1bcnAdn8WrxRYyUsus+II8EgjUvU2tqGBFmRZiJqc7ohq1d5N44I9GgJ6cj+BR+wokyT590UB2SVQ33ac58LBCAHu5UR63xwkOO8qogzRv2mAxL6WYuWD76D6OZS7sqqAyIr1KAXumZdbeewFSQ1137+EFch3H0ZVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142124; c=relaxed/simple;
	bh=86cuy5bsOsXmi7He/wJYNm2GpTCDTH3NKeX6iSgsT5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9oJmyR4+kOBls39pUk06cj45i64bSfGgw1ecA0a0MqjvlMNbvt0rZkJRjScm6ZqFBS6XAeU1DC//57oE+CLNczR5eB5fEn4GsXMS0kpcsFpVdgoWrdwUULCNwXzUccSD3ToVvDGbFVk1h2vWgnPXLhoIjARRVpQfVU+e68X8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy/KkJ9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26874C2BC86;
	Tue, 10 Mar 2026 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142124;
	bh=86cuy5bsOsXmi7He/wJYNm2GpTCDTH3NKeX6iSgsT5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jy/KkJ9lRdW8fEJFN3tUzyp0daqtukqEbpIpjISRDzCsIbtE/7DV8WL37SCvJCLcS
	 fBB2QB4j8B2JpjRQBs32ogF5WqZKNp4gcyw+mcnT6vsP2mgd3ctSIeOR5vM3qGXiEf
	 9/rKnkNAovikrBXVckSCgTo0d7knPLx/QFHkoPEo8UULXflkxGffN1QdA8NjvsJqAB
	 /5E1vTshDdt3YwO3ct3iwaXE8QZ1qUBqS76zBOfFloh3bCLRaltE1BZURTmIjBKc1W
	 /0vRkXLdTuWWKK8PYLdO9lHlrBnCmaFeRJEKhFNw/GVqLvmG4tnh+ZhfVq7JkXzkp5
	 vFp1EUdyYNSTQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 213/314] HID: multitouch: new class MT_CLS_EGALAX_P80H84
Date: Tue, 10 Mar 2026 07:17:52 -0400
Message-ID: <79b0dec3b975b5dfde4df6e76701ac1bdfc793a0.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 468D024B621
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224392-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gehealthcare.com:email,suse.com:email]
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
index 1f8accb7ff435..af19e089b0122 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -233,6 +233,7 @@ static void mt_post_parse(struct mt_device *td, struct mt_application *app);
 #define MT_CLS_SMART_TECH			0x0113
 #define MT_CLS_APPLE_TOUCHBAR			0x0114
 #define MT_CLS_YOGABOOK9I			0x0115
+#define MT_CLS_EGALAX_P80H84			0x0116
 #define MT_CLS_SIS				0x0457
 
 #define MT_DEFAULT_MAXCONTACT	10
@@ -447,6 +448,11 @@ static const struct mt_class mt_classes[] = {
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
 
@@ -2223,8 +2229,9 @@ static const struct hid_device_id mt_devices[] = {
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


