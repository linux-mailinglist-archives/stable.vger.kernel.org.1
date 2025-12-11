Return-Path: <stable+bounces-200815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92690CB6BB9
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 18:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B0FE3019B89
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F15D32ED5E;
	Thu, 11 Dec 2025 17:31:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from postmaster.electro-mail.ru (postmaster.electro-mail.ru [109.236.68.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FF632ED47;
	Thu, 11 Dec 2025 17:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.236.68.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765474261; cv=none; b=m7W4cNcUFU/Vt2SHQZDzqdTbHWP8JnvswAe8/C6VPSGYIJ6UmVfkQ00D6vx4Ej79+xbXorIvNZJ9xN8JVABItPEt3TSyRP44YSxAJbHyMK6+20DbINZwbYnAeF3B2bNrVYMVLGF0RVTb3e72fU3vszdOynLz1LIyfYBNLQHdx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765474261; c=relaxed/simple;
	bh=ozU9m/XaU3oz5LPCsa3Se6LsM+CvWJ8+mGeve9FvDrQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jChrqBIuuZ2SmQHiGHk3EtHBHkkMfDhGxfoVoOq2TVCgY007gCA0TKaQe4ImKbO4OM5u3mXTmDGtiNGOr+z97G8PZ1bHS/fEHkhJmv8Of5b7nOt8OOODIYOrzKe+j6zRMETP3KI3wLxi4nIJ1WmgvrfhwIQF8hSerpRhFFts26k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru; spf=pass smtp.mailfrom=tpz.ru; arc=none smtp.client-ip=109.236.68.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tpz.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tpz.ru
Received: from localhost (localhost [127.0.0.1])
	by postmaster.electro-mail.ru (Postfix) with ESMTP id 7E0451006BA1;
	Thu, 11 Dec 2025 20:30:57 +0300 (MSK)
Received: from postmaster.electro-mail.ru ([127.0.0.1])
	by localhost (postmaster.electro-mail.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id FaFmj9ZbOJ-E; Thu, 11 Dec 2025 20:30:56 +0300 (MSK)
Received: from postmaster.electro-mail.ru (localhost [127.0.0.1])
	by postmaster.electro-mail.ru (Postfix) with ESMTPS id B9E841006E41;
	Thu, 11 Dec 2025 20:30:56 +0300 (MSK)
Received: from email.electro-mail.ru (unknown [10.10.0.10])
	by postmaster.electro-mail.ru (Postfix) with ESMTPS id A58621006BA1;
	Thu, 11 Dec 2025 20:30:56 +0300 (MSK)
Received: from lvc.d-systems.local (109.236.68.122) by email.electro-mail.ru
 (10.120.0.4) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 11 Dec 2025
 20:30:56 +0300
From: Ilya Krutskih <devsec@tpz.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Ilya Krutskih <devsec@tpz.ru>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
Subject: [PATCH v2] net: fealnx: fix possible 'card_idx' integer overflow in
Date: Thu, 11 Dec 2025 17:30:33 +0000
Message-ID: <20251211173035.852756-1-devsec@tpz.ru>
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

'card_idx' can be overflowed when fealnx_init_one() will be called more t=
han
INT_MAX times. Check before incremention is required.

Fixes: 15c037d6423e ("fealnx: Move the Myson driver")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Ilya Krutskih <devsec@tpz.ru>
---
 drivers/net/ethernet/fealnx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.=
c
index 6ac8547ef9b8..7eb6e42b4551 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -489,7 +489,10 @@ static int fealnx_init_one(struct pci_dev *pdev,
 	int bar =3D 1;
 #endif
=20
-	card_idx++;
+	if (card_idx =3D=3D INT_MAX)
+		return -EINVAL;
+	else
+		card_idx++;
 	sprintf(boardname, "fealnx%d", card_idx);
=20
 	option =3D card_idx < MAX_UNITS ? options[card_idx] : 0;
--=20
2.43.0


