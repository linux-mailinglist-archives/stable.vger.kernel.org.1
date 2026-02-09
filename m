Return-Path: <stable+bounces-215199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBJaDojyiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:43:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D1110C61
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14442301B7DB
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4EC37C0F5;
	Mon,  9 Feb 2026 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vWd9assQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB536828A;
	Mon,  9 Feb 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648005; cv=none; b=sujZ6rjMBpSPh/dWUoYRP7NnhFKgS9IgkqX6uXkKk9DovKTCgr3xsPCx+a08Mw0+YvJWs9mTIn9HgVQWyefeACpShsauE8HsJ9V8DVYYjTsq5HXhoLE413pvQxeSup30hAIz6ditVN1hnmWrN9RLF4gSpcZwCxI1gGVzMW2rPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648005; c=relaxed/simple;
	bh=np68byDpRSIdYEU+WTuixgeLpizeUdC8r01i9KakiRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjGBOhqvgVrdXXwZoJGolvyKxYXS9cLD/uDgcNtyRUkm4Fm2d9KPxTwZwSSRS3v6KZlpwQi7V/g/s6ufqLv9YXqzZxcSyzQDJ+uTRMkmQTqdtHsb1gf1r5nAvnx2ibzTb31y4EmabGX8KMH4a6dpAjelQA4h0U1IP6S3BmPqJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vWd9assQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD6CC116C6;
	Mon,  9 Feb 2026 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648004;
	bh=np68byDpRSIdYEU+WTuixgeLpizeUdC8r01i9KakiRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vWd9assQgNCP7kYPsixK1B9ND60pK2/WfjXzCh7R4pdEqoIqjNhjtgTCaf+5Z01PW
	 Im4FDoZ5LPHseOLTSqBvgxjREz7d5NP24H1/7+3LWP6bOfwmjN7L5X1N5K0O+zrqQM
	 HUskx8vrunBrH4xPZS2a7VUa041P3/9cymvlk4FM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 091/113] net: usb: r8152: fix resume reset deadlock
Date: Mon,  9 Feb 2026 15:24:00 +0100
Message-ID: <20260209142313.452746656@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215199-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: D92D1110C61
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 6d06bc83a5ae8777a5f7a81c32dd75b8d9b2fe04 ]

rtl8152 can trigger device reset during reset which
potentially can result in a deadlock:

 **** DPM device timeout after 10 seconds; 15 seconds until panic ****
 Call Trace:
 <TASK>
 schedule+0x483/0x1370
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock_common+0x1fd/0x470
 __rtl8152_set_mac_address+0x80/0x1f0
 dev_set_mac_address+0x7f/0x150
 rtl8152_post_reset+0x72/0x150
 usb_reset_device+0x1d0/0x220
 rtl8152_resume+0x99/0xc0
 usb_resume_interface+0x3e/0xc0
 usb_resume_both+0x104/0x150
 usb_resume+0x22/0x110

The problem is that rtl8152 resume calls reset under
tp->control mutex while reset basically re-enters rtl8152
and attempts to acquire the same tp->control lock once
again.

Reset INACCESSIBLE device outside of tp->control mutex
scope to avoid recursive mutex_lock() deadlock.

Fixes: 4933b066fefb ("r8152: If inaccessible at resume time, issue a reset")
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://patch.msgid.link/20260129031106.3805887-1-senozhatsky@chromium.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 3fcd2b736c5e3..d27e62939bf13 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8565,19 +8565,6 @@ static int rtl8152_system_resume(struct r8152 *tp)
 		usb_submit_urb(tp->intr_urb, GFP_NOIO);
 	}
 
-	/* If the device is RTL8152_INACCESSIBLE here then we should do a
-	 * reset. This is important because the usb_lock_device_for_reset()
-	 * that happens as a result of usb_queue_reset_device() will silently
-	 * fail if the device was suspended or if too much time passed.
-	 *
-	 * NOTE: The device is locked here so we can directly do the reset.
-	 * We don't need usb_lock_device_for_reset() because that's just a
-	 * wrapper over device_lock() and device_resume() (which calls us)
-	 * does that for us.
-	 */
-	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
-		usb_reset_device(tp->udev);
-
 	return 0;
 }
 
@@ -8688,19 +8675,33 @@ static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
 static int rtl8152_resume(struct usb_interface *intf)
 {
 	struct r8152 *tp = usb_get_intfdata(intf);
+	bool runtime_resume = test_bit(SELECTIVE_SUSPEND, &tp->flags);
 	int ret;
 
 	mutex_lock(&tp->control);
 
 	rtl_reset_ocp_base(tp);
 
-	if (test_bit(SELECTIVE_SUSPEND, &tp->flags))
+	if (runtime_resume)
 		ret = rtl8152_runtime_resume(tp);
 	else
 		ret = rtl8152_system_resume(tp);
 
 	mutex_unlock(&tp->control);
 
+	/* If the device is RTL8152_INACCESSIBLE here then we should do a
+	 * reset. This is important because the usb_lock_device_for_reset()
+	 * that happens as a result of usb_queue_reset_device() will silently
+	 * fail if the device was suspended or if too much time passed.
+	 *
+	 * NOTE: The device is locked here so we can directly do the reset.
+	 * We don't need usb_lock_device_for_reset() because that's just a
+	 * wrapper over device_lock() and device_resume() (which calls us)
+	 * does that for us.
+	 */
+	if (!runtime_resume && test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+		usb_reset_device(tp->udev);
+
 	return ret;
 }
 
-- 
2.51.0




