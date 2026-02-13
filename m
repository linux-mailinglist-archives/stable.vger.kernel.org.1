Return-Path: <stable+bounces-216019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLS9DN2ujmkUDwEAu9opvQ
	(envelope-from <stable+bounces-216019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 05:55:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8007132EAA
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 05:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29850305CF5D
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 04:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38422594BD;
	Fri, 13 Feb 2026 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0xSIcyk"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90119245031
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770958548; cv=none; b=gilUT5SQQCJTLrZSEchmt7g56p60QYad1T/YATMHj+PNNQfMvL51yR55PyWvQeuNbiiHLDMAOZpgNKmjjMQB99giMuVY923EhmH5qkcGjQ4/oC9fiC+/zkwcZm2KoyC4noIkS5v+rau/n79uR7FdDWhs5ELPF2Oj7/Q5kwp6tn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770958548; c=relaxed/simple;
	bh=S3UQ0I6GAAFw2ZrsUNcDfOuA6jQgRQzkcE2bZIN6tC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bEzrsy2lcSUMCdZzN+lYpJ/wPccWCtCfwQMR9NfvmskB+mfHlA7V+h4FpAxEzIMHp9/CjsFoMrk8wCPxEg6udwqby34HFrAP7tQ6KC3B8iB8N5ZB/BowZpAmJJB2022IuD4zI7ya4ftFAcIxDW2RiuZ0va0Oj8bxoVMPhL9GHf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0xSIcyk; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso536979eec.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 20:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770958546; x=1771563346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=En+pLxpA/9SkcB4JG3FQxxc277chmMll4kOR/JIga7g=;
        b=b0xSIcyk8H6bz3AohA4TczmD+8bP0JUPSGEWFU2cWUv2D/+Ci0iktzYmC8dR593u2i
         DsltwxON5k2f6LxOxEh2sZqiIY+6l7RY9+r1FrvwDkTqCCnuZsVcu0dEiGknwjilpVVw
         8d104roK2G5Wqv+/ek3JgAdcCJQ8uV09ClZ1EtQbTRWtvw9vP4Ok/745wh7eaAS2QZRP
         rlZxXAoSjicZJ5kG5DZxs4fL3zengxuL9uvHAapYUOtw1HUADtzbuoWBFPDXRu2EcPNJ
         hoxq4gCJhsUY+YEuFOASMyuMfuvxXHcEzF+BYWCbyvnPwmKs9D7HTrTicnFUSdKzQaNI
         RPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770958546; x=1771563346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En+pLxpA/9SkcB4JG3FQxxc277chmMll4kOR/JIga7g=;
        b=FufvigEjnIdU8iKIH4JxM99+QieUZdtxw8rYQrLuz7IOYaoVHvbX9jp5/VZM/k+Rhv
         0dT8YgMUlhPPbadK5E9Tjs8iNSefH/yKNO1ClnD4VZv3lIyFYhCresqDcdCZRV4SeRw5
         I3X6HxleWStOD2fmXfmA+GU3ty6E0D5q1dLQZRc2rh8jBrLIVat2KVyMYabn6FV0Iojk
         /c+DYwQ2e+WusFq9g1/Q+4RbG3pAIlFrTYzWQZKUe/MtjvOh9tYyOKYiBKmM/eR8BIAz
         PS16drnYYm73ZuH8EAfXVo1WmPlJ77SsKUzKWS5KllTZgci27Vlt6YkkMA34K2j5OKea
         l+SA==
X-Forwarded-Encrypted: i=1; AJvYcCUrOA0W1Cb7Po8J+Bpg5EhheI8DIyGwEmjI20sRC+BhS0Pez0n/Miby5YBBGF6gB7A3+RSi6tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/UT3Fof6qlLcQQH+wneolclD+3SWXmzlvqr95YOcBC0IyRMm
	1MyACyxUmIFPC8aYMOi+tyq9z9KDt3aksDLnBoH6V66m1fX+Mr5F7oJV
X-Gm-Gg: AZuq6aIHOrrIrST49HOK/k23b+C3Int4LLdb5zWwwSFiH8DaaZitFn74+4JQGGREuko
	2oaIRD6cZjd75DJJPQBNiTSoptADbBZMn/EmBni7su7zGq2vCBglkU9NDqqCj32XRlS4kRTGx8g
	rRsWN3QBKYm4JkqYvA4ZHqg0k8qCpTX4Qg6ToCZ8Nst7CNjp85igwqaO6akQvAjx5K+8jHWAJfF
	Ga29uTcnkfvE8f9jeroOushVGln4n4MBKoJniuGVJGuJPw6YZd79abyM0AS1NdAYbN0dcTZwUoL
	EE0kmsOzTp0A5bCb4iafxs2wfmEvX9ZGLvfLJvzdrJcqOrxDcwDnonXKoQKOcvPiqHRAop69wRm
	+hfXHT5HUG5JG2nGjSniNkCzrm71opZQTOy8n0HeV9h0Y2o4ffyDxH1mMMlXoO4CNrNpEQDRjlk
	5gQ1AAWo/2relN7eMy9aw+gOt2BEJuoUYTFUxeurNKyiCqRFZFQWVdoN9CR6TN8/9dq3qtEACb8
	w8j8cWDOta2jdziCP/NCWmqtU3bZr9LPFpyeJiw4m+nYjFgzEXUD6klQJruZC2SRXLtmDADpJYC
	T5Lh3bZUpqApceXXmg==
X-Received: by 2002:a05:7300:80d6:b0:2ba:14a6:c96f with SMTP id 5a478bee46e88-2babc47c424mr211119eec.36.1770958546131;
        Thu, 12 Feb 2026 20:55:46 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd03d8sm4846139eec.21.2026.02.12.20.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 20:55:45 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH v3] net: arcnet: com20020-pci: fix support for 2.5Mbit cards
Date: Thu, 12 Feb 2026 20:55:09 -0800
Message-ID: <20260213045510.32368-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216019-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8007132EAA
X-Rspamd-Action: no action

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
---
Changes from v1:
Rebase on latest mainline instead of net-next
Add received tag
Changes from v2:
Use card_info_2p5mbit if driver_data is NULL (see rationale above)
Remove modification of driver_data fields for each device because the
above makes it unnecessary
Rebase on latest mainline

I know the forward declaration of card_info_2p5mbit is not ideal, but
the alternative is moving all the card_info struct definitions earlier
in the file, which is too invasive for a bug fix that will be
backported to stable versions.

 drivers/net/arcnet/com20020-pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 19e411b2e3a7..dbadda08dce2 100644
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
2.43.0


