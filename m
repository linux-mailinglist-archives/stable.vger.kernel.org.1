Return-Path: <stable+bounces-222011-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA+kCv6bo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222011-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:53:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6911CC1C9
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A783430845AF
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838030AD15;
	Sun,  1 Mar 2026 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WsitmNKc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1AD1DF271;
	Sun,  1 Mar 2026 01:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329687; cv=none; b=sWlUfkoC8XHJPEgG1jKomxavfR/zJH4vZwOmgXjMTnnkbffqkUs0u+4lEOPN1CVOV7zyms6po38gvrG9BNiSMPBZeox7Nvoq/kfS8FPFAGXlNSc+nO95K0b0sl8LZqmfDTkdj+0XwctdYKPETmpQBiXa4jTmk9THV/1/xFBh4WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329687; c=relaxed/simple;
	bh=2VCooE8rItf6tTr7ZBQLS2BbaMx+jeHF6RfHsaz+7iI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eCf2iQbrj74qor9KAw/eoqs+jZeGSbtR60F5lFx/g/myFWGDWWqkzQeQlsx57loE80VhwozQ/pvjc4YNb1ASyDWR+C84T8ijnGKHHMd193D0qwWu+YYZX2q04724Y8A9QWCn9OQhl5VYhDWWUc+76aIkAPEincmP0f3VjQSJ3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WsitmNKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C307C19421;
	Sun,  1 Mar 2026 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329686;
	bh=2VCooE8rItf6tTr7ZBQLS2BbaMx+jeHF6RfHsaz+7iI=;
	h=From:To:Cc:Subject:Date:From;
	b=WsitmNKcxJgplAVa1bcjNV5hUbCIYxb0aa1WNJ40I2l6m9pcEqYTInisl04sYzc9i
	 bQNl4B8emDMFJTHSIXj63XfRmL67MYmqYBW21Yq15sPyUPER7MqVxeWOM6AZNHhQ8C
	 1gor8an/4IQYAu0xnbNng7ub3B1JMbY0xurX2cgW8TSOxyrGHdO2/OTI6bXmvGuY8i
	 HT7UADI57PBL/rQAz+No3ubruiEiltLdUDWzvqa0f2vqQW+VXGS9dkG4zz0sTE9Ewa
	 fnkDGczzFFJqxvYWIkRse4FFz1HzIOepDQLi1IVglviygCUyGQrpr2HiEbirwg2yDh
	 G568qnjeC2MWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	enelsonmoore@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: arcnet: com20020-pci: fix support for 2.5Mbit cards" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:48:04 -0500
Message-ID: <20260301014805.1712137-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222011-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: BE6911CC1C9
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c7d9be66b71af490446127c6ffcb66d6bb71b8b9 Mon Sep 17 00:00:00 2001
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 12 Feb 2026 20:55:09 -0800
Subject: [PATCH] net: arcnet: com20020-pci: fix support for 2.5Mbit cards

Commit 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
converted the com20020-pci driver to use a card info structure instead
of a single flag mask in driver_data. However, it failed to take into
account that in the original code, driver_data of 0 indicates a card
with no special flags, not a card that should not have any card info
structure. This introduced a null pointer dereference when cards with
no flags were probed.

Commit bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in
com20020pci_probe()") then papered over this issue by rejecting cards
with no driver_data instead of resolving the problem at its source.

Fix the original issue by introducing a new card info structure for
2.5Mbit cards that does not set any flags and using it if no
driver_data is present.

Fixes: 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
Fixes: bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in com20020pci_probe()")
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Link: https://patch.msgid.link/20260213045510.32368-1-enelsonmoore@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/arcnet/com20020-pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 19e411b2e3a77..dbadda08dce23 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -115,6 +115,8 @@ static const struct attribute_group com20020_state_group = {
 	.attrs = com20020_state_attrs,
 };
 
+static struct com20020_pci_card_info card_info_2p5mbit;
+
 static void com20020pci_remove(struct pci_dev *pdev);
 
 static int com20020pci_probe(struct pci_dev *pdev,
@@ -140,7 +142,7 @@ static int com20020pci_probe(struct pci_dev *pdev,
 
 	ci = (struct com20020_pci_card_info *)id->driver_data;
 	if (!ci)
-		return -EINVAL;
+		ci = &card_info_2p5mbit;
 
 	priv->ci = ci;
 	mm = &ci->misc_map;
@@ -347,6 +349,18 @@ static struct com20020_pci_card_info card_info_5mbit = {
 	.flags = ARC_IS_5MBIT,
 };
 
+static struct com20020_pci_card_info card_info_2p5mbit = {
+	.name = "ARC-PCI",
+	.devcount = 1,
+	.chan_map_tbl = {
+		{
+			.bar = 2,
+			.offset = 0x00,
+			.size = 0x08,
+		},
+	},
+};
+
 static struct com20020_pci_card_info card_info_sohard = {
 	.name = "SOHARD SH ARC-PCI",
 	.devcount = 1,
-- 
2.51.0





