Return-Path: <stable+bounces-159529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB039AF791A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AF4158514A
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C7A2EF2B0;
	Thu,  3 Jul 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AnxsrEn8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E50819F43A;
	Thu,  3 Jul 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554517; cv=none; b=LtRz7BNA1ZFQseKkjiwFw9UwITG+cRJEhvheJQzZ4MoJraHs3Xu7jMUPMXf9Ugl9CvZYq8j95MbRdxkhaAYVxhCfU45bAodWIntu2vfNqCEaIVAq7Yx9bT6h3K71wBwxjl9fhLbvgZarVxfM30UIAS0T8Z+gRUulJCrHLf1qsuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554517; c=relaxed/simple;
	bh=TgiOyascnEjRYZEpFs0Bkv21n2KkZ8clkGOYX3UVwWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLK1TJWaW7Mp2dpavJ9D8D4/Vux0xP+EI75Tq/kFM6EKTA4T5cyx4AO4QUsCslIGpsTraO4FfMq4cpwTN0iaAgtSXBSRcstrPIs1201sPaDm21es5t0x979uAdXVHqQPPoVs/EN10gldNFDw/5D001RhX/m4J/zaUKjn1HVhebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AnxsrEn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B016C4CEE3;
	Thu,  3 Jul 2025 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554516;
	bh=TgiOyascnEjRYZEpFs0Bkv21n2KkZ8clkGOYX3UVwWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnxsrEn85dQWBmiU3YOHlX7Xrt5vqROpeoobl4HYGgxKSTrV9mlqFEmP9sHBHUmGK
	 F+c0FgTh9ePZkVdRdXW9RhEsfVTNi/68td+ukZ6AbZwrQRdApE4aQgmxwjYCYD7Vf0
	 GI1zj0hKKCiZtd/7E+UYHngZVoXBZms2TbUOLyOg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 212/218] spi: spi-mem: Extend spi-mem operations with a per-operation maximum frequency
Date: Thu,  3 Jul 2025 16:42:40 +0200
Message-ID: <20250703144004.692234510@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 0fefeade90e74bc8f40ab0e460f483565c492e28 ]

In the spi subsystem, the bus frequency is derived as follows:
- the controller may expose a minimum and maximum operating frequency
- the hardware description, through the spi peripheral properties,
  advise what is the maximum acceptable frequency from a device/wiring
  point of view.
Transfers must be observed at a frequency which fits both (so in
practice, the lowest maximum).

Actually, this second point mixes two information and already takes the
lowest frequency among:
- what the spi device is capable of (what is written in the component
  datasheet)
- what the wiring allows (electromagnetic sensibility, crossovers,
  terminations, antenna effect, etc).

This logic works until spi devices are no longer capable of sustaining
their highest frequency regardless of the operation. Spi memories are
typically subject to such variation. Some devices are capable of
spitting their internally stored data (essentially in read mode) at a
very fast rate, typically up to 166MHz on Winbond SPI-NAND chips, using
"fast" commands. However, some of the low-end operations, such as
regular page read-from-cache commands, are more limited and can only be
executed at 54MHz at most. This is currently a problem in the SPI-NAND
subsystem. Another situation, even if not yet supported, will be with
DTR commands, when the data is latched on both edges of the clock. The
same chips as mentioned previously are in this case limited to
80MHz. Yet another example might be continuous reads, which, under
certain circumstances, can also run at most at 104 or 120MHz.

As a matter of fact, the "one frequency per chip" policy is outdated and
more fine grain configuration is needed: we need to allow per-operation
frequency limitations. So far, all datasheets I encountered advertise a
maximum default frequency, which need to be lowered for certain specific
operations. So based on the current infrastructure, we can still expect
firmware (device trees in general) to continued advertising the same
maximum speed which is a mix between the PCB limitations and the chip
maximum capability, and expect per-operation lower frequencies when this
is relevant.

Add a `struct spi_mem_op` member to carry this information. Not
providing this field explicitly from upper layers means that there is no
further constraint and the default spi device maximum speed will be
carried instead. The SPI_MEM_OP() macro is also expanded with an
optional frequency argument, because virtually all operations can be
subject to such a limitation, and this will allow for a smooth and
discrete transition.

For controller drivers which do not implement the spi-mem interface, the
per-transfer speed is also set acordingly to a lower (than the maximum
default) speed when relevant.

Acked-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20241224-winbond-6-11-rc1-quad-support-v2-1-ad218dbc406f@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c |  2 ++
 drivers/spi/spi-mem.c       | 28 ++++++++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 12 +++++++++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4d76f9f71a0e9..075f513157603 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1214,6 +1214,8 @@ spinand_select_op_variant(struct spinand_device *spinand,
 			if (ret)
 				break;
 
+			spi_mem_adjust_op_freq(spinand->spimem, &op);
+
 			if (!spi_mem_supports_op(spinand->spimem, &op))
 				break;
 
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 17b8baf749e6a..f8b598ba962d9 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -184,6 +184,10 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 			return false;
 	}
 
+	if (op->max_freq && mem->spi->controller->min_speed_hz &&
+	    op->max_freq < mem->spi->controller->min_speed_hz)
+		return false;
+
 	return spi_mem_check_buswidth(mem, op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
@@ -361,6 +365,9 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	u8 *tmpbuf;
 	int ret;
 
+	/* Make sure the operation frequency is correct before going futher */
+	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
+
 	ret = spi_mem_check_op(op);
 	if (ret)
 		return ret;
@@ -407,6 +414,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	xfers[xferpos].tx_buf = tmpbuf;
 	xfers[xferpos].len = op->cmd.nbytes;
 	xfers[xferpos].tx_nbits = op->cmd.buswidth;
+	xfers[xferpos].speed_hz = op->max_freq;
 	spi_message_add_tail(&xfers[xferpos], &msg);
 	xferpos++;
 	totalxferlen++;
@@ -421,6 +429,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		xfers[xferpos].tx_buf = tmpbuf + 1;
 		xfers[xferpos].len = op->addr.nbytes;
 		xfers[xferpos].tx_nbits = op->addr.buswidth;
+		xfers[xferpos].speed_hz = op->max_freq;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->addr.nbytes;
@@ -432,6 +441,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		xfers[xferpos].len = op->dummy.nbytes;
 		xfers[xferpos].tx_nbits = op->dummy.buswidth;
 		xfers[xferpos].dummy_data = 1;
+		xfers[xferpos].speed_hz = op->max_freq;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->dummy.nbytes;
@@ -447,6 +457,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		}
 
 		xfers[xferpos].len = op->data.nbytes;
+		xfers[xferpos].speed_hz = op->max_freq;
 		spi_message_add_tail(&xfers[xferpos], &msg);
 		xferpos++;
 		totalxferlen += op->data.nbytes;
@@ -525,6 +536,23 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+/**
+ * spi_mem_adjust_op_freq() - Adjust the frequency of a SPI mem operation to
+ *			      match controller, PCB and chip limitations
+ * @mem: the SPI memory
+ * @op: the operation to adjust
+ *
+ * Some chips have per-op frequency limitations and must adapt the maximum
+ * speed. This function allows SPI mem drivers to set @op->max_freq to the
+ * maximum supported value.
+ */
+void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
+		op->max_freq = mem->spi->max_speed_hz;
+}
+EXPORT_SYMBOL_GPL(spi_mem_adjust_op_freq);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index f866d5c8ed32a..44b7ecee0e74c 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -68,6 +68,9 @@ enum spi_mem_data_dir {
 	SPI_MEM_DATA_OUT,
 };
 
+#define SPI_MEM_OP_MAX_FREQ(__freq)				\
+	.max_freq = __freq
+
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
@@ -95,6 +98,9 @@ enum spi_mem_data_dir {
  *		 operation does not involve transferring data
  * @data.buf.in: input buffer (must be DMA-able)
  * @data.buf.out: output buffer (must be DMA-able)
+ * @max_freq: frequency limitation wrt this operation. 0 means there is no
+ *	      specific constraint and the highest achievable frequency can be
+ *	      attempted.
  */
 struct spi_mem_op {
 	struct {
@@ -132,14 +138,17 @@ struct spi_mem_op {
 			const void *out;
 		} buf;
 	} data;
+
+	unsigned int max_freq;
 };
 
-#define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
+#define SPI_MEM_OP(__cmd, __addr, __dummy, __data, ...)		\
 	{							\
 		.cmd = __cmd,					\
 		.addr = __addr,					\
 		.dummy = __dummy,				\
 		.data = __data,					\
+		__VA_ARGS__					\
 	}
 
 /**
@@ -365,6 +374,7 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 #endif /* CONFIG_SPI_MEM */
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
+void spi_mem_adjust_op_freq(struct spi_mem *mem, struct spi_mem_op *op);
 
 bool spi_mem_supports_op(struct spi_mem *mem,
 			 const struct spi_mem_op *op);
-- 
2.39.5




