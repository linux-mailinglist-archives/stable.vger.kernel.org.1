Return-Path: <stable+bounces-258209-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMiXNh8kG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-258209-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:53:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B750C61096D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CB50300AB1A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FDC3AEB5C;
	Sat, 30 May 2026 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="smzRwTds"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63589320CAD;
	Sat, 30 May 2026 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163579; cv=none; b=jsW9veebH4mLQjbr8JjiDvgSAgMy21hNTaFmLSaNu4AU98WnSvQUe0e7tT/yzpuuxd2tbxjXD2zGwpMxdsLY6Ox86eWY0vgL4Ouwo//E+mHdEw/3yh6wA2Hs6mq+HF4zhMMynVLFBsRWezya2oTyqSx1dS/AIySW20qGcewJLko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163579; c=relaxed/simple;
	bh=MRdTwtXI/M8uJg75A5Ld7fDVnEktZqLEAMAPfewTO0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XC9D96BMBBWWuh3n7N+dNEusFK+g4IjelETdsnNsAf9gBmtK+qLdBuZHlbBwm74gMBppphDXEzt4wjwlMvjT3vSkOnyviZHklvSPxAAfIilcRUTYHeuy3no/aa974q4+w14gKNlKothXLfIrqM+AVK0MdWFXK+sPhIw9guCsmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=smzRwTds; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66FC1F00893;
	Sat, 30 May 2026 17:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163578;
	bh=GE6BTOateg2O+st+ageyD55D+p/5HjAAdtOQAqVl8II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=smzRwTds1e5dI6TmGfC8uILCbbr+h9NQkHEJvuitJ0Rg3Ke2ZiT1xsTOnjg2tASno
	 mTIVYOhIuQ6TYy8NtS6cvbXdY2ePwYcE9Li4ivkxekFvXt47e+M0X6aOXfvf9mNN6p
	 mTvz2WoUjKaaWQEIOm7/mDlNUT63kL+8Vc5H4dik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pete Zaitcev <zaitcev@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.15 293/776] usb: usblp: fix heap leak in IEEE 1284 device ID via short response
Date: Sat, 30 May 2026 18:00:07 +0200
Message-ID: <20260530160248.131326810@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258209-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B750C61096D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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



