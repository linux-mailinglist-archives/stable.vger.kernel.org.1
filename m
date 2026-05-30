Return-Path: <stable+bounces-257251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO4YE5sZG2pV/AgAu9opvQ
	(envelope-from <stable+bounces-257251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:08:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A687860EF64
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C08AF3069D0B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603533F5A3;
	Sat, 30 May 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uqTVjj12"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB7D332EA7;
	Sat, 30 May 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160344; cv=none; b=Fa2soQIPSGkVUQTfrQCES0KfkKdZJa9GybAzaph7oIjPn4gLsZLVDTi9Cj57+qTcJaJZJ32sHF2DZd+cyAytw4AQTQqBdAB4En0Aig6ec5UXW67C3niZ1OBFs63EtoU8hyabPbtTTCQRQ4tSKys31F1pj+IRwazHXBfLkNBeZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160344; c=relaxed/simple;
	bh=AsKyjqIG632J9B5An24n4/qh+j+vTqvq/ypsylc/FUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j54++JemYB2kg9gFXPksL82+Zdb7rbIWWpKWlOUSTqKVPfi1f/339gWsPgFoHmG0ED9n2Js/4PQCDRi5rjGQ6SmJ5PE+2e52K84S5Yv79T30seRnvKFK/59d8m4kzZBnh+QeuwUijKNsn46pVTRnCdwjMzUkfFp5xn9YjbLjfaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uqTVjj12; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 525AE1F00893;
	Sat, 30 May 2026 16:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160343;
	bh=lvQ7GYMytft3BuOF/Iwi6fqonm2GGZdMwJD/kKOhqdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uqTVjj12AF0lzVKBDoT/irK/XeuEAFpFjLMbaRozSdW5qFZaN7BvT204w4E8e/M8x
	 6E/em8boBcMuVjtWR2RJGBwTbsq2UthLnDiNUGg6lhHGDvoqUeSuT6pRStdUEfkkvZ
	 Z8pvXA4Q3g9WQC8ryLeRl2WMtl99suliMwqJ8fec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pete Zaitcev <zaitcev@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.1 305/969] usb: usblp: fix heap leak in IEEE 1284 device ID via short response
Date: Sat, 30 May 2026 17:57:09 +0200
Message-ID: <20260530160308.852312343@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257251-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A687860EF64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 7a400c6fe3617e31e690e3f7ca37bb335e0498f3 upstream.

usblp_ctrl_msg() collapses the usb_control_msg() return value to
0/-errno, discarding the actual number of bytes transferred.  A broken
printer can complete the GET_DEVICE_ID control transfer short and the
driver has no way to know.

usblp_cache_device_id_string() reads the 2-byte big-endian length prefix
from the response and trusts it (clamped only to the buffer bounds).
The buffer is kmalloc(1024) at probe time. A device that sends exactly
two bytes (e.g. 0x03 0xFF, claiming a 1023-byte ID) leaves
device_id_string[2..1022] holding stale kmalloc heap.

That stale data is then exposed:
  - via the ieee1284_id sysfs attribute (sprintf("%s", buf+2), truncated
    at the first NUL in the stale heap), and
  - via the IOCNR_GET_DEVICE_ID ioctl, which copy_to_user()s the full
    claimed length regardless of NULs, up to 1021 bytes of uninitialized
    heap, with the leak size chosen by the device.

Fix this up by just zapping the buffer with zeros before each request
sent to the device.

Cc: Pete Zaitcev <zaitcev@redhat.com>
Assisted-by: gkh_clanker_t1000
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/2026042002-unicorn-greedily-3c63@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/usblp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/class/usblp.c
+++ b/drivers/usb/class/usblp.c
@@ -1365,6 +1365,7 @@ static int usblp_cache_device_id_string(
 {
 	int err, length;
 
+	memset(usblp->device_id_string, 0, USBLP_DEVICE_ID_SIZE);
 	err = usblp_get_id(usblp, 0, usblp->device_id_string, USBLP_DEVICE_ID_SIZE - 1);
 	if (err < 0) {
 		dev_dbg(&usblp->intf->dev,



