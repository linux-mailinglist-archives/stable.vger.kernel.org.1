Return-Path: <stable+bounces-258726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDsbNNcqG2r//ggAu9opvQ
	(envelope-from <stable+bounces-258726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:22:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 743556119D6
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0D74301223A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9631274FDC;
	Sat, 30 May 2026 18:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I2d8WgMn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80E217704;
	Sat, 30 May 2026 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165331; cv=none; b=ZQhfGraerSeaEEk584h4ZlBUZchr8FHFCghI0Khtc58tht+85WupUwbogTLAgoDV3smItHG+ooLrfsgoXICahY46gSZATll60L6eO3S6x6cmgsiK8X6ggflZWbnwkxJj21FpKCJxM95+R35KAgiItI/Xz/rBKGDDcsBWSQkCA2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165331; c=relaxed/simple;
	bh=5zoGd0F1I+f1Q/aQSDBTa7jyhVGrkRINTDzi0ftXbl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILiQQ5QjXOVv5+T99l+L563ssklGi5aTqIBXPXFtPjptl8/KWbamS5ATfnapIZtkKNgKFE6k/PhO4JeiG9oXAUu0pQIi3KtxQSzEmHLjfPETICHpFKxD41aRhOZmEc1i0U3lshfq11qRwm0MLTQtVhBSzqWzIoWq7shq4ew9aqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I2d8WgMn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A351F00893;
	Sat, 30 May 2026 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165330;
	bh=ZkDkbpKJDtTSPrEFiqYOLJN+sPw7OHFocuHM0HqlxMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I2d8WgMnSswSjsK4B2XZeEp2XWLDRqGXyShqrBGPii7M6PfiMZxLk52A//Wd+OY0L
	 ayzRytap9c/BySrgJnpylRt2LVM3B2piPFatktRP+b/eRpev0pb/9KVNeV4y+ARL+Y
	 RwJBrq6HVWOaT7YcysIaSMK0bmiJXHQBsft8gQ+w=
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
Subject: [PATCH 5.10 047/589] HID: alps: fix NULL pointer dereference in alps_raw_event()
Date: Sat, 30 May 2026 17:58:48 +0200
Message-ID: <20260530160225.827352080@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-258726-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,alps.com:email]
X-Rspamd-Queue-Id: 743556119D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

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



