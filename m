Return-Path: <stable+bounces-239857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMdLFqFQ5mkDuwEAu9opvQ
	(envelope-from <stable+bounces-239857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:13:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C741642F26C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B16C3035351
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FBF344D95;
	Mon, 20 Apr 2026 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TRMckKhw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83DE344057;
	Mon, 20 Apr 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701394; cv=none; b=G0PeJIYlUrA/eMk46p/4hBVLMKCdrga08cMHZe6NLvf6FPos8kr1gSAt2r8j4R4bkbI2Nkm5P8PB7dEEFvSGuHESb8ic75eUmLcn0A23EFWlEYvgPG4WKCEbL0EQKEpYu084SuTlnKr6XdsFgLHfVCr1ZYuaMaVg1fo+vXEQ10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701394; c=relaxed/simple;
	bh=8RzUqbCLCEQKB8B0wRrY26xUVEZbC+qBAUHRhPNIOX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/QDaqNNeZMSyllhxX3hSuGbLsxT3K7zOecYBRXTQwTvkWHFDswi4SQk63+x94mJ13H0uFysPLLgcxmfvVIOLt6RW7J92jZQ6qcKoG1RZy+WmBneMV4xj3yfW2whK1af7izon30dROf9J8C4j0dsbWiy8TADJVzfG2/caXsBBWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TRMckKhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1E0C2BCB4;
	Mon, 20 Apr 2026 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701393;
	bh=8RzUqbCLCEQKB8B0wRrY26xUVEZbC+qBAUHRhPNIOX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRMckKhwCBNIfA+s0+1LWOYf7Gint6F9QlsE0y25/YLV8dLoQNJfOKn3qyjc26xs1
	 /Dlpfs9BHDUC5M0Q+1zepjGwAJiVE7DmDOBoOsIWk2UI5xYuN3zql0B1t4gDQE/BHZ
	 JK7IUqSwi2L3EHPTwch7BmwZiqhizakZ4Zo4zgRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	linux-input@vger.kernel.org,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.12 097/162] HID: alps: fix NULL pointer dereference in alps_raw_event()
Date: Mon, 20 Apr 2026 17:42:09 +0200
Message-ID: <20260420153930.553805210@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239857-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: C741642F26C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 1badfc4319224820d5d890f8eab6aa52e4e83339 upstream.

Commit ecfa6f34492c ("HID: Add HID_CLAIMED_INPUT guards in raw_event
callbacks missing them") attempted to fix up the HID drivers that had
missed the previous fix that was done in 2ff5baa9b527 ("HID: appleir:
Fix potential NULL dereference at raw event handle"), but the alps
driver was missed.

Fix this up by properly checking in the hid-alps driver that it had been
claimed correctly before attempting to process the raw event.

Fixes: 73196ebe134d ("HID: alps: add support for Alps T4 Touchpad device")
Cc: stable <stable@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-alps.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -437,6 +437,9 @@ static int alps_raw_event(struct hid_dev
 	int ret = 0;
 	struct alps_dev *hdata = hid_get_drvdata(hdev);
 
+	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !hdata->input)
+		return 0;
+
 	switch (hdev->product) {
 	case HID_PRODUCT_ID_T4_BTNLESS:
 		ret = t4_raw_event(hdata, data, size);



