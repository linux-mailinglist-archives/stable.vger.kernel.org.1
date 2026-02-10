Return-Path: <stable+bounces-215584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL9TGliRimkQMAAAu9opvQ
	(envelope-from <stable+bounces-215584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:00:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F591161BC
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 03:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23A56301FF85
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 02:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FA12BD597;
	Tue, 10 Feb 2026 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTnjbCsP"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60621883E
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688839; cv=none; b=e2fC6A116yJRh36iMpeHboeL4F4m0bonPznRlR75LDmUGePGNXIogNtJorACJvlND0u2i+CjvB8na7mNtK/LMitSHP73Pw1/WMNc39UNncrRoMDtGUCCoZOCnMj09rXeF3LC6qXPI82leTKUHiUPgzjEhCajFJ51jd/pfPNWwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688839; c=relaxed/simple;
	bh=UJkIDp3mei6FigAUKfuCD/58P/3Z7xvlLeXNG9/FfTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cX5E+v2EI3ZjbBp/YoBs+wi9x4LFJMk5iBn8Hx0aHifHXdvzb5GiVMijjyYCU8a9jbIUcW+x4nzQBKXXbestYt873bhvhzwo1nXGYnf/NlLi1Vg90a6nqqKW6aihBNqS68DaOxTFl0V28aaNE8D6zjgthlGCCmnVxiZN9HldHiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTnjbCsP; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1270adc5121so395839c88.0
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 18:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770688836; x=1771293636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfY4Xzr/UFYtGolHiW+DJ/mV6vJV4fu9aHTEWwC08qI=;
        b=GTnjbCsPOiSy2X18BmYbXx2+UtXf7E1P+6+E7zI8Fs7SjdqCjhPP56KqnkHzZtgR+X
         RdfGFPAKQQDXILKDBjNiUybd66sZRBtvwYe4MKnAGvrLWsic+5tVvr/36dXK1v3FL4KR
         WS4LB+fjL3QAFlipFpV/6rDU8DsKJazdIgsF8hC3KKK6LFSO1qZwjQuzjK/qZ7W6yrJ/
         EMmKvBYTtjR2zOCqYQagWThZNXL2vi9uJh+hJ+5KQ+9KzBpoI4xJnI4S/4UlLChqckXB
         cIRK45amNTzWYu1BlIlL5tdkLMFLzMRcKyFGCRPaYK0u9wjukJs8PmEBqEQL69sxRCni
         +WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770688836; x=1771293636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfY4Xzr/UFYtGolHiW+DJ/mV6vJV4fu9aHTEWwC08qI=;
        b=MYLshRPyK/b6FqoYPoHuA/9XCwKbmPPHitx8hk7z4GUGWDOdJOkiVEWOe9MyVN4Ctn
         ZRmpHA4gYIvT70tKLHHatbQkmzr4ojF6Jil83NVwj+dg5a6XZ1G34VSxqFHGtSO7YEsa
         aZ/530T2HtzEPnm6U4yXOIhIqUvvS7u2LftVm8olKm+UXp8EsXivu4lIUL9X/hjfL+G4
         hL8iLQNh3gt9vbzkLSvvrrkd/cFkzUCyovw3TQq3xtJETRYwHRsLFafOfv9VISeJNfrf
         wzEaDglMrKJ2KJvbec+WNAY1/wDq0R57SiZr04HIVcaz7NAscBmhYspGw3NahUb+WiAS
         yliw==
X-Forwarded-Encrypted: i=1; AJvYcCVXJkSb6Mpq9luLhYJUePzRWzaOhAYb9qVVbycImuLc24nfw9Zws6lVjGe4VmVUQQVKlx8/0no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDKfBurKUcjtf4uAzXjZfF4Uz2v2Btc6oRltv1OWrtQml350M
	RZCcanEU9WOAi5UWqPNasffVcj9OKXb1FCJYlAAiviSjCf3nQPYCf5In
X-Gm-Gg: AZuq6aLwItW2rLymJYIzYl93ncs9XRuCXJ9d+jjFUw9eZ9E7YQ2flJrrmDOy3Jgy33z
	a5sKR6arjFmNoawwE+f63bsDm80BtM1GcD1c5pdF0oes5fKbLIIl2dYHyHHhCLWVQGnDEzhPFlw
	hLUqwcmLy0Lh37lw6FDzsyGi5uXQSfh1BOvJ/jWxlw10f+fMuE8NpuI38dGwKP4JlFBapOgqPpX
	japwqzkBjjRDiELH9sMGgst0kDbT5DrKUGDeviOJk5rZ7UTUATwFzC8KLDdFHZOtAwJFhQSb2BV
	KD5Tt+zI842t50CqFUfHt8HaNHJjsU8FQo4cbrEdLc02vLeCbmfGCNoEGIHzBO2UsGndSAuZy+1
	4NDgMppka1rg4FW4vYw7D48Z4GLMzxfgrU25q0CuQfdj7aX7f2cETbEiFrOSEZ2vAWEa7iB3ZyJ
	7J1t+ddrsdTHHyHJDFrUJ4exXGVDP897DmpMYaULQ6/pWFqDMdBxSun2PNW8mQe8911M/iNYfvC
	gueblen/DlMlpLZLCaiO8Aap1+aU3indsv1KNTgquvFOrYZXouc09SANOH2GNUkFI23BTyLi4kJ
	tAzaCZXWf3OM8yzOHg==
X-Received: by 2002:a05:7022:f97:b0:119:e56b:98be with SMTP id a92af1059eb24-1270405aa41mr6196402c88.37.1770688836142;
        Mon, 09 Feb 2026 18:00:36 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d9c91sm11239559c88.2.2026.02.09.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 18:00:35 -0800 (PST)
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
Subject: [PATCH v2] net: arcnet: com20020-pci: fix support for 2.5Mbit cards
Date: Mon,  9 Feb 2026 18:00:12 -0800
Message-ID: <20260210020012.11819-1-enelsonmoore@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-215584-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: C3F591161BC
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
Changes from v1:
Rebase on latest mainline instead of net-next
Add received tag

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


