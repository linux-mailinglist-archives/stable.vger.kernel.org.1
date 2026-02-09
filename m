Return-Path: <stable+bounces-215062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMqxNP7viWn4EQAAu9opvQ
	(envelope-from <stable+bounces-215062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:32:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37291110668
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 367FC3004D00
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B503793C6;
	Mon,  9 Feb 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhmSmVMu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ED51DE8AD;
	Mon,  9 Feb 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647547; cv=none; b=e4ky4bRmMSUGxB/I1RlwoA4orSNPzipZlAiXDawhKZh/U9xyZ0r/2xYpKp9B4Nq1+YZrb71rWtTx9CwRQ3u39RvzK0a250BDDUWgWW9JKbZ2utvUmW9Z1S/L5FdZTkPSZPojiaApqHrGe92c6M0M5Hg/qox3svT9kwOqs0zgIwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647547; c=relaxed/simple;
	bh=E4/B0VzoVv+TM0pw198q3XqKNUx1bNCaDa8v9J7QBYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbuKxLhDeIZyDTQJPZLLX7ir33ujCKQuOAz9uEpmB5XoA/g5Ojzm+W5ilAXH4rQ40AkRCXzNsHd99YLLLyO4tXOW8rekih2FEYZnBlDZhtjYtEbeVo8Qf+xS8sqL1PJXDx1EJjycqcbB4QaRW40RmBpxx+EpngV3yNZfd9j2m24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhmSmVMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986C6C116C6;
	Mon,  9 Feb 2026 14:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647547;
	bh=E4/B0VzoVv+TM0pw198q3XqKNUx1bNCaDa8v9J7QBYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zhmSmVMuzdQZkVge83LOcGZO7y412c8W45e2YMZQHJVK/YvDFQzdyE8XrYeHEPEzV
	 z1zqjn4LuDhJ2065zX1QNzkwS7Qgf+dbDrk+JcBeG41eflujNcUNIQXoosd1j+iVV7
	 N4321JidWCC7R6+YBM8pgHXXCAKcvHuMejwwR1g8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 133/175] net: usb: r8152: fix resume reset deadlock
Date: Mon,  9 Feb 2026 15:23:26 +0100
Message-ID: <20260209142325.295763761@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215062-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 37291110668
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index a22d4bb2cf3b5..6a43054d5171f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8535,19 +8535,6 @@ static int rtl8152_system_resume(struct r8152 *tp)
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
 
@@ -8658,19 +8645,33 @@ static int rtl8152_suspend(struct usb_interface *intf, pm_message_t message)
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




