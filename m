Return-Path: <stable+bounces-214400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH46EDI+hGk71wMAu9opvQ
	(envelope-from <stable+bounces-214400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 07:52:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7292BEF27E
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 07:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 396F73004051
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 06:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE647330D32;
	Thu,  5 Feb 2026 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPBSjyV+"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9231A57C
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 06:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274344; cv=none; b=YRev6XxwGE+qK4ExRlGGAeO3yeUrRTjhoOK3n6PT2MNd1fKV/lVM3SVWpVs6sS9A3GHlaFYkcURXOrthVKXAtODoBijlGBh40oEJMB2FxP/CsJ8q0qKkqN3q/Kjt5QtY9qaO2jJkDu1U7xgJa88hQASwF9gm6EbG7gJc/haEl0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274344; c=relaxed/simple;
	bh=+vVoWX5sFN28i7ElAcVrMV2S8tLwXEb2jqKiNAZ9aNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fY47SUPlaiL81cA361GdCd8zQhZCS8VjrHjwt14VUDL2ZRSKeLMF8YPOb7z86S2wdJ13qLOdPd7TXEofLMVaJosdWyj+9RraKRsKfyIIXCLhKIchIS8DuYdyGXAmQmjNdPtS/I5VYaR1Q7LQYysPNMyCLVuV8C2ZkDayA49FaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPBSjyV+; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-45c93313721so428800b6e.2
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 22:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274343; x=1770879143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCXhBetIeM8B093OOufJcFHuH7QubNuOW96Pk4CsbeQ=;
        b=DPBSjyV+OMQuUHXi0cr5GlZii98goVYIjFJL6lV3dSAfoOEJsNoKium+k898+lrm7h
         zdmoCl9SCgVdzrTormS/7iFlv1u5Xd8vAQB/tX1gHzVbREA3iBjdpNG+W0qjibPDnGzp
         vfOuXTHeBxaqc5IyohdA2C1K8yOpgiRFOq9Md7hQfO/l9kpHxAjtp4tO61c1/DvBCsi6
         F69lnO23OyVUXHE2yn4rwkRO8MNEY1E0yT6e75/Ha/do/6gitaklnHQ7Z8Ue3onmKQJd
         0u+Z6HBV+nlaOB+2yM/Y5eO8Y0R+ZXEXsurqykiIgdYRef4YsNFJ1tZPo4rLyWztTiOZ
         qOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274343; x=1770879143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCXhBetIeM8B093OOufJcFHuH7QubNuOW96Pk4CsbeQ=;
        b=m8H9HlHHbHTSrGyQVpf75YdV4wOAZoxgHxPjSlXLd/oCl4mUFoM4L7ItyIzYIS1wM5
         JrUJg6TDC3tQsk9kMAEImhFo8/60J8BMkCRl5yszTBBinvYrjUapggL1xigDcGmhlbwH
         0HO+F9kiIzAd2HR6FpE+GuM0LXJdLhiMNwZX41Zlent7NwTzkO5tk6/YB3RlmT70oRYW
         BY0X2GScC8dvOXQf+AewLtFra8qTGTRXLBsfRfoyFNZI4n4SP3FZTkByhq/m0ndEdH9U
         QOpmA11Xs82URy7oyyS++AKJjuplE3xwvNo5QLf06F7I+/nuEe1p+vongrN2L0hiQrrr
         3Xsw==
X-Forwarded-Encrypted: i=1; AJvYcCXl9OkxAGjUM9r+1/q0q4Z7OHg4TnnI9b45NrVhn41j0Lw17uLy2dNUDu4A5Vn3eROadftspFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrSpWrwwTBEGbWXY+TYgAT4LENk/XB1SpsHdgJ9fiSd4KgzR2r
	7VMd1whCBlgPB1aISN1QfUbUFXrM1vPCtR9FpG0rVS6M/3WfVHMBLJUk
X-Gm-Gg: AZuq6aLj/MsmyKd9i46ZHXgi4NzT3Zt2zoUuCs/tX6+KshJwklPsUzUSSsG14GA1gqT
	4DqqEhNIXlZHptMYdDetX6ZKqNOSX2wvKAVdyn86c0o3drYxm8l29EhoCdJehpkT3kL9AOgBBWL
	eAWxxXSNNZJ0nY0Qq0ld24ExB8lMPGL6EnkrPGLbKA2AwClM9bDQ71cvwUPSPiPWPwl8jNi3+n5
	fk3ypilmpNKr/ypEf2Ol7SpeAvpq839TReCPFRDhO4FpuPuw6CprBakP9JWhr30rThO/ayFgL8u
	PbEqY0acoM0Q8U6FC8KhAFvlqghJuKLFiTDVVDF/yVPW9Zn3Djj+dzy8Soiq+Q2TuxFtP/jfFOf
	OI1gD+f16iPbc7gESq1duNsiNxs7zAaxfqSPN42BVSyms9CRkdzROcoLDT2pz/U2Hnzl65gA55U
	vDjGjAQg4ggt6ehjfCd86G3dvBkbq1YqnQvwZbHmJw+6PdCfT1GTtsNGLAbyxxv+6UiqEoT0G5L
	i254BwwA1hyxEmMOjsici7EZMUJetJ5FULja+ZiEkM1cA38+S5CG6icfgoY26ZYrHWJdiZn7ugJ
	60tz
X-Received: by 2002:a05:6808:4fce:b0:450:89ee:923d with SMTP id 5614622812f47-462d59f3861mr2634372b6e.31.1770274343294;
        Wed, 04 Feb 2026 22:52:23 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462d6801c3esm2743299b6e.21.2026.02.04.22.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 22:52:22 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH net-next] net: arcnet: com20020-pci: fix support for 2.5Mbit cards
Date: Wed,  4 Feb 2026 22:51:12 -0800
Message-ID: <20260205065113.33547-1-enelsonmoore@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,pengutronix.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214400-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7292BEF27E
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

Revert the incorrect fix and fix the original issue by introducing a
new card info structure for 2.5Mbit cards that does not set any flags.

Fixes: 8c14f9c70327 ("ARCNET: add com20020 PCI IDs with metadata")
Fixes: bd6f1fd5d33d ("net: arcnet: com20020: Fix null-ptr-deref in com20020pci_probe()")
Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/arcnet/com20020-pci.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/arcnet/com20020-pci.c b/drivers/net/arcnet/com20020-pci.c
index 0472bcdff130..4847f40a2095 100644
--- a/drivers/net/arcnet/com20020-pci.c
+++ b/drivers/net/arcnet/com20020-pci.c
@@ -139,9 +139,6 @@ static int com20020pci_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	ci = (struct com20020_pci_card_info *)id->driver_data;
-	if (!ci)
-		return -EINVAL;
-
 	priv->ci = ci;
 	mm = &ci->misc_map;
 
@@ -347,6 +344,18 @@ static struct com20020_pci_card_info card_info_5mbit = {
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
@@ -448,49 +457,49 @@ static const struct pci_device_id com20020pci_id_table[] = {
 		0x1571, 0xa001,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0,
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa002,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0,
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa003,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa004,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0,
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa005,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa006,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa007,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa008,
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0,
-		0
+		(kernel_ulong_t)&card_info_2p5mbit
 	},
 	{
 		0x1571, 0xa009,
-- 
2.43.0


