Return-Path: <stable+bounces-264930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j+6ZMBGCMWq5lAUAu9opvQ
	(envelope-from <stable+bounces-264930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:04:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C628692B1D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:04:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=a3QgaMRL;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264930-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264930-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB1231D955C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B05F47A0A1;
	Tue, 16 Jun 2026 16:50:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2AD45348A;
	Tue, 16 Jun 2026 16:50:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628636; cv=none; b=ombaKqSMxqTsFrdJsOZ+S6+TAdcitGscMV2hZ81LMLdvOZhJUR3RBtZU+o8kVxhQphHPN9Pazc9wXl6/ceE91CqZ6EO8bEoypdQ6RDWAGc3V1mMIIJabatMpeO+B03nPnqUJhhlXxb9rW333uSLLteSedkkJlYACFhnjV2OqD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628636; c=relaxed/simple;
	bh=1wZ1+m8G95iHhnYFQ6DByiO/chFCgXegzvUqB34uJtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doMAZtkRMS4QyqGq/xobyS9/8ulBbh0QQZU5hN/Exnu5vKn91e0peKBOBZh7QCDkSixrc1YwoMX6x2snFeIzrPenu51WhKSn1xWipQwKU0/4uGg4DohFysazKj8Ebz9tNlS0M9xRo0mPvqMQM2gE1dXuOw0b3SzN2J9khNg0z7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a3QgaMRL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4521F000E9;
	Tue, 16 Jun 2026 16:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628635;
	bh=bvOr7NQ8Wq1obU6MU1TOk3OrJ9TCFHUq8CiAvF1H5rY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a3QgaMRLJEioNLNKGIpnRf4V8Zj15tvijZhjsCYdHkJatD7ctkVtflBez3FTZGaHx
	 4l/WNeypyrrRNKzys66apo37qZCYh+zHpM5NqICCDZf+y1M95mMsQy2aCmGNP9dZan
	 PKx5AzLHcYgcxvsMYxHolmLfmGe9xzF/DRSRuKRY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ping Cheng <ping.cheng@wacom.com>,
	Lee Jones <lee@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH 6.6 133/452] HID: wacom: Fix OOB write in wacom_hid_set_device_mode()
Date: Tue, 16 Jun 2026 20:26:00 +0530
Message-ID: <20260616145124.721167130@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264930-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ping.cheng@wacom.com,m:lee@kernel.org,m:bentiss@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,wacom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C628692B1D

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lee Jones <lee@kernel.org>

commit c0a8899e02ddebd51e2589835182c239c2e224ae upstream.

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
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_sys.c |   13 ++++++++++---
 drivers/hid/wacom_wac.h |    1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -341,6 +341,7 @@ static void wacom_feature_mapping(struct
 
 		hid_data->inputmode = field->report->id;
 		hid_data->inputmode_index = usage->usage_index;
+		hid_data->inputmode_field_index = field->index;
 		break;
 
 	case HID_UP_DIGITIZER:
@@ -556,9 +557,14 @@ static int wacom_hid_set_device_mode(str
 
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
@@ -2810,6 +2816,7 @@ static int wacom_probe(struct hid_device
 		return error;
 
 	wacom_wac->hid_data.inputmode = -1;
+	wacom_wac->hid_data.inputmode_field_index = -1;
 	wacom_wac->mode_report = -1;
 
 	if (hid_is_usb(hdev)) {
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -297,6 +297,7 @@ struct wacom_shared {
 struct hid_data {
 	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
 	__s16 inputmode_index;	/* InputMode HID feature index in the report */
+	__s16 inputmode_field_index; /* InputMode HID feature field index in the report */
 	bool sense_state;
 	bool inrange_state;
 	bool invert_state;



