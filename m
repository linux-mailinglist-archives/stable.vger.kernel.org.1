Return-Path: <stable+bounces-98699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBB79E4A23
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8865A1882199
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44872206F3F;
	Wed,  4 Dec 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIXbFf/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38AD215F6C;
	Wed,  4 Dec 2024 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355389; cv=none; b=NPdmNWKAjZAFZTQu37KcJkWMh+3fgY27zh4D9sadAnz+GYPhWdF0mkOAt8oTvkXWHJaupMOMFCm/GNRfMcpy9PG9TId70NhquCgy3rHxeuPkt7+a/M9Enuv+uHD38YZH4TiYYJURUwMcEVPXZDArDmHBPPTF1vvZHRykhlaqnjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355389; c=relaxed/simple;
	bh=tiaMZKtDv5lKJdWASKTc5/3vyxs1Ilxhz9tDEHXqeeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MyQOSutm+fYaguF7+WWYIJIKMXuv3AAqgri4mz1ZqnWiXryQNOqUD0k7mfA0J37gTimT1QbTP+UjFQiFrEHnb/gbH+CfPJw+ksFU19abX/wLKhrvyGmgucIUfITJ+w5mne8siR7MK5XoRR9wJR2I6sb0RU9PWWyVjTD5cA2jbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIXbFf/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C538DC4CECD;
	Wed,  4 Dec 2024 23:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355388;
	bh=tiaMZKtDv5lKJdWASKTc5/3vyxs1Ilxhz9tDEHXqeeo=;
	h=From:To:Cc:Subject:Date:From;
	b=vIXbFf/7coQteyWVICFlhaxkpUcHACv+5vcyMiUA8fhdG+8/wzvXly5fYETlg0McT
	 BFhZPX25yIf+Gb9DNxodmdiNxouFjOuT8YJrgPgcAkP0D0aOofdavDxRHNfeKwRAvP
	 Phhx10+yRp5whGon29dHIgnJWmKipFt1nPo+xV03TKJCMvQ0wClSdDEKFs1rC1ach+
	 eP6+9mMQE4SCID9+Gh+FazQs/GJuX22AZ4M+10gZGaxwUs7WBZySxv5JuotW5ij3Y2
	 Hh8LDnYYrbJR0tZhDaREyfHb9UYlCVxn9e3dotZu1uJjol+Om3y1lqpoYn2Agol9g2
	 DVZUnu4PI1yoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Parker Newman <pnewman@connecttech.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10] misc: eeprom: eeprom_93cx6: Add quirk for extra read clock cycle
Date: Wed,  4 Dec 2024 17:25:01 -0500
Message-ID: <20241204222508.2250488-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 9627294fe3e95..4c9827fe92173 100644
--- a/drivers/misc/eeprom/eeprom_93cx6.c
+++ b/drivers/misc/eeprom/eeprom_93cx6.c
@@ -186,6 +186,11 @@ void eeprom_93cx6_read(struct eeprom_93cx6 *eeprom, const u8 word,
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
@@ -252,6 +257,11 @@ void eeprom_93cx6_readb(struct eeprom_93cx6 *eeprom, const u8 byte,
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
index c860c72a921d0..3a485cc0e0fa0 100644
--- a/include/linux/eeprom_93cx6.h
+++ b/include/linux/eeprom_93cx6.h
@@ -11,6 +11,8 @@
 	Supported chipsets: 93c46, 93c56 and 93c66.
  */
 
+#include <linux/bits.h>
+
 /*
  * EEPROM operation defines.
  */
@@ -34,6 +36,7 @@
  * @register_write(struct eeprom_93cx6 *eeprom): handler to
  * write to the eeprom register by using all reg_* fields.
  * @width: eeprom width, should be one of the PCI_EEPROM_WIDTH_* defines
+ * @quirks: eeprom or controller quirks
  * @drive_data: Set if we're driving the data line.
  * @reg_data_in: register field to indicate data input
  * @reg_data_out: register field to indicate data output
@@ -50,6 +53,9 @@ struct eeprom_93cx6 {
 	void (*register_write)(struct eeprom_93cx6 *eeprom);
 
 	int width;
+	unsigned int quirks;
+/* Some EEPROMs require an extra clock cycle before reading */
+#define PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE	BIT(0)
 
 	char drive_data;
 	char reg_data_in;
@@ -71,3 +77,8 @@ extern void eeprom_93cx6_wren(struct eeprom_93cx6 *eeprom, bool enable);
 
 extern void eeprom_93cx6_write(struct eeprom_93cx6 *eeprom,
 			       u8 addr, u16 data);
+
+static inline bool has_quirk_extra_read_cycle(struct eeprom_93cx6 *eeprom)
+{
+	return eeprom->quirks & PCI_EEPROM_QUIRK_EXTRA_READ_CYCLE;
+}
-- 
2.43.0


