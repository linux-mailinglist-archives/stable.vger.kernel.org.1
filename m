Return-Path: <stable+bounces-250641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCMfORD1DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:53:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF9594D38
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 792523152B03
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BA5372EED;
	Wed, 20 May 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Itgo6hx2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D8F34216C;
	Wed, 20 May 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295940; cv=none; b=GNVdi+mAo9OtK7kJRO/LGd3VNg0IV/1EIXHF9ex5hAOZkE9whfFe+5c/5gK06hXljJzk2A2eFyaOENcISf7RtQ6lVdCA6H3oL0WPlq7ozBMm/eybbT4cC9guzn6vgCdyTuowhD6M8Pe8yLbrMDNn+v0j2BTpAWvevawpwGpG0BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295940; c=relaxed/simple;
	bh=uzGnTqgWxVpZdo9KuIZj0XHRrwFapXHlUsVrvFaBgik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtj8H7mDJY7FFuXanvNua55mXvIhaqw5NLXtf4Lj4BagDT+RWkNG4Q7HksCUunkU+d8sRKR5cyEJ4dSn0/JaLuTqGlMPaa46q8h4DWrflNLZFuRimpt21OKCcf7UeLOTyzqUgBRoCHafFeBb2+G4jqDMRPSvT7ORWIb5EPfMplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Itgo6hx2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A001F000E9;
	Wed, 20 May 2026 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295939;
	bh=Mj/VG0c1zd0FsA2Ce+l7x+qpWxjcTewRRCN/E66rib0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Itgo6hx2M2af/JWpLez7xM7rBVAWw9wtY+zpzHLUixivIpxY9x/CUCvyA5hMHeM6f
	 1fFzqBdnNQTAWwNcECxYT85qNFwcMrJ5zHC8jqZNmJv5IyqorHdZVvlJ8rz1/9cQaK
	 bnapi7pSW2eGXMnqrFLz9MJd8LATV9mh+BiAkuoU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oliver Neukum <oneukum@suse.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0603/1146] HID: usbhid: fix deadlock in hid_post_reset()
Date: Wed, 20 May 2026 18:14:13 +0200
Message-ID: <20260520162201.826732610@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250641-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Queue-Id: 6ADF9594D38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index ddd5d77fb5a5e..fd3e1aedc5cbc 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1552,7 +1552,7 @@ static int hid_post_reset(struct usb_interface *intf)
 	 * configuration descriptors passed, we already know that
 	 * the size of the HID report descriptor has not changed.
 	 */
-	rdesc = kmalloc(hid->dev_rsize, GFP_KERNEL);
+	rdesc = kmalloc(hid->dev_rsize, GFP_NOIO);
 	if (!rdesc)
 		return -ENOMEM;
 
-- 
2.53.0




