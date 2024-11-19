Return-Path: <stable+bounces-93952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A42E59D25A3
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991461F24CFF
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A801CCB2B;
	Tue, 19 Nov 2024 12:19:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from queue02a.mail.zen.net.uk (queue02a.mail.zen.net.uk [212.23.3.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DF1CBE98;
	Tue, 19 Nov 2024 12:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.23.3.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018787; cv=none; b=tSvgNOuRT9M0JvP0EFHMNVhNx1wWV9OggMLYJMNTOrfUcUKo8wTT39PEQMdjxbZ/odbJuwaOS3gvZr0KRWElxrvTJGKPgQNg52Kr0aTn5n/JmLOTy/9LUTk+kgN7K+iBW8KpbBTmbCZ6B42DTEUdTeJLfbMIceWXEwGRl2olgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018787; c=relaxed/simple;
	bh=QA0E+wJRJTXUw1ekicDWUl5bcRQpYs/kNZZhAjykBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgSNyUkWuGVQPCVpXsmBm+I2DbM9Jx3B+XtPoVxLePPO+FeljBuL5zARPYw1bwi2fV/iEZdOACunBShM8H82pM3kRP2osUcPYD6VvKxgt0NAB1qPFZxvW0SoFCPQ0BfH6y08JQGKcZHx4+CZr4ORlGbhgKicKrCkpiaQbUvOZng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems; spf=fail smtp.mailfrom=starlabs.systems; arc=none smtp.client-ip=212.23.3.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=starlabs.systems
Received: from [212.23.1.21] (helo=smarthost01b.ixn.mail.zen.net.uk)
	by queue02a.mail.zen.net.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tDNCU-003pNW-QO;
	Tue, 19 Nov 2024 12:19:22 +0000
Received: from [217.155.46.38] (helo=sean-Byte.localdomain)
	by smarthost01b.ixn.mail.zen.net.uk with esmtp (Exim 4.95)
	(envelope-from <sean@starlabs.systems>)
	id 1tDNCM-00Ghb8-Tw;
	Tue, 19 Nov 2024 12:19:15 +0000
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Sean Rhodes <sean@starlabs.systems>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/3] Revert "staging: remove rts5139 driver code"
Date: Tue, 19 Nov 2024 12:19:10 +0000
Message-ID: <20241119121912.12383-1-sean@starlabs.systems>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-smarthost01b-IP: [217.155.46.38]
Feedback-ID: 217.155.46.38

This reverts commit 00d8521dcd236d1b8f664f54a0309e96bfdcb4f9.

The staging driver that was removed, `rts5139`, worked well with multiple
Realtek card readers and provided more comprehensive functionality than
`rtsx_usb`. It supported features like interrupts, SSC, speed modes,
suspend, secure erase, TRIM, and more. Additionally, its error recovery
mechanisms were superior.

Notable issues with the `rtsx_usb` driver include delayed S3 entry until
`mmc_rescan` was frozen and data corruption on SDR104 cards. Over 100 bugs
related to the `rtsx_usb` driver are reported on Bugzilla, with additional
reports downstream. As a result, several forks of `rts5139` exist on
GitHub and other repositories, which users rely on to mitigate these
problems.

Reintroducing `rts5139` addresses these deficiencies until the current
`rtsx_usb` driver achieves feature parity and stability.

Fixes: 00d8521dcd23 ("staging: remove rts5139 driver code")
Cc: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/staging/Kconfig                    |    2 +
 drivers/staging/Makefile                   |    1 +
 drivers/staging/rts5139/Kconfig            |   16 +
 drivers/staging/rts5139/Makefile           |   43 +
 drivers/staging/rts5139/TODO               |    9 +
 drivers/staging/rts5139/debug.h            |   46 +
 drivers/staging/rts5139/ms.c               | 4182 ++++++++++++++++++++
 drivers/staging/rts5139/ms.h               |  261 ++
 drivers/staging/rts5139/ms_mg.c            |  643 +++
 drivers/staging/rts5139/ms_mg.h            |   42 +
 drivers/staging/rts5139/rts51x.c           |  846 ++++
 drivers/staging/rts5139/rts51x.h           |  194 +
 drivers/staging/rts5139/rts51x_card.c      |  940 +++++
 drivers/staging/rts5139/rts51x_card.h      |  870 ++++
 drivers/staging/rts5139/rts51x_chip.c      | 1014 +++++
 drivers/staging/rts5139/rts51x_chip.h      |  821 ++++
 drivers/staging/rts5139/rts51x_fop.c       |  295 ++
 drivers/staging/rts5139/rts51x_fop.h       |   57 +
 drivers/staging/rts5139/rts51x_scsi.c      | 2135 ++++++++++
 drivers/staging/rts5139/rts51x_scsi.h      |  154 +
 drivers/staging/rts5139/rts51x_transport.c |  738 ++++
 drivers/staging/rts5139/rts51x_transport.h |   67 +
 drivers/staging/rts5139/sd.c               | 3274 +++++++++++++++
 drivers/staging/rts5139/sd.h               |  275 ++
 drivers/staging/rts5139/sd_cprm.c          | 1056 +++++
 drivers/staging/rts5139/sd_cprm.h          |   54 +
 drivers/staging/rts5139/trace.h            |   95 +
 drivers/staging/rts5139/xd.c               | 2145 ++++++++++
 drivers/staging/rts5139/xd.h               |  191 +
 29 files changed, 20466 insertions(+)
 create mode 100644 drivers/staging/rts5139/Kconfig
 create mode 100644 drivers/staging/rts5139/Makefile
 create mode 100644 drivers/staging/rts5139/TODO
 create mode 100644 drivers/staging/rts5139/debug.h
 create mode 100644 drivers/staging/rts5139/ms.c
 create mode 100644 drivers/staging/rts5139/ms.h
 create mode 100644 drivers/staging/rts5139/ms_mg.c
 create mode 100644 drivers/staging/rts5139/ms_mg.h
 create mode 100644 drivers/staging/rts5139/rts51x.c
 create mode 100644 drivers/staging/rts5139/rts51x.h
 create mode 100644 drivers/staging/rts5139/rts51x_card.c
 create mode 100644 drivers/staging/rts5139/rts51x_card.h
 create mode 100644 drivers/staging/rts5139/rts51x_chip.c
 create mode 100644 drivers/staging/rts5139/rts51x_chip.h
 create mode 100644 drivers/staging/rts5139/rts51x_fop.c
 create mode 100644 drivers/staging/rts5139/rts51x_fop.h
 create mode 100644 drivers/staging/rts5139/rts51x_scsi.c
 create mode 100644 drivers/staging/rts5139/rts51x_scsi.h
 create mode 100644 drivers/staging/rts5139/rts51x_transport.c
 create mode 100644 drivers/staging/rts5139/rts51x_transport.h
 create mode 100644 drivers/staging/rts5139/sd.c
 create mode 100644 drivers/staging/rts5139/sd.h
 create mode 100644 drivers/staging/rts5139/sd_cprm.c
 create mode 100644 drivers/staging/rts5139/sd_cprm.h
 create mode 100644 drivers/staging/rts5139/trace.h
 create mode 100644 drivers/staging/rts5139/xd.c
 create mode 100644 drivers/staging/rts5139/xd.h

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 3fb68d60dfc1..732afa01a31e 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -32,6 +32,8 @@ source "drivers/staging/rtl8723bs/Kconfig"
 
 source "drivers/staging/rtl8712/Kconfig"
 
+source "drivers/staging/rts5139/Kconfig"
+
 source "drivers/staging/rts5208/Kconfig"
 
 source "drivers/staging/octeon/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index c977aa13fad4..9212c4a003f8 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_FB_OLPC_DCON)	+= olpc_dcon/
 obj-$(CONFIG_RTL8192E)		+= rtl8192e/
 obj-$(CONFIG_RTL8723BS)		+= rtl8723bs/
 obj-$(CONFIG_R8712U)		+= rtl8712/
+obj-$(CONFIG_RTS5139)		+= rts5139/
 obj-$(CONFIG_RTS5208)		+= rts5208/
 obj-$(CONFIG_OCTEON_ETHERNET)	+= octeon/
 obj-$(CONFIG_VT6655)		+= vt6655/
diff --git a/drivers/staging/rts5139/Kconfig b/drivers/staging/rts5139/Kconfig
new file mode 100644
index 000000000000..afd526bf422a
--- /dev/null
+++ b/drivers/staging/rts5139/Kconfig
@@ -0,0 +1,16 @@
+config RTS5139
+	tristate "Realtek RTS5139 USB card reader support"
+	depends on USB && SCSI
+	help
+	  Say Y here to include driver code to support the Realtek
+	  RTS5139 USB card readers.
+
+	  If this driver is compiled as a module, it will be named rts5139.
+
+config RTS5139_DEBUG
+	bool "Realtek RTS5139 Card Reader verbose debug"
+	depends on RTS5139
+	help
+	  Say Y here in order to have the rts5139 code generate
+	  verbose debugging messages.
+
diff --git a/drivers/staging/rts5139/Makefile b/drivers/staging/rts5139/Makefile
new file mode 100644
index 000000000000..75dd31224e62
--- /dev/null
+++ b/drivers/staging/rts5139/Makefile
@@ -0,0 +1,43 @@
+# Driver for Realtek RTS51xx USB card reader
+#
+# Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms of the GNU General Public License as published by the
+# Free Software Foundation; either version 2, or (at your option) any
+# later version.
+#
+# This program is distributed in the hope that it will be useful, but
+# WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along
+# with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+# Author:
+#   wwang (wei_wang@realsil.com.cn)
+#   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+# Maintainer:
+#   Edwin Rong (edwin_rong@realsil.com.cn)
+#   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+#
+# Makefile for the RTS51xx USB Card Reader drivers.
+#
+
+obj-$(CONFIG_RTS5139) := rts5139.o
+
+ccflags-y := -Idrivers/scsi
+
+rts5139-y :=				\
+		rts51x_transport.o 	\
+		rts51x_scsi.o		\
+		rts51x_fop.o		\
+		rts51x.o		\
+		rts51x_chip.o		\
+		rts51x_card.o		\
+		xd.o			\
+		sd.o			\
+		ms.o			\
+		sd_cprm.o		\
+		ms_mg.o
diff --git a/drivers/staging/rts5139/TODO b/drivers/staging/rts5139/TODO
new file mode 100644
index 000000000000..dd5fabb8ea70
--- /dev/null
+++ b/drivers/staging/rts5139/TODO
@@ -0,0 +1,9 @@
+TODO:
+- support more USB card reader of Realtek family
+- use kernel coding style
+- checkpatch.pl fixes
+- stop having thousands of lines of code duplicated with staging/rts_pstor
+- This driver contains an entire SD/MMC stack -- it should use the stack in
+  drivers/mmc instead, as a host driver e.g. drivers/mmc/host/realtek-usb.c;
+  see drivers/mmc/host/ushc.c as an example.
+- This driver presents cards as SCSI devices, but they should be MMC devices.
diff --git a/drivers/staging/rts5139/debug.h b/drivers/staging/rts5139/debug.h
new file mode 100644
index 000000000000..73dec133a1bf
--- /dev/null
+++ b/drivers/staging/rts5139/debug.h
@@ -0,0 +1,46 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_DEBUG_H
+#define __RTS51X_DEBUG_H
+
+#include <linux/kernel.h>
+
+#define RTS51X_TIP "rts51x: "
+
+#ifdef CONFIG_RTS5139_DEBUG
+#define RTS51X_DEBUGP(x...) printk(KERN_DEBUG RTS51X_TIP x)
+#define RTS51X_DEBUGPN(x...) printk(KERN_DEBUG x)
+#define RTS51X_DEBUGPX(x...) printk(x)
+#define RTS51X_DEBUG(x) x
+#else
+#define RTS51X_DEBUGP(x...)
+#define RTS51X_DEBUGPN(x...)
+#define RTS51X_DEBUGPX(x...)
+#define RTS51X_DEBUG(x)
+#endif
+
+#endif /* __RTS51X_DEBUG_H */
diff --git a/drivers/staging/rts5139/ms.c b/drivers/staging/rts5139/ms.c
new file mode 100644
index 000000000000..a843a2f4392b
--- /dev/null
+++ b/drivers/staging/rts5139/ms.c
@@ -0,0 +1,4182 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "debug.h"
+#include "trace.h"
+#include "rts51x.h"
+#include "rts51x_transport.h"
+#include "rts51x_scsi.h"
+#include "rts51x_card.h"
+#include "ms.h"
+#include "ms_mg.h"
+
+static inline void ms_set_err_code(struct rts51x_chip *chip, u8 err_code)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+
+	ms_card->err_code = err_code;
+}
+
+static inline int ms_check_err_code(struct rts51x_chip *chip, u8 err_code)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+
+	return ms_card->err_code == err_code;
+}
+
+static int ms_parse_err_code(struct rts51x_chip *chip)
+{
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+static int ms_transfer_tpc(struct rts51x_chip *chip, u8 trans_mode, u8 tpc,
+			   u8 cnt, u8 cfg)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+
+	RTS51X_DEBUGP("ms_transfer_tpc: tpc = 0x%x\n", tpc);
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TPC, 0xFF, tpc);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_BYTE_CNT, 0xFF, cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF, cfg);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       PINGPONG_BUFFER);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+		       MS_TRANSFER_START | trans_mode);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER, MS_TRANSFER_END,
+		       MS_TRANSFER_END);
+
+	rts51x_add_cmd(chip, READ_REG_CMD, MS_TRANS_CFG, 0, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 2, 5000);
+	if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+		rts51x_clear_ms_error(chip);
+		ms_set_err_code(chip, MS_TO_ERROR);
+		TRACE_RET(chip, ms_parse_err_code(chip));
+	}
+
+	if (!(tpc & 0x08)) {	/* Read Packet */
+		/* Check CRC16 & Ready Timeout */
+		if (chip->rsp_buf[1] & MS_CRC16_ERR) {
+			ms_set_err_code(chip, MS_CRC16_ERROR);
+			TRACE_RET(chip, ms_parse_err_code(chip));
+		}
+	} else { /* Write Packet */
+		if (CHK_MSPRO(ms_card) && !(chip->rsp_buf[1] & 0x80)) {
+			if (chip->rsp_buf[1] & (MS_INT_ERR | MS_INT_CMDNK)) {
+				ms_set_err_code(chip, MS_CMD_NK);
+				TRACE_RET(chip, ms_parse_err_code(chip));
+			}
+		}
+	}
+
+	/* Check Timeout of Ready Signal */
+	if (chip->rsp_buf[1] & MS_RDY_TIMEOUT) {
+		rts51x_clear_ms_error(chip);
+		ms_set_err_code(chip, MS_TO_ERROR);
+		TRACE_RET(chip, ms_parse_err_code(chip));
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int ms_transfer_data(struct rts51x_chip *chip, u8 trans_mode, u8 tpc,
+		     u16 sec_cnt, u8 cfg, int mode_2k, int use_sg, void *buf,
+		     int buf_len)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	u8 val, err_code = 0, flag = 0;
+	enum dma_data_direction dir;
+	unsigned int pipe;
+
+	if (!buf || !buf_len)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if (trans_mode == MS_TM_AUTO_READ) {
+		pipe = RCV_BULK_PIPE(chip);
+		dir = DMA_FROM_DEVICE;
+		flag = MODE_CDIR;
+		err_code = MS_FLASH_READ_ERROR;
+	} else if (trans_mode == MS_TM_AUTO_WRITE) {
+		pipe = SND_BULK_PIPE(chip);
+		dir = DMA_TO_DEVICE;
+		flag = MODE_CDOR;
+		err_code = MS_FLASH_WRITE_ERROR;
+	} else {
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TPC, 0xFF, tpc);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_SECTOR_CNT_H, 0xFF,
+		       (u8) (sec_cnt >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_SECTOR_CNT_L, 0xFF,
+		       (u8) sec_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF, cfg);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       RING_BUFFER);
+
+	if (mode_2k)
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_CFG, MS_2K_SECTOR_MODE,
+			       MS_2K_SECTOR_MODE);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_CFG, MS_2K_SECTOR_MODE,
+			       0);
+
+	rts51x_trans_dma_enable(dir, chip, sec_cnt * 512, DMA_512);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+		       MS_TRANSFER_START | trans_mode);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER, MS_TRANSFER_END,
+		       MS_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, flag | STAGE_MS_STATUS, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval =
+	    rts51x_transfer_data_rcc(chip, pipe, buf, buf_len, use_sg, NULL,
+				     15000, flag);
+	if (retval != STATUS_SUCCESS) {
+		ms_set_err_code(chip, err_code);
+		rts51x_clear_ms_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	retval = rts51x_get_rsp(chip, 3, 15000);
+	if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+		ms_set_err_code(chip, err_code);
+		rts51x_clear_ms_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	ms_card->last_rw_int = val = chip->rsp_buf[1];
+	if (val & (MS_INT_CMDNK | MS_INT_ERR | MS_CRC16_ERR | MS_RDY_TIMEOUT))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+int ms_write_bytes(struct rts51x_chip *chip, u8 tpc, u8 cnt, u8 cfg, u8 *data,
+		   int data_len)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+
+	if (!data || (data_len < cnt))
+		TRACE_RET(chip, STATUS_ERROR);
+
+	rts51x_init_cmd(chip);
+
+	for (i = 0; i < cnt; i++) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, PPBUF_BASE2 + i, 0xFF,
+			       data[i]);
+	}
+	if (cnt % 2)
+		rts51x_add_cmd(chip, WRITE_REG_CMD, PPBUF_BASE2 + i,
+				0xFF, 0xFF);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TPC, 0xFF, tpc);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_BYTE_CNT, 0xFF, cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF, cfg);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       PINGPONG_BUFFER);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+		       MS_TRANSFER_START | MS_TM_WRITE_BYTES);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER, MS_TRANSFER_END,
+		       MS_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 1, 5000);
+	if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+		u8 val = 0;
+
+		rts51x_ep0_read_register(chip, MS_TRANS_CFG, &val);
+		RTS51X_DEBUGP("MS_TRANS_CFG: 0x%02x\n", val);
+
+		rts51x_clear_ms_error(chip);
+
+		if (!(tpc & 0x08)) { /* Read Packet */
+			/* Check CRC16 & Ready Timeout */
+			if (val & MS_CRC16_ERR) {
+				ms_set_err_code(chip, MS_CRC16_ERROR);
+				TRACE_RET(chip, ms_parse_err_code(chip));
+			}
+		} else { /* Write Packet */
+			if (CHK_MSPRO(ms_card) && !(val & 0x80)) {
+				if (val & (MS_INT_ERR | MS_INT_CMDNK)) {
+					ms_set_err_code(chip, MS_CMD_NK);
+					TRACE_RET(chip,
+						  ms_parse_err_code(chip));
+				}
+			}
+		}
+
+		/* Check Timeout of Ready Signal */
+		if (val & MS_RDY_TIMEOUT) {
+			ms_set_err_code(chip, MS_TO_ERROR);
+			TRACE_RET(chip, ms_parse_err_code(chip));
+		}
+
+		ms_set_err_code(chip, MS_TO_ERROR);
+		TRACE_RET(chip, ms_parse_err_code(chip));
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int ms_read_bytes(struct rts51x_chip *chip, u8 tpc, u8 cnt, u8 cfg, u8 *data,
+		  int data_len)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+
+	if (!data)
+		TRACE_RET(chip, STATUS_ERROR);
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TPC, 0xFF, tpc);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_BYTE_CNT, 0xFF, cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF, cfg);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       PINGPONG_BUFFER);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+		       MS_TRANSFER_START | MS_TM_READ_BYTES);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER, MS_TRANSFER_END,
+		       MS_TRANSFER_END);
+
+	for (i = 0; i < data_len - 1; i++)
+		rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + i, 0, 0);
+
+	if (data_len % 2)
+		rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + data_len, 0,
+			       0);
+	else
+		rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + data_len - 1,
+			       0, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, data_len + 1, 5000);
+	if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+		u8 val = 0;
+
+		rts51x_ep0_read_register(chip, MS_TRANS_CFG, &val);
+		RTS51X_DEBUGP("MS_TRANS_CFG: 0x%02x\n", val);
+
+		rts51x_clear_ms_error(chip);
+
+		if (!(tpc & 0x08)) { /* Read Packet */
+			/* Check CRC16 & Ready Timeout */
+			if (val & MS_CRC16_ERR) {
+				ms_set_err_code(chip, MS_CRC16_ERROR);
+				TRACE_RET(chip, ms_parse_err_code(chip));
+			}
+		} else { /* Write Packet */
+			if (CHK_MSPRO(ms_card) && !(val & 0x80)) {
+				if (val & (MS_INT_ERR | MS_INT_CMDNK)) {
+					ms_set_err_code(chip, MS_CMD_NK);
+					TRACE_RET(chip,
+						  ms_parse_err_code(chip));
+				}
+			}
+		}
+
+		/* Check Timeout of Ready Signal */
+		if (val & MS_RDY_TIMEOUT) {
+			ms_set_err_code(chip, MS_TO_ERROR);
+			TRACE_RET(chip, ms_parse_err_code(chip));
+		}
+
+		ms_set_err_code(chip, MS_TO_ERROR);
+		TRACE_RET(chip, ms_parse_err_code(chip));
+	}
+
+	rts51x_read_rsp_buf(chip, 1, data, data_len);
+
+	return STATUS_SUCCESS;
+}
+
+int ms_set_rw_reg_addr(struct rts51x_chip *chip,
+		       u8 read_start, u8 read_cnt, u8 write_start, u8 write_cnt)
+{
+	int retval, i;
+	u8 data[4];
+
+	data[0] = read_start;
+	data[1] = read_cnt;
+	data[2] = write_start;
+	data[3] = write_cnt;
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, SET_RW_REG_ADRS, 4, NO_WAIT_INT, data,
+				   4);
+		if (retval == STATUS_SUCCESS)
+			return STATUS_SUCCESS;
+		rts51x_clear_ms_error(chip);
+	}
+
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+static int ms_send_cmd(struct rts51x_chip *chip, u8 cmd, u8 cfg)
+{
+	u8 data[2];
+
+	data[0] = cmd;
+	data[1] = 0;
+
+	return ms_write_bytes(chip, PRO_SET_CMD, 1, cfg, data, 1);
+}
+
+static int ms_set_cmd(struct rts51x_chip *chip,
+		      u8 read_start, u8 read_count,
+		      u8 write_start, u8 write_count,
+		      u8 cmd, u8 cfg, u8 *data, int data_len, u8 *int_stat)
+{
+	int retval, i;
+	u8 val;
+
+	if (!data || (data_len <= 0) || (data_len > 128)) {
+		RTS51X_DEBUGP("ms_set_cmd (data_len = %d)\n", data_len);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	retval =
+	    ms_set_rw_reg_addr(chip, read_start, read_count, write_start,
+			       write_count);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, WRITE_REG, write_count, NO_WAIT_INT,
+				   data, data_len);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	ms_set_err_code(chip, MS_NO_ERROR);
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval = ms_send_cmd(chip, cmd, WAIT_INT);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+	/* GET_INT Register */
+	ms_set_err_code(chip, MS_NO_ERROR);
+	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (int_stat)
+		*int_stat = val;
+
+	return STATUS_SUCCESS;
+}
+
+#ifdef MS_SPEEDUP
+static int ms_auto_set_cmd(struct rts51x_chip *chip,
+			   u8 read_start, u8 read_count,
+			   u8 write_start, u8 write_count,
+			   u8 cmd, u8 cfg, u8 *data, int data_len,
+			   u8 *int_stat)
+{
+	int retval;
+	int i;
+
+	if (!data || (data_len <= 0) || (data_len > 128)) {
+		RTS51X_DEBUGP("ms_auto_set_cmd (data_len = %d)\n", data_len);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_READ_START, 0xFF, read_start);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_READ_COUNT, 0xFF, read_count);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_WRITE_START, 0xFF, write_start);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_WRITE_COUNT, 0xFF, write_count);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_COMMAND, 0xFF, cmd);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF, cfg);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       PINGPONG_BUFFER);
+
+	for (i = 0; i < data_len; i++) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, PPBUF_BASE2 + i, 0xFF,
+			       data[i]);
+	}
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+		       MS_TRANSFER_START | MS_TM_SET_CMD);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER, MS_TRANSFER_END,
+		       MS_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CR | STAGE_MS_STATUS, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 3, 5000);
+
+	if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+		rts51x_clear_ms_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (int_stat)
+		*int_stat = chip->rsp_buf[2];
+
+	return STATUS_SUCCESS;
+}
+#endif
+
+static int ms_set_init_para(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+
+	if (CHK_HG8BIT(ms_card)) {
+		if (chip->asic_code)
+			ms_card->ms_clock = chip->option.asic_ms_hg_clk;
+		else
+			ms_card->ms_clock = chip->option.fpga_ms_hg_clk;
+	} else if (CHK_MSPRO(ms_card) || CHK_MS4BIT(ms_card)) {
+		if (chip->asic_code)
+			ms_card->ms_clock = chip->option.asic_ms_4bit_clk;
+		else
+			ms_card->ms_clock = chip->option.fpga_ms_4bit_clk;
+	} else {
+		if (chip->asic_code)
+			ms_card->ms_clock = 38;
+		else
+			ms_card->ms_clock = CLK_40;
+	}
+
+	retval = switch_clock(chip, ms_card->ms_clock);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_select_card(chip, MS_CARD);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+int ms_switch_clock(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+
+	retval = rts51x_select_card(chip, MS_CARD);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = switch_clock(chip, ms_card->ms_clock);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static void ms_pull_ctl_disable(struct rts51x_chip *chip)
+{
+	if (CHECK_PKG(chip, LQFP48)) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0xA5);
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0x65);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x56);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0x59);
+	}
+}
+
+static void ms_pull_ctl_enable(struct rts51x_chip *chip)
+{
+	if (CHECK_PKG(chip, LQFP48)) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0xA5);
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0x65);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0x59);
+	}
+}
+
+static int ms_prepare_reset(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+
+	ms_card->ms_type = 0;
+	ms_card->check_ms_flow = 0;
+	ms_card->switch_8bit_fail = 0;
+	ms_card->delay_write.delay_write_flag = 0;
+
+	ms_card->pro_under_formatting = 0;
+
+	rts51x_init_cmd(chip);
+
+	if (chip->asic_code) {
+		ms_pull_ctl_enable(chip);
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, FPGA_PULL_CTL,
+			       FPGA_MS_PULL_CTL_BIT | 0x20, 0);
+	}
+	/* Tri-state MS output */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, MS_OUTPUT_EN, 0);
+
+	if (!chip->option.FT2_fast_mode) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK,
+			       POWER_OFF);
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (!chip->option.FT2_fast_mode) {
+		wait_timeout(250);
+
+		rts51x_card_power_on(chip, MS_CARD);
+		wait_timeout(150);
+
+#ifdef SUPPORT_OCP
+		rts51x_get_card_status(chip, &(chip->card_status));
+		/* get OCP status */
+		chip->ocp_stat = (chip->card_status >> 4) & 0x03;
+
+		if (chip->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
+			RTS51X_DEBUGP("Over current, OCPSTAT is 0x%x\n",
+				       chip->ocp_stat);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+#endif
+	}
+
+	rts51x_init_cmd(chip);
+
+	/* Enable MS Output */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, MS_OUTPUT_EN,
+		       MS_OUTPUT_EN);
+
+	/* Reset Registers */
+	if (chip->asic_code)
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_CFG, 0xFF,
+			       SAMPLE_TIME_RISING | PUSH_TIME_DEFAULT |
+			       NO_EXTEND_TOGGLE | MS_BUS_WIDTH_1);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_CFG, 0xFF,
+			       SAMPLE_TIME_FALLING | PUSH_TIME_DEFAULT |
+			       NO_EXTEND_TOGGLE | MS_BUS_WIDTH_1);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF,
+		       NO_WAIT_INT | NO_AUTO_READ_INT_REG);
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return ms_set_init_para(chip);
+}
+
+static int ms_identify_media_type(struct rts51x_chip *chip, int switch_8bit_bus)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	u8 val;
+
+	retval = ms_set_rw_reg_addr(chip, Pro_StatusReg, 6, SystemParm, 1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	/* Get Register form MS-PRO card */
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_transfer_tpc(chip, MS_TM_READ_BYTES, READ_REG, 6,
+				    NO_WAIT_INT);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	RTS51X_READ_REG(chip, PPBUF_BASE2 + 2, &val);
+	RTS51X_DEBUGP("Type register: 0x%x\n", val);
+	if (val != 0x01) {
+		if (val != 0x02)
+			ms_card->check_ms_flow = 1;
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	/* Category Register */
+	RTS51X_READ_REG(chip, PPBUF_BASE2 + 4, &val);
+	RTS51X_DEBUGP("Category register: 0x%x\n", val);
+	if (val != 0) {
+		ms_card->check_ms_flow = 1;
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	/* Class Register */
+	RTS51X_READ_REG(chip, PPBUF_BASE2 + 5, &val);
+	RTS51X_DEBUGP("Class register: 0x%x\n", val);
+	if (val == 0) {
+		RTS51X_READ_REG(chip, PPBUF_BASE2, &val);
+		if (val & WRT_PRTCT)
+			chip->card_wp |= MS_CARD;
+		else
+			chip->card_wp &= ~MS_CARD;
+	} else if ((val == 0x01) || (val == 0x02) || (val == 0x03)) {
+		chip->card_wp |= MS_CARD;
+	} else {
+		ms_card->check_ms_flow = 1;
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	ms_card->ms_type |= TYPE_MSPRO;
+
+	/* Check MSPro-HG Card, use IF Mode Register to distinguish */
+	RTS51X_READ_REG(chip, PPBUF_BASE2 + 3, &val);
+	RTS51X_DEBUGP("IF Mode register: 0x%x\n", val);
+	if (val == 0) {
+		ms_card->ms_type &= 0x0F;
+	} else if (val == 7) {
+		if (switch_8bit_bus)
+			ms_card->ms_type |= MS_HG;
+		else
+			ms_card->ms_type &= 0x0F;
+	} else {
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	/* end Procedure to identify Media Type */
+	return STATUS_SUCCESS;
+}
+
+static int ms_confirm_cpu_startup(struct rts51x_chip *chip)
+{
+	int retval, i, k;
+	u8 val;
+
+	/* Confirm CPU StartUp */
+	k = 0;
+	do {
+		if (monitor_card_cd(chip, MS_CARD) == CD_NOT_EXIST)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+			retval =
+			    ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val,
+					  1);
+			if (retval == STATUS_SUCCESS)
+				break;
+		}
+		if (i == MS_MAX_RETRY_COUNT)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		if (k > 100)
+			TRACE_RET(chip, STATUS_FAIL);
+		k++;
+		wait_timeout(100);
+	} while (!(val & INT_REG_CED));
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if (val & INT_REG_ERR) {
+		if (val & INT_REG_CMDNK) {	/* CMDNK = 1 */
+			chip->card_wp |= (MS_CARD);
+		} else {	/* CMDNK = 0 */
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+	/*--  end confirm CPU startup */
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_switch_parallel_bus(struct rts51x_chip *chip)
+{
+	int retval, i;
+	u8 data[2];
+
+	data[0] = PARALLEL_4BIT_IF;
+	data[1] = 0;
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, WRITE_REG, 1, NO_WAIT_INT, data, 2);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_switch_8bit_bus(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	u8 data[2];
+
+	data[0] = PARALLEL_8BIT_IF;
+	data[1] = 0;
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, WRITE_REG, 1, NO_WAIT_INT, data, 2);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	RTS51X_WRITE_REG(chip, MS_CFG, 0x98,
+			 MS_BUS_WIDTH_8 | SAMPLE_TIME_FALLING);
+	ms_card->ms_type |= MS_8BIT;
+
+	retval = ms_set_init_para(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_transfer_tpc(chip, MS_TM_READ_BYTES, GET_INT, 1,
+				    NO_WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_pro_reset_flow(struct rts51x_chip *chip, int switch_8bit_bus)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+
+	for (i = 0; i < 3; i++) {
+		retval = ms_prepare_reset(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = ms_identify_media_type(chip, switch_8bit_bus);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = ms_confirm_cpu_startup(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = ms_switch_parallel_bus(chip);
+		if (retval != STATUS_SUCCESS) {
+			if (monitor_card_cd(chip, MS_CARD) == CD_NOT_EXIST)
+				TRACE_RET(chip, STATUS_FAIL);
+			continue;
+		} else {
+			break;
+		}
+	}
+
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_WRITE_REG(chip, MS_CFG, 0x18, MS_BUS_WIDTH_4);
+
+	RTS51X_WRITE_REG(chip, MS_CFG, PUSH_TIME_ODD, PUSH_TIME_ODD);
+
+	retval = ms_set_init_para(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (CHK_MSHG(ms_card) && switch_8bit_bus) {
+		retval = ms_switch_8bit_bus(chip);
+		if (retval != STATUS_SUCCESS) {
+			ms_card->switch_8bit_fail = 1;
+			TRACE_RET(chip, retval);
+		}
+	}
+
+	return STATUS_SUCCESS;
+}
+
+#ifdef XC_POWERCLASS
+static int msxc_change_power(struct rts51x_chip *chip, u8 mode)
+{
+	int retval;
+	u8 buf[6];
+
+	rts51x_ms_cleanup_work(chip);
+
+	/* Set Parameter Register */
+	retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_DataCount1, 6);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	buf[0] = 0;
+	buf[1] = mode;
+	buf[2] = 0;
+	buf[3] = 0;
+	buf[4] = 0;
+	buf[5] = 0;
+
+	retval = ms_write_bytes(chip, PRO_WRITE_REG, 6, NO_WAIT_INT, buf, 6);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = ms_send_cmd(chip, XC_CHG_POWER, WAIT_INT);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_READ_REG(chip, MS_TRANS_CFG, buf);
+	if (buf[0] & (MS_INT_CMDNK | MS_INT_ERR))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+#endif
+
+static int ms_read_attribute_info(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	u8 val, *buf, class_code, device_type, sub_class, data[16];
+	u16 total_blk = 0, blk_size = 0;
+#ifdef SUPPORT_MSXC
+	u32 xc_total_blk = 0, xc_blk_size = 0;
+#endif
+	u32 sys_info_addr = 0, sys_info_size;
+#ifdef SUPPORT_PCGL_1P18
+	u32 model_name_addr = 0, model_name_size;
+	int found_sys_info = 0, found_model_name = 0;
+#endif
+
+	retval = ms_set_rw_reg_addr(chip, Pro_IntReg, 2, Pro_SystemParm, 7);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (CHK_MS8BIT(ms_card))
+		data[0] = PARALLEL_8BIT_IF;
+	else
+		data[0] = PARALLEL_4BIT_IF;
+	data[1] = 0;
+
+	data[2] = 0x40;
+	data[3] = 0;
+	data[4] = 0;
+	data[5] = 0;
+	/* Start address 0 */
+	data[6] = 0;
+	data[7] = 0;
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, PRO_WRITE_REG, 7, NO_WAIT_INT, data,
+				   8);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	buf = kmalloc(64 * 512, GFP_KERNEL);
+	if (buf == NULL)
+		TRACE_RET(chip, STATUS_NOMEM);
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval = ms_send_cmd(chip, PRO_READ_ATRB, WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			continue;
+
+		retval = rts51x_read_register(chip, MS_TRANS_CFG, &val);
+		if (retval != STATUS_SUCCESS) {
+			kfree(buf);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+		if (!(val & MS_INT_BREQ)) {
+			kfree(buf);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		retval =
+		    ms_transfer_data(chip, MS_TM_AUTO_READ, PRO_READ_LONG_DATA,
+				     0x40, WAIT_INT, 0, 0, buf, 64 * 512);
+		if (retval == STATUS_SUCCESS)
+			break;
+		else
+			rts51x_clear_ms_error(chip);
+	}
+	if (retval != STATUS_SUCCESS) {
+		kfree(buf);
+		TRACE_RET(chip, retval);
+	}
+
+	i = 0;
+	do {
+		retval = rts51x_read_register(chip, MS_TRANS_CFG, &val);
+		if (retval != STATUS_SUCCESS) {
+			kfree(buf);
+			TRACE_RET(chip, retval);
+		}
+
+		if ((val & MS_INT_CED) || !(val & MS_INT_BREQ))
+			break;
+
+		retval =
+		    ms_transfer_tpc(chip, MS_TM_NORMAL_READ, PRO_READ_LONG_DATA,
+				    0, WAIT_INT);
+		if (retval != STATUS_SUCCESS) {
+			kfree(buf);
+			TRACE_RET(chip, retval);
+		}
+
+		i++;
+	} while (i < 1024);
+
+	if (retval != STATUS_SUCCESS) {
+		kfree(buf);
+		TRACE_RET(chip, retval);
+	}
+
+	if ((buf[0] != 0xa5) && (buf[1] != 0xc3)) {
+		/* Signature code is wrong */
+		kfree(buf);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if ((buf[4] < 1) || (buf[4] > 12)) {
+		kfree(buf);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	for (i = 0; i < buf[4]; i++) {
+		int cur_addr_off = 16 + i * 12;
+
+#ifdef SUPPORT_MSXC
+		if ((buf[cur_addr_off + 8] == 0x10)
+		    || (buf[cur_addr_off + 8] == 0x13)) {
+#else
+		if (buf[cur_addr_off + 8] == 0x10) {
+#endif
+			sys_info_addr = ((u32) buf[cur_addr_off + 0] << 24) |
+			    ((u32) buf[cur_addr_off + 1] << 16) |
+			    ((u32) buf[cur_addr_off + 2] << 8) |
+			    buf[cur_addr_off + 3];
+			sys_info_size =
+			    ((u32) buf[cur_addr_off + 4] << 24) |
+			    ((u32) buf[cur_addr_off + 5] << 16) |
+			    ((u32) buf[cur_addr_off + 6] << 8) |
+			    buf[cur_addr_off + 7];
+			RTS51X_DEBUGP("sys_info_addr = 0x%x, sys_info_size = 0x%x\n",
+						sys_info_addr, sys_info_size);
+			if (sys_info_size != 96) {
+				kfree(buf);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			if (sys_info_addr < 0x1A0) {
+				kfree(buf);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			if ((sys_info_size + sys_info_addr) > 0x8000) {
+				kfree(buf);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+#ifdef SUPPORT_MSXC
+			if (buf[cur_addr_off + 8] == 0x13)
+				ms_card->ms_type |= MS_XC;
+#endif
+#ifdef SUPPORT_PCGL_1P18
+			found_sys_info = 1;
+#else
+			break;
+#endif
+		}
+#ifdef SUPPORT_PCGL_1P18
+		if (buf[cur_addr_off + 8] == 0x15) {
+			model_name_addr = ((u32) buf[cur_addr_off + 0] << 24) |
+			    ((u32) buf[cur_addr_off + 1] << 16) |
+			    ((u32) buf[cur_addr_off + 2] << 8) |
+			    buf[cur_addr_off + 3];
+			model_name_size =
+			    ((u32) buf[cur_addr_off + 4] << 24) |
+			    ((u32) buf[cur_addr_off + 5] << 16) |
+			    ((u32) buf[cur_addr_off + 6] << 8) |
+			    buf[cur_addr_off + 7];
+			RTS51X_DEBUGP("model_name_addr = 0x%x, model_name_size = 0x%x\n",
+					model_name_addr, model_name_size);
+			if (model_name_size != 48) {
+				kfree(buf);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			if (model_name_addr < 0x1A0) {
+				kfree(buf);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			if ((model_name_size + model_name_addr) > 0x8000) {
+				kfree(buf);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			found_model_name = 1;
+		}
+
+		if (found_sys_info && found_model_name)
+			break;
+#endif
+	}
+
+	if (i == buf[4]) {
+		kfree(buf);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	class_code = buf[sys_info_addr + 0];
+	device_type = buf[sys_info_addr + 56];
+	sub_class = buf[sys_info_addr + 46];
+#ifdef SUPPORT_MSXC
+	if (CHK_MSXC(ms_card)) {
+		xc_total_blk = ((u32) buf[sys_info_addr + 6] << 24) |
+		    ((u32) buf[sys_info_addr + 7] << 16) |
+		    ((u32) buf[sys_info_addr + 8] << 8) |
+		    buf[sys_info_addr + 9];
+		xc_blk_size = ((u32) buf[sys_info_addr + 32] << 24) |
+		    ((u32) buf[sys_info_addr + 33] << 16) |
+		    ((u32) buf[sys_info_addr + 34] << 8) |
+		    buf[sys_info_addr + 35];
+		RTS51X_DEBUGP("xc_total_blk = 0x%x, xc_blk_size = 0x%x\n",
+			       xc_total_blk, xc_blk_size);
+	} else {
+		total_blk =
+		    ((u16) buf[sys_info_addr + 6] << 8) | buf[sys_info_addr +
+							      7];
+		blk_size =
+		    ((u16) buf[sys_info_addr + 2] << 8) | buf[sys_info_addr +
+							      3];
+		RTS51X_DEBUGP("total_blk = 0x%x, blk_size = 0x%x\n", total_blk,
+			       blk_size);
+	}
+#else
+	total_blk =
+	    ((u16) buf[sys_info_addr + 6] << 8) | buf[sys_info_addr + 7];
+	blk_size = ((u16) buf[sys_info_addr + 2] << 8) | buf[sys_info_addr + 3];
+	RTS51X_DEBUGP("total_blk = 0x%x, blk_size = 0x%x\n", total_blk,
+		       blk_size);
+#endif
+
+	RTS51X_DEBUGP("class_code = 0x%x, device_type = 0x%x,"
+			"sub_class = 0x%x\n",
+				class_code, device_type, sub_class);
+
+	memcpy(ms_card->raw_sys_info, buf + sys_info_addr, 96);
+#ifdef SUPPORT_PCGL_1P18
+	memcpy(ms_card->raw_model_name, buf + model_name_addr, 48);
+#endif
+
+	kfree(buf);
+
+	/* Confirm System Information */
+#ifdef SUPPORT_MSXC
+	if (CHK_MSXC(ms_card)) {
+		if (class_code != 0x03)
+			TRACE_RET(chip, STATUS_FAIL);
+	} else {
+		if (class_code != 0x02)
+			TRACE_RET(chip, STATUS_FAIL);
+	}
+#else
+	if (class_code != 0x02)
+		TRACE_RET(chip, STATUS_FAIL);
+#endif
+
+	if (device_type != 0x00) {
+		if ((device_type == 0x01) || (device_type == 0x02)
+		    || (device_type == 0x03))
+			chip->card_wp |= MS_CARD;
+		else
+			TRACE_RET(chip, STATUS_FAIL);
+	}
+	if (sub_class & 0xC0)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	RTS51X_DEBUGP("class_code: 0x%x, device_type: 0x%x, sub_class: 0x%x\n",
+		       class_code, device_type, sub_class);
+
+#ifdef SUPPORT_MSXC
+	if (CHK_MSXC(ms_card)) {
+		chip->capacity[chip->card2lun[MS_CARD]] = ms_card->capacity =
+		    xc_total_blk * xc_blk_size;
+	} else {
+		chip->capacity[chip->card2lun[MS_CARD]] = ms_card->capacity =
+		    total_blk * blk_size;
+	}
+#else
+	chip->capacity[chip->card2lun[MS_CARD]] = ms_card->capacity =
+	    total_blk * blk_size;
+#endif
+
+	return STATUS_SUCCESS;
+}
+
+static int reset_ms_pro(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+#ifdef XC_POWERCLASS
+	u8 change_power_class = 2;
+#endif
+
+#ifdef XC_POWERCLASS
+Retry:
+#endif
+	retval = ms_pro_reset_flow(chip, 1);
+	if (retval != STATUS_SUCCESS) {
+		if (ms_card->switch_8bit_fail) {
+			retval = ms_pro_reset_flow(chip, 0);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+		} else {
+			TRACE_RET(chip, retval);
+		}
+	}
+
+	retval = ms_read_attribute_info(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+#ifdef XC_POWERCLASS
+	if (CHK_HG8BIT(ms_card))
+		change_power_class = 0;
+
+	if (change_power_class && CHK_MSXC(ms_card)) {
+		u8 power_class_mode = (ms_card->raw_sys_info[46] & 0x18) >> 3;
+		RTS51X_DEBUGP("power_class_mode = 0x%x", power_class_mode);
+		if (change_power_class > power_class_mode)
+			change_power_class = power_class_mode;
+		if (change_power_class) {
+			retval = msxc_change_power(chip, change_power_class);
+			if (retval != STATUS_SUCCESS) {
+				change_power_class--;
+				goto Retry;
+			}
+		}
+	}
+#endif
+
+#ifdef SUPPORT_MAGIC_GATE
+	retval = rts51x_mg_set_tpc_para_sub(chip, 0, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+#endif
+
+	if (CHK_HG8BIT(ms_card))
+		chip->card_bus_width[chip->card2lun[MS_CARD]] = 8;
+	else
+		chip->card_bus_width[chip->card2lun[MS_CARD]] = 4;
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_read_status_reg(struct rts51x_chip *chip)
+{
+	int retval;
+	u8 val[2];
+
+	retval = ms_set_rw_reg_addr(chip, StatusReg0, 2, 0, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = ms_read_bytes(chip, READ_REG, 2, NO_WAIT_INT, val, 2);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	if (val[1] & (STS_UCDT | STS_UCEX | STS_UCFG)) {
+		ms_set_err_code(chip, MS_FLASH_READ_ERROR);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_check_boot_block(struct rts51x_chip *chip, u16 block_addr)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	u8 extra[MS_EXTRA_SIZE], data[10], val = 0;
+
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (block_addr >> 8);
+	data[3] = (u8) block_addr;
+	/* Page Number
+	 * Extra data access mode */
+	data[4] = 0x40;
+	data[5] = 0;
+
+	retval = ms_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm, 6,
+			    BLOCK_READ, WAIT_INT, data, 6, &val);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (val & INT_REG_CMDNK) {
+		ms_set_err_code(chip, MS_CMD_NK);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	if (val & INT_REG_CED) {
+		if (val & INT_REG_ERR) {
+			retval = ms_read_status_reg(chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+			retval =
+			    ms_set_rw_reg_addr(chip, OverwriteFlag,
+					       MS_EXTRA_SIZE, SystemParm, 6);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+		}
+	}
+
+	retval =
+	    ms_read_bytes(chip, READ_REG, MS_EXTRA_SIZE, NO_WAIT_INT, extra,
+			  MS_EXTRA_SIZE);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (!(extra[0] & BLOCK_OK) || (extra[1] & NOT_BOOT_BLOCK))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_read_extra_data(struct rts51x_chip *chip,
+			      u16 block_addr, u8 page_num, u8 *buf,
+			      int buf_len)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	u8 val = 0, data[10];
+
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (block_addr >> 8);
+	data[3] = (u8) block_addr;
+	/* Page Number
+	 * Extra data access mode */
+	data[4] = 0x40;
+	data[5] = page_num;
+
+#ifdef MS_SPEEDUP
+	retval =
+	    ms_auto_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm, 6,
+			    BLOCK_READ, WAIT_INT, data, 6, &val);
+#else
+	retval = ms_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm, 6,
+			    BLOCK_READ, WAIT_INT, data, 6, &val);
+#endif
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (val & INT_REG_CMDNK) {
+		ms_set_err_code(chip, MS_CMD_NK);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	if (val & INT_REG_CED) {
+		if (val & INT_REG_ERR) {
+			retval = ms_read_status_reg(chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+			retval =
+			    ms_set_rw_reg_addr(chip, OverwriteFlag,
+					       MS_EXTRA_SIZE, SystemParm, 6);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+		}
+	}
+
+	retval =
+	    ms_read_bytes(chip, READ_REG, MS_EXTRA_SIZE, NO_WAIT_INT, data,
+			  MS_EXTRA_SIZE);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (buf && buf_len) {
+		if (buf_len > MS_EXTRA_SIZE)
+			buf_len = MS_EXTRA_SIZE;
+		memcpy(buf, data, buf_len);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_write_extra_data(struct rts51x_chip *chip,
+			       u16 block_addr, u8 page_num, u8 *buf,
+			       int buf_len)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	u8 val = 0, data[16];
+
+	if (!buf || (buf_len < MS_EXTRA_SIZE))
+		TRACE_RET(chip, STATUS_FAIL);
+	/* Write REG */
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (block_addr >> 8);
+	data[3] = (u8) block_addr;
+	/* Page Number
+	 * Extra data access mode */
+	data[4] = 0x40;
+	data[5] = page_num;
+
+	for (i = 6; i < MS_EXTRA_SIZE + 6; i++)
+		data[i] = buf[i - 6];
+
+#ifdef MS_SPEEDUP
+	retval =
+	    ms_auto_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm,
+			    6 + MS_EXTRA_SIZE, BLOCK_WRITE, WAIT_INT, data, 16,
+			    &val);
+#else
+	retval =
+	    ms_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm,
+		       6 + MS_EXTRA_SIZE, BLOCK_WRITE, WAIT_INT, data, 16,
+		       &val);
+#endif
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (val & INT_REG_CMDNK) {
+		ms_set_err_code(chip, MS_CMD_NK);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	if (val & INT_REG_CED) {
+		if (val & INT_REG_ERR) {
+			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_read_page(struct rts51x_chip *chip, u16 block_addr, u8 page_num)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	u8 val = 0, data[6];
+
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (block_addr >> 8);
+	data[3] = (u8) block_addr;
+	/* Page Number
+	 * Single page access mode */
+	data[4] = 0x20;
+	data[5] = page_num;
+
+	retval = ms_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm, 6,
+			    BLOCK_READ, WAIT_INT, data, 6, &val);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (val & INT_REG_CMDNK) {
+		ms_set_err_code(chip, MS_CMD_NK);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (val & INT_REG_CED) {
+		if (val & INT_REG_ERR) {
+			if (!(val & INT_REG_BREQ)) {
+				ms_set_err_code(chip, MS_FLASH_READ_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			retval = ms_read_status_reg(chip);
+			if (retval != STATUS_SUCCESS)
+				ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
+		} else {
+			if (!(val & INT_REG_BREQ)) {
+				ms_set_err_code(chip, MS_BREQ_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+	}
+
+	retval =
+	    ms_transfer_tpc(chip, MS_TM_NORMAL_READ, READ_PAGE_DATA, 0,
+			    NO_WAIT_INT);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	if (ms_check_err_code(chip, MS_FLASH_WRITE_ERROR))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_set_bad_block(struct rts51x_chip *chip, u16 phy_blk)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	u8 val = 0, data[8], extra[MS_EXTRA_SIZE];
+
+	retval = ms_read_extra_data(chip, phy_blk, 0, extra, MS_EXTRA_SIZE);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	ms_set_err_code(chip, MS_NO_ERROR);
+
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (phy_blk >> 8);
+	data[3] = (u8) phy_blk;
+	data[4] = 0x80;
+	data[5] = 0;
+	data[6] = extra[0] & 0x7F;
+	data[7] = 0xFF;
+
+#ifdef MS_SPEEDUP
+	retval = ms_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm, 7,
+			    BLOCK_WRITE, WAIT_INT, data, 7, &val);
+#else
+	retval = ms_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm, 7,
+			    BLOCK_WRITE, WAIT_INT, data, 7, &val);
+#endif
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (val & INT_REG_CMDNK) {
+		ms_set_err_code(chip, MS_CMD_NK);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (val & INT_REG_CED) {
+		if (val & INT_REG_ERR) {
+			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_erase_block(struct rts51x_chip *chip, u16 phy_blk)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i = 0;
+	u8 val = 0, data[6];
+
+	retval =
+	    ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm,
+			       6);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	ms_set_err_code(chip, MS_NO_ERROR);
+
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (phy_blk >> 8);
+	data[3] = (u8) phy_blk;
+	data[4] = 0;
+	data[5] = 0;
+
+ERASE_RTY:
+#ifdef MS_SPEEDUP
+	retval =
+	    ms_auto_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm, 6,
+			    BLOCK_ERASE, WAIT_INT, data, 6, &val);
+#else
+	retval = ms_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm, 6,
+			    BLOCK_ERASE, WAIT_INT, data, 6, &val);
+#endif
+
+	if (val & INT_REG_CMDNK) {
+		if (i < 3) {
+			i++;
+			goto ERASE_RTY;
+		}
+		ms_set_err_code(chip, MS_CMD_NK);
+		ms_set_bad_block(chip, phy_blk);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (val & INT_REG_CED) {
+		if (val & INT_REG_ERR) {
+			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static void ms_set_page_status(u16 log_blk, u8 type, u8 *extra, int extra_len)
+{
+	if (!extra || (extra_len < MS_EXTRA_SIZE))
+		return;
+
+	memset(extra, 0xFF, MS_EXTRA_SIZE);
+
+	if (type == setPS_NG)
+		extra[0] = 0xB8;
+	else
+		extra[0] = 0x98;
+
+	extra[2] = (u8) (log_blk >> 8);
+	extra[3] = (u8) log_blk;
+}
+
+static int ms_init_page(struct rts51x_chip *chip, u16 phy_blk, u16 log_blk,
+			u8 start_page, u8 end_page)
+{
+	int retval;
+	u8 extra[MS_EXTRA_SIZE], i;
+
+	memset(extra, 0xff, MS_EXTRA_SIZE);
+
+	extra[0] = 0xf8; /* Block, page OK, data erased */
+	extra[1] = 0xff;
+	extra[2] = (u8) (log_blk >> 8);
+	extra[3] = (u8) log_blk;
+
+	for (i = start_page; i < end_page; i++) {
+		if (monitor_card_cd(chip, MS_CARD) == CD_NOT_EXIST)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		retval =
+		    ms_write_extra_data(chip, phy_blk, i, extra, MS_EXTRA_SIZE);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_copy_page(struct rts51x_chip *chip, u16 old_blk, u16 new_blk,
+			u16 log_blk, u8 start_page, u8 end_page)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, rty_cnt, uncorrect_flag = 0;
+	u8 extra[MS_EXTRA_SIZE], val, i, j, data[16];
+
+	RTS51X_DEBUGP("Copy page from 0x%x to 0x%x, logical block is 0x%x\n",
+		       old_blk, new_blk, log_blk);
+	RTS51X_DEBUGP("start_page = %d, end_page = %d\n", start_page,
+		       end_page);
+
+	retval = ms_read_extra_data(chip, new_blk, 0, extra, MS_EXTRA_SIZE);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = ms_read_status_reg(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_READ_REG(chip, PPBUF_BASE2, &val);
+
+	if (val & BUF_FULL) {
+		/* Clear Buffer */
+		retval = ms_send_cmd(chip, CLEAR_BUF, WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		/* GET_INT Register */
+		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		if (!(val & INT_REG_CED)) {
+			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	for (i = start_page; i < end_page; i++) {
+		if (monitor_card_cd(chip, MS_CARD) == CD_NOT_EXIST)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		ms_read_extra_data(chip, old_blk, i, extra, MS_EXTRA_SIZE);
+
+		retval =
+		    ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
+				       SystemParm, 6);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		/* Write REG */
+		ms_set_err_code(chip, MS_NO_ERROR);
+
+		if (CHK_MS4BIT(ms_card)) {
+			/* Parallel interface */
+			data[0] = 0x88;
+		} else {
+			/* Serial interface */
+			data[0] = 0x80;
+		}
+		/* Block Address */
+		data[1] = 0;
+		data[2] = (u8) (old_blk >> 8);
+		data[3] = (u8) old_blk;
+		data[4] = 0x20;
+		data[5] = i;
+
+		retval =
+		    ms_write_bytes(chip, WRITE_REG, 6, NO_WAIT_INT, data, 6);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = ms_send_cmd(chip, BLOCK_READ, WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		ms_set_err_code(chip, MS_NO_ERROR);
+		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		if (val & INT_REG_CMDNK) {
+			ms_set_err_code(chip, MS_CMD_NK);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		if (val & INT_REG_CED) {
+			if (val & INT_REG_ERR) {
+				retval = ms_read_status_reg(chip);
+				if (retval != STATUS_SUCCESS) {
+					uncorrect_flag = 1;
+					RTS51X_DEBUGP("Uncorrectable error\n");
+				} else {
+					uncorrect_flag = 0;
+				}
+
+				retval =
+				    ms_transfer_tpc(chip, MS_TM_NORMAL_READ,
+					READ_PAGE_DATA, 0, NO_WAIT_INT);
+				if (retval != STATUS_SUCCESS)
+					TRACE_RET(chip, retval);
+				if (uncorrect_flag) {
+					ms_set_page_status(log_blk, setPS_NG,
+						extra, MS_EXTRA_SIZE);
+					if (i == 0)
+						extra[0] &= 0xEF;
+					ms_write_extra_data(chip, old_blk, i,
+							    extra,
+							    MS_EXTRA_SIZE);
+					RTS51X_DEBUGP("page %d : extra[0] = 0x%x\n",
+							i, extra[0]);
+					MS_SET_BAD_BLOCK_FLG(ms_card);
+
+					ms_set_page_status(log_blk, setPS_Error,
+							extra, MS_EXTRA_SIZE);
+					ms_write_extra_data(chip, new_blk, i,
+						extra, MS_EXTRA_SIZE);
+					continue;
+				}
+
+				for (rty_cnt = 0; rty_cnt < MS_MAX_RETRY_COUNT;
+				     rty_cnt++) {
+					retval =
+					    ms_transfer_tpc(chip,
+							    MS_TM_NORMAL_WRITE,
+							    WRITE_PAGE_DATA, 0,
+							    NO_WAIT_INT);
+					if (retval == STATUS_SUCCESS)
+						break;
+				}
+				if (rty_cnt == MS_MAX_RETRY_COUNT)
+					TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			if (!(val & INT_REG_BREQ)) {
+				ms_set_err_code(chip, MS_BREQ_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		retval = ms_set_rw_reg_addr(chip, OverwriteFlag,
+					    MS_EXTRA_SIZE, SystemParm,
+					    (6 + MS_EXTRA_SIZE));
+
+		/* Write REG */
+		ms_set_err_code(chip, MS_NO_ERROR);
+
+		if (CHK_MS4BIT(ms_card)) {
+			/* Parallel interface */
+			data[0] = 0x88;
+		} else {
+			/* Serial interface */
+			data[0] = 0x80;
+		}
+		/* Block Address */
+		data[1] = 0;
+		data[2] = (u8) (new_blk >> 8);
+		data[3] = (u8) new_blk;
+		data[4] = 0x20;
+		data[5] = i;
+
+		/* for MS check procedure */
+		if ((extra[0] & 0x60) != 0x60)
+			data[6] = extra[0];
+		else
+			data[6] = 0xF8;
+
+		data[6 + 1] = 0xFF;
+		data[6 + 2] = (u8) (log_blk >> 8);
+		data[6 + 3] = (u8) log_blk;
+
+		for (j = 4; j <= MS_EXTRA_SIZE; j++)
+			data[6 + j] = 0xFF;
+
+		retval =
+		    ms_write_bytes(chip, WRITE_REG, (6 + MS_EXTRA_SIZE),
+				   NO_WAIT_INT, data, 16);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		/* GET_INT Register */
+		ms_set_err_code(chip, MS_NO_ERROR);
+		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		if (val & INT_REG_CMDNK) {
+			ms_set_err_code(chip, MS_CMD_NK);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		if (val & INT_REG_CED) {
+			if (val & INT_REG_ERR) {
+				ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		if (i == 0) {
+			retval =
+			    ms_set_rw_reg_addr(chip, OverwriteFlag,
+					       MS_EXTRA_SIZE, SystemParm, 7);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+
+			ms_set_err_code(chip, MS_NO_ERROR);
+
+			if (CHK_MS4BIT(ms_card)) {
+				/* Parallel interface */
+				data[0] = 0x88;
+			} else {
+				/* Serial interface */
+				data[0] = 0x80;
+			}
+			/* Block Address */
+			data[1] = 0;
+			data[2] = (u8) (old_blk >> 8);
+			data[3] = (u8) old_blk;
+			data[4] = 0x80;
+			data[5] = 0;
+			data[6] = 0xEF;
+			data[7] = 0xFF;
+
+			retval =
+			    ms_write_bytes(chip, WRITE_REG, 7, NO_WAIT_INT,
+					   data, 8);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+
+			retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+
+			ms_set_err_code(chip, MS_NO_ERROR);
+			retval =
+			    ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val,
+					  1);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+
+			if (val & INT_REG_CMDNK) {
+				ms_set_err_code(chip, MS_CMD_NK);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			if (val & INT_REG_CED) {
+				if (val & INT_REG_ERR) {
+					ms_set_err_code(chip,
+							MS_FLASH_WRITE_ERROR);
+					TRACE_RET(chip, STATUS_FAIL);
+				}
+			}
+		}
+	}
+
+	return STATUS_SUCCESS;
+}
+
+#ifdef MS_SPEEDUP
+static int ms_auto_copy_page(struct rts51x_chip *chip, u16 old_blk, u16 new_blk,
+			     u16 log_blk, u8 start_page, u8 end_page)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	u8 page_len, bus_width, val = 0;
+	u8 extra[MS_EXTRA_SIZE];
+
+	RTS51X_DEBUGP("Auto copy page from 0x%x to 0x%x, logical block is 0x%x\n",
+				old_blk, new_blk, log_blk);
+	RTS51X_DEBUGP("start_page = %d, end_page = %d\n", start_page,
+		       end_page);
+
+	page_len = end_page - start_page;
+
+	retval = ms_read_extra_data(chip, new_blk, 0, extra, MS_EXTRA_SIZE);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = ms_read_status_reg(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_READ_REG(chip, PPBUF_BASE2, &val);
+
+	if (val & BUF_FULL) {
+		retval = ms_send_cmd(chip, CLEAR_BUF, WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		if (!(val & INT_REG_CED)) {
+			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		bus_width = 0x88;
+	} else {
+		/* Serial interface */
+		bus_width = 0x80;
+	}
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_OLD_BLOCK_0, 0xFF, (u8) old_blk);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_OLD_BLOCK_1, 0xFF,
+		       (u8) (old_blk >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_NEW_BLOCK_0, 0xFF, (u8) new_blk);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_NEW_BLOCK_1, 0xFF,
+		       (u8) (new_blk >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_LOG_BLOCK_0, 0xFF, (u8) log_blk);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_LOG_BLOCK_1, 0xFF,
+		       (u8) (log_blk >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_PAGE_START, 0xFF, start_page);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_PAGE_LENGTH, 0xFF, page_len);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_BUS_WIDTH, 0xFF, bus_width);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+		       MS_TRANSFER_START | MS_TM_COPY_PAGE);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER, MS_TRANSFER_END,
+		       MS_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_ms_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	retval = rts51x_get_rsp(chip, 1, 5000);
+
+	if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+		rts51x_clear_ms_error(chip);
+		if (retval == STATUS_TIMEDOUT)
+			TRACE_RET(chip, retval);
+		TRACE_GOTO(chip, Fail);
+	}
+
+	return STATUS_SUCCESS;
+
+Fail:
+	retval = ms_erase_block(chip, new_blk);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval =
+	    ms_copy_page(chip, old_blk, new_blk, log_blk, start_page, end_page);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+#endif
+
+static int reset_ms(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	u16 i, reg_addr, block_size;
+	u8 val, j, *ptr;
+#ifndef SUPPORT_MAGIC_GATE
+	u16 eblock_cnt;
+#endif
+
+	retval = ms_prepare_reset(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	ms_card->ms_type |= TYPE_MS;
+
+	retval = ms_send_cmd(chip, MS_RESET, NO_WAIT_INT);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = ms_read_status_reg(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_READ_REG(chip, PPBUF_BASE2, &val);
+	if (val & WRT_PRTCT)
+		chip->card_wp |= MS_CARD;
+	else
+		chip->card_wp &= ~MS_CARD;
+
+	i = 0;
+
+RE_SEARCH:
+	/* Search For Boot Block */
+	while (i < (MAX_DEFECTIVE_BLOCK + 2)) {
+		if (monitor_card_cd(chip, MS_CARD) == CD_NOT_EXIST)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		retval = ms_check_boot_block(chip, i);
+		if (retval != STATUS_SUCCESS) {
+			i++;
+			continue;
+		}
+
+		ms_card->boot_block = i;
+		break;
+	}
+
+	if (i == (MAX_DEFECTIVE_BLOCK + 2)) {
+		RTS51X_DEBUGP("No boot block found!");
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	for (j = 0; j < 3; j++) {
+		retval = ms_read_page(chip, ms_card->boot_block, j);
+		if (retval != STATUS_SUCCESS) {
+			if (ms_check_err_code(chip, MS_FLASH_WRITE_ERROR)) {
+				i = ms_card->boot_block + 1;
+				ms_set_err_code(chip, MS_NO_ERROR);
+				goto RE_SEARCH;
+			}
+		}
+	}
+
+	/* Read boot block contents */
+	retval = ms_read_page(chip, ms_card->boot_block, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	/* Read MS system information as sys_info */
+	retval =
+	    rts51x_seq_read_register(chip, PPBUF_BASE2 + 0x1A0, 96,
+				     ms_card->raw_sys_info);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	/* Read useful block contents */
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, READ_REG_CMD, HEADER_ID0, 0, 0);
+	rts51x_add_cmd(chip, READ_REG_CMD, HEADER_ID1, 0, 0);
+
+	for (reg_addr = DISABLED_BLOCK0; reg_addr <= DISABLED_BLOCK3;
+	     reg_addr++) {
+		rts51x_add_cmd(chip, READ_REG_CMD, reg_addr, 0, 0);
+	}
+
+	for (reg_addr = BLOCK_SIZE_0; reg_addr <= PAGE_SIZE_1; reg_addr++)
+		rts51x_add_cmd(chip, READ_REG_CMD, reg_addr, 0, 0);
+
+	rts51x_add_cmd(chip, READ_REG_CMD, MS_Device_Type, 0, 0);
+	rts51x_add_cmd(chip, READ_REG_CMD, MS_4bit_Support, 0, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 16, 100);
+
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	ptr = rts51x_get_rsp_data(chip);
+
+	RTS51X_DEBUGP("Boot block data:\n");
+	RTS51X_DUMP(ptr, 16);
+
+	if (ptr[0] != 0x00 || ptr[1] != 0x01) {
+		i = ms_card->boot_block + 1;
+		goto RE_SEARCH;
+	}
+	if (ptr[12] != 0x02 || ptr[13] != 0x00) {
+		i = ms_card->boot_block + 1;
+		goto RE_SEARCH;
+	}
+	if ((ptr[14] == 1) || (ptr[14] == 3))
+		chip->card_wp |= MS_CARD;
+	block_size = ((u16) ptr[6] << 8) | ptr[7];
+	if (block_size == 0x0010) {
+		ms_card->block_shift = 5;
+		ms_card->page_off = 0x1F;
+	} else if (block_size == 0x0008) {
+		ms_card->block_shift = 4;
+		ms_card->page_off = 0x0F;
+	}
+	ms_card->total_block = ((u16) ptr[8] << 8) | ptr[9];
+
+#ifdef SUPPORT_MAGIC_GATE
+	j = ptr[10];
+
+	if (ms_card->block_shift == 4) {
+		if (j < 2)
+			ms_card->capacity = 0x1EE0;
+		else
+			ms_card->capacity = 0x3DE0;
+	} else {
+		if (j < 5)
+			ms_card->capacity = 0x7BC0;
+		else if (j < 0xA)
+			ms_card->capacity = 0xF7C0;
+		else if (j < 0x11)
+			ms_card->capacity = 0x1EF80;
+		else
+			ms_card->capacity = 0x3DF00;
+	}
+#else
+	eblock_cnt = ((u16) ptr[10] << 8) | ptr[11];
+
+	ms_card->capacity = ((u32) eblock_cnt - 2) << ms_card->block_shift;
+#endif
+
+	chip->capacity[chip->card2lun[MS_CARD]] = ms_card->capacity;
+
+	if (ptr[15]) {
+		retval = ms_set_rw_reg_addr(chip, 0, 0, SystemParm, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, STATUS_FAIL);
+		RTS51X_WRITE_REG(chip, PPBUF_BASE2, 0xFF, 0x88);
+		RTS51X_WRITE_REG(chip, PPBUF_BASE2 + 1, 0xFF, 0);
+
+		retval =
+		    ms_transfer_tpc(chip, MS_TM_WRITE_BYTES, WRITE_REG, 1,
+				    NO_WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, STATUS_FAIL);
+		RTS51X_WRITE_REG(chip, MS_CFG, 0x58 | MS_NO_CHECK_INT,
+				 MS_BUS_WIDTH_4 | PUSH_TIME_ODD |
+				 MS_NO_CHECK_INT);
+
+		ms_card->ms_type |= MS_4BIT;
+	}
+
+	if (CHK_MS4BIT(ms_card))
+		chip->card_bus_width[chip->card2lun[MS_CARD]] = 4;
+	else
+		chip->card_bus_width[chip->card2lun[MS_CARD]] = 1;
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_init_l2p_tbl(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int size, i, seg_no, retval;
+	u16 defect_block, reg_addr;
+	u8 val1, val2;
+
+	ms_card->segment_cnt = ms_card->total_block >> 9;
+	RTS51X_DEBUGP("ms_card->segment_cnt = %d\n", ms_card->segment_cnt);
+
+	size = ms_card->segment_cnt * sizeof(struct zone_entry);
+	ms_card->segment = vmalloc(size);
+	if (ms_card->segment == NULL)
+		TRACE_RET(chip, STATUS_FAIL);
+	memset(ms_card->segment, 0, size);
+
+	retval = ms_read_page(chip, ms_card->boot_block, 1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_GOTO(chip, INIT_FAIL);
+
+	reg_addr = PPBUF_BASE2;
+	for (i = 0; i < (((ms_card->total_block >> 9) * 10) + 1); i++) {
+		retval = rts51x_read_register(chip, reg_addr++, &val1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, INIT_FAIL);
+		retval = rts51x_read_register(chip, reg_addr++, &val2);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, INIT_FAIL);
+
+		defect_block = ((u16) val1 << 8) | val2;
+		if (defect_block == 0xFFFF)
+			break;
+		seg_no = defect_block / 512;
+		ms_card->segment[seg_no].defect_list[ms_card->segment[seg_no].
+						     disable_count++] =
+		    defect_block;
+	}
+
+	for (i = 0; i < ms_card->segment_cnt; i++) {
+		ms_card->segment[i].build_flag = 0;
+		ms_card->segment[i].l2p_table = NULL;
+		ms_card->segment[i].free_table = NULL;
+		ms_card->segment[i].get_index = 0;
+		ms_card->segment[i].set_index = 0;
+		ms_card->segment[i].unused_blk_cnt = 0;
+
+		RTS51X_DEBUGP("defective block count of segment %d is %d\n",
+			       i, ms_card->segment[i].disable_count);
+	}
+
+	return STATUS_SUCCESS;
+
+INIT_FAIL:
+	if (ms_card->segment) {
+		vfree(ms_card->segment);
+		ms_card->segment = NULL;
+	}
+
+	return STATUS_FAIL;
+}
+
+static u16 ms_get_l2p_tbl(struct rts51x_chip *chip, int seg_no, u16 log_off)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	struct zone_entry *segment;
+
+	if (ms_card->segment == NULL)
+		return 0xFFFF;
+
+	segment = &(ms_card->segment[seg_no]);
+
+	if (segment->l2p_table)
+		return segment->l2p_table[log_off];
+
+	return 0xFFFF;
+}
+
+static void ms_set_l2p_tbl(struct rts51x_chip *chip, int seg_no, u16 log_off,
+			   u16 phy_blk)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	struct zone_entry *segment;
+
+	if (ms_card->segment == NULL)
+		return;
+
+	segment = &(ms_card->segment[seg_no]);
+	if (segment->l2p_table)
+		segment->l2p_table[log_off] = phy_blk;
+}
+
+static void ms_set_unused_block(struct rts51x_chip *chip, u16 phy_blk)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	struct zone_entry *segment;
+	int seg_no;
+
+	seg_no = (int)phy_blk >> 9;
+	segment = &(ms_card->segment[seg_no]);
+
+	segment->free_table[segment->set_index++] = phy_blk;
+	if (segment->set_index >= MS_FREE_TABLE_CNT)
+		segment->set_index = 0;
+	segment->unused_blk_cnt++;
+}
+
+static u16 ms_get_unused_block(struct rts51x_chip *chip, int seg_no)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	struct zone_entry *segment;
+	u16 phy_blk;
+
+	segment = &(ms_card->segment[seg_no]);
+
+	if (segment->unused_blk_cnt <= 0)
+		return 0xFFFF;
+
+	phy_blk = segment->free_table[segment->get_index];
+	segment->free_table[segment->get_index++] = 0xFFFF;
+	if (segment->get_index >= MS_FREE_TABLE_CNT)
+		segment->get_index = 0;
+	segment->unused_blk_cnt--;
+
+	return phy_blk;
+}
+
+static const unsigned short ms_start_idx[] = {
+	0, 494, 990, 1486, 1982, 2478, 2974, 3470,
+	3966, 4462, 4958, 5454, 5950, 6446, 6942, 7438, 7934
+};
+
+static int ms_arbitrate_l2p(struct rts51x_chip *chip, u16 phy_blk, u16 log_off,
+			    u8 us1, u8 us2)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	struct zone_entry *segment;
+	int seg_no;
+	u16 tmp_blk;
+
+	seg_no = (int)phy_blk >> 9;
+	segment = &(ms_card->segment[seg_no]);
+	tmp_blk = segment->l2p_table[log_off];
+
+	if (us1 != us2) {
+		if (us1 == 0) {
+			if (!(chip->card_wp & MS_CARD))
+				ms_erase_block(chip, tmp_blk);
+			ms_set_unused_block(chip, tmp_blk);
+			segment->l2p_table[log_off] = phy_blk;
+		} else {
+			if (!(chip->card_wp & MS_CARD))
+				ms_erase_block(chip, phy_blk);
+			ms_set_unused_block(chip, phy_blk);
+		}
+	} else {
+		if (phy_blk < tmp_blk) {
+			if (!(chip->card_wp & MS_CARD))
+				ms_erase_block(chip, phy_blk);
+			ms_set_unused_block(chip, phy_blk);
+		} else {
+			if (!(chip->card_wp & MS_CARD))
+				ms_erase_block(chip, tmp_blk);
+			ms_set_unused_block(chip, tmp_blk);
+			segment->l2p_table[log_off] = phy_blk;
+		}
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_build_l2p_tbl(struct rts51x_chip *chip, int seg_no)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	struct zone_entry *segment;
+	int retval, table_size, disable_cnt, defect_flag, i;
+	u16 start, end, phy_blk, log_blk, tmp_blk;
+	u8 extra[MS_EXTRA_SIZE], us1, us2;
+
+	RTS51X_DEBUGP("ms_build_l2p_tbl: %d\n", seg_no);
+
+	if (ms_card->segment == NULL) {
+		retval = ms_init_l2p_tbl(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	if (ms_card->segment[seg_no].build_flag) {
+		RTS51X_DEBUGP("l2p table of segment %d has been built\n",
+			       seg_no);
+		return STATUS_SUCCESS;
+	}
+
+	if (seg_no == 0)
+		table_size = 494;
+	else
+		table_size = 496;
+
+	segment = &(ms_card->segment[seg_no]);
+
+	if (segment->l2p_table == NULL) {
+		segment->l2p_table = vmalloc(table_size * 2);
+		if (segment->l2p_table == NULL)
+			TRACE_GOTO(chip, BUILD_FAIL);
+	}
+	memset((u8 *) (segment->l2p_table), 0xff, table_size * 2);
+
+	if (segment->free_table == NULL) {
+		segment->free_table = vmalloc(MS_FREE_TABLE_CNT * 2);
+		if (segment->free_table == NULL)
+			TRACE_GOTO(chip, BUILD_FAIL);
+	}
+	memset((u8 *) (segment->free_table), 0xff, MS_FREE_TABLE_CNT * 2);
+
+	start = (u16) seg_no << 9;
+	end = (u16) (seg_no + 1) << 9;
+
+	disable_cnt = segment->disable_count;
+
+	segment->get_index = segment->set_index = 0;
+	segment->unused_blk_cnt = 0;
+
+	for (phy_blk = start; phy_blk < end; phy_blk++) {
+		if (disable_cnt) {
+			defect_flag = 0;
+			for (i = 0; i < segment->disable_count; i++) {
+				if (phy_blk == segment->defect_list[i]) {
+					defect_flag = 1;
+					break;
+				}
+			}
+			if (defect_flag) {
+				disable_cnt--;
+				continue;
+			}
+		}
+
+		retval =
+		    ms_read_extra_data(chip, phy_blk, 0, extra, MS_EXTRA_SIZE);
+		if (retval != STATUS_SUCCESS) {
+			RTS51X_DEBUGP("read extra data fail\n");
+			ms_set_bad_block(chip, phy_blk);
+			continue;
+		}
+
+		if (seg_no == ms_card->segment_cnt - 1) {
+			if (!(extra[1] & NOT_TRANSLATION_TABLE)) {
+				if (!(chip->card_wp & MS_CARD)) {
+					retval = ms_erase_block(chip, phy_blk);
+					if (retval != STATUS_SUCCESS)
+						continue;
+					extra[2] = 0xff;
+					extra[3] = 0xff;
+				}
+			}
+		}
+
+		if (!(extra[0] & BLOCK_OK))
+			continue;
+		if (!(extra[1] & NOT_BOOT_BLOCK))
+			continue;
+		if ((extra[0] & PAGE_OK) != PAGE_OK)
+			continue;
+
+		log_blk = ((u16) extra[2] << 8) | extra[3];
+
+		if (log_blk == 0xFFFF) {
+			if (!(chip->card_wp & MS_CARD)) {
+				retval = ms_erase_block(chip, phy_blk);
+				if (retval != STATUS_SUCCESS)
+					continue;
+			}
+			ms_set_unused_block(chip, phy_blk);
+			continue;
+		}
+
+		if ((log_blk < ms_start_idx[seg_no]) ||
+		    (log_blk >= ms_start_idx[seg_no + 1])) {
+			if (!(chip->card_wp & MS_CARD)) {
+				retval = ms_erase_block(chip, phy_blk);
+				if (retval != STATUS_SUCCESS)
+					continue;
+			}
+			ms_set_unused_block(chip, phy_blk);
+			continue;
+		}
+
+		if (segment->l2p_table[log_blk - ms_start_idx[seg_no]] ==
+		    0xFFFF) {
+			segment->l2p_table[log_blk - ms_start_idx[seg_no]] =
+			    phy_blk;
+			continue;
+		}
+
+		us1 = extra[0] & 0x10;
+		tmp_blk = segment->l2p_table[log_blk - ms_start_idx[seg_no]];
+		retval =
+		    ms_read_extra_data(chip, tmp_blk, 0, extra, MS_EXTRA_SIZE);
+		if (retval != STATUS_SUCCESS)
+			continue;
+		us2 = extra[0] & 0x10;
+
+		(void)ms_arbitrate_l2p(chip, phy_blk,
+				       log_blk - ms_start_idx[seg_no], us1,
+				       us2);
+		continue;
+	}
+
+	segment->build_flag = 1;
+
+	RTS51X_DEBUGP("unused block count: %d\n", segment->unused_blk_cnt);
+
+	if (seg_no == ms_card->segment_cnt - 1) {
+		if (segment->unused_blk_cnt < 2)
+			chip->card_wp |= MS_CARD;
+	} else {
+		if (segment->unused_blk_cnt < 1)
+			chip->card_wp |= MS_CARD;
+	}
+
+	if (chip->card_wp & MS_CARD)
+		return STATUS_SUCCESS;
+
+	for (log_blk = ms_start_idx[seg_no]; log_blk < ms_start_idx[seg_no + 1];
+	     log_blk++) {
+		if (segment->l2p_table[log_blk - ms_start_idx[seg_no]] ==
+		    0xFFFF) {
+			phy_blk = ms_get_unused_block(chip, seg_no);
+			if (phy_blk == 0xFFFF) {
+				chip->card_wp |= MS_CARD;
+				return STATUS_SUCCESS;
+			}
+			retval = ms_init_page(chip, phy_blk, log_blk, 0, 1);
+			if (retval != STATUS_SUCCESS)
+				TRACE_GOTO(chip, BUILD_FAIL);
+			segment->l2p_table[log_blk - ms_start_idx[seg_no]] =
+			    phy_blk;
+			if (seg_no == ms_card->segment_cnt - 1) {
+				if (segment->unused_blk_cnt < 2) {
+					chip->card_wp |= MS_CARD;
+					return STATUS_SUCCESS;
+				}
+			} else {
+				if (segment->unused_blk_cnt < 1) {
+					chip->card_wp |= MS_CARD;
+					return STATUS_SUCCESS;
+				}
+			}
+		}
+	}
+
+	if (seg_no == 0) {
+		for (log_blk = 0; log_blk < 494; log_blk++) {
+			tmp_blk = segment->l2p_table[log_blk];
+			if (tmp_blk < ms_card->boot_block) {
+				RTS51X_DEBUGP("Boot block is not the first normal block.\n");
+
+				if (chip->card_wp & MS_CARD)
+					break;
+
+				phy_blk = ms_get_unused_block(chip, 0);
+#ifdef MS_SPEEDUP
+				retval =
+				    ms_auto_copy_page(chip, tmp_blk, phy_blk,
+						      log_blk, 0,
+						      ms_card->page_off + 1);
+#else
+				retval = ms_copy_page(chip, tmp_blk, phy_blk,
+						      log_blk, 0,
+						      ms_card->page_off + 1);
+#endif
+				if (retval != STATUS_SUCCESS)
+					TRACE_RET(chip, retval);
+
+				segment->l2p_table[log_blk] = phy_blk;
+
+				retval = ms_set_bad_block(chip, tmp_blk);
+				if (retval != STATUS_SUCCESS)
+					TRACE_RET(chip, retval);
+			}
+		}
+	}
+
+	return STATUS_SUCCESS;
+
+BUILD_FAIL:
+	segment->build_flag = 0;
+	if (segment->l2p_table) {
+		vfree(segment->l2p_table);
+		segment->l2p_table = NULL;
+	}
+	if (segment->free_table) {
+		vfree(segment->free_table);
+		segment->free_table = NULL;
+	}
+
+	return STATUS_FAIL;
+}
+
+int rts51x_reset_ms_card(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+
+	memset(ms_card, 0, sizeof(struct ms_info));
+
+	rts51x_enable_card_clock(chip, MS_CARD);
+
+	retval = rts51x_select_card(chip, MS_CARD);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	ms_card->ms_type = 0;
+	ms_card->last_rw_int = 0;
+
+	retval = reset_ms_pro(chip);
+	if (retval != STATUS_SUCCESS) {
+		if (ms_card->check_ms_flow) {
+			retval = reset_ms(chip);
+			if (retval != STATUS_SUCCESS) {
+				if (chip->option.reset_or_rw_fail_set_pad_drive) {
+					rts51x_write_register(chip,
+						CARD_DRIVE_SEL, SD20_DRIVE_MASK,
+						DRIVE_8mA);
+				}
+				TRACE_RET(chip, retval);
+			}
+		} else {
+			if (chip->option.reset_or_rw_fail_set_pad_drive) {
+				rts51x_write_register(chip, CARD_DRIVE_SEL,
+						      SD20_DRIVE_MASK,
+						      DRIVE_8mA);
+			}
+			TRACE_RET(chip, retval);
+		}
+	}
+
+	retval = ms_set_init_para(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (!CHK_MSPRO(ms_card)) {
+		retval = ms_build_l2p_tbl(chip, ms_card->total_block / 512 - 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	RTS51X_DEBUGP("ms_card->ms_type = 0x%x\n", ms_card->ms_type);
+
+	return STATUS_SUCCESS;
+}
+
+static int mspro_set_rw_cmd(struct rts51x_chip *chip, u32 start_sec,
+			    u16 sec_cnt, u8 cmd)
+{
+	int retval, i;
+	u8 data[8];
+
+	data[0] = cmd;
+	data[1] = (u8) (sec_cnt >> 8);
+	data[2] = (u8) sec_cnt;
+	data[3] = (u8) (start_sec >> 24);
+	data[4] = (u8) (start_sec >> 16);
+	data[5] = (u8) (start_sec >> 8);
+	data[6] = (u8) start_sec;
+	data[7] = 0;
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, PRO_EX_SET_CMD, 7, WAIT_INT, data, 8);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+static void mspro_stop_seq_mode(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+
+	if (ms_card->seq_mode) {
+		retval = ms_switch_clock(chip);
+		if (retval != STATUS_SUCCESS)
+			return;
+
+		ms_card->seq_mode = 0;
+		ms_card->total_sec_cnt = 0;
+		ms_card->last_rw_int = 0;
+		ms_send_cmd(chip, PRO_STOP, WAIT_INT);
+
+		rts51x_ep0_write_register(chip, MC_FIFO_CTL, FIFO_FLUSH,
+					  FIFO_FLUSH);
+	}
+}
+
+static inline int ms_auto_tune_clock(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+
+	if (chip->asic_code) {
+		if (ms_card->ms_clock > 30)
+			ms_card->ms_clock -= 20;
+	} else {
+		if (ms_card->ms_clock == CLK_80)
+			ms_card->ms_clock = CLK_60;
+		else if (ms_card->ms_clock == CLK_60)
+			ms_card->ms_clock = CLK_40;
+	}
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static int mspro_rw_multi_sector(struct scsi_cmnd *srb,
+				 struct rts51x_chip *chip, u32 start_sector,
+				 u16 sector_cnt)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, mode_2k = 0;
+	u16 count;
+	u8 val, trans_mode, rw_tpc, rw_cmd;
+
+	ms_set_err_code(chip, MS_NO_ERROR);
+
+	ms_card->counter = 0;
+
+	if (CHK_MSHG(ms_card)) {
+		if ((start_sector % 4) || (sector_cnt % 4)) {
+			if (srb->sc_data_direction == DMA_FROM_DEVICE) {
+				rw_tpc = PRO_READ_LONG_DATA;
+				rw_cmd = PRO_READ_DATA;
+			} else {
+				rw_tpc = PRO_WRITE_LONG_DATA;
+				rw_cmd = PRO_WRITE_DATA;
+			}
+		} else {
+			if (srb->sc_data_direction == DMA_FROM_DEVICE) {
+				rw_tpc = PRO_READ_QUAD_DATA;
+				rw_cmd = PRO_READ_2K_DATA;
+			} else {
+				rw_tpc = PRO_WRITE_QUAD_DATA;
+				rw_cmd = PRO_WRITE_2K_DATA;
+			}
+			mode_2k = 1;
+		}
+	} else {
+		if (srb->sc_data_direction == DMA_FROM_DEVICE) {
+			rw_tpc = PRO_READ_LONG_DATA;
+			rw_cmd = PRO_READ_DATA;
+		} else {
+			rw_tpc = PRO_WRITE_LONG_DATA;
+			rw_cmd = PRO_WRITE_DATA;
+		}
+	}
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (srb->sc_data_direction == DMA_FROM_DEVICE)
+		trans_mode = MS_TM_AUTO_READ;
+	else
+		trans_mode = MS_TM_AUTO_WRITE;
+
+	val = ms_card->last_rw_int;
+
+	if (ms_card->seq_mode) {
+		if ((ms_card->pre_dir != srb->sc_data_direction)
+		    || ((ms_card->pre_sec_addr + ms_card->pre_sec_cnt) !=
+			start_sector)
+		    || (mode_2k && (ms_card->seq_mode & MODE_512_SEQ))
+		    || (!mode_2k && (ms_card->seq_mode & MODE_2K_SEQ))
+		    || !(val & MS_INT_BREQ)
+		    || ((ms_card->total_sec_cnt + sector_cnt) > 0xFE00)) {
+			ms_card->seq_mode = 0;
+			ms_card->total_sec_cnt = 0;
+			ms_card->last_rw_int = 0;
+			if (val & MS_INT_BREQ) {
+				retval = ms_send_cmd(chip, PRO_STOP, WAIT_INT);
+				if (retval != STATUS_SUCCESS)
+					TRACE_RET(chip, retval);
+
+				rts51x_ep0_write_register(chip, MC_FIFO_CTL,
+					FIFO_FLUSH, FIFO_FLUSH);
+			}
+		}
+	}
+
+	if (!ms_card->seq_mode) {
+		ms_card->total_sec_cnt = 0;
+		if (sector_cnt >= 0x80) {
+			if ((ms_card->capacity - start_sector) > 0xFE00)
+				count = 0xFE00;
+			else
+				count =
+				    (u16) (ms_card->capacity - start_sector);
+			if (count > sector_cnt) {
+				if (mode_2k)
+					ms_card->seq_mode |= MODE_2K_SEQ;
+				else
+					ms_card->seq_mode |= MODE_512_SEQ;
+			}
+		} else {
+			count = sector_cnt;
+		}
+		retval = mspro_set_rw_cmd(chip, start_sector, count, rw_cmd);
+		if (retval != STATUS_SUCCESS) {
+			ms_card->seq_mode = 0;
+			TRACE_RET(chip, retval);
+		}
+	}
+
+	retval =
+	    ms_transfer_data(chip, trans_mode, rw_tpc, sector_cnt, WAIT_INT,
+			     mode_2k, scsi_sg_count(srb), scsi_sglist(srb),
+			     scsi_bufflen(srb));
+	if (retval != STATUS_SUCCESS) {
+		ms_card->seq_mode = 0;
+		rts51x_ep0_read_register(chip, MS_TRANS_CFG, &val);
+		rts51x_clear_ms_error(chip);
+		if (val & MS_INT_BREQ)
+			ms_send_cmd(chip, PRO_STOP, WAIT_INT);
+		if (val & (MS_CRC16_ERR | MS_RDY_TIMEOUT)) {
+			RTS51X_DEBUGP("MSPro CRC error, tune clock!\n");
+			ms_auto_tune_clock(chip);
+		}
+
+		TRACE_RET(chip, retval);
+	}
+
+	ms_card->pre_sec_addr = start_sector;
+	ms_card->pre_sec_cnt = sector_cnt;
+	ms_card->pre_dir = srb->sc_data_direction;
+	ms_card->total_sec_cnt += sector_cnt;
+
+	return STATUS_SUCCESS;
+}
+
+static int mspro_read_format_progress(struct rts51x_chip *chip,
+				      const int short_data_len)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	u32 total_progress, cur_progress;
+	u8 cnt, tmp;
+	u8 data[8];
+
+	ms_card->format_status = FORMAT_FAIL;
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_READ_REG(chip, MS_TRANS_CFG, &tmp);
+
+	if ((tmp & (MS_INT_CED | MS_INT_CMDNK | MS_INT_ERR)) == MS_INT_CED) {
+		ms_card->format_status = FORMAT_SUCCESS;
+		ms_card->pro_under_formatting = 0;
+		return STATUS_SUCCESS;
+	}
+	if (!
+	    ((tmp & (MS_INT_BREQ | MS_INT_CED | MS_INT_CMDNK | MS_INT_ERR)) ==
+	     MS_INT_BREQ)) {
+		ms_card->pro_under_formatting = 0;
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (short_data_len >= 256)
+		cnt = 0;
+	else
+		cnt = (u8) short_data_len;
+
+	retval =
+	    ms_read_bytes(chip, PRO_READ_SHORT_DATA, cnt, WAIT_INT, data, 8);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	total_progress =
+	    (data[0] << 24) | (data[1] << 16) | (data[2] << 8) | data[3];
+	cur_progress =
+	    (data[4] << 24) | (data[5] << 16) | (data[6] << 8) | data[7];
+
+	RTS51X_DEBUGP("total_progress = %d, cur_progress = %d\n",
+		       total_progress, cur_progress);
+
+	if (total_progress == 0) {
+		ms_card->progress = 0;
+	} else {
+		u64 ulltmp = (u64) cur_progress * (u64) 65535;
+		do_div(ulltmp, total_progress);
+		ms_card->progress = (u16) ulltmp;
+	}
+	RTS51X_DEBUGP("progress = %d\n", ms_card->progress);
+
+	for (i = 0; i < 2500; i++) {
+		RTS51X_READ_REG(chip, MS_TRANS_CFG, &tmp);
+		if (tmp &
+		    (MS_INT_CED | MS_INT_CMDNK | MS_INT_BREQ | MS_INT_ERR))
+			break;
+
+		wait_timeout(1);
+	}
+
+	if (i == 2500)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	RTS51X_DEBUGP("MSPro format tmp:%d\n", tmp);
+
+	if (tmp & (MS_INT_CMDNK | MS_INT_ERR))
+		TRACE_RET(chip, STATUS_FAIL);
+	if (tmp & MS_INT_CED) {
+		ms_card->format_status = FORMAT_SUCCESS;
+		ms_card->pro_under_formatting = 0;
+	} else if (tmp & MS_INT_BREQ) {
+		ms_card->format_status = FORMAT_IN_PROGRESS;
+	} else {
+		ms_card->format_status = FORMAT_FAIL;
+		ms_card->pro_under_formatting = 0;
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	RTS51X_DEBUGP("MSPro format format_status:%d\n",
+		       ms_card->format_status);
+
+	return STATUS_SUCCESS;
+}
+
+void rts51x_mspro_polling_format_status(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int i;
+
+	if (ms_card->pro_under_formatting) {
+		for (i = 0; i < 65535; i++) {
+			mspro_read_format_progress(chip, MS_SHORT_DATA_LEN);
+			if (ms_card->format_status != FORMAT_IN_PROGRESS)
+				break;
+		}
+	}
+
+	return;
+}
+
+void rts51x_mspro_format_sense(struct rts51x_chip *chip, unsigned int lun)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+
+	if (CHK_FORMAT_STATUS(ms_card, FORMAT_SUCCESS)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_NO_SENSE);
+		ms_card->pro_under_formatting = 0;
+		ms_card->progress = 0;
+	} else if (CHK_FORMAT_STATUS(ms_card, FORMAT_IN_PROGRESS)) {
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x02, 0, 0x04, 0x04,
+			       0, (u16) (ms_card->progress));
+	} else {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_FORMAT_CMD_FAILED);
+		ms_card->pro_under_formatting = 0;
+		ms_card->progress = 0;
+	}
+}
+
+int rts51x_mspro_format(struct scsi_cmnd *srb, struct rts51x_chip *chip,
+		 int short_data_len, int quick_format)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	u8 buf[8], tmp;
+	u16 para;
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = ms_set_rw_reg_addr(chip, 0x00, 0x00, Pro_TPCParm, 0x01);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	memset(buf, 0, 2);
+	switch (short_data_len) {
+	case 32:
+		buf[0] = 0;
+		break;
+	case 64:
+		buf[0] = 1;
+		break;
+	case 128:
+		buf[0] = 2;
+		break;
+	case 256:
+	default:
+		buf[0] = 3;
+		break;
+	}
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, PRO_WRITE_REG, 1, NO_WAIT_INT, buf, 2);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+	/* Format command */
+	if (quick_format)
+		para = 0x0000;
+	else
+		para = 0x0001;
+	retval = mspro_set_rw_cmd(chip, 0, para, PRO_FORMAT);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	/* Check INT */
+	RTS51X_READ_REG(chip, MS_TRANS_CFG, &tmp);
+	if (tmp & (MS_INT_CMDNK | MS_INT_ERR))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if ((tmp & (MS_INT_BREQ | MS_INT_CED)) == MS_INT_BREQ) {
+		ms_card->pro_under_formatting = 1;
+		ms_card->progress = 0;
+		ms_card->format_status = FORMAT_IN_PROGRESS;
+		return STATUS_SUCCESS;
+	}
+
+	if (tmp & MS_INT_CED) {
+		ms_card->pro_under_formatting = 0;
+		ms_card->progress = 0;
+		ms_card->format_status = FORMAT_SUCCESS;
+		rts51x_set_sense_type(chip, SCSI_LUN(srb), SENSE_TYPE_NO_SENSE);
+		return STATUS_SUCCESS;
+	}
+
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+#ifdef MS_SPEEDUP
+static int ms_read_multiple_pages(struct rts51x_chip *chip, u16 phy_blk,
+				  u16 log_blk, u8 start_page, u8 end_page,
+				  u8 *buf, void **ptr, unsigned int *offset)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	int send_blkend;
+	u8 extra[MS_EXTRA_SIZE], val1, val2, data[6];
+	u8 page_cnt = end_page - start_page, page_addr, sec_cnt;
+
+	if (end_page != (ms_card->page_off + 1))
+		send_blkend = 1;
+	else
+		send_blkend = 0;
+
+	retval =
+	    ms_read_extra_data(chip, phy_blk, start_page, extra, MS_EXTRA_SIZE);
+	if (retval == STATUS_SUCCESS) {
+		if ((extra[1] & 0x30) != 0x30) {
+			ms_set_err_code(chip, MS_FLASH_READ_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (phy_blk >> 8);
+	data[3] = (u8) phy_blk;
+	/* Page Number
+	 * Extra data access mode */
+	data[4] = 0;
+	data[5] = start_page;
+
+	retval =
+	    ms_auto_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm, 6,
+			    BLOCK_READ, WAIT_INT, data, 6, &val1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	rts51x_init_cmd(chip);
+
+	if (send_blkend)
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_BLKEND, SET_BLKEND,
+			       SET_BLKEND);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_BLKEND, SET_BLKEND, 0);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, WAIT_INT,
+		       NO_WAIT_INT);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_SECTOR_CNT_L, 0xFF,
+		       (u8) page_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_SECTOR_CNT_H, 0xFF, 0);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TPC, 0xFF, READ_PAGE_DATA);
+
+	rts51x_trans_dma_enable(DMA_FROM_DEVICE, chip, 512 * page_cnt, DMA_512);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+		       MS_TRANSFER_START | MS_TM_MULTI_READ);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER, MS_TRANSFER_END,
+		       MS_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CDIR | STAGE_MS_STATUS, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval =
+	    rts51x_transfer_data_partial(chip, RCV_BULK_PIPE(chip), (void *)buf,
+					 ptr, offset, 512 * page_cnt,
+					 scsi_sg_count(chip->srb), NULL, 2000);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_ms_error(chip);
+		if (retval == STATUS_TIMEDOUT)
+			TRACE_RET(chip, retval);
+		TRACE_GOTO(chip, Fail);
+	}
+	retval = rts51x_get_rsp(chip, 3, 200);
+	if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+		rts51x_clear_ms_error(chip);
+		if (retval == STATUS_TIMEDOUT)
+			TRACE_RET(chip, retval);
+		TRACE_GOTO(chip, Fail);
+	}
+
+	return STATUS_SUCCESS;
+
+Fail:
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, READ_REG_CMD, MS_SECTOR_CNT_L, 0, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_CR | STAGE_MS_STATUS, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 3, 200);
+
+	if (CHECK_MS_TRANS_FAIL(chip, retval))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	sec_cnt = chip->rsp_buf[0];
+	RTS51X_DEBUGP("%d pages need be transferred, %d pages remained\n",
+		       (int)page_cnt, (int)sec_cnt);
+	page_addr = start_page + (page_cnt - sec_cnt);
+
+	if (CHK_MS4BIT(ms_card)) {
+		val1 = chip->rsp_buf[1];
+		RTS51X_DEBUGP("MS_TRANS_CFG: 0x%x\n", val1);
+	} else {
+		val1 = 0;
+	}
+
+	val2 = chip->rsp_buf[2];
+	RTS51X_DEBUGP("GET_INT: 0x%x\n", val2);
+
+	if ((val1 & INT_CMDNK) || (val2 & INT_REG_CMDNK)) {
+		ms_set_err_code(chip, MS_CMD_NK);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if ((val1 & INT_ERR) || (val2 & INT_REG_ERR)) {
+		if ((val1 & INT_BREQ) || (val2 & INT_REG_BREQ)) {
+			retval = ms_read_status_reg(chip);
+			if (retval != STATUS_SUCCESS) {
+				if (!(chip->card_wp & MS_CARD)) {
+					reset_ms(chip);
+					ms_set_page_status(log_blk, setPS_NG,
+						extra, MS_EXTRA_SIZE);
+					ms_write_extra_data(chip, phy_blk,
+						page_addr, extra,
+						MS_EXTRA_SIZE);
+				}
+				ms_set_err_code(chip, MS_FLASH_READ_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		} else {
+			ms_set_err_code(chip, MS_FLASH_READ_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	} else {
+		if (CHK_MS4BIT(ms_card)) {
+			if (!(val1 & INT_BREQ) && !(val2 & INT_REG_BREQ)) {
+				ms_set_err_code(chip, MS_BREQ_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		} else {
+			if (!(val2 & INT_REG_BREQ)) {
+				ms_set_err_code(chip, MS_BREQ_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+	}
+
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+static int ms_write_multiple_pages(struct rts51x_chip *chip, u16 old_blk,
+				   u16 new_blk, u16 log_blk, u8 start_page,
+				   u8 end_page, u8 *buf, void **ptr,
+				   unsigned int *offset)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	int send_blkend;
+	u8 val, data[16];
+	u8 page_cnt = end_page - start_page;
+
+	if ((end_page == (ms_card->page_off + 1)) || (page_cnt == 1))
+		send_blkend = 0;
+	else
+		send_blkend = 1;
+
+	if (!start_page) {
+		if (CHK_MS4BIT(ms_card)) {
+			/* Parallel interface */
+			data[0] = 0x88;
+		} else {
+			/* Serial interface */
+			data[0] = 0x80;
+		}
+		/* Block Address */
+		data[1] = 0;
+		data[2] = (u8) (old_blk >> 8);
+		data[3] = (u8) old_blk;
+		data[4] = 0x80;
+		data[5] = 0;
+		data[6] = 0xEF;
+		data[7] = 0xFF;
+
+		retval =
+		    ms_auto_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE,
+				    SystemParm, 7, BLOCK_WRITE, WAIT_INT, data,
+				    7, &val);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	retval =
+	    ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm,
+			       (6 + MS_EXTRA_SIZE));
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	ms_set_err_code(chip, MS_NO_ERROR);
+
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (new_blk >> 8);
+	data[3] = (u8) new_blk;
+	/* Page Number
+	 * Extra data access mode */
+	if (page_cnt == 1) {
+		/* Single page access mode */
+		data[4] = 0x20;
+	} else {
+		/* Block access mode */
+		data[4] = 0;
+	}
+	data[5] = start_page;
+	data[6] = 0xF8;
+	data[7] = 0xFF;
+	data[8] = (u8) (log_blk >> 8);
+	data[9] = (u8) log_blk;
+
+	for (i = 0x0A; i < 0x10; i++) {
+		/* ECC */
+		data[i] = 0xFF;
+	}
+
+	retval =
+	    ms_auto_set_cmd(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm,
+			    (6 + MS_EXTRA_SIZE), BLOCK_WRITE, WAIT_INT, data,
+			    16, &val);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	rts51x_init_cmd(chip);
+
+	if (send_blkend)
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_BLKEND, SET_BLKEND,
+			       SET_BLKEND);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_BLKEND, SET_BLKEND, 0);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, WAIT_INT,
+		       NO_WAIT_INT);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_SECTOR_CNT_L, 0xFF,
+		       (u8) page_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_SECTOR_CNT_H, 0xFF, 0);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TPC, 0xFF, WRITE_PAGE_DATA);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       RING_BUFFER);
+
+	rts51x_trans_dma_enable(DMA_TO_DEVICE, chip, 512 * page_cnt, DMA_512);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+		       MS_TRANSFER_START | MS_TM_MULTI_WRITE);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER, MS_TRANSFER_END,
+		       MS_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CDOR | STAGE_MS_STATUS, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval =
+	    rts51x_transfer_data_partial(chip, SND_BULK_PIPE(chip), (void *)buf,
+					 ptr, offset, 512 * page_cnt,
+					 scsi_sg_count(chip->srb), NULL, 2000);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_ms_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	retval = rts51x_get_rsp(chip, 3, 2000);
+
+
+	if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+		rts51x_clear_ms_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+#else
+
+static int ms_read_multiple_pages(struct rts51x_chip *chip, u16 phy_blk,
+				  u16 log_blk, u8 start_page, u8 end_page,
+				  u8 *buf, void **ptr, unsigned int *offset)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	u8 extra[MS_EXTRA_SIZE], page_addr, val, trans_cfg, data[6];
+
+	retval =
+	    ms_read_extra_data(chip, phy_blk, start_page, extra, MS_EXTRA_SIZE);
+	if (retval == STATUS_SUCCESS) {
+		if ((extra[1] & 0x30) != 0x30) {
+			ms_set_err_code(chip, MS_FLASH_READ_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	retval =
+	    ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm,
+			       6);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	/* Write REG */
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (phy_blk >> 8);
+	data[3] = (u8) phy_blk;
+	/* Page Number
+	 * Extra data access mode */
+	data[4] = 0;
+	data[5] = start_page;
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, WRITE_REG, 6, NO_WAIT_INT, data, 6);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	ms_set_err_code(chip, MS_NO_ERROR);
+
+	retval = ms_send_cmd(chip, BLOCK_READ, WAIT_INT);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	for (page_addr = start_page; page_addr < end_page; page_addr++) {
+		ms_set_err_code(chip, MS_NO_ERROR);
+
+		if (monitor_card_cd(chip, MS_CARD) == CD_NOT_EXIST) {
+			ms_set_err_code(chip, MS_NO_CARD);
+			chip->card_exist &= ~MS_CARD;
+			chip->card_ready &= ~MS_CARD;
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+		/* GET_INT Register */
+		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		if (val & INT_REG_CMDNK) {
+			ms_set_err_code(chip, MS_CMD_NK);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+		if (val & INT_REG_ERR) {
+			if (val & INT_REG_BREQ) {
+				retval = ms_read_status_reg(chip);
+				if (retval != STATUS_SUCCESS) {
+					if (!(chip->card_wp & MS_CARD)) {
+						reset_ms(chip);
+						ms_set_page_status(log_blk,
+							setPS_NG, extra,
+							MS_EXTRA_SIZE);
+						ms_write_extra_data(chip,
+							phy_blk, page_addr,
+							extra, MS_EXTRA_SIZE);
+					}
+					ms_set_err_code(chip,
+							MS_FLASH_READ_ERROR);
+					TRACE_RET(chip, STATUS_FAIL);
+				}
+			} else {
+				ms_set_err_code(chip, MS_FLASH_READ_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		} else {
+			if (!(val & INT_REG_BREQ)) {
+				ms_set_err_code(chip, MS_BREQ_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		if (page_addr == (end_page - 1)) {
+			if (!(val & INT_REG_CED)) {
+				retval = ms_send_cmd(chip, BLOCK_END, WAIT_INT);
+				if (retval != STATUS_SUCCESS)
+					TRACE_RET(chip, retval);
+			}
+			retval =
+			    ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val,
+					  1);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+			if (!(val & INT_REG_CED)) {
+				ms_set_err_code(chip, MS_FLASH_READ_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			trans_cfg = NO_WAIT_INT;
+		} else {
+			trans_cfg = WAIT_INT;
+		}
+
+		rts51x_init_cmd(chip);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TPC, 0xFF,
+			       READ_PAGE_DATA);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF,
+			       trans_cfg);
+
+		rts51x_trans_dma_enable(DMA_FROM_DEVICE, chip, 512, DMA_512);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+			       MS_TRANSFER_START | MS_TM_NORMAL_READ);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER,
+			       MS_TRANSFER_END, MS_TRANSFER_END);
+
+		retval = rts51x_send_cmd(chip, MODE_CDIR, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval =
+		    rts51x_transfer_data_partial(chip, RCV_BULK_PIPE(chip),
+						 (void *)buf, ptr, offset, 512,
+						 scsi_sg_count(chip->srb), NULL,
+						 2000);
+		if (retval != STATUS_SUCCESS) {
+			if (retval == STATUS_TIMEDOUT) {
+				ms_set_err_code(chip, MS_TO_ERROR);
+				rts51x_clear_ms_error(chip);
+				TRACE_RET(chip, retval);
+			}
+
+			retval =
+			    rts51x_ep0_read_register(chip, MS_TRANS_CFG, &val);
+			if (retval != STATUS_SUCCESS) {
+				ms_set_err_code(chip, MS_TO_ERROR);
+				rts51x_clear_ms_error(chip);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			if (val & (MS_CRC16_ERR | MS_RDY_TIMEOUT)) {
+				ms_set_err_code(chip, MS_CRC16_ERROR);
+				rts51x_clear_ms_error(chip);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		retval = rts51x_get_rsp(chip, 1, 2000);
+		if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+			if (retval == STATUS_TIMEDOUT) {
+				ms_set_err_code(chip, MS_TO_ERROR);
+				rts51x_clear_ms_error(chip);
+				TRACE_RET(chip, retval);
+			}
+
+			retval =
+			    rts51x_ep0_read_register(chip, MS_TRANS_CFG, &val);
+			if (retval != STATUS_SUCCESS) {
+				ms_set_err_code(chip, MS_TO_ERROR);
+				rts51x_clear_ms_error(chip);
+				TRACE_RET(chip, retval);
+			}
+			if (val & (MS_CRC16_ERR | MS_RDY_TIMEOUT)) {
+				ms_set_err_code(chip, MS_CRC16_ERROR);
+				rts51x_clear_ms_error(chip);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_write_multiple_pages(struct rts51x_chip *chip, u16 old_blk,
+				   u16 new_blk, u16 log_blk, u8 start_page,
+				   u8 end_page, u8 *buf, void **ptr,
+				   unsigned int *offset)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	u8 page_addr, val, data[16];
+
+	if (!start_page) {
+		retval =
+		    ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE,
+				       SystemParm, 7);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		if (CHK_MS4BIT(ms_card)) {
+			/* Parallel interface */
+			data[0] = 0x88;
+		} else {
+			/* Serial interface */
+			data[0] = 0x80;
+		}
+		/* Block Address */
+		data[1] = 0;
+		data[2] = (u8) (old_blk >> 8);
+		data[3] = (u8) old_blk;
+		data[4] = 0x80;
+		data[5] = 0;
+		data[6] = 0xEF;
+		data[7] = 0xFF;
+
+		retval =
+		    ms_write_bytes(chip, WRITE_REG, 7, NO_WAIT_INT, data, 8);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		/* GET_INT Register */
+		ms_set_err_code(chip, MS_NO_ERROR);
+		retval =
+		    ms_transfer_tpc(chip, MS_TM_READ_BYTES, GET_INT, 1,
+				    NO_WAIT_INT);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	retval =
+	    ms_set_rw_reg_addr(chip, OverwriteFlag, MS_EXTRA_SIZE, SystemParm,
+			       (6 + MS_EXTRA_SIZE));
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	ms_set_err_code(chip, MS_NO_ERROR);
+
+	if (CHK_MS4BIT(ms_card)) {
+		/* Parallel interface */
+		data[0] = 0x88;
+	} else {
+		/* Serial interface */
+		data[0] = 0x80;
+	}
+	/* Block Address */
+	data[1] = 0;
+	data[2] = (u8) (new_blk >> 8);
+	data[3] = (u8) new_blk;
+	/* Page Number
+	 * Extra data access mode */
+	if ((end_page - start_page) == 1) {
+		/* Single page access mode */
+		data[4] = 0x20;
+	} else {
+		/* Block access mode */
+		data[4] = 0;
+	}
+	data[5] = start_page;
+	data[6] = 0xF8;
+	data[7] = 0xFF;
+	data[8] = (u8) (log_blk >> 8);
+	data[9] = (u8) log_blk;
+
+	for (i = 0x0A; i < 0x10; i++) {
+		/* ECC */
+		data[i] = 0xFF;
+	}
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, WRITE_REG, 6 + MS_EXTRA_SIZE,
+				   NO_WAIT_INT, data, 16);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval = ms_send_cmd(chip, BLOCK_WRITE, WAIT_INT);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+	/* GET_INT Register */
+	retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	for (page_addr = start_page; page_addr < end_page; page_addr++) {
+		ms_set_err_code(chip, MS_NO_ERROR);
+
+		if (monitor_card_cd(chip, MS_CARD) == CD_NOT_EXIST) {
+			ms_set_err_code(chip, MS_NO_CARD);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		if (val & INT_REG_CMDNK) {
+			ms_set_err_code(chip, MS_CMD_NK);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+		if (val & INT_REG_ERR) {
+			ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+		if (!(val & INT_REG_BREQ)) {
+			ms_set_err_code(chip, MS_BREQ_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		udelay(30);
+
+		rts51x_init_cmd(chip);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TPC, 0xFF,
+			       WRITE_PAGE_DATA);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF,
+			       WAIT_INT);
+
+		rts51x_trans_dma_enable(DMA_TO_DEVICE, chip, 512, DMA_512);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+			       MS_TRANSFER_START | MS_TM_NORMAL_WRITE);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER,
+			       MS_TRANSFER_END, MS_TRANSFER_END);
+
+		retval = rts51x_send_cmd(chip, MODE_CDOR, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval =
+		    rts51x_transfer_data_partial(chip, SND_BULK_PIPE(chip),
+						 (void *)buf, ptr, offset, 512,
+						 scsi_sg_count(chip->srb), NULL,
+						 2000);
+		if (retval != STATUS_SUCCESS) {
+			ms_set_err_code(chip, MS_TO_ERROR);
+			rts51x_clear_ms_error(chip);
+
+			if (retval == STATUS_TIMEDOUT)
+				TRACE_RET(chip, STATUS_TIMEDOUT);
+			else
+				TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		retval = rts51x_get_rsp(chip, 1, 2000);
+		if (CHECK_MS_TRANS_FAIL(chip, retval)) {
+			ms_set_err_code(chip, MS_TO_ERROR);
+			rts51x_clear_ms_error(chip);
+
+			if (retval == STATUS_TIMEDOUT)
+				TRACE_RET(chip, STATUS_TIMEDOUT);
+			else
+				TRACE_RET(chip, STATUS_FAIL);
+		}
+		/* GET_INT Register */
+		retval = ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT, &val, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		if ((end_page - start_page) == 1) {
+			if (!(val & INT_REG_CED)) {
+				/* Command can not be executed */
+				ms_set_err_code(chip, MS_FLASH_WRITE_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		} else {
+			if (page_addr == (end_page - 1)) {
+				if (!(val & INT_REG_CED)) {
+					retval =
+					    ms_send_cmd(chip, BLOCK_END,
+							WAIT_INT);
+					if (retval != STATUS_SUCCESS)
+						TRACE_RET(chip, retval);
+				}
+				/* GET_INT Register */
+				retval =
+				    ms_read_bytes(chip, GET_INT, 1, NO_WAIT_INT,
+						  &val, 1);
+				if (retval != STATUS_SUCCESS)
+					TRACE_RET(chip, retval);
+			}
+
+			if ((page_addr == (end_page - 1))
+			    || (page_addr == ms_card->page_off)) {
+				if (!(val & INT_REG_CED)) {
+					ms_set_err_code(chip,
+							MS_FLASH_WRITE_ERROR);
+					TRACE_RET(chip, STATUS_FAIL);
+				}
+			}
+		}
+	}
+
+	return STATUS_SUCCESS;
+}
+#endif
+
+static int ms_finish_write(struct rts51x_chip *chip, u16 old_blk, u16 new_blk,
+			   u16 log_blk, u8 page_off)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, seg_no;
+
+#ifdef MS_SPEEDUP
+	retval = ms_auto_copy_page(chip, old_blk, new_blk, log_blk,
+				   page_off, ms_card->page_off + 1);
+#else
+	retval = ms_copy_page(chip, old_blk, new_blk, log_blk,
+			      page_off, ms_card->page_off + 1);
+#endif
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	seg_no = old_blk >> 9;
+
+	if (MS_TST_BAD_BLOCK_FLG(ms_card)) {
+		MS_CLR_BAD_BLOCK_FLG(ms_card);
+		ms_set_bad_block(chip, old_blk);
+	} else {
+		retval = ms_erase_block(chip, old_blk);
+		if (retval == STATUS_SUCCESS)
+			ms_set_unused_block(chip, old_blk);
+	}
+
+	ms_set_l2p_tbl(chip, seg_no, log_blk - ms_start_idx[seg_no], new_blk);
+
+	return STATUS_SUCCESS;
+}
+
+static int ms_prepare_write(struct rts51x_chip *chip, u16 old_blk, u16 new_blk,
+			    u16 log_blk, u8 start_page)
+{
+	int retval;
+
+	if (start_page) {
+#ifdef MS_SPEEDUP
+		retval =
+		    ms_auto_copy_page(chip, old_blk, new_blk, log_blk, 0,
+				      start_page);
+#else
+		retval =
+		    ms_copy_page(chip, old_blk, new_blk, log_blk, 0,
+				 start_page);
+#endif
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_ms_delay_write(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	struct rts51x_ms_delay_write_tag *delay_write = &(ms_card->delay_write);
+	int retval;
+
+	if (delay_write->delay_write_flag) {
+		retval = ms_set_init_para(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		delay_write->delay_write_flag = 0;
+		retval = ms_finish_write(chip,
+					 delay_write->old_phyblock,
+					 delay_write->new_phyblock,
+					 delay_write->logblock,
+					 delay_write->pageoff);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static inline void rts51x_ms_rw_fail(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	if (srb->sc_data_direction == DMA_FROM_DEVICE)
+		rts51x_set_sense_type(chip, SCSI_LUN(srb),
+			       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+	else
+		rts51x_set_sense_type(chip, SCSI_LUN(srb), SENSE_TYPE_MEDIA_WRITE_ERR);
+}
+
+static int rts51x_ms_rw_multi_sector(struct scsi_cmnd *srb, struct rts51x_chip *chip,
+			      u32 start_sector, u16 sector_cnt)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	unsigned int lun = SCSI_LUN(srb);
+	int retval, seg_no;
+	unsigned int offset = 0;
+	u16 old_blk = 0, new_blk = 0, log_blk, total_sec_cnt = sector_cnt;
+	u8 start_page, end_page = 0, page_cnt;
+	u8 *buf;
+	void *ptr = NULL;
+	struct rts51x_ms_delay_write_tag *delay_write = &(ms_card->delay_write);
+
+	ms_set_err_code(chip, MS_NO_ERROR);
+
+	ms_card->counter = 0;
+
+	buf = (u8 *) scsi_sglist(srb);
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_ms_rw_fail(srb, chip);
+		TRACE_RET(chip, retval);
+	}
+
+	log_blk = (u16) (start_sector >> ms_card->block_shift);
+	start_page = (u8) (start_sector & ms_card->page_off);
+
+	for (seg_no = 0; seg_no < ARRAY_SIZE(ms_start_idx) - 1; seg_no++) {
+		if (log_blk < ms_start_idx[seg_no + 1])
+			break;
+	}
+
+	if (ms_card->segment[seg_no].build_flag == 0) {
+		retval = ms_build_l2p_tbl(chip, seg_no);
+		if (retval != STATUS_SUCCESS) {
+			chip->card_fail |= MS_CARD;
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+			TRACE_RET(chip, retval);
+		}
+	}
+
+	if (srb->sc_data_direction == DMA_TO_DEVICE) {
+		if (delay_write->delay_write_flag &&
+		    (delay_write->logblock == log_blk) &&
+		    (start_page > delay_write->pageoff)) {
+			delay_write->delay_write_flag = 0;
+#ifdef MS_SPEEDUP
+			retval = ms_auto_copy_page(chip,
+						   delay_write->old_phyblock,
+						   delay_write->new_phyblock,
+						   log_blk,
+						   delay_write->pageoff,
+						   start_page);
+#else
+			retval = ms_copy_page(chip,
+					      delay_write->old_phyblock,
+					      delay_write->new_phyblock,
+					      log_blk, delay_write->pageoff,
+					      start_page);
+#endif
+			if (retval != STATUS_SUCCESS) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, retval);
+			}
+			old_blk = delay_write->old_phyblock;
+			new_blk = delay_write->new_phyblock;
+		} else if (delay_write->delay_write_flag &&
+			   (delay_write->logblock == log_blk) &&
+			   (start_page == delay_write->pageoff)) {
+			delay_write->delay_write_flag = 0;
+			old_blk = delay_write->old_phyblock;
+			new_blk = delay_write->new_phyblock;
+		} else {
+			retval = rts51x_ms_delay_write(chip);
+			if (retval != STATUS_SUCCESS) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, retval);
+			}
+			old_blk =
+			    ms_get_l2p_tbl(chip, seg_no,
+					   log_blk - ms_start_idx[seg_no]);
+			new_blk = ms_get_unused_block(chip, seg_no);
+			if ((old_blk == 0xFFFF) || (new_blk == 0xFFFF)) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			retval =
+			    ms_prepare_write(chip, old_blk, new_blk, log_blk,
+					     start_page);
+			if (retval != STATUS_SUCCESS) {
+				if (monitor_card_cd(chip, MS_CARD) ==
+				    CD_NOT_EXIST) {
+					rts51x_set_sense_type(chip, lun,
+						SENSE_TYPE_MEDIA_NOT_PRESENT);
+					TRACE_RET(chip, STATUS_FAIL);
+				}
+
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, retval);
+			}
+		}
+	} else {
+		retval = rts51x_ms_delay_write(chip);
+		if (retval != STATUS_SUCCESS) {
+			if (monitor_card_cd(chip, MS_CARD) == CD_NOT_EXIST) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_NOT_PRESENT);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+			TRACE_RET(chip, retval);
+		}
+		old_blk =
+		    ms_get_l2p_tbl(chip, seg_no,
+				   log_blk - ms_start_idx[seg_no]);
+		if (old_blk == 0xFFFF) {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	RTS51X_DEBUGP("seg_no = %d, old_blk = 0x%x, new_blk = 0x%x\n", seg_no,
+		       old_blk, new_blk);
+
+	while (total_sec_cnt) {
+		if ((start_page + total_sec_cnt) > (ms_card->page_off + 1))
+			end_page = ms_card->page_off + 1;
+		else
+			end_page = start_page + (u8) total_sec_cnt;
+		page_cnt = end_page - start_page;
+
+		RTS51X_DEBUGP("start_page = %d, end_page = %d, page_cnt = %d\n",
+					start_page, end_page, page_cnt);
+
+		if (srb->sc_data_direction == DMA_FROM_DEVICE)
+			retval = ms_read_multiple_pages(chip,
+							old_blk, log_blk,
+							start_page, end_page,
+							buf, &ptr, &offset);
+		else
+			retval = ms_write_multiple_pages(chip, old_blk,
+							 new_blk, log_blk,
+							 start_page, end_page,
+							 buf, &ptr, &offset);
+
+		if (retval != STATUS_SUCCESS) {
+			if (monitor_card_cd(chip, MS_CARD) == CD_NOT_EXIST) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_NOT_PRESENT);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			rts51x_ms_rw_fail(srb, chip);
+			TRACE_RET(chip, retval);
+		}
+		/* Update L2P table if need */
+		if (srb->sc_data_direction == DMA_TO_DEVICE) {
+			if (end_page == (ms_card->page_off + 1)) {
+				retval = ms_erase_block(chip, old_blk);
+				if (retval == STATUS_SUCCESS)
+					ms_set_unused_block(chip, old_blk);
+				ms_set_l2p_tbl(chip, seg_no,
+					       log_blk - ms_start_idx[seg_no],
+					       new_blk);
+			}
+		}
+
+		total_sec_cnt -= page_cnt;
+
+		if (total_sec_cnt == 0)
+			break;
+
+		log_blk++;
+
+		for (seg_no = 0; seg_no < ARRAY_SIZE(ms_start_idx) - 1;
+				seg_no++) {
+			if (log_blk < ms_start_idx[seg_no + 1])
+				break;
+		}
+
+		if (ms_card->segment[seg_no].build_flag == 0) {
+			retval = ms_build_l2p_tbl(chip, seg_no);
+			if (retval != STATUS_SUCCESS) {
+				chip->card_fail |= MS_CARD;
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_NOT_PRESENT);
+				TRACE_RET(chip, retval);
+			}
+		}
+
+		old_blk =
+		    ms_get_l2p_tbl(chip, seg_no,
+				   log_blk - ms_start_idx[seg_no]);
+		if (old_blk == 0xFFFF) {
+			rts51x_ms_rw_fail(srb, chip);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		if (srb->sc_data_direction == DMA_TO_DEVICE) {
+			new_blk = ms_get_unused_block(chip, seg_no);
+			if (new_blk == 0xFFFF) {
+				rts51x_ms_rw_fail(srb, chip);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		RTS51X_DEBUGP("seg_no = %d, old_blk = 0x%x, new_blk = 0x%x\n",
+			       seg_no, old_blk, new_blk);
+
+		start_page = 0;
+	}
+
+	if (srb->sc_data_direction == DMA_TO_DEVICE) {
+		if (end_page < (ms_card->page_off + 1)) {
+			delay_write->delay_write_flag = 1;
+			delay_write->old_phyblock = old_blk;
+			delay_write->new_phyblock = new_blk;
+			delay_write->logblock = log_blk;
+			delay_write->pageoff = end_page;
+		}
+	}
+
+	scsi_set_resid(srb, 0);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_ms_rw(struct scsi_cmnd *srb, struct rts51x_chip *chip, u32 start_sector,
+	  u16 sector_cnt)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+
+	if (CHK_MSPRO(ms_card))
+		retval =
+		    mspro_rw_multi_sector(srb, chip, start_sector, sector_cnt);
+	else
+		retval =
+		    rts51x_ms_rw_multi_sector(srb, chip, start_sector, sector_cnt);
+
+	return retval;
+}
+
+void rts51x_ms_free_l2p_tbl(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int i = 0;
+
+	if (ms_card->segment != NULL) {
+		for (i = 0; i < ms_card->segment_cnt; i++) {
+			if (ms_card->segment[i].l2p_table != NULL) {
+				vfree(ms_card->segment[i].l2p_table);
+				ms_card->segment[i].l2p_table = NULL;
+			}
+			if (ms_card->segment[i].free_table != NULL) {
+				vfree(ms_card->segment[i].free_table);
+				ms_card->segment[i].free_table = NULL;
+			}
+		}
+		vfree(ms_card->segment);
+		ms_card->segment = NULL;
+	}
+}
+
+void rts51x_ms_cleanup_work(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+
+	if (CHK_MSPRO(ms_card)) {
+		if (ms_card->seq_mode) {
+			RTS51X_DEBUGP("MS Pro: stop transmission\n");
+			mspro_stop_seq_mode(chip);
+			ms_card->counter = 0;
+		}
+		if (CHK_MSHG(ms_card)) {
+			u8 value;
+			rts51x_read_register(chip, MS_CFG, &value);
+			if (value & MS_2K_SECTOR_MODE)
+				rts51x_write_register(chip, MS_CFG,
+						      MS_2K_SECTOR_MODE, 0x00);
+		}
+	} else if ((!CHK_MSPRO(ms_card))
+		   && ms_card->delay_write.delay_write_flag) {
+		RTS51X_DEBUGP("MS: delay write\n");
+		rts51x_ms_delay_write(chip);
+		ms_card->counter = 0;
+	}
+}
+
+static int ms_power_off_card3v3(struct rts51x_chip *chip)
+{
+	int retval;
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_EN, MS_CLK_EN, 0);
+	if (chip->asic_code)
+		ms_pull_ctl_disable(chip);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, FPGA_PULL_CTL,
+			       FPGA_MS_PULL_CTL_BIT | 0x20,
+			       FPGA_MS_PULL_CTL_BIT);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, MS_OUTPUT_EN, 0);
+	if (!chip->option.FT2_fast_mode) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK,
+			       POWER_OFF);
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_release_ms_card(struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+
+	RTS51X_DEBUGP("rts51x_release_ms_card\n");
+
+	ms_card->delay_write.delay_write_flag = 0;
+	ms_card->pro_under_formatting = 0;
+
+	chip->card_ready &= ~MS_CARD;
+	chip->card_fail &= ~MS_CARD;
+	chip->card_wp &= ~MS_CARD;
+
+	rts51x_ms_free_l2p_tbl(chip);
+
+	rts51x_write_register(chip, SFSM_ED, HW_CMD_STOP, HW_CMD_STOP);
+
+	memset(ms_card->raw_sys_info, 0, 96);
+#ifdef SUPPORT_PCGL_1P18
+	memset(ms_card->raw_model_name, 0, 48);
+#endif
+
+	retval = ms_power_off_card3v3(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
diff --git a/drivers/staging/rts5139/ms.h b/drivers/staging/rts5139/ms.h
new file mode 100644
index 000000000000..857c1974ef24
--- /dev/null
+++ b/drivers/staging/rts5139/ms.h
@@ -0,0 +1,261 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_MS_H
+#define __RTS51X_MS_H
+
+#include "rts51x_chip.h"
+
+#define	MS_MAX_RETRY_COUNT		3
+
+#define	MS_EXTRA_SIZE			0x9
+
+#define	WRT_PRTCT			0x01
+
+/* Error Code */
+#define	MS_NO_ERROR				0x00
+#define	MS_CRC16_ERROR				0x80
+#define	MS_TO_ERROR				0x40
+#define	MS_NO_CARD				0x20
+#define	MS_NO_MEMORY				0x10
+#define	MS_CMD_NK				0x08
+#define	MS_FLASH_READ_ERROR			0x04
+#define	MS_FLASH_WRITE_ERROR			0x02
+#define	MS_BREQ_ERROR				0x01
+#define	MS_NOT_FOUND				0x03
+
+/* Transfer Protocol Command */
+#define READ_PAGE_DATA				0x02
+#define READ_REG				0x04
+#define	GET_INT					0x07
+#define WRITE_PAGE_DATA				0x0D
+#define WRITE_REG				0x0B
+#define SET_RW_REG_ADRS				0x08
+#define SET_CMD					0x0E
+
+#define	PRO_READ_LONG_DATA			0x02
+#define	PRO_READ_SHORT_DATA			0x03
+#define PRO_READ_REG				0x04
+#define	PRO_READ_QUAD_DATA			0x05
+#define PRO_GET_INT				0x07
+#define	PRO_WRITE_LONG_DATA			0x0D
+#define	PRO_WRITE_SHORT_DATA			0x0C
+#define	PRO_WRITE_QUAD_DATA			0x0A
+#define PRO_WRITE_REG				0x0B
+#define PRO_SET_RW_REG_ADRS			0x08
+#define PRO_SET_CMD				0x0E
+#define PRO_EX_SET_CMD				0x09
+
+#ifdef SUPPORT_MAGIC_GATE
+#define MG_GET_ID		0x40
+#define MG_SET_LID		0x41
+#define MG_GET_LEKB		0x42
+#define MG_SET_RD		0x43
+#define MG_MAKE_RMS		0x44
+#define MG_MAKE_KSE		0x45
+#define MG_SET_IBD		0x46
+#define MG_GET_IBD		0x47
+#endif
+
+#ifdef XC_POWERCLASS
+#define XC_CHG_POWER		0x16
+#endif
+
+/* ++ CMD over Memory Stick */
+/*  Flash CMD */
+#define BLOCK_READ		0xAA
+#define	BLOCK_WRITE		0x55
+#define BLOCK_END		0x33
+#define BLOCK_ERASE		0x99
+#define FLASH_STOP		0xCC
+
+/*  Function CMD */
+#define SLEEP			0x5A
+#define CLEAR_BUF		0xC3
+#define MS_RESET		0x3C
+/* -- CMD over Memory Stick */
+
+/* ++ CMD over Memory Stick Pro */
+/*  Flash CMD */
+#define PRO_READ_DATA		0x20
+#define	PRO_WRITE_DATA		0x21
+#define PRO_READ_ATRB		0x24
+#define PRO_STOP		0x25
+#define PRO_ERASE		0x26
+#define	PRO_READ_2K_DATA	0x27
+#define	PRO_WRITE_2K_DATA	0x28
+
+/*  Function CMD */
+#define PRO_FORMAT		0x10
+#define PRO_SLEEP		0x11
+/* -- CMD over Memory Stick Pro */
+
+/*  register inside memory stick */
+#define	IntReg			0x01
+#define StatusReg0		0x02
+#define StatusReg1		0x03
+
+#define SystemParm		0x10
+#define BlockAdrs		0x11
+#define CMDParm			0x14
+#define PageAdrs		0x15
+
+#define OverwriteFlag		0x16
+#define ManagemenFlag		0x17
+#define LogicalAdrs		0x18
+#define ReserveArea		0x1A
+
+/*  register inside memory pro */
+#define	Pro_IntReg		0x01
+#define Pro_StatusReg		0x02
+#define Pro_TypeReg		0x04
+#define	Pro_IFModeReg		0x05
+#define Pro_CatagoryReg		0x06
+#define Pro_ClassReg		0x07
+
+#define Pro_SystemParm		0x10
+#define Pro_DataCount1		0x11
+#define Pro_DataCount0		0x12
+#define Pro_DataAddr3		0x13
+#define Pro_DataAddr2		0x14
+#define Pro_DataAddr1		0x15
+#define Pro_DataAddr0		0x16
+
+#define Pro_TPCParm		0x17
+#define Pro_CMDParm		0x18
+
+/*  define for INT Register */
+#define	INT_REG_CED		0x80
+#define	INT_REG_ERR		0x40
+#define	INT_REG_BREQ		0x20
+#define	INT_REG_CMDNK		0x01
+
+/*  INT signal */
+#define	INT_CED			0x01
+#define	INT_ERR			0x02
+#define	INT_BREQ		0x04
+#define	INT_CMDNK		0x08
+
+/*  define for OverwriteFlag Register */
+#define	BLOCK_BOOT		0xC0
+#define	BLOCK_OK		0x80
+#define	PAGE_OK			0x60
+#define	DATA_COMPL		0x10
+
+/*  define for ManagemenFlag Register */
+#define	NOT_BOOT_BLOCK		0x4
+#define	NOT_TRANSLATION_TABLE	0x8
+
+/*  Header */
+#define	HEADER_ID0		(PPBUF_BASE2)			/* 0 */
+#define	HEADER_ID1		(PPBUF_BASE2 + 1)		/* 1 */
+/*  System Entry */
+#define	DISABLED_BLOCK0		(PPBUF_BASE2 + 0x170 + 4)	/* 2 */
+#define	DISABLED_BLOCK1		(PPBUF_BASE2 + 0x170 + 5)	/* 3 */
+#define	DISABLED_BLOCK2		(PPBUF_BASE2 + 0x170 + 6)	/* 4 */
+#define	DISABLED_BLOCK3		(PPBUF_BASE2 + 0x170 + 7)	/* 5 */
+/*  Boot & Attribute Information */
+#define	BLOCK_SIZE_0		(PPBUF_BASE2 + 0x1a0 + 2)	/* 6 */
+#define	BLOCK_SIZE_1		(PPBUF_BASE2 + 0x1a0 + 3)	/* 7 */
+#define	BLOCK_COUNT_0		(PPBUF_BASE2 + 0x1a0 + 4)	/* 8 */
+#define	BLOCK_COUNT_1		(PPBUF_BASE2 + 0x1a0 + 5)	/* 9 */
+#define	EBLOCK_COUNT_0		(PPBUF_BASE2 + 0x1a0 + 6)	/* 10 */
+#define	EBLOCK_COUNT_1		(PPBUF_BASE2 + 0x1a0 + 7)	/* 11 */
+#define	PAGE_SIZE_0		(PPBUF_BASE2 + 0x1a0 + 8)	/* 12 */
+#define	PAGE_SIZE_1		(PPBUF_BASE2 + 0x1a0 + 9)	/* 13 */
+
+/* joey 2004-08-07 for MS check Procedure */
+#define MS_Device_Type	(PPBUF_BASE2 + 0x1D8)	/* 14 */
+/* end */
+
+/* joey 2004-05-03 */
+#define	MS_4bit_Support	(PPBUF_BASE2 + 0x1D3)	/* 15 */
+/* end */
+
+#define setPS_NG	1
+#define setPS_Error	0
+
+/*  define for Pro_SystemParm Register */
+#define	PARALLEL_8BIT_IF	0x40
+#define	PARALLEL_4BIT_IF	0x00
+#define	SERIAL_IF		0x80
+
+/*  define for StatusReg0 Register */
+#define BUF_FULL	0x10
+#define BUF_EMPTY	0x20
+
+/*  define for StatusReg1 Register */
+#define	MEDIA_BUSY	0x80
+#define	FLASH_BUSY	0x40
+#define	DATA_ERROR	0x20
+#define	STS_UCDT	0x10
+#define	EXTRA_ERROR	0x08
+#define	STS_UCEX	0x04
+#define	FLAG_ERROR	0x02
+#define	STS_UCFG	0x01
+
+#define MS_SHORT_DATA_LEN	32
+
+#define FORMAT_SUCCESS		0
+#define FORMAT_FAIL		1
+#define FORMAT_IN_PROGRESS	2
+
+#define	MS_SET_BAD_BLOCK_FLG(ms_card)	((ms_card)->multi_flag |= 0x80)
+#define MS_CLR_BAD_BLOCK_FLG(ms_card)	((ms_card)->multi_flag &= 0x7F)
+#define MS_TST_BAD_BLOCK_FLG(ms_card)	((ms_card)->multi_flag & 0x80)
+
+#define CHECK_MS_TRANS_FAIL(chip, retval)	\
+	(((retval) != STATUS_SUCCESS) || \
+	(chip->rsp_buf[0] & MS_TRANSFER_ERR))
+
+void rts51x_mspro_polling_format_status(struct rts51x_chip *chip);
+void rts51x_mspro_format_sense(struct rts51x_chip *chip, unsigned int lun);
+
+int rts51x_reset_ms_card(struct rts51x_chip *chip);
+int rts51x_ms_rw(struct scsi_cmnd *srb, struct rts51x_chip *chip, u32 start_sector,
+	  u16 sector_cnt);
+int rts51x_mspro_format(struct scsi_cmnd *srb, struct rts51x_chip *chip,
+		 int short_data_len, int quick_format);
+void rts51x_ms_free_l2p_tbl(struct rts51x_chip *chip);
+void rts51x_ms_cleanup_work(struct rts51x_chip *chip);
+int rts51x_release_ms_card(struct rts51x_chip *chip);
+int rts51x_ms_delay_write(struct rts51x_chip *chip);
+
+#ifdef SUPPORT_MAGIC_GATE
+
+int ms_switch_clock(struct rts51x_chip *chip);
+int ms_write_bytes(struct rts51x_chip *chip, u8 tpc, u8 cnt, u8 cfg, u8 *data,
+		   int data_len);
+int ms_read_bytes(struct rts51x_chip *chip, u8 tpc, u8 cnt, u8 cfg, u8 *data,
+		  int data_len);
+int ms_set_rw_reg_addr(struct rts51x_chip *chip, u8 read_start, u8 read_cnt,
+		       u8 write_start, u8 write_cnt);
+int ms_transfer_data(struct rts51x_chip *chip, u8 trans_mode, u8 tpc,
+		     u16 sec_cnt, u8 cfg, int mode_2k, int use_sg, void *buf,
+		     int buf_len);
+#endif
+
+#endif /* __RTS51X_MS_H */
diff --git a/drivers/staging/rts5139/ms_mg.c b/drivers/staging/rts5139/ms_mg.c
new file mode 100644
index 000000000000..c8f26062c682
--- /dev/null
+++ b/drivers/staging/rts5139/ms_mg.c
@@ -0,0 +1,643 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include "debug.h"
+#include "trace.h"
+#include "rts51x.h"
+#include "rts51x_transport.h"
+#include "rts51x_scsi.h"
+#include "rts51x_card.h"
+#include "ms.h"
+#include "ms_mg.h"
+
+#ifdef SUPPORT_MAGIC_GATE
+
+static int mg_check_int_error(struct rts51x_chip *chip)
+{
+	u8 value;
+
+	rts51x_read_register(chip, MS_TRANS_CFG, &value);
+	if (value & (INT_ERR | INT_CMDNK))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+static int mg_send_ex_cmd(struct rts51x_chip *chip, u8 cmd, u8 entry_num)
+{
+	int retval, i;
+	u8 data[8];
+
+	data[0] = cmd;
+	data[1] = 0;
+	data[2] = 0;
+	data[3] = 0;
+	data[4] = 0;
+	data[5] = 0;
+	data[6] = entry_num;
+	data[7] = 0;
+
+	for (i = 0; i < MS_MAX_RETRY_COUNT; i++) {
+		retval =
+		    ms_write_bytes(chip, PRO_EX_SET_CMD, 7, WAIT_INT, data, 8);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (i == MS_MAX_RETRY_COUNT)
+		TRACE_RET(chip, STATUS_FAIL);
+	retval = mg_check_int_error(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_mg_set_tpc_para_sub(struct rts51x_chip *chip, int type, u8 mg_entry_num)
+{
+	int retval;
+	u8 buf[6];
+
+	RTS51X_DEBUGP("--%s--\n", __func__);
+
+	if (type == 0)
+		retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_TPCParm, 1);
+	else
+		retval = ms_set_rw_reg_addr(chip, 0, 0, Pro_DataCount1, 6);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	buf[0] = 0;
+	buf[1] = 0;
+	if (type == 1) {
+		buf[2] = 0;
+		buf[3] = 0;
+		buf[4] = 0;
+		buf[5] = mg_entry_num;
+	}
+	retval =
+	    ms_write_bytes(chip, PRO_WRITE_REG, (type == 0) ? 1 : 6,
+			   NO_WAIT_INT, buf, 6);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+/**
+  * Get MagciGate ID and set Leaf ID to medium.
+
+  * After receiving this SCSI command, adapter shall fulfill 2 tasks
+  * below in order:
+  * 1. send GET_ID TPC command to get MagicGate ID and hold it till
+  * Response&challenge CMD.
+  * 2. send SET_ID TPC command to medium with Leaf ID released by host
+  * in this SCSI CMD.
+  */
+int rts51x_mg_set_leaf_id(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int retval;
+	int i;
+	unsigned int lun = SCSI_LUN(srb);
+	u8 buf1[32], buf2[12];
+
+	RTS51X_DEBUGP("--%s--\n", __func__);
+
+	if (scsi_bufflen(srb) < 12) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	rts51x_ms_cleanup_work(chip);
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = mg_send_ex_cmd(chip, MG_SET_LID, 0);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
+		TRACE_RET(chip, retval);
+	}
+
+	memset(buf1, 0, 32);
+	rts51x_get_xfer_buf(buf2, min(12, (int)scsi_bufflen(srb)), srb);
+	for (i = 0; i < 8; i++)
+		buf1[8 + i] = buf2[4 + i];
+	retval =
+	    ms_write_bytes(chip, PRO_WRITE_SHORT_DATA, 32, WAIT_INT, buf1, 32);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
+		TRACE_RET(chip, retval);
+	}
+	retval = mg_check_int_error(chip);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
+		TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+/**
+  * Send Local EKB to host.
+
+  * After receiving this SCSI command, adapter shall read the divided
+  * data(1536 bytes totally) from medium by using READ_LONG_DATA TPC
+  * for 3 times, and report data to host with data-length is 1052 bytes.
+  */
+int rts51x_mg_get_local_EKB(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int retval = STATUS_FAIL;
+	int bufflen;
+	unsigned int lun = SCSI_LUN(srb);
+	u8 *buf = NULL;
+
+	RTS51X_DEBUGP("--%s--\n", __func__);
+
+	rts51x_ms_cleanup_work(chip);
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	buf = kmalloc(1540, GFP_KERNEL);
+	if (!buf)
+		TRACE_RET(chip, STATUS_NOMEM);
+
+	buf[0] = 0x04;
+	buf[1] = 0x1A;
+	buf[2] = 0x00;
+	buf[3] = 0x00;
+
+	retval = mg_send_ex_cmd(chip, MG_GET_LEKB, 0);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		TRACE_GOTO(chip, GetEKBFinish);
+	}
+
+	retval = ms_transfer_data(chip, MS_TM_AUTO_READ, PRO_READ_LONG_DATA,
+				  3, WAIT_INT, 0, 0, buf + 4, 1536);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		rts51x_write_register(chip, CARD_STOP, MS_STOP | MS_CLR_ERR,
+				      MS_STOP | MS_CLR_ERR);
+		TRACE_GOTO(chip, GetEKBFinish);
+	}
+	retval = mg_check_int_error(chip);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		TRACE_GOTO(chip, GetEKBFinish);
+	}
+
+	bufflen = min(1052, (int)scsi_bufflen(srb));
+	rts51x_set_xfer_buf(buf, bufflen, srb);
+
+GetEKBFinish:
+	kfree(buf);
+	return retval;
+}
+
+/**
+  * Send challenge(host) to medium.
+
+  * After receiving this SCSI command, adapter shall sequentially issues
+  * TPC commands to the medium for writing 8-bytes data as challenge
+  * by host within a short data packet.
+  */
+int rts51x_mg_chg(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	int bufflen;
+	int i;
+	unsigned int lun = SCSI_LUN(srb);
+	u8 buf[32], tmp;
+
+	RTS51X_DEBUGP("--%s--\n", __func__);
+
+	rts51x_ms_cleanup_work(chip);
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = mg_send_ex_cmd(chip, MG_GET_ID, 0);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
+		TRACE_RET(chip, retval);
+	}
+
+	retval =
+	    ms_read_bytes(chip, PRO_READ_SHORT_DATA, 32, WAIT_INT, buf, 32);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
+		TRACE_RET(chip, retval);
+	}
+	retval = mg_check_int_error(chip);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
+		TRACE_RET(chip, retval);
+	}
+
+	memcpy(ms_card->magic_gate_id, buf, 16);
+
+	for (i = 0; i < 2500; i++) {
+		RTS51X_READ_REG(chip, MS_TRANS_CFG, &tmp);
+		if (tmp &
+		    (MS_INT_CED | MS_INT_CMDNK | MS_INT_BREQ | MS_INT_ERR))
+			break;
+
+		wait_timeout(1);
+	}
+
+	if (i == 2500) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	retval = mg_send_ex_cmd(chip, MG_SET_RD, 0);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
+		TRACE_RET(chip, retval);
+	}
+
+	bufflen = min(12, (int)scsi_bufflen(srb));
+	rts51x_get_xfer_buf(buf, bufflen, srb);
+
+	for (i = 0; i < 8; i++)
+		buf[i] = buf[4 + i];
+	for (i = 0; i < 24; i++)
+		buf[8 + i] = 0;
+	retval =
+	    ms_write_bytes(chip, PRO_WRITE_SHORT_DATA, 32, WAIT_INT, buf, 32);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
+		TRACE_RET(chip, retval);
+	}
+	retval = mg_check_int_error(chip);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
+		TRACE_RET(chip, retval);
+	}
+
+	ms_card->mg_auth = 0;
+
+	return STATUS_SUCCESS;
+}
+
+/**
+  * Send Response and Challenge data  to host.
+
+  * After receiving this SCSI command, adapter shall communicates with
+  * the medium, get parameters(HRd, Rms, MagicGateID) by using READ_SHORT_DATA
+  * TPC and send the data to host according to certain format required by
+  * MG-R specification.
+  * The paremeter MagicGateID is the one that adapter has obtained from
+  * the medium by TPC commands in Set Leaf ID command phase previously.
+  */
+int rts51x_mg_get_rsp_chg(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval, i;
+	int bufflen;
+	unsigned int lun = SCSI_LUN(srb);
+	u8 buf1[32], buf2[36], tmp;
+
+	RTS51X_DEBUGP("--%s--\n", __func__);
+
+	rts51x_ms_cleanup_work(chip);
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = mg_send_ex_cmd(chip, MG_MAKE_RMS, 0);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		TRACE_RET(chip, retval);
+	}
+
+	retval =
+	    ms_read_bytes(chip, PRO_READ_SHORT_DATA, 32, WAIT_INT, buf1, 32);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		TRACE_RET(chip, retval);
+	}
+	retval = mg_check_int_error(chip);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		TRACE_RET(chip, retval);
+	}
+
+	buf2[0] = 0x00;
+	buf2[1] = 0x22;
+	buf2[2] = 0x00;
+	buf2[3] = 0x00;
+
+	memcpy(buf2 + 4, ms_card->magic_gate_id, 16);
+	memcpy(buf2 + 20, buf1, 16);
+
+	bufflen = min(36, (int)scsi_bufflen(srb));
+	rts51x_set_xfer_buf(buf2, bufflen, srb);
+
+	for (i = 0; i < 2500; i++) {
+		RTS51X_READ_REG(chip, MS_TRANS_CFG, &tmp);
+		if (tmp & (MS_INT_CED | MS_INT_CMDNK |
+				MS_INT_BREQ | MS_INT_ERR))
+			break;
+
+		wait_timeout(1);
+	}
+
+	if (i == 2500) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+/**
+  * Send response(host) to medium.
+
+  * After receiving this SCSI command, adapter shall sequentially
+  * issues TPC commands to the medium for writing 8-bytes data as
+  * challenge by host within a short data packet.
+  */
+int rts51x_mg_rsp(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	int i;
+	int bufflen;
+	unsigned int lun = SCSI_LUN(srb);
+	u8 buf[32];
+
+	RTS51X_DEBUGP("--%s--\n", __func__);
+
+	rts51x_ms_cleanup_work(chip);
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = mg_send_ex_cmd(chip, MG_MAKE_KSE, 0);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		TRACE_RET(chip, retval);
+	}
+
+	bufflen = min(12, (int)scsi_bufflen(srb));
+	rts51x_get_xfer_buf(buf, bufflen, srb);
+
+	for (i = 0; i < 8; i++)
+		buf[i] = buf[4 + i];
+	for (i = 0; i < 24; i++)
+		buf[8 + i] = 0;
+	retval =
+	    ms_write_bytes(chip, PRO_WRITE_SHORT_DATA, 32, WAIT_INT, buf, 32);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		TRACE_RET(chip, retval);
+	}
+	retval = mg_check_int_error(chip);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN);
+		TRACE_RET(chip, retval);
+	}
+
+	ms_card->mg_auth = 1;
+
+	return STATUS_SUCCESS;
+}
+
+/** * Send ICV data to host.
+
+  * After receiving this SCSI command, adapter shall read the divided
+  * data(1024 bytes totally) from medium by using READ_LONG_DATA TPC
+  * for 2 times, and report data to host with data-length is 1028 bytes.
+  *
+  * Since the extra 4 bytes data is just only a prefix to original data
+  * that read from medium, so that the 4-byte data pushed into Ring buffer
+  * precedes data transmission from medium to Ring buffer by DMA mechanism
+  * in order to get maximum performance and minimum code size simultaneously.
+  */
+int rts51x_mg_get_ICV(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	int bufflen;
+	unsigned int lun = SCSI_LUN(srb);
+	u8 *buf = NULL;
+
+	RTS51X_DEBUGP("--%s--\n", __func__);
+
+	rts51x_ms_cleanup_work(chip);
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	buf = kmalloc(1028, GFP_KERNEL);
+	if (!buf)
+		TRACE_RET(chip, STATUS_NOMEM);
+
+	buf[0] = 0x04;
+	buf[1] = 0x02;
+	buf[2] = 0x00;
+	buf[3] = 0x00;
+
+	retval = mg_send_ex_cmd(chip, MG_GET_IBD, ms_card->mg_entry_num);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+		TRACE_GOTO(chip, GetICVFinish);
+	}
+
+	retval = ms_transfer_data(chip, MS_TM_AUTO_READ, PRO_READ_LONG_DATA,
+				  2, WAIT_INT, 0, 0, buf + 4, 1024);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+		rts51x_write_register(chip, CARD_STOP, MS_STOP | MS_CLR_ERR,
+				      MS_STOP | MS_CLR_ERR);
+		TRACE_GOTO(chip, GetICVFinish);
+	}
+	retval = mg_check_int_error(chip);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+		TRACE_GOTO(chip, GetICVFinish);
+	}
+
+	bufflen = min(1028, (int)scsi_bufflen(srb));
+	rts51x_set_xfer_buf(buf, bufflen, srb);
+
+GetICVFinish:
+	kfree(buf);
+	return retval;
+}
+
+/**
+  * Send ICV data to medium.
+
+  * After receiving this SCSI command, adapter shall receive 1028 bytes
+  * and write the later 1024 bytes to medium by WRITE_LONG_DATA TPC
+  * consecutively.
+  *
+  * Since the first 4-bytes data is just only a prefix to original data
+  * that sent by host, and it should be skipped by shifting DMA pointer
+  * before writing 1024 bytes to medium.
+  */
+int rts51x_mg_set_ICV(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	int bufflen;
+#ifdef MG_SET_ICV_SLOW
+	int i;
+#endif
+	unsigned int lun = SCSI_LUN(srb);
+	u8 *buf = NULL;
+
+	RTS51X_DEBUGP("--%s--\n", __func__);
+
+	rts51x_ms_cleanup_work(chip);
+
+	retval = ms_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	buf = kmalloc(1028, GFP_KERNEL);
+	if (!buf)
+		TRACE_RET(chip, STATUS_NOMEM);
+
+	bufflen = min(1028, (int)scsi_bufflen(srb));
+	rts51x_get_xfer_buf(buf, bufflen, srb);
+
+	retval = mg_send_ex_cmd(chip, MG_SET_IBD, ms_card->mg_entry_num);
+	if (retval != STATUS_SUCCESS) {
+		if (ms_card->mg_auth == 0) {
+			if ((buf[5] & 0xC0) != 0)
+				rts51x_set_sense_type(chip, lun,
+					SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
+			else
+				rts51x_set_sense_type(chip, lun,
+					SENSE_TYPE_MG_WRITE_ERR);
+		} else {
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_WRITE_ERR);
+		}
+		TRACE_GOTO(chip, SetICVFinish);
+	}
+
+#ifdef MG_SET_ICV_SLOW
+	for (i = 0; i < 2; i++) {
+		udelay(50);
+
+		rts51x_init_cmd(chip);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TPC, 0xFF,
+			       PRO_WRITE_LONG_DATA);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANS_CFG, 0xFF,
+			       WAIT_INT);
+
+		rts51x_trans_dma_enable(DMA_TO_DEVICE, chip, 512, DMA_512);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MS_TRANSFER, 0xFF,
+			       MS_TRANSFER_START | MS_TM_NORMAL_WRITE);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, MS_TRANSFER,
+			       MS_TRANSFER_END, MS_TRANSFER_END);
+
+		retval = rts51x_send_cmd(chip, MODE_CDOR, 100);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_WRITE_ERR);
+			TRACE_GOTO(chip, SetICVFinish);
+		}
+
+		retval = rts51x_transfer_data_rcc(chip, SND_BULK_PIPE(chip),
+						  buf + 4 + i * 512, 512, 0,
+						  NULL, 3000, STAGE_DO);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_clear_ms_error(chip);
+			if (ms_card->mg_auth == 0) {
+				if ((buf[5] & 0xC0) != 0)
+					rts51x_set_sense_type(chip, lun,
+						SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
+				else
+					rts51x_set_sense_type(chip, lun,
+						SENSE_TYPE_MG_WRITE_ERR);
+			} else {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MG_WRITE_ERR);
+			}
+			retval = STATUS_FAIL;
+			TRACE_GOTO(chip, SetICVFinish);
+		}
+
+		retval = rts51x_get_rsp(chip, 1, 3000);
+		if (CHECK_MS_TRANS_FAIL(chip, retval)
+		    || mg_check_int_error(chip)) {
+			rts51x_clear_ms_error(chip);
+			if (ms_card->mg_auth == 0) {
+				if ((buf[5] & 0xC0) != 0)
+					rts51x_set_sense_type(chip, lun,
+						SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
+				else
+					rts51x_set_sense_type(chip, lun,
+						SENSE_TYPE_MG_WRITE_ERR);
+			} else {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MG_WRITE_ERR);
+			}
+			retval = STATUS_FAIL;
+			TRACE_GOTO(chip, SetICVFinish);
+		}
+	}
+#else
+	retval = ms_transfer_data(chip, MS_TM_AUTO_WRITE, PRO_WRITE_LONG_DATA,
+				  2, WAIT_INT, 0, 0, buf + 4, 1024);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_ms_error(chip);
+		if (ms_card->mg_auth == 0) {
+			if ((buf[5] & 0xC0) != 0)
+				rts51x_set_sense_type(chip, lun,
+					SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB);
+			else
+				rts51x_set_sense_type(chip, lun,
+					SENSE_TYPE_MG_WRITE_ERR);
+		} else {
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_WRITE_ERR);
+		}
+		TRACE_GOTO(chip, SetICVFinish);
+	}
+#endif
+
+SetICVFinish:
+	kfree(buf);
+	return retval;
+}
+
+#endif /* SUPPORT_MAGIC_GATE */
diff --git a/drivers/staging/rts5139/ms_mg.h b/drivers/staging/rts5139/ms_mg.h
new file mode 100644
index 000000000000..109c71290953
--- /dev/null
+++ b/drivers/staging/rts5139/ms_mg.h
@@ -0,0 +1,42 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_MS_MG_H
+#define __RTS51X_MS_MG_H
+
+#include "rts51x_chip.h"
+#include "ms.h"
+
+int rts51x_mg_set_tpc_para_sub(struct rts51x_chip *chip, int type, u8 mg_entry_num);
+int rts51x_mg_set_leaf_id(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_mg_get_local_EKB(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_mg_chg(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_mg_get_rsp_chg(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_mg_rsp(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_mg_get_ICV(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_mg_set_ICV(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+
+#endif /* __RTS51X_MS_MG_H */
diff --git a/drivers/staging/rts5139/rts51x.c b/drivers/staging/rts5139/rts51x.c
new file mode 100644
index 000000000000..8529cbabc554
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x.c
@@ -0,0 +1,846 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+#include <linux/errno.h>
+#include <linux/freezer.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/utsname.h>
+#include <linux/usb.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_devinfo.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_host.h>
+
+#include "debug.h"
+#include "ms.h"
+#include "rts51x.h"
+#include "rts51x_chip.h"
+#include "rts51x_card.h"
+#include "rts51x_scsi.h"
+#include "rts51x_transport.h"
+#include "rts51x_fop.h"
+
+MODULE_DESCRIPTION(RTS51X_DESC);
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRIVER_VERSION);
+
+static int auto_delink_en;
+module_param(auto_delink_en, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(auto_delink_en, "enable auto delink");
+
+static int ss_en;
+module_param(ss_en, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(ss_en, "enable selective suspend");
+
+static int ss_delay = 50;
+module_param(ss_delay, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(ss_delay,
+		 "seconds to delay before entering selective suspend");
+
+static int needs_remote_wakeup;
+module_param(needs_remote_wakeup, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(needs_remote_wakeup, "ss state needs remote wakeup supported");
+
+#ifdef SUPPORT_FILE_OP
+static const struct file_operations rts51x_fops = {
+	.owner = THIS_MODULE,
+	.read = rts51x_read,
+	.write = rts51x_write,
+	.unlocked_ioctl = rts51x_ioctl,
+	.open = rts51x_open,
+	.release = rts51x_release,
+};
+
+/*
+ * usb class driver info in order to get a minor number from the usb core,
+ * and to have the device registered with the driver core
+ */
+static struct usb_class_driver rts51x_class = {
+	.name = "rts51x%d",
+	.fops = &rts51x_fops,
+	.minor_base = 192,
+};
+#endif
+
+#ifdef CONFIG_PM		/* Minimal support for suspend and resume */
+
+static inline void usb_autopm_enable(struct usb_interface *intf)
+{
+	atomic_set(&intf->pm_usage_cnt, 1);
+	usb_autopm_put_interface(intf);
+}
+
+static inline void usb_autopm_disable(struct usb_interface *intf)
+{
+	atomic_set(&intf->pm_usage_cnt, 0);
+	usb_autopm_get_interface(intf);
+}
+
+static void rts51x_try_to_enter_ss(struct rts51x_chip *chip)
+{
+	pr_debug("Ready to enter SS state\n");
+	usb_autopm_enable(chip->usb->pusb_intf);
+}
+
+void rts51x_try_to_exit_ss(struct rts51x_chip *chip)
+{
+	pr_debug("Exit from SS state\n");
+	usb_autopm_disable(chip->usb->pusb_intf);
+}
+
+int rts51x_suspend(struct usb_interface *iface, pm_message_t message)
+{
+	struct rts51x_chip *chip = usb_get_intfdata(iface);
+
+	pr_debug("%s, message.event = 0x%x\n", __func__, message.event);
+
+	/* Wait until no command is running */
+	mutex_lock(&chip->usb->dev_mutex);
+
+	chip->fake_card_ready = chip->card_ready;
+	rts51x_do_before_power_down(chip);
+
+	if (message.event == PM_EVENT_AUTO_SUSPEND) {
+		pr_debug("Enter SS state");
+		chip->resume_from_scsi = 0;
+		RTS51X_SET_STAT(chip, STAT_SS);
+	} else {
+		pr_debug("Enter SUSPEND state");
+		RTS51X_SET_STAT(chip, STAT_SUSPEND);
+	}
+
+	/* When runtime PM is working, we'll set a flag to indicate
+	 * whether we should autoresume when a SCSI request arrives. */
+
+	mutex_unlock(&chip->usb->dev_mutex);
+	return 0;
+}
+
+int rts51x_resume(struct usb_interface *iface)
+{
+	struct rts51x_chip *chip = usb_get_intfdata(iface);
+
+	pr_debug("%s\n", __func__);
+
+	if (!RTS51X_CHK_STAT(chip, STAT_SS) || !chip->resume_from_scsi) {
+		mutex_lock(&chip->usb->dev_mutex);
+
+		if (chip->option.ss_en) {
+			if (GET_PM_USAGE_CNT(chip) <= 0) {
+				/* Remote wake up, increase pm_usage_cnt */
+				pr_debug("Incr pm_usage_cnt\n");
+				SET_PM_USAGE_CNT(chip, 1);
+			}
+		}
+
+		RTS51X_SET_STAT(chip, STAT_RUN);
+
+		rts51x_init_chip(chip);
+		rts51x_init_cards(chip);
+
+		mutex_unlock(&chip->usb->dev_mutex);
+	}
+
+	return 0;
+}
+
+int rts51x_reset_resume(struct usb_interface *iface)
+{
+	struct rts51x_chip *chip = usb_get_intfdata(iface);
+
+	pr_debug("%s\n", __func__);
+
+	mutex_lock(&chip->usb->dev_mutex);
+
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	if (chip->option.ss_en)
+		SET_PM_USAGE_CNT(chip, 1);
+
+	rts51x_init_chip(chip);
+	rts51x_init_cards(chip);
+
+	mutex_unlock(&chip->usb->dev_mutex);
+
+	/* FIXME: Notify the subdrivers that they need to reinitialize
+	 * the device */
+	return 0;
+}
+
+#else /* CONFIG_PM */
+
+static void rts51x_try_to_enter_ss(struct rts51x_chip *chip)
+{
+}
+
+void rts51x_try_to_exit_ss(struct rts51x_chip *chip)
+{
+}
+
+#endif /* CONFIG_PM */
+
+/*
+ * The next two routines get called just before and just after
+ * a USB port reset, whether from this driver or a different one.
+ */
+
+static int rts51x_pre_reset(struct usb_interface *iface)
+{
+	struct rts51x_chip *chip = usb_get_intfdata(iface);
+
+	pr_debug("%s\n", __func__);
+
+	/* Make sure no command runs during the reset */
+	mutex_lock(&chip->usb->dev_mutex);
+	return 0;
+}
+
+static int rts51x_post_reset(struct usb_interface *iface)
+{
+	struct rts51x_chip *chip = usb_get_intfdata(iface);
+
+	pr_debug("%s\n", __func__);
+
+	/* Report the reset to the SCSI core */
+	/* usb_stor_report_bus_reset(us); */
+
+	/* FIXME: Notify the subdrivers that they need to reinitialize
+	 * the device */
+
+	mutex_unlock(&chip->usb->dev_mutex);
+	return 0;
+}
+
+static int rts51x_control_thread(void *__chip)
+{
+	struct rts51x_chip *chip = (struct rts51x_chip *)__chip;
+	struct Scsi_Host *host = rts51x_to_host(chip);
+
+	for (;;) {
+		if (wait_for_completion_interruptible(&chip->usb->cmnd_ready))
+			break;
+
+		if (test_bit(FLIDX_DISCONNECTING, &chip->usb->dflags)) {
+			pr_debug("-- exiting from rts51x-control\n");
+			break;
+		}
+
+		/* lock the device pointers */
+		mutex_lock(&(chip->usb->dev_mutex));
+
+		/* lock access to the state */
+		scsi_lock(host);
+
+		/* When we are called with no command pending, we're done */
+		if (chip->srb == NULL) {
+			scsi_unlock(host);
+			mutex_unlock(&chip->usb->dev_mutex);
+			pr_debug("-- exiting from control thread\n");
+			break;
+		}
+
+		/* has the command timed out *already* ? */
+		if (test_bit(FLIDX_TIMED_OUT, &chip->usb->dflags)) {
+			chip->srb->result = DID_ABORT << 16;
+			goto abort;
+		}
+
+		scsi_unlock(host);
+
+		/* reject the command if the direction indicator
+		 * is UNKNOWN
+		 */
+		if (chip->srb->sc_data_direction == DMA_BIDIRECTIONAL) {
+			pr_debug("UNKNOWN data direction\n");
+			chip->srb->result = DID_ERROR << 16;
+		}
+
+		/* reject if target != 0 or if LUN is higher than
+		 * the maximum known LUN
+		 */
+		else if (chip->srb->device->id) {
+			pr_debug("Bad target number (%d:%d)\n",
+				 chip->srb->device->id,
+				 chip->srb->device->lun);
+			chip->srb->result = DID_BAD_TARGET << 16;
+		}
+
+		else if (chip->srb->device->lun > chip->max_lun) {
+			pr_debug("Bad LUN (%d:%d)\n",
+				 chip->srb->device->id,
+				 chip->srb->device->lun);
+			chip->srb->result = DID_BAD_TARGET << 16;
+		}
+
+		/* we've got a command, let's do it! */
+		else {
+			RTS51X_DEBUG(rts51x_scsi_show_command(chip->srb));
+			rts51x_invoke_transport(chip->srb, chip);
+		}
+
+		/* lock access to the state */
+		scsi_lock(host);
+
+		/* indicate that the command is done */
+		if (chip->srb->result != DID_ABORT << 16)
+			chip->srb->scsi_done(chip->srb);
+		else
+abort :
+			pr_debug("scsi command aborted\n");
+
+		/* If an abort request was received we need to signal that
+		 * the abort has finished.  The proper test for this is
+		 * the TIMED_OUT flag, not srb->result == DID_ABORT, because
+		 * the timeout might have occurred after the command had
+		 * already completed with a different result code. */
+		if (test_bit(FLIDX_TIMED_OUT, &chip->usb->dflags)) {
+			complete(&(chip->usb->notify));
+
+			/* Allow USB transfers to resume */
+			clear_bit(FLIDX_ABORTING, &chip->usb->dflags);
+			clear_bit(FLIDX_TIMED_OUT, &chip->usb->dflags);
+		}
+
+		/* finished working on this command */
+		chip->srb = NULL;
+		scsi_unlock(host);
+
+		/* unlock the device pointers */
+		mutex_unlock(&chip->usb->dev_mutex);
+	}			/* for (;;) */
+
+	complete(&chip->usb->control_exit);
+
+	/* Wait until we are told to stop */
+/*	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_stop())
+			break;
+		schedule();
+	}
+	__set_current_state(TASK_RUNNING);*/
+	return 0;
+}
+
+static int rts51x_polling_thread(void *__chip)
+{
+	struct rts51x_chip *chip = (struct rts51x_chip *)__chip;
+
+	for (;;) {
+		wait_timeout(POLLING_INTERVAL);
+
+		/* if the device has disconnected, we are free to exit */
+		if (test_bit(FLIDX_DISCONNECTING, &chip->usb->dflags)) {
+			pr_debug("-- exiting from rts51x-polling\n");
+			break;
+		}
+
+		/* if the device has disconnected, we are free to exit */
+		/* if (kthread_should_stop()) {
+			printk(KERN_INFO "Stop polling thread!\n");
+			break;
+		} */
+
+#ifdef CONFIG_PM
+		if (RTS51X_CHK_STAT(chip, STAT_SS) ||
+		    RTS51X_CHK_STAT(chip, STAT_SS_PRE) ||
+		    RTS51X_CHK_STAT(chip, STAT_SUSPEND)) {
+			continue;
+		}
+
+		if (ss_en) {
+			if (RTS51X_CHK_STAT(chip, STAT_IDLE)) {
+				if (chip->ss_counter <
+				    (ss_delay * 1000 / POLLING_INTERVAL)) {
+					chip->ss_counter++;
+				} else {
+					/* Prepare SS state */
+					RTS51X_SET_STAT(chip, STAT_SS_PRE);
+					rts51x_try_to_enter_ss(chip);
+					continue;
+				}
+			} else {
+				chip->ss_counter = 0;
+			}
+		}
+#endif
+
+		rts51x_mspro_polling_format_status(chip);
+
+		/* lock the device pointers */
+		mutex_lock(&(chip->usb->dev_mutex));
+
+		rts51x_polling_func(chip);
+
+		/* unlock the device pointers */
+		mutex_unlock(&chip->usb->dev_mutex);
+	}			/* for (;;) */
+
+	complete(&chip->usb->polling_exit);
+
+	/* Wait until we are told to stop */
+	/* for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (kthread_should_stop())
+		break;
+		schedule();
+		}
+	__set_current_state(TASK_RUNNING); */
+	return 0;
+}
+
+/* Associate our private data with the USB device */
+static int associate_dev(struct rts51x_chip *chip, struct usb_interface *intf)
+{
+	struct rts51x_usb *rts51x = chip->usb;
+#ifdef SUPPORT_FILE_OP
+	int retval;
+#endif
+
+	/* Fill in the device-related fields */
+	rts51x->pusb_dev = interface_to_usbdev(intf);
+	rts51x->pusb_intf = intf;
+	rts51x->ifnum = intf->cur_altsetting->desc.bInterfaceNumber;
+	pr_debug("Vendor: 0x%04x, Product: 0x%04x, Revision: 0x%04x\n",
+		 le16_to_cpu(rts51x->pusb_dev->descriptor.idVendor),
+		 le16_to_cpu(rts51x->pusb_dev->descriptor.idProduct),
+		 le16_to_cpu(rts51x->pusb_dev->descriptor.bcdDevice));
+	pr_debug("Interface Subclass: 0x%02x, Protocol: 0x%02x\n",
+		 intf->cur_altsetting->desc.bInterfaceSubClass,
+		 intf->cur_altsetting->desc.bInterfaceProtocol);
+
+	/* Store our private data in the interface */
+	usb_set_intfdata(intf, chip);
+
+#ifdef SUPPORT_FILE_OP
+	/* we can register the device now, as it is ready */
+	retval = usb_register_dev(intf, &rts51x_class);
+	if (retval) {
+		/* something prevented us from registering this driver */
+		pr_debug("Not able to get a minor for this device.");
+		usb_set_intfdata(intf, NULL);
+		return -ENOMEM;
+	}
+#endif
+
+	/* Allocate the device-related DMA-mapped buffers */
+	rts51x->cr = usb_buffer_alloc(rts51x->pusb_dev, sizeof(*rts51x->cr),
+				      GFP_KERNEL, &rts51x->cr_dma);
+	if (!rts51x->cr) {
+		usb_set_intfdata(intf, NULL);
+		return -ENOMEM;
+	}
+
+	rts51x->iobuf = usb_buffer_alloc(rts51x->pusb_dev, RTS51X_IOBUF_SIZE,
+					 GFP_KERNEL, &rts51x->iobuf_dma);
+	if (!rts51x->iobuf) {
+		usb_set_intfdata(intf, NULL);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void rts51x_init_options(struct rts51x_chip *chip)
+{
+	struct rts51x_option *option = &(chip->option);
+
+	option->rts51x_mspro_formatter_enable = 1;
+
+	option->fpga_sd_sdr104_clk = CLK_100;
+	option->fpga_sd_sdr50_clk = CLK_100;
+	option->fpga_sd_ddr50_clk = CLK_100;
+	option->fpga_sd_hs_clk = CLK_100;
+	option->fpga_mmc_52m_clk = CLK_80;
+	option->fpga_ms_hg_clk = CLK_80;
+	option->fpga_ms_4bit_clk = CLK_80;
+
+	option->asic_sd_sdr104_clk = 98;
+	option->asic_sd_sdr50_clk = 98;
+	option->asic_sd_ddr50_clk = 98;
+	option->asic_sd_hs_clk = 97;
+	option->asic_mmc_52m_clk = 95;
+	option->asic_ms_hg_clk = 116;
+	option->asic_ms_4bit_clk = 77;
+
+	option->sd_ddr_tx_phase = 0;
+	option->mmc_ddr_tx_phase = 1;
+
+	option->sd_speed_prior = 0;
+	option->sd_ctl =
+	    SD_PUSH_POINT_AUTO | SD_SAMPLE_POINT_AUTO | SUPPORT_UHS50_MMC44;
+
+	option->ss_en = ss_en;
+	option->ss_delay = ss_delay;
+
+	option->auto_delink_en = auto_delink_en;
+
+	option->FT2_fast_mode = 0;
+	option->pwr_delay = 800;
+	option->rts51x_xd_rw_step = 0;
+	option->D3318_off_delay = 50;
+	option->delink_delay = 100;
+	option->rts5129_D3318_off_enable = 0;
+	option->sd20_pad_drive = 0;
+	option->reset_or_rw_fail_set_pad_drive = 1;
+	option->debounce_num = 2;
+	option->led_toggle_interval = 6;
+	option->rts51x_xd_rwn_step = 0;
+	option->sd_send_status_en = 0;
+	option->sdr50_tx_phase = 0x01;
+	option->sdr50_rx_phase = 0x05;
+	option->ddr50_tx_phase = 0x09;
+	option->ddr50_rx_phase = 0x06;
+	option->sdr50_phase_sel = 0;
+	option->sd30_pad_drive = 1;
+	option->ms_errreg_fix = 0;
+	option->reset_mmc_first = 0;
+	option->speed_mmc = 1;
+	option->led_always_on = 0;
+}
+
+/* Get the pipe settings */
+static int get_pipes(struct rts51x_chip *chip)
+{
+	struct rts51x_usb *rts51x = chip->usb;
+	struct usb_host_interface *altsetting =
+	    rts51x->pusb_intf->cur_altsetting;
+	int i;
+	struct usb_endpoint_descriptor *ep;
+	struct usb_endpoint_descriptor *ep_in = NULL;
+	struct usb_endpoint_descriptor *ep_out = NULL;
+	struct usb_endpoint_descriptor *ep_int = NULL;
+
+	/*
+	 * Find the first endpoint of each type we need.
+	 * We are expecting a minimum of 2 endpoints - in and out (bulk).
+	 * An optional interrupt-in is OK (necessary for CBI protocol).
+	 * We will ignore any others.
+	 */
+	for (i = 0; i < altsetting->desc.bNumEndpoints; i++) {
+		ep = &altsetting->endpoint[i].desc;
+
+		if (usb_endpoint_xfer_bulk(ep)) {
+			if (usb_endpoint_dir_in(ep)) {
+				if (!ep_in)
+					ep_in = ep;
+			} else {
+				if (!ep_out)
+					ep_out = ep;
+			}
+		}
+
+		else if (usb_endpoint_is_int_in(ep)) {
+			if (!ep_int)
+				ep_int = ep;
+		}
+	}
+
+	if (!ep_in || !ep_out) {
+		pr_debug("Endpoint sanity check failed! Rejecting dev.\n");
+		return -EIO;
+	}
+
+	/* Calculate and store the pipe values */
+	rts51x->send_ctrl_pipe = usb_sndctrlpipe(rts51x->pusb_dev, 0);
+	rts51x->recv_ctrl_pipe = usb_rcvctrlpipe(rts51x->pusb_dev, 0);
+	rts51x->send_bulk_pipe = usb_sndbulkpipe(rts51x->pusb_dev,
+						 usb_endpoint_num(ep_out));
+	rts51x->recv_bulk_pipe = usb_rcvbulkpipe(rts51x->pusb_dev,
+						 usb_endpoint_num(ep_in));
+	if (ep_int) {
+		rts51x->recv_intr_pipe = usb_rcvintpipe(rts51x->pusb_dev,
+							usb_endpoint_num
+							(ep_int));
+		rts51x->ep_bInterval = ep_int->bInterval;
+	}
+	return 0;
+}
+
+/* Initialize all the dynamic resources we need */
+static int rts51x_acquire_resources(struct rts51x_chip *chip)
+{
+	struct rts51x_usb *rts51x = chip->usb;
+	int retval;
+
+	rts51x->current_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!rts51x->current_urb)
+		return -ENOMEM;
+
+	rts51x->intr_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!rts51x->intr_urb)
+		return -ENOMEM;
+
+	chip->cmd_buf = rts51x->iobuf;
+	chip->rsp_buf = rts51x->iobuf;
+
+	rts51x_init_options(chip);
+
+	/* Init rts51xx device */
+	retval = rts51x_init_chip(chip);
+	if (retval != STATUS_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
+/* Release all our dynamic resources */
+static void rts51x_release_resources(struct rts51x_chip *chip)
+{
+	pr_debug("-- %s\n", __func__);
+
+	/* Tell the control thread to exit.  The SCSI host must
+	 * already have been removed and the DISCONNECTING flag set
+	 * so that we won't accept any more commands.
+	 */
+	pr_debug("-- sending exit command to thread\n");
+	complete(&chip->usb->cmnd_ready);
+	if (chip->usb->ctl_thread)
+		wait_for_completion(&chip->usb->control_exit);
+		/* kthread_stop(chip->usb->ctl_thread); */
+	if (chip->usb->polling_thread)
+		wait_for_completion(&chip->usb->polling_exit);
+
+	/* if (chip->usb->polling_thread)
+		kthread_stop(chip->usb->polling_thread); */
+
+	wait_timeout(200);
+
+	/* Release rts51xx device here */
+	rts51x_release_chip(chip);
+
+	usb_free_urb(chip->usb->current_urb);
+	usb_free_urb(chip->usb->intr_urb);
+}
+
+/* Dissociate from the USB device */
+static void dissociate_dev(struct rts51x_chip *chip)
+{
+	struct rts51x_usb *rts51x = chip->usb;
+
+	pr_debug("-- %s\n", __func__);
+
+	/* Free the device-related DMA-mapped buffers */
+	if (rts51x->cr)
+		usb_buffer_free(rts51x->pusb_dev, sizeof(*rts51x->cr),
+				rts51x->cr, rts51x->cr_dma);
+	if (rts51x->iobuf)
+		usb_buffer_free(rts51x->pusb_dev, RTS51X_IOBUF_SIZE,
+				rts51x->iobuf, rts51x->iobuf_dma);
+
+	/* Remove our private data from the interface */
+	usb_set_intfdata(rts51x->pusb_intf, NULL);
+
+#ifdef SUPPORT_FILE_OP
+	/* give back our minor */
+	usb_deregister_dev(rts51x->pusb_intf, &rts51x_class);
+#endif
+
+	kfree(rts51x);
+	chip->usb = NULL;
+}
+
+/* First stage of disconnect processing: stop SCSI scanning,
+ * remove the host, and stop accepting new commands
+ */
+static void quiesce_and_remove_host(struct rts51x_chip *chip)
+{
+	struct rts51x_usb *rts51x = chip->usb;
+	struct Scsi_Host *host = rts51x_to_host(chip);
+
+	/* If the device is really gone, cut short reset delays */
+	if (rts51x->pusb_dev->state == USB_STATE_NOTATTACHED)
+		set_bit(FLIDX_DISCONNECTING, &rts51x->dflags);
+
+	/* Removing the host will perform an orderly shutdown: caches
+	 * synchronized, disks spun down, etc.
+	 */
+	scsi_remove_host(host);
+
+	/* Prevent any new commands from being accepted and cut short
+	 * reset delays.
+	 */
+	scsi_lock(host);
+	set_bit(FLIDX_DISCONNECTING, &rts51x->dflags);
+	scsi_unlock(host);
+}
+
+/* Second stage of disconnect processing: deallocate all resources */
+static void release_everything(struct rts51x_chip *chip)
+{
+	rts51x_release_resources(chip);
+	dissociate_dev(chip);
+
+	/* Drop our reference to the host; the SCSI core will free it
+	 * (and "chip" along with it) when the refcount becomes 0. */
+	scsi_host_put(rts51x_to_host(chip));
+}
+
+static int rts51x_probe(struct usb_interface *intf,
+			const struct usb_device_id *id)
+{
+	struct Scsi_Host *host;
+	struct rts51x_chip *chip;
+	struct rts51x_usb *rts51x;
+	int result;
+	struct task_struct *th;
+
+	pr_debug("%s detected\n", RTS51X_NAME);
+
+	rts51x = kzalloc(sizeof(*rts51x), GFP_KERNEL);
+	if (!rts51x)
+		return -ENOMEM;
+
+	/*
+	 * Ask the SCSI layer to allocate a host structure, with extra
+	 * space at the end for our private us_data structure.
+	 */
+	host = scsi_host_alloc(&rts51x_host_template, sizeof(*chip));
+	if (!host) {
+		kfree(rts51x);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Allow 16-byte CDBs and thus > 2TB
+	 */
+	host->max_cmd_len = 16;
+	chip = host_to_rts51x(host);
+	memset(chip, 0, sizeof(struct rts51x_chip));
+
+	chip->vendor_id = id->idVendor;
+	chip->product_id = id->idProduct;
+
+	mutex_init(&(rts51x->dev_mutex));
+	init_completion(&rts51x->cmnd_ready);
+	init_completion(&rts51x->control_exit);
+	init_completion(&rts51x->polling_exit);
+	init_completion(&(rts51x->notify));
+
+	chip->usb = rts51x;
+
+	/* Associate the us_data structure with the USB device */
+	result = associate_dev(chip, intf);
+	if (result)
+		goto bad_device;
+
+	/* Find the endpoints and calculate pipe values */
+	result = get_pipes(chip);
+	if (result)
+		goto bad_device;
+
+	/* Acquire all the other resources and add the host */
+	result = rts51x_acquire_resources(chip);
+	if (result)
+		goto bad_device;
+
+	/* Start up our control thread */
+	th = kthread_run(rts51x_control_thread, chip, RTS51X_CTL_THREAD);
+	if (IS_ERR(th)) {
+		pr_warn("Unable to start control thread\n");
+		result = PTR_ERR(th);
+		goto bad_device;
+	}
+	rts51x->ctl_thread = th;
+
+	result = scsi_add_host(rts51x_to_host(chip), &rts51x->pusb_intf->dev);
+	if (result) {
+		pr_warn("Unable to add the scsi host\n");
+		goto bad_device;
+	}
+	scsi_scan_host(rts51x_to_host(chip));
+
+	/* Start up our polling thread */
+	th = kthread_run(rts51x_polling_thread, chip, RTS51X_POLLING_THREAD);
+	if (IS_ERR(th)) {
+		pr_warn("Unable to start polling thread\n");
+		result = PTR_ERR(th);
+		goto bad_device;
+	}
+	rts51x->polling_thread = th;
+
+#ifdef CONFIG_PM
+	if (ss_en) {
+		rts51x->pusb_intf->needs_remote_wakeup = needs_remote_wakeup;
+		SET_PM_USAGE_CNT(chip, 1);
+		pr_debug("pm_usage_cnt = %d\n", GET_PM_USAGE_CNT(chip));
+	}
+#endif
+
+	return 0;
+
+	/* We come here if there are any problems */
+bad_device:
+	pr_debug("rts51x_probe() failed\n");
+	release_everything(chip);
+	return result;
+}
+
+static void rts51x_disconnect(struct usb_interface *intf)
+{
+	struct rts51x_chip *chip = (struct rts51x_chip *)usb_get_intfdata(intf);
+
+	pr_debug("rts51x_disconnect() called\n");
+	quiesce_and_remove_host(chip);
+	release_everything(chip);
+}
+
+/***********************************************************************
+ * Initialization and registration
+ ***********************************************************************/
+
+static struct usb_device_id rts5139_usb_ids[] = {
+	{USB_DEVICE(0x0BDA, 0x0139)},
+	{USB_DEVICE(0x0BDA, 0x0129)},
+	{}			/* Terminating entry */
+};
+EXPORT_SYMBOL_GPL(rts5139_usb_ids);
+
+MODULE_DEVICE_TABLE(usb, rts5139_usb_ids);
+
+struct usb_driver rts51x_driver = {
+	.name = RTS51X_NAME,
+	.probe = rts51x_probe,
+	.disconnect = rts51x_disconnect,
+	.suspend = rts51x_suspend,
+	.resume = rts51x_resume,
+	.reset_resume = rts51x_reset_resume,
+	.pre_reset = rts51x_pre_reset,
+	.post_reset = rts51x_post_reset,
+	.id_table = rts5139_usb_ids,
+	.soft_unbind = 1,
+};
+
+module_usb_driver(rts51x_driver);
diff --git a/drivers/staging/rts5139/rts51x.h b/drivers/staging/rts5139/rts51x.h
new file mode 100644
index 000000000000..ecc0109a5b1a
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x.h
@@ -0,0 +1,194 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_H
+#define __RTS51X_H
+
+#include <linux/usb.h>
+#include <linux/usb_usual.h>
+#include <linux/blkdev.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <linux/cdrom.h>
+#include <linux/kernel.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_devinfo.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_host.h>
+
+#define DRIVER_VERSION		"v1.04"
+
+#define RTS51X_DESC		"Realtek RTS5139/29 USB card reader driver"
+#define RTS51X_NAME		"rts5139"
+#define RTS51X_CTL_THREAD	"rts5139-control"
+#define RTS51X_POLLING_THREAD	"rts5139-polling"
+
+#define POLLING_IN_THREAD
+#define SUPPORT_FILE_OP
+
+#define wait_timeout_x(task_state, msecs)	\
+do {						\
+	set_current_state((task_state));	\
+	schedule_timeout((msecs) * HZ / 1000);	\
+} while (0)
+
+#define wait_timeout(msecs)	wait_timeout_x(TASK_INTERRUPTIBLE, (msecs))
+
+#define SCSI_LUN(srb)		((srb)->device->lun)
+
+/* Size of the DMA-mapped I/O buffer */
+#define RTS51X_IOBUF_SIZE	1024
+
+/* Dynamic bitflag definitions (dflags): used in set_bit() etc. */
+#define FLIDX_URB_ACTIVE	0	/* current_urb is in use    */
+#define FLIDX_SG_ACTIVE		1	/* current_sg is in use     */
+#define FLIDX_ABORTING		2	/* abort is in progress     */
+#define FLIDX_DISCONNECTING	3	/* disconnect in progress   */
+#define FLIDX_RESETTING		4	/* device reset in progress */
+#define FLIDX_TIMED_OUT		5	/* SCSI midlayer timed out  */
+
+struct rts51x_chip;
+
+struct rts51x_usb {
+	/* The device we're working with
+	 * It's important to note:
+	 *    (o) you must hold dev_mutex to change pusb_dev
+	 */
+	struct mutex dev_mutex;	/* protect pusb_dev */
+	struct usb_device *pusb_dev;	/* this usb_device */
+	struct usb_interface *pusb_intf;	/* this interface */
+
+	unsigned long dflags;	/* dynamic atomic bitflags */
+
+	unsigned int send_bulk_pipe;	/* cached pipe values */
+	unsigned int recv_bulk_pipe;
+	unsigned int send_ctrl_pipe;
+	unsigned int recv_ctrl_pipe;
+	unsigned int recv_intr_pipe;
+
+	u8 ifnum;		/* interface number   */
+	u8 ep_bInterval;	/* interrupt interval */
+
+	/* control and bulk communications data */
+	struct urb *current_urb;	/* USB requests         */
+	struct urb *intr_urb;	/* Interrupt USB request */
+	struct usb_ctrlrequest *cr;	/* control requests     */
+	struct usb_sg_request current_sg;	/* scatter-gather req.  */
+	unsigned char *iobuf;	/* I/O buffer           */
+	dma_addr_t cr_dma;	/* buffer DMA addresses */
+	dma_addr_t iobuf_dma;
+	struct task_struct *ctl_thread;	/* the control thread   */
+	struct task_struct *polling_thread;	/* the polling thread   */
+
+	/* mutual exclusion and synchronization structures */
+	struct completion cmnd_ready;	/* to sleep thread on      */
+	struct completion control_exit;	/* control thread exit     */
+	struct completion polling_exit;	/* polling thread exit     */
+	struct completion notify;	/* thread begin/end        */
+};
+
+extern struct usb_driver rts51x_driver;
+
+static inline void get_current_time(u8 *timeval_buf, int buf_len)
+{
+	struct timeval tv;
+
+	if (!timeval_buf || (buf_len < 8))
+		return;
+
+	do_gettimeofday(&tv);
+
+	timeval_buf[0] = (u8) (tv.tv_sec >> 24);
+	timeval_buf[1] = (u8) (tv.tv_sec >> 16);
+	timeval_buf[2] = (u8) (tv.tv_sec >> 8);
+	timeval_buf[3] = (u8) (tv.tv_sec);
+	timeval_buf[4] = (u8) (tv.tv_usec >> 24);
+	timeval_buf[5] = (u8) (tv.tv_usec >> 16);
+	timeval_buf[6] = (u8) (tv.tv_usec >> 8);
+	timeval_buf[7] = (u8) (tv.tv_usec);
+}
+
+#define SND_CTRL_PIPE(chip)	((chip)->usb->send_ctrl_pipe)
+#define RCV_CTRL_PIPE(chip)	((chip)->usb->recv_ctrl_pipe)
+#define SND_BULK_PIPE(chip)	((chip)->usb->send_bulk_pipe)
+#define RCV_BULK_PIPE(chip)	((chip)->usb->recv_bulk_pipe)
+#define RCV_INTR_PIPE(chip)	((chip)->usb->recv_intr_pipe)
+
+/* The scsi_lock() and scsi_unlock() macros protect the sm_state and the
+ * single queue element srb for write access */
+#define scsi_unlock(host)	spin_unlock_irq(host->host_lock)
+#define scsi_lock(host)		spin_lock_irq(host->host_lock)
+
+#define GET_PM_USAGE_CNT(chip)	\
+	atomic_read(&((chip)->usb->pusb_intf->pm_usage_cnt))
+#define SET_PM_USAGE_CNT(chip, cnt)	\
+	atomic_set(&((chip)->usb->pusb_intf->pm_usage_cnt), (cnt))
+
+/* Compatible macros while we switch over */
+static inline void *usb_buffer_alloc(struct usb_device *dev, size_t size,
+				     gfp_t mem_flags, dma_addr_t *dma)
+{
+	return usb_alloc_coherent(dev, size, mem_flags, dma);
+}
+
+static inline void usb_buffer_free(struct usb_device *dev, size_t size,
+				   void *addr, dma_addr_t dma)
+{
+	return usb_free_coherent(dev, size, addr, dma);
+}
+
+/* Convert between us_data and the corresponding Scsi_Host */
+static inline struct Scsi_Host *rts51x_to_host(struct rts51x_chip *chip)
+{
+	return container_of((void *)chip, struct Scsi_Host, hostdata);
+}
+
+static inline struct rts51x_chip *host_to_rts51x(struct Scsi_Host *host)
+{
+	return (struct rts51x_chip *)(host->hostdata);
+}
+
+/* struct scsi_cmnd transfer buffer access utilities */
+enum xfer_buf_dir { TO_XFER_BUF, FROM_XFER_BUF };
+
+/* General routines provided by the usb-storage standard core */
+#ifdef CONFIG_PM
+void rts51x_try_to_exit_ss(struct rts51x_chip *chip);
+int rts51x_suspend(struct usb_interface *iface, pm_message_t message);
+int rts51x_resume(struct usb_interface *iface);
+int rts51x_reset_resume(struct usb_interface *iface);
+#else
+#define rts51x_suspend		NULL
+#define rts51x_resume		NULL
+#define rts51x_reset_resume	NULL
+#endif
+
+extern struct scsi_host_template rts51x_host_template;
+
+#endif /* __RTS51X_H */
diff --git a/drivers/staging/rts5139/rts51x_card.c b/drivers/staging/rts5139/rts51x_card.c
new file mode 100644
index 000000000000..03456d9873e5
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_card.c
@@ -0,0 +1,940 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_device.h>
+
+#include "debug.h"
+#include "rts51x.h"
+#include "rts51x_chip.h"
+#include "rts51x_card.h"
+#include "rts51x_transport.h"
+#include "xd.h"
+#include "sd.h"
+#include "ms.h"
+
+void rts51x_do_remaining_work(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	struct xd_info *xd_card = &(chip->xd_card);
+	struct ms_info *ms_card = &(chip->ms_card);
+
+	if (chip->card_ready & SD_CARD) {
+		if (sd_card->seq_mode) {
+			RTS51X_SET_STAT(chip, STAT_RUN);
+			sd_card->counter++;
+		} else {
+			sd_card->counter = 0;
+		}
+	}
+
+	if (chip->card_ready & XD_CARD) {
+		if (xd_card->delay_write.delay_write_flag) {
+			RTS51X_SET_STAT(chip, STAT_RUN);
+			xd_card->counter++;
+		} else {
+			xd_card->counter = 0;
+		}
+	}
+
+	if (chip->card_ready & MS_CARD) {
+		if (CHK_MSPRO(ms_card)) {
+			if (ms_card->seq_mode) {
+				RTS51X_SET_STAT(chip, STAT_RUN);
+				ms_card->counter++;
+			} else {
+				ms_card->counter = 0;
+			}
+		} else {
+			if (ms_card->delay_write.delay_write_flag) {
+				RTS51X_SET_STAT(chip, STAT_RUN);
+				ms_card->counter++;
+			} else {
+				ms_card->counter = 0;
+			}
+		}
+	}
+
+	if (sd_card->counter > POLLING_WAIT_CNT)
+		rts51x_sd_cleanup_work(chip);
+
+	if (xd_card->counter > POLLING_WAIT_CNT)
+		rts51x_xd_cleanup_work(chip);
+
+	if (ms_card->counter > POLLING_WAIT_CNT)
+		rts51x_ms_cleanup_work(chip);
+}
+
+static void do_rts51x_reset_xd_card(struct rts51x_chip *chip)
+{
+	int retval;
+
+	if (chip->card2lun[XD_CARD] >= MAX_ALLOWED_LUN_CNT)
+		return;
+
+	retval = rts51x_reset_xd_card(chip);
+	if (retval == STATUS_SUCCESS) {
+		chip->card_ready |= XD_CARD;
+		chip->card_fail &= ~XD_CARD;
+		chip->rw_card[chip->card2lun[XD_CARD]] = rts51x_xd_rw;
+	} else {
+		chip->card_ready &= ~XD_CARD;
+		chip->card_fail |= XD_CARD;
+		chip->capacity[chip->card2lun[XD_CARD]] = 0;
+		chip->rw_card[chip->card2lun[XD_CARD]] = NULL;
+
+		rts51x_init_cmd(chip);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, XD_OUTPUT_EN, 0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK,
+			       POWER_OFF);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_EN, XD_CLK_EN, 0);
+		rts51x_send_cmd(chip, MODE_C, 100);
+	}
+}
+
+void rts51x_do_rts51x_reset_sd_card(struct rts51x_chip *chip)
+{
+	int retval;
+
+	if (chip->card2lun[SD_CARD] >= MAX_ALLOWED_LUN_CNT)
+		return;
+
+	retval = rts51x_reset_sd_card(chip);
+	if (retval == STATUS_SUCCESS) {
+		chip->card_ready |= SD_CARD;
+		chip->card_fail &= ~SD_CARD;
+		chip->rw_card[chip->card2lun[SD_CARD]] = rts51x_sd_rw;
+	} else {
+		chip->card_ready &= ~SD_CARD;
+		chip->card_fail |= SD_CARD;
+		chip->capacity[chip->card2lun[SD_CARD]] = 0;
+		chip->rw_card[chip->card2lun[SD_CARD]] = NULL;
+
+		rts51x_init_cmd(chip);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, SD_OUTPUT_EN, 0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK,
+			       POWER_OFF);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_EN, SD_CLK_EN, 0);
+		rts51x_send_cmd(chip, MODE_C, 100);
+	}
+}
+
+static void do_rts51x_reset_ms_card(struct rts51x_chip *chip)
+{
+	int retval;
+
+	if (chip->card2lun[MS_CARD] >= MAX_ALLOWED_LUN_CNT)
+		return;
+
+	retval = rts51x_reset_ms_card(chip);
+	if (retval == STATUS_SUCCESS) {
+		chip->card_ready |= MS_CARD;
+		chip->card_fail &= ~MS_CARD;
+		chip->rw_card[chip->card2lun[MS_CARD]] = rts51x_ms_rw;
+	} else {
+		chip->card_ready &= ~MS_CARD;
+		chip->card_fail |= MS_CARD;
+		chip->capacity[chip->card2lun[MS_CARD]] = 0;
+		chip->rw_card[chip->card2lun[MS_CARD]] = NULL;
+
+		rts51x_init_cmd(chip);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, MS_OUTPUT_EN, 0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK,
+			       POWER_OFF);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_EN, MS_CLK_EN, 0);
+		rts51x_send_cmd(chip, MODE_C, 100);
+	}
+}
+
+static void card_cd_debounce(struct rts51x_chip *chip, u8 *need_reset,
+		      u8 *need_release)
+{
+	int retval;
+	u8 release_map = 0, reset_map = 0;
+	u8 value;
+
+	retval = rts51x_get_card_status(chip, &(chip->card_status));
+#ifdef SUPPORT_OCP
+	chip->ocp_stat = (chip->card_status >> 4) & 0x03;
+#endif
+
+	if (retval != STATUS_SUCCESS)
+		goto Exit_Debounce;
+
+	if (chip->card_exist) {
+		retval = rts51x_read_register(chip, CARD_INT_PEND, &value);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_ep0_write_register(chip, MC_FIFO_CTL, FIFO_FLUSH,
+						  FIFO_FLUSH);
+			rts51x_ep0_write_register(chip, SFSM_ED, 0xf8, 0xf8);
+			value = 0;
+		}
+
+		if (chip->card_exist & XD_CARD) {
+			if (!(chip->card_status & XD_CD))
+				release_map |= XD_CARD;
+		} else if (chip->card_exist & SD_CARD) {
+			/* if (!(chip->card_status & SD_CD)) { */
+			if (!(chip->card_status & SD_CD) || (value & SD_INT))
+				release_map |= SD_CARD;
+		} else if (chip->card_exist & MS_CARD) {
+			/* if (!(chip->card_status & MS_CD)) { */
+			if (!(chip->card_status & MS_CD) || (value & MS_INT))
+				release_map |= MS_CARD;
+		}
+	} else {
+		if (chip->card_status & XD_CD)
+			reset_map |= XD_CARD;
+		else if (chip->card_status & SD_CD)
+			reset_map |= SD_CARD;
+		else if (chip->card_status & MS_CD)
+			reset_map |= MS_CARD;
+	}
+
+	if (CHECK_PKG(chip, QFN24) && reset_map) {
+		if (chip->card_exist & XD_CARD) {
+			reset_map = 0;
+			goto Exit_Debounce;
+		}
+	}
+
+	if (reset_map) {
+		int xd_cnt = 0, sd_cnt = 0, ms_cnt = 0;
+		int i;
+
+		for (i = 0; i < (chip->option.debounce_num); i++) {
+			retval =
+			    rts51x_get_card_status(chip, &(chip->card_status));
+			if (retval != STATUS_SUCCESS) {
+				reset_map = release_map = 0;
+				goto Exit_Debounce;
+			}
+			if (chip->card_status & XD_CD)
+				xd_cnt++;
+			else
+				xd_cnt = 0;
+			if (chip->card_status & SD_CD)
+				sd_cnt++;
+			else
+				sd_cnt = 0;
+			if (chip->card_status & MS_CD)
+				ms_cnt++;
+			else
+				ms_cnt = 0;
+			wait_timeout(30);
+		}
+
+		reset_map = 0;
+		if (!(chip->card_exist & XD_CARD)
+		    && (xd_cnt > (chip->option.debounce_num - 1))) {
+			reset_map |= XD_CARD;
+		}
+		if (!(chip->card_exist & SD_CARD)
+		    && (sd_cnt > (chip->option.debounce_num - 1))) {
+			reset_map |= SD_CARD;
+		}
+		if (!(chip->card_exist & MS_CARD)
+		    && (ms_cnt > (chip->option.debounce_num - 1))) {
+			reset_map |= MS_CARD;
+		}
+	}
+	rts51x_write_register(chip, CARD_INT_PEND, XD_INT | MS_INT | SD_INT,
+			      XD_INT | MS_INT | SD_INT);
+
+Exit_Debounce:
+	if (need_reset)
+		*need_reset = reset_map;
+	if (need_release)
+		*need_release = release_map;
+}
+
+void rts51x_init_cards(struct rts51x_chip *chip)
+{
+	u8 need_reset = 0, need_release = 0;
+
+	card_cd_debounce(chip, &need_reset, &need_release);
+
+	if (need_release) {
+		RTS51X_DEBUGP("need_release = 0x%x\n", need_release);
+
+		rts51x_prepare_run(chip);
+		RTS51X_SET_STAT(chip, STAT_RUN);
+
+#ifdef SUPPORT_OCP
+		if (chip->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
+			rts51x_write_register(chip, OCPCTL, MS_OCP_CLEAR,
+					      MS_OCP_CLEAR);
+			chip->ocp_stat = 0;
+			RTS51X_DEBUGP("Clear OCP status.\n");
+		}
+#endif
+
+		if (need_release & XD_CARD) {
+			chip->card_exist &= ~XD_CARD;
+			chip->card_ejected = 0;
+			if (chip->card_ready & XD_CARD) {
+				rts51x_release_xd_card(chip);
+				chip->rw_card[chip->card2lun[XD_CARD]] = NULL;
+				clear_bit(chip->card2lun[XD_CARD],
+					  &(chip->lun_mc));
+			}
+		}
+
+		if (need_release & SD_CARD) {
+			chip->card_exist &= ~SD_CARD;
+			chip->card_ejected = 0;
+			if (chip->card_ready & SD_CARD) {
+				rts51x_release_sd_card(chip);
+				chip->rw_card[chip->card2lun[SD_CARD]] = NULL;
+				clear_bit(chip->card2lun[SD_CARD],
+					  &(chip->lun_mc));
+			}
+		}
+
+		if (need_release & MS_CARD) {
+			chip->card_exist &= ~MS_CARD;
+			chip->card_ejected = 0;
+			if (chip->card_ready & MS_CARD) {
+				rts51x_release_ms_card(chip);
+				chip->rw_card[chip->card2lun[MS_CARD]] = NULL;
+				clear_bit(chip->card2lun[MS_CARD],
+					  &(chip->lun_mc));
+			}
+		}
+	}
+
+	if (need_reset && !chip->card_ready) {
+		RTS51X_DEBUGP("need_reset = 0x%x\n", need_reset);
+
+		rts51x_prepare_run(chip);
+		RTS51X_SET_STAT(chip, STAT_RUN);
+
+		if (need_reset & XD_CARD) {
+			chip->card_exist |= XD_CARD;
+			do_rts51x_reset_xd_card(chip);
+		} else if (need_reset & SD_CARD) {
+			chip->card_exist |= SD_CARD;
+			rts51x_do_rts51x_reset_sd_card(chip);
+		} else if (need_reset & MS_CARD) {
+			chip->card_exist |= MS_CARD;
+			do_rts51x_reset_ms_card(chip);
+		}
+	}
+}
+
+void rts51x_release_cards(struct rts51x_chip *chip)
+{
+	if (chip->card_ready & SD_CARD) {
+		rts51x_sd_cleanup_work(chip);
+		rts51x_release_sd_card(chip);
+		chip->card_ready &= ~SD_CARD;
+	}
+
+	if (chip->card_ready & XD_CARD) {
+		rts51x_xd_cleanup_work(chip);
+		rts51x_release_xd_card(chip);
+		chip->card_ready &= ~XD_CARD;
+	}
+
+	if (chip->card_ready & MS_CARD) {
+		rts51x_ms_cleanup_work(chip);
+		rts51x_release_ms_card(chip);
+		chip->card_ready &= ~MS_CARD;
+	}
+}
+
+static inline u8 double_depth(u8 depth)
+{
+	return (depth > 1) ? (depth - 1) : depth;
+}
+
+int rts51x_switch_ssc_clock(struct rts51x_chip *chip, int clk)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	struct ms_info *ms_card = &(chip->ms_card);
+	int retval;
+	u8 N = (u8) (clk - 2), min_N, max_N;
+	u8 mcu_cnt, div, max_div, ssc_depth;
+	int sd_vpclk_phase_reset = 0;
+
+	if (chip->cur_clk == clk)
+		return STATUS_SUCCESS;
+
+	min_N = 60;
+	max_N = 120;
+	max_div = CLK_DIV_4;
+
+	RTS51X_DEBUGP("Switch SSC clock to %dMHz\n", clk);
+
+	if ((clk <= 2) || (N > max_N))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	mcu_cnt = (u8) (60 / clk + 3);
+	if (mcu_cnt > 15)
+		mcu_cnt = 15;
+	/* To make sure that the SSC clock div_n is
+	 * equal or greater than min_N */
+	div = CLK_DIV_1;
+	while ((N < min_N) && (div < max_div)) {
+		N = (N + 2) * 2 - 2;
+		div++;
+	}
+	RTS51X_DEBUGP("N = %d, div = %d\n", N, div);
+
+	if (chip->option.ssc_en) {
+		if (chip->cur_card == SD_CARD) {
+			if (CHK_SD_SDR104(sd_card)) {
+				ssc_depth = chip->option.ssc_depth_sd_sdr104;
+			} else if (CHK_SD_SDR50(sd_card)) {
+				ssc_depth = chip->option.ssc_depth_sd_sdr50;
+			} else if (CHK_SD_DDR50(sd_card)) {
+				ssc_depth =
+				    double_depth(chip->option.
+						 ssc_depth_sd_ddr50);
+			} else if (CHK_SD_HS(sd_card)) {
+				ssc_depth =
+				    double_depth(chip->option.ssc_depth_sd_hs);
+			} else if (CHK_MMC_52M(sd_card)
+				   || CHK_MMC_DDR52(sd_card)) {
+				ssc_depth =
+				    double_depth(chip->option.
+						 ssc_depth_mmc_52m);
+			} else {
+				ssc_depth =
+				    double_depth(chip->option.
+						 ssc_depth_low_speed);
+			}
+		} else if (chip->cur_card == MS_CARD) {
+			if (CHK_MSPRO(ms_card)) {
+				if (CHK_HG8BIT(ms_card)) {
+					ssc_depth =
+					    double_depth(chip->option.
+							 ssc_depth_ms_hg);
+				} else {
+					ssc_depth =
+					    double_depth(chip->option.
+							 ssc_depth_ms_4bit);
+				}
+			} else {
+				if (CHK_MS4BIT(ms_card)) {
+					ssc_depth =
+					    double_depth(chip->option.
+							 ssc_depth_ms_4bit);
+				} else {
+					ssc_depth =
+					    double_depth(chip->option.
+							 ssc_depth_low_speed);
+				}
+			}
+		} else {
+			ssc_depth =
+			    double_depth(chip->option.ssc_depth_low_speed);
+		}
+
+		if (ssc_depth) {
+			if (div == CLK_DIV_2) {
+				/* If clock divided by 2, ssc depth must
+				 * be multiplied by 2 */
+				if (ssc_depth > 1)
+					ssc_depth -= 1;
+				else
+					ssc_depth = SSC_DEPTH_2M;
+			} else if (div == CLK_DIV_4) {
+				/* If clock divided by 4, ssc depth must
+				 * be multiplied by 4 */
+				if (ssc_depth > 2)
+					ssc_depth -= 2;
+				else
+					ssc_depth = SSC_DEPTH_2M;
+			}
+		}
+	} else {
+		/* Disable SSC */
+		ssc_depth = 0;
+	}
+
+	RTS51X_DEBUGP("ssc_depth = %d\n", ssc_depth);
+
+	rts51x_init_cmd(chip);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CLK_DIV, CLK_CHANGE, CLK_CHANGE);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CLK_DIV, 0x3F,
+		       (div << 4) | mcu_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SSC_CTL1, SSC_RSTB, 0);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SSC_CTL2, SSC_DEPTH_MASK,
+		       ssc_depth);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SSC_DIV_N_0, 0xFF, N);
+	if (sd_vpclk_phase_reset) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_VPCLK0_CTL,
+			       PHASE_NOT_RESET, 0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_VPCLK0_CTL,
+			       PHASE_NOT_RESET, PHASE_NOT_RESET);
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_C, 2000);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	if (chip->option.ssc_en && ssc_depth)
+		rts51x_write_register(chip, SSC_CTL1, 0xff, 0xD0);
+	else
+		rts51x_write_register(chip, SSC_CTL1, 0xff, 0x50);
+	udelay(100);
+	RTS51X_WRITE_REG(chip, CLK_DIV, CLK_CHANGE, 0);
+
+	chip->cur_clk = clk;
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_switch_normal_clock(struct rts51x_chip *chip, int clk)
+{
+	int retval;
+	u8 sel, div, mcu_cnt;
+	int sd_vpclk_phase_reset = 0;
+
+	if (chip->cur_clk == clk)
+		return STATUS_SUCCESS;
+
+	if (chip->cur_card == SD_CARD) {
+		struct sd_info *sd_card = &(chip->sd_card);
+		if (CHK_SD30_SPEED(sd_card) || CHK_MMC_DDR52(sd_card))
+			sd_vpclk_phase_reset = 1;
+	}
+
+	switch (clk) {
+	case CLK_20:
+		RTS51X_DEBUGP("Switch clock to 20MHz\n");
+		sel = SSC_80;
+		div = CLK_DIV_4;
+		mcu_cnt = 5;
+		break;
+
+	case CLK_30:
+		RTS51X_DEBUGP("Switch clock to 30MHz\n");
+		sel = SSC_60;
+		div = CLK_DIV_2;
+		mcu_cnt = 4;
+		break;
+
+	case CLK_40:
+		RTS51X_DEBUGP("Switch clock to 40MHz\n");
+		sel = SSC_80;
+		div = CLK_DIV_2;
+		mcu_cnt = 3;
+		break;
+
+	case CLK_50:
+		RTS51X_DEBUGP("Switch clock to 50MHz\n");
+		sel = SSC_100;
+		div = CLK_DIV_2;
+		mcu_cnt = 3;
+		break;
+
+	case CLK_60:
+		RTS51X_DEBUGP("Switch clock to 60MHz\n");
+		sel = SSC_60;
+		div = CLK_DIV_1;
+		mcu_cnt = 3;
+		break;
+
+	case CLK_80:
+		RTS51X_DEBUGP("Switch clock to 80MHz\n");
+		sel = SSC_80;
+		div = CLK_DIV_1;
+		mcu_cnt = 2;
+		break;
+
+	case CLK_100:
+		RTS51X_DEBUGP("Switch clock to 100MHz\n");
+		sel = SSC_100;
+		div = CLK_DIV_1;
+		mcu_cnt = 2;
+		break;
+
+	/* case CLK_120:
+		RTS51X_DEBUGP("Switch clock to 120MHz\n");
+		sel = SSC_120;
+		div = CLK_DIV_1;
+		mcu_cnt = 2;
+		break;
+
+	case CLK_150:
+		RTS51X_DEBUGP("Switch clock to 150MHz\n");
+		sel = SSC_150;
+		div = CLK_DIV_1;
+		mcu_cnt = 2;
+		break; */
+
+	default:
+		RTS51X_DEBUGP("Try to switch to an illegal clock (%d)\n",
+			       clk);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (!sd_vpclk_phase_reset) {
+		rts51x_init_cmd(chip);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CLK_DIV, CLK_CHANGE,
+			       CLK_CHANGE);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CLK_DIV, 0x3F,
+			       (div << 4) | mcu_cnt);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SSC_CLK_FPGA_SEL, 0xFF,
+			       sel);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CLK_DIV, CLK_CHANGE, 0);
+
+		retval = rts51x_send_cmd(chip, MODE_C, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	} else {
+		rts51x_init_cmd(chip);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CLK_DIV, CLK_CHANGE,
+			       CLK_CHANGE);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_VPCLK0_CTL,
+			       PHASE_NOT_RESET, 0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_VPCLK1_CTL,
+			       PHASE_NOT_RESET, 0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CLK_DIV, 0x3F,
+			       (div << 4) | mcu_cnt);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SSC_CLK_FPGA_SEL, 0xFF,
+			       sel);
+
+		retval = rts51x_send_cmd(chip, MODE_C, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		udelay(200);
+
+		rts51x_init_cmd(chip);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_VPCLK0_CTL,
+			       PHASE_NOT_RESET, PHASE_NOT_RESET);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_VPCLK1_CTL,
+			       PHASE_NOT_RESET, PHASE_NOT_RESET);
+
+		retval = rts51x_send_cmd(chip, MODE_C, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		udelay(200);
+
+		RTS51X_WRITE_REG(chip, CLK_DIV, CLK_CHANGE, 0);
+	}
+
+	chip->cur_clk = clk;
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_card_rw(struct scsi_cmnd *srb, struct rts51x_chip *chip,
+		u32 sec_addr, u16 sec_cnt)
+{
+	int retval;
+	unsigned int lun = SCSI_LUN(srb);
+	int i;
+
+	if (chip->rw_card[lun] == NULL)
+		return STATUS_FAIL;
+
+	RTS51X_DEBUGP("%s card, sector addr: 0x%x, sector cnt: %d\n",
+		       (srb->sc_data_direction ==
+			DMA_TO_DEVICE) ? "Write" : "Read", sec_addr, sec_cnt);
+
+	chip->rw_need_retry = 0;
+	for (i = 0; i < 3; i++) {
+		retval = chip->rw_card[lun] (srb, chip, sec_addr, sec_cnt);
+		if (retval != STATUS_SUCCESS) {
+			CATCH_TRIGGER(chip);
+			if (chip->option.reset_or_rw_fail_set_pad_drive) {
+				rts51x_write_register(chip, CARD_DRIVE_SEL,
+						      SD20_DRIVE_MASK,
+						      DRIVE_8mA);
+			}
+		}
+
+		if (!chip->rw_need_retry)
+			break;
+
+		RTS51X_DEBUGP("Retry RW, (i = %d\n)", i);
+	}
+
+	return retval;
+}
+
+u8 rts51x_get_lun_card(struct rts51x_chip *chip, unsigned int lun)
+{
+	if ((chip->card_ready & chip->lun2card[lun]) == XD_CARD)
+		return (u8) XD_CARD;
+	else if ((chip->card_ready & chip->lun2card[lun]) == SD_CARD)
+		return (u8) SD_CARD;
+	else if ((chip->card_ready & chip->lun2card[lun]) == MS_CARD)
+		return (u8) MS_CARD;
+
+	return 0;
+}
+
+static int card_share_mode(struct rts51x_chip *chip, int card)
+{
+	u8 value;
+
+	if (card == SD_CARD)
+		value = CARD_SHARE_SD;
+	else if (card == MS_CARD)
+		value = CARD_SHARE_MS;
+	else if (card == XD_CARD)
+		value = CARD_SHARE_XD;
+	else
+		TRACE_RET(chip, STATUS_FAIL);
+
+	RTS51X_WRITE_REG(chip, CARD_SHARE_MODE, CARD_SHARE_MASK, value);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_select_card(struct rts51x_chip *chip, int card)
+{
+	int retval;
+
+	if (chip->cur_card != card) {
+		u8 mod;
+
+		if (card == SD_CARD)
+			mod = SD_MOD_SEL;
+		else if (card == MS_CARD)
+			mod = MS_MOD_SEL;
+		else if (card == XD_CARD)
+			mod = XD_MOD_SEL;
+		else
+			TRACE_RET(chip, STATUS_FAIL);
+		RTS51X_WRITE_REG(chip, CARD_SELECT, 0x07, mod);
+		chip->cur_card = card;
+
+		retval = card_share_mode(chip, card);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+void rts51x_eject_card(struct rts51x_chip *chip, unsigned int lun)
+{
+	RTS51X_DEBUGP("eject card\n");
+	RTS51X_SET_STAT(chip, STAT_RUN);
+	rts51x_do_remaining_work(chip);
+
+	if ((chip->card_ready & chip->lun2card[lun]) == SD_CARD) {
+		rts51x_release_sd_card(chip);
+		chip->card_ejected |= SD_CARD;
+		chip->card_ready &= ~SD_CARD;
+		chip->capacity[lun] = 0;
+	} else if ((chip->card_ready & chip->lun2card[lun]) == XD_CARD) {
+		rts51x_release_xd_card(chip);
+		chip->card_ejected |= XD_CARD;
+		chip->card_ready &= ~XD_CARD;
+		chip->capacity[lun] = 0;
+	} else if ((chip->card_ready & chip->lun2card[lun]) == MS_CARD) {
+		rts51x_release_ms_card(chip);
+		chip->card_ejected |= MS_CARD;
+		chip->card_ready &= ~MS_CARD;
+		chip->capacity[lun] = 0;
+	}
+	rts51x_write_register(chip, CARD_INT_PEND, XD_INT | MS_INT | SD_INT,
+			      XD_INT | MS_INT | SD_INT);
+}
+
+void rts51x_trans_dma_enable(enum dma_data_direction dir,
+		struct rts51x_chip *chip, u32 byte_cnt, u8 pack_size)
+{
+	if (pack_size > DMA_1024)
+		pack_size = DMA_512;
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       RING_BUFFER);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MC_DMA_TC3, 0xFF,
+		       (u8) (byte_cnt >> 24));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MC_DMA_TC2, 0xFF,
+		       (u8) (byte_cnt >> 16));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MC_DMA_TC1, 0xFF,
+		       (u8) (byte_cnt >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, MC_DMA_TC0, 0xFF, (u8) byte_cnt);
+
+	if (dir == DMA_FROM_DEVICE) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MC_DMA_CTL,
+			       0x03 | DMA_PACK_SIZE_MASK,
+			       DMA_DIR_FROM_CARD | DMA_EN | pack_size);
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, MC_DMA_CTL,
+			       0x03 | DMA_PACK_SIZE_MASK,
+			       DMA_DIR_TO_CARD | DMA_EN | pack_size);
+	}
+}
+
+int rts51x_enable_card_clock(struct rts51x_chip *chip, u8 card)
+{
+	u8 clk_en = 0;
+
+	if (card & XD_CARD)
+		clk_en |= XD_CLK_EN;
+	if (card & SD_CARD)
+		clk_en |= SD_CLK_EN;
+	if (card & MS_CARD)
+		clk_en |= MS_CLK_EN;
+
+	RTS51X_WRITE_REG(chip, CARD_CLK_EN, clk_en, clk_en);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_card_power_on(struct rts51x_chip *chip, u8 card)
+{
+	u8 mask, val1, val2;
+
+	mask = POWER_MASK;
+	val1 = PARTIAL_POWER_ON;
+	val2 = POWER_ON;
+
+#ifdef SD_XD_IO_FOLLOW_PWR
+	if ((card == SD_CARD) || (card == XD_CARD)) {
+		RTS51X_WRITE_REG(chip, CARD_PWR_CTL, mask | LDO3318_PWR_MASK,
+				 val1 | LDO_SUSPEND);
+	} else {
+#endif
+		RTS51X_WRITE_REG(chip, CARD_PWR_CTL, mask, val1);
+#ifdef SD_XD_IO_FOLLOW_PWR
+	}
+#endif
+	udelay(chip->option.pwr_delay);
+	RTS51X_WRITE_REG(chip, CARD_PWR_CTL, mask, val2);
+#ifdef SD_XD_IO_FOLLOW_PWR
+	if (card == SD_CARD) {
+		rts51x_write_register(chip, CARD_PWR_CTL, LDO3318_PWR_MASK,
+				      LDO_ON);
+	}
+#endif
+
+	return STATUS_SUCCESS;
+}
+
+int monitor_card_cd(struct rts51x_chip *chip, u8 card)
+{
+	int retval;
+	u8 card_cd[32] = { 0 };
+
+	card_cd[SD_CARD] = SD_CD;
+	card_cd[XD_CARD] = XD_CD;
+	card_cd[MS_CARD] = MS_CD;
+
+	retval = rts51x_get_card_status(chip, &(chip->card_status));
+	if (retval != STATUS_SUCCESS)
+		return CD_NOT_EXIST;
+
+	if (chip->card_status & card_cd[card])
+		return CD_EXIST;
+
+	return CD_NOT_EXIST;
+}
+
+int rts51x_toggle_gpio(struct rts51x_chip *chip, u8 gpio)
+{
+	int retval;
+	u8 temp_reg;
+	u8 gpio_output[4] = {
+		0x01,
+	};
+	u8 gpio_oe[4] = {
+		0x02,
+	};
+	if (chip->rts5179) {
+		retval = rts51x_ep0_read_register(chip, CARD_GPIO, &temp_reg);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, STATUS_FAIL);
+		temp_reg ^= gpio_oe[gpio];
+		temp_reg &= 0xfe; /* bit 0 always set 0 */
+		retval =
+		    rts51x_ep0_write_register(chip, CARD_GPIO, 0x03, temp_reg);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, STATUS_FAIL);
+	} else {
+		retval = rts51x_ep0_read_register(chip, CARD_GPIO, &temp_reg);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, STATUS_FAIL);
+		temp_reg ^= gpio_output[gpio];
+		retval =
+		    rts51x_ep0_write_register(chip, CARD_GPIO, 0xFF,
+					      temp_reg | gpio_oe[gpio]);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_turn_on_led(struct rts51x_chip *chip, u8 gpio)
+{
+	int retval;
+	u8 gpio_oe[4] = {
+		0x02,
+	};
+	u8 gpio_mask[4] = {
+		0x03,
+	};
+
+	retval =
+	    rts51x_ep0_write_register(chip, CARD_GPIO, gpio_mask[gpio],
+				      gpio_oe[gpio]);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_turn_off_led(struct rts51x_chip *chip, u8 gpio)
+{
+	int retval;
+	u8 gpio_output[4] = {
+		0x01,
+	};
+	u8 gpio_oe[4] = {
+		0x02,
+	};
+	u8 gpio_mask[4] = {
+		0x03,
+	};
+
+	retval =
+	    rts51x_ep0_write_register(chip, CARD_GPIO, gpio_mask[gpio],
+				      gpio_oe[gpio] | gpio_output[gpio]);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
diff --git a/drivers/staging/rts5139/rts51x_card.h b/drivers/staging/rts5139/rts51x_card.h
new file mode 100644
index 000000000000..df8816e0f840
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_card.h
@@ -0,0 +1,870 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_CARD_H
+#define __RTS51X_CARD_H
+
+#include "rts51x_chip.h"
+
+/* Register bit definition */
+
+/* Card Power Control Register */
+#define POWER_OFF			0x03
+#define PARTIAL_POWER_ON		0x02
+#define POWER_ON			0x00
+#define POWER_MASK			0x03
+#define LDO3318_PWR_MASK		0x0C
+#define LDO_ON				0x00
+#define LDO_SUSPEND			0x08
+#define LDO_OFF				0x0C
+#define DV3318_AUTO_PWR_OFF		0x10
+#define FORCE_LDO_POWERB	0x60
+
+/* Card Output Enable Register */
+#define XD_OUTPUT_EN			0x02
+#define SD_OUTPUT_EN			0x04
+#define MS_OUTPUT_EN			0x08
+
+/* System Clock Control Register */
+
+/* System Clock Divider Register */
+#define CLK_CHANGE			0x80
+#define CLK_DIV_1			0x00
+#define CLK_DIV_2			0x01
+#define CLK_DIV_4			0x02
+#define CLK_DIV_8			0x03
+
+/* System Clock Select Register */
+#define SSC_60				0
+#define SSC_80				1
+#define SSC_100				2
+#define SSC_120				3
+#define SSC_150				4
+
+/* Card Clock Enable Register */
+#define XD_CLK_EN			0x02
+#define SD_CLK_EN			0x04
+#define MS_CLK_EN			0x08
+
+/* Card Select Register */
+#define XD_MOD_SEL			1
+#define SD_MOD_SEL			2
+#define MS_MOD_SEL			3
+
+/* Card Transfer Reset Register */
+#define XD_STOP				0x02
+#define SD_STOP				0x04
+#define MS_STOP				0x08
+#define XD_CLR_ERR			0x20
+#define SD_CLR_ERR			0x40
+#define MS_CLR_ERR			0x80
+
+/* SD30_drive_sel */
+#define SD30_DRIVE_MASK	0x07
+
+/* CARD_DRIVE_SEL */
+#define SD20_DRIVE_MASK	0x03
+#define DRIVE_4mA			0x00
+#define DRIVE_8mA			0x01
+#define DRIVE_12mA			0x02
+
+/* FPGA_PULL_CTL */
+#define FPGA_MS_PULL_CTL_EN		0xEF
+#define FPGA_SD_PULL_CTL_EN		0xF7
+#define FPGA_XD_PULL_CTL_EN1		0xFE
+#define FPGA_XD_PULL_CTL_EN2		0xFD
+#define FPGA_XD_PULL_CTL_EN3		0xFB
+
+#define FPGA_MS_PULL_CTL_BIT		0x10
+#define FPGA_SD_PULL_CTL_BIT		0x08
+
+/* Card Data Source Register */
+#define PINGPONG_BUFFER			0x01
+#define RING_BUFFER			0x00
+
+/* SFSM_ED */
+#define HW_CMD_STOP			0x80
+#define CLR_STAGE_STALL			0x08
+#define CARD_ERR				0x10
+
+/* CARD_SHARE_MODE */
+#define	CARD_SHARE_LQFP48		0x04
+#define	CARD_SHARE_QFN24		0x00
+#define CARD_SHARE_LQFP_SEL		0x04
+#define	CARD_SHARE_XD			0x00
+#define	CARD_SHARE_SD			0x01
+#define	CARD_SHARE_MS			0x02
+#define CARD_SHARE_MASK			0x03
+
+/* CARD_AUTO_BLINK */
+#define BLINK_ENABLE			0x08
+#define BLINK_SPEED_MASK		0x07
+
+/* CARD_GPIO */
+#define GPIO_OE				0x02
+#define GPIO_OUTPUT			0x01
+
+/* CARD_CLK_SOURCE */
+#define CRC_FIX_CLK			(0x00 << 0)
+#define CRC_VAR_CLK0			(0x01 << 0)
+#define CRC_VAR_CLK1			(0x02 << 0)
+#define SD30_FIX_CLK			(0x00 << 2)
+#define SD30_VAR_CLK0			(0x01 << 2)
+#define SD30_VAR_CLK1			(0x02 << 2)
+#define SAMPLE_FIX_CLK			(0x00 << 4)
+#define SAMPLE_VAR_CLK0			(0x01 << 4)
+#define SAMPLE_VAR_CLK1			(0x02 << 4)
+
+/* DCM_DRP_CTL */
+#define DCM_RESET			0x08
+#define DCM_LOCKED			0x04
+#define DCM_208M			0x00
+#define DCM_TX			        0x01
+#define DCM_RX			        0x02
+
+/* DCM_DRP_TRIG */
+#define DRP_START			0x80
+#define DRP_DONE			0x40
+
+/* DCM_DRP_CFG */
+#define DRP_WRITE			0x80
+#define DRP_READ			0x00
+#define DCM_WRITE_ADDRESS_50		0x50
+#define DCM_WRITE_ADDRESS_51		0x51
+#define DCM_READ_ADDRESS_00		0x00
+#define DCM_READ_ADDRESS_51		0x51
+
+/* HW_VERSION */
+#define FPGA_VER			0x80
+#define HW_VER_MASK			0x0F
+
+/* CD_DEGLITCH_EN */
+#define DISABLE_SD_CD			0x08
+#define DISABLE_MS_CD			0x10
+#define DISABLE_XD_CD			0x20
+#define SD_CD_DEGLITCH_EN		0x01
+#define MS_CD_DEGLITCH_EN		0x02
+#define XD_CD_DEGLITCH_EN		0x04
+
+/* OCPCTL */
+#define CARD_OC_DETECT_EN		0x08
+#define CARD_OC_CLR			0x01
+
+/* CARD_DMA1_CTL */
+#define EXTEND_DMA1_ASYNC_SIGNAL	0x02
+
+/* HS_USB_STAT */
+#define USB_HI_SPEED			0x01
+
+/* CFG_MODE_1 */
+#define RTS5179				0x02
+
+/* SYS_DUMMY0 */
+#define NYET_EN				0x01
+#define NYET_MSAK			0x01
+
+/* SSC_CTL1 */
+#define SSC_RSTB			0x80
+#define SSC_8X_EN			0x40
+#define SSC_FIX_FRAC			0x20
+#define SSC_SEL_1M			0x00
+#define SSC_SEL_2M			0x08
+#define SSC_SEL_4M			0x10
+#define SSC_SEL_8M			0x18
+
+/* SSC_CTL2 */
+#define SSC_DEPTH_MASK			0x03
+#define SSC_DEPTH_DISALBE		0x00
+#define SSC_DEPTH_2M			0x01
+#define SSC_DEPTH_1M			0x02
+#define SSC_DEPTH_512K			0x03
+
+/* LDO_POWER_CFG */
+#define TUNE_SD18_MASK			0x1C
+#define TUNE_SD18_1V8			(0x01 << 2)
+#define TUNE_SD18_3V3			(0x07 << 2)
+
+/* XD_CP_WAITTIME */
+#define WAIT_1F				0x00
+#define WAIT_3F				0x01
+#define WAIT_7F				0x02
+#define WAIT_FF				0x03
+
+/* XD_INIT */
+#define	XD_PWR_OFF_DELAY0		0x00
+#define	XD_PWR_OFF_DELAY1		0x02
+#define	XD_PWR_OFF_DELAY2		0x04
+#define	XD_PWR_OFF_DELAY3		0x06
+#define	XD_AUTO_PWR_OFF_EN		0xF7
+#define	XD_NO_AUTO_PWR_OFF		0x08
+
+/* XD_DTCTL */
+/* XD_CATCTL */
+#define	XD_TIME_RWN_1			0x00
+#define	XD_TIME_RWN_STEP		0x20
+#define	XD_TIME_RW_1			0x00
+#define	XD_TIME_RW_STEP			0x04
+#define	XD_TIME_SETUP_1			0x00
+#define	XD_TIME_SETUP_STEP		0x01
+
+/* XD_CTL */
+#define	XD_ECC2_UNCORRECTABLE		0x80
+#define	XD_ECC2_ERROR			0x40
+#define	XD_ECC1_UNCORRECTABLE		0x20
+#define	XD_ECC1_ERROR			0x10
+#define	XD_RDY				0x04
+#define	XD_CE_EN			0xFD
+#define	XD_CE_DISEN			0x02
+#define	XD_WP_EN			0xFE
+#define	XD_WP_DISEN			0x01
+
+/* XD_TRANSFER */
+#define	XD_TRANSFER_START		0x80
+#define	XD_TRANSFER_END			0x40
+#define	XD_PPB_EMPTY			0x20
+#define	XD_ERR				0x10
+#define	XD_RESET			0x00
+#define	XD_ERASE			0x01
+#define	XD_READ_STATUS			0x02
+#define	XD_READ_ID			0x03
+#define	XD_READ_REDUNDANT		0x04
+#define	XD_READ_PAGES			0x05
+#define	XD_SET_CMD			0x06
+#define	XD_NORMAL_READ			0x07
+#define	XD_WRITE_PAGES			0x08
+#define	XD_NORMAL_WRITE			0x09
+#define	XD_WRITE_REDUNDANT		0x0A
+#define	XD_SET_ADDR			0x0B
+#define XD_COPY_PAGES			0x0C
+
+/* XD_CFG */
+#define	XD_PPB_TO_SIE			0x80
+#define	XD_TO_PPB_ONLY			0x00
+#define	XD_BA_TRANSFORM			0x40
+#define	XD_BA_NO_TRANSFORM		0x00
+#define	XD_NO_CALC_ECC			0x20
+#define	XD_CALC_ECC			0x00
+#define	XD_IGNORE_ECC			0x10
+#define	XD_CHECK_ECC			0x00
+#define	XD_DIRECT_TO_RB			0x08
+#define XD_ADDR_MASK			0x07
+#define	XD_ADDR_LENGTH_0		0x00
+#define	XD_ADDR_LENGTH_1		0x01
+#define	XD_ADDR_LENGTH_2		0x02
+#define	XD_ADDR_LENGTH_3		0x03
+#define	XD_ADDR_LENGTH_4		0x04
+
+/* XD_PAGE_STATUS */
+#define	XD_GPG				0xFF
+#define	XD_BPG				0x00
+
+/* XD_BLOCK_STATUS */
+#define	XD_GBLK				0xFF
+#define	XD_LATER_BBLK			0xF0
+
+/* XD_PARITY */
+#define	XD_ECC2_ALL1			0x80
+#define	XD_ECC1_ALL1			0x40
+#define	XD_BA2_ALL0			0x20
+#define	XD_BA1_ALL0			0x10
+#define	XD_BA1_BA2_EQL			0x04
+#define	XD_BA2_VALID			0x02
+#define	XD_BA1_VALID			0x01
+
+/* XD_CHK_DATA_STATUS */
+#define	XD_PGSTS_ZEROBIT_OVER4		0x00
+#define	XD_PGSTS_NOT_FF			0x02
+#define	XD_AUTO_CHK_DATA_STATUS		0x01
+
+/* SD_CFG1 */
+#define SD_CLK_DIVIDE_0			0x00
+#define	SD_CLK_DIVIDE_256		0xC0
+#define	SD_CLK_DIVIDE_128		0x80
+#define SD_CLK_DIVIDE_MASK		0xC0
+#define	SD_BUS_WIDTH_1			0x00
+#define	SD_BUS_WIDTH_4			0x01
+#define	SD_BUS_WIDTH_8			0x02
+#define	SD_ASYNC_FIFO_RST		0x10
+#define	SD_20_MODE			0x00
+#define	SD_DDR_MODE			0x04
+#define	SD_30_MODE			0x08
+
+/* SD_CFG2 */
+#define	SD_CALCULATE_CRC7		0x00
+#define	SD_NO_CALCULATE_CRC7		0x80
+#define	SD_CHECK_CRC16			0x00
+#define	SD_NO_CHECK_CRC16		0x40
+#define SD_WAIT_CRC_TO_EN		0x20
+#define	SD_WAIT_BUSY_END		0x08
+#define	SD_NO_WAIT_BUSY_END		0x00
+#define	SD_CHECK_CRC7			0x00
+#define	SD_NO_CHECK_CRC7		0x04
+#define	SD_RSP_LEN_0			0x00
+#define	SD_RSP_LEN_6			0x01
+#define	SD_RSP_LEN_17			0x02
+/* SD/MMC Response Type Definition */
+/* SD_CALCULATE_CRC7, SD_CHECK_CRC16,
+ * SD_NO_WAIT_BUSY_END, SD_NO_CHECK_CRC7,
+ * SD_RSP_LEN_0 */
+#define	SD_RSP_TYPE_R0			0x04
+/* SD_CALCULATE_CRC7, SD_CHECK_CRC16,
+ * SD_NO_WAIT_BUSY_END, SD_CHECK_CRC7,
+ * SD_RSP_LEN_6 */
+#define	SD_RSP_TYPE_R1			0x01
+/* SD_CALCULATE_CRC7, SD_CHECK_CRC16,
+ * SD_WAIT_BUSY_END, SD_CHECK_CRC7,
+ * SD_RSP_LEN_6 */
+#define	SD_RSP_TYPE_R1b			0x09
+/* SD_CALCULATE_CRC7, SD_CHECK_CRC16,
+ * SD_NO_WAIT_BUSY_END, SD_CHECK_CRC7,
+ * SD_RSP_LEN_17 */
+#define	SD_RSP_TYPE_R2			0x02
+/* SD_CALCULATE_CRC7, SD_CHECK_CRC16,
+ * SD_NO_WAIT_BUSY_END, SD_NO_CHECK_CRC7,
+ * SD_RSP_LEN_6 */
+#define	SD_RSP_TYPE_R3			0x05
+/* SD_CALCULATE_CRC7, SD_CHECK_CRC16,
+ * SD_NO_WAIT_BUSY_END, SD_NO_CHECK_CRC7,
+ * SD_RSP_LEN_6 */
+#define	SD_RSP_TYPE_R4			0x05
+/* SD_CALCULATE_CRC7, SD_CHECK_CRC16,
+ * SD_NO_WAIT_BUSY_END, SD_CHECK_CRC7,
+ * SD_RSP_LEN_6 */
+#define	SD_RSP_TYPE_R5			0x01
+/* SD_CALCULATE_CRC7, SD_CHECK_CRC16,
+ * SD_NO_WAIT_BUSY_END, SD_CHECK_CRC7,
+ * SD_RSP_LEN_6 */
+#define	SD_RSP_TYPE_R6			0x01
+/* SD_CALCULATE_CRC7, SD_CHECK_CRC16,
+ * SD_NO_WAIT_BUSY_END, SD_CHECK_CRC7,
+ * SD_RSP_LEN_6  */
+#define	SD_RSP_TYPE_R7			0x01
+
+/* SD_CFG3 */
+#define	SD_RSP_80CLK_TIMEOUT_EN		0x01
+
+/* SD_STAT1 */
+#define	SD_CRC7_ERR			0x80
+#define	SD_CRC16_ERR			0x40
+#define	SD_CRC_WRITE_ERR		0x20
+#define	SD_CRC_WRITE_ERR_MASK		0x1C
+#define	GET_CRC_TIME_OUT		0x02
+#define	SD_TUNING_COMPARE_ERR		0x01
+
+/* SD_STAT2 */
+#define	SD_RSP_80CLK_TIMEOUT		0x01
+
+/* SD_BUS_STAT */
+#define	SD_CLK_TOGGLE_EN		0x80
+#define	SD_CLK_FORCE_STOP	        0x40
+#define	SD_DAT3_STATUS		        0x10
+#define	SD_DAT2_STATUS		        0x08
+#define	SD_DAT1_STATUS		        0x04
+#define	SD_DAT0_STATUS		        0x02
+#define	SD_CMD_STATUS			0x01
+
+/* SD_PAD_CTL */
+#define	SD_IO_USING_1V8		        0x80
+#define	SD_IO_USING_3V3		        0x7F
+#define	TYPE_A_DRIVING		        0x00
+#define	TYPE_B_DRIVING			0x01
+#define	TYPE_C_DRIVING			0x02
+#define	TYPE_D_DRIVING		        0x03
+
+/* SD_SAMPLE_POINT_CTL */
+#define	DDR_FIX_RX_DAT			0x00
+#define	DDR_VAR_RX_DAT			0x80
+#define	DDR_FIX_RX_DAT_EDGE		0x00
+#define	DDR_FIX_RX_DAT_14_DELAY		0x40
+#define	DDR_FIX_RX_CMD			0x00
+#define	DDR_VAR_RX_CMD			0x20
+#define	DDR_FIX_RX_CMD_POS_EDGE		0x00
+#define	DDR_FIX_RX_CMD_14_DELAY		0x10
+#define	SD20_RX_POS_EDGE		0x00
+#define	SD20_RX_14_DELAY		0x08
+#define SD20_RX_SEL_MASK		0x08
+
+/* SD_PUSH_POINT_CTL */
+#define	DDR_FIX_TX_CMD_DAT		0x00
+#define	DDR_VAR_TX_CMD_DAT		0x80
+#define	DDR_FIX_TX_DAT_14_TSU		0x00
+#define	DDR_FIX_TX_DAT_12_TSU		0x40
+#define	DDR_FIX_TX_CMD_NEG_EDGE		0x00
+#define	DDR_FIX_TX_CMD_14_AHEAD		0x20
+#define	SD20_TX_NEG_EDGE		0x00
+#define	SD20_TX_14_AHEAD		0x10
+#define SD20_TX_SEL_MASK		0x10
+#define	DDR_VAR_SDCLK_POL_SWAP		0x01
+
+/* SD_TRANSFER */
+#define	SD_TRANSFER_START		0x80
+#define	SD_TRANSFER_END			0x40
+#define SD_STAT_IDLE			0x20
+#define	SD_TRANSFER_ERR			0x10
+/* SD Transfer Mode definition */
+#define	SD_TM_NORMAL_WRITE		0x00
+#define	SD_TM_AUTO_WRITE_3		0x01
+#define	SD_TM_AUTO_WRITE_4		0x02
+#define	SD_TM_AUTO_READ_3		0x05
+#define	SD_TM_AUTO_READ_4		0x06
+#define	SD_TM_CMD_RSP			0x08
+#define	SD_TM_AUTO_WRITE_1		0x09
+#define	SD_TM_AUTO_WRITE_2		0x0A
+#define	SD_TM_NORMAL_READ		0x0C
+#define	SD_TM_AUTO_READ_1		0x0D
+#define	SD_TM_AUTO_READ_2		0x0E
+#define	SD_TM_AUTO_TUNING		0x0F
+
+/* SD_VPTX_CTL / SD_VPRX_CTL */
+#define PHASE_CHANGE			0x80
+#define PHASE_NOT_RESET			0x40
+
+/* SD_DCMPS_TX_CTL / SD_DCMPS_RX_CTL */
+#define DCMPS_CHANGE			0x80
+#define DCMPS_CHANGE_DONE		0x40
+#define DCMPS_ERROR			0x20
+#define DCMPS_CURRENT_PHASE		0x1F
+
+/* SD_CMD_STATE */
+#define SD_CMD_IDLE			0x80
+
+/* SD_DATA_STATE */
+#define SD_DATA_IDLE			0x80
+
+/* MS_BLKEND */
+#define SET_BLKEND			0x01
+
+/* MS_CFG */
+#define	SAMPLE_TIME_RISING		0x00
+#define	SAMPLE_TIME_FALLING		0x80
+#define	PUSH_TIME_DEFAULT		0x00
+#define	PUSH_TIME_ODD			0x40
+#define	NO_EXTEND_TOGGLE		0x00
+#define	EXTEND_TOGGLE_CHK		0x20
+#define	MS_BUS_WIDTH_1			0x00
+#define	MS_BUS_WIDTH_4			0x10
+#define	MS_BUS_WIDTH_8			0x18
+#define	MS_2K_SECTOR_MODE		0x04
+#define	MS_512_SECTOR_MODE		0x00
+#define	MS_TOGGLE_TIMEOUT_EN		0x00
+#define	MS_TOGGLE_TIMEOUT_DISEN		0x01
+#define MS_NO_CHECK_INT			0x02
+
+/* MS_TRANS_CFG */
+#define	WAIT_INT			0x80
+#define	NO_WAIT_INT			0x00
+#define	NO_AUTO_READ_INT_REG		0x00
+#define	AUTO_READ_INT_REG		0x40
+#define	MS_CRC16_ERR			0x20
+#define	MS_RDY_TIMEOUT			0x10
+#define	MS_INT_CMDNK			0x08
+#define	MS_INT_BREQ			0x04
+#define	MS_INT_ERR			0x02
+#define	MS_INT_CED			0x01
+
+/* MS_TRANSFER */
+#define	MS_TRANSFER_START		0x80
+#define	MS_TRANSFER_END			0x40
+#define	MS_TRANSFER_ERR			0x20
+#define	MS_BS_STATE			0x10
+#define	MS_TM_READ_BYTES		0x00
+#define	MS_TM_NORMAL_READ		0x01
+#define	MS_TM_WRITE_BYTES		0x04
+#define	MS_TM_NORMAL_WRITE		0x05
+#define	MS_TM_AUTO_READ			0x08
+#define	MS_TM_AUTO_WRITE		0x0C
+#define MS_TM_SET_CMD			0x06
+#define MS_TM_COPY_PAGE			0x07
+#define MS_TM_MULTI_READ		0x02
+#define MS_TM_MULTI_WRITE		0x03
+
+/* MC_DMA_CTL */
+#define DMA_TC_EQ_0			0x80
+#define DMA_DIR_TO_CARD			0x00
+#define DMA_DIR_FROM_CARD		0x02
+#define DMA_EN				0x01
+#define DMA_128				(0 << 2)
+#define DMA_256				(1 << 2)
+#define DMA_512				(2 << 2)
+#define DMA_1024			(3 << 2)
+#define DMA_PACK_SIZE_MASK		0x0C
+
+/* CARD_INT_PEND */
+#define XD_INT				0x10
+#define MS_INT				0x08
+#define SD_INT				0x04
+
+/* MC_FIFO_CTL */
+#define FIFO_FLUSH			0x01
+
+/* AUTO_DELINK_EN */
+#define AUTO_DELINK			0x02
+#define FORCE_DELINK			0x01
+
+/* MC_DMA_RST */
+#define DMA_RESET  0x01
+
+#define SSC_POWER_MASK			0x01
+#define SSC_POWER_DOWN			0x01
+#define SSC_POWER_ON			0x00
+
+/* OCPCTL */
+#define MS_OCP_DETECT_EN		0x08
+#define	MS_OCP_INT_EN			0x04
+#define	MS_OCP_INT_CLR			0x02
+#define	MS_OCP_CLEAR			0x01
+
+/* OCPSTAT */
+#define MS_OCP_DETECT			0x80
+#define MS_OCP_NOW			0x02
+#define MS_OCP_EVER			0x01
+
+/* MC_FIFO_STAT */
+#define FIFO_FULL		0x01
+#define FIFO_EMPTY		0x02
+
+/* RCCTL */
+#define U_HW_CMD_EN_MASK		0x02
+#define U_HW_CMD_EN			0x02
+#define U_HW_CMD_DIS			0x00
+
+/* Register address */
+#define FPDCTL				0xFC00
+#define SSC_DIV_N_0			0xFC07
+#define SSC_CTL1			0xFC09
+#define SSC_CTL2			0xFC0A
+#define CFG_MODE_1		0xFC0F
+#define RCCTL			0xFC14
+#define SYS_DUMMY0			0xFC30
+#define XD_CP_WAITTIME			0xFD00
+#define XD_CP_PAGELEN			0xFD01
+#define XD_CP_READADDR0			0xFD02
+#define XD_CP_READADDR1			0xFD03
+#define XD_CP_READADDR2			0xFD04
+#define XD_CP_READADDR3			0xFD05
+#define XD_CP_READADDR4			0xFD06
+#define XD_CP_WRITEADDR0		0xFD07
+#define XD_CP_WRITEADDR1		0xFD08
+#define XD_CP_WRITEADDR2		0xFD09
+#define XD_CP_WRITEADDR3		0xFD0A
+#define XD_CP_WRITEADDR4		0xFD0B
+#define XD_INIT				0xFD10
+#define XD_DTCTL			0xFD11
+#define XD_CTL				0xFD12
+#define XD_TRANSFER			0xFD13
+#define XD_CFG				0xFD14
+#define XD_ADDRESS0			0xFD15
+#define XD_ADDRESS1			0xFD16
+#define XD_ADDRESS2			0xFD17
+#define XD_ADDRESS3			0xFD18
+#define XD_ADDRESS4			0xFD19
+#define XD_DAT				0xFD1A
+#define XD_PAGE_CNT			0xFD1B
+#define XD_PAGE_STATUS			0xFD1C
+#define XD_BLOCK_STATUS			0xFD1D
+#define XD_BLOCK_ADDR1_L		0xFD1E
+#define XD_BLOCK_ADDR1_H		0xFD1F
+#define XD_BLOCK_ADDR2_L		0xFD20
+#define XD_BLOCK_ADDR2_H		0xFD21
+#define XD_BYTE_CNT_L			0xFD22
+#define XD_BYTE_CNT_H			0xFD23
+#define	XD_PARITY			0xFD24
+#define XD_ECC_BIT1			0xFD25
+#define XD_ECC_BYTE1			0xFD26
+#define XD_ECC_BIT2			0xFD27
+#define XD_ECC_BYTE2			0xFD28
+#define XD_RESERVED0			0xFD29
+#define XD_RESERVED1			0xFD2A
+#define XD_RESERVED2			0xFD2B
+#define XD_RESERVED3			0xFD2C
+#define XD_CHK_DATA_STATUS		0xFD2D
+#define XD_CATCTL			0xFD2E
+
+#define MS_BLKEND			0xFD30
+#define MS_READ_START			0xFD31
+#define MS_READ_COUNT			0xFD32
+#define MS_WRITE_START			0xFD33
+#define MS_WRITE_COUNT			0xFD34
+#define MS_COMMAND			0xFD35
+#define MS_OLD_BLOCK_0			0xFD36
+#define MS_OLD_BLOCK_1			0xFD37
+#define MS_NEW_BLOCK_0			0xFD38
+#define MS_NEW_BLOCK_1			0xFD39
+#define MS_LOG_BLOCK_0			0xFD3A
+#define MS_LOG_BLOCK_1			0xFD3B
+#define MS_BUS_WIDTH			0xFD3C
+#define MS_PAGE_START			0xFD3D
+#define MS_PAGE_LENGTH			0xFD3E
+#define MS_CFG				0xFD40
+#define MS_TPC				0xFD41
+#define MS_TRANS_CFG			0xFD42
+#define MS_TRANSFER			0xFD43
+#define MS_INT_REG			0xFD44
+#define MS_BYTE_CNT			0xFD45
+#define MS_SECTOR_CNT_L			0xFD46
+#define MS_SECTOR_CNT_H			0xFD47
+#define MS_DBUS_H			0xFD48
+
+#define CARD_DMA1_CTL			0xFD5C
+#define CARD_PULL_CTL1			0xFD60
+#define CARD_PULL_CTL2			0xFD61
+#define CARD_PULL_CTL3			0xFD62
+#define CARD_PULL_CTL4			0xFD63
+#define CARD_PULL_CTL5			0xFD64
+#define CARD_PULL_CTL6			0xFD65
+#define CARD_EXIST				0xFD6F
+#define CARD_INT_PEND			0xFD71
+
+#define LDO_POWER_CFG			0xFD7B
+
+#define SD_CFG1				0xFDA0
+#define SD_CFG2				0xFDA1
+#define SD_CFG3				0xFDA2
+#define SD_STAT1			0xFDA3
+#define SD_STAT2			0xFDA4
+#define SD_BUS_STAT			0xFDA5
+#define SD_PAD_CTL			0xFDA6
+#define SD_SAMPLE_POINT_CTL		0xFDA7
+#define SD_PUSH_POINT_CTL		0xFDA8
+#define SD_CMD0				0xFDA9
+#define SD_CMD1				0xFDAA
+#define SD_CMD2				0xFDAB
+#define SD_CMD3				0xFDAC
+#define SD_CMD4				0xFDAD
+#define SD_CMD5				0xFDAE
+#define SD_BYTE_CNT_L			0xFDAF
+#define SD_BYTE_CNT_H			0xFDB0
+#define SD_BLOCK_CNT_L			0xFDB1
+#define SD_BLOCK_CNT_H			0xFDB2
+#define SD_TRANSFER			0xFDB3
+#define SD_CMD_STATE			0xFDB5
+#define SD_DATA_STATE			0xFDB6
+#define SD_VPCLK0_CTL			0xFC2A
+#define SD_VPCLK1_CTL			0xFC2B
+#define SD_DCMPS0_CTL			0xFC2C
+#define SD_DCMPS1_CTL			0xFC2D
+
+#define CARD_DMA1_CTL			0xFD5C
+
+#define HW_VERSION			0xFC01
+
+#define SSC_CLK_FPGA_SEL		0xFC02
+#define CLK_DIV				0xFC03
+#define SFSM_ED				0xFC04
+
+#define CD_DEGLITCH_WIDTH		0xFC20
+#define CD_DEGLITCH_EN			0xFC21
+#define AUTO_DELINK_EN			0xFC23
+
+#define FPGA_PULL_CTL			0xFC1D
+#define CARD_CLK_SOURCE			0xFC2E
+
+#define CARD_SHARE_MODE			0xFD51
+#define CARD_DRIVE_SEL			0xFD52
+#define CARD_STOP			0xFD53
+#define CARD_OE				0xFD54
+#define CARD_AUTO_BLINK			0xFD55
+#define CARD_GPIO			0xFD56
+#define SD30_DRIVE_SEL		0xFD57
+
+#define CARD_DATA_SOURCE		0xFD5D
+#define CARD_SELECT			0xFD5E
+
+#define CARD_CLK_EN			0xFD79
+#define CARD_PWR_CTL			0xFD7A
+
+#define OCPCTL				0xFD80
+#define OCPPARA1			0xFD81
+#define OCPPARA2			0xFD82
+#define OCPSTAT				0xFD83
+
+#define HS_USB_STAT			0xFE01
+#define HS_VCONTROL			0xFE26
+#define HS_VSTAIN			0xFE27
+#define HS_VLOADM			0xFE28
+#define HS_VSTAOUT			0xFE29
+
+#define MC_IRQ				0xFF00
+#define MC_IRQEN			0xFF01
+#define MC_FIFO_CTL			0xFF02
+#define MC_FIFO_BC0			0xFF03
+#define MC_FIFO_BC1			0xFF04
+#define MC_FIFO_STAT			0xFF05
+#define MC_FIFO_MODE			0xFF06
+#define MC_FIFO_RD_PTR0		0xFF07
+#define MC_FIFO_RD_PTR1		0xFF08
+#define MC_DMA_CTL			0xFF10
+#define MC_DMA_TC0			0xFF11
+#define MC_DMA_TC1			0xFF12
+#define MC_DMA_TC2			0xFF13
+#define MC_DMA_TC3			0xFF14
+#define MC_DMA_RST			0xFF15
+
+/* Memory mapping */
+#define RBUF_SIZE_MASK		0xFBFF
+#define RBUF_BASE			0xF000
+#define PPBUF_BASE1			0xF800
+#define PPBUF_BASE2			0xFA00
+
+/* int monitor_card_cd */
+#define CD_EXIST			0
+#define CD_NOT_EXIST			1
+
+#define DEBOUNCE_CNT			5
+
+int monitor_card_cd(struct rts51x_chip *chip, u8 card);
+
+void rts51x_do_remaining_work(struct rts51x_chip *chip);
+void rts51x_do_rts51x_reset_sd_card(struct rts51x_chip *chip);
+void rts51x_init_cards(struct rts51x_chip *chip);
+void rts51x_release_cards(struct rts51x_chip *chip);
+int rts51x_switch_ssc_clock(struct rts51x_chip *chip, int clk);
+int rts51x_switch_normal_clock(struct rts51x_chip *chip, int clk);
+int rts51x_card_rw(struct scsi_cmnd *srb, struct rts51x_chip *chip,
+		u32 sec_addr, u16 sec_cnt);
+u8 rts51x_get_lun_card(struct rts51x_chip *chip, unsigned int lun);
+int rts51x_select_card(struct rts51x_chip *chip, int card);
+void rts51x_eject_card(struct rts51x_chip *chip, unsigned int lun);
+void rts51x_trans_dma_enable(enum dma_data_direction dir,
+		struct rts51x_chip *chip, u32 byte_cnt, u8 pack_size);
+int rts51x_enable_card_clock(struct rts51x_chip *chip, u8 card);
+int rts51x_card_power_on(struct rts51x_chip *chip, u8 card);
+int rts51x_toggle_gpio(struct rts51x_chip *chip, u8 gpio);
+int rts51x_turn_on_led(struct rts51x_chip *chip, u8 gpio);
+int rts51x_turn_off_led(struct rts51x_chip *chip, u8 gpio);
+
+static inline int check_card_ready(struct rts51x_chip *chip, unsigned int lun)
+{
+	if (chip->card_ready & chip->lun2card[lun])
+		return 1;
+
+	return 0;
+}
+
+static inline int check_card_exist(struct rts51x_chip *chip, unsigned int lun)
+{
+	if (chip->card_exist & chip->lun2card[lun])
+		return 1;
+
+	return 0;
+}
+
+static inline int check_card_wp(struct rts51x_chip *chip, unsigned int lun)
+{
+	if (chip->card_wp & chip->lun2card[lun])
+		return 1;
+
+	return 0;
+}
+
+static inline int check_card_fail(struct rts51x_chip *chip, unsigned int lun)
+{
+	if (chip->card_fail & chip->lun2card[lun])
+		return 1;
+
+	return 0;
+}
+
+static inline int check_card_ejected(struct rts51x_chip *chip, unsigned int lun)
+{
+	if (chip->card_ejected & chip->lun2card[lun])
+		return 1;
+
+	return 0;
+}
+
+static inline int check_fake_card_ready(struct rts51x_chip *chip,
+					unsigned int lun)
+{
+	if (chip->fake_card_ready & chip->lun2card[lun])
+		return 1;
+
+	return 0;
+}
+
+static inline u8 get_lun2card(struct rts51x_chip *chip, unsigned int lun)
+{
+	return chip->lun2card[lun];
+}
+
+static inline int check_lun_mc(struct rts51x_chip *chip, unsigned int lun)
+{
+	return CHK_BIT(chip->lun_mc, lun);
+}
+
+static inline void set_lun_mc(struct rts51x_chip *chip, unsigned int lun)
+{
+	SET_BIT(chip->lun_mc, lun);
+}
+
+static inline void clear_lun_mc(struct rts51x_chip *chip, unsigned int lun)
+{
+	CLR_BIT(chip->lun_mc, lun);
+}
+
+static inline int switch_clock(struct rts51x_chip *chip, int clk)
+{
+	int retval = 0;
+
+	if (chip->asic_code)
+		retval = rts51x_switch_ssc_clock(chip, clk);
+	else
+		retval = rts51x_switch_normal_clock(chip, clk);
+
+	return retval;
+}
+
+static inline void rts51x_clear_xd_error(struct rts51x_chip *chip)
+{
+	rts51x_ep0_write_register(chip, CARD_STOP,
+				  XD_STOP | XD_CLR_ERR, XD_STOP | XD_CLR_ERR);
+
+	rts51x_ep0_write_register(chip, MC_FIFO_CTL, FIFO_FLUSH, FIFO_FLUSH);
+	rts51x_ep0_write_register(chip, MC_DMA_RST, DMA_RESET, DMA_RESET);
+	rts51x_ep0_write_register(chip, SFSM_ED, 0xf8, 0xf8);
+}
+
+static inline void rts51x_clear_sd_error(struct rts51x_chip *chip)
+{
+	rts51x_ep0_write_register(chip, CARD_STOP,
+				  SD_STOP | SD_CLR_ERR, SD_STOP | SD_CLR_ERR);
+
+	rts51x_ep0_write_register(chip, MC_FIFO_CTL, FIFO_FLUSH, FIFO_FLUSH);
+	rts51x_ep0_write_register(chip, MC_DMA_RST, DMA_RESET, DMA_RESET);
+	rts51x_ep0_write_register(chip, SFSM_ED, 0xf8, 0xf8);
+}
+
+static inline void rts51x_clear_ms_error(struct rts51x_chip *chip)
+{
+	rts51x_ep0_write_register(chip, CARD_STOP,
+				  MS_STOP | MS_CLR_ERR, MS_STOP | MS_CLR_ERR);
+
+	rts51x_ep0_write_register(chip, MC_FIFO_CTL, FIFO_FLUSH, FIFO_FLUSH);
+	rts51x_ep0_write_register(chip, MC_DMA_RST, DMA_RESET, DMA_RESET);
+	rts51x_ep0_write_register(chip, SFSM_ED, 0xf8, 0xf8);
+}
+
+#endif /* __RTS51X_CARD_H */
diff --git a/drivers/staging/rts5139/rts51x_chip.c b/drivers/staging/rts5139/rts51x_chip.c
new file mode 100644
index 000000000000..7d7510de170c
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_chip.c
@@ -0,0 +1,1014 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+
+#include "debug.h"
+#include "trace.h"
+#include "rts51x.h"
+#include "rts51x_chip.h"
+#include "rts51x_card.h"
+#include "rts51x_transport.h"
+#include "xd.h"
+#include "ms.h"
+#include "sd.h"
+
+static int check_sd_speed_prior(u32 sd_speed_prior)
+{
+	int i, fake_para = 0;
+
+	/* Check the legality of sd_speed_prior */
+	for (i = 0; i < 4; i++) {
+		u8 tmp = (u8) (sd_speed_prior >> (i * 8));
+		if ((tmp < 0x01) || (tmp > 0x04)) {
+			fake_para = 1;
+			break;
+		}
+	}
+
+	return !fake_para;
+}
+
+int rts51x_reset_chip(struct rts51x_chip *chip)
+{
+	int retval;
+
+	if (CHECK_PKG(chip, LQFP48)) {
+		RTS51X_WRITE_REG(chip, CARD_PWR_CTL, LDO3318_PWR_MASK,
+				 LDO_SUSPEND);
+		RTS51X_WRITE_REG(chip, CARD_PWR_CTL, FORCE_LDO_POWERB,
+				 FORCE_LDO_POWERB);
+		RTS51X_WRITE_REG(chip, CARD_PULL_CTL1, 0x30, 0x10);
+		RTS51X_WRITE_REG(chip, CARD_PULL_CTL5, 0x03, 0x01);
+		RTS51X_WRITE_REG(chip, CARD_PULL_CTL6, 0x0C, 0x04);
+	}
+	if (chip->asic_code) {
+		RTS51X_WRITE_REG(chip, SYS_DUMMY0, NYET_MSAK, NYET_EN);
+		RTS51X_WRITE_REG(chip, CD_DEGLITCH_WIDTH, 0xFF, 0x08);
+		rts51x_write_register(chip, CD_DEGLITCH_EN, XD_CD_DEGLITCH_EN,
+				      0x00);
+		rts51x_write_register(chip, SD30_DRIVE_SEL, SD30_DRIVE_MASK,
+				      chip->option.sd30_pad_drive);
+		rts51x_write_register(chip, CARD_DRIVE_SEL, SD20_DRIVE_MASK,
+				      chip->option.sd20_pad_drive);
+		if (chip->rts5179)
+			rts51x_write_register(chip, CARD_PULL_CTL5, 0x03, 0x01);
+		if (CHECK_PKG(chip, LQFP48)) {
+			rts51x_write_register(chip, CARD_PULL_CTL3,
+					      0x80, 0x80);
+			rts51x_write_register(chip, CARD_PULL_CTL6,
+					      0xf0, 0xA0);
+		} else {
+			rts51x_write_register(chip, CARD_PULL_CTL1,
+					      0x30, 0x20);
+			rts51x_write_register(chip, CARD_PULL_CTL3,
+					      0x80, 0x80);
+			rts51x_write_register(chip, CARD_PULL_CTL6,
+					      0x0c, 0x08);
+		}
+	}
+	if (chip->option.sd_ctl & SUPPORT_UHS50_MMC44) {
+		SET_UHS50(chip);
+		RTS51X_DEBUGP("option enable UHS50&MMC44,sd_ctl:0x%x\n",
+			chip->option.sd_ctl);
+	} else {
+		/* if(CHECK_PID(chip, 0x0139)&&CHECK_PKG(chip, LQFP48)) */
+		if ((CHECK_PID(chip, 0x0139) && CHECK_PKG(chip, LQFP48))
+		    || chip->rts5179) {
+			SET_UHS50(chip);
+			RTS51X_DEBUGP("PID enable UHS50&MMC44\n");
+		} else {
+			CLEAR_UHS50(chip);
+			RTS51X_DEBUGP("PID disable UHS50&MMC44\n");
+		}
+	}
+
+	if (chip->option.ms_errreg_fix && (chip->ic_version > 1))
+		rts51x_write_register(chip, 0xFD4D, 0x01, 0x01);
+	retval = rts51x_write_phy_register(chip, 0xC2, 0x7C);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	rts51x_init_cmd(chip);
+
+	/* GPIO OE */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_GPIO, GPIO_OE, GPIO_OE);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DMA1_CTL,
+		       EXTEND_DMA1_ASYNC_SIGNAL, EXTEND_DMA1_ASYNC_SIGNAL);
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+#ifdef SUPPORT_OCP
+	if (chip->asic_code) {
+		rts51x_write_register(chip, OCPCTL, MS_OCP_DETECT_EN,
+				      MS_OCP_DETECT_EN);
+		RTS51X_DEBUGP("Enable OCP detect!\n");
+	}
+#endif
+	if (chip->option.FT2_fast_mode) {
+		rts51x_card_power_on(chip, SD_CARD | MS_CARD | XD_CARD);
+		wait_timeout(10);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_init_chip(struct rts51x_chip *chip)
+{
+	int retval;
+	u8 val;
+
+	chip->max_lun = 0;
+	chip->cur_clk = 0;
+	chip->cur_card = 0;
+
+	chip->card2lun[XD_CARD] = 0;
+	chip->card2lun[SD_CARD] = 0;
+	chip->card2lun[MS_CARD] = 0;
+	chip->card_ejected = 0;
+
+	chip->lun2card[0] = XD_CARD | SD_CARD | MS_CARD;
+#ifdef CLOSE_SSC_POWER
+	rts51x_write_register(chip, FPDCTL, SSC_POWER_MASK, SSC_POWER_ON);
+	udelay(100);
+	rts51x_write_register(chip, CLK_DIV, CLK_CHANGE, 0x00);
+#endif
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	RTS51X_READ_REG(chip, HW_VERSION, &val);
+	RTS51X_DEBUGP("HW_VERSION: 0x%x\n", val);
+	if (val & FPGA_VER) {
+		chip->asic_code = 0;
+		RTS51X_DEBUGP("FPGA!\n");
+	} else {
+		chip->asic_code = 1;
+		RTS51X_DEBUGP("ASIC!\n");
+	}
+	chip->ic_version = val & HW_VER_MASK;
+
+	if (!check_sd_speed_prior(chip->option.sd_speed_prior))
+		chip->option.sd_speed_prior = 0x01020403;
+	RTS51X_DEBUGP("sd_speed_prior = 0x%08x\n",
+		       chip->option.sd_speed_prior);
+
+	RTS51X_READ_REG(chip, CARD_SHARE_MODE, &val);
+	if (val & CARD_SHARE_LQFP_SEL) {
+		chip->package = LQFP48;
+		RTS51X_DEBUGP("Package: LQFP48\n");
+	} else {
+		chip->package = QFN24;
+		RTS51X_DEBUGP("Package: QFN24\n");
+	}
+
+	RTS51X_READ_REG(chip, HS_USB_STAT, &val);
+	if (val & USB_HI_SPEED) {
+		chip->usb_speed = USB_20;
+		RTS51X_DEBUGP("USB High Speed\n");
+	} else {
+		chip->usb_speed = USB_11;
+		RTS51X_DEBUGP("USB Full Speed\n");
+	}
+
+	RTS51X_READ_REG(chip, CFG_MODE_1, &val);
+	if (val & RTS5179) {
+		chip->rts5179 = 1;
+		RTS51X_DEBUGP("device is rts5179\n");
+	} else {
+		chip->rts5179 = 0;
+	}
+
+	retval = rts51x_reset_chip(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_release_chip(struct rts51x_chip *chip)
+{
+	rts51x_xd_free_l2p_tbl(chip);
+	rts51x_ms_free_l2p_tbl(chip);
+	chip->card_ready = 0;
+	return STATUS_SUCCESS;
+}
+
+static inline void rts51x_blink_led(struct rts51x_chip *chip)
+{
+	/* Read/Write */
+	if (chip->card_ready) {
+		if (chip->led_toggle_counter <
+				chip->option.led_toggle_interval) {
+			chip->led_toggle_counter++;
+		} else {
+			chip->led_toggle_counter = 0;
+			rts51x_toggle_gpio(chip, LED_GPIO);
+		}
+	}
+}
+
+static void rts51x_auto_delink_cmd(struct rts51x_chip *chip)
+{
+	rts51x_write_register(chip, AUTO_DELINK_EN,
+			AUTO_DELINK, AUTO_DELINK);
+}
+
+static void rts51x_auto_delink_force_cmd(struct rts51x_chip *chip)
+{
+	rts51x_write_register(chip, AUTO_DELINK_EN,
+			AUTO_DELINK | FORCE_DELINK,
+			AUTO_DELINK | FORCE_DELINK);
+}
+
+#ifdef USING_POLLING_CYCLE_DELINK
+/* using polling cycle as delink time */
+static void rts51x_auto_delink_polling_cycle(struct rts51x_chip *chip)
+{
+	if (chip->auto_delink_counter <=
+			chip->option.delink_delay * 2) {
+		if (chip->auto_delink_counter ==
+		    chip->option.delink_delay) {
+			if (chip->card_exist) {
+				/* False card */
+				if (!chip->card_ejected) {
+					/* if card is not ejected or safely
+					 * remove,then do force delink */
+					RTS51X_DEBUGP("False card inserted,"
+							"do force delink\n");
+					rts51x_auto_delink_force_cmd(chip);
+					chip->auto_delink_counter =
+					    chip->option.delink_delay * 2 + 1;
+				}
+			} else {
+				RTS51X_DEBUGP("No card inserted, do delink\n");
+				/* rts51x_write_register(chip, CARD_PWR_CTL,
+						DV3318_AUTO_PWR_OFF, 0); */
+				rts51x_auto_delink_cmd(chip);
+			}
+		}
+		if (chip->auto_delink_counter ==
+		    chip->option.delink_delay * 2) {
+			RTS51X_DEBUGP("Try to do force delink\n");
+			rts51x_auto_delink_force_cmd(chip);
+		}
+		chip->auto_delink_counter++;
+	}
+}
+
+static void rts51x_auto_delink(struct rts51x_chip *chip)
+{
+	rts51x_auto_delink_polling_cycle(chip);
+}
+#else
+/* some of called funcs are not implemented, so comment it out */
+static void rts51x_auto_delink(struct rts51x_chip *chip)
+{
+}
+#endif
+
+void rts51x_polling_func(struct rts51x_chip *chip)
+{
+
+	rts51x_init_cards(chip);
+
+#ifdef SUPPORT_OCP
+	/* if OCP happen and card exist, then close card OE */
+	if ((chip->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) &&
+			(chip->card_exist)) {
+
+		rts51x_prepare_run(chip);
+
+		if (chip->card_exist & SD_CARD)
+			rts51x_write_register(chip, CARD_OE, SD_OUTPUT_EN, 0);
+		else if (chip->card_exist & MS_CARD)
+			rts51x_write_register(chip, CARD_OE, MS_OUTPUT_EN, 0);
+		else if (chip->card_exist & XD_CARD)
+			rts51x_write_register(chip, CARD_OE, XD_OUTPUT_EN, 0);
+	}
+#endif
+
+	if (chip->idle_counter < IDLE_MAX_COUNT) {
+		chip->idle_counter++;
+	} else {
+		if (!RTS51X_CHK_STAT(chip, STAT_IDLE)) {
+			RTS51X_DEBUGP("Idle state!\n");
+			RTS51X_SET_STAT(chip, STAT_IDLE);
+			chip->led_toggle_counter = 0;
+			/* Idle state, turn off LED
+			 * to reduce power consumption */
+			if (chip->option.led_always_on
+			    && (chip->card_exist &
+				(SD_CARD | MS_CARD | XD_CARD))
+			    && (!chip->card_ejected)) {
+				rts51x_turn_on_led(chip, LED_GPIO);
+			} else {
+				if (chip->rts5179) {
+					rts51x_ep0_write_register(chip,
+								  CARD_GPIO,
+								  0x03, 0x00);
+				} else {
+					rts51x_turn_off_led(chip, LED_GPIO);
+				}
+
+			}
+
+#ifdef CLOSE_SSC_POWER
+			if (!chip->card_ready) {
+				rts51x_write_register(chip, CLK_DIV, CLK_CHANGE,
+						      CLK_CHANGE);
+				rts51x_write_register(chip, FPDCTL,
+						      SSC_POWER_MASK,
+						      SSC_POWER_DOWN);
+				RTS51X_DEBUGP("Close SSC clock power!\n");
+			}
+#endif
+		}
+	}
+
+	switch (RTS51X_GET_STAT(chip)) {
+	case STAT_RUN:
+		rts51x_blink_led(chip);
+		rts51x_do_remaining_work(chip);
+		break;
+
+	case STAT_IDLE:
+		break;
+
+	default:
+		break;
+	}
+
+	if (chip->option.auto_delink_en && !chip->card_ready)
+		rts51x_auto_delink(chip);
+	else
+		chip->auto_delink_counter = 0;
+}
+
+void rts51x_add_cmd(struct rts51x_chip *chip,
+		    u8 cmd_type, u16 reg_addr, u8 mask, u8 data)
+{
+	int i;
+
+	if (chip->cmd_idx < ((CMD_BUF_LEN - CMD_OFFSET) / 4)) {
+		i = CMD_OFFSET + chip->cmd_idx * 4;
+		chip->cmd_buf[i++] =
+		    ((cmd_type & 0x03) << 6) | (u8) ((reg_addr >> 8) & 0x3F);
+		chip->cmd_buf[i++] = (u8) reg_addr;
+		chip->cmd_buf[i++] = mask;
+		chip->cmd_buf[i++] = data;
+		chip->cmd_idx++;
+	}
+}
+
+int rts51x_send_cmd(struct rts51x_chip *chip, u8 flag, int timeout)
+{
+	int result;
+
+	chip->cmd_buf[CNT_H] = (u8) (chip->cmd_idx >> 8);
+	chip->cmd_buf[CNT_L] = (u8) (chip->cmd_idx);
+	chip->cmd_buf[STAGE_FLAG] = flag;
+
+	result = rts51x_transfer_data_rcc(chip, SND_BULK_PIPE(chip),
+					  (void *)(chip->cmd_buf),
+					  chip->cmd_idx * 4 + CMD_OFFSET,
+					  0, NULL, timeout, MODE_C);
+	if (result != STATUS_SUCCESS)
+		TRACE_RET(chip, result);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_get_rsp(struct rts51x_chip *chip, int rsp_len, int timeout)
+{
+	int result;
+
+	if (rsp_len <= 0)
+		TRACE_RET(chip, STATUS_ERROR);
+	/* rsp_len must aligned to dword */
+	if (rsp_len % 4)
+		rsp_len += (4 - rsp_len % 4);
+
+	result = rts51x_transfer_data_rcc(chip, RCV_BULK_PIPE(chip),
+					  (void *)chip->rsp_buf, rsp_len,
+					  0, NULL, timeout, STAGE_R);
+	if (result != STATUS_SUCCESS)
+		TRACE_RET(chip, result);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_get_card_status(struct rts51x_chip *chip, u16 *status)
+{
+	int retval;
+	u16 val;
+
+#ifdef GET_CARD_STATUS_USING_EPC
+	retval = rts51x_get_epc_status(chip, &val);
+
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+#else
+	retval = rts51x_ctrl_transfer(chip, RCV_CTRL_PIPE(chip), 0x02, 0xC0,
+				      0, 0, &val, 2, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+#endif
+
+	if (status)
+		*status = val;
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_write_register(struct rts51x_chip *chip, u16 addr, u8 mask, u8 data)
+{
+	int retval;
+
+	rts51x_init_cmd(chip);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, addr, mask, data);
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_read_register(struct rts51x_chip *chip, u16 addr, u8 *data)
+{
+	int retval;
+
+	if (data)
+		*data = 0;
+	rts51x_init_cmd(chip);
+	rts51x_add_cmd(chip, READ_REG_CMD, addr, 0, 0);
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	retval = rts51x_get_rsp(chip, 1, 100);
+
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if (data)
+		*data = chip->rsp_buf[0];
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_ep0_write_register(struct rts51x_chip *chip, u16 addr, u8 mask,
+			      u8 data)
+{
+	int retval;
+	u16 value = 0, index = 0;
+
+	value |= (u16) (3 & 0x03) << 14;
+	value |= (u16) (addr & 0x3FFF);
+	index |= (u16) mask << 8;
+	index |= (u16) data;
+
+	retval = rts51x_ctrl_transfer(chip, SND_CTRL_PIPE(chip), 0x00, 0x40,
+				      cpu_to_be16(value), cpu_to_be16(index),
+				      NULL, 0, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_ep0_read_register(struct rts51x_chip *chip, u16 addr, u8 *data)
+{
+	int retval;
+	u16 value = 0;
+	u8 val;
+
+	if (data)
+		*data = 0;
+
+	value |= (u16) (2 & 0x03) << 14;
+	value |= (u16) (addr & 0x3FFF);
+
+	retval = rts51x_ctrl_transfer(chip, RCV_CTRL_PIPE(chip), 0x00, 0xC0,
+				      cpu_to_be16(value), 0, &val, 1, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (data)
+		*data = val;
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_seq_write_register(struct rts51x_chip *chip, u16 addr, u16 len,
+			      u8 *data)
+{
+	int result;
+	u16 cmd_len = len + 12;
+
+	if (!data)
+		TRACE_RET(chip, STATUS_ERROR);
+
+	cmd_len = (cmd_len <= CMD_BUF_LEN) ? cmd_len : CMD_BUF_LEN;
+
+	/* cmd_len must aligned to dword */
+	if (cmd_len % 4)
+		cmd_len += (4 - cmd_len % 4);
+
+	chip->cmd_buf[0] = 'R';
+	chip->cmd_buf[1] = 'T';
+	chip->cmd_buf[2] = 'C';
+	chip->cmd_buf[3] = 'R';
+	chip->cmd_buf[PACKET_TYPE] = SEQ_WRITE;
+	chip->cmd_buf[5] = (u8) (len >> 8);
+	chip->cmd_buf[6] = (u8) len;
+	chip->cmd_buf[STAGE_FLAG] = 0;
+	chip->cmd_buf[8] = (u8) (addr >> 8);
+	chip->cmd_buf[9] = (u8) addr;
+
+	memcpy(chip->cmd_buf + 12, data, len);
+
+	result = rts51x_transfer_data_rcc(chip, SND_BULK_PIPE(chip),
+					  (void *)(chip->cmd_buf), cmd_len, 0,
+					  NULL, 100, MODE_C);
+	if (result != STATUS_SUCCESS)
+		TRACE_RET(chip, result);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_seq_read_register(struct rts51x_chip *chip, u16 addr, u16 len,
+			     u8 *data)
+{
+	int result;
+	u16 rsp_len;
+
+	if (!data)
+		TRACE_RET(chip, STATUS_ERROR);
+	/* rsp_len must aligned to dword */
+	if (len % 4)
+		rsp_len = len + (4 - len % 4);
+	else
+		rsp_len = len;
+
+	chip->cmd_buf[0] = 'R';
+	chip->cmd_buf[1] = 'T';
+	chip->cmd_buf[2] = 'C';
+	chip->cmd_buf[3] = 'R';
+	chip->cmd_buf[PACKET_TYPE] = SEQ_READ;
+	chip->cmd_buf[5] = (u8) (rsp_len >> 8);
+	chip->cmd_buf[6] = (u8) rsp_len;
+	chip->cmd_buf[STAGE_FLAG] = STAGE_R;
+	chip->cmd_buf[8] = (u8) (addr >> 8);
+	chip->cmd_buf[9] = (u8) addr;
+
+	result = rts51x_transfer_data_rcc(chip, SND_BULK_PIPE(chip),
+					  (void *)(chip->cmd_buf), 12, 0, NULL,
+					  100, MODE_C);
+	if (result != STATUS_SUCCESS)
+		TRACE_RET(chip, result);
+
+	result = rts51x_transfer_data_rcc(chip, RCV_BULK_PIPE(chip),
+					  (void *)data, rsp_len, 0, NULL, 100,
+					  STAGE_DI);
+	if (result != STATUS_SUCCESS)
+		TRACE_RET(chip, result);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_read_ppbuf(struct rts51x_chip *chip, u8 *buf, int buf_len)
+{
+	int retval;
+
+	if (!buf)
+		TRACE_RET(chip, STATUS_ERROR);
+
+	retval =
+	    rts51x_seq_read_register(chip, PPBUF_BASE2, (u16) buf_len, buf);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_write_ppbuf(struct rts51x_chip *chip, u8 *buf, int buf_len)
+{
+	int retval;
+
+	if (!buf)
+		TRACE_RET(chip, STATUS_ERROR);
+
+	retval =
+	    rts51x_seq_write_register(chip, PPBUF_BASE2, (u16) buf_len, buf);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_write_phy_register(struct rts51x_chip *chip, u8 addr, u8 val)
+{
+	int retval;
+
+	RTS51X_DEBUGP("Write 0x%x to phy register 0x%x\n", val, addr);
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VSTAIN, 0xFF, val);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VCONTROL, 0xFF, addr & 0x0F);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x01);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VCONTROL, 0xFF,
+		       (addr >> 4) & 0x0F);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x01);
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_read_phy_register(struct rts51x_chip *chip, u8 addr, u8 *val)
+{
+	int retval;
+
+	RTS51X_DEBUGP("Read from phy register 0x%x\n", addr);
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VCONTROL, 0xFF, 0x07);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x01);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VCONTROL, 0xFF,
+		       (addr >> 4) & 0x0F);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x01);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VCONTROL, 0xFF, addr & 0x0F);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, HS_VLOADM, 0xFF, 0x01);
+	rts51x_add_cmd(chip, READ_REG_CMD, HS_VSTAOUT, 0, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 1, 100);
+
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (val)
+		*val = chip->rsp_buf[0];
+
+	RTS51X_DEBUGP("Return value: 0x%x\n", chip->rsp_buf[0]);
+
+	return STATUS_SUCCESS;
+}
+
+void rts51x_do_before_power_down(struct rts51x_chip *chip)
+{
+	RTS51X_DEBUGP("rts51x_do_before_power_down\n");
+
+	rts51x_prepare_run(chip);
+
+	rts51x_release_cards(chip);
+	if (chip->rts5179)
+		rts51x_ep0_write_register(chip, CARD_GPIO, 0x03, 0x00);
+	else
+		rts51x_turn_off_led(chip, LED_GPIO);
+
+	chip->cur_clk = 0;
+	chip->card_exist = 0;
+	chip->cur_card = 0;
+	if (chip->asic_code) {
+		if (CHECK_PKG(chip, LQFP48)) {
+			rts51x_write_register(chip, CARD_PULL_CTL3, 0x80, 0x00);
+			rts51x_write_register(chip, CARD_PULL_CTL6, 0xf0, 0x50);
+		} else {
+			rts51x_write_register(chip, CARD_PULL_CTL1, 0x30, 0x10);
+			rts51x_write_register(chip, CARD_PULL_CTL3, 0x80, 0x00);
+			rts51x_write_register(chip, CARD_PULL_CTL6, 0x0c, 0x04);
+		}
+	}
+	if (CHECK_PKG(chip, LQFP48))
+		rts51x_write_register(chip, CARD_PWR_CTL, LDO3318_PWR_MASK,
+				      LDO_OFF);
+}
+
+void rts51x_clear_hw_error(struct rts51x_chip *chip)
+{
+	rts51x_ep0_write_register(chip, SFSM_ED, 0xf8, 0xf8);
+}
+
+void rts51x_prepare_run(struct rts51x_chip *chip)
+{
+#ifdef CLOSE_SSC_POWER
+	if (RTS51X_CHK_STAT(chip, STAT_IDLE) && (!chip->card_ready)) {
+		rts51x_write_register(chip, FPDCTL, SSC_POWER_MASK,
+				      SSC_POWER_ON);
+		udelay(100);
+		RTS51X_DEBUGP("Open SSC clock power.\n");
+
+		rts51x_write_register(chip, CLK_DIV, CLK_CHANGE, 0x00);
+	}
+#endif
+}
+
+#ifdef _MSG_TRACE
+void rts51x_trace_msg(struct rts51x_chip *chip, unsigned char *buf, int clear)
+{
+	unsigned char *ptr;
+	int i, msg_cnt;
+
+	if (!buf)
+		return;
+
+	ptr = buf;
+
+	if (chip->trace_msg[chip->msg_idx].valid)
+		msg_cnt = TRACE_ITEM_CNT;
+	else
+		msg_cnt = chip->msg_idx;
+	*(ptr++) = (u8) (msg_cnt >> 24);
+	*(ptr++) = (u8) (msg_cnt >> 16);
+	*(ptr++) = (u8) (msg_cnt >> 8);
+	*(ptr++) = (u8) msg_cnt;
+	RTS51X_DEBUGP("Trace message count is %d\n", msg_cnt);
+
+	for (i = 1; i <= msg_cnt; i++) {
+		int j, idx;
+
+		idx = chip->msg_idx - i;
+		if (idx < 0)
+			idx += TRACE_ITEM_CNT;
+
+		*(ptr++) = (u8) (chip->trace_msg[idx].line >> 8);
+		*(ptr++) = (u8) (chip->trace_msg[idx].line);
+		for (j = 0; j < MSG_FUNC_LEN; j++)
+			*(ptr++) = chip->trace_msg[idx].func[j];
+		for (j = 0; j < MSG_FILE_LEN; j++)
+			*(ptr++) = chip->trace_msg[idx].file[j];
+		for (j = 0; j < TIME_VAL_LEN; j++)
+			*(ptr++) = chip->trace_msg[idx].timeval_buf[j];
+	}
+
+	if (clear) {
+		chip->msg_idx = 0;
+		for (i = 0; i < TRACE_ITEM_CNT; i++)
+			chip->trace_msg[i].valid = 0;
+	}
+}
+#endif
+
+void rts51x_pp_status(struct rts51x_chip *chip, unsigned int lun, u8 *status,
+		      u8 status_len)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	struct ms_info *ms_card = &(chip->ms_card);
+	u8 card = rts51x_get_lun_card(chip, lun);
+#ifdef SUPPORT_OC
+	u8 oc_now_mask = 0, oc_ever_mask = 0;
+#endif
+
+	if (!status || (status_len < 32))
+		return;
+	/* IC Version */
+	status[0] = (u8) RTS51X_GET_PID(chip);
+	status[1] = (u8) (chip->ic_version);
+
+	/* Auto delink mode */
+	if (chip->option.auto_delink_en)
+		status[2] = 0x10;
+	else
+		status[2] = 0x00;
+
+	/* Spec version */
+	status[3] = 20;
+	status[4] = 10;
+	status[5] = 05;
+	status[6] = 21;
+
+	/* Card WP */
+	if (chip->card_wp)
+		status[7] = 0x20;
+	else
+		status[7] = 0x00;
+
+#ifdef SUPPORT_OC
+	/* Over current status */
+	status[8] = 0;
+	oc_now_mask = MS_OCP_NOW;
+	oc_ever_mask = MS_OCP_EVER;
+
+	if (chip->ocp_stat & oc_now_mask)
+		status[8] |= 0x02;
+	if (chip->ocp_stat & oc_ever_mask)
+		status[8] |= 0x01;
+#endif
+
+	if (card == SD_CARD) {
+		if (CHK_SD(sd_card)) {
+			if (CHK_SD_HCXC(sd_card)) {
+				if (sd_card->capacity > 0x4000000)
+					/* SDXC */
+					status[0x0E] = 0x02;
+				else /* SDHC */
+					status[0x0E] = 0x01;
+			} else { /* SDSC */
+				status[0x0E] = 0x00;
+			}
+
+			if (CHK_SD_SDR104(sd_card))
+				status[0x0F] = 0x03;
+			else if (CHK_SD_DDR50(sd_card))
+				status[0x0F] = 0x04;
+			else if (CHK_SD_SDR50(sd_card))
+				status[0x0F] = 0x02;
+			else if (CHK_SD_HS(sd_card))
+				status[0x0F] = 0x01;
+			else
+				status[0x0F] = 0x00; /* Normal speed */
+		} else {
+			if (CHK_MMC_SECTOR_MODE(sd_card))
+				status[0x0E] = 0x01; /* High capacity */
+			else
+				status[0x0E] = 0x00; /* Normal capacity */
+
+			if (CHK_MMC_DDR52(sd_card))
+				status[0x0F] = 0x03; /* DDR 52M */
+			else if (CHK_MMC_52M(sd_card))
+				status[0x0F] = 0x02; /* SDR 52M */
+			else if (CHK_MMC_26M(sd_card))
+				status[0x0F] = 0x01; /* SDR 26M */
+			else
+				status[0x0F] = 0x00; /* Normal speed */
+		}
+	} else if (card == MS_CARD) {
+		if (CHK_MSPRO(ms_card)) {
+			if (CHK_MSXC(ms_card))
+				status[0x0E] = 0x01; /* XC */
+			else
+				status[0x0E] = 0x00;
+
+			if (CHK_HG8BIT(ms_card))
+				status[0x0F] = 0x01;
+			else
+				status[0x0F] = 0x00;
+		}
+	}
+
+	/* Function 0
+	 * Support Magic Gate, CPRM and PhyRegister R/W */
+	status[0x18] = 0x8A;
+
+	/* Function 2
+	 * Support OC LUN status & WP LUN status */
+	status[0x1A] = 0x28;
+
+	/* Function 2
+	 * Support OC LUN status & WP LUN status */
+	status[0x1A] = 0x28;
+}
+
+void rts51x_read_status(struct rts51x_chip *chip, unsigned int lun,
+			u8 *rts51x_status, u8 status_len)
+{
+	if (!rts51x_status || (status_len < 16))
+		return;
+	/* VID */
+	rts51x_status[0] = (u8) (RTS51X_GET_VID(chip) >> 8);
+	rts51x_status[1] = (u8) RTS51X_GET_VID(chip);
+
+	/* PID */
+	rts51x_status[2] = (u8) (RTS51X_GET_PID(chip) >> 8);
+	rts51x_status[3] = (u8) RTS51X_GET_PID(chip);
+
+	/* gbLUN */
+	rts51x_status[4] = (u8) lun;
+
+	/* Lun Card Number */
+	if (chip->card_exist) {
+		if (chip->card_exist & XD_CARD)
+			rts51x_status[5] = 4; /* xD Card */
+		else if (chip->card_exist & SD_CARD)
+			rts51x_status[5] = 2; /* SD Card */
+		else if (chip->card_exist & MS_CARD)
+			rts51x_status[5] = 3; /* MS Card */
+		else
+			rts51x_status[5] = 7; /* Multi */
+	} else {
+		rts51x_status[5] = 7;	/* Multi */
+	}
+
+	/* Total LUNs */
+	rts51x_status[6] = 1;
+
+	/* IC Version */
+	rts51x_status[7] = (u8) RTS51X_GET_PID(chip);
+	rts51x_status[8] = chip->ic_version;
+
+	/* Physical Exist */
+	if (check_card_exist(chip, lun))
+		rts51x_status[9] = 1;
+	else
+		rts51x_status[9] = 0;
+
+	/* Multi Flag */
+	rts51x_status[10] = 1;
+
+	/* LUN Valid Map */
+	rts51x_status[11] = XD_CARD | SD_CARD | MS_CARD;
+
+	/* Logical Exist */
+	if (check_card_ready(chip, lun))
+		rts51x_status[12] = 1;
+	else
+		rts51x_status[12] = 0;
+
+	/* Detailed Type */
+	if (rts51x_get_lun_card(chip, lun) == XD_CARD) {
+		rts51x_status[13] = 0x40;
+	} else if (rts51x_get_lun_card(chip, lun) == SD_CARD) {
+		struct sd_info *sd_card = &(chip->sd_card);
+
+		rts51x_status[13] = 0x20;
+		if (CHK_SD(sd_card)) {
+			if (CHK_SD_HCXC(sd_card))
+				rts51x_status[13] |= 0x04; /* Hi capacity SD */
+			if (CHK_SD_HS(sd_card))
+				rts51x_status[13] |= 0x02; /* Hi speed SD */
+		} else {
+			rts51x_status[13] |= 0x08; /* MMC card */
+			if (CHK_MMC_52M(sd_card))
+				rts51x_status[13] |= 0x02; /* Hi speed */
+			if (CHK_MMC_SECTOR_MODE(sd_card))
+				rts51x_status[13] |= 0x04; /* Hi capacity */
+		}
+	} else if (rts51x_get_lun_card(chip, lun) == MS_CARD) {
+		struct ms_info *ms_card = &(chip->ms_card);
+
+		if (CHK_MSPRO(ms_card)) {
+			rts51x_status[13] = 0x38; /* MS Pro */
+			if (CHK_HG8BIT(ms_card))
+				rts51x_status[13] |= 0x04; /* HG */
+#ifdef SUPPORT_MSXC
+			if (CHK_MSXC(ms_card))
+				rts51x_status[13] |= 0x01; /* MSXC */
+#endif
+		} else {
+			rts51x_status[13] = 0x30;
+		}
+	} else {
+		rts51x_status[13] = 0x70;
+	}
+/* Support OC, auto delink, vendor r/w, get bus width */
+	rts51x_status[14] = 0x78;
+
+	rts51x_status[15] = 0x82;
+}
+
+int rts51x_transfer_data_rcc(struct rts51x_chip *chip, unsigned int pipe,
+			     void *buf, unsigned int len, int use_sg,
+			     unsigned int *act_len, int timeout, u8 stage_flag)
+{
+	int retval;
+
+	retval =
+	    rts51x_transfer_data(chip, pipe, buf, len, use_sg, act_len,
+				 timeout);
+
+	return retval;
+
+}
diff --git a/drivers/staging/rts5139/rts51x_chip.h b/drivers/staging/rts5139/rts51x_chip.h
new file mode 100644
index 000000000000..12deb24cfbbe
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_chip.h
@@ -0,0 +1,821 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_CHIP_H
+#define __RTS51X_CHIP_H
+
+#include <linux/usb.h>
+#include <linux/usb_usual.h>
+#include <linux/blkdev.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <scsi/scsi_host.h>
+
+#include "trace.h"
+
+#define SUPPORT_CPRM
+#define SUPPORT_MAGIC_GATE
+#define SUPPORT_MSXC
+#define USING_POLLING_CYCLE_DELINK
+
+#ifdef SUPPORT_MAGIC_GA
+/* Using NORMAL_WRITE instead of AUTO_WRITE to set ICVTE */
+#define MG_SET_ICV_SLOW
+#endif
+
+#ifdef SUPPORT_MSXC
+#define XC_POWERCLASS
+#define SUPPORT_PCGL_1P18
+#endif
+
+#define GET_CARD_STATUS_USING_EPC
+
+#define CLOSE_SSC_POWER
+
+#define SUPPORT_OCP
+
+#define MS_SPEEDUP
+
+#define SD_XD_IO_FOLLOW_PWR
+
+#define SD_NR		2
+#define MS_NR		3
+#define XD_NR		4
+#define SD_CARD		(1 << SD_NR)
+#define MS_CARD		(1 << MS_NR)
+#define XD_CARD		(1 << XD_NR)
+
+#define SD_CD		0x01
+#define MS_CD		0x02
+#define XD_CD		0x04
+#define SD_WP		0x08
+
+#define MAX_ALLOWED_LUN_CNT	8
+#define CMD_BUF_LEN		1024
+#define POLLING_INTERVAL	50	/* 50ms */
+
+#define XD_FREE_TABLE_CNT	1200
+#define MS_FREE_TABLE_CNT	512
+
+/* Bit Operation */
+#define SET_BIT(data, idx)	((data) |= 1 << (idx))
+#define CLR_BIT(data, idx)	((data) &= ~(1 << (idx)))
+#define CHK_BIT(data, idx)	((data) & (1 << (idx)))
+
+/* Command type */
+#define READ_REG_CMD		0
+#define WRITE_REG_CMD		1
+#define CHECK_REG_CMD		2
+
+#define PACKET_TYPE		4
+#define CNT_H			5
+#define CNT_L			6
+#define STAGE_FLAG		7
+#define CMD_OFFSET		8
+
+/* Packet type */
+#define BATCH_CMD		0
+#define SEQ_READ		1
+#define SEQ_WRITE		2
+
+/* Stage flag */
+#define STAGE_R			0x01
+#define STAGE_DI		0x02
+#define STAGE_DO		0x04
+/* Return MS_TRANS_CFG, GET_INT */
+#define STAGE_MS_STATUS		0x08
+/* Return XD_CFG, XD_CTL, XD_PAGE_STATUS */
+#define STAGE_XD_STATUS		0x10
+/* Command stage mode */
+#define MODE_C			0x00
+#define MODE_CR			(STAGE_R)
+#define MODE_CDIR		(STAGE_R | STAGE_DI)
+#define MODE_CDOR		(STAGE_R | STAGE_DO)
+
+/* Function return code */
+#ifndef STATUS_SUCCESS
+#define STATUS_SUCCESS		0
+#endif
+
+#define STATUS_FAIL		1
+#define STATUS_TIMEDOUT		4
+#define STATUS_NOMEM		5
+#define STATUS_TRANS_SHORT	6
+#define STATUS_TRANS_LONG	7
+#define STATUS_STALLED		8
+#define STATUS_ERROR		10
+
+#define IDLE_MAX_COUNT		10
+#define POLLING_WAIT_CNT	1
+#define LED_GPIO		0
+
+/* package */
+#define QFN24			0
+#define LQFP48			1
+
+#define USB_11			0
+#define USB_20			1
+
+/*
+ * Transport return codes
+ */
+/* Transport good, command good */
+#define TRANSPORT_GOOD		0
+/* Transport good, command failed */
+#define TRANSPORT_FAILED	1
+/* Transport bad (i.e. device dead) */
+#define TRANSPORT_ERROR		3
+
+/* Supported Clock */
+enum card_clock { CLK_20 = 1, CLK_30, CLK_40, CLK_50, CLK_60, CLK_80, CLK_100 };
+
+#ifdef _MSG_TRACE
+
+#define TRACE_ITEM_CNT		64
+
+struct trace_msg_t {
+	u16 line;
+#define MSG_FUNC_LEN 64
+	char func[MSG_FUNC_LEN];
+#define MSG_FILE_LEN 32
+	char file[MSG_FILE_LEN];
+#define TIME_VAL_LEN 16
+	u8 timeval_buf[TIME_VAL_LEN];
+	u8 valid;
+};
+
+#endif /* _MSG_TRACE */
+
+/* Size of the autosense data buffer */
+#define SENSE_SIZE		18
+
+/* Sense type */
+#define	SENSE_TYPE_NO_SENSE				0
+#define	SENSE_TYPE_MEDIA_CHANGE				1
+#define	SENSE_TYPE_MEDIA_NOT_PRESENT			2
+#define	SENSE_TYPE_MEDIA_LBA_OVER_RANGE			3
+#define	SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT		4
+#define	SENSE_TYPE_MEDIA_WRITE_PROTECT			5
+#define	SENSE_TYPE_MEDIA_INVALID_CMD_FIELD		6
+#define	SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR		7
+#define	SENSE_TYPE_MEDIA_WRITE_ERR			8
+#define SENSE_TYPE_FORMAT_CMD_FAILED			10
+#ifdef SUPPORT_MAGIC_GATE
+/* COPY PROTECTION KEY EXCHANGE FAILURE - KEY NOT ESTABLISHED */
+#define SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB		0x0b
+/* COPY PROTECTION KEY EXCHANGE FAILURE - AUTHENTICATION FAILURE */
+#define SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN		0x0c
+/* INCOMPATIBLE MEDIUM INSTALLED */
+#define SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM		0x0d
+/* WRITE ERROR */
+#define SENSE_TYPE_MG_WRITE_ERR				0x0e
+#endif
+
+/*---- sense key ----*/
+#define ILGAL_REQ               0x05	/* CDB/parameter/identify msg error */
+
+/*-----------------------------------
+    SENSE_DATA
+-----------------------------------*/
+
+/*---- error code ----*/
+#define CUR_ERR                 0x70	/* current error                    */
+
+/*---- sense key Information ----*/
+
+#define SKSV                    0x80
+#define CDB_ILLEGAL             0x40
+
+/*---- ASC ----*/
+#define ASC_INVLD_CDB           0x24
+
+/*---- ASQC ----*/
+#define ASCQ_INVLD_CDB          0x00
+
+struct sense_data_t {
+	unsigned char err_code;	/* error code */
+	/* bit7 : valid                    */
+	/*   (1 : SCSI2)                    */
+	/*   (0 : Vendor specific)          */
+	/* bit6-0 : error code             */
+	/*  (0x70 : current error)          */
+	/*  (0x71 : specific command error) */
+	unsigned char seg_no;	/* segment No.                      */
+	unsigned char sense_key;	/* byte5 : ILI                      */
+	/* bit3-0 : sense key              */
+	unsigned char info[4];	/* information                       */
+	unsigned char ad_sense_len;	/* additional sense data length     */
+	unsigned char cmd_info[4];	/* command specific information      */
+	unsigned char asc;	/* ASC                              */
+	unsigned char ascq;	/* ASCQ                             */
+	unsigned char rfu;	/* FRU                              */
+	unsigned char sns_key_info[3];	/* sense key specific information    */
+};
+
+/* sd_ctl bit map */
+/* SD push point control, bit 0, 1 */
+#define SD_PUSH_POINT_CTL_MASK		0x03
+#define SD_PUSH_POINT_DELAY		0x01
+#define SD_PUSH_POINT_AUTO		0x02
+/* SD sample point control, bit 2, 3 */
+#define SD_SAMPLE_POINT_CTL_MASK	0x0C
+#define SD_SAMPLE_POINT_DELAY		0x04
+#define SD_SAMPLE_POINT_AUTO		0x08
+/* SD DDR Tx phase set by user, bit 4 */
+#define SD_DDR_TX_PHASE_SET_BY_USER	0x10
+/* MMC DDR Tx phase set by user, bit 5 */
+#define MMC_DDR_TX_PHASE_SET_BY_USER	0x20
+/* Support MMC DDR mode, bit 6 */
+/*#define SUPPORT_MMC_DDR_MODE          0x40 */
+#define SUPPORT_UHS50_MMC44		0x40
+
+struct rts51x_option {
+	int rts51x_mspro_formatter_enable;
+
+	/* card clock expected by user for fpga platform */
+	int fpga_sd_sdr104_clk;
+	int fpga_sd_ddr50_clk;
+	int fpga_sd_sdr50_clk;
+	int fpga_sd_hs_clk;
+	int fpga_mmc_52m_clk;
+	int fpga_ms_hg_clk;
+	int fpga_ms_4bit_clk;
+
+	/* card clock expected by user for asic platform */
+	int asic_sd_sdr104_clk;
+	int asic_sd_ddr50_clk;
+	int asic_sd_sdr50_clk;
+	int asic_sd_hs_clk;
+	int asic_mmc_52m_clk;
+	int asic_ms_hg_clk;
+	int asic_ms_4bit_clk;
+
+	u8 ssc_depth_sd_sdr104;	/* sw */
+	u8 ssc_depth_sd_ddr50;	/* sw */
+	u8 ssc_depth_sd_sdr50;	/* sw */
+	u8 ssc_depth_sd_hs;	/* sw */
+	u8 ssc_depth_mmc_52m;	/* sw */
+	u8 ssc_depth_ms_hg;	/* sw */
+	u8 ssc_depth_ms_4bit;	/* sw */
+	u8 ssc_depth_low_speed;	/* sw */
+
+	/* SD/MMC Tx phase */
+	int sd_ddr_tx_phase;	/* Enabled by bit 4 of sd_ctl */
+	int mmc_ddr_tx_phase;	/* Enabled by bit 5 of sd_ctl */
+
+	/* priority of choosing sd speed funciton */
+	u32 sd_speed_prior;
+
+	/* sd card control */
+	u32 sd_ctl;
+
+	/* Enable Selective Suspend */
+	int ss_en;
+	/* Interval to enter SS from IDLE state (second) */
+	int ss_delay;
+
+	/* Enable SSC clock */
+	int ssc_en;
+
+	int auto_delink_en;
+
+	/* sangdy2010-07-13:add FT2 fast mode */
+	int FT2_fast_mode;
+	/* sangdy2010-07-15:
+	 * add for config delay between 1/4 PMOS and 3/4 PMOS */
+	int pwr_delay;
+
+	int rts51x_xd_rw_step;		/* add to tune xd tRP */
+	int D3318_off_delay;	/* add to tune D3318 off delay time */
+	int delink_delay;	/* add to tune delink delay time */
+	/* add for rts5129 to enable/disable D3318 off */
+	u8 rts5129_D3318_off_enable;
+	u8 sd20_pad_drive;	/* add to config SD20 PAD drive */
+	u8 sd30_pad_drive;	/* add to config SD30 pad drive */
+	/*if reset or rw fail,then set SD20 pad drive again */
+	u8 reset_or_rw_fail_set_pad_drive;
+
+	u8 debounce_num;	/* debounce number */
+	u8 led_toggle_interval;	/* used to control led toggle speed */
+	int rts51x_xd_rwn_step;
+	u8 sd_send_status_en;
+	/* used to store default phase which is
+	 * used when phase tune all pass. */
+	u8 ddr50_tx_phase;
+	u8 ddr50_rx_phase;
+	u8 sdr50_tx_phase;
+	u8 sdr50_rx_phase;
+	/* used to enable select sdr50 tx phase according to proportion. */
+	u8 sdr50_phase_sel;
+	u8 ms_errreg_fix;
+	u8 reset_mmc_first;
+	u8 speed_mmc;		/* when set, then try CMD55 only twice */
+	u8 led_always_on;	/* if set, then led always on when card exist */
+	u8 dv18_voltage;	/* add to tune dv18 voltage */
+};
+
+#define MS_FORMATTER_ENABLED(chip)	((chip)->option.rts51x_mspro_formatter_enable)
+
+struct rts51x_chip;
+
+typedef int (*rts51x_card_rw_func) (struct scsi_cmnd *srb, struct rts51x_chip *chip,
+			     u32 sec_addr, u16 sec_cnt);
+
+/* For MS Card */
+#define    MAX_DEFECTIVE_BLOCK     10
+
+struct zone_entry {
+	u16 *l2p_table;
+	u16 *free_table;
+	u16 defect_list[MAX_DEFECTIVE_BLOCK];	/* For MS card only */
+	int set_index;
+	int get_index;
+	int unused_blk_cnt;
+	int disable_count;
+	/* To indicate whether the L2P table of this zone has been built. */
+	int build_flag;
+};
+
+struct xd_delay_write_tag {
+	u32 old_phyblock;
+	u32 new_phyblock;
+	u32 logblock;
+	u8 pageoff;
+	u8 delay_write_flag;
+};
+
+struct xd_info {
+	u8 maker_code;
+	u8 device_code;
+	u8 block_shift;
+	u8 page_off;
+	u8 addr_cycle;
+	u16 cis_block;
+	u8 multi_flag;
+	u8 err_code;
+	u32 capacity;
+
+	struct zone_entry *zone;
+	int zone_cnt;
+
+	struct xd_delay_write_tag delay_write;
+
+	int counter;
+
+	int xd_clock;
+};
+
+#define TYPE_SD			0x0000
+#define TYPE_MMC		0x0001
+
+/* TYPE_SD */
+#define SD_HS			0x0100
+#define SD_SDR50		0x0200
+#define SD_DDR50		0x0400
+#define SD_SDR104		0x0800
+#define SD_HCXC			0x1000
+
+/* TYPE_MMC */
+#define MMC_26M			0x0100
+#define MMC_52M			0x0200
+#define MMC_4BIT		0x0400
+#define MMC_8BIT		0x0800
+#define MMC_SECTOR_MODE		0x1000
+#define MMC_DDR52		0x2000
+
+/* SD card */
+#define CHK_SD(sd_card)			(((sd_card)->sd_type & 0xFF) == TYPE_SD)
+#define CHK_SD_HS(sd_card)	\
+	(CHK_SD(sd_card) && ((sd_card)->sd_type & SD_HS))
+#define CHK_SD_SDR50(sd_card)		\
+	(CHK_SD(sd_card) && ((sd_card)->sd_type & SD_SDR50))
+#define CHK_SD_DDR50(sd_card)	\
+	(CHK_SD(sd_card) && ((sd_card)->sd_type & SD_DDR50))
+#define CHK_SD_SDR104(sd_card)	\
+	(CHK_SD(sd_card) && ((sd_card)->sd_type & SD_SDR104))
+#define CHK_SD_HCXC(sd_card)	\
+	(CHK_SD(sd_card) && ((sd_card)->sd_type & SD_HCXC))
+#define CHK_SD30_SPEED(sd_card)	\
+	(CHK_SD_SDR50(sd_card) || CHK_SD_DDR50(sd_card) ||\
+	 CHK_SD_SDR104(sd_card))
+
+#define SET_SD(sd_card)			((sd_card)->sd_type = TYPE_SD)
+#define SET_SD_HS(sd_card)		((sd_card)->sd_type |= SD_HS)
+#define SET_SD_SDR50(sd_card)		((sd_card)->sd_type |= SD_SDR50)
+#define SET_SD_DDR50(sd_card)		((sd_card)->sd_type |= SD_DDR50)
+#define SET_SD_SDR104(sd_card)		((sd_card)->sd_type |= SD_SDR104)
+#define SET_SD_HCXC(sd_card)		((sd_card)->sd_type |= SD_HCXC)
+
+#define CLR_SD_HS(sd_card)		((sd_card)->sd_type &= ~SD_HS)
+#define CLR_SD_SDR50(sd_card)		((sd_card)->sd_type &= ~SD_SDR50)
+#define CLR_SD_DDR50(sd_card)		((sd_card)->sd_type &= ~SD_DDR50)
+#define CLR_SD_SDR104(sd_card)		((sd_card)->sd_type &= ~SD_SDR104)
+#define CLR_SD_HCXC(sd_card)		((sd_card)->sd_type &= ~SD_HCXC)
+#define CLR_SD30_SPEED(sd_card)	\
+	((sd_card)->sd_type &= ~(SD_SDR50|SD_DDR50|SD_SDR104))
+
+/* MMC card */
+#define CHK_MMC(sd_card)	\
+	(((sd_card)->sd_type & 0xFF) == TYPE_MMC)
+#define CHK_MMC_26M(sd_card)	\
+	(CHK_MMC(sd_card) && ((sd_card)->sd_type & MMC_26M))
+#define CHK_MMC_52M(sd_card)	\
+	(CHK_MMC(sd_card) && ((sd_card)->sd_type & MMC_52M))
+#define CHK_MMC_4BIT(sd_card)	\
+	(CHK_MMC(sd_card) && ((sd_card)->sd_type & MMC_4BIT))
+#define CHK_MMC_8BIT(sd_card)	\
+	(CHK_MMC(sd_card) && ((sd_card)->sd_type & MMC_8BIT))
+#define CHK_MMC_SECTOR_MODE(sd_card)\
+	(CHK_MMC(sd_card) && ((sd_card)->sd_type & MMC_SECTOR_MODE))
+#define CHK_MMC_DDR52(sd_card)	\
+	(CHK_MMC(sd_card) && ((sd_card)->sd_type & MMC_DDR52))
+
+#define SET_MMC(sd_card)		((sd_card)->sd_type = TYPE_MMC)
+#define SET_MMC_26M(sd_card)		((sd_card)->sd_type |= MMC_26M)
+#define SET_MMC_52M(sd_card)		((sd_card)->sd_type |= MMC_52M)
+#define SET_MMC_4BIT(sd_card)		((sd_card)->sd_type |= MMC_4BIT)
+#define SET_MMC_8BIT(sd_card)		((sd_card)->sd_type |= MMC_8BIT)
+#define SET_MMC_SECTOR_MODE(sd_card)	((sd_card)->sd_type |= MMC_SECTOR_MODE)
+#define SET_MMC_DDR52(sd_card)		((sd_card)->sd_type |= MMC_DDR52)
+
+#define CLR_MMC_26M(sd_card)		((sd_card)->sd_type &= ~MMC_26M)
+#define CLR_MMC_52M(sd_card)		((sd_card)->sd_type &= ~MMC_52M)
+#define CLR_MMC_4BIT(sd_card)		((sd_card)->sd_type &= ~MMC_4BIT)
+#define CLR_MMC_8BIT(sd_card)		((sd_card)->sd_type &= ~MMC_8BIT)
+#define CLR_MMC_SECTOR_MODE(sd_card)	((sd_card)->sd_type &= ~MMC_SECTOR_MODE)
+#define CLR_MMC_DDR52(sd_card)		((sd_card)->sd_type &= ~MMC_DDR52)
+
+#define CHK_MMC_HS(sd_card)	\
+	(CHK_MMC_52M(sd_card) && CHK_MMC_26M(sd_card))
+#define CLR_MMC_HS(sd_card)			\
+do {						\
+	CLR_MMC_DDR52(sd_card);			\
+	CLR_MMC_52M(sd_card);			\
+	CLR_MMC_26M(sd_card);			\
+} while (0)
+
+#define SD_SUPPORT_CLASS_TEN		0x01
+#define SD_SUPPORT_1V8			0x02
+
+#define SD_SET_CLASS_TEN(sd_card)	\
+	((sd_card)->sd_setting |= SD_SUPPORT_CLASS_TEN)
+#define SD_CHK_CLASS_TEN(sd_card)	\
+	((sd_card)->sd_setting & SD_SUPPORT_CLASS_TEN)
+#define SD_CLR_CLASS_TEN(sd_card)	\
+	((sd_card)->sd_setting &= ~SD_SUPPORT_CLASS_TEN)
+#define SD_SET_1V8(sd_card)		\
+	((sd_card)->sd_setting |= SD_SUPPORT_1V8)
+#define SD_CHK_1V8(sd_card)		\
+	((sd_card)->sd_setting & SD_SUPPORT_1V8)
+#define SD_CLR_1V8(sd_card)		\
+	((sd_card)->sd_setting &= ~SD_SUPPORT_1V8)
+#define CLR_RETRY_SD20_MODE(sd_card)		\
+	((sd_card)->retry_SD20_mode = 0)
+#define SET_RETRY_SD20_MODE(sd_card)		\
+	((sd_card)->retry_SD20_mode = 1)
+#define CHK_RETRY_SD20_MODE(sd_card)		\
+	((sd_card)->retry_SD20_mode == 1)
+
+struct sd_info {
+	u16 sd_type;
+	u8 err_code;
+	u8 sd_data_buf_ready;
+	u32 sd_addr;
+	u32 capacity;
+
+	u8 raw_csd[16];
+	u8 raw_scr[8];
+
+	/* Sequential RW */
+	int seq_mode;
+	enum dma_data_direction pre_dir;
+	u32 pre_sec_addr;
+	u16 pre_sec_cnt;
+
+	int counter;
+
+	int sd_clock;
+
+#ifdef SUPPORT_CPRM
+	int sd_pass_thru_en;
+	int pre_cmd_err;
+	u8 last_rsp_type;
+	u8 rsp[17];
+#endif
+
+	u8 func_group1_mask;
+	u8 func_group2_mask;
+	u8 func_group3_mask;
+	u8 func_group4_mask;
+
+	u8 sd_switch_fail;
+	u8 sd_read_phase;
+	u8 retry_SD20_mode;	/* sangdy2010-06-10 */
+	u8 sd_reset_fail;	/* sangdy2010-07-01 */
+	u8 sd_send_status_en;
+
+};
+
+#define MODE_512_SEQ		0x01
+#define MODE_2K_SEQ		0x02
+
+#define TYPE_MS			0x0000
+#define TYPE_MSPRO		0x0001
+
+#define MS_4BIT			0x0100
+#define MS_8BIT			0x0200
+#define MS_HG			0x0400
+#define MS_XC			0x0800
+
+#define HG8BIT			(MS_HG | MS_8BIT)
+
+#define CHK_MSPRO(ms_card)	\
+	(((ms_card)->ms_type & 0xFF) == TYPE_MSPRO)
+#define CHK_HG8BIT(ms_card)	\
+	(CHK_MSPRO(ms_card) && (((ms_card)->ms_type & HG8BIT) == HG8BIT))
+#define CHK_MSXC(ms_card)	\
+	(CHK_MSPRO(ms_card) && ((ms_card)->ms_type & MS_XC))
+#define CHK_MSHG(ms_card)	\
+	(CHK_MSPRO(ms_card) && ((ms_card)->ms_type & MS_HG))
+
+#define CHK_MS8BIT(ms_card)	(((ms_card)->ms_type & MS_8BIT))
+#define CHK_MS4BIT(ms_card)	(((ms_card)->ms_type & MS_4BIT))
+
+struct rts51x_ms_delay_write_tag {
+	u16 old_phyblock;
+	u16 new_phyblock;
+	u16 logblock;
+	u8 pageoff;
+	u8 delay_write_flag;
+};
+
+struct ms_info {
+	u16 ms_type;
+	u8 block_shift;
+	u8 page_off;
+	u16 total_block;
+	u16 boot_block;
+	u32 capacity;
+
+	u8 check_ms_flow;
+	u8 switch_8bit_fail;
+	u8 err_code;
+
+	struct zone_entry *segment;
+	int segment_cnt;
+
+	int pro_under_formatting;
+	int format_status;
+	u16 progress;
+	u8 raw_sys_info[96];
+#ifdef SUPPORT_PCGL_1P18
+	u8 raw_model_name[48];
+#endif
+
+	u8 multi_flag;
+
+	/* Sequential RW */
+	u8 seq_mode;
+	enum dma_data_direction pre_dir;
+	u32 pre_sec_addr;
+	u16 pre_sec_cnt;
+	u32 total_sec_cnt;
+	u8 last_rw_int;
+
+	struct rts51x_ms_delay_write_tag delay_write;
+
+	int counter;
+
+	int ms_clock;
+
+#ifdef SUPPORT_MAGIC_GATE
+	u8 magic_gate_id[16];
+	u8 mg_entry_num;
+	int mg_auth;		/* flag to indicate authentication process */
+#endif
+};
+
+#define PRO_UNDER_FORMATTING(ms_card)		\
+	((ms_card)->pro_under_formatting)
+#define SET_FORMAT_STATUS(ms_card, status)	\
+	((ms_card)->format_status = (status))
+#define CHK_FORMAT_STATUS(ms_card, status)	\
+	((ms_card)->format_status == (status))
+
+struct scsi_cmnd;
+
+enum CHIP_STAT { STAT_INIT, STAT_IDLE, STAT_RUN, STAT_SS_PRE, STAT_SS,
+	    STAT_SUSPEND };
+
+struct rts51x_chip {
+	u16 vendor_id;
+	u16 product_id;
+	char max_lun;
+
+	struct scsi_cmnd *srb;
+	struct sense_data_t sense_buffer[MAX_ALLOWED_LUN_CNT];
+
+	int led_toggle_counter;
+
+	int ss_counter;
+	int idle_counter;
+	int auto_delink_counter;
+	enum CHIP_STAT chip_stat;
+
+	int resume_from_scsi;
+
+	/* Card information */
+	struct xd_info xd_card;
+	struct sd_info sd_card;
+	struct ms_info ms_card;
+
+	int cur_clk;		/* current card clock */
+	int cur_card;		/* Current card module */
+
+	u8 card_exist;		/* card exist bit map (physical exist) */
+	u8 card_ready;		/* card ready bit map (reset successfully) */
+	u8 card_fail;		/* card reset fail bit map */
+	u8 card_ejected;	/* card ejected bit map */
+	u8 card_wp;		/* card write protected bit map */
+
+	u8 fake_card_ready;
+	/* flag to indicate whether to answer MediaChange */
+	unsigned long lun_mc;
+
+	/* card bus width */
+	u8 card_bus_width[MAX_ALLOWED_LUN_CNT];
+	/* card capacity */
+	u32 capacity[MAX_ALLOWED_LUN_CNT];
+
+	/* read/write card function pointer */
+	rts51x_card_rw_func rw_card[MAX_ALLOWED_LUN_CNT];
+	/* read/write capacity, used for GPIO Toggle */
+	u32 rw_cap[MAX_ALLOWED_LUN_CNT];
+	/* card to lun mapping table */
+	u8 card2lun[32];
+	/* lun to card mapping table */
+	u8 lun2card[MAX_ALLOWED_LUN_CNT];
+
+#ifdef _MSG_TRACE
+	struct trace_msg_t trace_msg[TRACE_ITEM_CNT];
+	int msg_idx;
+#endif
+
+	int rw_need_retry;
+
+	/* ASIC or FPGA */
+	int asic_code;
+
+	/* QFN24 or LQFP48 */
+	int package;
+
+	/* Full Speed or High Speed */
+	int usb_speed;
+
+	/*sangdy:enable or disable UHS50 and MMC4.4 */
+	int uhs50_mmc44_en;
+
+	u8 ic_version;
+
+	/* Command buffer */
+	u8 *cmd_buf;
+	unsigned int cmd_idx;
+	/* Response buffer */
+	u8 *rsp_buf;
+
+	u16 card_status;
+
+#ifdef SUPPORT_OCP
+	u16 ocp_stat;
+#endif
+
+	struct rts51x_option option;
+	struct rts51x_usb *usb;
+
+	u8 rcc_read_response;
+	int reset_need_retry;
+	u8 rts5179;
+};
+
+#define UHS50_EN 0x0001
+#define UHS50_DIS 0x0000
+#define SET_UHS50(chip)   ((chip)->uhs50_mmc44_en = UHS50_EN)
+#define CLEAR_UHS50(chip)  ((chip)->uhs50_mmc44_en = UHS50_DIS)
+#define CHECK_UHS50(chip)  (((chip)->uhs50_mmc44_en&0xff) == UHS50_EN)
+
+#define RTS51X_GET_VID(chip)		((chip)->vendor_id)
+#define RTS51X_GET_PID(chip)		((chip)->product_id)
+
+#define RTS51X_SET_STAT(chip, stat)			\
+do {							\
+	if ((stat) != STAT_IDLE) {			\
+		(chip)->idle_counter = 0;		\
+	}						\
+	(chip)->chip_stat = (enum CHIP_STAT)(stat);	\
+} while (0)
+#define RTS51X_CHK_STAT(chip, stat)	((chip)->chip_stat == (stat))
+#define RTS51X_GET_STAT(chip)		((chip)->chip_stat)
+
+#define CHECK_PID(chip, pid)		(RTS51X_GET_PID(chip) == (pid))
+#define CHECK_PKG(chip, pkg)		((chip)->package == (pkg))
+#define CHECK_USB(chip, speed)		((chip)->usb_speed == (speed))
+
+int rts51x_reset_chip(struct rts51x_chip *chip);
+int rts51x_init_chip(struct rts51x_chip *chip);
+int rts51x_release_chip(struct rts51x_chip *chip);
+void rts51x_polling_func(struct rts51x_chip *chip);
+
+static inline void rts51x_init_cmd(struct rts51x_chip *chip)
+{
+	chip->cmd_idx = 0;
+	chip->cmd_buf[0] = 'R';
+	chip->cmd_buf[1] = 'T';
+	chip->cmd_buf[2] = 'C';
+	chip->cmd_buf[3] = 'R';
+	chip->cmd_buf[PACKET_TYPE] = BATCH_CMD;
+}
+
+void rts51x_add_cmd(struct rts51x_chip *chip,
+		    u8 cmd_type, u16 reg_addr, u8 mask, u8 data);
+int rts51x_send_cmd(struct rts51x_chip *chip, u8 flag, int timeout);
+int rts51x_get_rsp(struct rts51x_chip *chip, int rsp_len, int timeout);
+
+static inline void rts51x_read_rsp_buf(struct rts51x_chip *chip, int offset,
+				       u8 *buf, int buf_len)
+{
+	memcpy(buf, chip->rsp_buf + offset, buf_len);
+}
+
+static inline u8 *rts51x_get_rsp_data(struct rts51x_chip *chip)
+{
+	return chip->rsp_buf;
+}
+
+int rts51x_get_card_status(struct rts51x_chip *chip, u16 *status);
+int rts51x_write_register(struct rts51x_chip *chip, u16 addr, u8 mask, u8 data);
+int rts51x_read_register(struct rts51x_chip *chip, u16 addr, u8 *data);
+int rts51x_ep0_write_register(struct rts51x_chip *chip, u16 addr, u8 mask,
+			      u8 data);
+int rts51x_ep0_read_register(struct rts51x_chip *chip, u16 addr, u8 *data);
+int rts51x_seq_write_register(struct rts51x_chip *chip, u16 addr, u16 len,
+			      u8 *data);
+int rts51x_seq_read_register(struct rts51x_chip *chip, u16 addr, u16 len,
+			     u8 *data);
+int rts51x_read_ppbuf(struct rts51x_chip *chip, u8 *buf, int buf_len);
+int rts51x_write_ppbuf(struct rts51x_chip *chip, u8 *buf, int buf_len);
+int rts51x_write_phy_register(struct rts51x_chip *chip, u8 addr, u8 val);
+int rts51x_read_phy_register(struct rts51x_chip *chip, u8 addr, u8 *val);
+void rts51x_do_before_power_down(struct rts51x_chip *chip);
+void rts51x_clear_hw_error(struct rts51x_chip *chip);
+void rts51x_prepare_run(struct rts51x_chip *chip);
+void rts51x_trace_msg(struct rts51x_chip *chip, unsigned char *buf, int clear);
+void rts51x_pp_status(struct rts51x_chip *chip, unsigned int lun, u8 *status,
+		      u8 status_len);
+void rts51x_read_status(struct rts51x_chip *chip, unsigned int lun,
+			u8 *rts51x_status, u8 status_len);
+int rts51x_transfer_data_rcc(struct rts51x_chip *chip, unsigned int pipe,
+			     void *buf, unsigned int len, int use_sg,
+			     unsigned int *act_len, int timeout, u8 stage_flag);
+
+#define RTS51X_WRITE_REG(chip, addr, mask, data)	\
+do {							\
+	int _retval = rts51x_write_register((chip),	\
+			(addr), (mask), (data));	\
+	if (_retval != STATUS_SUCCESS) {		\
+		TRACE_RET((chip), _retval);		\
+	}						\
+} while (0)
+
+#define RTS51X_READ_REG(chip, addr, data)		\
+do {							\
+	int _retval = rts51x_read_register((chip),	\
+			(addr), (data));		\
+	if (_retval != STATUS_SUCCESS) {		\
+		TRACE_RET((chip), _retval);		\
+	}						\
+} while (0)
+
+#endif /* __RTS51X_CHIP_H */
diff --git a/drivers/staging/rts5139/rts51x_fop.c b/drivers/staging/rts5139/rts51x_fop.c
new file mode 100644
index 000000000000..cf4e675aea69
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_fop.c
@@ -0,0 +1,295 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include "rts51x.h"
+
+#ifdef SUPPORT_FILE_OP
+
+#include <linux/types.h>
+#include <linux/stat.h>
+#include <linux/kref.h>
+#include <linux/slab.h>
+
+#include "rts51x_chip.h"
+#include "rts51x_card.h"
+#include "rts51x_fop.h"
+#include "sd_cprm.h"
+
+#define RTS5139_IOC_MAGIC		0x39
+
+#define RTS5139_IOC_SD_DIRECT		_IOWR(RTS5139_IOC_MAGIC, 0xA0, int)
+#define RTS5139_IOC_SD_GET_RSP		_IOWR(RTS5139_IOC_MAGIC, 0xA1, int)
+
+static int rts51x_sd_direct_cmnd(struct rts51x_chip *chip,
+				 struct sd_direct_cmnd *cmnd)
+{
+	int retval;
+	u8 dir, cmd12, standby, acmd, cmd_idx, rsp_code;
+	u8 *buf;
+	u32 arg, len;
+
+	dir = (cmnd->cmnd[0] >> 3) & 0x03;
+	cmd12 = (cmnd->cmnd[0] >> 2) & 0x01;
+	standby = (cmnd->cmnd[0] >> 1) & 0x01;
+	acmd = cmnd->cmnd[0] & 0x01;
+	cmd_idx = cmnd->cmnd[1];
+	arg = ((u32) (cmnd->cmnd[2]) << 24) | ((u32) (cmnd->cmnd[3]) << 16) |
+	    ((u32) (cmnd->cmnd[4]) << 8) | cmnd->cmnd[5];
+	len =
+	    ((u32) (cmnd->cmnd[6]) << 16) | ((u32) (cmnd->cmnd[7]) << 8) |
+	    cmnd->cmnd[8];
+	rsp_code = cmnd->cmnd[9];
+
+	if (dir) {
+		if (!cmnd->buf || (cmnd->buf_len < len))
+			TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	switch (dir) {
+	case 0:
+		/* No data */
+		retval = ext_rts51x_sd_execute_no_data(chip,
+						chip->card2lun[SD_CARD],
+						cmd_idx, standby, acmd,
+						rsp_code, arg);
+		if (retval != TRANSPORT_GOOD)
+			TRACE_RET(chip, STATUS_FAIL);
+		break;
+
+	case 1:
+		/* Read from card */
+		buf = kzalloc(cmnd->buf_len, GFP_KERNEL);
+		if (!buf)
+			TRACE_RET(chip, STATUS_NOMEM);
+
+		retval = ext_rts51x_sd_execute_read_data(chip,
+						chip->card2lun[SD_CARD],
+						cmd_idx, cmd12, standby, acmd,
+						rsp_code, arg, len, buf,
+						cmnd->buf_len, 0);
+		if (retval != TRANSPORT_GOOD) {
+			kfree(buf);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		retval =
+		    copy_to_user(cmnd->buf, (void *)buf, cmnd->buf_len);
+		if (retval) {
+			kfree(buf);
+			TRACE_RET(chip, STATUS_NOMEM);
+		}
+
+		kfree(buf);
+		break;
+
+	case 2:
+		/* Write to card */
+		buf = kmalloc(cmnd->buf_len, GFP_KERNEL);
+		if (!buf)
+			TRACE_RET(chip, STATUS_NOMEM);
+
+		retval =
+		    copy_from_user((void *)buf, cmnd->buf,
+				   cmnd->buf_len);
+		if (retval) {
+			kfree(buf);
+			TRACE_RET(chip, STATUS_NOMEM);
+		}
+
+		retval =
+		    ext_rts51x_sd_execute_write_data(chip,
+						chip->card2lun[SD_CARD],
+						cmd_idx, cmd12, standby, acmd,
+						rsp_code, arg, len, buf,
+						cmnd->buf_len, 0);
+		if (retval != TRANSPORT_GOOD) {
+			kfree(buf);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		kfree(buf);
+
+		break;
+
+	default:
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int rts51x_sd_get_rsp(struct rts51x_chip *chip, struct sd_rsp *rsp)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int count = 0, retval;
+
+	if (sd_card->pre_cmd_err) {
+		sd_card->pre_cmd_err = 0;
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (sd_card->last_rsp_type == SD_RSP_TYPE_R0)
+		TRACE_RET(chip, STATUS_FAIL);
+	else if (sd_card->last_rsp_type == SD_RSP_TYPE_R2)
+		count = (rsp->rsp_len < 17) ? rsp->rsp_len : 17;
+	else
+		count = (rsp->rsp_len < 6) ? rsp->rsp_len : 6;
+
+	retval = copy_to_user(rsp->rsp, (void *)sd_card->rsp, count);
+	if (retval)
+		TRACE_RET(chip, STATUS_NOMEM);
+
+	RTS51X_DEBUGP("Response length: %d\n", count);
+	RTS51X_DEBUGP("Response: 0x%x 0x%x 0x%x 0x%x\n",
+		       sd_card->rsp[0], sd_card->rsp[1], sd_card->rsp[2],
+		       sd_card->rsp[3]);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_open(struct inode *inode, struct file *filp)
+{
+	struct rts51x_chip *chip;
+	struct usb_interface *interface;
+	int subminor;
+	int retval = 0;
+
+	subminor = iminor(inode);
+
+	interface = usb_find_interface(&rts51x_driver, subminor);
+	if (!interface) {
+		RTS51X_DEBUGP("%s - error, can't find device for minor %d\n",
+			       __func__, subminor);
+		retval = -ENODEV;
+		goto exit;
+	}
+
+	chip = (struct rts51x_chip *)usb_get_intfdata(interface);
+	if (!chip) {
+		RTS51X_DEBUGP("Can't find chip\n");
+		retval = -ENODEV;
+		goto exit;
+	}
+
+	/* Increase our reference to the host */
+	scsi_host_get(rts51x_to_host(chip));
+
+	/* lock the device pointers */
+	mutex_lock(&(chip->usb->dev_mutex));
+
+	/* save our object in the file's private structure */
+	filp->private_data = chip;
+
+	/* unlock the device pointers */
+	mutex_unlock(&chip->usb->dev_mutex);
+
+exit:
+	return retval;
+}
+
+int rts51x_release(struct inode *inode, struct file *filp)
+{
+	struct rts51x_chip *chip;
+
+	chip = (struct rts51x_chip *)filp->private_data;
+	if (chip == NULL)
+		return -ENODEV;
+
+	/* Drop our reference to the host; the SCSI core will free it
+	 * (and "chip" along with it) when the refcount becomes 0. */
+	scsi_host_put(rts51x_to_host(chip));
+
+	return 0;
+}
+
+ssize_t rts51x_read(struct file *filp, char __user *buf, size_t count,
+		    loff_t *f_pos)
+{
+	return 0;
+}
+
+ssize_t rts51x_write(struct file *filp, const char __user *buf, size_t count,
+		     loff_t *f_pos)
+{
+	return 0;
+}
+
+long rts51x_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct rts51x_chip *chip;
+	struct sd_direct_cmnd cmnd;
+	struct sd_rsp rsp;
+	int retval = 0;
+
+	chip = (struct rts51x_chip *)filp->private_data;
+	if (chip == NULL)
+		return -ENODEV;
+
+	/* lock the device pointers */
+	mutex_lock(&(chip->usb->dev_mutex));
+
+	switch (cmd) {
+	case RTS5139_IOC_SD_DIRECT:
+		retval =
+		    copy_from_user((void *)&cmnd, (void __user *)arg,
+				   sizeof(struct sd_direct_cmnd));
+		if (retval) {
+			retval = -ENOMEM;
+			TRACE_GOTO(chip, exit);
+		}
+		retval = rts51x_sd_direct_cmnd(chip, &cmnd);
+		if (retval != STATUS_SUCCESS) {
+			retval = -EIO;
+			TRACE_GOTO(chip, exit);
+		}
+		break;
+
+	case RTS5139_IOC_SD_GET_RSP:
+		retval =
+		    copy_from_user(&rsp, (void __user *)arg,
+				   sizeof(struct sd_rsp));
+		if (retval) {
+			retval = -ENOMEM;
+			TRACE_GOTO(chip, exit);
+		}
+		retval = rts51x_sd_get_rsp(chip, &rsp);
+		if (retval != STATUS_SUCCESS) {
+			retval = -EIO;
+			TRACE_GOTO(chip, exit);
+		}
+		break;
+
+	default:
+		break;
+	}
+
+exit:
+	/* unlock the device pointers */
+	mutex_unlock(&chip->usb->dev_mutex);
+
+	return retval;
+}
+
+#endif
diff --git a/drivers/staging/rts5139/rts51x_fop.h b/drivers/staging/rts5139/rts51x_fop.h
new file mode 100644
index 000000000000..c691ee99720e
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_fop.h
@@ -0,0 +1,57 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_FOP_H
+#define __RTS51X_FOP_H
+
+#include "rts51x.h"
+
+#ifdef SUPPORT_FILE_OP
+
+#include <linux/fs.h>
+#include <linux/types.h>
+
+struct sd_direct_cmnd {
+	u8 cmnd[12];
+	void __user *buf;
+	int buf_len;
+};
+
+struct sd_rsp {
+	void __user *rsp;
+	int rsp_len;
+};
+
+int rts51x_open(struct inode *inode, struct file *filp);
+int rts51x_release(struct inode *inode, struct file *filp);
+ssize_t rts51x_read(struct file *filp, char __user *buf, size_t count,
+		    loff_t *f_pos);
+ssize_t rts51x_write(struct file *filp, const char __user *buf, size_t count,
+		     loff_t *f_pos);
+long rts51x_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+
+#endif
+
+#endif /* __RTS51X_FOP_H */
diff --git a/drivers/staging/rts5139/rts51x_scsi.c b/drivers/staging/rts5139/rts51x_scsi.c
new file mode 100644
index 000000000000..75282fea38f7
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_scsi.c
@@ -0,0 +1,2135 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/export.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_device.h>
+
+#include "debug.h"
+#include "rts51x.h"
+#include "rts51x_chip.h"
+#include "rts51x_scsi.h"
+#include "rts51x_card.h"
+#include "rts51x_transport.h"
+#include "sd_cprm.h"
+#include "ms_mg.h"
+#include "trace.h"
+
+void rts51x_scsi_show_command(struct scsi_cmnd *srb)
+{
+	char *what = NULL;
+	int i, unknown_cmd = 0;
+
+	switch (srb->cmnd[0]) {
+	case TEST_UNIT_READY:
+		what = (char *)"TEST_UNIT_READY";
+		break;
+	case REZERO_UNIT:
+		what = (char *)"REZERO_UNIT";
+		break;
+	case REQUEST_SENSE:
+		what = (char *)"REQUEST_SENSE";
+		break;
+	case FORMAT_UNIT:
+		what = (char *)"FORMAT_UNIT";
+		break;
+	case READ_BLOCK_LIMITS:
+		what = (char *)"READ_BLOCK_LIMITS";
+		break;
+	case 0x07:
+		what = (char *)"REASSIGN_BLOCKS";
+		break;
+	case READ_6:
+		what = (char *)"READ_6";
+		break;
+	case WRITE_6:
+		what = (char *)"WRITE_6";
+		break;
+	case SEEK_6:
+		what = (char *)"SEEK_6";
+		break;
+	case READ_REVERSE:
+		what = (char *)"READ_REVERSE";
+		break;
+	case WRITE_FILEMARKS:
+		what = (char *)"WRITE_FILEMARKS";
+		break;
+	case SPACE:
+		what = (char *)"SPACE";
+		break;
+	case INQUIRY:
+		what = (char *)"INQUIRY";
+		break;
+	case RECOVER_BUFFERED_DATA:
+		what = (char *)"RECOVER_BUFFERED_DATA";
+		break;
+	case MODE_SELECT:
+		what = (char *)"MODE_SELECT";
+		break;
+	case RESERVE:
+		what = (char *)"RESERVE";
+		break;
+	case RELEASE:
+		what = (char *)"RELEASE";
+		break;
+	case COPY:
+		what = (char *)"COPY";
+		break;
+	case ERASE:
+		what = (char *)"ERASE";
+		break;
+	case MODE_SENSE:
+		what = (char *)"MODE_SENSE";
+		break;
+	case START_STOP:
+		what = (char *)"START_STOP";
+		break;
+	case RECEIVE_DIAGNOSTIC:
+		what = (char *)"RECEIVE_DIAGNOSTIC";
+		break;
+	case SEND_DIAGNOSTIC:
+		what = (char *)"SEND_DIAGNOSTIC";
+		break;
+	case ALLOW_MEDIUM_REMOVAL:
+		what = (char *)"ALLOW_MEDIUM_REMOVAL";
+		break;
+	case SET_WINDOW:
+		what = (char *)"SET_WINDOW";
+		break;
+	case READ_CAPACITY:
+		what = (char *)"READ_CAPACITY";
+		break;
+	case READ_10:
+		what = (char *)"READ_10";
+		break;
+	case WRITE_10:
+		what = (char *)"WRITE_10";
+		break;
+	case SEEK_10:
+		what = (char *)"SEEK_10";
+		break;
+	case WRITE_VERIFY:
+		what = (char *)"WRITE_VERIFY";
+		break;
+	case VERIFY:
+		what = (char *)"VERIFY";
+		break;
+	case SEARCH_HIGH:
+		what = (char *)"SEARCH_HIGH";
+		break;
+	case SEARCH_EQUAL:
+		what = (char *)"SEARCH_EQUAL";
+		break;
+	case SEARCH_LOW:
+		what = (char *)"SEARCH_LOW";
+		break;
+	case SET_LIMITS:
+		what = (char *)"SET_LIMITS";
+		break;
+	case READ_POSITION:
+		what = (char *)"READ_POSITION";
+		break;
+	case SYNCHRONIZE_CACHE:
+		what = (char *)"SYNCHRONIZE_CACHE";
+		break;
+	case LOCK_UNLOCK_CACHE:
+		what = (char *)"LOCK_UNLOCK_CACHE";
+		break;
+	case READ_DEFECT_DATA:
+		what = (char *)"READ_DEFECT_DATA";
+		break;
+	case MEDIUM_SCAN:
+		what = (char *)"MEDIUM_SCAN";
+		break;
+	case COMPARE:
+		what = (char *)"COMPARE";
+		break;
+	case COPY_VERIFY:
+		what = (char *)"COPY_VERIFY";
+		break;
+	case WRITE_BUFFER:
+		what = (char *)"WRITE_BUFFER";
+		break;
+	case READ_BUFFER:
+		what = (char *)"READ_BUFFER";
+		break;
+	case UPDATE_BLOCK:
+		what = (char *)"UPDATE_BLOCK";
+		break;
+	case READ_LONG:
+		what = (char *)"READ_LONG";
+		break;
+	case WRITE_LONG:
+		what = (char *)"WRITE_LONG";
+		break;
+	case CHANGE_DEFINITION:
+		what = (char *)"CHANGE_DEFINITION";
+		break;
+	case WRITE_SAME:
+		what = (char *)"WRITE_SAME";
+		break;
+	case GPCMD_READ_SUBCHANNEL:
+		what = (char *)"READ SUBCHANNEL";
+		break;
+	case READ_TOC:
+		what = (char *)"READ_TOC";
+		break;
+	case GPCMD_READ_HEADER:
+		what = (char *)"READ HEADER";
+		break;
+	case GPCMD_PLAY_AUDIO_10:
+		what = (char *)"PLAY AUDIO (10)";
+		break;
+	case GPCMD_PLAY_AUDIO_MSF:
+		what = (char *)"PLAY AUDIO MSF";
+		break;
+	case GPCMD_GET_EVENT_STATUS_NOTIFICATION:
+		what = (char *)"GET EVENT/STATUS NOTIFICATION";
+		break;
+	case GPCMD_PAUSE_RESUME:
+		what = (char *)"PAUSE/RESUME";
+		break;
+	case LOG_SELECT:
+		what = (char *)"LOG_SELECT";
+		break;
+	case LOG_SENSE:
+		what = (char *)"LOG_SENSE";
+		break;
+	case GPCMD_STOP_PLAY_SCAN:
+		what = (char *)"STOP PLAY/SCAN";
+		break;
+	case GPCMD_READ_DISC_INFO:
+		what = (char *)"READ DISC INFORMATION";
+		break;
+	case GPCMD_READ_TRACK_RZONE_INFO:
+		what = (char *)"READ TRACK INFORMATION";
+		break;
+	case GPCMD_RESERVE_RZONE_TRACK:
+		what = (char *)"RESERVE TRACK";
+		break;
+	case GPCMD_SEND_OPC:
+		what = (char *)"SEND OPC";
+		break;
+	case MODE_SELECT_10:
+		what = (char *)"MODE_SELECT_10";
+		break;
+	case GPCMD_REPAIR_RZONE_TRACK:
+		what = (char *)"REPAIR TRACK";
+		break;
+	case 0x59:
+		what = (char *)"READ MASTER CUE";
+		break;
+	case MODE_SENSE_10:
+		what = (char *)"MODE_SENSE_10";
+		break;
+	case GPCMD_CLOSE_TRACK:
+		what = (char *)"CLOSE TRACK/SESSION";
+		break;
+	case 0x5C:
+		what = (char *)"READ BUFFER CAPACITY";
+		break;
+	case 0x5D:
+		what = (char *)"SEND CUE SHEET";
+		break;
+	case GPCMD_BLANK:
+		what = (char *)"BLANK";
+		break;
+	case REPORT_LUNS:
+		what = (char *)"REPORT LUNS";
+		break;
+	case MOVE_MEDIUM:
+		what = (char *)"MOVE_MEDIUM or PLAY AUDIO (12)";
+		break;
+	case READ_12:
+		what = (char *)"READ_12";
+		break;
+	case WRITE_12:
+		what = (char *)"WRITE_12";
+		break;
+	case WRITE_VERIFY_12:
+		what = (char *)"WRITE_VERIFY_12";
+		break;
+	case SEARCH_HIGH_12:
+		what = (char *)"SEARCH_HIGH_12";
+		break;
+	case SEARCH_EQUAL_12:
+		what = (char *)"SEARCH_EQUAL_12";
+		break;
+	case SEARCH_LOW_12:
+		what = (char *)"SEARCH_LOW_12";
+		break;
+	case SEND_VOLUME_TAG:
+		what = (char *)"SEND_VOLUME_TAG";
+		break;
+	case READ_ELEMENT_STATUS:
+		what = (char *)"READ_ELEMENT_STATUS";
+		break;
+	case GPCMD_READ_CD_MSF:
+		what = (char *)"READ CD MSF";
+		break;
+	case GPCMD_SCAN:
+		what = (char *)"SCAN";
+		break;
+	case GPCMD_SET_SPEED:
+		what = (char *)"SET CD SPEED";
+		break;
+	case GPCMD_MECHANISM_STATUS:
+		what = (char *)"MECHANISM STATUS";
+		break;
+	case GPCMD_READ_CD:
+		what = (char *)"READ CD";
+		break;
+	case 0xE1:
+		what = (char *)"WRITE CONTINUE";
+		break;
+	case WRITE_LONG_2:
+		what = (char *)"WRITE_LONG_2";
+		break;
+	case VENDOR_CMND:
+		what = (char *)"Realtek's vendor command";
+		break;
+	default:
+		what = (char *)"(unknown command)";
+		unknown_cmd = 1;
+		break;
+	}
+
+	if (srb->cmnd[0] != TEST_UNIT_READY)
+		RTS51X_DEBUGP("Command %s (%d bytes)\n", what, srb->cmd_len);
+	if (unknown_cmd) {
+		RTS51X_DEBUGP("");
+		for (i = 0; i < srb->cmd_len && i < 16; i++)
+			RTS51X_DEBUGPN(" %02x", srb->cmnd[i]);
+		RTS51X_DEBUGPN("\n");
+	}
+}
+
+void rts51x_set_sense_type(struct rts51x_chip *chip, unsigned int lun, int sense_type)
+{
+	switch (sense_type) {
+	case SENSE_TYPE_MEDIA_CHANGE:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x06, 0, 0x28, 0, 0, 0);
+		break;
+
+	case SENSE_TYPE_MEDIA_NOT_PRESENT:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x02, 0, 0x3A, 0, 0, 0);
+		break;
+
+	case SENSE_TYPE_MEDIA_LBA_OVER_RANGE:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x05, 0, 0x21, 0, 0, 0);
+		break;
+
+	case SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x05, 0, 0x25, 0, 0, 0);
+		break;
+
+	case SENSE_TYPE_MEDIA_WRITE_PROTECT:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x07, 0, 0x27, 0, 0, 0);
+		break;
+
+	case SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x03, 0, 0x11, 0, 0, 0);
+		break;
+
+	case SENSE_TYPE_MEDIA_WRITE_ERR:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x03, 0, 0x0C, 0x02, 0, 0);
+		break;
+
+	case SENSE_TYPE_MEDIA_INVALID_CMD_FIELD:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, ILGAL_REQ, 0,
+			       ASC_INVLD_CDB, ASCQ_INVLD_CDB, CDB_ILLEGAL, 1);
+		break;
+
+	case SENSE_TYPE_FORMAT_CMD_FAILED:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x03, 0, 0x31, 0x01, 0, 0);
+		break;
+
+#ifdef SUPPORT_MAGIC_GATE
+	case SENSE_TYPE_MG_KEY_FAIL_NOT_ESTAB:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x05, 0, 0x6F, 0x02, 0, 0);
+		break;
+
+	case SENSE_TYPE_MG_KEY_FAIL_NOT_AUTHEN:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x05, 0, 0x6F, 0x00, 0, 0);
+		break;
+
+	case SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x02, 0, 0x30, 0x00, 0, 0);
+		break;
+
+	case SENSE_TYPE_MG_WRITE_ERR:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0x03, 0, 0x0C, 0x00, 0, 0);
+		break;
+#endif
+
+	case SENSE_TYPE_NO_SENSE:
+	default:
+		rts51x_set_sense_data(chip, lun, CUR_ERR, 0, 0, 0, 0, 0, 0);
+		break;
+	}
+}
+
+void rts51x_set_sense_data(struct rts51x_chip *chip, unsigned int lun, u8 err_code,
+		    u8 sense_key, u32 info, u8 asc, u8 ascq, u8 sns_key_info0,
+		    u16 sns_key_info1)
+{
+	struct sense_data_t *sense = &(chip->sense_buffer[lun]);
+
+	sense->err_code = err_code;
+	sense->sense_key = sense_key;
+	sense->info[0] = (u8) (info >> 24);
+	sense->info[1] = (u8) (info >> 16);
+	sense->info[2] = (u8) (info >> 8);
+	sense->info[3] = (u8) info;
+
+	sense->ad_sense_len = sizeof(struct sense_data_t) - 8;
+	sense->asc = asc;
+	sense->ascq = ascq;
+	if (sns_key_info0 != 0) {
+		sense->sns_key_info[0] = SKSV | sns_key_info0;
+		sense->sns_key_info[1] = (sns_key_info1 & 0xf0) >> 8;
+		sense->sns_key_info[2] = sns_key_info1 & 0x0f;
+	}
+}
+
+static int test_unit_ready(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+
+	rts51x_init_cards(chip);
+
+	if (!check_card_ready(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		return TRANSPORT_FAILED;
+	}
+
+	if (!check_lun_mc(chip, lun)) {
+		set_lun_mc(chip, lun);
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
+		return TRANSPORT_FAILED;
+	}
+
+	return TRANSPORT_GOOD;
+}
+
+static unsigned char formatter_inquiry_str[20] = {
+	'M', 'E', 'M', 'O', 'R', 'Y', 'S', 'T', 'I', 'C', 'K',
+	'-', 'M', 'G',		/* Byte[47:49] */
+	0x0B,			/* Byte[50]: MG, MS, MSPro, MSXC */
+	0x00,			/* Byte[51]: Category Specific Commands */
+	0x00,			/* Byte[52]: Access Control and feature */
+	0x20, 0x20, 0x20,	/* Byte[53:55] */
+};
+
+static int inquiry(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+	char *inquiry_default = (char *)"Generic-xD/SD/M.S.      1.00 ";
+	char *inquiry_string;
+	unsigned char sendbytes;
+	unsigned char *buf;
+	u8 card = rts51x_get_lun_card(chip, lun);
+	int pro_formatter_flag = 0;
+	unsigned char inquiry_buf[] = {
+		QULIFIRE | DRCT_ACCESS_DEV,
+		RMB_DISC | 0x0D,
+		0x00,
+		0x01,
+		0x1f,
+		0x02,
+		0,
+		REL_ADR | WBUS_32 | WBUS_16 | SYNC | LINKED | CMD_QUE | SFT_RE,
+	};
+
+	inquiry_string = inquiry_default;
+
+	buf = vmalloc(scsi_bufflen(srb));
+	if (buf == NULL)
+		TRACE_RET(chip, TRANSPORT_ERROR);
+
+	if (MS_FORMATTER_ENABLED(chip) && (get_lun2card(chip, lun) & MS_CARD)) {
+		if (!card || (card == MS_CARD))
+			pro_formatter_flag = 1;
+	}
+
+	if (pro_formatter_flag) {
+		if (scsi_bufflen(srb) < 56)
+			sendbytes = (unsigned char)(scsi_bufflen(srb));
+		else
+			sendbytes = 56;
+	} else {
+		if (scsi_bufflen(srb) < 36)
+			sendbytes = (unsigned char)(scsi_bufflen(srb));
+		else
+			sendbytes = 36;
+	}
+
+	if (sendbytes > 8) {
+		memcpy(buf, inquiry_buf, 8);
+		memcpy(buf + 8, inquiry_string, sendbytes - 8);
+		if (pro_formatter_flag)
+			buf[4] = 0x33;	/* Additional Length */
+	} else {
+		memcpy(buf, inquiry_buf, sendbytes);
+	}
+
+	if (pro_formatter_flag) {
+		if (sendbytes > 36)
+			memcpy(buf + 36, formatter_inquiry_str, sendbytes - 36);
+	}
+
+	scsi_set_resid(srb, 0);
+
+	rts51x_set_xfer_buf(buf, scsi_bufflen(srb), srb);
+	vfree(buf);
+
+	return TRANSPORT_GOOD;
+}
+
+static int start_stop_unit(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+
+	scsi_set_resid(srb, scsi_bufflen(srb));
+
+	if (srb->cmnd[1] == 1)
+		return TRANSPORT_GOOD;
+
+	switch (srb->cmnd[0x4]) {
+	case STOP_MEDIUM:
+		/* Media disabled */
+		return TRANSPORT_GOOD;
+
+	case UNLOAD_MEDIUM:
+		/* Media shall be unload */
+		if (check_card_ready(chip, lun))
+			rts51x_eject_card(chip, lun);
+		return TRANSPORT_GOOD;
+
+	case MAKE_MEDIUM_READY:
+	case LOAD_MEDIUM:
+		if (check_card_ready(chip, lun)) {
+			return TRANSPORT_GOOD;
+		} else {
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+
+		break;
+	}
+
+	TRACE_RET(chip, TRANSPORT_ERROR);
+}
+
+static int allow_medium_removal(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int prevent;
+
+	prevent = srb->cmnd[4] & 0x1;
+
+	scsi_set_resid(srb, 0);
+
+	if (prevent) {
+		rts51x_set_sense_type(chip, SCSI_LUN(srb),
+			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	return TRANSPORT_GOOD;
+}
+
+static void ms_mode_sense(struct rts51x_chip *chip, u8 cmd,
+			  int lun, u8 *buf, int buf_len)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	int sys_info_offset;
+	int data_size = buf_len;
+	int support_format = 0;
+	int i = 0;
+
+	if (cmd == MODE_SENSE) {
+		sys_info_offset = 8;
+		if (data_size > 0x68)
+			data_size = 0x68;
+		buf[i++] = 0x67;	/* Mode Data Length */
+	} else {
+		sys_info_offset = 12;
+		if (data_size > 0x6C)
+			data_size = 0x6C;
+		buf[i++] = 0x00;	/* Mode Data Length (MSB) */
+		buf[i++] = 0x6A;	/* Mode Data Length (LSB) */
+	}
+
+	/* Medium Type Code */
+	if (check_card_ready(chip, lun)) {
+		if (CHK_MSXC(ms_card)) {
+			support_format = 1;
+			buf[i++] = 0x40;
+		} else if (CHK_MSPRO(ms_card)) {
+			support_format = 1;
+			buf[i++] = 0x20;
+		} else {
+			buf[i++] = 0x10;
+		}
+
+		/* WP */
+		if (check_card_wp(chip, lun))
+			buf[i++] = 0x80;
+		else
+			buf[i++] = 0x00;
+	} else {
+		buf[i++] = 0x00;	/* MediaType */
+		buf[i++] = 0x00;	/* WP */
+	}
+
+	buf[i++] = 0x00;	/* Reserved */
+
+	if (cmd == MODE_SENSE_10) {
+		buf[i++] = 0x00;	/* Reserved */
+		buf[i++] = 0x00;	/* Block descriptor length(MSB) */
+		buf[i++] = 0x00;	/* Block descriptor length(LSB) */
+
+		/* The Following Data is the content of "Page 0x20" */
+		if (data_size >= 9)
+			buf[i++] = 0x20;	/* Page Code */
+		if (data_size >= 10)
+			buf[i++] = 0x62;	/* Page Length */
+		if (data_size >= 11)
+			buf[i++] = 0x00;	/* No Access Control */
+		if (data_size >= 12) {
+			if (support_format)
+				buf[i++] = 0xC0;	/* SF, SGM */
+			else
+				buf[i++] = 0x00;
+		}
+	} else {
+		/* The Following Data is the content of "Page 0x20" */
+		if (data_size >= 5)
+			buf[i++] = 0x20;	/* Page Code */
+		if (data_size >= 6)
+			buf[i++] = 0x62;	/* Page Length */
+		if (data_size >= 7)
+			buf[i++] = 0x00;	/* No Access Control */
+		if (data_size >= 8) {
+			if (support_format)
+				buf[i++] = 0xC0;	/* SF, SGM */
+			else
+				buf[i++] = 0x00;
+		}
+	}
+
+	if (data_size > sys_info_offset) {
+		/* 96 Bytes Attribute Data */
+		int len = data_size - sys_info_offset;
+		len = (len < 96) ? len : 96;
+
+		memcpy(buf + sys_info_offset, ms_card->raw_sys_info, len);
+	}
+}
+
+static int mode_sense(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+	unsigned int dataSize;
+	int status;
+	int pro_formatter_flag;
+	unsigned char pageCode, *buf;
+	u8 card = rts51x_get_lun_card(chip, lun);
+
+	if (!check_card_ready(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		scsi_set_resid(srb, scsi_bufflen(srb));
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	pro_formatter_flag = 0;
+	dataSize = 8;
+	/* In Combo mode, device responses ModeSense command as a MS LUN
+	 * when no card is inserted */
+	if ((get_lun2card(chip, lun) & MS_CARD)) {
+		if (!card || (card == MS_CARD)) {
+			dataSize = 108;
+			if (chip->option.rts51x_mspro_formatter_enable)
+				pro_formatter_flag = 1;
+		}
+	}
+
+	buf = kmalloc(dataSize, GFP_KERNEL);
+	if (buf == NULL)
+		TRACE_RET(chip, TRANSPORT_ERROR);
+
+	pageCode = srb->cmnd[2] & 0x3f;
+
+	if ((pageCode == 0x3F) || (pageCode == 0x1C) ||
+	    (pageCode == 0x00) || (pro_formatter_flag && (pageCode == 0x20))) {
+		if (srb->cmnd[0] == MODE_SENSE) {
+			if ((pageCode == 0x3F) || (pageCode == 0x20)) {
+				ms_mode_sense(chip, srb->cmnd[0], lun, buf,
+					      dataSize);
+			} else {
+				dataSize = 4;
+				buf[0] = 0x03;
+				buf[1] = 0x00;
+				if (check_card_wp(chip, lun))
+					buf[2] = 0x80;
+				else
+				buf[3] = 0x00;
+			}
+		} else {
+			if ((pageCode == 0x3F) || (pageCode == 0x20)) {
+				ms_mode_sense(chip, srb->cmnd[0], lun, buf,
+					      dataSize);
+			} else {
+				dataSize = 8;
+				buf[0] = 0x00;
+				buf[1] = 0x06;
+				buf[2] = 0x00;
+				if (check_card_wp(chip, lun))
+					buf[3] = 0x80;
+				else
+					buf[3] = 0x00;
+				buf[4] = 0x00;
+				buf[5] = 0x00;
+				buf[6] = 0x00;
+				buf[7] = 0x00;
+			}
+		}
+		status = TRANSPORT_GOOD;
+	} else {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		scsi_set_resid(srb, scsi_bufflen(srb));
+		status = TRANSPORT_FAILED;
+	}
+
+	if (status == TRANSPORT_GOOD) {
+		unsigned int len = min(scsi_bufflen(srb), dataSize);
+		rts51x_set_xfer_buf(buf, len, srb);
+		scsi_set_resid(srb, scsi_bufflen(srb) - len);
+	}
+	kfree(buf);
+
+	return status;
+}
+
+static int request_sense(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct sense_data_t *sense;
+	unsigned int lun = SCSI_LUN(srb);
+	struct ms_info *ms_card = &(chip->ms_card);
+	unsigned char *tmp, *buf;
+
+	sense = &(chip->sense_buffer[lun]);
+
+	if ((rts51x_get_lun_card(chip, lun) == MS_CARD)
+	    && PRO_UNDER_FORMATTING(ms_card)) {
+		rts51x_mspro_format_sense(chip, lun);
+	}
+
+	buf = vmalloc(scsi_bufflen(srb));
+	if (buf == NULL)
+		TRACE_RET(chip, TRANSPORT_ERROR);
+
+	tmp = (unsigned char *)sense;
+	memcpy(buf, tmp, scsi_bufflen(srb));
+
+	rts51x_set_xfer_buf(buf, scsi_bufflen(srb), srb);
+	vfree(buf);
+
+	scsi_set_resid(srb, 0);
+	/* Reset Sense Data */
+	rts51x_set_sense_type(chip, lun, SENSE_TYPE_NO_SENSE);
+	return TRANSPORT_GOOD;
+}
+
+static int read_write(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+	int retval;
+	u32 start_sec;
+	u16 sec_cnt;
+
+	if (!check_card_ready(chip, lun) || (chip->capacity[lun] == 0)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (!check_lun_mc(chip, lun)) {
+		set_lun_mc(chip, lun);
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
+		return TRANSPORT_FAILED;
+	}
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	if ((srb->cmnd[0] == READ_10) || (srb->cmnd[0] == WRITE_10)) {
+		start_sec =
+		    ((u32) srb->cmnd[2] << 24) |
+		    ((u32) srb->cmnd[3] << 16) |
+		    ((u32) srb->cmnd[4] << 8) |
+		    ((u32) srb->cmnd[5]);
+		sec_cnt = ((u16) (srb->cmnd[7]) << 8) | srb->cmnd[8];
+	} else if ((srb->cmnd[0] == READ_6) || (srb->cmnd[0] == WRITE_6)) {
+		start_sec = ((u32) (srb->cmnd[1] & 0x1F) << 16) |
+		    ((u32) srb->cmnd[2] << 8) | ((u32) srb->cmnd[3]);
+		sec_cnt = srb->cmnd[4];
+	} else if ((srb->cmnd[0] == VENDOR_CMND) &&
+			(srb->cmnd[1] == SCSI_APP_CMD) &&
+			((srb->cmnd[2] == PP_READ10) ||
+			 (srb->cmnd[2] == PP_WRITE10))) {
+		start_sec = ((u32) srb->cmnd[4] << 24) |
+			((u32) srb->cmnd[5] << 16) |
+			((u32) srb->cmnd[6] << 8) |
+			((u32) srb->cmnd[7]);
+		sec_cnt = ((u16) (srb->cmnd[9]) << 8) | srb->cmnd[10];
+	} else {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if ((start_sec > chip->capacity[lun]) ||
+	    ((start_sec + sec_cnt) > chip->capacity[lun])) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LBA_OVER_RANGE);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (sec_cnt == 0) {
+		scsi_set_resid(srb, 0);
+		return TRANSPORT_GOOD;
+	}
+
+	if ((srb->sc_data_direction == DMA_TO_DEVICE)
+	    && check_card_wp(chip, lun)) {
+		RTS51X_DEBUGP("Write protected card!\n");
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_PROTECT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	retval = rts51x_card_rw(srb, chip, start_sec, sec_cnt);
+	if (retval != STATUS_SUCCESS) {
+		if (srb->sc_data_direction == DMA_FROM_DEVICE) {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+		} else {
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_ERR);
+		}
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	scsi_set_resid(srb, 0);
+
+	return TRANSPORT_GOOD;
+}
+
+static int read_format_capacity(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned char *buf;
+	unsigned int lun = SCSI_LUN(srb);
+	unsigned int buf_len;
+	u8 card = rts51x_get_lun_card(chip, lun);
+	int desc_cnt;
+	int i = 0;
+
+	if (!check_card_ready(chip, lun)) {
+		if (!chip->option.rts51x_mspro_formatter_enable) {
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+	}
+
+	buf_len = (scsi_bufflen(srb) > 12) ? 0x14 : 12;
+
+	buf = kmalloc(buf_len, GFP_KERNEL);
+	if (buf == NULL)
+		TRACE_RET(chip, TRANSPORT_ERROR);
+
+	buf[i++] = 0;
+	buf[i++] = 0;
+	buf[i++] = 0;
+
+	/* Capacity List Length */
+	if ((buf_len > 12) && chip->option.rts51x_mspro_formatter_enable &&
+	    (chip->lun2card[lun] & MS_CARD) && (!card || (card == MS_CARD))) {
+		buf[i++] = 0x10;
+		desc_cnt = 2;
+	} else {
+		buf[i++] = 0x08;
+		desc_cnt = 1;
+	}
+
+	while (desc_cnt) {
+		if (check_card_ready(chip, lun)) {
+			buf[i++] = (unsigned char)((chip->capacity[lun]) >> 24);
+			buf[i++] = (unsigned char)((chip->capacity[lun]) >> 16);
+			buf[i++] = (unsigned char)((chip->capacity[lun]) >> 8);
+			buf[i++] = (unsigned char)(chip->capacity[lun]);
+
+			if (desc_cnt == 2)
+				/* Byte[8]: Descriptor Type: Formatted medium */
+				buf[i++] = 2;
+			else
+				buf[i++] = 0;	/* Byte[16] */
+		} else {
+			buf[i++] = 0xFF;
+			buf[i++] = 0xFF;
+			buf[i++] = 0xFF;
+			buf[i++] = 0xFF;
+
+			if (desc_cnt == 2)
+				/* Byte[8]: Descriptor Type: No medium */
+				buf[i++] = 3;
+			else
+				buf[i++] = 0;	/*Byte[16] */
+		}
+
+		buf[i++] = 0x00;
+		buf[i++] = 0x02;
+		buf[i++] = 0x00;
+
+		desc_cnt--;
+	}
+
+	buf_len = min(scsi_bufflen(srb), buf_len);
+	rts51x_set_xfer_buf(buf, buf_len, srb);
+	kfree(buf);
+
+	scsi_set_resid(srb, scsi_bufflen(srb) - buf_len);
+
+	return TRANSPORT_GOOD;
+}
+
+static int read_capacity(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned char *buf;
+	unsigned int lun = SCSI_LUN(srb);
+
+	if (!check_card_ready(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (!check_lun_mc(chip, lun)) {
+		set_lun_mc(chip, lun);
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
+		return TRANSPORT_FAILED;
+	}
+
+	buf = kmalloc(8, GFP_KERNEL);
+	if (buf == NULL)
+		TRACE_RET(chip, TRANSPORT_ERROR);
+
+	buf[0] = (unsigned char)((chip->capacity[lun] - 1) >> 24);
+	buf[1] = (unsigned char)((chip->capacity[lun] - 1) >> 16);
+	buf[2] = (unsigned char)((chip->capacity[lun] - 1) >> 8);
+	buf[3] = (unsigned char)(chip->capacity[lun] - 1);
+
+	buf[4] = 0x00;
+	buf[5] = 0x00;
+	buf[6] = 0x02;
+	buf[7] = 0x00;
+
+	rts51x_set_xfer_buf(buf, scsi_bufflen(srb), srb);
+	kfree(buf);
+
+	scsi_set_resid(srb, 0);
+
+	return TRANSPORT_GOOD;
+}
+
+static int get_dev_status(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+	unsigned int buf_len;
+	u8 status[32] = { 0 };
+
+	rts51x_pp_status(chip, lun, status, 32);
+
+	buf_len = min_t(unsigned int, scsi_bufflen(srb), sizeof(status));
+	rts51x_set_xfer_buf(status, buf_len, srb);
+	scsi_set_resid(srb, scsi_bufflen(srb) - buf_len);
+
+	return TRANSPORT_GOOD;
+}
+
+static int read_status(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	u8 rts51x_status[16];
+	unsigned int buf_len;
+	unsigned int lun = SCSI_LUN(srb);
+
+	rts51x_read_status(chip, lun, rts51x_status, 16);
+
+	buf_len = min_t(unsigned int, scsi_bufflen(srb), sizeof(rts51x_status));
+	rts51x_set_xfer_buf(rts51x_status, buf_len, srb);
+	scsi_set_resid(srb, scsi_bufflen(srb) - buf_len);
+
+	return TRANSPORT_GOOD;
+}
+
+static int read_mem(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+	unsigned short addr, len, i;
+	int retval;
+	u8 *buf;
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	addr = ((u16) srb->cmnd[2] << 8) | srb->cmnd[3];
+	len = ((u16) srb->cmnd[4] << 8) | srb->cmnd[5];
+
+	if (addr < 0xe000) {
+		RTS51X_DEBUGP("filter!addr=0x%x\n", addr);
+		return TRANSPORT_GOOD;
+	}
+
+	buf = vmalloc(len);
+	if (!buf)
+		TRACE_RET(chip, TRANSPORT_ERROR);
+
+	for (i = 0; i < len; i++) {
+		retval = rts51x_ep0_read_register(chip, addr + i, buf + i);
+		if (retval != STATUS_SUCCESS) {
+			vfree(buf);
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+	}
+
+	len = (unsigned short)min(scsi_bufflen(srb), (unsigned int)len);
+	rts51x_set_xfer_buf(buf, len, srb);
+	scsi_set_resid(srb, scsi_bufflen(srb) - len);
+
+	vfree(buf);
+
+	return TRANSPORT_GOOD;
+}
+
+static int write_mem(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+	unsigned short addr, len, i;
+	int retval;
+	u8 *buf;
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	addr = ((u16) srb->cmnd[2] << 8) | srb->cmnd[3];
+	len = ((u16) srb->cmnd[4] << 8) | srb->cmnd[5];
+
+	if (addr < 0xe000) {
+		RTS51X_DEBUGP("filter!addr=0x%x\n", addr);
+		return TRANSPORT_GOOD;
+	}
+
+	len = (unsigned short)min(scsi_bufflen(srb), (unsigned int)len);
+	buf = vmalloc(len);
+	if (!buf)
+		TRACE_RET(chip, TRANSPORT_ERROR);
+
+	rts51x_get_xfer_buf(buf, len, srb);
+
+	for (i = 0; i < len; i++) {
+		retval =
+		    rts51x_ep0_write_register(chip, addr + i, 0xFF, buf[i]);
+		if (retval != STATUS_SUCCESS) {
+			vfree(buf);
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_ERR);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+	}
+
+	vfree(buf);
+	scsi_set_resid(srb, scsi_bufflen(srb) - len);
+
+	return TRANSPORT_GOOD;
+}
+
+static int get_sd_csd(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	unsigned int lun = SCSI_LUN(srb);
+
+	if (!check_card_ready(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (rts51x_get_lun_card(chip, lun) != SD_CARD) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	scsi_set_resid(srb, 0);
+	rts51x_set_xfer_buf(sd_card->raw_csd, scsi_bufflen(srb), srb);
+
+	return TRANSPORT_GOOD;
+}
+
+static int read_phy_register(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int retval;
+	u8 addr, len, i;
+	u8 *buf;
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	addr = srb->cmnd[5];
+	len = srb->cmnd[7];
+
+	if (len) {
+		buf = vmalloc(len);
+		if (!buf)
+			TRACE_RET(chip, TRANSPORT_ERROR);
+
+		for (i = 0; i < len; i++) {
+			retval =
+			    rts51x_read_phy_register(chip, addr + i, buf + i);
+			if (retval != STATUS_SUCCESS) {
+				vfree(buf);
+				rts51x_set_sense_type(chip, SCSI_LUN(srb),
+					SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+				TRACE_RET(chip, TRANSPORT_FAILED);
+			}
+		}
+
+		len = min(scsi_bufflen(srb), (unsigned int)len);
+		rts51x_set_xfer_buf(buf, len, srb);
+		scsi_set_resid(srb, scsi_bufflen(srb) - len);
+
+		vfree(buf);
+	}
+
+	return TRANSPORT_GOOD;
+}
+
+static int write_phy_register(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int retval;
+	u8 addr, len, i;
+	u8 *buf;
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	addr = srb->cmnd[5];
+	len = srb->cmnd[7];
+
+	if (len) {
+		len = min(scsi_bufflen(srb), (unsigned int)len);
+
+		buf = vmalloc(len);
+		if (buf == NULL)
+			TRACE_RET(chip, TRANSPORT_ERROR);
+
+		rts51x_get_xfer_buf(buf, len, srb);
+		scsi_set_resid(srb, scsi_bufflen(srb) - len);
+
+		for (i = 0; i < len; i++) {
+			retval =
+			    rts51x_write_phy_register(chip, addr + i, buf[i]);
+			if (retval != STATUS_SUCCESS) {
+				vfree(buf);
+				rts51x_set_sense_type(chip, SCSI_LUN(srb),
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, TRANSPORT_FAILED);
+			}
+		}
+
+		vfree(buf);
+	}
+
+	return TRANSPORT_GOOD;
+}
+
+static int get_card_bus_width(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+	u8 card, bus_width;
+
+	if (!check_card_ready(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	card = rts51x_get_lun_card(chip, lun);
+	if ((card == SD_CARD) || (card == MS_CARD)) {
+		bus_width = chip->card_bus_width[lun];
+	} else {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	scsi_set_resid(srb, 0);
+	rts51x_set_xfer_buf(&bus_width, scsi_bufflen(srb), srb);
+
+	return TRANSPORT_GOOD;
+}
+
+#ifdef _MSG_TRACE
+static int trace_msg_cmd(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned char *buf = NULL;
+	u8 clear;
+	unsigned int buf_len;
+
+	buf_len =
+	    4 +
+	    ((2 + MSG_FUNC_LEN + MSG_FILE_LEN + TIME_VAL_LEN) * TRACE_ITEM_CNT);
+
+	if ((scsi_bufflen(srb) < buf_len) || (scsi_sglist(srb) == NULL)) {
+		rts51x_set_sense_type(chip, SCSI_LUN(srb),
+			       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	clear = srb->cmnd[2];
+
+	buf = vmalloc(scsi_bufflen(srb));
+	if (buf == NULL)
+		TRACE_RET(chip, TRANSPORT_ERROR);
+
+	rts51x_trace_msg(chip, buf, clear);
+
+	rts51x_set_xfer_buf(buf, scsi_bufflen(srb), srb);
+	vfree(buf);
+
+	scsi_set_resid(srb, 0);
+	return TRANSPORT_GOOD;
+}
+#endif
+
+static int rw_mem_cmd_buf(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int retval = STATUS_SUCCESS;
+	unsigned int lun = SCSI_LUN(srb);
+	u8 cmd_type, mask, value, idx, mode, len;
+	u16 addr;
+	u32 timeout;
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	switch (srb->cmnd[3]) {
+	case INIT_BATCHCMD:
+		rts51x_init_cmd(chip);
+		break;
+
+	case ADD_BATCHCMD:
+		cmd_type = srb->cmnd[4];
+		if (cmd_type > 2) {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		addr = (srb->cmnd[5] << 8) | srb->cmnd[6];
+		mask = srb->cmnd[7];
+		value = srb->cmnd[8];
+		rts51x_add_cmd(chip, cmd_type, addr, mask, value);
+		break;
+
+	case SEND_BATCHCMD:
+		mode = srb->cmnd[4];
+		len = srb->cmnd[5];
+		timeout =
+		    ((u32) srb->cmnd[6] << 24) | ((u32) srb->
+						  cmnd[7] << 16) | ((u32) srb->
+								    cmnd[8] <<
+								    8) | ((u32)
+									  srb->
+									  cmnd
+									  [9]);
+		retval = rts51x_send_cmd(chip, mode, 1000);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_ERR);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		if (mode & STAGE_R) {
+			retval = rts51x_get_rsp(chip, len, timeout);
+			if (retval != STATUS_SUCCESS) {
+				rts51x_set_sense_type(chip, lun,
+					SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+				TRACE_RET(chip, TRANSPORT_FAILED);
+			}
+		}
+		break;
+
+	case GET_BATCHRSP:
+		idx = srb->cmnd[4];
+		value = chip->rsp_buf[idx];
+		if (scsi_bufflen(srb) < 1) {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		rts51x_set_xfer_buf(&value, 1, srb);
+		scsi_set_resid(srb, 0);
+		break;
+
+	default:
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_ERR);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	return TRANSPORT_GOOD;
+}
+
+static int suit_cmd(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int result;
+
+	switch (srb->cmnd[3]) {
+	case INIT_BATCHCMD:
+	case ADD_BATCHCMD:
+	case SEND_BATCHCMD:
+	case GET_BATCHRSP:
+		result = rw_mem_cmd_buf(srb, chip);
+		break;
+	default:
+		result = TRANSPORT_ERROR;
+	}
+
+	return result;
+}
+
+static int app_cmd(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int result;
+
+	switch (srb->cmnd[2]) {
+	case PP_READ10:
+	case PP_WRITE10:
+		result = read_write(srb, chip);
+		break;
+
+	case SUIT_CMD:
+		result = suit_cmd(srb, chip);
+		break;
+
+	case READ_PHY:
+		result = read_phy_register(srb, chip);
+		break;
+
+	case WRITE_PHY:
+		result = write_phy_register(srb, chip);
+		break;
+
+	case GET_DEV_STATUS:
+		result = get_dev_status(srb, chip);
+		break;
+
+	default:
+		rts51x_set_sense_type(chip, SCSI_LUN(srb),
+			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	return result;
+}
+
+static int vendor_cmnd(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int result = TRANSPORT_GOOD;
+
+	switch (srb->cmnd[1]) {
+	case READ_STATUS:
+		result = read_status(srb, chip);
+		break;
+
+	case READ_MEM:
+		result = read_mem(srb, chip);
+		break;
+
+	case WRITE_MEM:
+		result = write_mem(srb, chip);
+		break;
+
+	case GET_BUS_WIDTH:
+		result = get_card_bus_width(srb, chip);
+		break;
+
+	case GET_SD_CSD:
+		result = get_sd_csd(srb, chip);
+		break;
+
+#ifdef _MSG_TRACE
+	case TRACE_MSG:
+		result = trace_msg_cmd(srb, chip);
+		break;
+#endif
+
+	case SCSI_APP_CMD:
+		result = app_cmd(srb, chip);
+		break;
+
+	default:
+		rts51x_set_sense_type(chip, SCSI_LUN(srb),
+			       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	return result;
+}
+
+static int ms_format_cmnd(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	unsigned int lun = SCSI_LUN(srb);
+	int retval, quick_format;
+
+	if (rts51x_get_lun_card(chip, lun) != MS_CARD) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if ((srb->cmnd[3] != 0x4D) || (srb->cmnd[4] != 0x47)
+	    || (srb->cmnd[5] != 0x66) || (srb->cmnd[6] != 0x6D)
+	    || (srb->cmnd[7] != 0x74)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (srb->cmnd[8] & 0x01)
+		quick_format = 0;
+	else
+		quick_format = 1;
+
+	if (!(chip->card_ready & MS_CARD)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (chip->card_wp & MS_CARD) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_PROTECT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (!CHK_MSPRO(ms_card)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	retval = rts51x_mspro_format(srb, chip, MS_SHORT_DATA_LEN, quick_format);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_FORMAT_CMD_FAILED);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	scsi_set_resid(srb, 0);
+	return TRANSPORT_GOOD;
+}
+
+#ifdef SUPPORT_PCGL_1P18
+static int get_ms_information(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	unsigned int lun = SCSI_LUN(srb);
+	u8 dev_info_id, data_len;
+	u8 *buf;
+	unsigned int buf_len;
+	int i;
+
+	if (!check_card_ready(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+	if ((rts51x_get_lun_card(chip, lun) != MS_CARD)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if ((srb->cmnd[2] != 0xB0) || (srb->cmnd[4] != 0x4D) ||
+	    (srb->cmnd[5] != 0x53) || (srb->cmnd[6] != 0x49) ||
+	    (srb->cmnd[7] != 0x44)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	dev_info_id = srb->cmnd[3];
+	if ((CHK_MSXC(ms_card) && (dev_info_id == 0x10)) ||
+	    (!CHK_MSXC(ms_card) && (dev_info_id == 0x13)) ||
+	    !CHK_MSPRO(ms_card)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (dev_info_id == 0x15)
+		buf_len = data_len = 0x3A;
+	else
+		buf_len = data_len = 0x6A;
+
+	buf = kmalloc(buf_len, GFP_KERNEL);
+	if (!buf)
+		TRACE_RET(chip, TRANSPORT_ERROR);
+
+	i = 0;
+	/* GET Memory Stick Media Information Response Header */
+	buf[i++] = 0x00;	/* Data length MSB */
+	buf[i++] = data_len;	/* Data length LSB */
+	/* Device Information Type Code */
+	if (CHK_MSXC(ms_card))
+		buf[i++] = 0x03;
+	else
+		buf[i++] = 0x02;
+	/* SGM bit */
+	buf[i++] = 0x01;
+	/* Reserved */
+	buf[i++] = 0x00;
+	buf[i++] = 0x00;
+	buf[i++] = 0x00;
+	/* Number of Device Information */
+	buf[i++] = 0x01;
+
+	/*  Device Information Body
+	 *  Device Information ID Number */
+	buf[i++] = dev_info_id;
+	/* Device Information Length */
+	if (dev_info_id == 0x15)
+		data_len = 0x31;
+	else
+		data_len = 0x61;
+	buf[i++] = 0x00;	/* Data length MSB */
+	buf[i++] = data_len;	/* Data length LSB */
+	/* Valid Bit */
+	buf[i++] = 0x80;
+	if ((dev_info_id == 0x10) || (dev_info_id == 0x13)) {
+		/* System Information */
+		memcpy(buf + i, ms_card->raw_sys_info, 96);
+	} else {
+		/* Model Name */
+		memcpy(buf + i, ms_card->raw_model_name, 48);
+	}
+
+	rts51x_set_xfer_buf(buf, buf_len, srb);
+
+	if (dev_info_id == 0x15)
+		scsi_set_resid(srb, scsi_bufflen(srb) - 0x3C);
+	else
+		scsi_set_resid(srb, scsi_bufflen(srb) - 0x6C);
+
+	kfree(buf);
+	return STATUS_SUCCESS;
+}
+#endif
+
+static int ms_sp_cmnd(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int retval = TRANSPORT_ERROR;
+
+	if (srb->cmnd[2] == MS_FORMAT)
+		retval = ms_format_cmnd(srb, chip);
+#ifdef SUPPORT_PCGL_1P18
+	else if (srb->cmnd[2] == GET_MS_INFORMATION)
+		retval = get_ms_information(srb, chip);
+#endif
+
+	return retval;
+}
+
+#ifdef SUPPORT_CPRM
+static int sd_extention_cmnd(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	unsigned int lun = SCSI_LUN(srb);
+	int result;
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	rts51x_sd_cleanup_work(chip);
+
+	if (!check_card_ready(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+	if ((rts51x_get_lun_card(chip, lun) != SD_CARD)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	switch (srb->cmnd[0]) {
+	case SD_PASS_THRU_MODE:
+		result = rts51x_sd_pass_thru_mode(srb, chip);
+		break;
+
+	case SD_EXECUTE_NO_DATA:
+		result = rts51x_sd_execute_no_data(srb, chip);
+		break;
+
+	case SD_EXECUTE_READ:
+		result = rts51x_sd_execute_read_data(srb, chip);
+		break;
+
+	case SD_EXECUTE_WRITE:
+		result = rts51x_sd_execute_write_data(srb, chip);
+		break;
+
+	case SD_GET_RSP:
+		result = rts51x_sd_get_cmd_rsp(srb, chip);
+		break;
+
+	case SD_HW_RST:
+		result = rts51x_sd_hw_rst(srb, chip);
+		break;
+
+	default:
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	return result;
+}
+#endif
+
+#ifdef SUPPORT_MAGIC_GATE
+static int mg_report_key(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	unsigned int lun = SCSI_LUN(srb);
+	int retval;
+	u8 key_format;
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	rts51x_ms_cleanup_work(chip);
+
+	if (!check_card_ready(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+	if ((rts51x_get_lun_card(chip, lun) != MS_CARD)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (srb->cmnd[7] != KC_MG_R_PRO) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (!CHK_MSPRO(ms_card)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	key_format = srb->cmnd[10] & 0x3F;
+
+	switch (key_format) {
+	case KF_GET_LOC_EKB:
+		if ((scsi_bufflen(srb) == 0x41C) &&
+		    (srb->cmnd[8] == 0x04) && (srb->cmnd[9] == 0x1C)) {
+			retval = rts51x_mg_get_local_EKB(srb, chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, TRANSPORT_FAILED);
+		} else {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		break;
+
+	case KF_RSP_CHG:
+		if ((scsi_bufflen(srb) == 0x24) &&
+		    (srb->cmnd[8] == 0x00) && (srb->cmnd[9] == 0x24)) {
+			retval = rts51x_mg_get_rsp_chg(srb, chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, TRANSPORT_FAILED);
+		} else {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		break;
+
+	case KF_GET_ICV:
+		ms_card->mg_entry_num = srb->cmnd[5];
+		if ((scsi_bufflen(srb) == 0x404) &&
+		    (srb->cmnd[8] == 0x04) &&
+		    (srb->cmnd[9] == 0x04) &&
+		    (srb->cmnd[2] == 0x00) &&
+		    (srb->cmnd[3] == 0x00) &&
+		    (srb->cmnd[4] == 0x00) && (srb->cmnd[5] < 32)) {
+			retval = rts51x_mg_get_ICV(srb, chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, TRANSPORT_FAILED);
+		} else {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		break;
+
+	default:
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	scsi_set_resid(srb, 0);
+	return TRANSPORT_GOOD;
+}
+
+static int mg_send_key(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	unsigned int lun = SCSI_LUN(srb);
+	int retval;
+	u8 key_format;
+
+	rts51x_prepare_run(chip);
+	RTS51X_SET_STAT(chip, STAT_RUN);
+
+	rts51x_ms_cleanup_work(chip);
+
+	if (!check_card_ready(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+	if (check_card_wp(chip, lun)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_PROTECT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+	if ((rts51x_get_lun_card(chip, lun) != MS_CARD)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_LUN_NOT_SUPPORT);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (srb->cmnd[7] != KC_MG_R_PRO) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (!CHK_MSPRO(ms_card)) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MG_INCOMPATIBLE_MEDIUM);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	key_format = srb->cmnd[10] & 0x3F;
+
+	switch (key_format) {
+	case KF_SET_LEAF_ID:
+		if ((scsi_bufflen(srb) == 0x0C) &&
+		    (srb->cmnd[8] == 0x00) && (srb->cmnd[9] == 0x0C)) {
+			retval = rts51x_mg_set_leaf_id(srb, chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, TRANSPORT_FAILED);
+		} else {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		break;
+
+	case KF_CHG_HOST:
+		if ((scsi_bufflen(srb) == 0x0C) &&
+		    (srb->cmnd[8] == 0x00) && (srb->cmnd[9] == 0x0C)) {
+			retval = rts51x_mg_chg(srb, chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, TRANSPORT_FAILED);
+		} else {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		break;
+
+	case KF_RSP_HOST:
+		if ((scsi_bufflen(srb) == 0x0C) &&
+		    (srb->cmnd[8] == 0x00) && (srb->cmnd[9] == 0x0C)) {
+			retval = rts51x_mg_rsp(srb, chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, TRANSPORT_FAILED);
+		} else {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		break;
+
+	case KF_SET_ICV:
+		ms_card->mg_entry_num = srb->cmnd[5];
+		if ((scsi_bufflen(srb) == 0x404) &&
+		    (srb->cmnd[8] == 0x04) &&
+		    (srb->cmnd[9] == 0x04) &&
+		    (srb->cmnd[2] == 0x00) &&
+		    (srb->cmnd[3] == 0x00) &&
+		    (srb->cmnd[4] == 0x00) && (srb->cmnd[5] < 32)) {
+			retval = rts51x_mg_set_ICV(srb, chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, TRANSPORT_FAILED);
+		} else {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		break;
+
+	default:
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	scsi_set_resid(srb, 0);
+	return TRANSPORT_GOOD;
+}
+#endif
+
+int rts51x_scsi_handler(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct ms_info *ms_card = &(chip->ms_card);
+	unsigned int lun = SCSI_LUN(srb);
+	int result = TRANSPORT_GOOD;
+
+	if ((rts51x_get_lun_card(chip, lun) == MS_CARD) &&
+	    (ms_card->format_status == FORMAT_IN_PROGRESS)) {
+		if ((srb->cmnd[0] != REQUEST_SENSE)
+		    && (srb->cmnd[0] != INQUIRY)) {
+			/* Logical Unit Not Ready Format in Progress */
+			rts51x_set_sense_data(chip, lun, CUR_ERR, 0x02, 0, 0x04, 0x04,
+				       0, (u16) (ms_card->progress));
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+	}
+
+	switch (srb->cmnd[0]) {
+	case READ_10:
+	case WRITE_10:
+	case READ_6:
+	case WRITE_6:
+		result = read_write(srb, chip);
+		break;
+
+	case TEST_UNIT_READY:
+		result = test_unit_ready(srb, chip);
+		break;
+
+	case INQUIRY:
+		result = inquiry(srb, chip);
+		break;
+
+	case READ_CAPACITY:
+		result = read_capacity(srb, chip);
+		break;
+
+	case START_STOP:
+		result = start_stop_unit(srb, chip);
+		break;
+
+	case ALLOW_MEDIUM_REMOVAL:
+		result = allow_medium_removal(srb, chip);
+		break;
+
+	case REQUEST_SENSE:
+		result = request_sense(srb, chip);
+		break;
+
+	case MODE_SENSE:
+	case MODE_SENSE_10:
+		result = mode_sense(srb, chip);
+		break;
+
+	case 0x23:
+		result = read_format_capacity(srb, chip);
+		break;
+
+	case VENDOR_CMND:
+		result = vendor_cmnd(srb, chip);
+		break;
+
+	case MS_SP_CMND:
+		result = ms_sp_cmnd(srb, chip);
+		break;
+
+#ifdef SUPPORT_CPRM
+	case SD_PASS_THRU_MODE:
+	case SD_EXECUTE_NO_DATA:
+	case SD_EXECUTE_READ:
+	case SD_EXECUTE_WRITE:
+	case SD_GET_RSP:
+	case SD_HW_RST:
+		result = sd_extention_cmnd(srb, chip);
+		break;
+#endif
+
+#ifdef SUPPORT_MAGIC_GATE
+	case CMD_MSPRO_MG_RKEY:
+		result = mg_report_key(srb, chip);
+		break;
+
+	case CMD_MSPRO_MG_SKEY:
+		result = mg_send_key(srb, chip);
+		break;
+#endif
+
+	case FORMAT_UNIT:
+	case MODE_SELECT:
+	case VERIFY:
+		result = TRANSPORT_GOOD;
+		break;
+
+	default:
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		result = TRANSPORT_FAILED;
+	}
+
+	return result;
+}
+
+/***********************************************************************
+ * Host functions
+ ***********************************************************************/
+
+int slave_alloc(struct scsi_device *sdev)
+{
+	/*
+	 * Set the INQUIRY transfer length to 36.  We don't use any of
+	 * the extra data and many devices choke if asked for more or
+	 * less than 36 bytes.
+	 */
+	sdev->inquiry_len = 36;
+	return 0;
+}
+
+int slave_configure(struct scsi_device *sdev)
+{
+	/* Scatter-gather buffers (all but the last) must have a length
+	 * divisible by the bulk maxpacket size.  Otherwise a data packet
+	 * would end up being short, causing a premature end to the data
+	 * transfer.  Since high-speed bulk pipes have a maxpacket size
+	 * of 512, we'll use that as the scsi device queue's DMA alignment
+	 * mask.  Guaranteeing proper alignment of the first buffer will
+	 * have the desired effect because, except at the beginning and
+	 * the end, scatter-gather buffers follow page boundaries. */
+	blk_queue_dma_alignment(sdev->request_queue, (512 - 1));
+
+	/* Set the SCSI level to at least 2.  We'll leave it at 3 if that's
+	 * what is originally reported.  We need this to avoid confusing
+	 * the SCSI layer with devices that report 0 or 1, but need 10-byte
+	 * commands (ala ATAPI devices behind certain bridges, or devices
+	 * which simply have broken INQUIRY data).
+	 *
+	 * NOTE: This means /dev/sg programs (ala cdrecord) will get the
+	 * actual information.  This seems to be the preference for
+	 * programs like that.
+	 *
+	 * NOTE: This also means that /proc/scsi/scsi and sysfs may report
+	 * the actual value or the modified one, depending on where the
+	 * data comes from.
+	 */
+	if (sdev->scsi_level < SCSI_2)
+		sdev->scsi_level = sdev->sdev_target->scsi_level = SCSI_2;
+
+	return 0;
+}
+
+/***********************************************************************
+ * /proc/scsi/ functions
+ ***********************************************************************/
+
+/* we use this macro to help us write into the buffer */
+#undef SPRINTF
+#define SPRINTF(args...) seq_printf(m, ##args)
+
+static int write_info(struct Scsi_Host *host, char *buffer, int length)
+{
+	/* if someone is sending us data, just throw it away */
+	return length;
+}
+
+static int show_info(struct seq_file *m, struct Scsi_Host *host)
+{
+	/* print the controller name */
+	SPRINTF("   Host scsi%d: %s\n", host->host_no, RTS51X_NAME);
+
+	/* print product, vendor, and driver version strings */
+	SPRINTF("       Vendor: Realtek Corp.\n");
+	SPRINTF("      Product: RTS51xx USB Card Reader\n");
+	SPRINTF("      Version: %s\n", DRIVER_VERSION);
+	return 0;
+}
+
+/* queue a command */
+/* This is always called with scsi_lock(host) held */
+static int queuecommand_lck(struct scsi_cmnd *srb, void (*done) (struct scsi_cmnd *))
+{
+	struct rts51x_chip *chip = host_to_rts51x(srb->device->host);
+
+	/* check for state-transition errors */
+	if (chip->srb != NULL) {
+		RTS51X_DEBUGP("Error in %s: chip->srb = %p\n",
+			       __func__, chip->srb);
+		return SCSI_MLQUEUE_HOST_BUSY;
+	}
+
+	/* fail the command if we are disconnecting */
+	if (test_bit(FLIDX_DISCONNECTING, &chip->usb->dflags)) {
+		RTS51X_DEBUGP("Fail command during disconnect\n");
+		srb->result = DID_NO_CONNECT << 16;
+		done(srb);
+		return 0;
+	}
+
+	/* enqueue the command and wake up the control thread */
+	srb->scsi_done = done;
+	chip->srb = srb;
+	complete(&chip->usb->cmnd_ready);
+
+	return 0;
+}
+
+DEF_SCSI_QCMD(queuecommand)
+/***********************************************************************
+ * Error handling functions
+ ***********************************************************************/
+/* Command timeout and abort */
+int command_abort(struct scsi_cmnd *srb)
+{
+	struct rts51x_chip *chip = host_to_rts51x(srb->device->host);
+
+	RTS51X_DEBUGP("%s called\n", __func__);
+
+	/* us->srb together with the TIMED_OUT, RESETTING, and ABORTING
+	 * bits are protected by the host lock. */
+	scsi_lock(rts51x_to_host(chip));
+
+	/* Is this command still active? */
+	if (chip->srb != srb) {
+		scsi_unlock(rts51x_to_host(chip));
+		RTS51X_DEBUGP("-- nothing to abort\n");
+		return FAILED;
+	}
+
+	/* Set the TIMED_OUT bit.  Also set the ABORTING bit, but only if
+	 * a device reset isn't already in progress (to avoid interfering
+	 * with the reset).  Note that we must retain the host lock while
+	 * calling usb_stor_stop_transport(); otherwise it might interfere
+	 * with an auto-reset that begins as soon as we release the lock. */
+	set_bit(FLIDX_TIMED_OUT, &chip->usb->dflags);
+	if (!test_bit(FLIDX_RESETTING, &chip->usb->dflags)) {
+		set_bit(FLIDX_ABORTING, &chip->usb->dflags);
+		/* rts51x_stop_transport(us); */
+	}
+	scsi_unlock(rts51x_to_host(chip));
+
+	/* Wait for the aborted command to finish */
+	wait_for_completion(&chip->usb->notify);
+	return SUCCESS;
+}
+
+/* This invokes the transport reset mechanism to reset the state of the
+ * device */
+static int device_reset(struct scsi_cmnd *srb)
+{
+	int result = 0;
+
+	RTS51X_DEBUGP("%s called\n", __func__);
+
+	return result < 0 ? FAILED : SUCCESS;
+}
+
+/* Simulate a SCSI bus reset by resetting the device's USB port. */
+int bus_reset(struct scsi_cmnd *srb)
+{
+	int result = 0;
+
+	RTS51X_DEBUGP("%s called\n", __func__);
+
+	return result < 0 ? FAILED : SUCCESS;
+}
+
+static const char *rts5139_info(struct Scsi_Host *host)
+{
+	return "SCSI emulation for RTS5139 USB card reader";
+}
+
+struct scsi_host_template rts51x_host_template = {
+	/* basic userland interface stuff */
+	.name = RTS51X_NAME,
+	.proc_name = RTS51X_NAME,
+	.show_info = show_info,
+	.write_info = write_info,
+	.info = rts5139_info,
+
+	/* command interface -- queued only */
+	.queuecommand = queuecommand,
+
+	/* error and abort handlers */
+	.eh_abort_handler = command_abort,
+	.eh_device_reset_handler = device_reset,
+	.eh_bus_reset_handler = bus_reset,
+
+	/* queue commands only, only one command per LUN */
+	.can_queue = 1,
+	.cmd_per_lun = 1,
+
+	/* unknown initiator id */
+	.this_id = -1,
+
+	.slave_alloc = slave_alloc,
+	.slave_configure = slave_configure,
+
+	/* lots of sg segments can be handled */
+	.sg_tablesize = SG_ALL,
+
+	/* limit the total size of a transfer to 120 KB */
+	.max_sectors = 240,
+
+	/* merge commands... this seems to help performance, but
+	 * periodically someone should test to see which setting is more
+	 * optimal.
+	 */
+	.use_clustering = 1,
+
+	/* emulated HBA */
+	.emulated = 1,
+
+	/* we do our own delay after a device or bus reset */
+	.skip_settle_delay = 1,
+
+	/* sysfs device attributes */
+	/* .sdev_attrs = sysfs_device_attr_list, */
+
+	/* module management */
+	.module = THIS_MODULE
+};
+
diff --git a/drivers/staging/rts5139/rts51x_scsi.h b/drivers/staging/rts5139/rts51x_scsi.h
new file mode 100644
index 000000000000..1a0d70566186
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_scsi.h
@@ -0,0 +1,154 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_SCSI_H
+#define __RTS51X_SCSI_H
+
+#include <linux/usb.h>
+#include <linux/usb_usual.h>
+#include <linux/blkdev.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+#include <scsi/scsi_host.h>
+
+#include "rts51x_chip.h"
+
+#define MS_SP_CMND		0xFA
+#define MS_FORMAT		0xA0
+#define GET_MS_INFORMATION	0xB0
+
+#define VENDOR_CMND		0xF0
+
+#define READ_STATUS		0x09
+
+#define READ_MEM		0x0D
+#define WRITE_MEM		0x0E
+#define GET_BUS_WIDTH		0x13
+#define GET_SD_CSD		0x14
+#define TOGGLE_GPIO		0x15
+#define TRACE_MSG		0x18
+
+#define SCSI_APP_CMD		0x10
+
+#define PP_READ10		0x1A
+#define PP_WRITE10		0x0A
+#define READ_HOST_REG		0x1D
+#define WRITE_HOST_REG		0x0D
+#define SET_VAR			0x05
+#define GET_VAR			0x15
+#define DMA_READ		0x16
+#define DMA_WRITE		0x06
+#define GET_DEV_STATUS		0x10
+#define SET_CHIP_MODE		0x27
+#define SUIT_CMD		0xE0
+#define WRITE_PHY		0x07
+#define READ_PHY		0x17
+
+#define INIT_BATCHCMD		0x41
+#define ADD_BATCHCMD		0x42
+#define SEND_BATCHCMD		0x43
+#define GET_BATCHRSP		0x44
+
+#ifdef SUPPORT_CPRM
+/* SD Pass Through Command Extension */
+#define SD_PASS_THRU_MODE	0xD0
+#define SD_EXECUTE_NO_DATA	0xD1
+#define SD_EXECUTE_READ		0xD2
+#define SD_EXECUTE_WRITE	0xD3
+#define SD_GET_RSP		0xD4
+#define SD_HW_RST		0xD6
+#endif
+
+#ifdef SUPPORT_MAGIC_GATE
+#define CMD_MSPRO_MG_RKEY	0xA4	/* Report Key Command */
+#define CMD_MSPRO_MG_SKEY	0xA3	/* Send Key Command */
+
+/* CBWCB field: key class */
+#define KC_MG_R_PRO		0xBE	/* MG-R PRO */
+
+/* CBWCB field: key format */
+#define KF_SET_LEAF_ID		0x31	/* Set Leaf ID */
+#define KF_GET_LOC_EKB		0x32	/* Get Local EKB */
+#define KF_CHG_HOST		0x33	/* Challenge (host) */
+#define KF_RSP_CHG		0x34	/* Response and Challenge (device)  */
+#define KF_RSP_HOST		0x35	/* Response (host) */
+#define KF_GET_ICV		0x36	/* Get ICV */
+#define KF_SET_ICV		0x37	/* SSet ICV */
+#endif
+
+struct rts51x_chip;
+
+/*-----------------------------------
+    Start-Stop-Unit
+-----------------------------------*/
+#define STOP_MEDIUM			0x00	/* access disable */
+#define MAKE_MEDIUM_READY		0x01	/* access enable */
+#define UNLOAD_MEDIUM			0x02	/* unload */
+#define LOAD_MEDIUM			0x03	/* load */
+
+/*-----------------------------------
+    STANDARD_INQUIRY
+-----------------------------------*/
+#define QULIFIRE                0x00
+#define AENC_FNC                0x00
+#define TRML_IOP                0x00
+#define REL_ADR                 0x00
+#define WBUS_32                 0x00
+#define WBUS_16                 0x00
+#define SYNC                    0x00
+#define LINKED                  0x00
+#define CMD_QUE                 0x00
+#define SFT_RE                  0x00
+
+#define VEN_ID_LEN              8	/* Vendor ID Length         */
+#define PRDCT_ID_LEN            16	/* Product ID Length        */
+#define PRDCT_REV_LEN           4	/* Product LOT Length       */
+
+#define DRCT_ACCESS_DEV         0x00	/* Direct Access Device             */
+#define RMB_DISC                0x80	/* The Device is Removable          */
+#define ANSI_SCSI2              0x02	/* Based on ANSI-SCSI2              */
+
+#define SCSI                    0x00	/* Interface ID                     */
+
+void rts51x_scsi_show_command(struct scsi_cmnd *srb);
+void rts51x_set_sense_type(struct rts51x_chip *chip, unsigned int lun, int sense_type);
+void rts51x_set_sense_data(struct rts51x_chip *chip, unsigned int lun, u8 err_code,
+		    u8 sense_key, u32 info, u8 asc, u8 ascq, u8 sns_key_info0,
+		    u16 sns_key_info1);
+
+int rts51x_scsi_handler(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+
+struct Scsi_Host;
+struct scsi_device;
+struct scsi_cmnd;
+
+int slave_alloc(struct scsi_device *sdev);
+int slave_configure(struct scsi_device *sdev);
+int queuecommand(struct Scsi_Host *, struct scsi_cmnd *);
+int command_abort(struct scsi_cmnd *srb);
+int bus_reset(struct scsi_cmnd *srb);
+
+#endif /* __RTS51X_SCSI_H */
diff --git a/drivers/staging/rts5139/rts51x_transport.c b/drivers/staging/rts5139/rts51x_transport.c
new file mode 100644
index 000000000000..0db1345df94e
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_transport.c
@@ -0,0 +1,738 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include <scsi/scsi.h>
+#include <scsi/scsi_eh.h>
+#include <scsi/scsi_device.h>
+
+#include "debug.h"
+#include "rts51x.h"
+#include "rts51x_chip.h"
+#include "rts51x_card.h"
+#include "rts51x_scsi.h"
+#include "rts51x_transport.h"
+#include "trace.h"
+
+/***********************************************************************
+ * Scatter-gather transfer buffer access routines
+ ***********************************************************************/
+
+/* Copy a buffer of length buflen to/from the srb's transfer buffer.
+ * Update the **sgptr and *offset variables so that the next copy will
+ * pick up from where this one left off.
+ */
+
+unsigned int rts51x_access_sglist(unsigned char *buffer,
+				  unsigned int buflen, void *sglist,
+				  void **sgptr, unsigned int *offset,
+				  enum xfer_buf_dir dir)
+{
+	unsigned int cnt;
+	struct scatterlist *sg = (struct scatterlist *)*sgptr;
+
+	/* We have to go through the list one entry
+	 * at a time.  Each s-g entry contains some number of pages, and
+	 * each page has to be kmap()'ed separately.  If the page is already
+	 * in kernel-addressable memory then kmap() will return its address.
+	 * If the page is not directly accessible -- such as a user buffer
+	 * located in high memory -- then kmap() will map it to a temporary
+	 * position in the kernel's virtual address space.
+	 */
+
+	if (!sg)
+		sg = (struct scatterlist *)sglist;
+
+	/* This loop handles a single s-g list entry, which may
+	 * include multiple pages.  Find the initial page structure
+	 * and the starting offset within the page, and update
+	 * the *offset and **sgptr values for the next loop.
+	 */
+	cnt = 0;
+	while (cnt < buflen && sg) {
+		struct page *page = sg_page(sg) +
+		    ((sg->offset + *offset) >> PAGE_SHIFT);
+		unsigned int poff = (sg->offset + *offset) & (PAGE_SIZE - 1);
+		unsigned int sglen = sg->length - *offset;
+
+		if (sglen > buflen - cnt) {
+
+			/* Transfer ends within this s-g entry */
+			sglen = buflen - cnt;
+			*offset += sglen;
+		} else {
+
+			/* Transfer continues to next s-g entry */
+			*offset = 0;
+			sg = sg_next(sg);
+		}
+
+		/* Transfer the data for all the pages in this
+		 * s-g entry.  For each page: call kmap(), do the
+		 * transfer, and call kunmap() immediately after. */
+		while (sglen > 0) {
+			unsigned int plen = min(sglen, (unsigned int)
+						PAGE_SIZE - poff);
+			unsigned char *ptr = kmap(page);
+
+			if (dir == TO_XFER_BUF)
+				memcpy(ptr + poff, buffer + cnt, plen);
+			else
+				memcpy(buffer + cnt, ptr + poff, plen);
+			kunmap(page);
+
+			/* Start at the beginning of the next page */
+			poff = 0;
+			++page;
+			cnt += plen;
+			sglen -= plen;
+		}
+	}
+	*sgptr = sg;
+
+	/* Return the amount actually transferred */
+	return cnt;
+}
+
+static unsigned int rts51x_access_xfer_buf(unsigned char *buffer,
+				    unsigned int buflen, struct scsi_cmnd *srb,
+				    struct scatterlist **sgptr,
+				    unsigned int *offset, enum xfer_buf_dir dir)
+{
+	return rts51x_access_sglist(buffer, buflen, (void *)scsi_sglist(srb),
+				    (void **)sgptr, offset, dir);
+}
+
+/* Store the contents of buffer into srb's transfer buffer and set the
+ * SCSI residue.
+ */
+void rts51x_set_xfer_buf(unsigned char *buffer,
+			 unsigned int buflen, struct scsi_cmnd *srb)
+{
+	unsigned int offset = 0;
+	struct scatterlist *sg = NULL;
+
+	buflen = min(buflen, scsi_bufflen(srb));
+	buflen = rts51x_access_xfer_buf(buffer, buflen, srb, &sg, &offset,
+					TO_XFER_BUF);
+	if (buflen < scsi_bufflen(srb))
+		scsi_set_resid(srb, scsi_bufflen(srb) - buflen);
+}
+
+void rts51x_get_xfer_buf(unsigned char *buffer,
+			 unsigned int buflen, struct scsi_cmnd *srb)
+{
+	unsigned int offset = 0;
+	struct scatterlist *sg = NULL;
+
+	buflen = min(buflen, scsi_bufflen(srb));
+	buflen = rts51x_access_xfer_buf(buffer, buflen, srb, &sg, &offset,
+					FROM_XFER_BUF);
+	if (buflen < scsi_bufflen(srb))
+		scsi_set_resid(srb, scsi_bufflen(srb) - buflen);
+}
+
+/* This is the completion handler which will wake us up when an URB
+ * completes.
+ */
+static void urb_done_completion(struct urb *urb)
+{
+	struct completion *urb_done_ptr = urb->context;
+
+	if (urb_done_ptr)
+		complete(urb_done_ptr);
+}
+
+/* This is the common part of the URB message submission code
+ *
+ * All URBs from the driver involved in handling a queued scsi
+ * command _must_ pass through this function (or something like it) for the
+ * abort mechanisms to work properly.
+ */
+static int rts51x_msg_common(struct rts51x_chip *chip, struct urb *urb,
+			     int timeout)
+{
+	struct rts51x_usb *rts51x = chip->usb;
+	struct completion urb_done;
+	long timeleft;
+	int status;
+
+	/* don't submit URBs during abort processing */
+	if (test_bit(FLIDX_ABORTING, &rts51x->dflags))
+		TRACE_RET(chip, -EIO);
+
+	/* set up data structures for the wakeup system */
+	init_completion(&urb_done);
+
+	/* fill the common fields in the URB */
+	urb->context = &urb_done;
+	urb->actual_length = 0;
+	urb->error_count = 0;
+	urb->status = 0;
+
+	/* we assume that if transfer_buffer isn't us->iobuf then it
+	 * hasn't been mapped for DMA.  Yes, this is clunky, but it's
+	 * easier than always having the caller tell us whether the
+	 * transfer buffer has already been mapped. */
+	urb->transfer_flags = URB_NO_SETUP_DMA_MAP;
+	if (urb->transfer_buffer == rts51x->iobuf) {
+		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+		urb->transfer_dma = rts51x->iobuf_dma;
+	}
+	urb->setup_dma = rts51x->cr_dma;
+
+	/* submit the URB */
+	status = usb_submit_urb(urb, GFP_NOIO);
+	if (status) {
+		/* something went wrong */
+		TRACE_RET(chip, status);
+	}
+
+	/* since the URB has been submitted successfully, it's now okay
+	 * to cancel it */
+	set_bit(FLIDX_URB_ACTIVE, &rts51x->dflags);
+
+	/* did an abort occur during the submission? */
+	if (test_bit(FLIDX_ABORTING, &rts51x->dflags)) {
+
+		/* cancel the URB, if it hasn't been cancelled already */
+		if (test_and_clear_bit(FLIDX_URB_ACTIVE, &rts51x->dflags)) {
+			RTS51X_DEBUGP("-- cancelling URB\n");
+			usb_unlink_urb(urb);
+		}
+	}
+
+	/* wait for the completion of the URB */
+	timeleft =
+	    wait_for_completion_interruptible_timeout(&urb_done,
+						      (timeout * HZ /
+						       1000) ? :
+						      MAX_SCHEDULE_TIMEOUT);
+
+	clear_bit(FLIDX_URB_ACTIVE, &rts51x->dflags);
+
+	if (timeleft <= 0) {
+		RTS51X_DEBUGP("%s -- cancelling URB\n",
+			       timeleft == 0 ? "Timeout" : "Signal");
+		usb_kill_urb(urb);
+		if (timeleft == 0)
+			status = -ETIMEDOUT;
+		else
+			status = -EINTR;
+	} else {
+		status = urb->status;
+	}
+
+	return status;
+}
+
+static int rts51x_clear_halt(struct rts51x_chip *chip, unsigned int pipe);
+
+/*
+ * Interpret the results of a URB transfer
+ */
+static int interpret_urb_result(struct rts51x_chip *chip, unsigned int pipe,
+				unsigned int length, int result,
+				unsigned int partial)
+{
+	int retval = STATUS_SUCCESS;
+
+	/* RTS51X_DEBUGP("Status code %d; transferred %u/%u\n",
+				result, partial, length); */
+	switch (result) {
+		/* no error code; did we send all the data? */
+	case 0:
+		if (partial != length) {
+			RTS51X_DEBUGP("-- short transfer\n");
+			TRACE_RET(chip, STATUS_TRANS_SHORT);
+		}
+		/* RTS51X_DEBUGP("-- transfer complete\n"); */
+		return STATUS_SUCCESS;
+		/* stalled */
+	case -EPIPE:
+		/* for control endpoints, (used by CB[I]) a stall indicates
+		 * a failed command */
+		if (usb_pipecontrol(pipe)) {
+			RTS51X_DEBUGP("-- stall on control pipe\n");
+			TRACE_RET(chip, STATUS_STALLED);
+		}
+		/* for other sorts of endpoint, clear the stall */
+		RTS51X_DEBUGP("clearing endpoint halt for pipe 0x%x\n", pipe);
+		if (rts51x_clear_halt(chip, pipe) < 0)
+			TRACE_RET(chip, STATUS_ERROR);
+		retval = STATUS_STALLED;
+		TRACE_GOTO(chip, Exit);
+
+		/* babble - the device tried to send more than
+		 * we wanted to read */
+	case -EOVERFLOW:
+		RTS51X_DEBUGP("-- babble\n");
+		retval = STATUS_TRANS_LONG;
+		TRACE_GOTO(chip, Exit);
+
+		/* the transfer was cancelled by abort,
+		 * disconnect, or timeout */
+	case -ECONNRESET:
+		RTS51X_DEBUGP("-- transfer cancelled\n");
+		retval = STATUS_ERROR;
+		TRACE_GOTO(chip, Exit);
+
+		/* short scatter-gather read transfer */
+	case -EREMOTEIO:
+		RTS51X_DEBUGP("-- short read transfer\n");
+		retval = STATUS_TRANS_SHORT;
+		TRACE_GOTO(chip, Exit);
+
+		/* abort or disconnect in progress */
+	case -EIO:
+		RTS51X_DEBUGP("-- abort or disconnect in progress\n");
+		retval = STATUS_ERROR;
+		TRACE_GOTO(chip, Exit);
+
+	case -ETIMEDOUT:
+		RTS51X_DEBUGP("-- time out\n");
+		retval = STATUS_TIMEDOUT;
+		TRACE_GOTO(chip, Exit);
+
+		/* the catch-all error case */
+	default:
+		RTS51X_DEBUGP("-- unknown error\n");
+		retval = STATUS_ERROR;
+		TRACE_GOTO(chip, Exit);
+	}
+
+Exit:
+	if ((retval != STATUS_SUCCESS) && !usb_pipecontrol(pipe))
+		rts51x_clear_hw_error(chip);
+
+	return retval;
+}
+
+int rts51x_ctrl_transfer(struct rts51x_chip *chip, unsigned int pipe,
+			 u8 request, u8 requesttype, u16 value, u16 index,
+			 void *data, u16 size, int timeout)
+{
+	struct rts51x_usb *rts51x = chip->usb;
+	int result;
+
+	RTS51X_DEBUGP("%s: rq=%02x rqtype=%02x value=%04x index=%02x len=%u\n",
+		       __func__, request, requesttype, value, index, size);
+
+	/* fill in the devrequest structure */
+	rts51x->cr->bRequestType = requesttype;
+	rts51x->cr->bRequest = request;
+	rts51x->cr->wValue = cpu_to_le16(value);
+	rts51x->cr->wIndex = cpu_to_le16(index);
+	rts51x->cr->wLength = cpu_to_le16(size);
+
+	/* fill and submit the URB */
+	usb_fill_control_urb(rts51x->current_urb, rts51x->pusb_dev, pipe,
+			     (unsigned char *)rts51x->cr, data, size,
+			     urb_done_completion, NULL);
+	result = rts51x_msg_common(chip, rts51x->current_urb, timeout);
+
+	return interpret_urb_result(chip, pipe, size, result,
+				    rts51x->current_urb->actual_length);
+}
+
+static int rts51x_clear_halt(struct rts51x_chip *chip, unsigned int pipe)
+{
+	int result;
+	int endp = usb_pipeendpoint(pipe);
+
+	if (usb_pipein(pipe))
+		endp |= USB_DIR_IN;
+
+	result = rts51x_ctrl_transfer(chip, SND_CTRL_PIPE(chip),
+				      USB_REQ_CLEAR_FEATURE, USB_RECIP_ENDPOINT,
+				      USB_ENDPOINT_HALT, endp, NULL, 0, 3000);
+	if (result != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	usb_reset_endpoint(chip->usb->pusb_dev, endp);
+
+	return STATUS_SUCCESS;
+}
+
+static void rts51x_sg_clean(struct usb_sg_request *io)
+{
+	if (io->urbs) {
+		while (io->entries--)
+			usb_free_urb(io->urbs[io->entries]);
+		kfree(io->urbs);
+		io->urbs = NULL;
+	}
+	io->dev = NULL;
+}
+
+static int rts51x_sg_init(struct usb_sg_request *io, struct usb_device *dev,
+		   unsigned pipe, unsigned period, struct scatterlist *sg,
+		   int nents, size_t length, gfp_t mem_flags)
+{
+	return usb_sg_init(io, dev, pipe, period, sg, nents, length, mem_flags);
+}
+
+static int rts51x_sg_wait(struct usb_sg_request *io, int timeout)
+{
+	long timeleft;
+	int i;
+	int entries = io->entries;
+
+	/* queue the urbs.  */
+	spin_lock_irq(&io->lock);
+	i = 0;
+	while (i < entries && !io->status) {
+		int retval;
+
+		io->urbs[i]->dev = io->dev;
+		retval = usb_submit_urb(io->urbs[i], GFP_ATOMIC);
+
+		/* after we submit, let completions or cancelations fire;
+		 * we handshake using io->status.
+		 */
+		spin_unlock_irq(&io->lock);
+		switch (retval) {
+			/* maybe the retry will recover */
+		case -ENXIO:	/* hc didn't queue this one */
+		case -EAGAIN:
+		case -ENOMEM:
+			io->urbs[i]->dev = NULL;
+			retval = 0;
+			yield();
+			break;
+
+			/* no error? continue immediately.
+			 *
+			 * NOTE: to work better with UHCI (4K I/O buffer may
+			 * need 3K of TDs) it may be good to limit how many
+			 * URBs are queued at once; N milliseconds?
+			 */
+		case 0:
+			++i;
+			cpu_relax();
+			break;
+
+			/* fail any uncompleted urbs */
+		default:
+			io->urbs[i]->dev = NULL;
+			io->urbs[i]->status = retval;
+			dev_dbg(&io->dev->dev, "%s, submit --> %d\n",
+				__func__, retval);
+			usb_sg_cancel(io);
+		}
+		spin_lock_irq(&io->lock);
+		if (retval && (io->status == 0 || io->status == -ECONNRESET))
+			io->status = retval;
+	}
+	io->count -= entries - i;
+	if (io->count == 0)
+		complete(&io->complete);
+	spin_unlock_irq(&io->lock);
+
+	timeleft =
+	    wait_for_completion_interruptible_timeout(&io->complete,
+						      (timeout * HZ /
+						       1000) ? :
+						      MAX_SCHEDULE_TIMEOUT);
+	if (timeleft <= 0) {
+		RTS51X_DEBUGP("%s -- cancelling SG request\n",
+			       timeleft == 0 ? "Timeout" : "Signal");
+		usb_sg_cancel(io);
+		if (timeleft == 0)
+			io->status = -ETIMEDOUT;
+		else
+			io->status = -EINTR;
+	}
+
+	rts51x_sg_clean(io);
+	return io->status;
+}
+
+/*
+ * Transfer a scatter-gather list via bulk transfer
+ *
+ * This function does basically the same thing as usb_stor_bulk_transfer_buf()
+ * above, but it uses the usbcore scatter-gather library.
+ */
+static int rts51x_bulk_transfer_sglist(struct rts51x_chip *chip,
+				       unsigned int pipe,
+				       struct scatterlist *sg, int num_sg,
+				       unsigned int length,
+				       unsigned int *act_len, int timeout)
+{
+	int result;
+
+	/* don't submit s-g requests during abort processing */
+	if (test_bit(FLIDX_ABORTING, &chip->usb->dflags))
+		TRACE_RET(chip, STATUS_ERROR);
+
+	/* initialize the scatter-gather request block */
+	RTS51X_DEBUGP("%s: xfer %u bytes, %d entries\n", __func__,
+		       length, num_sg);
+	result =
+	    rts51x_sg_init(&chip->usb->current_sg, chip->usb->pusb_dev, pipe, 0,
+			   sg, num_sg, length, GFP_NOIO);
+	if (result) {
+		RTS51X_DEBUGP("rts51x_sg_init returned %d\n", result);
+		TRACE_RET(chip, STATUS_ERROR);
+	}
+
+	/* since the block has been initialized successfully, it's now
+	 * okay to cancel it */
+	set_bit(FLIDX_SG_ACTIVE, &chip->usb->dflags);
+
+	/* did an abort occur during the submission? */
+	if (test_bit(FLIDX_ABORTING, &chip->usb->dflags)) {
+
+		/* cancel the request, if it hasn't been cancelled already */
+		if (test_and_clear_bit(FLIDX_SG_ACTIVE, &chip->usb->dflags)) {
+			RTS51X_DEBUGP("-- cancelling sg request\n");
+			usb_sg_cancel(&chip->usb->current_sg);
+		}
+	}
+
+	/* wait for the completion of the transfer */
+	result = rts51x_sg_wait(&chip->usb->current_sg, timeout);
+
+	clear_bit(FLIDX_SG_ACTIVE, &chip->usb->dflags);
+
+	/* result = us->current_sg.status; */
+	if (act_len)
+		*act_len = chip->usb->current_sg.bytes;
+	return interpret_urb_result(chip, pipe, length, result,
+				    chip->usb->current_sg.bytes);
+}
+
+static int rts51x_bulk_transfer_buf(struct rts51x_chip *chip,
+			     unsigned int pipe,
+			     void *buf, unsigned int length,
+			     unsigned int *act_len, int timeout)
+{
+	int result;
+
+	/* fill and submit the URB */
+	usb_fill_bulk_urb(chip->usb->current_urb, chip->usb->pusb_dev, pipe,
+			  buf, length, urb_done_completion, NULL);
+	result = rts51x_msg_common(chip, chip->usb->current_urb, timeout);
+
+	/* store the actual length of the data transferred */
+	if (act_len)
+		*act_len = chip->usb->current_urb->actual_length;
+	return interpret_urb_result(chip, pipe, length, result,
+				    chip->usb->current_urb->actual_length);
+}
+
+int rts51x_transfer_data(struct rts51x_chip *chip, unsigned int pipe,
+			 void *buf, unsigned int len, int use_sg,
+			 unsigned int *act_len, int timeout)
+{
+	int result;
+
+	if (timeout < 600)
+		timeout = 600;
+
+	if (use_sg) {
+		result =
+		    rts51x_bulk_transfer_sglist(chip, pipe,
+						(struct scatterlist *)buf,
+						use_sg, len, act_len, timeout);
+	} else {
+		result =
+		    rts51x_bulk_transfer_buf(chip, pipe, buf, len, act_len,
+					     timeout);
+	}
+
+	return result;
+}
+
+int rts51x_transfer_data_partial(struct rts51x_chip *chip, unsigned int pipe,
+				 void *buf, void **ptr, unsigned int *offset,
+				 unsigned int len, int use_sg,
+				 unsigned int *act_len, int timeout)
+{
+	int result;
+
+	if (timeout < 600)
+		timeout = 600;
+
+	if (use_sg) {
+		void *tmp_buf = kmalloc(len, GFP_KERNEL);
+		if (!tmp_buf)
+			TRACE_RET(chip, STATUS_NOMEM);
+
+		if (usb_pipeout(pipe)) {
+			rts51x_access_sglist(tmp_buf, len, buf, ptr, offset,
+					     FROM_XFER_BUF);
+		}
+		result =
+		    rts51x_bulk_transfer_buf(chip, pipe, tmp_buf, len, act_len,
+					     timeout);
+		if (result == STATUS_SUCCESS) {
+			if (usb_pipein(pipe)) {
+				rts51x_access_sglist(tmp_buf, len, buf, ptr,
+						     offset, TO_XFER_BUF);
+			}
+		}
+
+		kfree(tmp_buf);
+	} else {
+		unsigned int step = 0;
+		if (offset)
+			step = *offset;
+		result =
+		    rts51x_bulk_transfer_buf(chip, pipe, buf + step, len,
+					     act_len, timeout);
+		if (act_len)
+			step += *act_len;
+		else
+			step += len;
+		if (offset)
+			*offset = step;
+	}
+
+	return result;
+}
+
+int rts51x_get_epc_status(struct rts51x_chip *chip, u16 *status)
+{
+	unsigned int pipe = RCV_INTR_PIPE(chip);
+	struct usb_host_endpoint *ep;
+	struct completion urb_done;
+	int result;
+
+	if (!status)
+		TRACE_RET(chip, STATUS_ERROR);
+
+	/* set up data structures for the wakeup system */
+	init_completion(&urb_done);
+
+	ep = chip->usb->pusb_dev->ep_in[usb_pipeendpoint(pipe)];
+
+	/* fill and submit the URB */
+	/* Set interval to 10 here to match the endpoint descriptor,
+	 * the polling interval is controlled by the polling thread */
+	usb_fill_int_urb(chip->usb->intr_urb, chip->usb->pusb_dev, pipe,
+			 status, 2, urb_done_completion, &urb_done, 10);
+
+	result = rts51x_msg_common(chip, chip->usb->intr_urb, 100);
+
+	return interpret_urb_result(chip, pipe, 2, result,
+				    chip->usb->intr_urb->actual_length);
+}
+
+void rts51x_invoke_transport(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	int result;
+
+#ifdef CONFIG_PM
+	static const u8 media_not_present[] = {
+		0x70, 0, 0x02, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0x3A, 0, 0, 0, 0, 0
+	};
+	static const u8 invalid_cmd_field[] = {
+		0x70, 0, 0x05, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0x24, 0, 0, 0, 0, 0
+	};
+
+	if (chip->option.ss_en) {
+		if (srb->cmnd[0] == TEST_UNIT_READY) {
+			if (RTS51X_CHK_STAT(chip, STAT_SS)) {
+				if (check_fake_card_ready(chip,
+							SCSI_LUN(srb))) {
+					srb->result = SAM_STAT_GOOD;
+				} else {
+					srb->result = SAM_STAT_CHECK_CONDITION;
+					memcpy(srb->sense_buffer,
+					       media_not_present, SENSE_SIZE);
+				}
+				return;
+			}
+		} else if (srb->cmnd[0] == ALLOW_MEDIUM_REMOVAL) {
+			if (RTS51X_CHK_STAT(chip, STAT_SS)) {
+				int prevent = srb->cmnd[4] & 0x1;
+
+				if (prevent) {
+					srb->result = SAM_STAT_CHECK_CONDITION;
+					memcpy(srb->sense_buffer,
+					       invalid_cmd_field, SENSE_SIZE);
+				} else {
+					srb->result = SAM_STAT_GOOD;
+				}
+				return;
+			}
+		} else {
+			if (RTS51X_CHK_STAT(chip, STAT_SS)
+			    || RTS51X_CHK_STAT(chip, STAT_SS_PRE)) {
+				/* Wake up device */
+				RTS51X_DEBUGP("Try to wake up device\n");
+				chip->resume_from_scsi = 1;
+
+				rts51x_try_to_exit_ss(chip);
+
+				if (RTS51X_CHK_STAT(chip, STAT_SS)) {
+					wait_timeout(3000);
+
+					rts51x_init_chip(chip);
+					rts51x_init_cards(chip);
+				}
+			}
+		}
+	}
+#endif
+
+	result = rts51x_scsi_handler(srb, chip);
+
+	/* if there is a transport error, reset and don't auto-sense */
+	if (result == TRANSPORT_ERROR) {
+		RTS51X_DEBUGP("-- transport indicates error, resetting\n");
+		srb->result = DID_ERROR << 16;
+		goto Handle_Errors;
+	}
+
+	srb->result = SAM_STAT_GOOD;
+
+	/*
+	 * If we have a failure, we're going to do a REQUEST_SENSE
+	 * automatically.  Note that we differentiate between a command
+	 * "failure" and an "error" in the transport mechanism.
+	 */
+	if (result == TRANSPORT_FAILED) {
+		/* set the result so the higher layers expect this data */
+		srb->result = SAM_STAT_CHECK_CONDITION;
+		memcpy(srb->sense_buffer,
+		       (unsigned char *)&(chip->sense_buffer[SCSI_LUN(srb)]),
+		       sizeof(struct sense_data_t));
+	}
+
+	return;
+
+	/* Error and abort processing: try to resynchronize with the device
+	 * by issuing a port reset.  If that fails, try a class-specific
+	 * device reset. */
+Handle_Errors:
+	return;
+}
diff --git a/drivers/staging/rts5139/rts51x_transport.h b/drivers/staging/rts5139/rts51x_transport.h
new file mode 100644
index 000000000000..024f115540a6
--- /dev/null
+++ b/drivers/staging/rts5139/rts51x_transport.h
@@ -0,0 +1,67 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_TRANSPORT_H
+#define __RTS51X_TRANSPORT_H
+
+#include <linux/kernel.h>
+
+#include "rts51x.h"
+#include "rts51x_chip.h"
+
+#if 1 /* LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 34) */
+#define URB_NO_SETUP_DMA_MAP		0
+#endif
+
+unsigned int rts51x_access_sglist(unsigned char *buffer,
+				  unsigned int buflen, void *sglist,
+				  void **sgptr, unsigned int *offset,
+				  enum xfer_buf_dir dir);
+void rts51x_set_xfer_buf(unsigned char *buffer, unsigned int buflen,
+			 struct scsi_cmnd *srb);
+void rts51x_get_xfer_buf(unsigned char *buffer, unsigned int buflen,
+			 struct scsi_cmnd *srb);
+
+int rts51x_ctrl_transfer(struct rts51x_chip *chip, unsigned int pipe,
+			 u8 request, u8 requesttype, u16 value, u16 index,
+			 void *data, u16 size, int timeout);
+int rts51x_transfer_data(struct rts51x_chip *chip, unsigned int pipe,
+			 void *buf, unsigned int len, int use_sg,
+			 unsigned int *act_len, int timeout);
+int rts51x_transfer_data_partial(struct rts51x_chip *chip, unsigned int pipe,
+				 void *buf, void **ptr, unsigned int *offset,
+				 unsigned int len, int use_sg,
+				 unsigned int *act_len, int timeout);
+
+#ifndef POLLING_IN_THREAD
+int rts51x_start_epc_transfer(struct rts51x_chip *chip);
+void rts51x_cancel_epc_transfer(struct rts51x_chip *chip);
+#endif
+
+int rts51x_get_epc_status(struct rts51x_chip *chip, u16 *status);
+void rts51x_invoke_transport(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+
+#endif /* __RTS51X_TRANSPORT_H */
diff --git a/drivers/staging/rts5139/sd.c b/drivers/staging/rts5139/sd.c
new file mode 100644
index 000000000000..da5a9b8fb69c
--- /dev/null
+++ b/drivers/staging/rts5139/sd.c
@@ -0,0 +1,3274 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+
+#include "debug.h"
+#include "trace.h"
+#include "rts51x.h"
+#include "rts51x_transport.h"
+#include "rts51x_scsi.h"
+#include "rts51x_card.h"
+#include "sd.h"
+
+static inline void sd_set_reset_fail(struct rts51x_chip *chip, u8 err_code)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+
+	sd_card->sd_reset_fail |= err_code;
+}
+
+static inline void sd_clear_reset_fail(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+
+	sd_card->sd_reset_fail = 0;
+}
+
+static inline int sd_check_reset_fail(struct rts51x_chip *chip, u8 err_code)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+
+	return sd_card->sd_reset_fail & err_code;
+}
+
+static inline void sd_set_err_code(struct rts51x_chip *chip, u8 err_code)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+
+	sd_card->err_code |= err_code;
+}
+
+static inline void sd_clr_err_code(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+
+	sd_card->err_code = 0;
+}
+
+static inline int sd_check_err_code(struct rts51x_chip *chip, u8 err_code)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+
+	return sd_card->err_code & err_code;
+}
+
+static int sd_parse_err_code(struct rts51x_chip *chip)
+{
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+int sd_check_data0_status(struct rts51x_chip *chip)
+{
+	int retval;
+	u8 stat;
+
+	retval = rts51x_ep0_read_register(chip, SD_BUS_STAT, &stat);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	if (!(stat & SD_DAT0_STATUS)) {
+		sd_set_err_code(chip, SD_BUSY);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_send_cmd_get_rsp(struct rts51x_chip *chip, u8 cmd_idx,
+			       u32 arg, u8 rsp_type, u8 *rsp, int rsp_len)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	int timeout = 50;
+	u16 reg_addr;
+	u8 buf[17], stat;
+	int len = 2;
+	int rty_cnt = 0;
+
+	sd_clr_err_code(chip);
+
+	RTS51X_DEBUGP("SD/MMC CMD %d, arg = 0x%08x\n", cmd_idx, arg);
+
+	if (rsp_type == SD_RSP_TYPE_R1b)
+		timeout = 3000;
+
+RTY_SEND_CMD:
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD0, 0xFF, 0x40 | cmd_idx);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD1, 0xFF, (u8) (arg >> 24));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD2, 0xFF, (u8) (arg >> 16));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD3, 0xFF, (u8) (arg >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD4, 0xFF, (u8) arg);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF, rsp_type);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       PINGPONG_BUFFER);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+		       SD_TM_CMD_RSP | SD_TRANSFER_START);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER,
+		       SD_TRANSFER_END | SD_STAT_IDLE,
+		       SD_TRANSFER_END | SD_STAT_IDLE);
+
+	rts51x_add_cmd(chip, READ_REG_CMD, SD_STAT1, 0, 0);
+
+	if (CHECK_USB(chip, USB_20)) {
+		if (rsp_type == SD_RSP_TYPE_R2) {
+			/* Read data from ping-pong buffer */
+			for (reg_addr = PPBUF_BASE2;
+			     reg_addr < PPBUF_BASE2 + 16; reg_addr++) {
+				rts51x_add_cmd(chip, READ_REG_CMD, reg_addr, 0,
+					       0);
+			}
+			len = 18;
+		} else if (rsp_type != SD_RSP_TYPE_R0) {
+			/* Read data from SD_CMDx registers */
+			for (reg_addr = SD_CMD0; reg_addr <= SD_CMD4;
+			     reg_addr++) {
+				rts51x_add_cmd(chip, READ_REG_CMD, reg_addr, 0,
+					       0);
+			}
+			len = 7;
+		} else {
+			len = 2;
+		}
+	} else {
+		len = 2;
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, len, timeout);
+
+	if (CHECK_SD_TRANS_FAIL(chip, retval)) {
+		u8 val;
+
+		rts51x_ep0_read_register(chip, SD_STAT1, &val);
+		RTS51X_DEBUGP("SD_STAT1: 0x%x\n", val);
+
+		rts51x_ep0_read_register(chip, SD_STAT2, &val);
+		RTS51X_DEBUGP("SD_STAT2: 0x%x\n", val);
+
+		if (val & SD_RSP_80CLK_TIMEOUT)
+			sd_set_err_code(chip, SD_RSP_TIMEOUT);
+
+		rts51x_ep0_read_register(chip, SD_BUS_STAT, &val);
+		RTS51X_DEBUGP("SD_BUS_STAT: 0x%x\n", val);
+
+		if (retval == STATUS_TIMEDOUT) {
+			if (rsp_type & SD_WAIT_BUSY_END) {
+				retval = sd_check_data0_status(chip);
+				if (retval != STATUS_SUCCESS)
+					TRACE_RET(chip, retval);
+			} else {
+				sd_set_err_code(chip, SD_TO_ERR);
+			}
+		}
+		rts51x_clear_sd_error(chip);
+
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (rsp_type == SD_RSP_TYPE_R0)
+		return STATUS_SUCCESS;
+
+	if (CHECK_USB(chip, USB_20)) {
+		rts51x_read_rsp_buf(chip, 2, buf, len - 2);
+	} else {
+		if (rsp_type == SD_RSP_TYPE_R2) {
+			reg_addr = PPBUF_BASE2;
+			len = 16;
+		} else {
+			reg_addr = SD_CMD0;
+			len = 5;
+		}
+		retval = rts51x_seq_read_register(chip, reg_addr,
+						     (unsigned short)len, buf);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+	stat = chip->rsp_buf[1];
+
+	/* Check (Start,Transmission) bit of Response */
+	if ((buf[0] & 0xC0) != 0) {
+		sd_set_err_code(chip, SD_STS_ERR);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	/* Check CRC7 */
+	if (!(rsp_type & SD_NO_CHECK_CRC7)) {
+		if (stat & SD_CRC7_ERR) {
+			if (cmd_idx == WRITE_MULTIPLE_BLOCK) {
+				sd_set_err_code(chip, SD_CRC_ERR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			if (rty_cnt < SD_MAX_RETRY_COUNT) {
+				wait_timeout(20);
+				rty_cnt++;
+				goto RTY_SEND_CMD;
+			} else {
+				sd_set_err_code(chip, SD_CRC_ERR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+	}
+	/* Check Status */
+	if ((rsp_type == SD_RSP_TYPE_R1) || (rsp_type == SD_RSP_TYPE_R1b)) {
+		if ((cmd_idx != SEND_RELATIVE_ADDR)
+		    && (cmd_idx != SEND_IF_COND)) {
+			if (cmd_idx != STOP_TRANSMISSION) {
+				if (buf[1] & 0x80)
+					TRACE_RET(chip, STATUS_FAIL);
+			}
+			if (buf[1] & 0x7F) {
+				RTS51X_DEBUGP("buf[1]: 0x%02x\n", buf[1]);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			if (buf[2] & 0xFF) {
+				RTS51X_DEBUGP("buf[2]: 0x%02x\n", buf[2]);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			if (buf[3] & 0x80) {
+				RTS51X_DEBUGP("buf[3]: 0x%02x\n", buf[3]);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			if (buf[3] & 0x01) {
+				/* Get "READY_FOR_DATA" bit */
+				sd_card->sd_data_buf_ready = 1;
+			} else {
+				sd_card->sd_data_buf_ready = 0;
+			}
+		}
+	}
+
+	if (rsp && rsp_len)
+		memcpy(rsp, buf, rsp_len);
+
+	return STATUS_SUCCESS;
+}
+
+static inline void sd_print_debug_reg(struct rts51x_chip *chip)
+{
+#ifdef CONFIG_RTS5139_DEBUG
+	u8 val = 0;
+
+	rts51x_ep0_read_register(chip, SD_STAT1, &val);
+	RTS51X_DEBUGP("SD_STAT1: 0x%x\n", val);
+	rts51x_ep0_read_register(chip, SD_STAT2, &val);
+	RTS51X_DEBUGP("SD_STAT2: 0x%x\n", val);
+	rts51x_ep0_read_register(chip, SD_BUS_STAT, &val);
+	RTS51X_DEBUGP("SD_BUS_STAT: 0x%x\n", val);
+#endif
+}
+
+int sd_read_data(struct rts51x_chip *chip, u8 trans_mode, u8 *cmd, int cmd_len,
+		 u16 byte_cnt, u16 blk_cnt, u8 bus_width, u8 *buf, int buf_len,
+		 int timeout)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	int i;
+
+	sd_clr_err_code(chip);
+
+	if (!buf)
+		buf_len = 0;
+
+	if (buf_len > 512)
+		/* This function can't read data more than one page */
+		TRACE_RET(chip, STATUS_FAIL);
+
+	rts51x_init_cmd(chip);
+
+	if (cmd_len) {
+		RTS51X_DEBUGP("SD/MMC CMD %d\n", cmd[0] - 0x40);
+		for (i = 0; i < (cmd_len < 6 ? cmd_len : 6); i++) {
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD0 + i, 0xFF,
+				       cmd[i]);
+		}
+	}
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF, (u8) byte_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_H, 0xFF,
+		       (u8) (byte_cnt >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_L, 0xFF, (u8) blk_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_H, 0xFF,
+		       (u8) (blk_cnt >> 8));
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1, 0x03, bus_width);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF,
+		       SD_CALCULATE_CRC7 | SD_CHECK_CRC16 | SD_NO_WAIT_BUSY_END
+		       | SD_CHECK_CRC7 | SD_RSP_LEN_6);
+	if (trans_mode != SD_TM_AUTO_TUNING) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+			       PINGPONG_BUFFER);
+	}
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+		       trans_mode | SD_TRANSFER_START);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER, SD_TRANSFER_END,
+		       SD_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 1, timeout);
+
+	if (CHECK_SD_TRANS_FAIL(chip, retval)) {
+		sd_print_debug_reg(chip);
+		if (retval == STATUS_TIMEDOUT) {
+			sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+					    SD_RSP_TYPE_R1, NULL, 0);
+		}
+
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (buf && buf_len) {
+		retval = rts51x_read_ppbuf(chip, buf, buf_len);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_write_data(struct rts51x_chip *chip, u8 trans_mode,
+			 u8 *cmd, int cmd_len, u16 byte_cnt, u16 blk_cnt,
+			 u8 bus_width, u8 *buf, int buf_len, int timeout)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	int i;
+
+	sd_clr_err_code(chip);
+
+	if (!buf)
+		buf_len = 0;
+
+	/* This function can't write data more than one page */
+	if (buf_len > 512)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if (buf && buf_len) {
+		retval = rts51x_write_ppbuf(chip, buf, buf_len);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	rts51x_init_cmd(chip);
+
+	if (cmd_len) {
+		RTS51X_DEBUGP("SD/MMC CMD %d\n", cmd[0] - 0x40);
+		for (i = 0; i < (cmd_len < 6 ? cmd_len : 6); i++) {
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD0 + i, 0xFF,
+				       cmd[i]);
+		}
+	}
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF, (u8) byte_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_H, 0xFF,
+		       (u8) (byte_cnt >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_L, 0xFF, (u8) blk_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_H, 0xFF,
+		       (u8) (blk_cnt >> 8));
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1, 0x03, bus_width);
+
+	if (cmd_len) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF,
+			       SD_CALCULATE_CRC7 | SD_CHECK_CRC16 |
+			       SD_WAIT_BUSY_END | SD_CHECK_CRC7 | SD_RSP_LEN_6);
+
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF,
+			       SD_CALCULATE_CRC7 | SD_CHECK_CRC16 |
+			       SD_NO_WAIT_BUSY_END | SD_CHECK_CRC7 |
+			       SD_RSP_LEN_6);
+	}
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+		       trans_mode | SD_TRANSFER_START);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER, SD_TRANSFER_END,
+		       SD_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 1, timeout);
+
+	if (CHECK_SD_TRANS_FAIL(chip, retval)) {
+		sd_print_debug_reg(chip);
+
+		if (retval == STATUS_TIMEDOUT)
+			sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+					    SD_RSP_TYPE_R1, NULL, 0);
+
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_check_csd(struct rts51x_chip *chip, char check_wp)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	int i;
+	u8 csd_ver, trans_speed;
+	u8 rsp[16];
+
+	for (i = 0; i < 6; i++) {
+		if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST) {
+			sd_set_reset_fail(chip, SD_RESET_FAIL);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		retval =
+		    sd_send_cmd_get_rsp(chip, SEND_CSD, sd_card->sd_addr,
+					SD_RSP_TYPE_R2, rsp, 16);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+
+	if (i == 6)
+		TRACE_RET(chip, STATUS_FAIL);
+	memcpy(sd_card->raw_csd, rsp + 1, 15);
+	/* Get CRC7 */
+	RTS51X_READ_REG(chip, SD_CMD5, sd_card->raw_csd + 15);
+
+	RTS51X_DEBUGP("CSD Response:\n");
+	RTS51X_DUMP(rsp, 16);
+
+	/* Get CSD Version */
+	csd_ver = (rsp[1] & 0xc0) >> 6;
+	RTS51X_DEBUGP("csd_ver = %d\n", csd_ver);
+
+	trans_speed = rsp[4];
+	if ((trans_speed & 0x07) == 0x02) {	/* 10Mbits/s */
+		if ((trans_speed & 0xf8) >= 0x30) {	/* >25Mbits/s */
+			if (chip->asic_code)
+				sd_card->sd_clock = 46;
+			else
+				sd_card->sd_clock = CLK_50;
+		} else if ((trans_speed & 0xf8) == 0x28) { /* 20Mbits/s */
+			if (chip->asic_code)
+				sd_card->sd_clock = 39;
+			else
+				sd_card->sd_clock = CLK_40;
+		} else if ((trans_speed & 0xf8) == 0x20) { /* 15Mbits/s */
+			if (chip->asic_code)
+				sd_card->sd_clock = 29;
+			else
+				sd_card->sd_clock = CLK_30;
+		} else if ((trans_speed & 0xf8) >= 0x10) { /* 12Mbits/s */
+			if (chip->asic_code)
+				sd_card->sd_clock = 23;
+			else
+				sd_card->sd_clock = CLK_20;
+		} else if ((trans_speed & 0x08) >= 0x08) { /* 10Mbits/s */
+			if (chip->asic_code)
+				sd_card->sd_clock = 19;
+			else
+				sd_card->sd_clock = CLK_20;
+		} /*else { */
+			/*If this ,then slow card will use 30M clock */
+			/* TRACE_RET(chip, STATUS_FAIL); */
+		/* } */
+	}
+	/*else {
+	   TRACE_RET(chip, STATUS_FAIL);
+	   } */
+	if (CHK_MMC_SECTOR_MODE(sd_card)) {
+		sd_card->capacity = 0;
+	} else {
+		/* For High-Capacity Card, CSD_STRUCTURE always be "0x1" */
+		if ((!CHK_SD_HCXC(sd_card)) || (csd_ver == 0)) {
+			/* Calculate total sector according to C_SIZE,
+			 * C_SIZE_MULT & READ_BL_LEN */
+			u8 blk_size, c_size_mult;
+			u16 c_size;
+			/* Get READ_BL_LEN */
+			blk_size = rsp[6] & 0x0F;
+			/* Get C_SIZE */
+			c_size = ((u16) (rsp[7] & 0x03) << 10)
+			    + ((u16) rsp[8] << 2)
+			    + ((u16) (rsp[9] & 0xC0) >> 6);
+			/* Get C_SIZE_MUL */
+			c_size_mult = (u8) ((rsp[10] & 0x03) << 1);
+			c_size_mult += (rsp[11] & 0x80) >> 7;
+			/* Calculate total Capacity  */
+			sd_card->capacity =
+			    (((u32) (c_size + 1)) *
+			     (1 << (c_size_mult + 2))) << (blk_size - 9);
+		} else {
+			/* High Capacity Card and Use CSD2.0 Version */
+			u32 total_sector = 0;
+			total_sector = (((u32) rsp[8] & 0x3f) << 16) |
+			    ((u32) rsp[9] << 8) | (u32) rsp[10];
+			/* Total Capacity= (C_SIZE+1) *
+			 * 512K Byte = (C_SIZE+1)K Sector,1K = 1024 Bytes */
+			sd_card->capacity = (total_sector + 1) << 10;
+		}
+	}
+
+	/* We need check Write-Protected Status by Field PERM WP or TEMP WP */
+	if (check_wp) {
+		if (rsp[15] & 0x30)
+			chip->card_wp |= SD_CARD;
+		RTS51X_DEBUGP("CSD WP Status: 0x%x\n", rsp[15]);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_set_sample_push_timing(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+
+	rts51x_init_cmd(chip);
+
+	if (CHK_SD_SDR104(sd_card) || CHK_SD_SDR50(sd_card)) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1,
+			       0x0C | SD_ASYNC_FIFO_RST,
+			       SD_30_MODE | SD_ASYNC_FIFO_RST);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_SOURCE, 0xFF,
+			       CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+	} else if (CHK_SD_DDR50(sd_card) || CHK_MMC_DDR52(sd_card)) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1,
+			       0x0C | SD_ASYNC_FIFO_RST,
+			       SD_DDR_MODE | SD_ASYNC_FIFO_RST);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_SOURCE, 0xFF,
+			       CRC_VAR_CLK0 | SD30_FIX_CLK | SAMPLE_VAR_CLK1);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_PUSH_POINT_CTL,
+			       DDR_VAR_TX_CMD_DAT, DDR_VAR_TX_CMD_DAT);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_SAMPLE_POINT_CTL,
+			       DDR_VAR_RX_DAT | DDR_VAR_RX_CMD,
+			       DDR_VAR_RX_DAT | DDR_VAR_RX_CMD);
+	} else {
+		u8 val = 0;
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1, 0x0C, SD_20_MODE);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_SOURCE, 0xFF,
+			       CRC_FIX_CLK | SD30_VAR_CLK0 | SAMPLE_VAR_CLK1);
+
+		if ((chip->option.sd_ctl & SD_PUSH_POINT_CTL_MASK) ==
+		    SD_PUSH_POINT_AUTO) {
+			val = SD20_TX_NEG_EDGE;
+		} else if ((chip->option.sd_ctl & SD_PUSH_POINT_CTL_MASK) ==
+			   SD_PUSH_POINT_DELAY) {
+			val = SD20_TX_14_AHEAD;
+		} else {
+			val = SD20_TX_NEG_EDGE;
+		}
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_PUSH_POINT_CTL,
+			       SD20_TX_SEL_MASK, val);
+
+		if ((chip->option.sd_ctl & SD_SAMPLE_POINT_CTL_MASK) ==
+		    SD_SAMPLE_POINT_AUTO) {
+			if (chip->asic_code) {
+				if (CHK_SD_HS(sd_card) || CHK_MMC_52M(sd_card))
+					val = SD20_RX_14_DELAY;
+				else
+					val = SD20_RX_POS_EDGE;
+			} else {
+				val = SD20_RX_14_DELAY;
+			}
+		} else if ((chip->option.sd_ctl & SD_SAMPLE_POINT_CTL_MASK) ==
+			   SD_SAMPLE_POINT_DELAY) {
+			val = SD20_RX_14_DELAY;
+		} else {
+			val = SD20_RX_POS_EDGE;
+		}
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_SAMPLE_POINT_CTL,
+			       SD20_RX_SEL_MASK, val);
+	}
+
+	if (CHK_MMC_DDR52(sd_card) && CHK_MMC_8BIT(sd_card)) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DMA1_CTL,
+			       EXTEND_DMA1_ASYNC_SIGNAL, 0);
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static void sd_choose_proper_clock(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+
+	if (CHK_SD_SDR104(sd_card)) {
+		if (chip->asic_code)
+			sd_card->sd_clock = chip->option.asic_sd_sdr104_clk;
+		else
+			sd_card->sd_clock = chip->option.fpga_sd_sdr104_clk;
+	} else if (CHK_SD_DDR50(sd_card)) {
+		if (chip->asic_code)
+			sd_card->sd_clock = chip->option.asic_sd_ddr50_clk;
+		else
+			sd_card->sd_clock = chip->option.fpga_sd_ddr50_clk;
+	} else if (CHK_SD_SDR50(sd_card)) {
+		if (chip->asic_code)
+			sd_card->sd_clock = chip->option.asic_sd_sdr50_clk;
+		else
+			sd_card->sd_clock = chip->option.fpga_sd_sdr50_clk;
+	} else if (CHK_SD_HS(sd_card)) {
+		if (chip->asic_code)
+			sd_card->sd_clock = chip->option.asic_sd_hs_clk;
+		else
+			sd_card->sd_clock = chip->option.fpga_sd_hs_clk;
+	} else if (CHK_MMC_52M(sd_card) || CHK_MMC_DDR52(sd_card)) {
+		if (chip->asic_code)
+			sd_card->sd_clock = chip->option.asic_mmc_52m_clk;
+		else
+			sd_card->sd_clock = chip->option.fpga_mmc_52m_clk;
+	} else if (CHK_MMC_26M(sd_card)) {
+		if (chip->asic_code) {
+			sd_card->sd_clock = 46;
+			RTS51X_DEBUGP("Set MMC clock to 22.5MHz\n");
+		} else {
+			sd_card->sd_clock = CLK_50;
+		}
+	}
+}
+
+static int sd_set_init_para(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+
+	retval = sd_set_sample_push_timing(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	sd_choose_proper_clock(chip);
+
+	retval = switch_clock(chip, sd_card->sd_clock);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_sd_select_card(struct rts51x_chip *chip, int select)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 cmd_idx, cmd_type;
+	u32 addr;
+
+	if (select) {
+		cmd_idx = SELECT_CARD;
+		cmd_type = SD_RSP_TYPE_R1;
+		addr = sd_card->sd_addr;
+	} else {
+		cmd_idx = DESELECT_CARD;
+		cmd_type = SD_RSP_TYPE_R0;
+		addr = 0;
+	}
+
+	retval = sd_send_cmd_get_rsp(chip, cmd_idx, addr, cmd_type, NULL, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_wait_currentstate_dataready(struct rts51x_chip *chip, u8 statechk,
+				   u8 rdychk, u16 pollingcnt)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 rsp[5];
+	u16 i;
+
+	for (i = 0; i < pollingcnt; i++) {
+
+		retval =
+		    sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+					SD_RSP_TYPE_R1, rsp, 5);
+		if (retval == STATUS_SUCCESS) {
+			if (((rsp[3] & 0x1E) == statechk)
+			    && ((rsp[3] & 0x01) == rdychk)) {
+				return STATUS_SUCCESS;
+			}
+		} else {
+			rts51x_clear_sd_error(chip);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	return STATUS_TIMEDOUT;
+}
+
+static int sd_voltage_switch(struct rts51x_chip *chip)
+{
+	int retval;
+	u8 stat;
+
+	RTS51X_WRITE_REG(chip, SD_BUS_STAT,
+			 SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP,
+			 SD_CLK_TOGGLE_EN);
+
+	retval =
+	    sd_send_cmd_get_rsp(chip, VOLTAGE_SWITCH, 0, SD_RSP_TYPE_R1, NULL,
+				0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_READ_REG(chip, SD_BUS_STAT, &stat);
+	if (stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
+		    SD_DAT1_STATUS | SD_DAT0_STATUS))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	rts51x_init_cmd(chip);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BUS_STAT, 0xFF,
+		       SD_CLK_FORCE_STOP);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_PAD_CTL, SD_IO_USING_1V8,
+		       SD_IO_USING_1V8);
+	if (chip->asic_code)
+		rts51x_add_cmd(chip, WRITE_REG_CMD, LDO_POWER_CFG,
+			       TUNE_SD18_MASK, TUNE_SD18_1V8);
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	wait_timeout(chip->option.D3318_off_delay);
+
+	RTS51X_WRITE_REG(chip, SD_BUS_STAT, 0xFF, SD_CLK_TOGGLE_EN);
+	wait_timeout(10);
+
+	RTS51X_READ_REG(chip, SD_BUS_STAT, &stat);
+	if ((stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
+		     SD_DAT1_STATUS | SD_DAT0_STATUS)) !=
+	    (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
+	     SD_DAT1_STATUS | SD_DAT0_STATUS)) {
+		rts51x_init_cmd(chip);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BUS_STAT, 0xFF,
+			       SD_CLK_FORCE_STOP);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_EN, 0xFF, 0);
+		rts51x_send_cmd(chip, MODE_C, 100);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	RTS51X_WRITE_REG(chip, SD_BUS_STAT,
+			 SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_change_phase(struct rts51x_chip *chip, u8 sample_point,
+			   u8 tune_dir)
+{
+	u16 SD_VP_CTL, SD_DCMPS_CTL;
+	u8 val;
+	int retval;
+
+	RTS51X_DEBUGP("sd_change_phase (sample_point = %d, tune_dir = %d)\n",
+		       sample_point, tune_dir);
+
+	if (tune_dir == TUNE_RX) {
+		SD_VP_CTL = SD_VPCLK1_CTL;
+		SD_DCMPS_CTL = SD_DCMPS1_CTL;
+	} else {
+		SD_VP_CTL = SD_VPCLK0_CTL;
+		SD_DCMPS_CTL = SD_DCMPS0_CTL;
+	}
+
+	if (chip->asic_code) {
+		RTS51X_WRITE_REG(chip, CLK_DIV, CLK_CHANGE, CLK_CHANGE);
+		RTS51X_WRITE_REG(chip, SD_VP_CTL, 0x1F, sample_point);
+		RTS51X_WRITE_REG(chip, SD_VPCLK0_CTL, PHASE_NOT_RESET, 0);
+		RTS51X_WRITE_REG(chip, SD_VPCLK0_CTL, PHASE_NOT_RESET,
+				 PHASE_NOT_RESET);
+		RTS51X_WRITE_REG(chip, CLK_DIV, CLK_CHANGE, 0);
+	} else {
+#ifdef CONFIG_RTS5139_DEBUG
+		RTS51X_READ_REG(chip, SD_VP_CTL, &val);
+		RTS51X_DEBUGP("SD_VP_CTL: 0x%x\n", val);
+		RTS51X_READ_REG(chip, SD_DCMPS_CTL, &val);
+		RTS51X_DEBUGP("SD_DCMPS_CTL: 0x%x\n", val);
+#endif
+
+		RTS51X_WRITE_REG(chip, CLK_DIV, CLK_CHANGE, CLK_CHANGE);
+		udelay(100);
+		RTS51X_WRITE_REG(chip, SD_VP_CTL, 0xFF,
+				 PHASE_NOT_RESET | sample_point);
+		udelay(200);
+
+		rts51x_init_cmd(chip);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_DCMPS_CTL, DCMPS_CHANGE,
+			       DCMPS_CHANGE);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, SD_DCMPS_CTL,
+			       DCMPS_CHANGE_DONE, DCMPS_CHANGE_DONE);
+		retval = rts51x_send_cmd(chip, MODE_CR, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, Fail);
+
+		retval = rts51x_get_rsp(chip, 1, 500);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, Fail);
+
+		val = chip->rsp_buf[0];
+		if (val & DCMPS_ERROR)
+			TRACE_GOTO(chip, Fail);
+		if ((val & DCMPS_CURRENT_PHASE) != sample_point)
+			TRACE_GOTO(chip, Fail);
+		RTS51X_WRITE_REG(chip, SD_DCMPS_CTL, DCMPS_CHANGE, 0);
+		RTS51X_WRITE_REG(chip, CLK_DIV, CLK_CHANGE, 0);
+		udelay(100);
+	}
+
+	RTS51X_WRITE_REG(chip, SD_CFG1, SD_ASYNC_FIFO_RST, 0);
+
+	return STATUS_SUCCESS;
+
+Fail:
+#ifdef CONFIG_RTS5139_DEBUG
+	rts51x_ep0_read_register(chip, SD_VP_CTL, &val);
+	RTS51X_DEBUGP("SD_VP_CTL: 0x%x\n", val);
+	rts51x_ep0_read_register(chip, SD_DCMPS_CTL, &val);
+	RTS51X_DEBUGP("SD_DCMPS_CTL: 0x%x\n", val);
+#endif
+
+	RTS51X_WRITE_REG(chip, SD_DCMPS_CTL, DCMPS_CHANGE, 0);
+	RTS51X_WRITE_REG(chip, SD_VP_CTL, PHASE_CHANGE, 0);
+	wait_timeout(10);
+
+	return STATUS_FAIL;
+}
+
+static int sd_check_spec(struct rts51x_chip *chip, u8 bus_width)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 cmd[5], buf[8];
+
+	retval =
+	    sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr, SD_RSP_TYPE_R1,
+				NULL, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	cmd[0] = 0x40 | SEND_SCR;
+	cmd[1] = 0;
+	cmd[2] = 0;
+	cmd[3] = 0;
+	cmd[4] = 0;
+
+	retval =
+	    sd_read_data(chip, SD_TM_NORMAL_READ, cmd, 5, 8, 1, bus_width, buf,
+			 8, 250);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_sd_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	memcpy(sd_card->raw_scr, buf, 8);
+
+	if ((buf[0] & 0x0F) == 0)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_query_switch_result(struct rts51x_chip *chip, u8 func_group,
+				  u8 func_to_switch, u8 *buf, int buf_len)
+{
+	u8 support_mask = 0, query_switch = 0, switch_busy = 0;
+	int support_offset = 0, query_switch_offset = 0, check_busy_offset = 0;
+
+	if (func_group == SD_FUNC_GROUP_1) {
+		support_offset = FUNCTION_GROUP1_SUPPORT_OFFSET;
+		query_switch_offset = FUNCTION_GROUP1_QUERY_SWITCH_OFFSET;
+		check_busy_offset = FUNCTION_GROUP1_CHECK_BUSY_OFFSET;
+
+		switch (func_to_switch) {
+		case HS_SUPPORT:
+			support_mask = HS_SUPPORT_MASK;
+			query_switch = HS_QUERY_SWITCH_OK;
+			switch_busy = HS_SWITCH_BUSY;
+			break;
+
+		case SDR50_SUPPORT:
+			support_mask = SDR50_SUPPORT_MASK;
+			query_switch = SDR50_QUERY_SWITCH_OK;
+			switch_busy = SDR50_SWITCH_BUSY;
+			break;
+
+		case SDR104_SUPPORT:
+			support_mask = SDR104_SUPPORT_MASK;
+			query_switch = SDR104_QUERY_SWITCH_OK;
+			switch_busy = SDR104_SWITCH_BUSY;
+			break;
+
+		case DDR50_SUPPORT:
+			support_mask = DDR50_SUPPORT_MASK;
+			query_switch = DDR50_QUERY_SWITCH_OK;
+			switch_busy = DDR50_SWITCH_BUSY;
+			break;
+
+		default:
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	} else if (func_group == SD_FUNC_GROUP_3) {
+		support_offset = FUNCTION_GROUP3_SUPPORT_OFFSET;
+		query_switch_offset = FUNCTION_GROUP3_QUERY_SWITCH_OFFSET;
+		check_busy_offset = FUNCTION_GROUP3_CHECK_BUSY_OFFSET;
+
+		switch (func_to_switch) {
+		case DRIVING_TYPE_A:
+			support_mask = DRIVING_TYPE_A_MASK;
+			query_switch = TYPE_A_QUERY_SWITCH_OK;
+			switch_busy = TYPE_A_SWITCH_BUSY;
+			break;
+
+		case DRIVING_TYPE_C:
+			support_mask = DRIVING_TYPE_C_MASK;
+			query_switch = TYPE_C_QUERY_SWITCH_OK;
+			switch_busy = TYPE_C_SWITCH_BUSY;
+			break;
+
+		case DRIVING_TYPE_D:
+			support_mask = DRIVING_TYPE_D_MASK;
+			query_switch = TYPE_D_QUERY_SWITCH_OK;
+			switch_busy = TYPE_D_SWITCH_BUSY;
+			break;
+
+		default:
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	} else if (func_group == SD_FUNC_GROUP_4) {
+		support_offset = FUNCTION_GROUP4_SUPPORT_OFFSET;
+		query_switch_offset = FUNCTION_GROUP4_QUERY_SWITCH_OFFSET;
+		check_busy_offset = FUNCTION_GROUP4_CHECK_BUSY_OFFSET;
+
+		switch (func_to_switch) {
+		case CURRENT_LIMIT_400:
+			support_mask = CURRENT_LIMIT_400_MASK;
+			query_switch = CURRENT_LIMIT_400_QUERY_SWITCH_OK;
+			switch_busy = CURRENT_LIMIT_400_SWITCH_BUSY;
+			break;
+
+		case CURRENT_LIMIT_600:
+			support_mask = CURRENT_LIMIT_600_MASK;
+			query_switch = CURRENT_LIMIT_600_QUERY_SWITCH_OK;
+			switch_busy = CURRENT_LIMIT_600_SWITCH_BUSY;
+			break;
+
+		case CURRENT_LIMIT_800:
+			support_mask = CURRENT_LIMIT_800_MASK;
+			query_switch = CURRENT_LIMIT_800_QUERY_SWITCH_OK;
+			switch_busy = CURRENT_LIMIT_800_SWITCH_BUSY;
+			break;
+
+		default:
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	} else {
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (func_group == SD_FUNC_GROUP_4)
+		buf[query_switch_offset] =
+		    (buf[query_switch_offset] & 0xf0) >> 4;
+	if (!(buf[support_offset] & support_mask) ||
+	    ((buf[query_switch_offset] & 0x0F) != query_switch))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if ((buf[DATA_STRUCTURE_VER_OFFSET] == 0x01) &&
+	    ((buf[check_busy_offset] & switch_busy) == switch_busy))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_check_switch_mode(struct rts51x_chip *chip, u8 mode,
+				u8 func_group, u8 func_to_switch, u8 bus_width)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 cmd[5], buf[64];
+
+	RTS51X_DEBUGP("sd_check_switch_mode (mode = %d, func_group = %d,"
+		"func_to_switch = %d)\n", mode, func_group, func_to_switch);
+
+	cmd[0] = 0x40 | SWITCH;
+	cmd[1] = mode;
+
+	if (func_group == SD_FUNC_GROUP_1) {
+		cmd[2] = 0xFF;
+		cmd[3] = 0xFF;
+		cmd[4] = 0xF0 + func_to_switch;
+	} else if (func_group == SD_FUNC_GROUP_3) {
+		cmd[2] = 0xFF;
+		cmd[3] = 0xF0 + func_to_switch;
+		cmd[4] = 0xFF;
+	} else if (func_group == SD_FUNC_GROUP_4) {
+		cmd[2] = 0xFF;
+		cmd[3] = 0x0F + (func_to_switch << 4);
+		cmd[4] = 0xFF;
+	} else {
+		cmd[1] = SD_CHECK_MODE;
+		cmd[2] = 0xFF;
+		cmd[3] = 0xFF;
+		cmd[4] = 0xFF;
+	}
+
+	retval =
+	    sd_read_data(chip, SD_TM_NORMAL_READ, cmd, 5, 64, 1, bus_width, buf,
+			 64, 250);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_sd_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	if (func_group == NO_ARGUMENT) {
+		sd_card->func_group1_mask = buf[0x0D];
+		sd_card->func_group2_mask = buf[0x0B];
+		sd_card->func_group3_mask = buf[0x09];
+		sd_card->func_group4_mask = buf[0x07];
+
+		RTS51X_DEBUGP("func_group1_mask = 0x%02x\n", buf[0x0D]);
+		RTS51X_DEBUGP("func_group2_mask = 0x%02x\n", buf[0x0B]);
+		RTS51X_DEBUGP("func_group3_mask = 0x%02x\n", buf[0x09]);
+		RTS51X_DEBUGP("func_group4_mask = 0x%02x\n", buf[0x07]);
+	} else {
+		if ((buf[0] == 0) && (buf[1] == 0))
+			TRACE_RET(chip, STATUS_FAIL);
+		retval =
+		    sd_query_switch_result(chip, func_group, func_to_switch,
+					   buf, 64);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_check_switch(struct rts51x_chip *chip,
+			   u8 func_group, u8 func_to_switch, u8 bus_width)
+{
+	int retval;
+	int i;
+	int switch_good = 0;
+
+	for (i = 0; i < 3; i++) {
+		if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST) {
+			sd_set_reset_fail(chip, SD_RESET_FAIL);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		retval = sd_check_switch_mode(chip, SD_CHECK_MODE, func_group,
+					      func_to_switch, bus_width);
+		if (retval == STATUS_SUCCESS) {
+			u8 stat;
+
+			retval = sd_check_switch_mode(chip, SD_SWITCH_MODE,
+					func_group, func_to_switch, bus_width);
+			if (retval == STATUS_SUCCESS) {
+				switch_good = 1;
+				break;
+			}
+
+			RTS51X_READ_REG(chip, SD_STAT1, &stat);
+
+			if (stat & SD_CRC16_ERR) {
+				RTS51X_DEBUGP("SD CRC16 error when switching"
+							"mode\n");
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		wait_timeout(20);
+	}
+
+	if (!switch_good)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_switch_function(struct rts51x_chip *chip, u8 bus_width)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	int i;
+	u8 func_to_switch = 0;
+
+	/* Get supported functions */
+	retval = sd_check_switch_mode(chip, SD_CHECK_MODE,
+				      NO_ARGUMENT, NO_ARGUMENT, bus_width);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	sd_card->func_group1_mask &= ~(sd_card->sd_switch_fail);
+
+	for (i = 0; i < 4; i++) {
+		switch ((u8) (chip->option.sd_speed_prior >> (i * 8))) {
+		case DDR50_SUPPORT:
+			if ((sd_card->func_group1_mask & DDR50_SUPPORT_MASK)
+			    && (CHECK_UHS50(chip)))
+				func_to_switch = DDR50_SUPPORT;
+			break;
+
+		case SDR50_SUPPORT:
+			if ((sd_card->func_group1_mask & SDR50_SUPPORT_MASK)
+			    && (CHECK_UHS50(chip)))
+				func_to_switch = SDR50_SUPPORT;
+			break;
+
+		case HS_SUPPORT:
+			if (sd_card->func_group1_mask & HS_SUPPORT_MASK)
+				func_to_switch = HS_SUPPORT;
+			break;
+
+		default:
+			continue;
+		}
+
+		if (func_to_switch)
+			break;
+	}
+	RTS51X_DEBUGP("SD_FUNC_GROUP_1: func_to_switch = 0x%02x",
+		       func_to_switch);
+
+	if (func_to_switch) {
+		retval =
+		    sd_check_switch(chip, SD_FUNC_GROUP_1, func_to_switch,
+				    bus_width);
+		if (retval != STATUS_SUCCESS) {
+			if (func_to_switch == SDR104_SUPPORT)
+				sd_card->sd_switch_fail = SDR104_SUPPORT_MASK;
+			else if (func_to_switch == DDR50_SUPPORT)
+				sd_card->sd_switch_fail = DDR50_SUPPORT_MASK;
+			else if (func_to_switch == SDR50_SUPPORT)
+				sd_card->sd_switch_fail = SDR50_SUPPORT_MASK;
+			else if (func_to_switch == HS_SUPPORT)
+				sd_card->sd_switch_fail = HS_SUPPORT_MASK;
+
+			TRACE_RET(chip, retval);
+		}
+
+		if (func_to_switch == SDR104_SUPPORT)
+			SET_SD_SDR104(sd_card);
+		else if (func_to_switch == DDR50_SUPPORT)
+			SET_SD_DDR50(sd_card);
+		else if (func_to_switch == SDR50_SUPPORT)
+			SET_SD_SDR50(sd_card);
+		else
+			SET_SD_HS(sd_card);
+	}
+
+	if (CHK_SD_DDR50(sd_card))
+		RTS51X_WRITE_REG(chip, SD_CFG1, 0x0C, SD_DDR_MODE);
+
+	func_to_switch = 0;
+	if (sd_card->func_group4_mask & CURRENT_LIMIT_400_MASK)
+		func_to_switch = CURRENT_LIMIT_400;
+
+	if (func_to_switch) {
+		RTS51X_DEBUGP("Try to switch current_limit_400\n");
+		retval =
+		    sd_check_switch(chip, SD_FUNC_GROUP_4, func_to_switch,
+				    bus_width);
+		RTS51X_DEBUGP("Switch current_limit_400 status: (%d)\n",
+			       retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_wait_data_idle(struct rts51x_chip *chip)
+{
+	int retval = STATUS_TIMEDOUT;
+	int i;
+	u8 val = 0;
+
+	for (i = 0; i < 100; i++) {
+		retval = rts51x_ep0_read_register(chip, SD_DATA_STATE, &val);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, STATUS_FAIL);
+		if (val & SD_DATA_IDLE) {
+			retval = STATUS_SUCCESS;
+			break;
+		}
+		udelay(100);
+	}
+	RTS51X_DEBUGP("SD_DATA_STATE: 0x%02x\n", val);
+
+	return retval;
+}
+
+static int sd_sdr_tuning_rx_cmd(struct rts51x_chip *chip, u8 sample_point)
+{
+	int retval;
+	u8 cmd[5];
+
+	retval = sd_change_phase(chip, sample_point, TUNE_RX);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	cmd[0] = 0x40 | SEND_TUNING_PATTERN;
+	cmd[1] = 0;
+	cmd[2] = 0;
+	cmd[3] = 0;
+	cmd[4] = 0;
+
+	retval = sd_read_data(chip, SD_TM_AUTO_TUNING,
+			      cmd, 5, 0x40, 1, SD_BUS_WIDTH_4, NULL, 0, 100);
+	if (retval != STATUS_SUCCESS) {
+		/* Wait till SD DATA IDLE */
+		(void)sd_wait_data_idle(chip);
+
+		rts51x_clear_sd_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_ddr_tuning_rx_cmd(struct rts51x_chip *chip, u8 sample_point)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 cmd[5];
+
+	retval = sd_change_phase(chip, sample_point, TUNE_RX);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_DEBUGP("sd ddr tuning rx\n");
+
+	retval =
+	    sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr, SD_RSP_TYPE_R1,
+				NULL, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	cmd[0] = 0x40 | SD_STATUS;
+	cmd[1] = 0;
+	cmd[2] = 0;
+	cmd[3] = 0;
+	cmd[4] = 0;
+
+	retval = sd_read_data(chip, SD_TM_NORMAL_READ,
+			      cmd, 5, 64, 1, SD_BUS_WIDTH_4, NULL, 0, 100);
+	if (retval != STATUS_SUCCESS) {
+		/* Wait till SD DATA IDLE */
+		(void)sd_wait_data_idle(chip);
+
+		rts51x_clear_sd_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int mmc_ddr_tunning_rx_cmd(struct rts51x_chip *chip, u8 sample_point)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 cmd[5], bus_width;
+
+	if (CHK_MMC_8BIT(sd_card))
+		bus_width = SD_BUS_WIDTH_8;
+	else if (CHK_MMC_4BIT(sd_card))
+		bus_width = SD_BUS_WIDTH_4;
+	else
+		bus_width = SD_BUS_WIDTH_1;
+
+	retval = sd_change_phase(chip, sample_point, TUNE_RX);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_DEBUGP("mmc ddr tuning rx\n");
+
+	cmd[0] = 0x40 | SEND_EXT_CSD;
+	cmd[1] = 0;
+	cmd[2] = 0;
+	cmd[3] = 0;
+	cmd[4] = 0;
+
+	retval = sd_read_data(chip, SD_TM_NORMAL_READ,
+			      cmd, 5, 0x200, 1, bus_width, NULL, 0, 100);
+	if (retval != STATUS_SUCCESS) {
+		/* Wait till SD DATA IDLE */
+		(void)sd_wait_data_idle(chip);
+
+		rts51x_clear_sd_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_sdr_tuning_tx_cmd(struct rts51x_chip *chip, u8 sample_point)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+
+	retval = sd_change_phase(chip, sample_point, TUNE_TX);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_WRITE_REG(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
+			 SD_RSP_80CLK_TIMEOUT_EN);
+
+	retval = sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+				     SD_RSP_TYPE_R1, NULL, 0);
+	if (retval != STATUS_SUCCESS) {
+		if (sd_check_err_code(chip, SD_RSP_TIMEOUT)) {
+			/* Tunning TX fail */
+			rts51x_ep0_write_register(chip, SD_CFG3,
+						  SD_RSP_80CLK_TIMEOUT_EN, 0);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	RTS51X_WRITE_REG(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN, 0);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_ddr_tuning_tx_cmd(struct rts51x_chip *chip, u8 sample_point)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 cmd[5], bus_width;
+
+	retval = sd_change_phase(chip, sample_point, TUNE_TX);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (CHK_SD(sd_card)) {
+		bus_width = SD_BUS_WIDTH_4;
+	} else {
+		if (CHK_MMC_8BIT(sd_card))
+			bus_width = SD_BUS_WIDTH_8;
+		else if (CHK_MMC_4BIT(sd_card))
+			bus_width = SD_BUS_WIDTH_4;
+		else
+			bus_width = SD_BUS_WIDTH_1;
+	}
+	retval = sd_wait_currentstate_dataready(chip, 0x08, 1, 20);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	RTS51X_WRITE_REG(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
+			 SD_RSP_80CLK_TIMEOUT_EN);
+
+	cmd[0] = 0x40 | PROGRAM_CSD;
+	cmd[1] = 0;
+	cmd[2] = 0;
+	cmd[3] = 0;
+	cmd[4] = 0;
+
+	retval = sd_write_data(chip, SD_TM_AUTO_WRITE_2,
+			cmd, 5, 16, 1, bus_width, sd_card->raw_csd, 16, 100);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_sd_error(chip);
+		/* Tunning TX fail */
+		rts51x_ep0_write_register(chip, SD_CFG3,
+					  SD_RSP_80CLK_TIMEOUT_EN, 0);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	RTS51X_WRITE_REG(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN, 0);
+
+	sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr, SD_RSP_TYPE_R1,
+			    NULL, 0);
+
+	return STATUS_SUCCESS;
+}
+
+static u8 sd_search_final_phase(struct rts51x_chip *chip, u32 phase_map,
+				u8 tune_dir)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	struct timing_phase_path path[MAX_PHASE + 1];
+	int i, j, cont_path_cnt;
+	int new_block, max_len;
+	u8 final_phase = 0xFF;
+	int final_path_idx;
+
+	if (phase_map == 0xffff) {
+		if (CHK_SD_DDR50(sd_card)) {
+			if (tune_dir == TUNE_TX)
+				final_phase = chip->option.ddr50_tx_phase;
+			else
+				final_phase = chip->option.ddr50_rx_phase;
+			RTS51X_DEBUGP("DDR50 tuning dir:%d all pass,"
+					"so select default phase:0x%x.\n",
+					tune_dir, final_phase);
+		} else {
+			if (tune_dir == TUNE_TX)
+				final_phase = chip->option.sdr50_tx_phase;
+			else
+				final_phase = chip->option.sdr50_rx_phase;
+			RTS51X_DEBUGP("SDR50 tuning dir:%d all pass,"
+					"so select default phase:0x%x.\n",
+					tune_dir, final_phase);
+		}
+		goto Search_Finish;
+	}
+
+	cont_path_cnt = 0;
+	new_block = 1;
+	j = 0;
+	for (i = 0; i < MAX_PHASE + 1; i++) {
+		if (phase_map & (1 << i)) {
+			if (new_block) {
+				new_block = 0;
+				j = cont_path_cnt++;
+				path[j].start = i;
+				path[j].end = i;
+			} else {
+				path[j].end = i;
+			}
+		} else {
+			new_block = 1;
+			if (cont_path_cnt) {
+				int idx = cont_path_cnt - 1;
+				path[idx].len =
+				    path[idx].end - path[idx].start + 1;
+				path[idx].mid =
+				    path[idx].start + path[idx].len / 2;
+			}
+		}
+	}
+
+	if (cont_path_cnt == 0) {
+		RTS51X_DEBUGP("No continuous phase path\n");
+		goto Search_Finish;
+	} else {
+		int idx = cont_path_cnt - 1;
+		path[idx].len = path[idx].end - path[idx].start + 1;
+		path[idx].mid = path[idx].start + path[idx].len / 2;
+	}
+
+	if ((path[0].start == 0) &&
+			(path[cont_path_cnt - 1].end == MAX_PHASE)) {
+		path[0].start = path[cont_path_cnt - 1].start - MAX_PHASE - 1;
+		path[0].len += path[cont_path_cnt - 1].len;
+		path[0].mid = path[0].start + path[0].len / 2;
+		if (path[0].mid < 0)
+			path[0].mid += MAX_PHASE + 1;
+		cont_path_cnt--;
+	}
+	max_len = 0;
+	final_phase = 0;
+	final_path_idx = 0;
+	for (i = 0; i < cont_path_cnt; i++) {
+		if (path[i].len > max_len) {
+			max_len = path[i].len;
+			final_phase = (u8) path[i].mid;
+			final_path_idx = i;
+		}
+
+		RTS51X_DEBUGP("path[%d].start = %d\n", i, path[i].start);
+		RTS51X_DEBUGP("path[%d].end = %d\n", i, path[i].end);
+		RTS51X_DEBUGP("path[%d].len = %d\n", i, path[i].len);
+		RTS51X_DEBUGP("path[%d].mid = %d\n", i, path[i].mid);
+		RTS51X_DEBUGP("\n");
+	}
+
+	if ((tune_dir == TUNE_TX) && (CHK_SD_SDR50(sd_card))
+	    && chip->option.sdr50_phase_sel) {
+		if (max_len > 6) {
+			int temp_mid = (max_len - 6) / 2;
+			int temp_final_phase =
+			    path[final_path_idx].end - (max_len -
+							(3 + temp_mid));
+
+			if (temp_final_phase < 0)
+				final_phase = temp_final_phase + MAX_PHASE + 1;
+			else
+				final_phase = (u8) temp_final_phase;
+		}
+	}
+
+Search_Finish:
+	RTS51X_DEBUGP("Final chosen phase: %d\n", final_phase);
+	return final_phase;
+}
+
+static int sd_tuning_rx(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	int i, j;
+	u32 raw_phase_map[3], phase_map;
+	u8 final_phase;
+	int (*tuning_cmd)(struct rts51x_chip *chip, u8 sample_point);
+
+	if (CHK_SD(sd_card)) {
+		if (CHK_SD_DDR50(sd_card))
+			tuning_cmd = sd_ddr_tuning_rx_cmd;
+		else
+			tuning_cmd = sd_sdr_tuning_rx_cmd;
+	} else {
+		if (CHK_MMC_DDR52(sd_card))
+			tuning_cmd = mmc_ddr_tunning_rx_cmd;
+		else
+			TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	for (i = 0; i < 3; i++) {
+		raw_phase_map[i] = 0;
+		for (j = MAX_PHASE; j >= 0; j--) {
+			if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST) {
+				sd_set_reset_fail(chip, SD_RESET_FAIL);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			retval = tuning_cmd(chip, (u8) j);
+			if (retval == STATUS_SUCCESS)
+				raw_phase_map[i] |= 1 << j;
+			else
+				RTS51X_DEBUGP("Tuning phase %d fail\n", j);
+		}
+	}
+
+	phase_map = raw_phase_map[0] & raw_phase_map[1] & raw_phase_map[2];
+	for (i = 0; i < 3; i++)
+		RTS51X_DEBUGP("RX raw_phase_map[%d] = 0x%04x\n", i,
+			       raw_phase_map[i]);
+	RTS51X_DEBUGP("RX phase_map = 0x%04x\n", phase_map);
+
+	final_phase = sd_search_final_phase(chip, phase_map, TUNE_RX);
+	if (final_phase == 0xFF)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	retval = tuning_cmd(chip, final_phase);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_ddr_pre_tuning_tx(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 i;
+	u8 pre_tune_tx_phase;
+	u32 pre_tune_phase_map;
+
+	RTS51X_WRITE_REG(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN,
+			 SD_RSP_80CLK_TIMEOUT_EN);
+
+	pre_tune_tx_phase = 0xFF;
+	pre_tune_phase_map = 0x0000;
+	for (i = 0; i < MAX_PHASE + 1; i++) {
+		if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST) {
+			sd_set_reset_fail(chip, SD_RESET_FAIL);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		retval = sd_change_phase(chip, (u8) i, TUNE_TX);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval =
+		    sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+					SD_RSP_TYPE_R1, NULL, 0);
+		if ((retval == STATUS_SUCCESS)
+		    || !sd_check_err_code(chip, SD_RSP_TIMEOUT))
+			pre_tune_phase_map |= (u32) 1 << i;
+	}
+
+	RTS51X_WRITE_REG(chip, SD_CFG3, SD_RSP_80CLK_TIMEOUT_EN, 0);
+
+	pre_tune_tx_phase =
+	    sd_search_final_phase(chip, pre_tune_phase_map, TUNE_TX);
+	if (pre_tune_tx_phase == 0xFF)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	sd_change_phase(chip, pre_tune_tx_phase, TUNE_TX);
+	RTS51X_DEBUGP("DDR TX pre tune phase: %d\n", (int)pre_tune_tx_phase);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_tuning_tx(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	int i, j;
+	u32 raw_phase_map[3], phase_map;
+	u8 final_phase;
+	int (*tuning_cmd)(struct rts51x_chip *chip, u8 sample_point);
+
+	if (CHK_SD(sd_card)) {
+		if (CHK_SD_DDR50(sd_card))
+			tuning_cmd = sd_ddr_tuning_tx_cmd;
+		else
+			tuning_cmd = sd_sdr_tuning_tx_cmd;
+	} else {
+		if (CHK_MMC_DDR52(sd_card))
+			tuning_cmd = sd_ddr_tuning_tx_cmd;
+		else
+			TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	for (i = 0; i < 3; i++) {
+		raw_phase_map[i] = 0;
+		for (j = MAX_PHASE; j >= 0; j--) {
+			if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST) {
+				sd_set_reset_fail(chip, SD_RESET_FAIL);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			retval = tuning_cmd(chip, (u8) j);
+			if (retval == STATUS_SUCCESS)
+				raw_phase_map[i] |= 1 << j;
+			else
+				RTS51X_DEBUGP("Tuning phase %d fail\n", j);
+		}
+	}
+
+	phase_map = raw_phase_map[0] & raw_phase_map[1] & raw_phase_map[2];
+	for (i = 0; i < 3; i++)
+		RTS51X_DEBUGP("TX raw_phase_map[%d] = 0x%04x\n", i,
+			       raw_phase_map[i]);
+	RTS51X_DEBUGP("TX phase_map = 0x%04x\n", phase_map);
+
+	final_phase = sd_search_final_phase(chip, phase_map, TUNE_TX);
+	if (final_phase == 0xFF)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	retval = tuning_cmd(chip, final_phase);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_sdr_tuning(struct rts51x_chip *chip)
+{
+	int retval;
+
+	retval = sd_tuning_tx(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = sd_tuning_rx(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_ddr_tuning(struct rts51x_chip *chip)
+{
+	int retval;
+
+	if (!(chip->option.sd_ctl & SD_DDR_TX_PHASE_SET_BY_USER)) {
+		retval = sd_ddr_pre_tuning_tx(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	} else {
+		retval =
+		    sd_change_phase(chip, (u8) chip->option.sd_ddr_tx_phase,
+				    TUNE_TX);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	retval = sd_tuning_rx(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (!(chip->option.sd_ctl & SD_DDR_TX_PHASE_SET_BY_USER)) {
+		retval = sd_tuning_tx(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int mmc_ddr_tuning(struct rts51x_chip *chip)
+{
+	int retval;
+
+	if (!(chip->option.sd_ctl & MMC_DDR_TX_PHASE_SET_BY_USER)) {
+		retval = sd_ddr_pre_tuning_tx(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	} else {
+		retval =
+		    sd_change_phase(chip, (u8) chip->option.mmc_ddr_tx_phase,
+				    TUNE_TX);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	retval = sd_tuning_rx(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (!(chip->option.sd_ctl & MMC_DDR_TX_PHASE_SET_BY_USER)) {
+		retval = sd_tuning_tx(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_sd_switch_clock(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	int re_tuning = 0;
+
+	retval = rts51x_select_card(chip, SD_CARD);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (CHK_SD30_SPEED(sd_card) || CHK_MMC_DDR52(sd_card)) {
+		if (sd_card->sd_clock != chip->cur_clk)
+			re_tuning = 1;
+	}
+
+	retval = switch_clock(chip, sd_card->sd_clock);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (re_tuning) {
+		if (CHK_SD(sd_card)) {
+			if (CHK_SD_DDR50(sd_card))
+				retval = sd_ddr_tuning(chip);
+			else
+				retval = sd_sdr_tuning(chip);
+		} else {
+			if (CHK_MMC_DDR52(sd_card))
+				retval = mmc_ddr_tuning(chip);
+		}
+
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_prepare_reset(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+
+	if (chip->asic_code)
+		sd_card->sd_clock = 29;
+	else
+		sd_card->sd_clock = CLK_30;
+
+	/* Set SD Clocks */
+	retval = sd_set_init_para(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1, 0xFF,
+		       SD_CLK_DIVIDE_128 | SD_20_MODE | SD_BUS_WIDTH_1);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_SAMPLE_POINT_CTL, 0xFF,
+		       SD20_RX_POS_EDGE);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_PUSH_POINT_CTL, 0xFF, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_select_card(chip, SD_CARD);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static void sd_pull_ctl_disable(struct rts51x_chip *chip)
+{
+	if (CHECK_PKG(chip, LQFP48)) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0xA5);
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0x65);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x56);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0x59);
+	}
+}
+
+static void sd_pull_ctl_enable(struct rts51x_chip *chip)
+{
+	if (CHECK_PKG(chip, LQFP48)) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0xAA);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0xAA);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0xA9);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0xA5);
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0xA5);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x9A);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0xA5);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x9A);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x65);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0x5A);
+	}
+}
+
+static int sd_init_power(struct rts51x_chip *chip)
+{
+	int retval;
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, LDO3318_PWR_MASK,
+		       LDO_ON);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_PAD_CTL, SD_IO_USING_1V8,
+		       SD_IO_USING_3V3);
+	if (chip->asic_code)
+		rts51x_add_cmd(chip, WRITE_REG_CMD, LDO_POWER_CFG,
+			       TUNE_SD18_MASK, TUNE_SD18_3V3);
+	if (chip->asic_code)
+		sd_pull_ctl_disable(chip);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, FPGA_PULL_CTL,
+			       FPGA_SD_PULL_CTL_BIT | 0x20,
+			       FPGA_SD_PULL_CTL_BIT);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, SD_OUTPUT_EN, 0);
+	if (!chip->option.FT2_fast_mode)
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK,
+			       POWER_OFF);
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	if (!chip->option.FT2_fast_mode) {
+#ifdef SD_XD_IO_FOLLOW_PWR
+		if (CHECK_PKG(chip, LQFP48)
+		    || chip->option.rts5129_D3318_off_enable)
+			rts51x_write_register(chip, CARD_PWR_CTL,
+					LDO_OFF, LDO_OFF);
+#endif
+		wait_timeout(250);
+
+#ifdef SD_XD_IO_FOLLOW_PWR
+		if (CHECK_PKG(chip, LQFP48)
+		    || chip->option.rts5129_D3318_off_enable) {
+			rts51x_init_cmd(chip);
+			if (chip->asic_code)
+				sd_pull_ctl_enable(chip);
+			else
+				rts51x_add_cmd(chip, WRITE_REG_CMD,
+					       FPGA_PULL_CTL,
+					       FPGA_SD_PULL_CTL_BIT | 0x20, 0);
+			retval = rts51x_send_cmd(chip, MODE_C, 100);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+		} else {
+			if (chip->asic_code)
+				rts51x_write_register(chip, CARD_PULL_CTL6,
+						      0x03, 0x00);
+		}
+#endif
+
+		/* Power on card */
+		retval = rts51x_card_power_on(chip, SD_CARD);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		wait_timeout(260);
+
+#ifdef SUPPORT_OCP
+		rts51x_get_card_status(chip, &(chip->card_status));
+		chip->ocp_stat = (chip->card_status >> 4) & 0x03;
+
+		if (chip->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
+			RTS51X_DEBUGP("Over current, OCPSTAT is 0x%x\n",
+				       chip->ocp_stat);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+#endif
+	}
+
+	rts51x_init_cmd(chip);
+	if (chip->asic_code) {
+		sd_pull_ctl_enable(chip);
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, FPGA_PULL_CTL,
+			       FPGA_SD_PULL_CTL_BIT | 0x20, 0);
+	}
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+#ifdef SD_XD_IO_FOLLOW_PWR
+	rts51x_write_register(chip, CARD_INT_PEND, XD_INT | MS_INT | SD_INT,
+			      XD_INT | MS_INT | SD_INT);
+#endif
+
+	RTS51X_WRITE_REG(chip, CARD_OE, SD_OUTPUT_EN, SD_OUTPUT_EN);
+
+	return STATUS_SUCCESS;
+}
+
+static int sd_dummy_clock(struct rts51x_chip *chip)
+{
+	RTS51X_WRITE_REG(chip, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
+	wait_timeout(5);
+	RTS51X_WRITE_REG(chip, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0x00);
+
+	return STATUS_SUCCESS;
+}
+
+int reset_sd(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval, i = 0, j = 0, k = 0, hi_cap_flow = 0;
+	int sd_dont_switch = 0;
+	int support_1v8 = 0;
+	u8 rsp[16];
+	u8 switch_bus_width;
+	u32 voltage = 0;
+	u8 cmd[5], buf[64];
+	u16 sd_card_type;
+
+	SET_SD(sd_card);
+	CLR_RETRY_SD20_MODE(sd_card);
+Switch_Fail:
+	i = 0;
+	j = 0;
+	k = 0;
+	hi_cap_flow = 0;
+	support_1v8 = 0;
+
+	retval = sd_prepare_reset(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	sd_dummy_clock(chip);
+
+	/* Start Initialization Process of SD Card */
+RTY_SD_RST:
+	retval =
+	    sd_send_cmd_get_rsp(chip, GO_IDLE_STATE, 0, SD_RSP_TYPE_R0, NULL,
+				0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	wait_timeout(20);
+
+	retval =
+	    sd_send_cmd_get_rsp(chip, SEND_IF_COND, 0x000001AA, SD_RSP_TYPE_R7,
+				rsp, 5);
+	if (retval == STATUS_SUCCESS) {
+		if ((rsp[4] == 0xAA) && ((rsp[3] & 0x0f) == 0x01)) {
+			hi_cap_flow = 1;
+			if (CHK_RETRY_SD20_MODE(sd_card)) {
+				voltage =
+				    SUPPORT_VOLTAGE |
+				    SUPPORT_HIGH_AND_EXTENDED_CAPACITY;
+			} else {
+				voltage =
+				    SUPPORT_VOLTAGE |
+				    SUPPORT_HIGH_AND_EXTENDED_CAPACITY |
+				    SUPPORT_MAX_POWER_PERMANCE | SUPPORT_1V8;
+			}
+		}
+	}
+
+	if (!hi_cap_flow) {
+		voltage = SUPPORT_VOLTAGE;
+
+		retval =
+		    sd_send_cmd_get_rsp(chip, GO_IDLE_STATE, 0, SD_RSP_TYPE_R0,
+					NULL, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		wait_timeout(20);
+	}
+
+	/* ACMD41 */
+	do {
+		{
+			u8 temp = 0;
+			rts51x_read_register(chip, CARD_INT_PEND, &temp);
+			RTS51X_DEBUGP("CARD_INT_PEND:%x\n", temp);
+			if (temp & SD_INT) {
+				chip->reset_need_retry = 1;
+				rts51x_write_register(chip, CARD_INT_PEND,
+						      XD_INT | SD_INT | MS_INT,
+						      XD_INT | SD_INT | MS_INT);
+				sd_set_reset_fail(chip, SD_RESET_FAIL);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+RTY_CMD55:
+		retval =
+		    sd_send_cmd_get_rsp(chip, APP_CMD, 0, SD_RSP_TYPE_R1, NULL,
+					0);
+		if (retval != STATUS_SUCCESS) {
+			if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST) {
+				sd_set_reset_fail(chip, SD_RESET_FAIL);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			j++;
+			if (chip->option.speed_mmc) {
+				if (j < 2)
+					goto RTY_CMD55;
+				else
+					TRACE_RET(chip, STATUS_FAIL);
+			} else {
+				if (j < 3)
+					goto RTY_SD_RST;
+				else
+					TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		retval =
+		    sd_send_cmd_get_rsp(chip, SD_APP_OP_COND, voltage,
+					SD_RSP_TYPE_R3, rsp, 5);
+		if (retval != STATUS_SUCCESS) {
+			k++;
+			if (k < 3)
+				goto RTY_SD_RST;
+			else
+				TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		i++;
+		wait_timeout(20);
+	} while (!(rsp[1] & 0x80) && (i < 255)); /* Not complete power on */
+
+	if (i == 255) {
+		/* Time out */
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (hi_cap_flow) {
+		if (rsp[1] & 0x40)
+			SET_SD_HCXC(sd_card);
+		else
+			CLR_SD_HCXC(sd_card);
+		if (!CHK_RETRY_SD20_MODE(sd_card)) {
+			if ((CHK_SD_HCXC(sd_card)) && (CHECK_UHS50(chip))) {
+				support_1v8 = (rsp[1] & 0x01) ? 1 : 0;
+				RTS51X_DEBUGP("support_1v8 = %d\n",
+					       support_1v8);
+			}
+		}
+	} else {
+		CLR_SD_HCXC(sd_card);
+		support_1v8 = 0;
+	}
+
+	/* CMD11: Switch Voltage */
+	if (support_1v8 && CHECK_UHS50(chip)
+	    && !(((u8) chip->option.sd_speed_prior & SDR104_SUPPORT) ==
+		 HS_SUPPORT)) {
+		retval = sd_voltage_switch(chip);
+		if (retval != STATUS_SUCCESS) {
+			SET_RETRY_SD20_MODE(sd_card);
+			sd_init_power(chip);
+			RTS51X_DEBUGP("1.8v switch fail\n");
+			goto Switch_Fail;
+		}
+	}
+
+	/* CMD 2 */
+	retval =
+	    sd_send_cmd_get_rsp(chip, ALL_SEND_CID, 0, SD_RSP_TYPE_R2, NULL, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	/* CMD 3 */
+	retval =
+	    sd_send_cmd_get_rsp(chip, SEND_RELATIVE_ADDR, 0, SD_RSP_TYPE_R6,
+				rsp, 5);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	sd_card->sd_addr = (u32) rsp[1] << 24;
+	sd_card->sd_addr += (u32) rsp[2] << 16;
+
+	/* Get CSD register for Calculating Timing,Capacity,
+	 * Check CSD to determine as if this is the SD ROM card */
+	retval = sd_check_csd(chip, 1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	/* Select SD card */
+	retval = rts51x_sd_select_card(chip, 1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	/* ACMD42 */
+	retval =
+	    sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr, SD_RSP_TYPE_R1,
+				NULL, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval =
+	    sd_send_cmd_get_rsp(chip, SET_CLR_CARD_DETECT, 0, SD_RSP_TYPE_R1,
+				NULL, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (support_1v8) {
+		/* ACMD6 */
+		retval =
+		    sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
+					SD_RSP_TYPE_R1, NULL, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		/* Enable 4 bit data bus */
+		retval =
+		    sd_send_cmd_get_rsp(chip, SET_BUS_WIDTH, 2, SD_RSP_TYPE_R1,
+					NULL, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		switch_bus_width = SD_BUS_WIDTH_4;
+	} else {
+		switch_bus_width = SD_BUS_WIDTH_1;
+	}
+
+	/* Set block length 512 bytes for all block commands */
+	retval = sd_send_cmd_get_rsp(chip, SET_BLOCKLEN,
+			0x200, SD_RSP_TYPE_R1, NULL, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_WRITE_REG(chip, SD_CFG1, SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
+
+	if (!(sd_card->raw_csd[4] & 0x40)) {
+		sd_dont_switch = 1;
+		RTS51X_DEBUGP("Not support class ten\n");
+	}
+
+	if (!sd_dont_switch) {
+		/* Check the card whether flow SD1.1 spec or higher */
+		retval = sd_check_spec(chip, switch_bus_width);
+		if (retval == STATUS_SUCCESS) {
+			retval = sd_switch_function(chip, switch_bus_width);
+			if (retval != STATUS_SUCCESS) {
+				if ((sd_card->sd_switch_fail ==
+				     SDR104_SUPPORT_MASK)
+				    || (sd_card->sd_switch_fail ==
+					DDR50_SUPPORT_MASK)
+				    || (sd_card->sd_switch_fail ==
+					    SDR50_SUPPORT_MASK)) {
+					sd_init_power(chip);
+					SET_RETRY_SD20_MODE(sd_card);
+				} else if (sd_card->sd_switch_fail ==
+						HS_SUPPORT_MASK) {
+					sd_dont_switch = 1;
+				}
+				goto Switch_Fail;
+			}
+		} else {
+			if (support_1v8) {
+				SET_RETRY_SD20_MODE(sd_card);
+				sd_init_power(chip);
+				sd_dont_switch = 1;
+
+				goto Switch_Fail;
+			}
+		}
+	}
+
+	if (!support_1v8) {
+		/* ACMD6 */
+		retval =
+		    sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
+					SD_RSP_TYPE_R1, NULL, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		/* Enable 4 bit data bus */
+		retval =
+		    sd_send_cmd_get_rsp(chip, SET_BUS_WIDTH, 2, SD_RSP_TYPE_R1,
+					NULL, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	if (CHK_SD30_SPEED(sd_card)) {
+		rts51x_write_register(chip, SD30_DRIVE_SEL, SD30_DRIVE_MASK,
+				      0x03);
+
+		retval = sd_set_init_para(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		if (CHK_SD_DDR50(sd_card))
+			retval = sd_ddr_tuning(chip);
+		else
+			retval = sd_sdr_tuning(chip);
+
+		if (retval != STATUS_SUCCESS) {
+			SET_RETRY_SD20_MODE(sd_card);
+			RTS51X_DEBUGP("tuning phase fail,goto SD20 mode\n");
+			sd_init_power(chip);
+			CLR_SD30_SPEED(sd_card);
+			goto Switch_Fail;
+		}
+		if (STATUS_SUCCESS ==
+		    sd_wait_currentstate_dataready(chip, 0x08, 1, 20)) {
+			cmd[0] = 0x40 | READ_SINGLE_BLOCK;
+			cmd[1] = 0x00;
+			cmd[2] = 0x00;
+			cmd[3] = 0x00;
+			cmd[4] = 0x00;
+			retval =
+			    sd_read_data(chip, SD_TM_NORMAL_READ, cmd, 5, 512,
+					 1, SD_BUS_WIDTH_4, NULL, 0, 600);
+			if (retval != STATUS_SUCCESS) {
+				SET_RETRY_SD20_MODE(sd_card);
+				RTS51X_DEBUGP("read lba0 fail,"
+							"goto SD20 mode\n");
+				sd_init_power(chip);
+				CLR_SD30_SPEED(sd_card);
+				goto Switch_Fail;
+			}
+		}
+	}
+	sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr, SD_RSP_TYPE_R1,
+			    NULL, 0);
+
+	retval = sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
+			SD_RSP_TYPE_R1, NULL, 0);
+	if (retval == STATUS_SUCCESS) {
+		int ret;
+		cmd[0] = 0x40 | SEND_STATUS;
+		cmd[1] = 0x00;
+		cmd[2] = 0x00;
+		cmd[3] = 0x00;
+		cmd[4] = 0x00;
+		ret =
+		    sd_read_data(chip, SD_TM_NORMAL_READ, cmd, 5, 64, 1,
+				 SD_BUS_WIDTH_4, buf, 64, 600);
+		if (ret == STATUS_SUCCESS) {
+			sd_card_type = ((u16) buf[2] << 8) | (u16) buf[3];
+			RTS51X_DEBUGP("sd_card_type:0x%4x\n", sd_card_type);
+			if ((sd_card_type == 0x0001)
+			    || (sd_card_type == 0x0002))
+				chip->card_wp |= SD_CARD;
+		} else {
+			rts51x_clear_sd_error(chip);
+			sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+					    SD_RSP_TYPE_R1, NULL, 0);
+		}
+	} else {
+		rts51x_clear_sd_error(chip);
+		sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+				    SD_RSP_TYPE_R1, NULL, 0);
+	}
+
+	/* Check SD Machanical Write-Protect Switch */
+	retval = rts51x_get_card_status(chip, &(chip->card_status));
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	if (chip->card_status & SD_WP)
+		chip->card_wp |= SD_CARD;
+
+	chip->card_bus_width[chip->card2lun[SD_CARD]] = 4;
+
+	return STATUS_SUCCESS;
+}
+
+static int mmc_test_switch_bus(struct rts51x_chip *chip, u8 width)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 buf[8] = { 0 }, bus_width;
+	u16 byte_cnt;
+	int len;
+
+	retval =
+	    sd_send_cmd_get_rsp(chip, BUSTEST_W, 0, SD_RSP_TYPE_R1, NULL, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (width == MMC_8BIT_BUS) {
+		buf[0] = 0x55;
+		buf[1] = 0xAA;
+		len = 8;
+		byte_cnt = 8;
+		bus_width = SD_BUS_WIDTH_8;
+	} else {
+		buf[0] = 0x5A;
+		len = 4;
+		byte_cnt = 4;
+		bus_width = SD_BUS_WIDTH_4;
+	}
+
+	retval = sd_write_data(chip, SD_TM_AUTO_WRITE_3,
+			       NULL, 0, byte_cnt, 1, bus_width, buf, len, 100);
+	if (retval != STATUS_SUCCESS) {
+		u8 val1 = 0, val2 = 0;
+		rts51x_ep0_read_register(chip, SD_STAT1, &val1);
+		rts51x_ep0_read_register(chip, SD_STAT2, &val2);
+		rts51x_clear_sd_error(chip);
+		if ((val1 & 0xE0) || val2)
+			TRACE_RET(chip, STATUS_FAIL);
+	}
+	RTS51X_DEBUGP("SD/MMC CMD %d\n", BUSTEST_R);
+
+	rts51x_init_cmd(chip);
+
+	/* CMD14 */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD0, 0xFF, 0x40 | BUSTEST_R);
+
+	if (width == MMC_8BIT_BUS)
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF, 0x08);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF, 0x04);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_L, 0xFF, 1);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_H, 0xFF, 0);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF,
+		       SD_CALCULATE_CRC7 | SD_NO_CHECK_CRC16 |
+		       SD_NO_WAIT_BUSY_END | SD_CHECK_CRC7 | SD_RSP_LEN_6);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       PINGPONG_BUFFER);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+		       SD_TM_NORMAL_READ | SD_TRANSFER_START);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER, SD_TRANSFER_END,
+		       SD_TRANSFER_END);
+
+	rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2, 0, 0);
+	if (width == MMC_8BIT_BUS) {
+		len = 3;
+		rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + 1, 0, 0);
+	} else {
+		len = 2;
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, len, 100);
+	if (CHECK_SD_TRANS_FAIL(chip, retval)) {
+		rts51x_clear_sd_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	rts51x_read_rsp_buf(chip, 1, buf, 2);
+
+	if (width == MMC_8BIT_BUS) {
+		RTS51X_DEBUGP("BUSTEST_R [8bits]: 0x%02x 0x%02x\n",
+					buf[0], buf[1]);
+		if ((buf[0] == 0xAA) && (buf[1] == 0x55)) {
+			u8 rsp[5];
+			u32 arg;
+
+			if (CHK_MMC_DDR52(sd_card))
+				arg = 0x03B70600;
+			else
+				arg = 0x03B70200;
+			/* Switch MMC to  8-bit mode */
+			retval =
+			    sd_send_cmd_get_rsp(chip, SWITCH, arg,
+						SD_RSP_TYPE_R1b, rsp, 5);
+			if ((retval == STATUS_SUCCESS)
+			    && !(rsp[4] & MMC_SWITCH_ERR))
+				return STATUS_SUCCESS;
+		}
+	} else {
+		RTS51X_DEBUGP("BUSTEST_R [4bits]: 0x%02x\n", buf[0]);
+		if (buf[0] == 0xA5) {
+			u8 rsp[5];
+			u32 arg;
+
+			if (CHK_MMC_DDR52(sd_card))
+				arg = 0x03B70500;
+			else
+				arg = 0x03B70100;
+			/* Switch MMC to  4-bit mode */
+			retval =
+			    sd_send_cmd_get_rsp(chip, SWITCH, arg,
+						SD_RSP_TYPE_R1b, rsp, 5);
+			if ((retval == STATUS_SUCCESS)
+			    && !(rsp[4] & MMC_SWITCH_ERR))
+				return STATUS_SUCCESS;
+		}
+	}
+
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+static int mmc_switch_timing_bus(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	u8 card_type, card_type_mask = 0;
+	u8 buf[6];
+
+	CLR_MMC_HS(sd_card);
+
+	RTS51X_DEBUGP("SD/MMC CMD %d\n", SEND_EXT_CSD);
+
+	rts51x_init_cmd(chip);
+
+	/* SEND_EXT_CSD command */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD0, 0xFF,
+			0x40 | SEND_EXT_CSD);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD1, 0xFF, 0);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD2, 0xFF, 0);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD3, 0xFF, 0);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD4, 0xFF, 0);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF, 0);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_H, 0xFF, 2);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_L, 0xFF, 1);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_H, 0xFF, 0);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF,
+		       SD_CALCULATE_CRC7 | SD_CHECK_CRC16 | SD_NO_WAIT_BUSY_END
+		       | SD_CHECK_CRC7 | SD_RSP_LEN_6);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       PINGPONG_BUFFER);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+		       SD_TM_NORMAL_READ | SD_TRANSFER_START);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER, SD_TRANSFER_END,
+		       SD_TRANSFER_END);
+
+	rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + 196, 0xFF, 0);
+	rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + 212, 0xFF, 0);
+	rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + 213, 0xFF, 0);
+	rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + 214, 0xFF, 0);
+	rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + 215, 0xFF, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 6, 1000);
+
+	if (CHECK_SD_TRANS_FAIL(chip, retval)) {
+		if (retval == STATUS_TIMEDOUT) {
+			rts51x_clear_sd_error(chip);
+			sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+					    SD_RSP_TYPE_R1, NULL, 0);
+		}
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	rts51x_read_rsp_buf(chip, 0, buf, 6);
+
+	if (buf[0] & SD_TRANSFER_ERR) {
+		sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+				    SD_RSP_TYPE_R1, NULL, 0);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+	if (CHK_MMC_SECTOR_MODE(sd_card))
+		sd_card->capacity =
+		    ((u32) buf[5] << 24) | ((u32) buf[4] << 16) |
+		    ((u32) buf[3] << 8) | ((u32) buf[2]);
+	if (CHECK_UHS50(chip))
+		card_type_mask = 0x07;
+	else
+		card_type_mask = 0x03;
+
+	card_type = buf[1] & card_type_mask;
+	if (card_type) {
+		/* CARD TYPE FIELD = DDR52MHz, 52MHz or 26MHz */
+		u8 rsp[5];
+
+		if (card_type & 0x04)
+			SET_MMC_DDR52(sd_card);
+		else if (card_type & 0x02)
+			SET_MMC_52M(sd_card);
+		else
+			SET_MMC_26M(sd_card);
+
+		retval =
+		    sd_send_cmd_get_rsp(chip, SWITCH, 0x03B90100,
+					SD_RSP_TYPE_R1b, rsp, 5);
+		if ((retval != STATUS_SUCCESS) || (rsp[4] & MMC_SWITCH_ERR))
+			CLR_MMC_HS(sd_card);
+	}
+	sd_choose_proper_clock(chip);
+	retval = switch_clock(chip, sd_card->sd_clock);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	/* Test Bus Procedure */
+	if (mmc_test_switch_bus(chip, MMC_8BIT_BUS) == STATUS_SUCCESS) {
+		SET_MMC_8BIT(sd_card);
+		chip->card_bus_width[chip->card2lun[SD_CARD]] = 8;
+	} else if (mmc_test_switch_bus(chip, MMC_4BIT_BUS) == STATUS_SUCCESS) {
+		SET_MMC_4BIT(sd_card);
+		chip->card_bus_width[chip->card2lun[SD_CARD]] = 4;
+	} else {
+		CLR_MMC_8BIT(sd_card);
+		CLR_MMC_4BIT(sd_card);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int reset_mmc(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval, i = 0, j = 0, k = 0;
+	u8 rsp[16];
+	u8 spec_ver = 0;
+	u8 change_to_ddr52 = 1;
+	u8 cmd[5];
+
+MMC_DDR_FAIL:
+
+	retval = sd_prepare_reset(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	SET_MMC(sd_card);
+
+RTY_MMC_RST:
+	retval =
+	    sd_send_cmd_get_rsp(chip, GO_IDLE_STATE, 0, SD_RSP_TYPE_R0, NULL,
+				0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	do {
+		{
+			u8 temp = 0;
+			rts51x_read_register(chip, CARD_INT_PEND, &temp);
+			if (temp & SD_INT) {
+				chip->reset_need_retry = 1;
+				rts51x_write_register(chip, CARD_INT_PEND,
+						      XD_INT | SD_INT | MS_INT,
+						      XD_INT | SD_INT | MS_INT);
+				sd_set_reset_fail(chip, MMC_RESET_FAIL);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		/* CMD  1 */
+		retval = sd_send_cmd_get_rsp(chip, SEND_OP_COND,
+					     (SUPPORT_VOLTAGE | 0x40000000),
+					     SD_RSP_TYPE_R3, rsp, 5);
+		if (retval != STATUS_SUCCESS) {
+			if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST) {
+				sd_set_reset_fail(chip, MMC_RESET_FAIL);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+
+			if (sd_check_err_code(chip, SD_BUSY)
+			    || sd_check_err_code(chip, SD_TO_ERR)) {
+				k++;
+				if (k < 20) {
+					sd_clr_err_code(chip);
+					goto RTY_MMC_RST;
+				} else {
+					TRACE_RET(chip, STATUS_FAIL);
+				}
+			} else {
+				j++;
+				if (j < 100) {
+					sd_clr_err_code(chip);
+					goto RTY_MMC_RST;
+				} else {
+					TRACE_RET(chip, STATUS_FAIL);
+				}
+			}
+		}
+
+		wait_timeout(20);
+		i++;
+	} while (!(rsp[1] & 0x80) && (i < 100)); /* Not complete power on */
+
+	if (i == 100) {
+		/* Time out */
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if ((rsp[1] & 0x60) == 0x40)
+		SET_MMC_SECTOR_MODE(sd_card);
+	else
+		CLR_MMC_SECTOR_MODE(sd_card);
+
+	/* CMD 2 */
+	retval =
+	    sd_send_cmd_get_rsp(chip, ALL_SEND_CID, 0, SD_RSP_TYPE_R2, NULL, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	/* CMD 3 */
+	sd_card->sd_addr = 0x00100000;
+	retval =
+	    sd_send_cmd_get_rsp(chip, SET_RELATIVE_ADDR, sd_card->sd_addr,
+				SD_RSP_TYPE_R6, rsp, 5);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	/* Get CSD register for Calculating Timing,Capacity
+	 * Check CSD to determine as if this is the SD ROM card */
+	retval = sd_check_csd(chip, 1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	/* Get MMC Spec_Ver in the CSD register */
+	spec_ver = (sd_card->raw_csd[0] & 0x3C) >> 2;
+
+	/* Select MMC card */
+	retval = rts51x_sd_select_card(chip, 1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	/* Set block length 512 bytes for all block commands */
+	retval =
+	    sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200, SD_RSP_TYPE_R1, NULL,
+				0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_WRITE_REG(chip, SD_CFG1, SD_CLK_DIVIDE_MASK, SD_CLK_DIVIDE_0);
+
+	if (chip->ic_version < 2)
+		rts51x_write_register(chip, SD30_DRIVE_SEL, SD30_DRIVE_MASK,
+				      0x02);
+	rts51x_write_register(chip, CARD_DRIVE_SEL, SD20_DRIVE_MASK, DRIVE_8mA);
+
+	chip->card_bus_width[chip->card2lun[SD_CARD]] = 1;
+	if (spec_ver == 4) {
+		/* MMC 4.x Cards */
+		(void)mmc_switch_timing_bus(chip);
+	}
+
+	if (CHK_MMC_SECTOR_MODE(sd_card) && (sd_card->capacity == 0))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if (CHK_MMC_DDR52(sd_card) && change_to_ddr52) {
+		/* Card is extracted while identifying */
+		if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		retval = sd_set_init_para(chip);
+		if (retval != STATUS_SUCCESS) {
+			CLR_MMC_DDR52(sd_card);
+			sd_init_power(chip);
+			change_to_ddr52 = 0;
+			goto MMC_DDR_FAIL;
+		}
+
+		retval = mmc_ddr_tuning(chip);
+		if (retval != STATUS_SUCCESS) {
+			CLR_MMC_DDR52(sd_card);
+			sd_init_power(chip);
+			change_to_ddr52 = 0;
+			goto MMC_DDR_FAIL;
+		}
+
+		if (STATUS_SUCCESS ==
+		    sd_wait_currentstate_dataready(chip, 0x08, 1, 20)) {
+			cmd[0] = 0x40 | READ_SINGLE_BLOCK;
+			cmd[1] = 0x00;
+			cmd[2] = 0x00;
+			cmd[3] = 0x00;
+			cmd[4] = 0x00;
+			if (CHK_MMC_8BIT(sd_card)) {
+				retval =
+				    sd_read_data(chip, SD_TM_NORMAL_READ, cmd,
+						 5, 512, 1, SD_BUS_WIDTH_8,
+						 NULL, 0, 600);
+			} else if (CHK_MMC_4BIT(sd_card)) {
+				retval =
+				    sd_read_data(chip, SD_TM_NORMAL_READ, cmd,
+						 5, 512, 1, SD_BUS_WIDTH_4,
+						 NULL, 0, 600);
+			} else {
+				retval =
+				    sd_read_data(chip, SD_TM_NORMAL_READ, cmd,
+						 5, 512, 1, SD_BUS_WIDTH_1,
+						 NULL, 0, 600);
+			}
+
+			if (retval != STATUS_SUCCESS) {
+				CLR_MMC_DDR52(sd_card);
+				change_to_ddr52 = 0;
+				RTS51X_DEBUGP("read lba0 fail,"
+							"goto SD20 mode\n");
+				sd_init_power(chip);
+				goto MMC_DDR_FAIL;
+			}
+		}
+	}
+
+	retval = rts51x_get_card_status(chip, &(chip->card_status));
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	if (chip->card_status & SD_WP)
+		chip->card_wp |= SD_CARD;
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_reset_sd_card(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	int i;
+
+	memset(sd_card, 0, sizeof(struct sd_info));
+
+	/* Init variables */
+	sd_card->sd_type = 0;
+	sd_card->seq_mode = 0;
+	sd_card->sd_data_buf_ready = 0;
+	sd_card->capacity = 0;
+	sd_card->sd_switch_fail = 0;
+
+	sd_clear_reset_fail(chip);
+	rts51x_enable_card_clock(chip, SD_CARD);
+
+	sd_init_power(chip);
+
+	chip->reset_need_retry = 0;
+	for (i = 0; i < 3; i++) {
+		if (!chip->option.reset_mmc_first) { /* reset sd first */
+			retval = reset_sd(chip);
+			if (retval != STATUS_SUCCESS) {
+				/* Switch SD bus to 3V3 signal */
+				RTS51X_WRITE_REG(chip, SD_PAD_CTL,
+						 SD_IO_USING_1V8, 0);
+				if (sd_check_reset_fail(chip, SD_RESET_FAIL))
+					sd_clear_reset_fail(chip);
+				else
+					retval = reset_mmc(chip);
+			}
+		} else { /* reset MMC first */
+			retval = reset_mmc(chip);
+			if (retval != STATUS_SUCCESS) {
+				if (sd_check_reset_fail(chip, MMC_RESET_FAIL)) {
+					sd_clear_reset_fail(chip);
+				} else {
+					retval = reset_sd(chip);
+					if (retval != STATUS_SUCCESS) {
+						/* Switch SD bus to
+						 * 3V3 signal */
+						RTS51X_WRITE_REG(chip,
+							SD_PAD_CTL,
+							SD_IO_USING_1V8, 0);
+					}
+				}
+			}
+		}
+
+		if ((retval == STATUS_SUCCESS) || (!chip->reset_need_retry)) {
+			/* if reset success or don't need retry,then break */
+			break;
+		}
+		if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST) {
+			/* card is extracted */
+			break;
+		}
+		RTS51X_DEBUGP("retry reset sd card,%d\n", i);
+		chip->reset_need_retry = 0;
+	}
+
+	sd_clear_reset_fail(chip);
+	chip->reset_need_retry = 0;
+
+	if (retval == STATUS_SUCCESS) {
+		rts51x_init_cmd(chip);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1, SD_CLK_DIVIDE_MASK,
+			       SD_CLK_DIVIDE_0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF, 0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_H, 0xFF, 2);
+		retval = rts51x_send_cmd(chip, MODE_C, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	} else {
+		chip->capacity[chip->card2lun[SD_CARD]] = sd_card->capacity = 0;
+		if (chip->option.reset_or_rw_fail_set_pad_drive) {
+			rts51x_write_register(chip, CARD_DRIVE_SEL,
+					      SD20_DRIVE_MASK, DRIVE_8mA);
+		}
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	chip->capacity[chip->card2lun[SD_CARD]] = sd_card->capacity;
+
+	if (chip->option.sd_send_status_en) {
+		sd_card->sd_send_status_en = 1;
+	} else {
+		if (sd_card->capacity > 0x20000) { /* 64MB */
+			sd_card->sd_send_status_en = 0;
+		} else {
+			sd_card->sd_send_status_en = 1;
+		}
+	}
+	RTS51X_DEBUGP("sd_card->sd_send_status = %d\n",
+		       sd_card->sd_send_status_en);
+
+	retval = sd_set_init_para(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	RTS51X_DEBUGP("sd_card->sd_type = 0x%x\n", sd_card->sd_type);
+
+	return STATUS_SUCCESS;
+}
+
+#define WAIT_DATA_READY_RTY_CNT		255
+
+static int wait_data_buf_ready(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int i, retval;
+
+	for (i = 0; i < WAIT_DATA_READY_RTY_CNT; i++) {
+		if (monitor_card_cd(chip, SD_CARD) == CD_NOT_EXIST)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		sd_card->sd_data_buf_ready = 0;
+
+		retval = sd_send_cmd_get_rsp(chip, SEND_STATUS,
+					     sd_card->sd_addr, SD_RSP_TYPE_R1,
+					     NULL, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		if (sd_card->sd_data_buf_ready)
+			return sd_send_cmd_get_rsp(chip, SEND_STATUS,
+						   sd_card->sd_addr,
+						   SD_RSP_TYPE_R1, NULL, 0);
+	}
+
+	sd_set_err_code(chip, SD_TO_ERR);
+
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+static void sd_stop_seq_mode(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+
+	if (sd_card->seq_mode) {
+		retval = rts51x_sd_switch_clock(chip);
+		if (retval != STATUS_SUCCESS)
+			return;
+
+		retval = sd_send_cmd_get_rsp(chip, STOP_TRANSMISSION, 0,
+					     SD_RSP_TYPE_R1b, NULL, 0);
+		if (retval != STATUS_SUCCESS)
+			sd_set_err_code(chip, SD_STS_ERR);
+		sd_card->seq_mode = 0;
+
+		rts51x_ep0_write_register(chip, MC_FIFO_CTL, FIFO_FLUSH,
+					  FIFO_FLUSH);
+	}
+}
+
+static inline int sd_auto_tune_clock(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+
+	if (chip->asic_code) {
+		if (sd_card->sd_clock > 30)
+			sd_card->sd_clock -= 20;
+	} else {
+		if (sd_card->sd_clock == CLK_100)
+			sd_card->sd_clock = CLK_80;
+		else if (sd_card->sd_clock == CLK_80)
+			sd_card->sd_clock = CLK_60;
+		else if (sd_card->sd_clock == CLK_60)
+			sd_card->sd_clock = CLK_50;
+	}
+
+	retval = rts51x_sd_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_sd_rw(struct scsi_cmnd *srb, struct rts51x_chip *chip, u32 start_sector,
+	  u16 sector_cnt)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	u32 data_addr;
+	int retval;
+	u8 flag;
+	unsigned int pipe;
+	u8 stageflag;
+
+	sd_card->counter = 0;
+
+	if (!CHK_SD_HCXC(sd_card) && !CHK_MMC_SECTOR_MODE(sd_card))
+		data_addr = start_sector << 9;
+	else
+		data_addr = start_sector;
+
+	RTS51X_DEBUGP("rts51x_sd_rw, data_addr = 0x%x\n", data_addr);
+
+	sd_clr_err_code(chip);
+
+	retval = rts51x_sd_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (sd_card->seq_mode && ((sd_card->pre_dir != srb->sc_data_direction)
+				  ||
+				  ((sd_card->pre_sec_addr +
+				    sd_card->pre_sec_cnt) != start_sector))) {
+		if ((sd_card->pre_dir == DMA_FROM_DEVICE)
+		    && !CHK_SD30_SPEED(sd_card)
+		    && !CHK_SD_HS(sd_card)
+		    && !CHK_MMC_HS(sd_card)
+		    && sd_card->sd_send_status_en) {
+			sd_send_cmd_get_rsp(chip, SEND_STATUS,
+					    sd_card->sd_addr, SD_RSP_TYPE_R1,
+					    NULL, 0);
+		}
+
+		retval =
+		    sd_send_cmd_get_rsp(chip, STOP_TRANSMISSION, 0,
+					SD_RSP_TYPE_R1b, NULL, 0);
+		if (retval != STATUS_SUCCESS) {
+			sd_set_err_code(chip, SD_STS_ERR);
+			TRACE_RET(chip, sd_parse_err_code(chip));
+		}
+
+		sd_card->seq_mode = 0;
+
+		RTS51X_WRITE_REG(chip, MC_FIFO_CTL, FIFO_FLUSH, FIFO_FLUSH);
+
+		if (!CHK_SD30_SPEED(sd_card)
+		    && !CHK_SD_HS(sd_card)
+		    && !CHK_MMC_HS(sd_card)
+		    && sd_card->sd_send_status_en) {
+			/* random rw, so pre_sec_cnt < 0x80 */
+			sd_send_cmd_get_rsp(chip, SEND_STATUS,
+					    sd_card->sd_addr, SD_RSP_TYPE_R1,
+					    NULL, 0);
+		}
+	}
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF, 0x00);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_H, 0xFF, 0x02);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_L, 0xFF,
+		       (u8) sector_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_H, 0xFF,
+		       (u8) (sector_cnt >> 8));
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       RING_BUFFER);
+
+	if (CHK_MMC_8BIT(sd_card))
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1, 0x03,
+			       SD_BUS_WIDTH_8);
+	else if (CHK_MMC_4BIT(sd_card) || CHK_SD(sd_card))
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1, 0x03,
+			       SD_BUS_WIDTH_4);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1, 0x03,
+			       SD_BUS_WIDTH_1);
+
+	if (sd_card->seq_mode) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF,
+			       SD_NO_CALCULATE_CRC7 | SD_CHECK_CRC16 |
+			       SD_NO_WAIT_BUSY_END | SD_NO_CHECK_CRC7 |
+			       SD_RSP_LEN_0);
+
+		rts51x_trans_dma_enable(srb->sc_data_direction, chip, sector_cnt * 512,
+				 DMA_512);
+
+		if (srb->sc_data_direction == DMA_FROM_DEVICE) {
+			flag = MODE_CDIR;
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+				       SD_TM_AUTO_READ_3 | SD_TRANSFER_START);
+		} else {
+			flag = MODE_CDOR;
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+				       SD_TM_AUTO_WRITE_3 | SD_TRANSFER_START);
+		}
+
+		rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER,
+			       SD_TRANSFER_END, SD_TRANSFER_END);
+
+		retval = rts51x_send_cmd(chip, flag, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	} else {
+		if (srb->sc_data_direction == DMA_FROM_DEVICE) {
+			RTS51X_DEBUGP("SD/MMC CMD %d\n", READ_MULTIPLE_BLOCK);
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD0, 0xFF,
+				       0x40 | READ_MULTIPLE_BLOCK);
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD1, 0xFF,
+				       (u8) (data_addr >> 24));
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD2, 0xFF,
+				       (u8) (data_addr >> 16));
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD3, 0xFF,
+				       (u8) (data_addr >> 8));
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD4, 0xFF,
+				       (u8) data_addr);
+
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF,
+				       SD_CALCULATE_CRC7 | SD_CHECK_CRC16 |
+				       SD_NO_WAIT_BUSY_END | SD_CHECK_CRC7 |
+				       SD_RSP_LEN_6);
+
+			rts51x_trans_dma_enable(srb->sc_data_direction, chip,
+					 sector_cnt * 512, DMA_512);
+
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+				       SD_TM_AUTO_READ_2 | SD_TRANSFER_START);
+			rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER,
+				       SD_TRANSFER_END, SD_TRANSFER_END);
+
+			retval = rts51x_send_cmd(chip, MODE_CDIR, 100);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+		} else {
+			retval = rts51x_send_cmd(chip, MODE_C, 50);
+			if (retval != STATUS_SUCCESS) {
+				rts51x_clear_sd_error(chip);
+
+				sd_set_err_code(chip, SD_TO_ERR);
+				TRACE_RET(chip, sd_parse_err_code(chip));
+			}
+
+			retval = wait_data_buf_ready(chip);
+			if (retval != STATUS_SUCCESS) {
+				sd_set_err_code(chip, SD_TO_ERR);
+				TRACE_RET(chip, sd_parse_err_code(chip));
+			}
+
+			retval = sd_send_cmd_get_rsp(chip, WRITE_MULTIPLE_BLOCK,
+						     data_addr, SD_RSP_TYPE_R1,
+						     NULL, 0);
+			if (retval != STATUS_SUCCESS) {
+				sd_set_err_code(chip, SD_CRC_ERR);
+				TRACE_RET(chip, sd_parse_err_code(chip));
+			}
+
+			rts51x_init_cmd(chip);
+
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF,
+				       SD_NO_CALCULATE_CRC7 | SD_CHECK_CRC16 |
+				       SD_NO_WAIT_BUSY_END | SD_NO_CHECK_CRC7 |
+				       SD_RSP_LEN_0);
+
+			rts51x_trans_dma_enable(srb->sc_data_direction, chip,
+					 sector_cnt * 512, DMA_512);
+
+			rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+				       SD_TM_AUTO_WRITE_3 | SD_TRANSFER_START);
+			rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER,
+				       SD_TRANSFER_END, SD_TRANSFER_END);
+
+			retval = rts51x_send_cmd(chip, MODE_CDOR, 100);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+		}
+
+		sd_card->seq_mode = 1;
+	}
+
+	if (srb->sc_data_direction == DMA_FROM_DEVICE) {
+		pipe = RCV_BULK_PIPE(chip);
+		stageflag = STAGE_DI;
+	} else {
+		pipe = SND_BULK_PIPE(chip);
+		stageflag = STAGE_DO;
+	}
+
+	retval =
+	    rts51x_transfer_data_rcc(chip, pipe, scsi_sglist(srb),
+				     scsi_bufflen(srb), scsi_sg_count(srb),
+				     NULL, 10000, stageflag);
+	if (retval != STATUS_SUCCESS) {
+		u8 stat = 0;
+		int err = retval;
+
+		sd_print_debug_reg(chip);
+
+		rts51x_ep0_read_register(chip, SD_STAT1, &stat);
+		RTS51X_DEBUGP("SD_STAT1: 0x%x\n", stat);
+
+		rts51x_clear_sd_error(chip);
+
+		retval =
+		    sd_send_cmd_get_rsp(chip, STOP_TRANSMISSION, 0,
+					SD_RSP_TYPE_R1b, NULL, 0);
+		if (retval != STATUS_SUCCESS) {
+			sd_set_err_code(chip, SD_STS_ERR);
+			TRACE_RET(chip, retval);
+		}
+
+		if (stat & (SD_CRC7_ERR | SD_CRC16_ERR | SD_CRC_WRITE_ERR)) {
+			RTS51X_DEBUGP("SD CRC error, tune clock!\n");
+			sd_auto_tune_clock(chip);
+		}
+
+		sd_card->seq_mode = 0;
+
+		TRACE_RET(chip, err);
+	}
+	retval = rts51x_get_rsp(chip, 1, 2000);
+	if (CHECK_SD_TRANS_FAIL(chip, retval)) {
+		rts51x_clear_sd_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	sd_card->pre_sec_addr = start_sector;
+	sd_card->pre_sec_cnt = sector_cnt;
+	sd_card->pre_dir = srb->sc_data_direction;
+
+	return STATUS_SUCCESS;
+}
+
+void rts51x_sd_cleanup_work(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+
+	if (sd_card->seq_mode) {
+		RTS51X_DEBUGP("SD: stop transmission\n");
+		sd_stop_seq_mode(chip);
+		sd_card->counter = 0;
+	}
+}
+
+static inline void sd_fill_power_off_card3v3(struct rts51x_chip *chip)
+{
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_EN, SD_CLK_EN, 0);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, SD_OUTPUT_EN, 0);
+	if (!chip->option.FT2_fast_mode) {
+#ifdef SD_XD_IO_FOLLOW_PWR
+		if (CHECK_PKG(chip, LQFP48)
+		    || chip->option.rts5129_D3318_off_enable)
+			rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL,
+				       POWER_MASK | LDO_OFF,
+				       POWER_OFF | LDO_OFF);
+		else
+			rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL,
+				       POWER_MASK, POWER_OFF);
+#else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK,
+			       POWER_OFF);
+#endif
+	}
+}
+
+static int sd_power_off_card3v3(struct rts51x_chip *chip)
+{
+	int retval;
+
+	rts51x_init_cmd(chip);
+
+	sd_fill_power_off_card3v3(chip);
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+#ifdef SD_XD_IO_FOLLOW_PWR
+	if (!chip->option.FT2_fast_mode)
+		wait_timeout(chip->option.D3318_off_delay);
+#endif
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_release_sd_card(struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+
+	RTS51X_DEBUGP("rts51x_release_sd_card\n");
+
+	chip->card_ready &= ~SD_CARD;
+	chip->card_fail &= ~SD_CARD;
+	chip->card_wp &= ~SD_CARD;
+
+	memset(sd_card->raw_csd, 0, 16);
+	memset(sd_card->raw_scr, 0, 8);
+
+	rts51x_write_register(chip, SFSM_ED, HW_CMD_STOP, HW_CMD_STOP);
+	rts51x_write_register(chip, SD_PAD_CTL, SD_IO_USING_1V8, 0);
+	if (CHECK_PKG(chip, LQFP48) || chip->option.rts5129_D3318_off_enable)
+		sd_power_off_card3v3(chip);
+
+	rts51x_init_cmd(chip);
+	if (!(CHECK_PKG(chip, LQFP48) || chip->option.rts5129_D3318_off_enable))
+		sd_fill_power_off_card3v3(chip);
+
+	if (chip->asic_code)
+		sd_pull_ctl_disable(chip);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, FPGA_PULL_CTL,
+			       FPGA_SD_PULL_CTL_BIT | 0x20,
+			       FPGA_SD_PULL_CTL_BIT);
+
+	/* Switch LDO3318 to 3.3V */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, LDO_POWER_CFG, TUNE_SD18_MASK,
+		       TUNE_SD18_3V3);
+
+	if (CHK_MMC_DDR52(sd_card) && CHK_MMC_8BIT(sd_card))
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DMA1_CTL,
+			       EXTEND_DMA1_ASYNC_SIGNAL,
+			       EXTEND_DMA1_ASYNC_SIGNAL);
+	if (CHK_SD30_SPEED(sd_card) || CHK_MMC(sd_card))
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD30_DRIVE_SEL,
+			       SD30_DRIVE_MASK, chip->option.sd30_pad_drive);
+	/* Suspend LDO3318 */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, LDO3318_PWR_MASK,
+		       LDO_SUSPEND);
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	wait_timeout(20);
+
+	return STATUS_SUCCESS;
+}
diff --git a/drivers/staging/rts5139/sd.h b/drivers/staging/rts5139/sd.h
new file mode 100644
index 000000000000..7dd943f54c74
--- /dev/null
+++ b/drivers/staging/rts5139/sd.h
@@ -0,0 +1,275 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_SD_H
+#define __RTS51X_SD_H
+
+#include "rts51x_chip.h"
+
+#define SD_MAX_RETRY_COUNT	3
+
+#define SUPPORT_VOLTAGE	0x003C0000
+
+#define SD_RESET_FAIL	0x01
+#define MMC_RESET_FAIL  0x02
+
+/* Error Code */
+#define	SD_NO_ERROR		0x0
+#define	SD_CRC_ERR		0x80
+#define	SD_TO_ERR		0x40
+#define	SD_NO_CARD		0x20
+#define SD_BUSY			0x10
+#define	SD_STS_ERR		0x08
+#define SD_RSP_TIMEOUT		0x04
+
+/* MMC/SD Command Index */
+/* Basic command (class 0) */
+#define GO_IDLE_STATE		0
+#define	SEND_OP_COND		1 /* reserved for SD */
+#define	ALL_SEND_CID		2
+#define	SET_RELATIVE_ADDR	3
+#define	SEND_RELATIVE_ADDR	3
+#define	SET_DSR			4
+#define IO_SEND_OP_COND		5
+#define	SWITCH			6
+#define	SELECT_CARD		7
+#define	DESELECT_CARD		7
+/* CMD8 is "SEND_EXT_CSD" for MMC4.x Spec
+ * while is "SEND_IF_COND" for SD 2.0 */
+#define	SEND_EXT_CSD		8
+#define	SEND_IF_COND		8
+/* end  */
+#define	SEND_CSD		9
+#define	SEND_CID		10
+#define	VOLTAGE_SWITCH		11
+#define	READ_DAT_UTIL_STOP	11 /* reserved for SD */
+#define	STOP_TRANSMISSION	12
+#define	SEND_STATUS		13
+#define	GO_INACTIVE_STATE	15
+
+/* Block oriented read commands (class 2) */
+#define	SET_BLOCKLEN		16
+#define	READ_SINGLE_BLOCK	17
+#define	READ_MULTIPLE_BLOCK	18
+#define	SEND_TUNING_PATTERN	19
+
+/* Bus Width Test */
+#define	BUSTEST_R		14
+#define	BUSTEST_W		19
+/* end */
+
+/* Block oriented write commands (class 4) */
+#define	WRITE_BLOCK		24
+#define	WRITE_MULTIPLE_BLOCK	25
+#define	PROGRAM_CSD		27
+
+/* Erase commands */
+#define	ERASE_WR_BLK_START	32
+#define	ERASE_WR_BLK_END	33
+#define	ERASE_CMD		38
+
+/* Block Oriented Write Protection Commands */
+#define LOCK_UNLOCK		42
+
+#define	IO_RW_DIRECT		52
+
+/* Application specific commands (class 8) */
+#define	APP_CMD			55
+#define	GEN_CMD			56
+
+/* SD Application command Index */
+#define	SET_BUS_WIDTH			6
+#define	SD_STATUS			13
+#define	SEND_NUM_WR_BLOCKS		22
+#define	SET_WR_BLK_ERASE_COUNT		23
+#define	SD_APP_OP_COND			41
+#define	SET_CLR_CARD_DETECT		42
+#define	SEND_SCR			51
+
+/* SD TIMEOUT function return error */
+#define	SD_READ_COMPLETE	0x00
+#define	SD_READ_TO		0x01
+#define	SD_READ_ADVENCE		0x02
+
+/* SD v1.1 CMD6 SWITCH function */
+#define	SD_CHECK_MODE		0x00
+#define	SD_SWITCH_MODE		0x80
+#define	SD_FUNC_GROUP_1		0x01
+#define	SD_FUNC_GROUP_2		0x02
+#define	SD_FUNC_GROUP_3		0x03
+#define	SD_FUNC_GROUP_4		0x04
+#define	SD_CHECK_SPEC_V1_1	0xFF
+
+/* SD Command Argument */
+#define	NO_ARGUMENT	                        0x00
+#define	CHECK_PATTERN				0x000000AA
+#define	VOLTAGE_SUPPLY_RANGE			0x00000100 /* 2.7~3.6V */
+#define	SUPPORT_HIGH_AND_EXTENDED_CAPACITY	0x40000000
+#define	SUPPORT_MAX_POWER_PERMANCE	        0x10000000
+#define	SUPPORT_1V8	                        0x01000000
+
+/* Switch Command Error Code */
+#define	SWTICH_NO_ERR	  0x00
+#define	CARD_NOT_EXIST	  0x01
+#define	SPEC_NOT_SUPPORT  0x02
+#define	CHECK_MODE_ERR	  0x03
+#define	CHECK_NOT_READY	  0x04
+#define	SWITCH_CRC_ERR	  0x05
+#define	SWITCH_MODE_ERR	  0x06
+#define	SWITCH_PASS	  0x07
+
+/* Function Group Definition */
+/* Function Group 1 */
+#define	HS_SUPPORT			0x01
+#define	SDR50_SUPPORT			0x02
+#define	SDR104_SUPPORT			0x03
+#define	DDR50_SUPPORT			0x04
+#define	HS_SUPPORT_MASK			0x02
+#define	SDR50_SUPPORT_MASK		0x04
+#define	SDR104_SUPPORT_MASK		0x08
+#define	DDR50_SUPPORT_MASK		0x10
+#define	HS_QUERY_SWITCH_OK		0x01
+#define	SDR50_QUERY_SWITCH_OK		0x02
+#define	SDR104_QUERY_SWITCH_OK		0x03
+#define	DDR50_QUERY_SWITCH_OK		0x04
+#define	HS_SWITCH_BUSY			0x02
+#define	SDR50_SWITCH_BUSY		0x04
+#define	SDR104_SWITCH_BUSY		0x08
+#define	DDR50_SWITCH_BUSY		0x10
+#define	FUNCTION_GROUP1_SUPPORT_OFFSET       0x0D
+#define FUNCTION_GROUP1_QUERY_SWITCH_OFFSET  0x10
+#define FUNCTION_GROUP1_CHECK_BUSY_OFFSET    0x1D
+/* Function Group 3 */
+#define	DRIVING_TYPE_A	        0x01
+#define	DRIVING_TYPE_B		    0x00
+#define	DRIVING_TYPE_C		    0x02
+#define	DRIVING_TYPE_D	        0x03
+#define	DRIVING_TYPE_A_MASK	    0x02
+#define	DRIVING_TYPE_B_MASK	    0x01
+#define	DRIVING_TYPE_C_MASK	    0x04
+#define	DRIVING_TYPE_D_MASK	    0x08
+#define	TYPE_A_QUERY_SWITCH_OK	0x01
+#define	TYPE_B_QUERY_SWITCH_OK	0x00
+#define	TYPE_C_QUERY_SWITCH_OK  0x02
+#define	TYPE_D_QUERY_SWITCH_OK  0x03
+#define	TYPE_A_SWITCH_BUSY	    0x02
+#define	TYPE_B_SWITCH_BUSY	    0x01
+#define	TYPE_C_SWITCH_BUSY      0x04
+#define	TYPE_D_SWITCH_BUSY      0x08
+#define	FUNCTION_GROUP3_SUPPORT_OFFSET       0x09
+#define FUNCTION_GROUP3_QUERY_SWITCH_OFFSET  0x0F
+#define FUNCTION_GROUP3_CHECK_BUSY_OFFSET    0x19
+/* Function Group 4 */
+#define	CURRENT_LIMIT_200	    0x00
+#define	CURRENT_LIMIT_400	    0x01
+#define	CURRENT_LIMIT_600	    0x02
+#define	CURRENT_LIMIT_800	    0x03
+#define	CURRENT_LIMIT_200_MASK	0x01
+#define	CURRENT_LIMIT_400_MASK	0x02
+#define	CURRENT_LIMIT_600_MASK	0x04
+#define	CURRENT_LIMIT_800_MASK	0x08
+#define	CURRENT_LIMIT_200_QUERY_SWITCH_OK    0x00
+#define	CURRENT_LIMIT_400_QUERY_SWITCH_OK    0x01
+#define	CURRENT_LIMIT_600_QUERY_SWITCH_OK    0x02
+#define	CURRENT_LIMIT_800_QUERY_SWITCH_OK    0x03
+#define	CURRENT_LIMIT_200_SWITCH_BUSY        0x01
+#define	CURRENT_LIMIT_400_SWITCH_BUSY	     0x02
+#define	CURRENT_LIMIT_600_SWITCH_BUSY        0x04
+#define	CURRENT_LIMIT_800_SWITCH_BUSY        0x08
+#define	FUNCTION_GROUP4_SUPPORT_OFFSET       0x07
+#define FUNCTION_GROUP4_QUERY_SWITCH_OFFSET  0x0F
+#define FUNCTION_GROUP4_CHECK_BUSY_OFFSET    0x17
+/* Switch Function Status Offset */
+#define	DATA_STRUCTURE_VER_OFFSET   0x11 /* The high offset */
+#define MAX_PHASE		15
+/* #define      TOTAL_READ_PHASE    0x20 */
+/* #define      TOTAL_WRITE_PHASE    0x20 */
+/* MMC v4.0 */
+/* #define MMC_52MHZ_SPEED                       0x0001 */
+/* #define MMC_26MHZ_SPEED                       0x0002 */
+#define MMC_8BIT_BUS			0x0010
+#define MMC_4BIT_BUS			0x0020
+/* #define MMC_SECTOR_MODE                       0x0100 */
+#define MMC_SWITCH_ERR			0x80
+/* Tuning direction RX or TX */
+#define TUNE_TX    0x00
+#define TUNE_RX	   0x01
+/* For Change_DCM_FreqMode Function */
+#define CHANGE_TX  0x00
+#define CHANGE_RX  0x01
+#define DCM_HIGH_FREQUENCY_MODE  0x00
+#define DCM_LOW_FREQUENCY_MODE   0x01
+#define DCM_HIGH_FREQUENCY_MODE_SET  0x0C
+#define DCM_Low_FREQUENCY_MODE_SET   0x00
+/* For Change_FPGA_SSCClock Function */
+#define MULTIPLY_BY_1    0x00
+#define MULTIPLY_BY_2    0x01
+#define MULTIPLY_BY_3    0x02
+#define MULTIPLY_BY_4    0x03
+#define MULTIPLY_BY_5    0x04
+#define MULTIPLY_BY_6    0x05
+#define MULTIPLY_BY_7    0x06
+#define MULTIPLY_BY_8    0x07
+#define MULTIPLY_BY_9    0x08
+#define MULTIPLY_BY_10   0x09
+#define DIVIDE_BY_2      0x01
+#define DIVIDE_BY_3      0x02
+#define DIVIDE_BY_4      0x03
+#define DIVIDE_BY_5      0x04
+#define DIVIDE_BY_6      0x05
+#define DIVIDE_BY_7      0x06
+#define DIVIDE_BY_8      0x07
+#define DIVIDE_BY_9      0x08
+#define DIVIDE_BY_10     0x09
+#define CHECK_SD_TRANS_FAIL(chip, retval)	\
+	(((retval) != STATUS_SUCCESS) || \
+			(chip->rsp_buf[0] & SD_TRANSFER_ERR))
+/* SD Tuning Data Structure */
+/* Record continuous timing phase path */
+struct timing_phase_path {
+	int start;
+	int end;
+	int mid;
+	int len;
+};
+
+int rts51x_sd_select_card(struct rts51x_chip *chip, int select);
+int rts51x_reset_sd_card(struct rts51x_chip *chip);
+int rts51x_sd_switch_clock(struct rts51x_chip *chip);
+int rts51x_sd_rw(struct scsi_cmnd *srb, struct rts51x_chip *chip, u32 start_sector,
+	  u16 sector_cnt);
+void rts51x_sd_cleanup_work(struct rts51x_chip *chip);
+int rts51x_release_sd_card(struct rts51x_chip *chip);
+
+#ifdef SUPPORT_CPRM
+extern int reset_sd(struct rts51x_chip *chip);
+extern int sd_check_data0_status(struct rts51x_chip *chip);
+extern int sd_read_data(struct rts51x_chip *chip, u8 trans_mode, u8 *cmd,
+		int cmd_len, u16 byte_cnt, u16 blk_cnt, u8 bus_width,
+		u8 *buf, int buf_len, int timeout);
+#endif
+
+#endif /* __RTS51X_SD_H */
diff --git a/drivers/staging/rts5139/sd_cprm.c b/drivers/staging/rts5139/sd_cprm.c
new file mode 100644
index 000000000000..cede6c07394f
--- /dev/null
+++ b/drivers/staging/rts5139/sd_cprm.c
@@ -0,0 +1,1056 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include "debug.h"
+#include "trace.h"
+#include "rts51x.h"
+#include "rts51x_transport.h"
+#include "rts51x_scsi.h"
+#include "rts51x_card.h"
+#include "rts51x_chip.h"
+#include "sd_cprm.h"
+#include "sd.h"
+
+#ifdef SUPPORT_CPRM
+
+static inline int get_rsp_type(u8 rsp_code, u8 *rsp_type, int *rsp_len)
+{
+	if (!rsp_type || !rsp_len)
+		return STATUS_FAIL;
+
+	switch (rsp_code) {
+	case 0x03:
+		*rsp_type = SD_RSP_TYPE_R0; /* no response */
+		*rsp_len = 0;
+		break;
+
+	case 0x04:
+		*rsp_type = SD_RSP_TYPE_R1; /* R1,R6(,R4,R5) */
+		*rsp_len = 6;
+		break;
+
+	case 0x05:
+		*rsp_type = SD_RSP_TYPE_R1b;	/* R1b */
+		*rsp_len = 6;
+		break;
+
+	case 0x06:
+		*rsp_type = SD_RSP_TYPE_R2;	/* R2 */
+		*rsp_len = 17;
+		break;
+
+	case 0x07:
+		*rsp_type = SD_RSP_TYPE_R3;	/* R3 */
+		*rsp_len = 6;
+		break;
+
+	default:
+		return STATUS_FAIL;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int ext_sd_send_cmd_get_rsp(struct rts51x_chip *chip, u8 cmd_idx,
+			    u32 arg, u8 rsp_type, u8 *rsp, int rsp_len,
+			    int special_check)
+{
+	int retval;
+	int timeout = 50;
+	u16 reg_addr;
+	u8 buf[17], stat;
+	int len = 2;
+	int rty_cnt = 0;
+
+	RTS51X_DEBUGP("EXT SD/MMC CMD %d\n", cmd_idx);
+
+	if (rsp_type == SD_RSP_TYPE_R1b)
+		timeout = 3000;
+
+RTY_SEND_CMD:
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD0, 0xFF, 0x40 | cmd_idx);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD1, 0xFF, (u8) (arg >> 24));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD2, 0xFF, (u8) (arg >> 16));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD3, 0xFF, (u8) (arg >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD4, 0xFF, (u8) arg);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF, rsp_type);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE,
+		       0x01, PINGPONG_BUFFER);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER,
+		       0xFF, SD_TM_CMD_RSP | SD_TRANSFER_START);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER, SD_TRANSFER_END,
+		       SD_TRANSFER_END);
+
+	rts51x_add_cmd(chip, READ_REG_CMD, SD_STAT1, 0, 0);
+
+	if (CHECK_USB(chip, USB_20)) {
+		if (rsp_type == SD_RSP_TYPE_R2) {
+			for (reg_addr = PPBUF_BASE2;
+			     reg_addr < PPBUF_BASE2 + 16; reg_addr++) {
+				rts51x_add_cmd(chip, READ_REG_CMD, reg_addr, 0,
+					       0);
+			}
+			len = 19;
+		} else if (rsp_type != SD_RSP_TYPE_R0) {
+			/* Read data from SD_CMDx registers */
+			for (reg_addr = SD_CMD0; reg_addr <= SD_CMD4;
+			     reg_addr++) {
+				rts51x_add_cmd(chip, READ_REG_CMD, reg_addr, 0,
+					       0);
+			}
+			len = 8;
+		} else {
+			len = 3;
+		}
+		rts51x_add_cmd(chip, READ_REG_CMD, SD_CMD5, 0, 0);
+	} else {
+		len = 2;
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, len, timeout);
+
+	if (CHECK_SD_TRANS_FAIL(chip, retval)) {
+		rts51x_clear_sd_error(chip);
+
+		if (retval == STATUS_TIMEDOUT) {
+			if (rsp_type & SD_WAIT_BUSY_END) {
+				retval = sd_check_data0_status(chip);
+				if (retval != STATUS_SUCCESS)
+					TRACE_RET(chip, retval);
+			}
+		}
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	if (rsp_type == SD_RSP_TYPE_R0)
+		return STATUS_SUCCESS;
+
+	if (CHECK_USB(chip, USB_20)) {
+		rts51x_read_rsp_buf(chip, 2, buf, len - 2);
+	} else {
+		if (rsp_type == SD_RSP_TYPE_R2) {
+			reg_addr = PPBUF_BASE2;
+			len = 16;
+		} else {
+			reg_addr = SD_CMD0;
+			len = 5;
+		}
+		retval =
+		    rts51x_seq_read_register(chip, reg_addr,
+						     (unsigned short)len, buf);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		RTS51X_READ_REG(chip, SD_CMD5, buf + len);
+	}
+	stat = chip->rsp_buf[1];
+
+	if ((buf[0] & 0xC0) != 0)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if (!(rsp_type & SD_NO_CHECK_CRC7)) {
+		if (stat & SD_CRC7_ERR) {
+			if (cmd_idx == WRITE_MULTIPLE_BLOCK)
+				TRACE_RET(chip, STATUS_FAIL);
+			if (rty_cnt < SD_MAX_RETRY_COUNT) {
+				wait_timeout(20);
+				rty_cnt++;
+				goto RTY_SEND_CMD;
+			} else {
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+	}
+
+	if ((cmd_idx == SELECT_CARD) || (cmd_idx == APP_CMD) ||
+	    (cmd_idx == SEND_STATUS) || (cmd_idx == STOP_TRANSMISSION)) {
+		if ((cmd_idx != STOP_TRANSMISSION) && (special_check == 0)) {
+			if (buf[1] & 0x80)
+				TRACE_RET(chip, STATUS_FAIL);
+		}
+		if (buf[1] & 0x7F)
+			TRACE_RET(chip, STATUS_FAIL);
+		if (buf[2] & 0xF8)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		if (cmd_idx == SELECT_CARD) {
+			if (rsp_type == SD_RSP_TYPE_R2) {
+				if ((buf[3] & 0x1E) != 0x04)
+					TRACE_RET(chip, STATUS_FAIL);
+			} else if (rsp_type == SD_RSP_TYPE_R2) {
+				if ((buf[3] & 0x1E) != 0x03)
+					TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+	}
+
+	if (rsp && rsp_len)
+		memcpy(rsp, buf, rsp_len);
+
+	return STATUS_SUCCESS;
+}
+
+static int ext_sd_get_rsp(struct rts51x_chip *chip, int len,
+			u8 *rsp, u8 rsp_type)
+{
+	int retval, rsp_len;
+	u16 reg_addr;
+
+	if (rsp_type == SD_RSP_TYPE_R0)
+		return STATUS_SUCCESS;
+
+	rts51x_init_cmd(chip);
+
+	if (rsp_type == SD_RSP_TYPE_R2) {
+		for (reg_addr = PPBUF_BASE2; reg_addr < PPBUF_BASE2 + 16;
+		     reg_addr++) {
+			rts51x_add_cmd(chip, READ_REG_CMD, reg_addr, 0xFF, 0);
+		}
+		rsp_len = 17;
+	} else if (rsp_type != SD_RSP_TYPE_R0) {
+		for (reg_addr = SD_CMD0; reg_addr <= SD_CMD4; reg_addr++)
+			rts51x_add_cmd(chip, READ_REG_CMD, reg_addr, 0xFF, 0);
+		rsp_len = 6;
+	}
+	rts51x_add_cmd(chip, READ_REG_CMD, SD_CMD5, 0xFF, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, rsp_len, 100);
+
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (rsp) {
+		int min_len = (rsp_len < len) ? rsp_len : len;
+
+		memcpy(rsp, rts51x_get_rsp_data(chip), min_len);
+
+		RTS51X_DEBUGP("min_len = %d\n", min_len);
+		RTS51X_DEBUGP("Response in cmd buf: 0x%x 0x%x 0x%x 0x%x\n",
+			       rsp[0], rsp[1], rsp[2], rsp[3]);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int ext_rts51x_sd_execute_no_data(struct rts51x_chip *chip, unsigned int lun,
+			   u8 cmd_idx, u8 standby, u8 acmd, u8 rsp_code,
+			   u32 arg)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval, rsp_len;
+	u8 rsp_type;
+
+	retval = rts51x_sd_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, TRANSPORT_FAILED);
+
+	if (sd_card->pre_cmd_err) {
+		sd_card->pre_cmd_err = 0;
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+	retval = get_rsp_type(rsp_code, &rsp_type, &rsp_len);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+	sd_card->last_rsp_type = rsp_type;
+
+	retval = rts51x_sd_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	/* Set H/W SD/MMC Bus Width */
+	rts51x_write_register(chip, SD_CFG1, 0x03, SD_BUS_WIDTH_4);
+
+	if (standby) {
+		retval = rts51x_sd_select_card(chip, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Cmd_Failed);
+	}
+
+	if (acmd) {
+		retval =
+		    ext_sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
+					    SD_RSP_TYPE_R1, NULL, 0, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Cmd_Failed);
+	}
+
+	retval = ext_sd_send_cmd_get_rsp(chip, cmd_idx, arg, rsp_type,
+					 sd_card->rsp, rsp_len, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_GOTO(chip, SD_Execute_Cmd_Failed);
+
+	if (standby) {
+		retval = rts51x_sd_select_card(chip, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Cmd_Failed);
+	}
+
+	return TRANSPORT_GOOD;
+
+SD_Execute_Cmd_Failed:
+	sd_card->pre_cmd_err = 1;
+	rts51x_set_sense_type(chip, lun, SENSE_TYPE_NO_SENSE);
+	rts51x_release_sd_card(chip);
+	rts51x_do_rts51x_reset_sd_card(chip);
+	if (!(chip->card_ready & SD_CARD))
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+
+	TRACE_RET(chip, TRANSPORT_FAILED);
+}
+
+int ext_rts51x_sd_execute_read_data(struct rts51x_chip *chip, unsigned int lun,
+			     u8 cmd_idx, u8 cmd12, u8 standby,
+			     u8 acmd, u8 rsp_code, u32 arg, u32 data_len,
+			     void *data_buf, unsigned int buf_len, int use_sg)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval, rsp_len, i;
+	int cmd13_checkbit = 0, read_err = 0;
+	u8 rsp_type, bus_width;
+
+	if (sd_card->pre_cmd_err) {
+		sd_card->pre_cmd_err = 0;
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	retval = rts51x_sd_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+	retval = get_rsp_type(rsp_code, &rsp_type, &rsp_len);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+	sd_card->last_rsp_type = rsp_type;
+
+	retval = rts51x_sd_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	bus_width = SD_BUS_WIDTH_4;
+
+	if (data_len < 512) {
+		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, data_len,
+						 SD_RSP_TYPE_R1, NULL, 0, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+	}
+
+	if (standby) {
+		retval = rts51x_sd_select_card(chip, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+	}
+
+	if (acmd) {
+		retval =
+		    ext_sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
+					    SD_RSP_TYPE_R1, NULL, 0, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+	}
+
+	if (data_len <= 512) {
+		int min_len;
+		u8 *buf;
+		u16 byte_cnt, blk_cnt;
+		u8 cmd[5];
+		unsigned int offset = 0;
+		void *sg = NULL;
+
+		byte_cnt = (u16) (data_len & 0x3FF);
+		blk_cnt = 1;
+
+		cmd[0] = 0x40 | cmd_idx;
+		cmd[1] = (u8) (arg >> 24);
+		cmd[2] = (u8) (arg >> 16);
+		cmd[3] = (u8) (arg >> 8);
+		cmd[4] = (u8) arg;
+
+		buf = kmalloc(data_len, GFP_KERNEL);
+		if (buf == NULL)
+			TRACE_RET(chip, TRANSPORT_ERROR);
+
+		retval = sd_read_data(chip, SD_TM_NORMAL_READ, cmd, 5, byte_cnt,
+				      blk_cnt, bus_width, buf, data_len, 2000);
+		if (retval != STATUS_SUCCESS) {
+			read_err = 1;
+			kfree(buf);
+			rts51x_write_register(chip, CARD_STOP,
+					      SD_STOP | SD_CLR_ERR,
+					      SD_STOP | SD_CLR_ERR);
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+		}
+
+		min_len = min(data_len, buf_len);
+		if (use_sg)
+			rts51x_access_sglist(buf, min_len, (void *)data_buf,
+					     &sg, &offset, TO_XFER_BUF);
+		else
+			memcpy(data_buf, buf, min_len);
+
+		kfree(buf);
+	} else if (!(data_len & 0x1FF)) {
+		rts51x_init_cmd(chip);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_H, 0xFF, 0x02);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF, 0x00);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_H,
+			       0xFF, (u8) (data_len >> 17));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_L,
+			       0xFF, (u8) ((data_len & 0x0001FE00) >> 9));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD0, 0xFF,
+			       0x40 | cmd_idx);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD1, 0xFF,
+			       (u8) (arg >> 24));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD2, 0xFF,
+			       (u8) (arg >> 16));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD3, 0xFF,
+			       (u8) (arg >> 8));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CMD4, 0xFF, (u8) arg);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG1, 0x03, bus_width);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_CFG2, 0xFF, rsp_type);
+		rts51x_trans_dma_enable(DMA_FROM_DEVICE, chip, data_len, DMA_512);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+			       SD_TM_AUTO_READ_2 | SD_TRANSFER_START);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER,
+			       SD_TRANSFER_END, SD_TRANSFER_END);
+		retval = rts51x_send_cmd(chip, MODE_CDIR, 100);
+		if (retval != STATUS_SUCCESS) {
+			read_err = 1;
+			rts51x_ep0_write_register(chip, CARD_STOP,
+						  SD_STOP | SD_CLR_ERR,
+						  SD_STOP | SD_CLR_ERR);
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+		}
+
+		retval =
+		    rts51x_transfer_data_rcc(chip, RCV_BULK_PIPE(chip),
+					     data_buf, buf_len, use_sg, NULL,
+					     10000, STAGE_DI);
+		if (retval != STATUS_SUCCESS) {
+			read_err = 1;
+			rts51x_ep0_write_register(chip, CARD_STOP,
+						  SD_STOP | SD_CLR_ERR,
+						  SD_STOP | SD_CLR_ERR);
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+		}
+		retval = rts51x_get_rsp(chip, 1, 500);
+		if (CHECK_SD_TRANS_FAIL(chip, retval)) {
+			read_err = 1;
+			rts51x_ep0_write_register(chip, CARD_STOP,
+						  SD_STOP | SD_CLR_ERR,
+						  SD_STOP | SD_CLR_ERR);
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+		}
+	} else {
+		TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+	}
+
+	retval = ext_sd_get_rsp(chip, rsp_len, sd_card->rsp, rsp_type);
+	if (retval != STATUS_SUCCESS)
+		TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+
+	if (standby) {
+		retval = rts51x_sd_select_card(chip, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+	}
+
+	if (cmd12) {
+		retval = ext_sd_send_cmd_get_rsp(chip, STOP_TRANSMISSION,
+						 0, SD_RSP_TYPE_R1b, NULL, 0,
+						 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+	}
+
+	if (data_len < 512) {
+		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200,
+						 SD_RSP_TYPE_R1, NULL, 0, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+
+		rts51x_write_register(chip, SD_BYTE_CNT_H, 0xFF, 0x02);
+		rts51x_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
+	}
+
+	if (standby || cmd12)
+		cmd13_checkbit = 1;
+
+	for (i = 0; i < 3; i++) {
+		retval =
+		    ext_sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+					    SD_RSP_TYPE_R1, NULL, 0,
+					    cmd13_checkbit);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (retval != STATUS_SUCCESS)
+		TRACE_GOTO(chip, SD_Execute_Read_Cmd_Failed);
+
+	return TRANSPORT_GOOD;
+
+SD_Execute_Read_Cmd_Failed:
+	sd_card->pre_cmd_err = 1;
+	rts51x_set_sense_type(chip, lun, SENSE_TYPE_NO_SENSE);
+	if (read_err)
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+	rts51x_release_sd_card(chip);
+	rts51x_do_rts51x_reset_sd_card(chip);
+	if (!(chip->card_ready & SD_CARD))
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+
+	TRACE_RET(chip, TRANSPORT_FAILED);
+}
+
+int ext_rts51x_sd_execute_write_data(struct rts51x_chip *chip, unsigned int lun,
+			      u8 cmd_idx, u8 cmd12, u8 standby, u8 acmd,
+			      u8 rsp_code, u32 arg, u32 data_len,
+			      void *data_buf, unsigned int buf_len, int use_sg)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval, rsp_len;
+	int cmd13_checkbit = 0, write_err = 0;
+	u8 rsp_type;
+	u32 i;
+
+	if (sd_card->pre_cmd_err) {
+		sd_card->pre_cmd_err = 0;
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	retval = rts51x_sd_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	retval = get_rsp_type(rsp_code, &rsp_type, &rsp_len);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+	sd_card->last_rsp_type = rsp_type;
+
+	retval = rts51x_sd_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	rts51x_write_register(chip, SD_CFG1, 0x03, SD_BUS_WIDTH_4);
+
+	if (data_len < 512) {
+		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, data_len,
+						 SD_RSP_TYPE_R1, NULL, 0, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+	}
+
+	if (standby) {
+		retval = rts51x_sd_select_card(chip, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+	}
+
+	if (acmd) {
+		retval =
+		    ext_sd_send_cmd_get_rsp(chip, APP_CMD, sd_card->sd_addr,
+					    SD_RSP_TYPE_R1, NULL, 0, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+	}
+
+	retval = ext_sd_send_cmd_get_rsp(chip, cmd_idx, arg, rsp_type,
+					 sd_card->rsp, rsp_len, 0);
+	if (retval != STATUS_SUCCESS)
+		TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+
+	if (data_len <= 512) {
+		u8 *buf;
+		unsigned int offset = 0;
+		void *sg = NULL;
+
+		buf = kmalloc(data_len, GFP_KERNEL);
+		if (buf == NULL)
+			TRACE_RET(chip, TRANSPORT_ERROR);
+
+		if (use_sg)
+			rts51x_access_sglist(buf, data_len, (void *)data_buf,
+					     &sg, &offset, FROM_XFER_BUF);
+		else
+			memcpy(buf, data_buf, data_len);
+
+
+		if (data_len > 256) {
+			rts51x_init_cmd(chip);
+			for (i = 0; i < 256; i++) {
+				rts51x_add_cmd(chip, WRITE_REG_CMD,
+					       (u16) (PPBUF_BASE2 + i), 0xFF,
+					       buf[i]);
+			}
+			retval = rts51x_send_cmd(chip, MODE_C, 250);
+			if (retval != STATUS_SUCCESS) {
+				kfree(buf);
+				TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+			}
+
+			rts51x_init_cmd(chip);
+			for (i = 256; i < data_len; i++) {
+				rts51x_add_cmd(chip, WRITE_REG_CMD,
+					       (u16) (PPBUF_BASE2 + i), 0xFF,
+					       buf[i]);
+			}
+			retval = rts51x_send_cmd(chip, MODE_C, 250);
+			if (retval != STATUS_SUCCESS) {
+				kfree(buf);
+				TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+			}
+		} else {
+			rts51x_init_cmd(chip);
+			for (i = 0; i < data_len; i++) {
+				rts51x_add_cmd(chip, WRITE_REG_CMD,
+					       (u16) (PPBUF_BASE2 + i), 0xFF,
+					       buf[i]);
+			}
+			retval = rts51x_send_cmd(chip, MODE_C, 250);
+			if (retval != STATUS_SUCCESS) {
+				kfree(buf);
+				TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+			}
+		}
+
+		kfree(buf);
+
+		rts51x_init_cmd(chip);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_H, 0xFF,
+			       (u8) ((data_len >> 8) & 0x03));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF,
+			       (u8) data_len);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_H, 0xFF, 0x00);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_L, 0xFF, 0x01);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+			       PINGPONG_BUFFER);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+			       SD_TM_AUTO_WRITE_3 | SD_TRANSFER_START);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER,
+			       SD_TRANSFER_END, SD_TRANSFER_END);
+
+		retval = rts51x_send_cmd(chip, MODE_CR, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+
+		retval = rts51x_get_rsp(chip, 1, 250);
+		if (CHECK_SD_TRANS_FAIL(chip, retval))
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+	} else if (!(data_len & 0x1FF)) {
+		rts51x_init_cmd(chip);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_H, 0xFF, 0x02);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BYTE_CNT_L, 0xFF, 0x00);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_H,
+			       0xFF, (u8) (data_len >> 17));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_BLOCK_CNT_L,
+			       0xFF, (u8) ((data_len & 0x0001FE00) >> 9));
+
+		rts51x_trans_dma_enable(DMA_TO_DEVICE, chip, data_len, DMA_512);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, SD_TRANSFER, 0xFF,
+			       SD_TM_AUTO_WRITE_3 | SD_TRANSFER_START);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, SD_TRANSFER,
+			       SD_TRANSFER_END, SD_TRANSFER_END);
+
+		retval = rts51x_send_cmd(chip, MODE_CDOR, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+
+		retval =
+		    rts51x_transfer_data_rcc(chip, SND_BULK_PIPE(chip),
+					     data_buf, buf_len, use_sg, NULL,
+					     10000, STAGE_DO);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+
+		retval = rts51x_get_rsp(chip, 1, 10000);
+		if (CHECK_SD_TRANS_FAIL(chip, retval))
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+
+	} else {
+		TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+	}
+
+	if (retval < 0) {
+		write_err = 1;
+		rts51x_write_register(chip, CARD_STOP, SD_STOP | SD_CLR_ERR,
+				      SD_STOP | SD_CLR_ERR);
+		TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+	}
+
+	if (standby) {
+		retval = rts51x_sd_select_card(chip, 1);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+	}
+
+	if (cmd12) {
+		retval = ext_sd_send_cmd_get_rsp(chip, STOP_TRANSMISSION,
+						 0, SD_RSP_TYPE_R1b, NULL, 0,
+						 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+	}
+
+	if (data_len < 512) {
+		retval = ext_sd_send_cmd_get_rsp(chip, SET_BLOCKLEN, 0x200,
+						 SD_RSP_TYPE_R1, NULL, 0, 0);
+		if (retval != STATUS_SUCCESS)
+			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+
+		rts51x_write_register(chip, SD_BYTE_CNT_H, 0xFF, 0x02);
+		rts51x_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
+	}
+
+	if (cmd12 || standby) {
+		/* There is CMD7 or CMD12 sent before CMD13 */
+		cmd13_checkbit = 1;
+	}
+
+	for (i = 0; i < 3; i++) {
+		retval =
+		    ext_sd_send_cmd_get_rsp(chip, SEND_STATUS, sd_card->sd_addr,
+					    SD_RSP_TYPE_R1, NULL, 0,
+					    cmd13_checkbit);
+		if (retval == STATUS_SUCCESS)
+			break;
+	}
+	if (retval != STATUS_SUCCESS)
+		TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
+
+	return TRANSPORT_GOOD;
+
+SD_Execute_Write_Cmd_Failed:
+	sd_card->pre_cmd_err = 1;
+	rts51x_set_sense_type(chip, lun, SENSE_TYPE_NO_SENSE);
+	if (write_err)
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_WRITE_ERR);
+	rts51x_release_sd_card(chip);
+	rts51x_do_rts51x_reset_sd_card(chip);
+	if (!(chip->card_ready & SD_CARD))
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+
+	TRACE_RET(chip, TRANSPORT_FAILED);
+}
+
+int rts51x_sd_pass_thru_mode(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	unsigned int lun = SCSI_LUN(srb);
+	int len;
+	u8 buf[18] = {
+		0x00,
+		0x00,
+		0x00,
+		0x0E,
+		0x00,		/* Version Number */
+		0x00,		/* WP | Media Type */
+		0x00,		/* RCA (Low byte) */
+		0x00,		/* RCA (High byte) */
+		0x53,		/* 'S' */
+		0x44,		/* 'D' */
+		0x20,		/* ' ' */
+		0x43,		/* 'C' */
+		0x61,		/* 'a' */
+		0x72,		/* 'r' */
+		0x64,		/* 'd' */
+		0x00,		/* Max LUN Number */
+		0x00,
+		0x00,
+	};
+
+	sd_card->pre_cmd_err = 0;
+
+	if (!(CHK_BIT(chip->lun_mc, lun))) {
+		SET_BIT(chip->lun_mc, lun);
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if ((0x53 != srb->cmnd[2]) || (0x44 != srb->cmnd[3])
+	    || (0x20 != srb->cmnd[4]) || (0x43 != srb->cmnd[5])
+	    || (0x61 != srb->cmnd[6]) || (0x72 != srb->cmnd[7])
+	    || (0x64 != srb->cmnd[8])) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	switch (srb->cmnd[1] & 0x0F) {
+	case 0:
+		sd_card->sd_pass_thru_en = 0;
+		break;
+
+	case 1:
+		sd_card->sd_pass_thru_en = 1;
+		break;
+
+	default:
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	/* 0x01:SD Memory Card; 0x02:Other Media; 0x03:Illegal Media; */
+	buf[5] = (1 == CHK_SD(sd_card)) ? 0x01 : 0x02;
+	if (chip->card_wp & SD_CARD)
+		buf[5] |= 0x80;
+
+	buf[6] = (u8) (sd_card->sd_addr >> 16);
+	buf[7] = (u8) (sd_card->sd_addr >> 24);
+
+	buf[15] = chip->max_lun;
+
+	len = min_t(unsigned, 18, scsi_bufflen(srb));
+	rts51x_set_xfer_buf(buf, len, srb);
+
+	return TRANSPORT_GOOD;
+}
+
+int rts51x_sd_execute_no_data(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	unsigned int lun = SCSI_LUN(srb);
+	int retval;
+	u8 cmd_idx, rsp_code;
+	u8 standby = 0, acmd = 0;
+	u32 arg;
+
+	if (!sd_card->sd_pass_thru_en) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	cmd_idx = srb->cmnd[2] & 0x3F;
+	if (srb->cmnd[1] & 0x02)
+		standby = 1;
+	if (srb->cmnd[1] & 0x01)
+		acmd = 1;
+
+	arg = ((u32) srb->cmnd[3] << 24) | ((u32) srb->cmnd[4] << 16) |
+	    ((u32) srb->cmnd[5] << 8) | srb->cmnd[6];
+
+	rsp_code = srb->cmnd[10];
+
+	retval =
+	    ext_rts51x_sd_execute_no_data(chip, lun, cmd_idx, standby, acmd, rsp_code,
+				   arg);
+	scsi_set_resid(srb, 0);
+	return retval;
+}
+
+int rts51x_sd_execute_read_data(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	unsigned int lun = SCSI_LUN(srb);
+	u8 cmd_idx, rsp_code, send_cmd12 = 0, standby = 0, acmd = 0;
+	u32 arg, data_len;
+
+	if (!sd_card->sd_pass_thru_en) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	cmd_idx = srb->cmnd[2] & 0x3F;
+	if (srb->cmnd[1] & 0x04)
+		send_cmd12 = 1;
+	if (srb->cmnd[1] & 0x02)
+		standby = 1;
+	if (srb->cmnd[1] & 0x01)
+		acmd = 1;
+
+	arg = ((u32) srb->cmnd[3] << 24) | ((u32) srb->cmnd[4] << 16) |
+	    ((u32) srb->cmnd[5] << 8) | srb->cmnd[6];
+
+	data_len =
+	    ((u32) srb->cmnd[7] << 16) | ((u32) srb->cmnd[8] << 8) |
+	    srb->cmnd[9];
+	rsp_code = srb->cmnd[10];
+
+	retval =
+	    ext_rts51x_sd_execute_read_data(chip, lun, cmd_idx, send_cmd12, standby,
+				     acmd, rsp_code, arg, data_len,
+				     scsi_sglist(srb), scsi_bufflen(srb),
+				     scsi_sg_count(srb));
+	scsi_set_resid(srb, 0);
+	return retval;
+}
+
+int rts51x_sd_execute_write_data(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	int retval;
+	unsigned int lun = SCSI_LUN(srb);
+	u8 cmd_idx, rsp_code, send_cmd12 = 0, standby = 0, acmd = 0;
+	u32 data_len, arg;
+
+	if (!sd_card->sd_pass_thru_en) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	cmd_idx = srb->cmnd[2] & 0x3F;
+	if (srb->cmnd[1] & 0x04)
+		send_cmd12 = 1;
+	if (srb->cmnd[1] & 0x02)
+		standby = 1;
+	if (srb->cmnd[1] & 0x01)
+		acmd = 1;
+
+	data_len =
+	    ((u32) srb->cmnd[7] << 16) | ((u32) srb->cmnd[8] << 8) |
+	    srb->cmnd[9];
+	arg =
+	    ((u32) srb->cmnd[3] << 24) | ((u32) srb->cmnd[4] << 16) |
+	    ((u32) srb->cmnd[5] << 8) | srb->cmnd[6];
+	rsp_code = srb->cmnd[10];
+
+	retval =
+	    ext_rts51x_sd_execute_write_data(chip, lun, cmd_idx, send_cmd12, standby,
+				      acmd, rsp_code, arg, data_len,
+				      scsi_sglist(srb), scsi_bufflen(srb),
+				      scsi_sg_count(srb));
+	scsi_set_resid(srb, 0);
+	return retval;
+}
+
+int rts51x_sd_get_cmd_rsp(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	unsigned int lun = SCSI_LUN(srb);
+	int count;
+	u16 data_len;
+
+	if (!sd_card->sd_pass_thru_en) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (sd_card->pre_cmd_err) {
+		sd_card->pre_cmd_err = 0;
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	data_len = ((u16) srb->cmnd[7] << 8) | srb->cmnd[8];
+
+	if (sd_card->last_rsp_type == SD_RSP_TYPE_R0) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	} else if (sd_card->last_rsp_type == SD_RSP_TYPE_R2) {
+		count = (data_len < 17) ? data_len : 17;
+	} else {
+		count = (data_len < 6) ? data_len : 6;
+	}
+	rts51x_set_xfer_buf(sd_card->rsp, count, srb);
+
+	RTS51X_DEBUGP("Response length: %d\n", data_len);
+	RTS51X_DEBUGP("Response: 0x%x 0x%x 0x%x 0x%x\n",
+		       sd_card->rsp[0], sd_card->rsp[1], sd_card->rsp[2],
+		       sd_card->rsp[3]);
+
+	scsi_set_resid(srb, 0);
+	return TRANSPORT_GOOD;
+}
+
+int rts51x_sd_hw_rst(struct scsi_cmnd *srb, struct rts51x_chip *chip)
+{
+	struct sd_info *sd_card = &(chip->sd_card);
+	unsigned int lun = SCSI_LUN(srb);
+	int retval;
+
+	if (!sd_card->sd_pass_thru_en) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if (sd_card->pre_cmd_err) {
+		sd_card->pre_cmd_err = 0;
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_CHANGE);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	if ((0x53 != srb->cmnd[2]) || (0x44 != srb->cmnd[3])
+	    || (0x20 != srb->cmnd[4]) || (0x43 != srb->cmnd[5])
+	    || (0x61 != srb->cmnd[6]) || (0x72 != srb->cmnd[7])
+	    || (0x64 != srb->cmnd[8])) {
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	switch (srb->cmnd[1] & 0x0F) {
+	case 0:
+		/* SD Card Power Off -> ON and Initialization */
+		retval = rts51x_reset_sd_card(chip);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+			sd_card->pre_cmd_err = 1;
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		break;
+
+	case 1:
+		/* reset CMD(CMD0) and Initialization
+		 * (without SD Card Power Off -> ON) */
+		retval = reset_sd(chip);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_NOT_PRESENT);
+			sd_card->pre_cmd_err = 1;
+			TRACE_RET(chip, TRANSPORT_FAILED);
+		}
+		break;
+
+	default:
+		rts51x_set_sense_type(chip, lun, SENSE_TYPE_MEDIA_INVALID_CMD_FIELD);
+		TRACE_RET(chip, TRANSPORT_FAILED);
+	}
+
+	scsi_set_resid(srb, 0);
+	return TRANSPORT_GOOD;
+}
+#endif
diff --git a/drivers/staging/rts5139/sd_cprm.h b/drivers/staging/rts5139/sd_cprm.h
new file mode 100644
index 000000000000..79dfd27db41a
--- /dev/null
+++ b/drivers/staging/rts5139/sd_cprm.h
@@ -0,0 +1,54 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_SD_CPRM_H
+#define __RTS51X_SD_CPRM_H
+
+#include "rts51x_chip.h"
+#include "sd.h"
+
+#ifdef SUPPORT_CPRM
+int ext_rts51x_sd_execute_no_data(struct rts51x_chip *chip, unsigned int lun,
+			   u8 cmd_idx, u8 standby, u8 acmd, u8 rsp_code,
+			   u32 arg);
+int ext_rts51x_sd_execute_read_data(struct rts51x_chip *chip, unsigned int lun,
+			     u8 cmd_idx, u8 cmd12, u8 standby, u8 acmd,
+			     u8 rsp_code, u32 arg, u32 data_len, void *data_buf,
+			     unsigned int buf_len, int use_sg);
+int ext_rts51x_sd_execute_write_data(struct rts51x_chip *chip, unsigned int lun,
+			      u8 cmd_idx, u8 cmd12, u8 standby, u8 acmd,
+			      u8 rsp_code, u32 arg, u32 data_len,
+			      void *data_buf, unsigned int buf_len, int use_sg);
+
+int rts51x_sd_pass_thru_mode(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_sd_execute_no_data(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_sd_execute_read_data(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_sd_execute_write_data(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_sd_get_cmd_rsp(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+int rts51x_sd_hw_rst(struct scsi_cmnd *srb, struct rts51x_chip *chip);
+#endif
+
+#endif /* __RTS51X_SD_CPRM_H */
diff --git a/drivers/staging/rts5139/trace.h b/drivers/staging/rts5139/trace.h
new file mode 100644
index 000000000000..ac58b452ecb8
--- /dev/null
+++ b/drivers/staging/rts5139/trace.h
@@ -0,0 +1,95 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_TRACE_H
+#define __RTS51X_TRACE_H
+
+#include <linux/string.h>
+
+#include "debug.h"
+
+#define _MSG_TRACE
+
+#ifdef _MSG_TRACE
+#define TRACE_RET(chip, ret)						\
+do {									\
+	const char *_file = kbasename(__FILE__);			\
+	RTS51X_DEBUGP("[%s][%s]:[%d]\n", _file, __func__, __LINE__);	\
+	(chip)->trace_msg[(chip)->msg_idx].line = (u16)(__LINE__);	\
+	strncpy((chip)->trace_msg[(chip)->msg_idx].func,		\
+			__func__, MSG_FUNC_LEN-1);			\
+	strncpy((chip)->trace_msg[(chip)->msg_idx].file,		\
+			_file, MSG_FILE_LEN-1);				\
+	get_current_time((chip)->trace_msg[(chip)->msg_idx].timeval_buf,\
+			TIME_VAL_LEN);	\
+	(chip)->trace_msg[(chip)->msg_idx].valid = 1;			\
+	(chip)->msg_idx++;						\
+	if ((chip)->msg_idx >= TRACE_ITEM_CNT) {			\
+		(chip)->msg_idx = 0;					\
+	}								\
+	return ret;							\
+} while (0)
+
+#define TRACE_GOTO(chip, label)						\
+do {									\
+	const char *_file = kbasename(__FILE__);			\
+	RTS51X_DEBUGP("[%s][%s]:[%d]\n", _file, __func__, __LINE__);	\
+	(chip)->trace_msg[(chip)->msg_idx].line = (u16)(__LINE__);	\
+	strncpy((chip)->trace_msg[(chip)->msg_idx].func,		\
+			__func__, MSG_FUNC_LEN-1);			\
+	strncpy((chip)->trace_msg[(chip)->msg_idx].file,		\
+			_file, MSG_FILE_LEN-1);				\
+	get_current_time((chip)->trace_msg[(chip)->msg_idx].timeval_buf,\
+			TIME_VAL_LEN);					\
+	(chip)->trace_msg[(chip)->msg_idx].valid = 1;			\
+	(chip)->msg_idx++;						\
+	if ((chip)->msg_idx >= TRACE_ITEM_CNT) {			\
+		(chip)->msg_idx = 0;					\
+	}								\
+	goto label;							\
+} while (0)
+#else
+#define TRACE_RET(chip, ret)	return (ret)
+#define TRACE_GOTO(chip, label)	goto label
+#endif
+
+#ifdef CONFIG_RTS5139_DEBUG
+#define RTS51X_DUMP(buf, buf_len)					\
+	print_hex_dump(KERN_DEBUG, RTS51X_TIP, DUMP_PREFIX_NONE,	\
+				16, 1, (buf), (buf_len), false)
+
+#define CATCH_TRIGGER(chip)					\
+do {								\
+	rts51x_ep0_write_register((chip), 0xFC31, 0x01, 0x01);	\
+	RTS51X_DEBUGP("Catch trigger!\n");			\
+} while (0)
+
+#else
+#define RTS51X_DUMP(buf, buf_len)
+#define CATCH_TRIGGER(chip)
+#endif
+
+#endif /* __RTS51X_TRACE_H */
diff --git a/drivers/staging/rts5139/xd.c b/drivers/staging/rts5139/xd.c
new file mode 100644
index 000000000000..be432351be86
--- /dev/null
+++ b/drivers/staging/rts5139/xd.c
@@ -0,0 +1,2145 @@
+/* Driver for Realtek RTS51xx USB card reader
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <linux/vmalloc.h>
+
+#include "debug.h"
+#include "trace.h"
+#include "rts51x.h"
+#include "rts51x_transport.h"
+#include "rts51x_scsi.h"
+#include "rts51x_card.h"
+#include "xd.h"
+
+static int xd_build_l2p_tbl(struct rts51x_chip *chip, int zone_no);
+static int xd_init_page(struct rts51x_chip *chip, u32 phy_blk, u16 logoff,
+			u8 start_page, u8 end_page);
+
+static inline void xd_set_err_code(struct rts51x_chip *chip, u8 err_code)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+
+	xd_card->err_code = err_code;
+}
+
+static int xd_set_init_para(struct rts51x_chip *chip)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int retval;
+
+	if (chip->asic_code)
+		xd_card->xd_clock = 47;
+	else
+		xd_card->xd_clock = CLK_50;
+
+	retval = switch_clock(chip, xd_card->xd_clock);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_switch_clock(struct rts51x_chip *chip)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int retval;
+
+	retval = rts51x_select_card(chip, XD_CARD);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = switch_clock(chip, xd_card->xd_clock);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_read_id(struct rts51x_chip *chip, u8 id_cmd, u8 *id_buf,
+		      u8 buf_len)
+{
+	int retval, i;
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_DAT, 0xFF, id_cmd);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+		       XD_TRANSFER_START | XD_READ_ID);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER, XD_TRANSFER_END,
+		       XD_TRANSFER_END);
+
+	for (i = 0; i < 4; i++) {
+		rts51x_add_cmd(chip, READ_REG_CMD, (u16) (XD_ADDRESS1 + i), 0,
+			       0);
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 20);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 5, 20);
+
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	if (id_buf && buf_len) {
+		if (buf_len > 4)
+			buf_len = 4;
+		rts51x_read_rsp_buf(chip, 1, id_buf, buf_len);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static void xd_assign_phy_addr(struct rts51x_chip *chip, u32 addr, u8 mode)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+
+	switch (mode) {
+	case XD_RW_ADDR:
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_ADDRESS0, 0xFF, 0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_ADDRESS1, 0xFF,
+			       (u8) addr);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_ADDRESS2, 0xFF,
+			       (u8) (addr >> 8));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_ADDRESS3, 0xFF,
+			       (u8) (addr >> 16));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CFG, 0xFF,
+			       xd_card->addr_cycle | XD_CALC_ECC |
+			       XD_BA_NO_TRANSFORM);
+		break;
+
+	case XD_ERASE_ADDR:
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_ADDRESS0, 0xFF,
+			       (u8) addr);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_ADDRESS1, 0xFF,
+			       (u8) (addr >> 8));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_ADDRESS2, 0xFF,
+			       (u8) (addr >> 16));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CFG, 0xFF,
+			       (xd_card->addr_cycle - 1) |
+			       XD_CALC_ECC | XD_BA_NO_TRANSFORM);
+		break;
+
+	default:
+		break;
+	}
+}
+
+static int xd_read_redundant(struct rts51x_chip *chip, u32 page_addr, u8 *buf,
+			     int buf_len)
+{
+	int retval, i;
+
+	rts51x_init_cmd(chip);
+
+	xd_assign_phy_addr(chip, page_addr, XD_RW_ADDR);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+		       XD_TRANSFER_START | XD_READ_REDUNDANT);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER, XD_TRANSFER_END,
+		       XD_TRANSFER_END);
+
+	for (i = 0; i < 6; i++) {
+		rts51x_add_cmd(chip, READ_REG_CMD, (u16) (XD_PAGE_STATUS + i),
+			       0, 0);
+	}
+	for (i = 0; i < 4; i++) {
+		rts51x_add_cmd(chip, READ_REG_CMD, (u16) (XD_RESERVED0 + i), 0,
+			       0);
+	}
+	rts51x_add_cmd(chip, READ_REG_CMD, XD_PARITY, 0, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 11, 500);
+
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	if (buf && buf_len) {
+		if (buf_len > 11)
+			buf_len = 11;
+		rts51x_read_rsp_buf(chip, 1, buf, buf_len);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_read_data_from_ppb(struct rts51x_chip *chip, int offset, u8 *buf,
+				 int buf_len)
+{
+	int retval, i;
+
+	if (!buf || (buf_len <= 0))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	rts51x_init_cmd(chip);
+
+	for (i = 0; i < buf_len; i++) {
+		rts51x_add_cmd(chip, READ_REG_CMD, PPBUF_BASE2 + offset + i, 0,
+			       0);
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, buf_len, 200);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	rts51x_read_rsp_buf(chip, 0, buf, buf_len);
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_read_cis(struct rts51x_chip *chip, u32 page_addr, u8 *buf,
+		       int buf_len)
+{
+	int retval;
+	u8 reg;
+
+	if (!buf || (buf_len < 10))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	rts51x_init_cmd(chip);
+
+	xd_assign_phy_addr(chip, page_addr, XD_RW_ADDR);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       PINGPONG_BUFFER);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_CNT, 0xFF, 1);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CHK_DATA_STATUS,
+		       XD_AUTO_CHK_DATA_STATUS, XD_AUTO_CHK_DATA_STATUS);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+		       XD_TRANSFER_START | XD_READ_PAGES);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER,
+		       XD_TRANSFER_END | XD_PPB_EMPTY,
+		       XD_TRANSFER_END | XD_PPB_EMPTY);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 1, 500);
+	if (retval == STATUS_TIMEDOUT) {
+		rts51x_clear_xd_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	RTS51X_READ_REG(chip, XD_PAGE_STATUS, &reg);
+	if (reg != XD_GPG) {
+		rts51x_clear_xd_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	RTS51X_READ_REG(chip, XD_CTL, &reg);
+
+	if (!(reg & XD_ECC1_ERROR) || !(reg & XD_ECC1_UNCORRECTABLE)) {
+		retval = xd_read_data_from_ppb(chip, 0, buf, buf_len);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		if (reg & XD_ECC1_ERROR) {	/* correctable error */
+			u8 ecc_bit, ecc_byte;
+
+			RTS51X_READ_REG(chip, XD_ECC_BIT1, &ecc_bit);
+			RTS51X_READ_REG(chip, XD_ECC_BYTE1, &ecc_byte);
+
+			RTS51X_DEBUGP("ECC_BIT1 = 0x%x, ECC_BYTE1 = 0x%x\n",
+				       ecc_bit, ecc_byte);
+			if (ecc_byte < buf_len) {
+				RTS51X_DEBUGP("Before correct: 0x%x\n",
+					       buf[ecc_byte]);
+				buf[ecc_byte] ^= (1 << ecc_bit);
+				RTS51X_DEBUGP("After correct: 0x%x\n",
+					       buf[ecc_byte]);
+			}
+		}
+	} else if (!(reg & XD_ECC2_ERROR) || !(reg & XD_ECC2_UNCORRECTABLE)) {
+		RTS51X_WRITE_REG(chip, CARD_STOP, XD_STOP | XD_CLR_ERR,
+				 XD_STOP | XD_CLR_ERR);
+
+		retval = xd_read_data_from_ppb(chip, 256, buf, buf_len);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+		if (reg & XD_ECC2_ERROR) {
+			u8 ecc_bit, ecc_byte;
+
+			RTS51X_READ_REG(chip, XD_ECC_BIT2, &ecc_bit);
+			RTS51X_READ_REG(chip, XD_ECC_BYTE2, &ecc_byte);
+
+			RTS51X_DEBUGP("ECC_BIT2 = 0x%x, ECC_BYTE2 = 0x%x\n",
+				       ecc_bit, ecc_byte);
+			if (ecc_byte < buf_len) {
+				RTS51X_DEBUGP("Before correct: 0x%x\n",
+					       buf[ecc_byte]);
+				buf[ecc_byte] ^= (1 << ecc_bit);
+				RTS51X_DEBUGP("After correct: 0x%x\n",
+					       buf[ecc_byte]);
+			}
+		}
+	} else {
+		rts51x_clear_xd_error(chip);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static void xd_pull_ctl_disable(struct rts51x_chip *chip)
+{
+	if (CHECK_PKG(chip, LQFP48)) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0xA5);
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0x65);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x56);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0x59);
+	}
+}
+
+static void xd_pull_ctl_enable(struct rts51x_chip *chip)
+{
+	if (CHECK_PKG(chip, LQFP48)) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0xAA);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0xA5);
+	} else {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL1, 0xFF, 0xA5);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL2, 0xFF, 0x59);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL3, 0xFF, 0x95);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL4, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL5, 0xFF, 0x55);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PULL_CTL6, 0xFF, 0x59);
+	}
+}
+
+static int reset_xd(struct rts51x_chip *chip)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int retval, i, j;
+	u8 id_buf[4], redunt[11];
+
+	retval = rts51x_select_card(chip, XD_CARD);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CHK_DATA_STATUS, 0xFF,
+		       XD_PGSTS_NOT_FF);
+	if (chip->asic_code)
+		xd_pull_ctl_disable(chip);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, FPGA_PULL_CTL, 0xFF,
+			       (FPGA_XD_PULL_CTL_EN1 & FPGA_XD_PULL_CTL_EN3));
+
+	if (!chip->option.FT2_fast_mode) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_INIT, XD_NO_AUTO_PWR_OFF,
+			       0);
+		if (CHECK_PKG(chip, LQFP48) ||
+				chip->option.rts5129_D3318_off_enable) {
+			rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL,
+				       DV3318_AUTO_PWR_OFF,
+				       DV3318_AUTO_PWR_OFF);
+		}
+	}
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, XD_OUTPUT_EN, 0);
+	if (!chip->option.FT2_fast_mode) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK,
+			       POWER_OFF);
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	if (!chip->option.FT2_fast_mode) {
+#ifdef SD_XD_IO_FOLLOW_PWR
+		if (CHECK_PKG(chip, LQFP48)
+		    || chip->option.rts5129_D3318_off_enable) {
+			rts51x_write_register(chip, CARD_PWR_CTL,
+					LDO_OFF, LDO_OFF);
+		}
+#endif
+
+		wait_timeout(250);
+
+#ifdef SD_XD_IO_FOLLOW_PWR
+		if (CHECK_PKG(chip, LQFP48)
+		    || chip->option.rts5129_D3318_off_enable) {
+			rts51x_init_cmd(chip);
+			if (chip->asic_code) {
+				xd_pull_ctl_enable(chip);
+			} else {
+				rts51x_add_cmd(chip, WRITE_REG_CMD,
+					FPGA_PULL_CTL, 0xFF,
+					(FPGA_XD_PULL_CTL_EN1 &
+						FPGA_XD_PULL_CTL_EN2));
+			}
+			retval = rts51x_send_cmd(chip, MODE_C, 100);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, STATUS_FAIL);
+		}
+#endif
+
+		retval = rts51x_card_power_on(chip, XD_CARD);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+#ifdef SUPPORT_OCP
+		wait_timeout(50);
+		rts51x_get_card_status(chip, &(chip->card_status));
+		chip->ocp_stat = (chip->card_status >> 4) & 0x03;
+
+		if (chip->ocp_stat & (MS_OCP_NOW | MS_OCP_EVER)) {
+			RTS51X_DEBUGP("Over current, OCPSTAT is 0x%x\n",
+				       chip->ocp_stat);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+#endif
+	}
+
+	rts51x_init_cmd(chip);
+
+	if (chip->asic_code)
+		xd_pull_ctl_enable(chip);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, FPGA_PULL_CTL, 0xFF,
+			       (FPGA_XD_PULL_CTL_EN1 & FPGA_XD_PULL_CTL_EN2));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, XD_OUTPUT_EN,
+		       XD_OUTPUT_EN);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CTL, XD_CE_DISEN, XD_CE_DISEN);
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if (!chip->option.FT2_fast_mode)
+		wait_timeout(200);
+
+	retval = xd_set_init_para(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+	/* Read ID to check if the timing setting is right */
+	for (i = 0; i < 4; i++) {
+		u8 xd_dat, xd_ctl;
+
+		if (monitor_card_cd(chip, XD_CARD) == CD_NOT_EXIST)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		rts51x_init_cmd(chip);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_DTCTL, 0xFF,
+			XD_TIME_SETUP_STEP * 3 + XD_TIME_RW_STEP *
+			(2 + i + chip->option.rts51x_xd_rw_step)
+			+ XD_TIME_RWN_STEP *
+			(i + chip->option.rts51x_xd_rwn_step));
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CATCTL, 0xFF,
+			XD_TIME_SETUP_STEP * 3 + XD_TIME_RW_STEP * (4 +
+			i) + XD_TIME_RWN_STEP * (3 + i));
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+			       XD_TRANSFER_START | XD_RESET);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER,
+			       XD_TRANSFER_END, XD_TRANSFER_END);
+
+		rts51x_add_cmd(chip, READ_REG_CMD, XD_DAT, 0, 0);
+		rts51x_add_cmd(chip, READ_REG_CMD, XD_CTL, 0, 0);
+
+		retval = rts51x_send_cmd(chip, MODE_CR, 100);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_clear_xd_error(chip);
+			TRACE_RET(chip, retval);
+		}
+
+		retval = rts51x_get_rsp(chip, 3, 100);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_clear_xd_error(chip);
+			TRACE_RET(chip, retval);
+		}
+
+		xd_dat = chip->rsp_buf[1];
+		xd_ctl = chip->rsp_buf[2];
+		RTS51X_DEBUGP("XD_DAT: 0x%x, XD_CTL: 0x%x\n", xd_dat, xd_ctl);
+
+		if (((xd_dat & READY_FLAG) != READY_STATE)
+		    || !(xd_ctl & XD_RDY))
+			continue;
+
+		retval = xd_read_id(chip, READ_ID, id_buf, 4);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		RTS51X_DEBUGP("READ_ID: 0x%x 0x%x 0x%x 0x%x\n",
+			       id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
+
+		xd_card->device_code = id_buf[1];
+
+		switch (xd_card->device_code) {
+		case XD_4M_X8_512_1:
+		case XD_4M_X8_512_2:
+			xd_card->block_shift = 4;	/* 16 pages per block */
+			xd_card->page_off = 0x0F;
+			xd_card->addr_cycle = 3;
+			xd_card->zone_cnt = 1;
+			xd_card->capacity = 8000;	/* 500 * 2 ^ 4 */
+			XD_SET_4MB(xd_card);
+			break;
+		case XD_8M_X8_512:
+			xd_card->block_shift = 4;
+			xd_card->page_off = 0x0F;
+			xd_card->addr_cycle = 3;
+			xd_card->zone_cnt = 1;
+			xd_card->capacity = 16000;	/* 1000 * 2 ^ 4 */
+			break;
+		case XD_16M_X8_512:
+			XD_PAGE_512(xd_card);	/* 32 pages per block */
+			xd_card->addr_cycle = 3;
+			xd_card->zone_cnt = 1;
+			xd_card->capacity = 32000;	/* 1000 * 2 ^ 5 */
+			break;
+		case XD_32M_X8_512:
+			XD_PAGE_512(xd_card);
+			xd_card->addr_cycle = 3;
+			xd_card->zone_cnt = 2;
+			xd_card->capacity = 64000;	/* 2000 * 2 ^ 5 */
+			break;
+		case XD_64M_X8_512:
+			XD_PAGE_512(xd_card);
+			xd_card->addr_cycle = 4;
+			xd_card->zone_cnt = 4;
+			xd_card->capacity = 128000;	/* 4000 * 2 ^ 5 */
+			break;
+		case XD_128M_X8_512:
+			XD_PAGE_512(xd_card);
+			xd_card->addr_cycle = 4;
+			xd_card->zone_cnt = 8;
+			xd_card->capacity = 256000;	/* 8000 * 2 ^ 5 */
+			break;
+		case XD_256M_X8_512:
+			XD_PAGE_512(xd_card);
+			xd_card->addr_cycle = 4;
+			xd_card->zone_cnt = 16;
+			xd_card->capacity = 512000;	/* 16000 * 2 ^ 5 */
+			break;
+		case XD_512M_X8:
+			XD_PAGE_512(xd_card);
+			xd_card->addr_cycle = 4;
+			xd_card->zone_cnt = 32;
+			xd_card->capacity = 1024000;	/* 32000 * 2 ^ 5 */
+			break;
+		case xD_1G_X8_512:
+			XD_PAGE_512(xd_card);
+			xd_card->addr_cycle = 4;
+			xd_card->zone_cnt = 64;
+			xd_card->capacity = 2048000;	/* 64000 * 2 ^ 5 */
+			break;
+		case xD_2G_X8_512:
+			XD_PAGE_512(xd_card);
+			xd_card->addr_cycle = 4;
+			xd_card->zone_cnt = 128;
+			xd_card->capacity = 4096000;	/* 128000 * 2 ^ 5 */
+			break;
+		default:
+			continue;
+		}
+
+		/* Confirm timing setting */
+		for (j = 0; j < 10; j++) {
+			retval = xd_read_id(chip, READ_ID, id_buf, 4);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+
+			if (id_buf[1] != xd_card->device_code)
+				break;
+		}
+
+		/* Current timing pass */
+		if (j == 10)
+			break;
+	}
+
+	if (i == 4) {
+		xd_card->block_shift = 0;
+		xd_card->page_off = 0;
+		xd_card->addr_cycle = 0;
+		xd_card->capacity = 0;
+
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	retval = xd_read_id(chip, READ_xD_ID, id_buf, 4);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+	RTS51X_DEBUGP("READ_xD_ID: 0x%x 0x%x 0x%x 0x%x\n",
+		       id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
+	if (id_buf[2] != XD_ID_CODE)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	/* Search CIS block */
+	for (i = 0; i < 24; i++) {
+		u32 page_addr;
+
+		if (monitor_card_cd(chip, XD_CARD) == CD_NOT_EXIST)
+			TRACE_RET(chip, STATUS_FAIL);
+
+		page_addr = (u32) i << xd_card->block_shift;
+
+		for (j = 0; j < 3; j++) {
+			retval = xd_read_redundant(chip, page_addr, redunt, 11);
+			if (retval == STATUS_SUCCESS)
+				break;
+		}
+		if (j == 3)
+			continue;
+
+		if (redunt[BLOCK_STATUS] != XD_GBLK)
+			continue;
+
+		j = 0;
+		/* Check page status */
+		if (redunt[PAGE_STATUS] != XD_GPG) {
+			for (j = 1; j <= 8; j++) {
+				retval =
+				    xd_read_redundant(chip, page_addr + j,
+						      redunt, 11);
+				if (retval == STATUS_SUCCESS) {
+					if (redunt[PAGE_STATUS] == XD_GPG)
+						break;
+				}
+			}
+
+			if (j == 9)
+				break;
+		}
+
+		if ((redunt[BLOCK_STATUS] == XD_GBLK)
+		    && (redunt[PARITY] & XD_BA1_ALL0)) {
+			u8 buf[10];
+
+			page_addr += j;
+
+			retval = xd_read_cis(chip, page_addr, buf, 10);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+
+			if ((buf[0] == 0x01) && (buf[1] == 0x03)
+			    && (buf[2] == 0xD9)
+			    && (buf[3] == 0x01) && (buf[4] == 0xFF)
+			    && (buf[5] == 0x18) && (buf[6] == 0x02)
+			    && (buf[7] == 0xDF) && (buf[8] == 0x01)
+			    && (buf[9] == 0x20)) {
+				xd_card->cis_block = (u16) i;
+			}
+		}
+
+		break;
+	}
+
+	RTS51X_DEBUGP("CIS block: 0x%x\n", xd_card->cis_block);
+	if (xd_card->cis_block == 0xFFFF)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	chip->capacity[chip->card2lun[XD_CARD]] = xd_card->capacity;
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_check_data_blank(u8 *redunt)
+{
+	int i;
+
+	for (i = 0; i < 6; i++) {
+		if (redunt[PAGE_STATUS + i] != 0xFF)
+			return 0;
+	}
+
+	if ((redunt[PARITY] & (XD_ECC1_ALL1 | XD_ECC2_ALL1)) !=
+	    (XD_ECC1_ALL1 | XD_ECC2_ALL1))
+		return 0;
+
+	for (i = 0; i < 4; i++) {
+		if (redunt[RESERVED0 + i] != 0xFF)
+			return 0;
+	}
+
+	return 1;
+}
+
+static u16 xd_load_log_block_addr(u8 *redunt)
+{
+	u16 addr = 0xFFFF;
+
+	if (redunt[PARITY] & XD_BA1_BA2_EQL)
+		addr =
+		    ((u16) redunt[BLOCK_ADDR1_H] << 8) | redunt[BLOCK_ADDR1_L];
+	else if (redunt[PARITY] & XD_BA1_VALID)
+		addr =
+		    ((u16) redunt[BLOCK_ADDR1_H] << 8) | redunt[BLOCK_ADDR1_L];
+	else if (redunt[PARITY] & XD_BA2_VALID)
+		addr =
+		    ((u16) redunt[BLOCK_ADDR2_H] << 8) | redunt[BLOCK_ADDR2_L];
+
+	return addr;
+}
+
+static int xd_init_l2p_tbl(struct rts51x_chip *chip)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int size, i;
+
+	RTS51X_DEBUGP("xd_init_l2p_tbl: zone_cnt = %d\n", xd_card->zone_cnt);
+
+	if (xd_card->zone_cnt < 1)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	size = xd_card->zone_cnt * sizeof(struct zone_entry);
+	RTS51X_DEBUGP("Buffer size for l2p table is %d\n", size);
+
+	xd_card->zone = vmalloc(size);
+	if (!xd_card->zone)
+		TRACE_RET(chip, STATUS_NOMEM);
+
+	for (i = 0; i < xd_card->zone_cnt; i++) {
+		xd_card->zone[i].build_flag = 0;
+		xd_card->zone[i].l2p_table = NULL;
+		xd_card->zone[i].free_table = NULL;
+		xd_card->zone[i].get_index = 0;
+		xd_card->zone[i].set_index = 0;
+		xd_card->zone[i].unused_blk_cnt = 0;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static inline void free_zone(struct zone_entry *zone)
+{
+	RTS51X_DEBUGP("free_zone\n");
+	if (!zone)
+		return;
+	zone->build_flag = 0;
+	zone->set_index = 0;
+	zone->get_index = 0;
+	zone->unused_blk_cnt = 0;
+	if (zone->l2p_table) {
+		vfree(zone->l2p_table);
+		zone->l2p_table = NULL;
+	}
+	if (zone->free_table) {
+		vfree(zone->free_table);
+		zone->free_table = NULL;
+	}
+}
+
+static void xd_set_unused_block(struct rts51x_chip *chip, u32 phy_blk)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	struct zone_entry *zone;
+	int zone_no;
+
+	zone_no = (int)phy_blk >> 10;
+	if (zone_no >= xd_card->zone_cnt) {
+		RTS51X_DEBUGP("Set unused block to invalid zone"
+					"(zone_no = %d, zone_cnt = %d)\n",
+					zone_no, xd_card->zone_cnt);
+		return;
+	}
+	zone = &(xd_card->zone[zone_no]);
+
+	if (zone->free_table == NULL) {
+		if (xd_build_l2p_tbl(chip, zone_no) != STATUS_SUCCESS)
+			return;
+	}
+
+	if ((zone->set_index >= XD_FREE_TABLE_CNT)
+	    || (zone->set_index < 0)) {
+		free_zone(zone);
+		RTS51X_DEBUGP("Set unused block fail, invalid set_index\n");
+		return;
+	}
+
+	RTS51X_DEBUGP("Set unused block to index %d\n", zone->set_index);
+
+	zone->free_table[zone->set_index++] = (u16) (phy_blk & 0x3ff);
+	if (zone->set_index >= XD_FREE_TABLE_CNT)
+		zone->set_index = 0;
+	zone->unused_blk_cnt++;
+}
+
+static u32 xd_get_unused_block(struct rts51x_chip *chip, int zone_no)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	struct zone_entry *zone;
+	u32 phy_blk;
+
+	if (zone_no >= xd_card->zone_cnt) {
+		RTS51X_DEBUGP("Get unused block from invalid zone"
+					"(zone_no = %d, zone_cnt = %d)\n",
+					zone_no, xd_card->zone_cnt);
+		TRACE_RET(chip, BLK_NOT_FOUND);
+	}
+	zone = &(xd_card->zone[zone_no]);
+
+	if ((zone->unused_blk_cnt == 0) ||
+			(zone->set_index == zone->get_index)) {
+		free_zone(zone);
+		RTS51X_DEBUGP("Get unused block fail,"
+					"no unused block available\n");
+		TRACE_RET(chip, BLK_NOT_FOUND);
+	}
+	if ((zone->get_index >= XD_FREE_TABLE_CNT) || (zone->get_index < 0)) {
+		free_zone(zone);
+		RTS51X_DEBUGP("Get unused block fail, invalid get_index\n");
+		TRACE_RET(chip, BLK_NOT_FOUND);
+	}
+
+	RTS51X_DEBUGP("Get unused block from index %d\n", zone->get_index);
+
+	phy_blk = zone->free_table[zone->get_index];
+	zone->free_table[zone->get_index++] = 0xFFFF;
+	if (zone->get_index >= XD_FREE_TABLE_CNT)
+		zone->get_index = 0;
+	zone->unused_blk_cnt--;
+
+	phy_blk += ((u32) (zone_no) << 10);
+	return phy_blk;
+}
+
+static void xd_set_l2p_tbl(struct rts51x_chip *chip, int zone_no, u16 log_off,
+			   u16 phy_off)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	struct zone_entry *zone;
+
+	zone = &(xd_card->zone[zone_no]);
+	zone->l2p_table[log_off] = phy_off;
+}
+
+static int xd_delay_write(struct rts51x_chip *chip);
+
+static u32 xd_get_l2p_tbl(struct rts51x_chip *chip, int zone_no, u16 log_off)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	struct zone_entry *zone;
+	int retval;
+
+	zone = &(xd_card->zone[zone_no]);
+	if (zone->l2p_table[log_off] == 0xFFFF) {
+		u32 phy_blk = 0;
+		int i;
+
+		retval = xd_delay_write(chip);
+		if (retval != STATUS_SUCCESS) {
+			RTS51X_DEBUGP("In xd_get_l2p_tbl,"
+						"delay write fail!\n");
+			TRACE_RET(chip, BLK_NOT_FOUND);
+		}
+
+		if (zone->unused_blk_cnt <= 0) {
+			RTS51X_DEBUGP("No unused block!\n");
+			TRACE_RET(chip, BLK_NOT_FOUND);
+		}
+
+		for (i = 0; i < zone->unused_blk_cnt; i++) {
+			phy_blk = xd_get_unused_block(chip, zone_no);
+			if (phy_blk == BLK_NOT_FOUND) {
+				RTS51X_DEBUGP("No unused block available!\n");
+				TRACE_RET(chip, BLK_NOT_FOUND);
+			}
+
+			retval =
+			    xd_init_page(chip, phy_blk, log_off, 0,
+					 xd_card->page_off + 1);
+			if (retval == STATUS_SUCCESS)
+				break;
+		}
+		if (i >= zone->unused_blk_cnt) {
+			RTS51X_DEBUGP("No good unused block available!\n");
+			TRACE_RET(chip, BLK_NOT_FOUND);
+		}
+
+		xd_set_l2p_tbl(chip, zone_no, log_off, (u16) (phy_blk & 0x3FF));
+		return phy_blk;
+	}
+
+	return (u32) zone->l2p_table[log_off] + ((u32) (zone_no) << 10);
+}
+
+int rts51x_reset_xd_card(struct rts51x_chip *chip)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int retval;
+
+	memset(xd_card, 0, sizeof(struct xd_info));
+
+	xd_card->block_shift = 0;
+	xd_card->page_off = 0;
+	xd_card->addr_cycle = 0;
+	xd_card->capacity = 0;
+	xd_card->zone_cnt = 0;
+	xd_card->cis_block = 0xFFFF;
+	xd_card->delay_write.delay_write_flag = 0;
+
+	rts51x_enable_card_clock(chip, XD_CARD);
+
+	retval = reset_xd(chip);
+	if (retval != STATUS_SUCCESS) {
+		if (chip->option.reset_or_rw_fail_set_pad_drive) {
+			rts51x_write_register(chip, CARD_DRIVE_SEL,
+					      SD20_DRIVE_MASK, DRIVE_8mA);
+		}
+		TRACE_RET(chip, retval);
+	}
+
+	retval = xd_init_l2p_tbl(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_mark_bad_block(struct rts51x_chip *chip, u32 phy_blk)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int retval;
+	u32 page_addr;
+	u8 reg = 0;
+
+	RTS51X_DEBUGP("mark block 0x%x as bad block\n", phy_blk);
+
+	if (phy_blk == BLK_NOT_FOUND)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_STATUS, 0xFF, XD_GPG);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_STATUS, 0xFF,
+		       XD_LATER_BBLK);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_ADDR1_H, 0xFF, 0xFF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_ADDR1_L, 0xFF, 0xFF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_ADDR2_H, 0xFF, 0xFF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_ADDR2_L, 0xFF, 0xFF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_RESERVED0, 0xFF, 0xFF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_RESERVED1, 0xFF, 0xFF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_RESERVED2, 0xFF, 0xFF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_RESERVED3, 0xFF, 0xFF);
+
+	page_addr = phy_blk << xd_card->block_shift;
+
+	xd_assign_phy_addr(chip, page_addr, XD_RW_ADDR);
+
+	/* Specify page count */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_CNT, 0xFF,
+		       xd_card->page_off + 1);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+		       XD_TRANSFER_START | XD_WRITE_REDUNDANT);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER, XD_TRANSFER_END,
+		       XD_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	retval = rts51x_get_rsp(chip, 1, 100);
+
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+		rts51x_ep0_read_register(chip, XD_DAT, &reg);
+		if (reg & PROGRAM_ERROR)
+			xd_set_err_code(chip, XD_PRG_ERROR);
+		else
+			xd_set_err_code(chip, XD_TO_ERROR);
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_init_page(struct rts51x_chip *chip, u32 phy_blk, u16 logoff,
+			u8 start_page, u8 end_page)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int retval;
+	u32 page_addr;
+	u8 reg = 0;
+
+	RTS51X_DEBUGP("Init block 0x%x\n", phy_blk);
+
+	if (start_page > end_page)
+		TRACE_RET(chip, STATUS_FAIL);
+	if (phy_blk == BLK_NOT_FOUND)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_STATUS, 0xFF, 0xFF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_STATUS, 0xFF, 0xFF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_ADDR1_H, 0xFF,
+		       (u8) (logoff >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_ADDR1_L, 0xFF,
+		       (u8) logoff);
+
+	page_addr = (phy_blk << xd_card->block_shift) + start_page;
+
+	xd_assign_phy_addr(chip, page_addr, XD_RW_ADDR);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CFG, XD_BA_TRANSFORM,
+		       XD_BA_TRANSFORM);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_CNT, 0xFF,
+		       (end_page - start_page));
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+		       XD_TRANSFER_START | XD_WRITE_REDUNDANT);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER, XD_TRANSFER_END,
+		       XD_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	retval = rts51x_get_rsp(chip, 1, 500);
+
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+		rts51x_ep0_read_register(chip, XD_DAT, &reg);
+		if (reg & PROGRAM_ERROR) {
+			xd_mark_bad_block(chip, phy_blk);
+			xd_set_err_code(chip, XD_PRG_ERROR);
+		} else {
+			xd_set_err_code(chip, XD_TO_ERROR);
+		}
+		TRACE_RET(chip, STATUS_FAIL);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_copy_page(struct rts51x_chip *chip,
+			u32 old_blk, u32 new_blk, u8 start_page, u8 end_page)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	u32 old_page, new_page;
+	u8 i, reg = 0;
+	int retval;
+
+	RTS51X_DEBUGP("Copy page from block 0x%x to block 0x%x\n", old_blk,
+		       new_blk);
+
+	if (start_page > end_page)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	if ((old_blk == BLK_NOT_FOUND) || (new_blk == BLK_NOT_FOUND))
+		TRACE_RET(chip, STATUS_FAIL);
+
+	old_page = (old_blk << xd_card->block_shift) + start_page;
+	new_page = (new_blk << xd_card->block_shift) + start_page;
+
+	XD_CLR_BAD_NEWBLK(xd_card);
+
+	RTS51X_WRITE_REG(chip, CARD_DATA_SOURCE, 0x01, PINGPONG_BUFFER);
+
+	for (i = start_page; i < end_page; i++) {
+		if (monitor_card_cd(chip, XD_CARD) == CD_NOT_EXIST) {
+			RTS51X_WRITE_REG(chip, CARD_STOP, XD_STOP | XD_CLR_ERR,
+					 XD_STOP | XD_CLR_ERR);
+			xd_set_err_code(chip, XD_NO_CARD);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		rts51x_init_cmd(chip);
+
+		xd_assign_phy_addr(chip, old_page, XD_RW_ADDR);
+
+		/* Single page read */
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_CNT, 0xFF, 1);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CHK_DATA_STATUS,
+			       XD_AUTO_CHK_DATA_STATUS, 0);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+			       XD_TRANSFER_START | XD_READ_PAGES);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER,
+			       XD_TRANSFER_END, XD_TRANSFER_END);
+
+		retval = rts51x_send_cmd(chip, MODE_CR | STAGE_XD_STATUS, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = rts51x_get_rsp(chip, 4, 500);
+		if ((retval != STATUS_SUCCESS) ||
+		    (chip->rsp_buf[2] & (XD_ECC1_ERROR | XD_ECC2_ERROR))) {
+			rts51x_clear_xd_error(chip);
+			reg = 0;
+			rts51x_ep0_read_register(chip, XD_CTL, &reg);
+			if (reg & (XD_ECC1_ERROR | XD_ECC2_ERROR)) {
+				wait_timeout(100);
+
+				if (monitor_card_cd(chip, XD_CARD) ==
+				    CD_NOT_EXIST) {
+					xd_set_err_code(chip, XD_NO_CARD);
+					TRACE_RET(chip, STATUS_FAIL);
+				}
+
+				if (((reg &
+				      (XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE))
+				     == (XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE))
+				    || ((reg & (XD_ECC2_ERROR |
+					XD_ECC2_UNCORRECTABLE)) ==
+				     (XD_ECC2_ERROR | XD_ECC2_UNCORRECTABLE))) {
+					RTS51X_WRITE_REG(chip, XD_PAGE_STATUS,
+							 0xFF, XD_BPG);
+					RTS51X_WRITE_REG(chip, XD_BLOCK_STATUS,
+							 0xFF, XD_GBLK);
+					XD_SET_BAD_OLDBLK(xd_card);
+					RTS51X_DEBUGP("old block 0x%x"
+						"ecc error\n", old_blk);
+				}
+			} else {
+				xd_set_err_code(chip, XD_TO_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+		if (XD_CHK_BAD_OLDBLK(xd_card))
+			rts51x_clear_xd_error(chip);
+
+		rts51x_init_cmd(chip);
+
+		xd_assign_phy_addr(chip, new_page, XD_RW_ADDR);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_CNT, 0xFF, 1);
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+			       XD_TRANSFER_START | XD_WRITE_PAGES);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER,
+			       XD_TRANSFER_END, XD_TRANSFER_END);
+
+		retval = rts51x_send_cmd(chip, MODE_CR, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = rts51x_get_rsp(chip, 1, 300);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_clear_xd_error(chip);
+			reg = 0;
+			rts51x_ep0_read_register(chip, XD_DAT, &reg);
+			if (reg & PROGRAM_ERROR) {
+				xd_mark_bad_block(chip, new_blk);
+				xd_set_err_code(chip, XD_PRG_ERROR);
+				XD_SET_BAD_NEWBLK(xd_card);
+			} else {
+				xd_set_err_code(chip, XD_TO_ERROR);
+			}
+			TRACE_RET(chip, retval);
+		}
+
+		old_page++;
+		new_page++;
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_reset_cmd(struct rts51x_chip *chip)
+{
+	int retval;
+	u8 xd_dat, xd_ctl;
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+		       XD_TRANSFER_START | XD_RESET);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER, XD_TRANSFER_END,
+		       XD_TRANSFER_END);
+	rts51x_add_cmd(chip, READ_REG_CMD, XD_DAT, 0, 0);
+	rts51x_add_cmd(chip, READ_REG_CMD, XD_CTL, 0, 0);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 3, 100);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	xd_dat = chip->rsp_buf[1];
+	xd_ctl = chip->rsp_buf[2];
+	if (((xd_dat & READY_FLAG) == READY_STATE) && (xd_ctl & XD_RDY))
+		return STATUS_SUCCESS;
+
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+static int xd_erase_block(struct rts51x_chip *chip, u32 phy_blk)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	u32 page_addr;
+	u8 reg = 0, xd_dat;
+	int i, retval;
+
+	if (phy_blk == BLK_NOT_FOUND)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	page_addr = phy_blk << xd_card->block_shift;
+
+	for (i = 0; i < 3; i++) {
+		rts51x_init_cmd(chip);
+
+		xd_assign_phy_addr(chip, page_addr, XD_ERASE_ADDR);
+
+		rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+			       XD_TRANSFER_START | XD_ERASE);
+		rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER,
+			       XD_TRANSFER_END, XD_TRANSFER_END);
+		rts51x_add_cmd(chip, READ_REG_CMD, XD_DAT, 0, 0);
+
+		retval = rts51x_send_cmd(chip, MODE_CR, 100);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		retval = rts51x_get_rsp(chip, 2, 300);
+		if (retval != STATUS_SUCCESS) {
+			rts51x_clear_xd_error(chip);
+			rts51x_ep0_read_register(chip, XD_DAT, &reg);
+			if (reg & PROGRAM_ERROR) {
+				xd_mark_bad_block(chip, phy_blk);
+				xd_set_err_code(chip, XD_PRG_ERROR);
+				TRACE_RET(chip, STATUS_FAIL);
+			} else {
+				xd_set_err_code(chip, XD_ERASE_FAIL);
+			}
+			retval = xd_reset_cmd(chip);
+			if (retval != STATUS_SUCCESS)
+				TRACE_RET(chip, retval);
+			continue;
+		}
+		xd_dat = chip->rsp_buf[1];
+		if (xd_dat & PROGRAM_ERROR) {
+			xd_mark_bad_block(chip, phy_blk);
+			xd_set_err_code(chip, XD_PRG_ERROR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		return STATUS_SUCCESS;
+	}
+
+	xd_mark_bad_block(chip, phy_blk);
+	xd_set_err_code(chip, XD_ERASE_FAIL);
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+static int xd_build_l2p_tbl(struct rts51x_chip *chip, int zone_no)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	struct zone_entry *zone;
+	int retval;
+	u32 start, end, i;
+	u16 max_logoff, cur_fst_page_logoff, cur_lst_page_logoff,
+	    ent_lst_page_logoff;
+	u8 redunt[11];
+
+	RTS51X_DEBUGP("xd_build_l2p_tbl: %d\n", zone_no);
+
+	if (xd_card->zone == NULL) {
+		retval = xd_init_l2p_tbl(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	if (xd_card->zone[zone_no].build_flag) {
+		RTS51X_DEBUGP("l2p table of zone %d has been built\n",
+			       zone_no);
+		return STATUS_SUCCESS;
+	}
+
+	zone = &(xd_card->zone[zone_no]);
+
+	if (zone->l2p_table == NULL) {
+		zone->l2p_table = vmalloc(2000);
+		if (zone->l2p_table == NULL)
+			TRACE_GOTO(chip, Build_Fail);
+	}
+	memset((u8 *) (zone->l2p_table), 0xff, 2000);
+
+	if (zone->free_table == NULL) {
+		zone->free_table = vmalloc(XD_FREE_TABLE_CNT * 2);
+		if (zone->free_table == NULL)
+			TRACE_GOTO(chip, Build_Fail);
+	}
+	memset((u8 *) (zone->free_table), 0xff, XD_FREE_TABLE_CNT * 2);
+
+	if (zone_no == 0) {
+		if (xd_card->cis_block == 0xFFFF)
+			start = 0;
+		else
+			start = xd_card->cis_block + 1;
+		if (XD_CHK_4MB(xd_card)) {
+			end = 0x200;
+			max_logoff = 499;
+		} else {
+			end = 0x400;
+			max_logoff = 999;
+		}
+	} else {
+		start = (u32) (zone_no) << 10;
+		end = (u32) (zone_no + 1) << 10;
+		max_logoff = 999;
+	}
+
+	RTS51X_DEBUGP("start block 0x%x, end block 0x%x\n", start, end);
+
+	zone->set_index = zone->get_index = 0;
+	zone->unused_blk_cnt = 0;
+
+	for (i = start; i < end; i++) {
+		u32 page_addr = i << xd_card->block_shift;
+		u32 phy_block;
+
+		retval = xd_read_redundant(chip, page_addr, redunt, 11);
+		if (retval != STATUS_SUCCESS)
+			continue;
+
+		if (redunt[BLOCK_STATUS] != 0xFF) {
+			RTS51X_DEBUGP("bad block\n");
+			continue;
+		}
+
+		if (xd_check_data_blank(redunt)) {
+			RTS51X_DEBUGP("blank block\n");
+			xd_set_unused_block(chip, i);
+			continue;
+		}
+
+		cur_fst_page_logoff = xd_load_log_block_addr(redunt);
+		if ((cur_fst_page_logoff == 0xFFFF)
+		    || (cur_fst_page_logoff > max_logoff)) {
+			retval = xd_erase_block(chip, i);
+			if (retval == STATUS_SUCCESS)
+				xd_set_unused_block(chip, i);
+			continue;
+		}
+		if ((zone_no == 0) && (cur_fst_page_logoff == 0)
+		    && (redunt[PAGE_STATUS] != XD_GPG))
+			XD_SET_MBR_FAIL(xd_card);
+
+		if (zone->l2p_table[cur_fst_page_logoff] == 0xFFFF) {
+			zone->l2p_table[cur_fst_page_logoff] =
+			    (u16) (i & 0x3FF);
+			continue;
+		}
+
+		phy_block =
+		    zone->l2p_table[cur_fst_page_logoff] +
+		    ((u32) ((zone_no) << 10));
+
+		page_addr = ((i + 1) << xd_card->block_shift) - 1;
+
+		retval = xd_read_redundant(chip, page_addr, redunt, 11);
+		if (retval != STATUS_SUCCESS)
+			continue;
+
+		cur_lst_page_logoff = xd_load_log_block_addr(redunt);
+		if (cur_lst_page_logoff == cur_fst_page_logoff) {
+			int m;
+
+			page_addr =
+			    ((phy_block + 1) << xd_card->block_shift) - 1;
+
+			for (m = 0; m < 3; m++) {
+				retval =
+				    xd_read_redundant(chip, page_addr, redunt,
+						      11);
+				if (retval == STATUS_SUCCESS)
+					break;
+			}
+
+			if (m == 3) {
+				zone->l2p_table[cur_fst_page_logoff] =
+				    (u16) (i & 0x3FF);
+				retval = xd_erase_block(chip, phy_block);
+				if (retval == STATUS_SUCCESS)
+					xd_set_unused_block(chip, phy_block);
+				continue;
+			}
+
+			ent_lst_page_logoff = xd_load_log_block_addr(redunt);
+			if (ent_lst_page_logoff != cur_fst_page_logoff) {
+				zone->l2p_table[cur_fst_page_logoff] =
+				    (u16) (i & 0x3FF);
+				retval = xd_erase_block(chip, phy_block);
+				if (retval == STATUS_SUCCESS)
+					xd_set_unused_block(chip, phy_block);
+				continue;
+			} else {
+				retval = xd_erase_block(chip, i);
+				if (retval == STATUS_SUCCESS)
+					xd_set_unused_block(chip, i);
+			}
+		} else {
+			retval = xd_erase_block(chip, i);
+			if (retval == STATUS_SUCCESS)
+				xd_set_unused_block(chip, i);
+		}
+	}
+
+	if (XD_CHK_4MB(xd_card))
+		end = 500;
+	else
+		end = 1000;
+
+	i = 0;
+	for (start = 0; start < end; start++) {
+		if (zone->l2p_table[start] == 0xFFFF)
+			i++;
+	}
+
+	RTS51X_DEBUGP("Block count %d, invalid L2P entry %d\n", end, i);
+	RTS51X_DEBUGP("Total unused block: %d\n", zone->unused_blk_cnt);
+
+	if ((zone->unused_blk_cnt - i) < 1)
+		chip->card_wp |= XD_CARD;
+
+	zone->build_flag = 1;
+
+	return STATUS_SUCCESS;
+
+Build_Fail:
+	if (zone->l2p_table) {
+		vfree(zone->l2p_table);
+		zone->l2p_table = NULL;
+	}
+	if (zone->free_table) {
+		vfree(zone->free_table);
+		zone->free_table = NULL;
+	}
+
+	return STATUS_FAIL;
+}
+
+static int xd_send_cmd(struct rts51x_chip *chip, u8 cmd)
+{
+	int retval;
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_DAT, 0xFF, cmd);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+		       XD_TRANSFER_START | XD_SET_CMD);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER, XD_TRANSFER_END,
+		       XD_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval = rts51x_get_rsp(chip, 1, 200);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+		TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_read_multiple_pages(struct rts51x_chip *chip, u32 phy_blk,
+				  u32 log_blk, u8 start_page, u8 end_page,
+				  u8 *buf, void **ptr, unsigned int *offset)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	u32 page_addr, new_blk;
+	u16 log_off;
+	u8 reg_val, page_cnt;
+	int zone_no, retval, i;
+
+	if (start_page > end_page)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	page_cnt = end_page - start_page;
+	zone_no = (int)(log_blk / 1000);
+	log_off = (u16) (log_blk % 1000);
+
+	if ((phy_blk & 0x3FF) == 0x3FF) {
+		for (i = 0; i < 256; i++) {
+			page_addr = ((u32) i) << xd_card->block_shift;
+
+			retval = xd_read_redundant(chip, page_addr, NULL, 0);
+			if (retval == STATUS_SUCCESS)
+				break;
+
+			if (monitor_card_cd(chip, XD_CARD) == CD_NOT_EXIST) {
+				xd_set_err_code(chip, XD_NO_CARD);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+	}
+
+	page_addr = (phy_blk << xd_card->block_shift) + start_page;
+
+	rts51x_init_cmd(chip);
+
+	xd_assign_phy_addr(chip, page_addr, XD_RW_ADDR);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CFG, XD_PPB_TO_SIE,
+		       XD_PPB_TO_SIE);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       RING_BUFFER);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_CNT, 0xFF, page_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CHK_DATA_STATUS,
+		       XD_AUTO_CHK_DATA_STATUS, XD_AUTO_CHK_DATA_STATUS);
+
+	rts51x_trans_dma_enable(chip->srb->sc_data_direction, chip,
+			page_cnt * 512, DMA_512);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+		       XD_TRANSFER_START | XD_READ_PAGES);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER,
+		       XD_TRANSFER_END | XD_PPB_EMPTY,
+		       XD_TRANSFER_END | XD_PPB_EMPTY);
+
+	retval = rts51x_send_cmd(chip, MODE_CDIR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval =
+	    rts51x_transfer_data_partial(chip, RCV_BULK_PIPE(chip), (void *)buf,
+					 ptr, offset, page_cnt * 512,
+					 scsi_sg_count(chip->srb), NULL, 2000);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+
+		if (retval == STATUS_TIMEDOUT) {
+			xd_set_err_code(chip, XD_TO_ERROR);
+			TRACE_RET(chip, retval);
+		} else {
+			TRACE_GOTO(chip, Fail);
+		}
+	}
+	retval = rts51x_get_rsp(chip, 1, 200);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+
+		if (retval == STATUS_TIMEDOUT) {
+			xd_set_err_code(chip, XD_TO_ERROR);
+			TRACE_RET(chip, retval);
+		} else {
+			TRACE_GOTO(chip, Fail);
+		}
+	}
+
+	return STATUS_SUCCESS;
+
+Fail:
+	rts51x_ep0_read_register(chip, XD_PAGE_STATUS, &reg_val);
+	RTS51X_DEBUGP("XD_PAGE_STATUS: 0x%x\n", reg_val);
+
+	if (reg_val != XD_GPG)
+		xd_set_err_code(chip, XD_PRG_ERROR);
+
+	rts51x_ep0_read_register(chip, XD_CTL, &reg_val);
+	RTS51X_DEBUGP("XD_CTL: 0x%x\n", reg_val);
+
+	/* Handle uncorrectable ECC error */
+	if (((reg_val & (XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE))
+	     == (XD_ECC1_ERROR | XD_ECC1_UNCORRECTABLE))
+	    || ((reg_val & (XD_ECC2_ERROR | XD_ECC2_UNCORRECTABLE))
+		== (XD_ECC2_ERROR | XD_ECC2_UNCORRECTABLE))) {
+		wait_timeout(100);
+
+		if (monitor_card_cd(chip, XD_CARD) == CD_NOT_EXIST) {
+			xd_set_err_code(chip, XD_NO_CARD);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		xd_set_err_code(chip, XD_ECC_ERROR);
+
+		new_blk = xd_get_unused_block(chip, zone_no);
+		if (new_blk == NO_NEW_BLK) {
+			XD_CLR_BAD_OLDBLK(xd_card);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+		retval =
+		    xd_copy_page(chip, phy_blk, new_blk, 0,
+				 xd_card->page_off + 1);
+		if (retval != STATUS_SUCCESS) {
+			if (!XD_CHK_BAD_NEWBLK(xd_card)) {
+				retval = xd_erase_block(chip, new_blk);
+				if (retval == STATUS_SUCCESS)
+					xd_set_unused_block(chip, new_blk);
+			} else {
+				XD_CLR_BAD_NEWBLK(xd_card);
+			}
+			XD_CLR_BAD_OLDBLK(xd_card);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+		xd_set_l2p_tbl(chip, zone_no, log_off, (u16) (new_blk & 0x3FF));
+		xd_erase_block(chip, phy_blk);
+		xd_mark_bad_block(chip, phy_blk);
+		XD_CLR_BAD_OLDBLK(xd_card);
+	}
+
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+static int xd_finish_write(struct rts51x_chip *chip,
+			   u32 old_blk, u32 new_blk, u32 log_blk, u8 page_off)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int retval, zone_no;
+	u16 log_off;
+
+	RTS51X_DEBUGP("xd_finish_write, old_blk = 0x%x, new_blk = 0x%x,"
+				"log_blk = 0x%x\n", old_blk, new_blk, log_blk);
+
+	if (page_off > xd_card->page_off)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	zone_no = (int)(log_blk / 1000);
+	log_off = (u16) (log_blk % 1000);
+
+	if (old_blk == BLK_NOT_FOUND) {
+		retval = xd_init_page(chip, new_blk, log_off,
+				      page_off, xd_card->page_off + 1);
+		if (retval != STATUS_SUCCESS) {
+			retval = xd_erase_block(chip, new_blk);
+			if (retval == STATUS_SUCCESS)
+				xd_set_unused_block(chip, new_blk);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	} else {
+		retval = xd_copy_page(chip, old_blk, new_blk,
+				      page_off, xd_card->page_off + 1);
+		if (retval != STATUS_SUCCESS) {
+			if (!XD_CHK_BAD_NEWBLK(xd_card)) {
+				retval = xd_erase_block(chip, new_blk);
+				if (retval == STATUS_SUCCESS)
+					xd_set_unused_block(chip, new_blk);
+			}
+			XD_CLR_BAD_NEWBLK(xd_card);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		retval = xd_erase_block(chip, old_blk);
+		if (retval == STATUS_SUCCESS) {
+			if (XD_CHK_BAD_OLDBLK(xd_card)) {
+				xd_mark_bad_block(chip, old_blk);
+				XD_CLR_BAD_OLDBLK(xd_card);
+			} else {
+				/* Add source block to unused block */
+				xd_set_unused_block(chip, old_blk);
+			}
+		} else {
+			xd_set_err_code(chip, XD_NO_ERROR);
+			XD_CLR_BAD_OLDBLK(xd_card);
+		}
+	}
+
+	/* Add target block to L2P table */
+	xd_set_l2p_tbl(chip, zone_no, log_off, (u16) (new_blk & 0x3FF));
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_prepare_write(struct rts51x_chip *chip,
+			    u32 old_blk, u32 new_blk, u32 log_blk, u8 page_off)
+{
+	int retval;
+
+	RTS51X_DEBUGP("xd_prepare_write, old_blk = 0x%x, new_blk = 0x%x,"
+				"log_blk = 0x%x, page_off = %d\n",
+				old_blk, new_blk, log_blk, (int)page_off);
+
+	if (page_off) {
+		retval = xd_copy_page(chip, old_blk, new_blk, 0, page_off);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+static int xd_write_multiple_pages(struct rts51x_chip *chip, u32 old_blk,
+				   u32 new_blk, u32 log_blk, u8 start_page,
+				   u8 end_page, u8 *buf, void **ptr,
+				   unsigned int *offset)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	u32 page_addr;
+	int zone_no, retval;
+	u16 log_off;
+	u8 page_cnt, reg_val;
+
+	RTS51X_DEBUGP("xd_write_multiple_pages, old_blk = 0x%x,"
+				"new_blk = 0x%x, log_blk = 0x%x\n",
+				old_blk, new_blk, log_blk);
+
+	if (start_page > end_page)
+		TRACE_RET(chip, STATUS_FAIL);
+
+	page_cnt = end_page - start_page;
+	zone_no = (int)(log_blk / 1000);
+	log_off = (u16) (log_blk % 1000);
+
+	page_addr = (new_blk << xd_card->block_shift) + start_page;
+
+	/* Send index command */
+	retval = xd_send_cmd(chip, READ1_1);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	rts51x_init_cmd(chip);
+
+	/* Prepare redundant field */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_ADDR1_H, 0xFF,
+		       (u8) (log_off >> 8));
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_ADDR1_L, 0xFF,
+		       (u8) log_off);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_BLOCK_STATUS, 0xFF, XD_GBLK);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_STATUS, 0xFF, XD_GPG);
+
+	xd_assign_phy_addr(chip, page_addr, XD_RW_ADDR);
+
+	/* Transform the block address by hardware */
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_CFG, XD_BA_TRANSFORM,
+		       XD_BA_TRANSFORM);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_PAGE_CNT, 0xFF, page_cnt);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_DATA_SOURCE, 0x01,
+		       RING_BUFFER);
+
+	rts51x_trans_dma_enable(chip->srb->sc_data_direction, chip,
+			page_cnt * 512, DMA_512);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, XD_TRANSFER, 0xFF,
+		       XD_TRANSFER_START | XD_WRITE_PAGES);
+	rts51x_add_cmd(chip, CHECK_REG_CMD, XD_TRANSFER, XD_TRANSFER_END,
+		       XD_TRANSFER_END);
+
+	retval = rts51x_send_cmd(chip, MODE_CDOR, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	retval =
+	    rts51x_transfer_data_partial(chip, SND_BULK_PIPE(chip), (void *)buf,
+					 ptr, offset, page_cnt * 512,
+					 scsi_sg_count(chip->srb), NULL, 2000);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+
+		if (retval == STATUS_TIMEDOUT) {
+			xd_set_err_code(chip, XD_TO_ERROR);
+			TRACE_RET(chip, retval);
+		} else {
+			TRACE_GOTO(chip, Fail);
+		}
+	}
+	retval = rts51x_get_rsp(chip, 1, 200);
+	if (retval != STATUS_SUCCESS) {
+		rts51x_clear_xd_error(chip);
+
+		if (retval == STATUS_TIMEDOUT) {
+			xd_set_err_code(chip, XD_TO_ERROR);
+			TRACE_RET(chip, retval);
+		} else {
+			TRACE_GOTO(chip, Fail);
+		}
+	}
+
+	if (end_page == (xd_card->page_off + 1)) {
+		xd_card->delay_write.delay_write_flag = 0;
+
+		if (old_blk != BLK_NOT_FOUND) {
+			retval = xd_erase_block(chip, old_blk);
+			if (retval == STATUS_SUCCESS) {
+				if (XD_CHK_BAD_OLDBLK(xd_card)) {
+					xd_mark_bad_block(chip, old_blk);
+					XD_CLR_BAD_OLDBLK(xd_card);
+				} else {
+					xd_set_unused_block(chip, old_blk);
+				}
+			} else {
+				xd_set_err_code(chip, XD_NO_ERROR);
+				XD_CLR_BAD_OLDBLK(xd_card);
+			}
+		}
+		xd_set_l2p_tbl(chip, zone_no, log_off, (u16) (new_blk & 0x3FF));
+	}
+
+	return STATUS_SUCCESS;
+
+Fail:
+	rts51x_ep0_read_register(chip, XD_DAT, &reg_val);
+	RTS51X_DEBUGP("XD_DAT: 0x%x\n", reg_val);
+
+	if (reg_val & PROGRAM_ERROR) {
+		xd_set_err_code(chip, XD_PRG_ERROR);
+		xd_mark_bad_block(chip, new_blk);
+	}
+
+	TRACE_RET(chip, STATUS_FAIL);
+}
+
+static int xd_delay_write(struct rts51x_chip *chip)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	struct xd_delay_write_tag *delay_write = &(xd_card->delay_write);
+	int retval;
+
+	if (delay_write->delay_write_flag) {
+		RTS51X_DEBUGP("xd_delay_write\n");
+		retval = xd_switch_clock(chip);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+
+		delay_write->delay_write_flag = 0;
+		retval = xd_finish_write(chip,
+					 delay_write->old_phyblock,
+					 delay_write->new_phyblock,
+					 delay_write->logblock,
+					 delay_write->pageoff);
+		if (retval != STATUS_SUCCESS)
+			TRACE_RET(chip, retval);
+	}
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_xd_rw(struct scsi_cmnd *srb, struct rts51x_chip *chip,
+	u32 start_sector, u16 sector_cnt)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	unsigned int lun = SCSI_LUN(srb);
+	struct xd_delay_write_tag *delay_write = &(xd_card->delay_write);
+	int retval, zone_no;
+	u32 log_blk, old_blk = 0, new_blk = 0;
+	u16 log_off, total_sec_cnt = sector_cnt;
+	u8 start_page, end_page = 0, page_cnt;
+	u8 *buf;
+	void *ptr = NULL;
+	unsigned int offset = 0;
+
+	xd_set_err_code(chip, XD_NO_ERROR);
+
+	xd_card->counter = 0;
+
+	RTS51X_DEBUGP("rts51x_xd_rw: scsi_bufflen = %d, scsi_sg_count = %d\n",
+		       scsi_bufflen(srb), scsi_sg_count(srb));
+	RTS51X_DEBUGP("Data direction: %s\n",
+		       (srb->sc_data_direction ==
+			DMA_TO_DEVICE) ? "write" : "read");
+
+	buf = (u8 *) scsi_sglist(srb);
+
+	retval = xd_switch_clock(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	log_blk = start_sector >> xd_card->block_shift;
+	start_page = (u8) start_sector & xd_card->page_off;
+	zone_no = (int)(log_blk / 1000);
+	log_off = (u16) (log_blk % 1000);
+
+	RTS51X_DEBUGP("log_blk = 0x%x\n", log_blk);
+
+	if (xd_card->zone[zone_no].build_flag == 0) {
+		retval = xd_build_l2p_tbl(chip, zone_no);
+		if (retval != STATUS_SUCCESS) {
+			chip->card_fail |= XD_CARD;
+			rts51x_set_sense_type(chip, lun,
+				SENSE_TYPE_MEDIA_NOT_PRESENT);
+			TRACE_RET(chip, retval);
+		}
+	}
+
+	if (srb->sc_data_direction == DMA_TO_DEVICE) {
+		if (delay_write->delay_write_flag &&
+		    (delay_write->logblock == log_blk) &&
+		    (start_page > delay_write->pageoff)) {
+			delay_write->delay_write_flag = 0;
+			if (delay_write->old_phyblock != BLK_NOT_FOUND) {
+				retval = xd_copy_page(chip,
+						      delay_write->old_phyblock,
+						      delay_write->new_phyblock,
+						      delay_write->pageoff,
+						      start_page);
+				if (retval != STATUS_SUCCESS) {
+					rts51x_set_sense_type(chip, lun,
+						SENSE_TYPE_MEDIA_WRITE_ERR);
+					TRACE_RET(chip, retval);
+				}
+			}
+			old_blk = delay_write->old_phyblock;
+			new_blk = delay_write->new_phyblock;
+		} else if (delay_write->delay_write_flag &&
+			   (delay_write->logblock == log_blk) &&
+			   (start_page == delay_write->pageoff)) {
+			delay_write->delay_write_flag = 0;
+			old_blk = delay_write->old_phyblock;
+			new_blk = delay_write->new_phyblock;
+		} else {
+			retval = xd_delay_write(chip);
+			if (retval != STATUS_SUCCESS) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, retval);
+			}
+			old_blk = xd_get_l2p_tbl(chip, zone_no, log_off);
+			new_blk = xd_get_unused_block(chip, zone_no);
+			if ((old_blk == BLK_NOT_FOUND)
+			    || (new_blk == BLK_NOT_FOUND)) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, retval);
+			}
+
+			retval =
+			    xd_prepare_write(chip, old_blk, new_blk, log_blk,
+					     start_page);
+			if (retval != STATUS_SUCCESS) {
+				if (monitor_card_cd(chip, XD_CARD) ==
+				    CD_NOT_EXIST) {
+					rts51x_set_sense_type(chip, lun,
+						SENSE_TYPE_MEDIA_NOT_PRESENT);
+					TRACE_RET(chip, STATUS_FAIL);
+				}
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, retval);
+			}
+		}
+	} else {
+		retval = xd_delay_write(chip);
+		if (retval != STATUS_SUCCESS) {
+			if (monitor_card_cd(chip, XD_CARD) == CD_NOT_EXIST) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_NOT_PRESENT);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+			TRACE_RET(chip, retval);
+		}
+
+		old_blk = xd_get_l2p_tbl(chip, zone_no, log_off);
+		if (old_blk == BLK_NOT_FOUND) {
+			rts51x_set_sense_type(chip, lun,
+				       SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+	}
+
+	RTS51X_DEBUGP("old_blk = 0x%x\n", old_blk);
+	if (srb->sc_data_direction == DMA_TO_DEVICE)
+		RTS51X_DEBUGP("new_blk = 0x%x\n", new_blk);
+
+	while (total_sec_cnt) {
+		if ((start_page + total_sec_cnt) > (xd_card->page_off + 1))
+			end_page = xd_card->page_off + 1;
+		else
+			end_page = start_page + (u8) total_sec_cnt;
+		page_cnt = end_page - start_page;
+		if (srb->sc_data_direction == DMA_FROM_DEVICE) {
+			retval = xd_read_multiple_pages(chip, old_blk, log_blk,
+							start_page, end_page,
+							buf, &ptr, &offset);
+			if (retval != STATUS_SUCCESS) {
+				rts51x_set_sense_type(chip, lun,
+					SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		} else {
+			retval =
+			    xd_write_multiple_pages(chip, old_blk, new_blk,
+						    log_blk, start_page,
+						    end_page, buf, &ptr,
+						    &offset);
+			if (retval != STATUS_SUCCESS) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		total_sec_cnt -= page_cnt;
+
+		if (total_sec_cnt == 0)
+			break;
+
+		log_blk++;
+		zone_no = (int)(log_blk / 1000);
+		log_off = (u16) (log_blk % 1000);
+
+		if (xd_card->zone[zone_no].build_flag == 0) {
+			retval = xd_build_l2p_tbl(chip, zone_no);
+			if (retval != STATUS_SUCCESS) {
+				chip->card_fail |= XD_CARD;
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_NOT_PRESENT);
+				TRACE_RET(chip, retval);
+			}
+		}
+
+		old_blk = xd_get_l2p_tbl(chip, zone_no, log_off);
+		if (old_blk == BLK_NOT_FOUND) {
+			if (srb->sc_data_direction == DMA_FROM_DEVICE) {
+				rts51x_set_sense_type(chip, lun,
+					SENSE_TYPE_MEDIA_UNRECOVER_READ_ERR);
+			} else {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+			}
+			TRACE_RET(chip, STATUS_FAIL);
+		}
+
+		if (srb->sc_data_direction == DMA_TO_DEVICE) {
+			new_blk = xd_get_unused_block(chip, zone_no);
+			if (new_blk == BLK_NOT_FOUND) {
+				rts51x_set_sense_type(chip, lun,
+					       SENSE_TYPE_MEDIA_WRITE_ERR);
+				TRACE_RET(chip, STATUS_FAIL);
+			}
+		}
+
+		start_page = 0;
+	}
+
+	if ((srb->sc_data_direction == DMA_TO_DEVICE) &&
+	    (end_page != (xd_card->page_off + 1))) {
+		delay_write->delay_write_flag = 1;
+		delay_write->old_phyblock = old_blk;
+		delay_write->new_phyblock = new_blk;
+		delay_write->logblock = log_blk;
+		delay_write->pageoff = end_page;
+	}
+
+	scsi_set_resid(srb, 0);
+
+	return STATUS_SUCCESS;
+}
+
+void rts51x_xd_free_l2p_tbl(struct rts51x_chip *chip)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int i = 0;
+
+	if (xd_card->zone != NULL) {
+		for (i = 0; i < xd_card->zone_cnt; i++) {
+			if (xd_card->zone[i].l2p_table != NULL) {
+				vfree(xd_card->zone[i].l2p_table);
+				xd_card->zone[i].l2p_table = NULL;
+			}
+			if (xd_card->zone[i].free_table != NULL) {
+				vfree(xd_card->zone[i].free_table);
+				xd_card->zone[i].free_table = NULL;
+			}
+		}
+		vfree(xd_card->zone);
+		xd_card->zone = NULL;
+	}
+}
+
+void rts51x_xd_cleanup_work(struct rts51x_chip *chip)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+
+	if (xd_card->delay_write.delay_write_flag) {
+		RTS51X_DEBUGP("xD: delay write\n");
+		xd_delay_write(chip);
+		xd_card->counter = 0;
+	}
+}
+
+static int xd_power_off_card3v3(struct rts51x_chip *chip)
+{
+	int retval;
+
+	rts51x_init_cmd(chip);
+
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_CLK_EN, XD_CLK_EN, 0);
+
+	if (chip->asic_code)
+		xd_pull_ctl_disable(chip);
+	else
+		rts51x_add_cmd(chip, WRITE_REG_CMD, FPGA_PULL_CTL, 0xFF, 0xDF);
+	rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_OE, XD_OUTPUT_EN, 0);
+	if (!chip->option.FT2_fast_mode) {
+		rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL, POWER_MASK,
+			       POWER_OFF);
+		if (CHECK_PKG(chip, LQFP48)
+		    || chip->option.rts5129_D3318_off_enable)
+			rts51x_add_cmd(chip, WRITE_REG_CMD, CARD_PWR_CTL,
+				       DV3318_AUTO_PWR_OFF, 0);
+	}
+
+	retval = rts51x_send_cmd(chip, MODE_C, 100);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	return STATUS_SUCCESS;
+}
+
+int rts51x_release_xd_card(struct rts51x_chip *chip)
+{
+	struct xd_info *xd_card = &(chip->xd_card);
+	int retval;
+
+	RTS51X_DEBUGP("rts51x_release_xd_card\n");
+
+	chip->card_ready &= ~XD_CARD;
+	chip->card_fail &= ~XD_CARD;
+	chip->card_wp &= ~XD_CARD;
+
+	xd_card->delay_write.delay_write_flag = 0;
+
+	rts51x_xd_free_l2p_tbl(chip);
+
+	rts51x_write_register(chip, SFSM_ED, HW_CMD_STOP, HW_CMD_STOP);
+
+	retval = xd_power_off_card3v3(chip);
+	if (retval != STATUS_SUCCESS)
+		TRACE_RET(chip, retval);
+
+	if (chip->asic_code && CHECK_PKG(chip, QFN24))
+		wait_timeout(20);
+
+	return STATUS_SUCCESS;
+}
diff --git a/drivers/staging/rts5139/xd.h b/drivers/staging/rts5139/xd.h
new file mode 100644
index 000000000000..695a0b4d7e52
--- /dev/null
+++ b/drivers/staging/rts5139/xd.h
@@ -0,0 +1,191 @@
+/* Driver for Realtek RTS51xx USB card reader
+ * Header file
+ *
+ * Copyright(c) 2009 Realtek Semiconductor Corp. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author:
+ *   wwang (wei_wang@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ * Maintainer:
+ *   Edwin Rong (edwin_rong@realsil.com.cn)
+ *   No. 450, Shenhu Road, Suzhou Industry Park, Suzhou, China
+ */
+
+#ifndef __RTS51X_XD_H
+#define __RTS51X_XD_H
+
+/* Error Codes */
+#define	XD_NO_ERROR			0x00
+#define	XD_NO_MEMORY			0x80
+#define	XD_PRG_ERROR			0x40
+#define	XD_NO_CARD			0x20
+#define	XD_READ_FAIL			0x10
+#define	XD_ERASE_FAIL			0x08
+#define	XD_WRITE_FAIL			0x04
+#define	XD_ECC_ERROR			0x02
+#define	XD_TO_ERROR			0x01
+
+/* XD Commands */
+#define	READ1_1				0x00
+#define	READ1_2				0x01
+#define	READ2				0x50
+#define READ_ID				0x90
+#define RESET				0xff
+#define PAGE_PRG_1			0x80
+#define PAGE_PRG_2			0x10
+#define	BLK_ERASE_1			0x60
+#define	BLK_ERASE_2			0xD0
+#define READ_STS			0x70
+#define READ_xD_ID			0x9A
+#define	COPY_BACK_512			0x8A
+#define	COPY_BACK_2K			0x85
+#define	READ1_1_2			0x30
+#define	READ1_1_3			0x35
+#define	CHG_DAT_OUT_1			0x05
+#define RDM_DAT_OUT_1			0x05
+#define	CHG_DAT_OUT_2			0xE0
+#define RDM_DAT_OUT_2			0xE0
+#define	CHG_DAT_OUT_2			0xE0
+#define	CHG_DAT_IN_1			0x85
+#define	CACHE_PRG			0x15
+
+/* Redundant Area Related */
+#define XD_EXTRA_SIZE			0x10
+#define XD_2K_EXTRA_SIZE		0x40
+
+/* Define for XD Status  */
+#define	NOT_WRITE_PROTECTED		0x80
+#define	READY_STATE			0x40
+#define	PROGRAM_ERROR			0x01
+#define	PROGRAM_ERROR_N_1		0x02
+#define	INTERNAL_READY			0x20
+#define	READY_FLAG			0x5F
+
+/* Define for device code */
+#define	XD_8M_X8_512			0xE6
+#define	XD_16M_X8_512			0x73
+#define	XD_32M_X8_512			0x75
+#define	XD_64M_X8_512			0x76
+#define	XD_128M_X8_512			0x79
+#define	XD_256M_X8_512			0x71
+#define	XD_128M_X8_2048			0xF1
+#define	XD_256M_X8_2048			0xDA
+#define	XD_512M_X8			0xDC
+#define	XD_128M_X16_2048		0xC1
+#define	XD_4M_X8_512_1			0xE3
+#define	XD_4M_X8_512_2			0xE5
+#define	xD_1G_X8_512			0xD3
+#define	xD_2G_X8_512			0xD5
+
+#define	XD_ID_CODE			0xB5
+
+#define	VENDOR_BLOCK			0xEFFF
+#define	CIS_BLOCK			0xDFFF
+
+#define	BLK_NOT_FOUND			0xFFFFFFFF
+
+#define	NO_NEW_BLK			0xFFFFFFFF
+
+#define	PAGE_CORRECTABLE		0x0
+#define	PAGE_NOTCORRECTABLE		0x1
+
+#define	NO_OFFSET			0x0
+#define	WITH_OFFSET			0x1
+
+#define	Sect_Per_Page			4
+#define	XD_ADDR_MODE_2C			XD_ADDR_MODE_2A
+
+#define ZONE0_BAD_BLOCK			23
+#define NOT_ZONE0_BAD_BLOCK		24
+
+/* Assign address mode */
+#define	XD_RW_ADDR			0x01
+#define	XD_ERASE_ADDR			0x02
+
+/* Macro Definition */
+#define	XD_PAGE_512(xd_card)		\
+	do {	\
+		(xd_card)->block_shift = 5;	\
+		(xd_card)->page_off = 0x1F;	\
+	} while (0)
+
+#define	XD_SET_BAD_NEWBLK(xd_card)	((xd_card)->multi_flag |= 0x01)
+#define	XD_CLR_BAD_NEWBLK(xd_card)	((xd_card)->multi_flag &= ~0x01)
+#define	XD_CHK_BAD_NEWBLK(xd_card)	((xd_card)->multi_flag & 0x01)
+
+#define	XD_SET_BAD_OLDBLK(xd_card)	((xd_card)->multi_flag |= 0x02)
+#define	XD_CLR_BAD_OLDBLK(xd_card)	((xd_card)->multi_flag &= ~0x02)
+#define	XD_CHK_BAD_OLDBLK(xd_card)	((xd_card)->multi_flag & 0x02)
+
+#define	XD_SET_MBR_FAIL(xd_card)	((xd_card)->multi_flag |= 0x04)
+#define	XD_CLR_MBR_FAIL(xd_card)	((xd_card)->multi_flag &= ~0x04)
+#define	XD_CHK_MBR_FAIL(xd_card)	((xd_card)->multi_flag & 0x04)
+
+#define	XD_SET_ECC_FLD_ERR(xd_card)	((xd_card)->multi_flag |= 0x08)
+#define	XD_CLR_ECC_FLD_ERR(xd_card)	((xd_card)->multi_flag &= ~0x08)
+#define	XD_CHK_ECC_FLD_ERR(xd_card)	((xd_card)->multi_flag & 0x08)
+
+#define	XD_SET_4MB(xd_card)		((xd_card)->multi_flag |= 0x10)
+#define	XD_CLR_4MB(xd_card)		((xd_card)->multi_flag &= ~0x10)
+#define	XD_CHK_4MB(xd_card)		((xd_card)->multi_flag & 0x10)
+
+#define	XD_SET_ECC_ERR(xd_card)		((xd_card)->multi_flag |= 0x40)
+#define	XD_CLR_ECC_ERR(xd_card)		((xd_card)->multi_flag &= ~0x40)
+#define	XD_CHK_ECC_ERR(xd_card)		((xd_card)->multi_flag & 0x40)
+
+/* Offset in xD redundant buffer */
+#define PAGE_STATUS		0
+#define BLOCK_STATUS		1
+#define BLOCK_ADDR1_L		2
+#define BLOCK_ADDR1_H		3
+#define BLOCK_ADDR2_L		4
+#define BLOCK_ADDR2_H		5
+#define RESERVED0		6
+#define RESERVED1		7
+#define RESERVED2		8
+#define RESERVED3		9
+#define PARITY			10
+
+/* For CIS block */
+#define	CIS0_0			0
+#define	CIS0_1			1
+#define	CIS0_2			2
+#define	CIS0_3			3
+#define	CIS0_4			4
+#define	CIS0_5			5
+#define	CIS0_6			6
+#define	CIS0_7			7
+#define	CIS0_8			8
+#define	CIS0_9			9
+#define	CIS1_0			256
+#define	CIS1_1			(256 + 1)
+#define	CIS1_2			(256 + 2)
+#define	CIS1_3			(256 + 3)
+#define	CIS1_4			(256 + 4)
+#define	CIS1_5			(256 + 5)
+#define	CIS1_6			(256 + 6)
+#define	CIS1_7			(256 + 7)
+#define	CIS1_8			(256 + 8)
+#define	CIS1_9			(256 + 9)
+
+int rts51x_reset_xd_card(struct rts51x_chip *chip);
+int rts51x_xd_rw(struct scsi_cmnd *srb, struct rts51x_chip *chip, u32 start_sector,
+	  u16 sector_cnt);
+void rts51x_xd_free_l2p_tbl(struct rts51x_chip *chip);
+void rts51x_xd_cleanup_work(struct rts51x_chip *chip);
+int rts51x_release_xd_card(struct rts51x_chip *chip);
+
+#endif /* __RTS51X_XD_H */
-- 
2.43.0


