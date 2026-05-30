Return-Path: <stable+bounces-258422-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH8lGqMpG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258422-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:17:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF2C6116A3
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E2A0311A286
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D220123392B;
	Sat, 30 May 2026 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gF6I46ku"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30C2E22BD;
	Sat, 30 May 2026 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164298; cv=none; b=QIyhYIEwRmS+EexF3FNfg5QvGG1ty751zdRacmkVtzSBZKejvp+S2SJz7RixF2z1cKDXS3RjwSKv+saIfgjYFH+fCJlmrZKXilygnXcY1a5FDaXzmyYpDdqXUFq/Tn9hH/Pb0GkFdR2Xh1PWtHOEKCSkbNirhDun+DQYbnJClhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164298; c=relaxed/simple;
	bh=gd9oKfCgjRjIqgA73iCe7jSFSs+A7onkgjxkOCKT8sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtHTyTAekeH1QFmJXH8jBSw/whUls6l3IvkhGKiypEfo19slllnFGPyXnyK2kgigAbTBBPhJG24H6X0ulD2akAsPecchTI2jkipbPgQnpXfKEv6iq9IOCZB5UPxZHto0UwscxelqdD2Ek7udm3j5AwsXJBoJGuZT8S9dHM02DL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gF6I46ku; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48B81F00893;
	Sat, 30 May 2026 18:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164297;
	bh=k1nkiKr5N0MVklzvaONIMmRt1bNSQ/UHJBhgoaJyW8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gF6I46ku6ickEB2xrOSam1WQ+hrXuHoup4qj0ruZwx8nDeYHi+LPgmh7G5oap0O6V
	 9A/nId11U+h+zc8QzaAma+v6yzXY/DmWcR7MbF7eomGxU/OGU0dXbAoxiYDwBav2Rn
	 jCKfbaxm8VfE+9edbhzlhFKWHRVTvDRGOUrNK0o0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 512/776] HID: usbhid: fix deadlock in hid_post_reset()
Date: Sat, 30 May 2026 18:03:46 +0200
Message-ID: <20260530160253.490337219@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258422-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CEF2C6116A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 8df2c1b47ee3cd50fd454f75c7a7e2ae8a6adf72 ]

You can build a USB device that includes a HID component
and a storage or UAS component. The components can be reset
only together. That means that hid_pre_reset() and hid_post_reset()
are in the block IO error handling. Hence no memory allocation
used in them may do block IO because the IO can deadlock
on the mutex held while resetting a device and calling the
interface drivers.
Use GFP_NOIO for all allocations in them.

Fixes: dc3c78e434690 ("HID: usbhid: Check HID report descriptor contents after device reset")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/usbhid/hid-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 5faa608563814..b182b288991a6 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1544,7 +1544,7 @@ static int hid_post_reset(struct usb_interface *intf)
 	 * configuration descriptors passed, we already know that
 	 * the size of the HID report descriptor has not changed.
 	 */
-	rdesc = kmalloc(hid->dev_rsize, GFP_KERNEL);
+	rdesc = kmalloc(hid->dev_rsize, GFP_NOIO);
 	if (!rdesc)
 		return -ENOMEM;
 
-- 
2.53.0




