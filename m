Return-Path: <stable+bounces-214998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mADaACfviWn4EQAAu9opvQ
	(envelope-from <stable+bounces-214998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:28:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5017B11050F
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40374301476D
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73F537AA9E;
	Mon,  9 Feb 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DmRJipiQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDB35CB6B;
	Mon,  9 Feb 2026 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647332; cv=none; b=quTqRJAzBFYXt2UzW6NXwjJB5y1667L+Drg3uoNQju/NLjTvqIe7xIlog5CURdONxkf53p4qQm2noHU7W62dALBQMNUYAC5o3nbuE33VD+tfIlA0oI7p3sgiWdBE9QRI9MCqBQj5pTtPt0b0TFSPfPIfxggtqWE1xnf3dFdNunM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647332; c=relaxed/simple;
	bh=sA9HfWFUCi+tyRUkHairOC5ho7tmTVGK0z6MYKqVKnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CM6DEQCPZq3ezj9DbUEwzFmX0efwscIXhMegKxoLFlB1BNSDujuhwE6nvDFkrDLbPv7i5UzSZU0naCGbVZ4O6UhrUkB4UERXF3WU2pyf/qtANjBL/5abpEBcpPT4DXUNUlNVjS+yD4S9qrsZE6q8v2n9vfn7pnw/4cQ8WurWcO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DmRJipiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA12AC16AAE;
	Mon,  9 Feb 2026 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647332;
	bh=sA9HfWFUCi+tyRUkHairOC5ho7tmTVGK0z6MYKqVKnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DmRJipiQXg7Q2wmdTdQJTa0Nx2fmTWSh35QM0JI2VrgspjSJ3OHlKcfcjvIIyMvWS
	 R4EefVzIg4HBe8j+yA5K13l472lQEheqqqZ0IxNHDZAL4oCk5EBEGYTscAvaYy36Lr
	 s1QhRwRZ+B9Skn53QoychenFQ9/btm4cGyKoRmKA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 051/175] net: usb: sr9700: support devices with virtual driver CD
Date: Mon,  9 Feb 2026 15:22:04 +0100
Message-ID: <20260209142322.305549989@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-214998-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 5017B11050F
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 5d97e95a17b0d..820c4c5069792 100644
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




