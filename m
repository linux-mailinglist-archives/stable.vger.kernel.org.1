Return-Path: <stable+bounces-236641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BitINMb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:37:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5DC3EF699
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D047530C34FD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C2309DB5;
	Mon, 13 Apr 2026 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KbiShMLU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8A8306B0A;
	Mon, 13 Apr 2026 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097427; cv=none; b=nYUY/xnP1egceU0rRzSVfPPUboyOlU6P9XrVL9xOL1nu297eef/zBqzKBsirGAby3q222LJxjOMeG7WaFTQDRpnWqOU6SugypDwXlcsgbPW/a14dNj2SqsYzGbi23Vr9N2fgYsw2/QaDwaGncXRC13ZdzWdHw7n5iKRzflgt4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097427; c=relaxed/simple;
	bh=iKbN5P+orpP6WXW7QC1LRMZB+URopdZ8DuBOkMB6HjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YTZ/BlojEZbff/BnSCPcVkv0Jx23UVQS0oNZo5dg/tvac0cihDSsIa/Uq9XAwunNVbGVcSOSV1N0LzGQ8pgyB7jqJmM3/y2L1ASB0AKStq46HlfvX8ltHP8yDASzErBaaxN0Qti7N2WXMN0MEKpFkF02m4H7YzNJaonPc0Yb1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KbiShMLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18596C2BCAF;
	Mon, 13 Apr 2026 16:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097427;
	bh=iKbN5P+orpP6WXW7QC1LRMZB+URopdZ8DuBOkMB6HjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KbiShMLUJ+0DNvK6I0895ZyM/MMj7QAYQCDIllUfOupJLmhCmK8ERp5wV2PzkQogJ
	 0R/kh3GzGyLa6HOLvpPPLeG9Q9JL8E/MVDmTvOJ404Ft2uWaFWDxOu6sezz+cc4GlS
	 Ml1CkQ/lEd2ctEKuMLNJynk/mKnelXsoG3bfhMNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 133/570] net: usb: lan78xx: skip LTM configuration for LAN7850
Date: Mon, 13 Apr 2026 17:54:24 +0200
Message-ID: <20260413155835.426166711@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236641-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,pengutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E5DC3EF699
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit d9cc0e440f0664f6f3e2c26e39ab9dd5f3badba7 upstream.

Do not configure Latency Tolerance Messaging (LTM) on USB 2.0 hardware.

The LAN7850 is a High-Speed (USB 2.0) only device and does not support
SuperSpeed features like LTM. Currently, the driver unconditionally
attempts to configure LTM registers during initialization. On the
LAN7850, these registers do not exist, resulting in writes to invalid
or undocumented memory space.

This issue was identified during a port to the regmap API with strict
register validation enabled. While no functional issues or crashes have
been observed from these invalid writes, bypassing LTM initialization
on the LAN7850 ensures the driver strictly adheres to the hardware's
valid register map.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20260305143429.530909-4-o.rempel@pengutronix.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2518,6 +2518,10 @@ static void lan78xx_init_ltm(struct lan7
 	u32 buf;
 	u32 regs[6] = { 0 };
 
+	/* LAN7850 is USB 2.0 and does not support LTM */
+	if (dev->chipid == ID_REV_CHIP_ID_7850_)
+		return;
+
 	ret = lan78xx_read_reg(dev, USB_CFG1, &buf);
 	if (buf & USB_CFG1_LTM_ENABLE_) {
 		u8 temp[2];



