Return-Path: <stable+bounces-98701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE7A9E4A18
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460B7285489
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490B12163AA;
	Wed,  4 Dec 2024 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/WCXuV5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9420DD5B;
	Wed,  4 Dec 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355408; cv=none; b=uMuX05zD1aALOo2W9F11JX8G+Cjff94p7+xrOiN7KaVFU7MSARiLc5HtPPf5FezaFyFGi5N/pYLErWkrAYF614QS6L0tqxxPn806d0i+Yby6U1AJd1YEpej6JjF4Xtw1mJlvexpQMYpNUvBAtY8i8CYoct1D2BzYjvA02fJ0/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355408; c=relaxed/simple;
	bh=MFtM7Jc8YQIYkycGN7zLxsOEYcWNogypf6UQuSlYpF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JDTQc6iBm4XiPn/e60k382n4rSNHwHtCDfZVH/aopiyTMzCuykOMrr1N8nu4fIU/nUQx9GPVHAScsfp+4jxbMVrcOLPF+LRX5ttjf060o3LvYOWpkIWsW/T/cOeVA/bs+gRQ2jsmGBee6v6rKYTPjvf2BaabnQ2bKedfedJlo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/WCXuV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271BCC4CECD;
	Wed,  4 Dec 2024 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355407;
	bh=MFtM7Jc8YQIYkycGN7zLxsOEYcWNogypf6UQuSlYpF0=;
	h=From:To:Cc:Subject:Date:From;
	b=D/WCXuV5lvBj+rrm7qQpMdEwtA2p+tOK09fSRY1QnMrzU4tJCgTYZY3X3O94hB51l
	 hXgdD8xGuOTGMT34ZmMqmhfXsKbfdmF6Ys6KgwYXSdI6t1UIiLUGt5s6DYJL7s2+Hv
	 Tyg8nHyVUYdZs4oweeUC8sHxAjsLhFEGdj+kY2dfZ/83Ss2vBuQrBUFc8GFxy5rXdV
	 +A1AWFJRMfKW+hbgwgePWPhy/0tvkq+fz+czc5C2temfORoWFSJjTTHQ5vA6Ub6/9v
	 56qdph5y2Xhh81LyWST2rgt2ngjLVahfl+gq48BdQrEoye1QWbSAzjAeLpKAJcawaM
	 E1ymNrEqbgh1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19] misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
Date: Wed,  4 Dec 2024 17:25:20 -0500
Message-ID: <20241204222528.2250575-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.324
Content-Transfer-Encoding: 8bit

From: Parker Newman <pnewman@connecttech.com>

[ Upstream commit 7738a7ab9d12c5371ed97114ee2132d4512e9fd5 ]

Add a quirk similar to eeprom_93xx46 to add an extra clock cycle before
reading data from the EEPROM.

The 93Cx6 family of EEPROMs output a "dummy 0 bit" between the writing
of the op-code/address from the host to the EEPROM and the reading of
the actual data from the EEPROM.

More info can be found on page 6 of the AT93C46 datasheet (linked below).
Similar notes are found in other 93xx6 datasheets.

In summary the read operation for a 93Cx6 EEPROM is:
Write to EEPROM:	110[A5-A0]	(9 bits)
Read from EEPROM:	0[D15-D0]	(17 bits)

Where:
	110 is the start bit and READ OpCode
	[A5-A0] is the address to read from
	0 is a "dummy bit" preceding the actual data
	[D15-D0] is the actual data.

Looking at the READ timing diagrams in the 93Cx6 datasheets the dummy
bit should be clocked out on the last address bit clock cycle meaning it
should be discarded naturally.

However, depending on the hardware configuration sometimes this dummy
bit is not discarded. This is the case with Exar PCI UARTs which require
an extra clock cycle between sending the address and reading the data.

Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-5193-SEEPROM-AT93C46D-Datasheet.pdf
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Parker Newman <pnewman@connecttech.com>
Link: https://lore.kernel.org/r/0f23973efefccd2544705a0480b4ad4c2353e407.1727880931.git.pnewman@connecttech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/eeprom/eeprom_93cx6.c | 10 ++++++++++
 include/linux/eeprom_93cx6.h       | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/misc/eeprom/eeprom_93cx6.c b/drivers/misc/eeprom/eeprom_93cx6.c
index 0cf2c9d676be8..31c69642f13e0 100644
--- a/drivers/misc/eeprom/eeprom_93cx6.c
+++ b/drivers/misc/eeprom/eeprom_93cx6.c
@@ -195,6 +195,11 @@ void eeprom_93cx6_read(struct eeprom_93cx6 *eeprom, const u8 word,
 	eeprom_93cx6_write_bits(eeprom, command,
 		PCI_EEPROM_WIDTH_OPCODE + eeprom->width);
 
+	if (has_quirk_extra_read_cycle(eeprom)) {
+		eeprom_93cx6_pulse_high(eeprom);
+		eeprom_93cx6_pulse_low(eeprom);
+	}
+
 	/*
 	 * Read the requested 16 bits.
 	 */
@@ -261,6 +266,11 @@ void eeprom_93cx6_readb(struct eeprom_93cx6 *eeprom, const u8 byte,
 	eeprom_93cx6_write_bits(eeprom, command,
 		PCI_EEPROM_WIDTH_OPCODE + eeprom->width + 1);
 
+	if (has_quirk_extra_read_cycle(eeprom)) {
+		eeprom_93cx6_pulse_high(eeprom);
+		eeprom_93cx6_pulse_low(eeprom);
+	}
+
 	/*
 	 * Read the requested 8 bits.
 	 */
diff --git a/include/linux/eeprom_93cx6.h b/include/linux/eeprom_93cx6.h
index eb0b1988050ae..ec913059a5299 100644
--- a/include/linux/eeprom_93cx6.h
+++ b/include/linux/eeprom_93cx6.h
@@ -24,6 +24,8 @@
 	Supported chipsets: 93c46, 93c56 and 93c66.
  */
 
+#include <linux/bits.h>
+
 /*
  * EEPROM operation defines.
  */
@@ -47,6 +49,7 @@
  * @register_write(struct eeprom_93cx6 *eeprom): handler to
  * write to the eeprom register by using all reg_* fields.
  * @width: eeprom width, should be one of the PCI_EEPROM_WIDTH_* defines
+ * @quirks: eeprom or controller quirks
  * @drive_data: Set if we're driving the data line.
  * @reg_data_in: register field to indicate data input
  * @reg_data_out: register field to indicate data output
@@ -63,6 +66,9 @@ struct eeprom_93cx6 {
 	void (*register_write)(struct eeprom_93cx6 *eeprom);
 
 	int width;
+	unsigned int quirks;
+/* Some EEPROMs require an extra clock cycle before reading */
+#define PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE	BIT(0)
 
 	char drive_data;
 	char reg_data_in;
@@ -84,3 +90,8 @@ extern void eeprom_93cx6_wren(struct eeprom_93cx6 *eeprom, bool enable);
 
 extern void eeprom_93cx6_write(struct eeprom_93cx6 *eeprom,
 			       u8 addr, u16 data);
+
+static inline bool has_quirk_extra_read_cycle(struct eeprom_93cx6 *eeprom)
+{
+	return eeprom->quirks & PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE;
+}
-- 
2.43.0


