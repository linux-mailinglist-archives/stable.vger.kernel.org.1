Return-Path: <stable+bounces-195112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DBDC6A911
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 17:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2D4734A282
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 16:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537EC377E8A;
	Tue, 18 Nov 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sqFEY4ia"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20FE36CE1C
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482415; cv=none; b=F5F7o74KcHvAeeYzVS8yZWs7PqgwG8M6SSKSuriJNp8UZHzK/yVT6Olg1RhDlGAqYjhnWsAsIQ4poI94BgYBZFi1IcXJjVUd4zqoWXtWKeBAcx9z8nrgACmlfRZZXTK8l0lPoJj3FHnIcm0YWn06YNwqYEQW9BOIA69M5GFHV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482415; c=relaxed/simple;
	bh=lAPNyTJ1GEFY5OPoEwNjO5UpqvyoZBL0K112gxw+NGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sG+KUckE6xakPwUfUj6ZnjB2tmw6xu7IoWhFKPCzdij2GTQhaS+S4JsPNLPIRnv0L+GW/9s8x2lMKUcm3sCkekHu15217D5TxCPb8luZmVcLwsmdaBG6p6NqjW7yt9Ty1yx5pSOWznLS9dvYl5rPjWsnC+7tT3CfRvhA3plHAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sqFEY4ia; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E24484E4174B;
	Tue, 18 Nov 2025 16:13:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A2964606FE;
	Tue, 18 Nov 2025 16:13:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FA94103713BD;
	Tue, 18 Nov 2025 17:13:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763482407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=18F8HvNkBMTVA24va0QSPZazhHlDhrHxqx+hxacAHKM=;
	b=sqFEY4ianaLduRLEsfX7VbHCvirK/9GY+Dt7+gM9kmVWZv0qVAB9XB5E58AO663SWUiNcZ
	1zvCbYt1GbPWuHa8ajQAcSoFukshTCrRmR/kD2tKDAzHou49kOrBRHCNnjcn+1Ryq7Rl5w
	w6eNoLcsrnZxs3xQaSgG2ALrB9qNI+NutajzjL0AmRQC4b2wW2kgVOi+L4cQkGW/uCDcaw
	16Kiv0OlW3fhLBheLHzf0YitG8/VcYXbMB7VDNr1vvULoLz3CyhkBdTyHdjYLlHk7PJqcj
	5MCO+fEL/GtHre1LckaK2e97wIn0Lt0jQKQsUsY+5KOEIC/38wqd+f6QCP5sqA==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net v5 0/5] net: dsa: microchip: Fix resource releases in
 error path
Date: Tue, 18 Nov 2025 17:13:21 +0100
Message-Id: <20251118-ksz-fix-v5-0-8e9c7f56618d@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGbHGkC/2XMTW7DIBAF4KtErEPFMGCgq96jysLA0KAkpjKWl
 R/57kXeOJWX781878UqjZkq+zy82EhzrrkMLejjgYVzP/wQz7FlJoXUIBD4pT55yncePSodk+l
 QJ9a+f0dq9br0zQaa2KmV51ynMj7W9RnW025oBi64IdVFcs5RhC9fynTNw0cot3VllpsE0W1SN
 ikMWJs6Ya3BvcQ3CWqT2GQfvEfvQkCZ9lK9S7NJ1SQgQey17ZWT/+WyLH+2s6XPUwEAAA==
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

 drivers/net/dsa/microchip/ksz_common.c | 34 +++++++++++++++++-----------------
 drivers/net/dsa/microchip/ksz_ptp.c    | 22 +++++++++-------------
 2 files changed, 26 insertions(+), 30 deletions(-)
---
base-commit: 09652e543e809c2369dca142fee5d9b05be9bdc7
change-id: 20251031-ksz-fix-db345df7635f

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


