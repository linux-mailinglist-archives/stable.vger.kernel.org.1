Return-Path: <stable+bounces-232255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPV7GHD+y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-232255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC336DC44
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 050163081BEB
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E422423A62;
	Tue, 31 Mar 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BdF3Kqld"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E040710B;
	Tue, 31 Mar 2026 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976277; cv=none; b=OpAplBSzHE0GXzhUtQ209H2d7t4WY90tK1qOeu/5qhoJSIWVXqrBWhJreIN3fpGi+Xgwxhx0FJAWBI+9DW5V0mUN88hxH9A2VKTwp2BJaXFqBnIrYemRiujljPaDpe3yNzWdkztjO57MmGL5Q0w/jwtHI38tSw2WZDYiiNt1p60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976277; c=relaxed/simple;
	bh=tWl5dARxDDdRN2/vxsuOQnkt3sz0Vr8aQL5K/CzJo4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MT6VS0f7jTpIjNu98/d2aqSL7eAwRxyC0bYZkXq0xXMZcFRTPt43Kr3qaI4BD7eTf3bx4twYlB86pCYvsnkALoqTnXfKaSe/cYctDIq6uxmNUmrLdP7CrD12q/dvW7QByUKBk4FMxP7BRUiGgTPuS8Vc0TuUwfV7WOLAolMJi80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BdF3Kqld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9219C19423;
	Tue, 31 Mar 2026 16:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976277;
	bh=tWl5dARxDDdRN2/vxsuOQnkt3sz0Vr8aQL5K/CzJo4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdF3Kqlddavm4I9krXSTne8IiWcTUujjhLKDiV8viQqdRl5oWZL0QKYaC4w29+vwV
	 rMbnp5Uix31m2GFEN3rI2dsXpvY8iYPYyzbeZW7aM5PhDjQIdsRtQ/G0Viiy8tWT+T
	 jY7fJrBlP2wusIM2r/cBAi2za3xgHFTtNaVWTx7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 031/309] HID: apple: Add EPOMAKER TH87 to the non-apple keyboards list
Date: Tue, 31 Mar 2026 18:18:54 +0200
Message-ID: <20260331161754.627929456@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232255-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.com:email,suse.com:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 00AC336DC44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7c698de0dc5daa1e1a5fd1f0c6aa1b6bb2f5d867 ]

EPOMAKER TH87 has the very same ID as Apple Aluminum keyboard
(05ac:024f) although it doesn't work as expected in compatible way.

Put three entries to the non-apple keyboards list to exclude this
device: one for BT ("TH87"), one for USB ("HFD Epomaker TH87") and one
for dongle ("2.4G Wireless Receiver").

Link: https://bugzilla.suse.com/show_bug.cgi?id=1258455
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 233e367cce1d1..2f9a2e07c4263 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -365,6 +365,9 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "A3R" },
 	{ "hfd.cn" },
 	{ "WKB603" },
+	{ "TH87" },			/* EPOMAKER TH87 BT mode */
+	{ "HFD Epomaker TH87" },	/* EPOMAKER TH87 USB mode */
+	{ "2.4G Wireless Receiver" },	/* EPOMAKER TH87 dongle */
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.51.0




