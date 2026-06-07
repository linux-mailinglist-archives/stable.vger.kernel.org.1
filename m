Return-Path: <stable+bounces-261314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F4jZFgJIJWq8FwIAu9opvQ
	(envelope-from <stable+bounces-261314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B964FB27
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=gJWR0oiA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261314-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261314-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3FD430258BA
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EF6326924;
	Sun,  7 Jun 2026 10:27:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F131E832;
	Sun,  7 Jun 2026 10:27:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828076; cv=none; b=jK1CHIoiyiPhA0W+Q2CPcSKxkNdCpFRvNjt4eqNOoZjhOMxCWU22IxBJgK4LOcm2tZPetHjfWlqc2nQS8Yb/r3d/v0xfxCxSU1zcHarVw27QfoGaazpizvYnbtM0IYv6HILIlbedPSv5q9e2r9tUTtWfY+kbfpl3Yzc1WzlF8v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828076; c=relaxed/simple;
	bh=4B1TCOht/LJBUnV3/WFBG1s8vagKMLhrsRQg6t7We0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJRGe/c3D/Nq3NnI5F0rbExcz/AZlHlQfYPjI9DsIA65danacMkj005s3yZI5Q9xsGO4S9ucOZfRFWiT9YLfXSot7LIGYbw5Ziorf7otIEOww9cTFhAz7Hzw0tBqaVxBUTrsF3kztzqJ/krqmDHXFB2NBLDFWUMOq+avKxFKYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJWR0oiA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FDF1F00893;
	Sun,  7 Jun 2026 10:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828075;
	bh=H+2Z5vM/jhsnQu7qrEd3/7Oa/VhAwWu8VA+B5vE059o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gJWR0oiAJ+Pa+HXqyQYAfqx1V1XeWr7MynRbHbD1Y5HGVZe60KN1BmxsiAwwI3hPY
	 JRp0bnOi8AOkr0quZy5HT7YuXY9yIzM16X69XUyvP8XfeyrpohOyGltKs6Xjlc2P/D
	 3ebUB+ZGejsTmKtWHKaALhawci348RSzVVz3clT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.18 107/315] usb: typec: ucsi: ccg: reject firmware images without a : record header
Date: Sun,  7 Jun 2026 11:58:14 +0200
Message-ID: <20260607095731.579239928@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261314-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:heikki.krogerus@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C43B964FB27

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit d7486952bf74e546ee3748fb14b2d07881fa6273 upstream.

do_flash() locates the first .cyacd record with

	p = strnchr(fw->data, fw->size, ':');
	while (p < eof) {
		s = strnchr(p + 1, eof - p - 1, ':');
		...
	}

If the firmware image contains no ':' byte,  strnchr() returns NULL.
NULL compares less than the valid kernel pointer eof, so the loop body
runs and strnchr() is called with p + 1 == (void *)1 and a length of
roughly (unsigned long)eof, causing a wonderful crash.

The not_signed_fw fallthrough earlier in do_flash() and the chip-state
branches in ccg_fw_update_needed() allow an unsigned blob to reach this
loop, so a root user who can place a crafted file under /lib/firmware
and write the do_flash sysfs attribute can trigger the oops.

Bail out with -EINVAL when the initial strnchr() returns NULL.

Assisted-by: gkh_clanker_t1000
Cc: stable <stable@kernel.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026051405-posture-shrill-7884@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi_ccg.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1242,6 +1242,11 @@ not_signed_fw:
 	 *****************************************************************/
 
 	p = strnchr(fw->data, fw->size, ':');
+	if (!p) {
+		dev_err(dev, "Bad FW format: no ':' record header found\n");
+		err = -EINVAL;
+		goto release_mem;
+	}
 	while (p < eof) {
 		s = strnchr(p + 1, eof - p - 1, ':');
 



