Return-Path: <stable+bounces-215481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FqZCJr5iWkiFQAAu9opvQ
	(envelope-from <stable+bounces-215481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:13:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA39111BDD
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C545530DAF5D
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5B937BE77;
	Mon,  9 Feb 2026 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b+7dPQ5S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023FC2750E6;
	Mon,  9 Feb 2026 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648938; cv=none; b=C0PD3/hK5bebXOkDLPl2BPmJ/+AM42uXEgYavl52x9fhe88X95hM8Ei4V1J/V/cM/BUuZAX1cNxqGSL55HoJZa6SVojyelYCxphGYn4efWYAYB7nogMpwpUlPet+PMDZoCAi2LjAfvEMb64O5lvMW3q751VxbpOhjTgg96HUMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648938; c=relaxed/simple;
	bh=I52PfU2p+grNN19pjdQh+jzoQbsiuXh7ZABQE7u2YCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRQWUmIV0eKuoqCite2CK8M4dWajZpYAtFRQXdGbFDlt3DtKpweASX5lZinpq1gXP9sHJn6fgKUF2WypMM9MU07hb6jlkpWqaSXUwFdSUJPSepLrt3iz8GLdy5IEEOx91C2HpCDt1XsEGM8bp3/K77Uf8yQuac2CFPDWPc5lgWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b+7dPQ5S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35959C116C6;
	Mon,  9 Feb 2026 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648937;
	bh=I52PfU2p+grNN19pjdQh+jzoQbsiuXh7ZABQE7u2YCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+7dPQ5SRV3Xdii3krtZd4DuPGYehqY+HrUmBAIDgdhZQqWoEHZrkfj1mLXnfmmjw
	 mAHI3ZFkdt+meTPsjCZKhdARCr2BRs1g9MnoOu3CwIucg0NXTtEeMeCOSIVYrvNl04
	 Ycs4JR4NknIpxINR/9bdLK0oSqLcnbcdPWAcy0hw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 26/75] net: usb: sr9700: support devices with virtual driver CD
Date: Mon,  9 Feb 2026 15:24:23 +0100
Message-ID: <20260209142302.789074717@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.830618238@linuxfoundation.org>
References: <20260209142301.830618238@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215481-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FA39111BDD
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Nelson-Moore <enelsonmoore@gmail.com>

[ Upstream commit bf4172bd870c3a34d3065cbb39192c22cbd7b18d ]

Some SR9700 devices have an SPI flash chip containing a virtual driver
CD, in which case they appear as a device with two interfaces and
product ID 0x9702. Interface 0 is the driver CD and interface 1 is the
Ethernet device.

Link: https://github.com/name-kurniawan/usb-lan
Link: https://www.draisberghof.de/usb_modeswitch/bb/viewtopic.php?t=2185
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Link: https://patch.msgid.link/20251211062451.139036-1-enelsonmoore@gmail.com
[pabeni@redhat.com: fixes link tags]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/sr9700.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 90aed52ce9372..86d14fad318c3 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -539,6 +539,11 @@ static const struct usb_device_id products[] = {
 		USB_DEVICE(0x0fe6, 0x9700),	/* SR9700 device */
 		.driver_info = (unsigned long)&sr9700_driver_info,
 	},
+	{
+		/* SR9700 with virtual driver CD-ROM - interface 0 is the CD-ROM device */
+		USB_DEVICE_INTERFACE_NUMBER(0x0fe6, 0x9702, 1),
+		.driver_info = (unsigned long)&sr9700_driver_info,
+	},
 	{},			/* END */
 };
 
-- 
2.51.0




