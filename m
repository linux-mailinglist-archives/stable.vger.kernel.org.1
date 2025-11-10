Return-Path: <stable+bounces-192959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB19C47095
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 14:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B35044EC576
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F09630FC0D;
	Mon, 10 Nov 2025 13:53:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from postmaster.electro-mail.ru (postmaster.electro-mail.ru [109.236.68.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E3225417;
	Mon, 10 Nov 2025 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.236.68.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782800; cv=none; b=bslTxE9wBz+iBCvmDoxplnpq59LLnyhWY8ezIJ84WnBwMVEksPCI7uDN9PxSED/RwUuf5u3kurM2vl3yMWLgSu7Kr8IcDDTSBQark+gJ3GknUwh4bridcHzk0SgsVi8O0Rz7eKG0qEXzcLGyVIe+I4AAuLmPJkEsHm3rEhOFC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782800; c=relaxed/simple;
	bh=PJKxtiMdy5PQki0XTyfXhR7VS9xxuP+6xbZzXQLijds=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ISMJ5PvESDgqQAUykmlVwS5i1f5p48pqLssXOJrw7EqPrspaT1wR+oGIvR6qLM3K93yvfzNkPvysMyFUTQ819HP+ZM5iiJ1MDEmQV6p+hrKhSCxX482rPB3hYW3h2IHy+cuJtBdeEs5cTid1i1ZlghDWUsWz+4zT40u6/Del650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru; spf=pass smtp.mailfrom=tpz.ru; arc=none smtp.client-ip=109.236.68.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tpz.ru
Received: from localhost (localhost [127.0.0.1])
	by postmaster.electro-mail.ru (Postfix) with ESMTP id 6EFD6FFC581;
	Mon, 10 Nov 2025 16:45:25 +0300 (MSK)
Received: from postmaster.electro-mail.ru ([127.0.0.1])
	by localhost (postmaster.electro-mail.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id l7jmAB_-WevC; Mon, 10 Nov 2025 16:45:25 +0300 (MSK)
Received: from postmaster.electro-mail.ru (localhost [127.0.0.1])
	by postmaster.electro-mail.ru (Postfix) with ESMTPS id E4BA8FFC582;
	Mon, 10 Nov 2025 16:45:24 +0300 (MSK)
Received: from email.electro-mail.ru (unknown [10.10.0.10])
	by postmaster.electro-mail.ru (Postfix) with ESMTPS id D5BCEFFC581;
	Mon, 10 Nov 2025 16:45:24 +0300 (MSK)
Received: from lvc.d-systems.local (109.236.68.122) by email.electro-mail.ru
 (10.120.0.4) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 10 Nov 2025
 16:45:23 +0300
From: Ilya Krutskih <devsec@tpz.ru>
To: <sdl@secdev.space>
CC: Ilya Krutskih <devsec@tpz.ru>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tglx@linutronix.de>, <mingo@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] net: fealnx: fixed possible out of band acces to an array
Date: Mon, 10 Nov 2025 13:44:22 +0000
Message-ID: <20251110134423.432612-1-devsec@tpz.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-ServerInfo: srv-mail-01.tpz.local, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 09.10.2024 20:59:00
X-KSE-Attachment-Filter-Scan-Result: Clean
X-KSE-Attachment-Filter-Scan-Result: skipped
Content-Transfer-Encoding: quoted-printable

fixed possible out of band access to an array=20
If the fealnx_init_one() function is called more than MAX_UNITS times=20
or card_idx is less than zero

Added a check: 0 <=3D card_idx < MAX_UNITS

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
---
 drivers/net/ethernet/fealnx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.=
c
index 6ac8547ef9b8..c7f2141a01fe 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -491,8 +491,8 @@ static int fealnx_init_one(struct pci_dev *pdev,
=20
 	card_idx++;
 	sprintf(boardname, "fealnx%d", card_idx);
-
-	option =3D card_idx < MAX_UNITS ? options[card_idx] : 0;
+	if (card_idx >=3D 0)
+		option =3D card_idx < MAX_UNITS ? options[card_idx] : 0;
=20
 	i =3D pci_enable_device(pdev);
 	if (i) return i;
@@ -623,7 +623,7 @@ static int fealnx_init_one(struct pci_dev *pdev,
 		np->default_port =3D option & 15;
 	}
=20
-	if (card_idx < MAX_UNITS && full_duplex[card_idx] > 0)
+	if ((0 <=3D card_idx && MAX_UNITS > card_idx) && full_duplex[card_idx] =
> 0)
 		np->mii.full_duplex =3D full_duplex[card_idx];
=20
 	if (np->mii.full_duplex) {
--=20
2.43.0


