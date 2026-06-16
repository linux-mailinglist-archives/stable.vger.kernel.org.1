Return-Path: <stable+bounces-265998-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ECd5AWCUMWpFnQUAu9opvQ
	(envelope-from <stable+bounces-265998-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:22:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53D69412E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:22:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=co1XN1bV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265998-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265998-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F4188317BE37
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0E6466B64;
	Tue, 16 Jun 2026 18:22:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510503D45CB;
	Tue, 16 Jun 2026 18:22:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634122; cv=none; b=aeolkAEQ0GJLPLlXQ/YDxwJvHwU1BYTdVcP3rS2UTqxrGz5erkeIIRBaR5tWxmMHLGGHLMsH6uqIfmZxhHrH0dYcroq7R1O74i97L6fxWj/uHv7jkIycp3/esIUsIys2Ua9eq/K/MaAcMtvg0zyvRiJiBOpLsgfVkJbcP33DXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634122; c=relaxed/simple;
	bh=PVpr63UxBemehGr+3PH63rtN+0+NWum5Ng2pfLIbYdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcZ2MfM3ikzUVoG9WHNENN8ATy6aNoMTPt7DNZXWZA5ZD1Pa5pNSw0rw/P7kFk+8h1LtB2FMQDdu0JevT7BIx8ySaEN9KpwNJwSOsBGRRrw6ZOaB96hp9pd0yfQPrpYgT9bwNFrlSGpzuRkJjx6+3xFH8eNHQQIIwuOEO/1E3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=co1XN1bV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162291F000E9;
	Tue, 16 Jun 2026 18:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634121;
	bh=R+6hKvyquz6DnMNrc9rAfwex4ZCHHuWB5nlaxo5sJU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=co1XN1bVPv62GEpG3T49e4t/PIiEFqtC575eDVDWefyiNRcOXUgWjTqixtgZubnSb
	 NrvxjqHbn3q0axG56MeUqkcbBi2f/3k/Nc7mhy47RW20hKvjVEs9awMILtApUxsUds
	 iuf5iSaGvu/50IahoVdUdnMeXJy/a2VXRqyAQCZA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Adrian Korwel <adriank20047@gmail.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.15 206/411] USB: serial: io_ti: fix heap overflow in build_i2c_fw_hdr()
Date: Tue, 16 Jun 2026 20:27:24 +0530
Message-ID: <20260616145111.695542157@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265998-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:adriank20047@gmail.com,m:johan@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F53D69412E

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adrian Korwel <adriank20047@gmail.com>

commit 0fd2b00b2d3d05e3eaa13342b3dfb0fa85c226ae upstream.

build_i2c_fw_hdr() allocates a fixed-size buffer of
(16*1024 - 512) + sizeof(struct ti_i2c_firmware_rec) bytes, then
copies le16_to_cpu(img_header->Length) bytes into it without
validating that Length fits within the available space after the
firmware record header.

img_header->Length is a __le16 from the firmware file and can be
up to 65535. check_fw_sanity() validates the total firmware size
but not img_header->Length specifically.

Fix by rejecting images where img_header->Length exceeds the
available destination space.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Korwel <adriank20047@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/io_ti.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -843,6 +843,11 @@ static int build_i2c_fw_hdr(u8 *header,
 	/* Pointer to fw_down memory image */
 	img_header = (struct ti_i2c_image_header *)&fw->data[4];
 
+	if (le16_to_cpu(img_header->Length) >
+			buffer_size - sizeof(struct ti_i2c_firmware_rec)) {
+		kfree(buffer);
+		return -EINVAL;
+	}
 	memcpy(buffer + sizeof(struct ti_i2c_firmware_rec),
 		&fw->data[4 + sizeof(struct ti_i2c_image_header)],
 		le16_to_cpu(img_header->Length));



