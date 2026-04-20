Return-Path: <stable+bounces-239513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDViCIVh5mmavgEAu9opvQ
	(envelope-from <stable+bounces-239513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:25:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68843128F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84A2B32427E8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0FA33A9C4;
	Mon, 20 Apr 2026 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R1WE0sNE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0870332916;
	Mon, 20 Apr 2026 15:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700445; cv=none; b=Go/gHL17hwXPYy15vSvnNbW7qTHo2aQaB+aQutod5Zll9uvRJ5J5yj6mLL/TA2K2O9aTeJuZHfTI90usvnR4hl9zJJlu4B2vy1y+RsymQe1yR/x+0FxqbXKDoJ3wOyt7ncV5rvqtdLtRvZQ6NrXY2fFm40vcxcWO8vpvznb8bEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700445; c=relaxed/simple;
	bh=8Q3ROlLIzG1nOwWOetyvdp3O3sokICRXizuBa8SdYig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjjXpVGWilkjMfK/yMQ3rg2DRP3GWHOlCMmp7RwgsqHbaZE4p4THu3Xez9XxhlcOFuiX3IEJx+k9K1EiJF80qukDRHRV+GS1L5hslv4TwOKLhYj65ZeBktbmQHmmQSKlJMJfLTEoYFhG9EsvS9ULW6qCkr7QUoHqX1q7GHTis+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R1WE0sNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56484C19425;
	Mon, 20 Apr 2026 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700445;
	bh=8Q3ROlLIzG1nOwWOetyvdp3O3sokICRXizuBa8SdYig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R1WE0sNEt3BkJQBPHn6PglGjq5YsgNV+P2Ci5oL3XJk5YnS6ubv5iwAzjHt3BQl8r
	 p4ELNB/5k1k5LKDLJmXwLqT7nkWX4zeJQC7BWXGMKMFsW1vqleuhNG4hD2TMWiNwe9
	 PJaCc/83vMZeKMnerWSU6Ay9D+zTV2GZTGJ9AJfU=
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
Subject: [PATCH 6.19 144/220] HID: alps: fix NULL pointer dereference in alps_raw_event()
Date: Mon, 20 Apr 2026 17:41:25 +0200
Message-ID: <20260420153939.212279871@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239513-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,alps.com:email]
X-Rspamd-Queue-Id: 3B68843128F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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



