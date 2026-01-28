Return-Path: <stable+bounces-212258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI6BIi43eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:19:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8D7A56F3
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2443328385A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED22E2F3618;
	Wed, 28 Jan 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pO8iQnGQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B11F0991;
	Wed, 28 Jan 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614914; cv=none; b=HjsRRzJvyla/l9GCLhZl6RSC+u0GrLMtYZA5JDyktImO15KMGAOzOFoI9KFIQWJy4vdMJh1Uh6uPAwFGF0YMOySBNkCW/vdoaVfpYG/NfE1ub9+BO3VIe4ya3wxQu6sHkZKEEK7kF7MVUIdefMKVo2/SYB/z0CJ/YbJMyh6fkbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614914; c=relaxed/simple;
	bh=aB1X6ZaiZ6SLdNOndF+qGIn4i4BmIZz5kCyUHxkzEL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lF9yppEZNR6VCS2hU+lMUReZ7TjJuGvoMOPYyjkfhjYfB1tg1hynWA0IDDZCQpwcMQoSKpKXhl9CHzXHofMZ80DlExddo7ig60LPQN7OQiDNUjOg13fDctYaZ4JzCOrofC7C/OD8Rt9Q0h7r6lLrQAEXYLGpNsw2tRMk8VevYSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pO8iQnGQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A52C4CEF1;
	Wed, 28 Jan 2026 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614914;
	bh=aB1X6ZaiZ6SLdNOndF+qGIn4i4BmIZz5kCyUHxkzEL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pO8iQnGQZTOUq7OUqqLSP1qI92e5mx8zqtOr+J8Bq7driUwZUPnIbAoLj8tYFOumk
	 BX0Q7Ws8J9VdRRH95IJ33jLd0SCdidTKNrQ1BVbHlmQUTI3319oJyaxhhF798a3Li0
	 LrphOAxIDw/7wXfZchzvuSmdFkt4KqjtpNSdqXIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 025/169] net: usb: dm9601: remove broken SR9700 support
Date: Wed, 28 Jan 2026 16:21:48 +0100
Message-ID: <20260128145334.928581832@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,korsgaard.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-212258-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,korsgaard.com:email]
X-Rspamd-Queue-Id: 0E8D7A56F3
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Nelson-Moore <enelsonmoore@gmail.com>

[ Upstream commit 7d7dbafefbe74f5a25efc4807af093b857a7612e ]

The SR9700 chip sends more than one packet in a USB transaction,
like the DM962x chips can optionally do, but the dm9601 driver does not
support this mode, and the hardware does not have the DM962x
MODE_CTL register to disable it, so this driver drops packets on SR9700
devices. The sr9700 driver correctly handles receiving more than one
packet per transaction.

While the dm9601 driver could be improved to handle this, the easiest
way to fix this issue in the short term is to remove the SR9700 device
ID from the dm9601 driver so the sr9700 driver is always used. This
device ID should not have been in more than one driver to begin with.

The "Fixes" commit was chosen so that the patch is automatically
included in all kernels that have the sr9700 driver, even though the
issue affects dm9601.

Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Acked-by: Peter Korsgaard <peter@korsgaard.com>
Link: https://patch.msgid.link/20260113063924.74464-1-enelsonmoore@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/dm9601.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 8b6d6a1b3c2ec..2b4716ccf0c5b 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -603,10 +603,6 @@ static const struct usb_device_id products[] = {
 	USB_DEVICE(0x0fe6, 0x8101),	/* DM9601 USB to Fast Ethernet Adapter */
 	.driver_info = (unsigned long)&dm9601_info,
 	 },
-	{
-	 USB_DEVICE(0x0fe6, 0x9700),	/* DM9601 USB to Fast Ethernet Adapter */
-	 .driver_info = (unsigned long)&dm9601_info,
-	 },
 	{
 	 USB_DEVICE(0x0a46, 0x9000),	/* DM9000E */
 	 .driver_info = (unsigned long)&dm9601_info,
-- 
2.51.0




