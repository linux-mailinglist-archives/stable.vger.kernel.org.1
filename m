Return-Path: <stable+bounces-195234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9D1C730BA
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 10:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 874172BAF6
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8485302158;
	Thu, 20 Nov 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SYFq8EBP"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D294311971
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 09:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763629935; cv=none; b=MYCXYjNfqqUG3COx2iT2lFQz5hqdoPALZ5t0UnXD3ejEc1B4b80HZ9jMr0jlef79XXX2xJoJfKfcbegcZhsE0Cz4akYXqTuNtWPAjRTzBPWslptP6OKdy/zMZFoqkEmubkud5kqCF8eCsmbMHabCHnvD33VOBjLvbwdd2V1uNjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763629935; c=relaxed/simple;
	bh=CVl5hfHmm+btB3Wjc6ttnNrRk4deutzmxd5URUscRCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rdsajVBw8IWr0vAkuNU1mJI9LXX9lziEVWL3JNj0CQweW+AspcCSmnm86Y0IHvUsmelaXlZI2Lt++sANaxwcj6jW1QxfW1q2JiIYgI/0ColLW092LyYneXO66y8HBxsK530bvcLLmfq8COXLJ0X36z1E7r0dVtRLK4hIBC7yTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SYFq8EBP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 629801A1C1B;
	Thu, 20 Nov 2025 09:12:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3731B6068C;
	Thu, 20 Nov 2025 09:12:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5975510371C08;
	Thu, 20 Nov 2025 10:12:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763629929; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=s5kQlOxmcfPkYVGoAeCB+9DTT9baZsDkjUnBb6JjBt4=;
	b=SYFq8EBPeJVbn1cpMJtAJ0Aeg11Zkx2UKjs2SQprNp2jU7+9wh+g1SmZ1jgBwlrEUHLGNd
	m9R1suUQ9bQ8esbFemZr3z1vYMraDeV0NY2oCcewDSPp+920b6SkyYea3SgYb85T7HtJL2
	s8ksz49AAeCoyG2ObWNcjkcnzpj2t530B3MRCw/b4ntaVQJzXiqLmlwvrQKsWCaAktw4Oe
	ms5kbX4Jk0aLCwSSwoyPQD0sioIgSr2BY4fw+iFu63mVrkvEPehtHnCpqaSljwJ2bKLtLV
	N9T8pEekq/NDSK/XPe0tz2DJxkpIgCzhHn/LTK1MOlU7KTIhzrQHGtVmPmFRZg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net v6 0/5] net: dsa: microchip: Fix resource releases in
 error path
Date: Thu, 20 Nov 2025 10:11:59 +0100
Message-Id: <20251120-ksz-fix-v6-0-891f80ae7f8f@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF/bHmkC/2XMTW7DIBAF4KtErEvE8E9XvUeVhYEhQW1NZSwrb
 eS7B3mDIy/fm/neg1ScMlbyfnqQCZdccxlb0G8nEm7DeEWaY8uEM66ACaBf9Z+mfKfRC6liMlq
 oRNr374St3pY+yYgzubTylutcpr9tfYHtdBhagDJqUOqIzjmM8OFLmb/zeA7lZ1tZeJfAdJe8S
 WbA2qSZtUYcpdhJkF2KJofgvfAuBMHTUcq9NF3KJkEgxEHZQTp+lGovbZeqSYsumKS0Bhtf5bq
 uT0j+yHWNAQAA
X-Change-ID: 20251031-ksz-fix-db345df7635f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

I worked on adding PTP support for the KSZ8463. While doing so, I ran
into a few bugs in the resource release process that occur when things go
wrong arount IRQ initialization.

This small series fixes those bugs.

The next series, which will add the PTP support, depend on this one.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v6:
- PATCH 4: Jump in the middle of the release loop instead of partially
  freeing resource before jumping at the beginning of the release loop.
- PATCH 5: Add Andrew's Reviewed-By.
- Link to v5: https://lore.kernel.org/r/20251118-ksz-fix-v5-0-8e9c7f56618d@bootlin.com

Changes in v5:
- All: Add Cc Tag.
- PATCH 3: Use dsa_switch_for_each_user_port_continue_reverse() to only
  iterate over initialized ports.
- PATCH 4: Also clean PTP IRQs on port initialization failures
- Link to v4: https://lore.kernel.org/r/20251117-ksz-fix-v4-0-13e1da58a492@bootlin.com

Changes in v4:
- PATCH 1 & 2: Add Andrew's Reviewed-By.
- PATCH 3: Ensure ksz_irq is initialized outside of ksz_irq_free()
- Add PATCH 4
- PATCH 5: Fix symetry issues in ksz_ptp_msg_irq_{setup/free}()
- Link to v3: https://lore.kernel.org/r/20251114-ksz-fix-v3-0-acbb3b9cc32f@bootlin.com

Changes in v3:
- PATCH 1 and 3: Fix Fixes tags
- PATCH 3: Move the irq_dispose_mapping() behind the check that verifies that
  the domain is initialized
- Link to v2: https://lore.kernel.org/r/20251106-ksz-fix-v2-0-07188f608873@bootlin.com

Changes in v2:
- Add Fixes tag.
- Split PATCH 1 in two patches as it needed two different Fixes tags
- Add details in commit logs
- Link to v1: https://lore.kernel.org/r/20251031-ksz-fix-v1-0-7e46de999ed1@bootlin.com

---
Bastien Curutchet (Schneider Electric) (5):
      net: dsa: microchip: common: Fix checks on irq_find_mapping()
      net: dsa: microchip: ptp: Fix checks on irq_find_mapping()
      net: dsa: microchip: Don't free uninitialized ksz_irq
      net: dsa: microchip: Free previously initialized ports on init failures
      net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()

 drivers/net/dsa/microchip/ksz_common.c | 31 +++++++++++++++----------------
 drivers/net/dsa/microchip/ksz_ptp.c    | 22 +++++++++-------------
 2 files changed, 24 insertions(+), 29 deletions(-)
---
base-commit: 09652e543e809c2369dca142fee5d9b05be9bdc7
change-id: 20251031-ksz-fix-db345df7635f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


