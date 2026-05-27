Return-Path: <stable+bounces-254624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNwkOUsYF2px3wcAu9opvQ
	(envelope-from <stable+bounces-254624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:14:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 179CF5E78D5
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 860A73006983
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F3B38237B;
	Wed, 27 May 2026 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh7ICbeq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3433803D9;
	Wed, 27 May 2026 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897935; cv=none; b=k6vMpyJGECG5vc/ZKGExDd8tQSAV6F8x9uW0QyDnGp+zDDbuDuhWhAOYEMAAe4DXKoBboKXPImtGzroaHyHNK+I6XgGPQngjTUzkObpRedyfV9VujDarH0C0ktTXxKJ+7p0Uns1jNjyWhnDUvOQ3NsxjWZM6Jr9k5gx/orvbhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897935; c=relaxed/simple;
	bh=7A26relehPP5yXuYTa/eKUcVIk48lZzFsBmv8uoH9YE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJnULnxApRfrqc1bHC4heA3Z4/zlbkUM0z7+DqlTROLg/D9sU1kk1RUOJVRKHfk+Gqn+4GQmyLi6TO9j49jwMd2htqBQR/WoPIP9uT9s91D6Kfou6nvwQhkeCO80Jv1/GQjHjtPFFupbCNMccwXM5XPvFMOYPg8t5Pb5wcJkt2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh7ICbeq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A991F000E9;
	Wed, 27 May 2026 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779897933;
	bh=uOez9Z9nCz/wnIU41bFx3NdD9heAW+QrcuBmq2VO+ho=;
	h=From:To:Cc:Subject:Date;
	b=Kh7ICbeq1iqJ+GyGgrsMuu1+7jFKaYieMmgZdQFe7LlpPFX7U+XjUUe80+dJ1Eeig
	 dU29Z2YXaC0Q0NRxdmYPle7S6BOwHOAht8pOgTK6ttIB/sBnGoEic500J9ev+p3E3y
	 PaPIEfUZofU6IHqj/kTerqa2yDKWGLn91C40Qvwu7/3+tF8rjHnx2uX27KIz/5pacC
	 bd80znqH/Dj5Z5vR7Lr5Yeyzgyd1KOg9OOH1JobJPJ18mI+AmY4UbpZ4jBAHnbl2kV
	 O/3sp++QAsAYSkV9xBZQFEaYqnichpikJQeei1lzphcEnXVPp6CFFvtl7kNUtSDoLH
	 DCghzCftp/xkw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [RESEND 1/1] HID: wacom: Fix OOB write in wacom_hid_set_device_mode()
Date: Wed, 27 May 2026 17:05:26 +0100
Message-ID: <20260527160528.847928-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254624-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wacom.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 179CF5E78D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

wacom_hid_set_device_mode() currently assumes that the HID_DG_INPUTMODE
usage is always located in the first field (field[0]) of the feature report.
However, a device can specify HID_DG_INPUTMODE in a different field.

If HID_DG_INPUTMODE is in a field other than the first one and the first
field has a report_count smaller than the usage_index of HID_DG_INPUTMODE,
this leads to an out-of-bounds write to r->field[0]->value.

Fix this by storing the field index of HID_DG_INPUTMODE in 'struct
hid_data' during feature mapping.  In wacom_hid_set_device_mode(), use
this stored field index to access the correct field and add bounds
checks to ensure both the field index and the value index are within
valid ranges before writing.

Cc: stable@vger.kernel.org
Fixes: 5ae6e89f7409 ("HID: wacom: implement the finger part of the HID generic handling")
Tested-by: Ping Cheng <ping.cheng@wacom.com>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/wacom_sys.c | 13 ++++++++++---
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b351e3..2220168bf116 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -356,6 +356,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 
 		hid_data->inputmode = field->report->id;
 		hid_data->inputmode_index = usage->usage_index;
+		hid_data->inputmode_field_index = field->index;
 		break;
 
 	case HID_UP_DIGITIZER:
@@ -571,9 +572,14 @@ static int wacom_hid_set_device_mode(struct hid_device *hdev)
 
 	re = &(hdev->report_enum[HID_FEATURE_REPORT]);
 	r = re->report_id_hash[hid_data->inputmode];
-	if (r) {
-		r->field[0]->value[hid_data->inputmode_index] = 2;
-		hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+	if (r && hid_data->inputmode_field_index >= 0 &&
+	    hid_data->inputmode_field_index < r->maxfield) {
+		struct hid_field *field = r->field[hid_data->inputmode_field_index];
+
+		if (field && hid_data->inputmode_index < field->report_count) {
+			field->value[hid_data->inputmode_index] = 2;
+			hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+		}
 	}
 	return 0;
 }
@@ -2846,6 +2852,7 @@ static int wacom_probe(struct hid_device *hdev,
 		return -ENODEV;
 
 	wacom_wac->hid_data.inputmode = -1;
+	wacom_wac->hid_data.inputmode_field_index = -1;
 	wacom_wac->mode_report = -1;
 
 	if (hid_is_usb(hdev)) {
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index d4f7d8ca1e7e..126bec6e5c0c 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -295,6 +295,7 @@ struct wacom_shared {
 struct hid_data {
 	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
 	__s16 inputmode_index;	/* InputMode HID feature index in the report */
+	__s16 inputmode_field_index; /* InputMode HID feature field index in the report */
 	bool sense_state;
 	bool inrange_state;
 	bool eraser;
-- 
2.54.0.746.g67dd491aae-goog


