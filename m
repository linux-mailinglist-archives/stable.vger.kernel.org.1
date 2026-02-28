Return-Path: <stable+bounces-220900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECOtBsNLo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:10:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7881C7FB8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6620F313C7E4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69638427D46;
	Sat, 28 Feb 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z77yvwg3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A321427D35;
	Sat, 28 Feb 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300789; cv=none; b=V9AIdXQDGlJGKCm5KPx3zVv/zd2u3+dP6vCccTazJnxbLZmkUikJlEr3pHszlbAwAfYt+pTIJh2PKnbri09PWxqcTz46d8FFAuoPR4ta0d52luDFsls/4gzYq4+13SHuH96MLYsnRbw1Tx50MlLTCHYe3mCNoNtuJIPzQBP6sB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300789; c=relaxed/simple;
	bh=Ez11OVOkHbz5VC+1582CGU9v60g9JtJcp2H6KwN942A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U58nPzS+8lIz72tOd/tDAZZGxk5VuOnVMfAamYEw0YEw9nhF2WeFkFqDRBkyTlgtEFfkW73Tz/zE6GKTivbYNLdvXS2k6P3aquLCEIYlNebHv35OJQJw3tgP9eLhWYBCSbh7YL82hqdH5DxEwouSJbzGaOqtjXXezs+ZR5NUqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z77yvwg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63960C19423;
	Sat, 28 Feb 2026 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300789;
	bh=Ez11OVOkHbz5VC+1582CGU9v60g9JtJcp2H6KwN942A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z77yvwg3CfoMgYPZv4gvilwH/lnbIq5sCWnGdg8MGJPOT91fCjuD+1zdn4hT7Womj
	 Oxt1X5R/Fu7nOPXVksdP12mZkXMf57ptGDYPNNDO3qLGhmx5xDnPO8wKZFarKDaRDq
	 jESwMcFYiE9hmVefUfiN3DC4uMWs1KLXbLKTxkQ5hA56f0LalremZLgd91a6GHUWWX
	 93dv1MRO3JlDjobImCMK5qyM1+VrCvFXHthyuhPP4nalL+m4Y2tzD6CxhpS1tI+iwQ
	 gV1zQXFjQvYmKN8SIAXuHYgNYs0BaolSH63NZtuBxAWeneQQDB9H9ZkzKe//+qBi8w
	 nZ01vnKrc/1Vw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 821/844] net: arcnet: com20020-pci: fix support for 2.5Mbit cards
Date: Sat, 28 Feb 2026 12:32:14 -0500
Message-ID: <20260228173244.1509663-822-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220900-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 6C7881C7FB8
X-Rspamd-Action: no action

From: Ethan Nelson-Moore <enelsonmoore@gmail.com>

[ Upstream commit c7d9be66b71af490446127c6ffcb66d6bb71b8b9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/arcnet/com20020-pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 0472bcdff1307..b5729d6c0b47c 100644
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


