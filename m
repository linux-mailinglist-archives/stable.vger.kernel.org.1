Return-Path: <stable+bounces-234873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WO3LAjyo1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:10:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4543C2887
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB24731677AC
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516813624B2;
	Wed,  8 Apr 2026 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZ6m6Okq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4F2BD030;
	Wed,  8 Apr 2026 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673984; cv=none; b=KpFH9KzENoeYB+m99ZaAxISkrBL9j7FuOyU5zv3RU2iH+xaDBSfpLjyId97k8+GW6KiPdKl7Ox8BNh1IaIuuoYZ8pPBH+DVfSc2XXlZfQU+794hrKVceuZLkXBfhZsIXS61wj0DLCfF8I7lyN3RWoWF0lK3HaJk4PQN+1niY5Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673984; c=relaxed/simple;
	bh=jtYvlDbcI8TsM6CU8LSZOp1/EGBZClzwYl7EKIOQjpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qobyaZG8yzVRDhVziR3ETxAfX3hIySTcYjPxef/vaR5zy32n9EHvYHnm7qPkj9hudMnslknCUEqW/Nn2a33euDh5E9Y3XtLbspPbbEEVZAbzL8kZIv0PWVfZl61f9f5syJaZNh2eimEyvzinyBi1I6OF9trMHm3QnoOp+H+nHhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZ6m6Okq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E38CC19421;
	Wed,  8 Apr 2026 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673984;
	bh=jtYvlDbcI8TsM6CU8LSZOp1/EGBZClzwYl7EKIOQjpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TZ6m6Okq8WU78zViv+mcbQ6jfXZtGhAaHpZtBaW7hiCqaPgFU53g7XxrvLkC+bV4+
	 DBfDz9/zuv4lia1ob5ZgSJM7SQHhjvRSWrgtyHHxE5VzzRfFSKjOVnAh8X/1t5qWAi
	 qq6KNOrgOADiDwhgChJrs2eIvNTYd3Kq6iHmNcAE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH 6.12 164/242] usb: core: phy: avoid double use of usb3-phy
Date: Wed,  8 Apr 2026 20:03:24 +0200
Message-ID: <20260408175933.226942951@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234873-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 4A4543C2887
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <j4g8y7@gmail.com>

commit 0179c6da0793ae03607002c284b53b6d584172d0 upstream.

Commit 53a2d95df836 ("usb: core: add phy notify connect and disconnect")
causes double use of the 'usb3-phy' in certain cases.

Since that commit, if a generic PHY named 'usb3-phy' is specified in
the device tree, that is getting added to the 'phy_roothub' list of the
secondary HCD by the usb_phy_roothub_alloc_usb3_phy() function. However,
that PHY is getting added also to the primary HCD's 'phy_roothub' list
by usb_phy_roothub_alloc() if there is no generic PHY specified with
'usb2-phy' name.

This causes that the usb_add_hcd() function executes each phy operations
twice on the 'usb3-phy'. Once when the primary HCD is added, then once
again when the secondary HCD is added.

The issue affects the Marvell Armada 3700 platform at least, where a
custom name is used for the USB2 PHY:

  $ git grep 'phy-names.*usb3' arch/arm64/boot/dts/marvell/armada-37xx.dtsi | tr '\t' ' '
  arch/arm64/boot/dts/marvell/armada-37xx.dtsi:    phy-names = "usb3-phy", "usb2-utmi-otg-phy";

Extend the usb_phy_roothub_alloc_usb3_phy() function to skip adding the
'usb3-phy' to the 'phy_roothub' list of the secondary HCD when 'usb2-phy'
is not specified in the device tree to avoid the double use.

Fixes: 53a2d95df836 ("usb: core: add phy notify connect and disconnect")
Cc: stable <stable@kernel.org>
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Link: https://patch.msgid.link/20260330-usb-avoid-usb3-phy-double-use-v1-1-d2113aecb535@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/phy.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -114,7 +114,7 @@ EXPORT_SYMBOL_GPL(usb_phy_roothub_alloc)
 struct usb_phy_roothub *usb_phy_roothub_alloc_usb3_phy(struct device *dev)
 {
 	struct usb_phy_roothub *phy_roothub;
-	int num_phys;
+	int num_phys, usb2_phy_index;
 
 	if (!IS_ENABLED(CONFIG_GENERIC_PHY))
 		return NULL;
@@ -124,6 +124,16 @@ struct usb_phy_roothub *usb_phy_roothub_
 	if (num_phys <= 0)
 		return NULL;
 
+	/*
+	 * If 'usb2-phy' is not present, usb_phy_roothub_alloc() added
+	 * all PHYs to the primary HCD's phy_roothub already, so skip
+	 * adding 'usb3-phy' here to avoid double use of that.
+	 */
+	usb2_phy_index = of_property_match_string(dev->of_node, "phy-names",
+						  "usb2-phy");
+	if (usb2_phy_index < 0)
+		return NULL;
+
 	phy_roothub = devm_kzalloc(dev, sizeof(*phy_roothub), GFP_KERNEL);
 	if (!phy_roothub)
 		return ERR_PTR(-ENOMEM);



