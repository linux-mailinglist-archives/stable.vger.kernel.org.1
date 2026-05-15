Return-Path: <stable+bounces-247666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCmKC6IIB2qcqwIAu9opvQ
	(envelope-from <stable+bounces-247666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:50:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A05BC54EC85
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C388730DD60A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA1A47A0AE;
	Fri, 15 May 2026 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQ0Hhxct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCD477994
	for <stable@vger.kernel.org>; Fri, 15 May 2026 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778844714; cv=none; b=XjWomqq/ezmcPDRgnrC4NF+rReTGx7GGSHDpdl5H2Yv5KHrkNaIyKiH8UrKjKBQQzvb+27HPC//dh1NQYfjU3tPzYt3onaunnJuLKxWbCubFQaAOd8ZAJ7fH1R29kYKYDPCXD5R2H+0mWhU+7eHV3xmgMFgTu2k9nCcdXhoI7UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778844714; c=relaxed/simple;
	bh=OFj3Ntc+LouQINDzhFw/P7jaIGY93lrNvr8Fcbymq0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhBbLvBeSAomEP6w8PO28K54AlRRCYZJR6Da0UaPXqCcn2+2RFw9TRvX6JqOZsR+gfzceuXMjN77WVRsKW6FhNENf5IRTwxsv/B2IOCcLaU/G6+HzHcAT/3Nt12H1P3OHjiabTZdPSzhCrE3FZo3Pphrn/38MzPon/oLZumKFpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQ0Hhxct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F40DC2BCB0;
	Fri, 15 May 2026 11:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778844714;
	bh=OFj3Ntc+LouQINDzhFw/P7jaIGY93lrNvr8Fcbymq0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JQ0HhxctnefsOpdIBICwIkR/rlgf9atbtPaBHbHe3JYFdhF9AxYkGhBS5cP8LvxAs
	 IoA0zxlaFBdvEk50ZoLU2PDSQD03qZB4988SCecL7yVqy5epNsUcw2KX7zARbxn6/Z
	 zA+pEVJvir1zxdLPW6IbYe+q6kWHrRqRSLcVfXnkagT+jHpXc04R/i1k9MdOMZXkD5
	 OCUhUZP4/0dvfEE4C1FFQ0vB7Mxsb5QiiBNjw92PqEsHlFNyFvNVIjA6OyxgLeh2XU
	 ajDaWAhz9XlxGjYz4KLeIZ8cTl11DgDG3HOlbXNAtvD5jjf2Tn2DB78pWUJLHO2EkB
	 1kkcYH0uw2pUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] spi: topcliff-pch: switch to use modern name
Date: Fri, 15 May 2026 07:31:51 -0400
Message-ID: <20260515113152.2965674-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051239-idealize-clanking-104d@gregkh>
References: <2026051239-idealize-clanking-104d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A05BC54EC85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247666-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,msgid.link:url]
X-Rspamd-Action: no action

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit 40daed14705ee76b35717ffedc80a7f281023bca ]

Change legacy name master to modern name host or controller.

No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://msgid.link/r/20231128093031.3707034-18-yangyingliang@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 5d6f477d6fc0 ("spi: topcliff-pch: fix controller deregistration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 226 ++++++++++++++++-----------------
 1 file changed, 113 insertions(+), 113 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index af5846cfe5e91..271f3e7f834be 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -124,7 +124,7 @@ struct pch_spi_dma_ctrl {
  * struct pch_spi_data - Holds the SPI channel specific details
  * @io_remap_addr:		The remapped PCI base address
  * @io_base_addr:		Base address
- * @master:			Pointer to the SPI master structure
+ * @host:			Pointer to the SPI controller structure
  * @work:			Reference to work queue handler
  * @wait:			Wait queue for waking up upon receiving an
  *				interrupt.
@@ -161,7 +161,7 @@ struct pch_spi_dma_ctrl {
 struct pch_spi_data {
 	void __iomem *io_remap_addr;
 	unsigned long io_base_addr;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct work_struct work;
 	wait_queue_head_t wait;
 	u8 transfer_complete;
@@ -216,48 +216,48 @@ static const struct pci_device_id pch_spi_pcidev_id[] = {
 
 /**
  * pch_spi_writereg() - Performs  register writes
- * @master:	Pointer to struct spi_master.
+ * @host:	Pointer to struct spi_controller.
  * @idx:	Register offset.
  * @val:	Value to be written to register.
  */
-static inline void pch_spi_writereg(struct spi_master *master, int idx, u32 val)
+static inline void pch_spi_writereg(struct spi_controller *host, int idx, u32 val)
 {
-	struct pch_spi_data *data = spi_master_get_devdata(master);
+	struct pch_spi_data *data = spi_controller_get_devdata(host);
 	iowrite32(val, (data->io_remap_addr + idx));
 }
 
 /**
  * pch_spi_readreg() - Performs register reads
- * @master:	Pointer to struct spi_master.
+ * @host:	Pointer to struct spi_controller.
  * @idx:	Register offset.
  */
-static inline u32 pch_spi_readreg(struct spi_master *master, int idx)
+static inline u32 pch_spi_readreg(struct spi_controller *host, int idx)
 {
-	struct pch_spi_data *data = spi_master_get_devdata(master);
+	struct pch_spi_data *data = spi_controller_get_devdata(host);
 	return ioread32(data->io_remap_addr + idx);
 }
 
-static inline void pch_spi_setclr_reg(struct spi_master *master, int idx,
+static inline void pch_spi_setclr_reg(struct spi_controller *host, int idx,
 				      u32 set, u32 clr)
 {
-	u32 tmp = pch_spi_readreg(master, idx);
+	u32 tmp = pch_spi_readreg(host, idx);
 	tmp = (tmp & ~clr) | set;
-	pch_spi_writereg(master, idx, tmp);
+	pch_spi_writereg(host, idx, tmp);
 }
 
-static void pch_spi_set_master_mode(struct spi_master *master)
+static void pch_spi_set_host_mode(struct spi_controller *host)
 {
-	pch_spi_setclr_reg(master, PCH_SPCR, SPCR_MSTR_BIT, 0);
+	pch_spi_setclr_reg(host, PCH_SPCR, SPCR_MSTR_BIT, 0);
 }
 
 /**
  * pch_spi_clear_fifo() - Clears the Transmit and Receive FIFOs
- * @master:	Pointer to struct spi_master.
+ * @host:	Pointer to struct spi_controller.
  */
-static void pch_spi_clear_fifo(struct spi_master *master)
+static void pch_spi_clear_fifo(struct spi_controller *host)
 {
-	pch_spi_setclr_reg(master, PCH_SPCR, SPCR_FICLR_BIT, 0);
-	pch_spi_setclr_reg(master, PCH_SPCR, 0, SPCR_FICLR_BIT);
+	pch_spi_setclr_reg(host, PCH_SPCR, SPCR_FICLR_BIT, 0);
+	pch_spi_setclr_reg(host, PCH_SPCR, 0, SPCR_FICLR_BIT);
 }
 
 static void pch_spi_handler_sub(struct pch_spi_data *data, u32 reg_spsr_val,
@@ -312,7 +312,7 @@ static void pch_spi_handler_sub(struct pch_spi_data *data, u32 reg_spsr_val,
 		if (reg_spsr_val & SPSR_FI_BIT) {
 			if ((tx_index == bpw_len) && (rx_index == tx_index)) {
 				/* disable interrupts */
-				pch_spi_setclr_reg(data->master, PCH_SPCR, 0,
+				pch_spi_setclr_reg(data->host, PCH_SPCR, 0,
 						   PCH_ALL);
 
 				/* transfer is completed;
@@ -321,7 +321,7 @@ static void pch_spi_handler_sub(struct pch_spi_data *data, u32 reg_spsr_val,
 				data->transfer_active = false;
 				wake_up(&data->wait);
 			} else {
-				dev_vdbg(&data->master->dev,
+				dev_vdbg(&data->host->dev,
 					"%s : Transfer is not completed",
 					__func__);
 			}
@@ -383,10 +383,10 @@ static irqreturn_t pch_spi_handler(int irq, void *dev_id)
 
 /**
  * pch_spi_set_baud_rate() - Sets SPBR field in SPBRR
- * @master:	Pointer to struct spi_master.
+ * @host:	Pointer to struct spi_controller.
  * @speed_hz:	Baud rate.
  */
-static void pch_spi_set_baud_rate(struct spi_master *master, u32 speed_hz)
+static void pch_spi_set_baud_rate(struct spi_controller *host, u32 speed_hz)
 {
 	u32 n_spbr = PCH_CLOCK_HZ / (speed_hz * 2);
 
@@ -394,21 +394,21 @@ static void pch_spi_set_baud_rate(struct spi_master *master, u32 speed_hz)
 	if (n_spbr > PCH_MAX_SPBR)
 		n_spbr = PCH_MAX_SPBR;
 
-	pch_spi_setclr_reg(master, PCH_SPBRR, n_spbr, MASK_SPBRR_SPBR_BITS);
+	pch_spi_setclr_reg(host, PCH_SPBRR, n_spbr, MASK_SPBRR_SPBR_BITS);
 }
 
 /**
  * pch_spi_set_bits_per_word() - Sets SIZE field in SPBRR
- * @master:		Pointer to struct spi_master.
+ * @host:		Pointer to struct spi_controller.
  * @bits_per_word:	Bits per word for SPI transfer.
  */
-static void pch_spi_set_bits_per_word(struct spi_master *master,
+static void pch_spi_set_bits_per_word(struct spi_controller *host,
 				      u8 bits_per_word)
 {
 	if (bits_per_word == 8)
-		pch_spi_setclr_reg(master, PCH_SPBRR, 0, SPBRR_SIZE_BIT);
+		pch_spi_setclr_reg(host, PCH_SPBRR, 0, SPBRR_SIZE_BIT);
 	else
-		pch_spi_setclr_reg(master, PCH_SPBRR, SPBRR_SIZE_BIT, 0);
+		pch_spi_setclr_reg(host, PCH_SPBRR, SPBRR_SIZE_BIT, 0);
 }
 
 /**
@@ -420,12 +420,12 @@ static void pch_spi_setup_transfer(struct spi_device *spi)
 	u32 flags = 0;
 
 	dev_dbg(&spi->dev, "%s SPBRR content =%x setting baud rate=%d\n",
-		__func__, pch_spi_readreg(spi->master, PCH_SPBRR),
+		__func__, pch_spi_readreg(spi->controller, PCH_SPBRR),
 		spi->max_speed_hz);
-	pch_spi_set_baud_rate(spi->master, spi->max_speed_hz);
+	pch_spi_set_baud_rate(spi->controller, spi->max_speed_hz);
 
 	/* set bits per word */
-	pch_spi_set_bits_per_word(spi->master, spi->bits_per_word);
+	pch_spi_set_bits_per_word(spi->controller, spi->bits_per_word);
 
 	if (!(spi->mode & SPI_LSB_FIRST))
 		flags |= SPCR_LSBF_BIT;
@@ -433,29 +433,29 @@ static void pch_spi_setup_transfer(struct spi_device *spi)
 		flags |= SPCR_CPOL_BIT;
 	if (spi->mode & SPI_CPHA)
 		flags |= SPCR_CPHA_BIT;
-	pch_spi_setclr_reg(spi->master, PCH_SPCR, flags,
+	pch_spi_setclr_reg(spi->controller, PCH_SPCR, flags,
 			   (SPCR_LSBF_BIT | SPCR_CPOL_BIT | SPCR_CPHA_BIT));
 
 	/* Clear the FIFO by toggling  FICLR to 1 and back to 0 */
-	pch_spi_clear_fifo(spi->master);
+	pch_spi_clear_fifo(spi->controller);
 }
 
 /**
  * pch_spi_reset() - Clears SPI registers
- * @master:	Pointer to struct spi_master.
+ * @host:	Pointer to struct spi_controller.
  */
-static void pch_spi_reset(struct spi_master *master)
+static void pch_spi_reset(struct spi_controller *host)
 {
 	/* write 1 to reset SPI */
-	pch_spi_writereg(master, PCH_SRST, 0x1);
+	pch_spi_writereg(host, PCH_SRST, 0x1);
 
 	/* clear reset */
-	pch_spi_writereg(master, PCH_SRST, 0x0);
+	pch_spi_writereg(host, PCH_SRST, 0x0);
 }
 
 static int pch_spi_transfer(struct spi_device *pspi, struct spi_message *pmsg)
 {
-	struct pch_spi_data *data = spi_master_get_devdata(pspi->master);
+	struct pch_spi_data *data = spi_controller_get_devdata(pspi->controller);
 	int retval;
 	unsigned long flags;
 
@@ -524,15 +524,15 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 
 	/* set baud rate if needed */
 	if (data->cur_trans->speed_hz) {
-		dev_dbg(&data->master->dev, "%s:setting baud rate\n", __func__);
-		pch_spi_set_baud_rate(data->master, data->cur_trans->speed_hz);
+		dev_dbg(&data->host->dev, "%s:setting baud rate\n", __func__);
+		pch_spi_set_baud_rate(data->host, data->cur_trans->speed_hz);
 	}
 
 	/* set bits per word if needed */
 	if (data->cur_trans->bits_per_word &&
 	    (data->current_msg->spi->bits_per_word != data->cur_trans->bits_per_word)) {
-		dev_dbg(&data->master->dev, "%s:set bits per word\n", __func__);
-		pch_spi_set_bits_per_word(data->master,
+		dev_dbg(&data->host->dev, "%s:set bits per word\n", __func__);
+		pch_spi_set_bits_per_word(data->host,
 					  data->cur_trans->bits_per_word);
 		*bpw = data->cur_trans->bits_per_word;
 	} else {
@@ -590,13 +590,13 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 	if (n_writes > PCH_MAX_FIFO_DEPTH)
 		n_writes = PCH_MAX_FIFO_DEPTH;
 
-	dev_dbg(&data->master->dev,
+	dev_dbg(&data->host->dev,
 		"\n%s:Pulling down SSN low - writing 0x2 to SSNXCR\n",
 		__func__);
-	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_LOW);
+	pch_spi_writereg(data->host, PCH_SSNXCR, SSN_LOW);
 
 	for (j = 0; j < n_writes; j++)
-		pch_spi_writereg(data->master, PCH_SPDWR, data->pkt_tx_buff[j]);
+		pch_spi_writereg(data->host, PCH_SPDWR, data->pkt_tx_buff[j]);
 
 	/* update tx_index */
 	data->tx_index = j;
@@ -609,13 +609,13 @@ static void pch_spi_set_tx(struct pch_spi_data *data, int *bpw)
 static void pch_spi_nomore_transfer(struct pch_spi_data *data)
 {
 	struct spi_message *pmsg, *tmp;
-	dev_dbg(&data->master->dev, "%s called\n", __func__);
+	dev_dbg(&data->host->dev, "%s called\n", __func__);
 	/* Invoke complete callback
 	 * [To the spi core..indicating end of transfer] */
 	data->current_msg->status = 0;
 
 	if (data->current_msg->complete) {
-		dev_dbg(&data->master->dev,
+		dev_dbg(&data->host->dev,
 			"%s:Invoking callback of SPI core\n", __func__);
 		data->current_msg->complete(data->current_msg->context);
 	}
@@ -623,7 +623,7 @@ static void pch_spi_nomore_transfer(struct pch_spi_data *data)
 	/* update status in global variable */
 	data->bcurrent_msg_processing = false;
 
-	dev_dbg(&data->master->dev,
+	dev_dbg(&data->host->dev,
 		"%s:data->bcurrent_msg_processing = false\n", __func__);
 
 	data->current_msg = NULL;
@@ -638,11 +638,11 @@ static void pch_spi_nomore_transfer(struct pch_spi_data *data)
 		 * bpw;sfer requests in the current message or there are
 		 *more messages)
 		 */
-		dev_dbg(&data->master->dev, "%s:Invoke queue_work\n", __func__);
+		dev_dbg(&data->host->dev, "%s:Invoke queue_work\n", __func__);
 		schedule_work(&data->work);
 	} else if (data->board_dat->suspend_sts ||
 		   data->status == STATUS_EXITING) {
-		dev_dbg(&data->master->dev,
+		dev_dbg(&data->host->dev,
 			"%s suspend/remove initiated, flushing queue\n",
 			__func__);
 		list_for_each_entry_safe(pmsg, tmp, data->queue.next, queue) {
@@ -662,14 +662,14 @@ static void pch_spi_set_ir(struct pch_spi_data *data)
 	/* enable interrupts, set threshold, enable SPI */
 	if ((data->bpw_len) > PCH_MAX_FIFO_DEPTH)
 		/* set receive threshold to PCH_RX_THOLD */
-		pch_spi_setclr_reg(data->master, PCH_SPCR,
+		pch_spi_setclr_reg(data->host, PCH_SPCR,
 				   PCH_RX_THOLD << SPCR_RFIC_FIELD |
 				   SPCR_FIE_BIT | SPCR_RFIE_BIT |
 				   SPCR_ORIE_BIT | SPCR_SPE_BIT,
 				   MASK_RFIC_SPCR_BITS | PCH_ALL);
 	else
 		/* set receive threshold to maximum */
-		pch_spi_setclr_reg(data->master, PCH_SPCR,
+		pch_spi_setclr_reg(data->host, PCH_SPCR,
 				   PCH_RX_THOLD_MAX << SPCR_RFIC_FIELD |
 				   SPCR_FIE_BIT | SPCR_ORIE_BIT |
 				   SPCR_SPE_BIT,
@@ -677,18 +677,18 @@ static void pch_spi_set_ir(struct pch_spi_data *data)
 
 	/* Wait until the transfer completes; go to sleep after
 				 initiating the transfer. */
-	dev_dbg(&data->master->dev,
+	dev_dbg(&data->host->dev,
 		"%s:waiting for transfer to get over\n", __func__);
 
 	wait_event_interruptible(data->wait, data->transfer_complete);
 
 	/* clear all interrupts */
-	pch_spi_writereg(data->master, PCH_SPSR,
-			 pch_spi_readreg(data->master, PCH_SPSR));
+	pch_spi_writereg(data->host, PCH_SPSR,
+			 pch_spi_readreg(data->host, PCH_SPSR));
 	/* Disable interrupts and SPI transfer */
-	pch_spi_setclr_reg(data->master, PCH_SPCR, 0, PCH_ALL | SPCR_SPE_BIT);
+	pch_spi_setclr_reg(data->host, PCH_SPCR, 0, PCH_ALL | SPCR_SPE_BIT);
 	/* clear FIFO */
-	pch_spi_clear_fifo(data->master);
+	pch_spi_clear_fifo(data->host);
 }
 
 static void pch_spi_copy_rx_data(struct pch_spi_data *data, int bpw)
@@ -750,25 +750,25 @@ static int pch_spi_start_transfer(struct pch_spi_data *data)
 	spin_lock_irqsave(&data->lock, flags);
 
 	/* disable interrupts, SPI set enable */
-	pch_spi_setclr_reg(data->master, PCH_SPCR, SPCR_SPE_BIT, PCH_ALL);
+	pch_spi_setclr_reg(data->host, PCH_SPCR, SPCR_SPE_BIT, PCH_ALL);
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	/* Wait until the transfer completes; go to sleep after
 				 initiating the transfer. */
-	dev_dbg(&data->master->dev,
+	dev_dbg(&data->host->dev,
 		"%s:waiting for transfer to get over\n", __func__);
 	rtn = wait_event_interruptible_timeout(data->wait,
 					       data->transfer_complete,
 					       msecs_to_jiffies(2 * HZ));
 	if (!rtn)
-		dev_err(&data->master->dev,
+		dev_err(&data->host->dev,
 			"%s wait-event timeout\n", __func__);
 
-	dma_sync_sg_for_cpu(&data->master->dev, dma->sg_rx_p, dma->nent,
+	dma_sync_sg_for_cpu(&data->host->dev, dma->sg_rx_p, dma->nent,
 			    DMA_FROM_DEVICE);
 
-	dma_sync_sg_for_cpu(&data->master->dev, dma->sg_tx_p, dma->nent,
+	dma_sync_sg_for_cpu(&data->host->dev, dma->sg_tx_p, dma->nent,
 			    DMA_FROM_DEVICE);
 	memset(data->dma.tx_buf_virt, 0, PAGE_SIZE);
 
@@ -780,14 +780,14 @@ static int pch_spi_start_transfer(struct pch_spi_data *data)
 	spin_lock_irqsave(&data->lock, flags);
 
 	/* clear fifo threshold, disable interrupts, disable SPI transfer */
-	pch_spi_setclr_reg(data->master, PCH_SPCR, 0,
+	pch_spi_setclr_reg(data->host, PCH_SPCR, 0,
 			   MASK_RFIC_SPCR_BITS | MASK_TFIC_SPCR_BITS | PCH_ALL |
 			   SPCR_SPE_BIT);
 	/* clear all interrupts */
-	pch_spi_writereg(data->master, PCH_SPSR,
-			 pch_spi_readreg(data->master, PCH_SPSR));
+	pch_spi_writereg(data->host, PCH_SPSR,
+			 pch_spi_readreg(data->host, PCH_SPSR));
 	/* clear FIFO */
-	pch_spi_clear_fifo(data->master);
+	pch_spi_clear_fifo(data->host);
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
@@ -846,7 +846,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	param->width = width;
 	chan = dma_request_channel(mask, pch_spi_filter, param);
 	if (!chan) {
-		dev_err(&data->master->dev,
+		dev_err(&data->host->dev,
 			"ERROR: dma_request_channel FAILS(Tx)\n");
 		goto out;
 	}
@@ -860,7 +860,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	param->width = width;
 	chan = dma_request_channel(mask, pch_spi_filter, param);
 	if (!chan) {
-		dev_err(&data->master->dev,
+		dev_err(&data->host->dev,
 			"ERROR: dma_request_channel FAILS(Rx)\n");
 		dma_release_channel(dma->chan_tx);
 		dma->chan_tx = NULL;
@@ -913,9 +913,9 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 
 	/* set baud rate if needed */
 	if (data->cur_trans->speed_hz) {
-		dev_dbg(&data->master->dev, "%s:setting baud rate\n", __func__);
+		dev_dbg(&data->host->dev, "%s:setting baud rate\n", __func__);
 		spin_lock_irqsave(&data->lock, flags);
-		pch_spi_set_baud_rate(data->master, data->cur_trans->speed_hz);
+		pch_spi_set_baud_rate(data->host, data->cur_trans->speed_hz);
 		spin_unlock_irqrestore(&data->lock, flags);
 	}
 
@@ -923,9 +923,9 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 	if (data->cur_trans->bits_per_word &&
 	    (data->current_msg->spi->bits_per_word !=
 	     data->cur_trans->bits_per_word)) {
-		dev_dbg(&data->master->dev, "%s:set bits per word\n", __func__);
+		dev_dbg(&data->host->dev, "%s:set bits per word\n", __func__);
 		spin_lock_irqsave(&data->lock, flags);
-		pch_spi_set_bits_per_word(data->master,
+		pch_spi_set_bits_per_word(data->host,
 					  data->cur_trans->bits_per_word);
 		spin_unlock_irqrestore(&data->lock, flags);
 		*bpw = data->cur_trans->bits_per_word;
@@ -969,12 +969,12 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 		size = data->bpw_len;
 		rem = data->bpw_len;
 	}
-	dev_dbg(&data->master->dev, "%s num=%d size=%d rem=%d\n",
+	dev_dbg(&data->host->dev, "%s num=%d size=%d rem=%d\n",
 		__func__, num, size, rem);
 	spin_lock_irqsave(&data->lock, flags);
 
 	/* set receive fifo threshold and transmit fifo threshold */
-	pch_spi_setclr_reg(data->master, PCH_SPCR,
+	pch_spi_setclr_reg(data->host, PCH_SPCR,
 			   ((size - 1) << SPCR_RFIC_FIELD) |
 			   (PCH_TX_THOLD << SPCR_TFIC_FIELD),
 			   MASK_RFIC_SPCR_BITS | MASK_TFIC_SPCR_BITS);
@@ -1016,11 +1016,11 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 					num, DMA_DEV_TO_MEM,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_rx) {
-		dev_err(&data->master->dev,
+		dev_err(&data->host->dev,
 			"%s:dmaengine_prep_slave_sg Failed\n", __func__);
 		return;
 	}
-	dma_sync_sg_for_device(&data->master->dev, sg, num, DMA_FROM_DEVICE);
+	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_FROM_DEVICE);
 	desc_rx->callback = pch_dma_rx_complete;
 	desc_rx->callback_param = data;
 	dma->nent = num;
@@ -1078,20 +1078,20 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 					sg, num, DMA_MEM_TO_DEV,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc_tx) {
-		dev_err(&data->master->dev,
+		dev_err(&data->host->dev,
 			"%s:dmaengine_prep_slave_sg Failed\n", __func__);
 		return;
 	}
-	dma_sync_sg_for_device(&data->master->dev, sg, num, DMA_TO_DEVICE);
+	dma_sync_sg_for_device(&data->host->dev, sg, num, DMA_TO_DEVICE);
 	desc_tx->callback = NULL;
 	desc_tx->callback_param = data;
 	dma->nent = num;
 	dma->desc_tx = desc_tx;
 
-	dev_dbg(&data->master->dev, "%s:Pulling down SSN low - writing 0x2 to SSNXCR\n", __func__);
+	dev_dbg(&data->host->dev, "%s:Pulling down SSN low - writing 0x2 to SSNXCR\n", __func__);
 
 	spin_lock_irqsave(&data->lock, flags);
-	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_LOW);
+	pch_spi_writereg(data->host, PCH_SSNXCR, SSN_LOW);
 	desc_rx->tx_submit(desc_rx);
 	desc_tx->tx_submit(desc_tx);
 	spin_unlock_irqrestore(&data->lock, flags);
@@ -1107,12 +1107,12 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 	int bpw;
 
 	data = container_of(pwork, struct pch_spi_data, work);
-	dev_dbg(&data->master->dev, "%s data initialized\n", __func__);
+	dev_dbg(&data->host->dev, "%s data initialized\n", __func__);
 
 	spin_lock(&data->lock);
 	/* check if suspend has been initiated;if yes flush queue */
 	if (data->board_dat->suspend_sts || (data->status == STATUS_EXITING)) {
-		dev_dbg(&data->master->dev,
+		dev_dbg(&data->host->dev,
 			"%s suspend/remove initiated, flushing queue\n", __func__);
 		list_for_each_entry_safe(pmsg, tmp, data->queue.next, queue) {
 			pmsg->status = -EIO;
@@ -1132,7 +1132,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 	}
 
 	data->bcurrent_msg_processing = true;
-	dev_dbg(&data->master->dev,
+	dev_dbg(&data->host->dev,
 		"%s Set data->bcurrent_msg_processing= true\n", __func__);
 
 	/* Get the message from the queue and delete it from there. */
@@ -1150,7 +1150,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 	if (data->use_dma)
 		pch_spi_request_dma(data,
 				    data->current_msg->spi->bits_per_word);
-	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_NO_CONTROL);
+	pch_spi_writereg(data->host, PCH_SSNXCR, SSN_NO_CONTROL);
 	do {
 		int cnt;
 		/* If we are already processing a message get the next
@@ -1161,14 +1161,14 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 			data->cur_trans =
 				list_entry(data->current_msg->transfers.next,
 					   struct spi_transfer, transfer_list);
-			dev_dbg(&data->master->dev,
+			dev_dbg(&data->host->dev,
 				"%s :Getting 1st transfer message\n",
 				__func__);
 		} else {
 			data->cur_trans =
 				list_entry(data->cur_trans->transfer_list.next,
 					   struct spi_transfer, transfer_list);
-			dev_dbg(&data->master->dev,
+			dev_dbg(&data->host->dev,
 				"%s :Getting next transfer message\n",
 				__func__);
 		}
@@ -1210,7 +1210,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 		data->cur_trans->len = data->save_total_len;
 		data->current_msg->actual_length += data->cur_trans->len;
 
-		dev_dbg(&data->master->dev,
+		dev_dbg(&data->host->dev,
 			"%s:data->current_msg->actual_length=%d\n",
 			__func__, data->current_msg->actual_length);
 
@@ -1229,7 +1229,7 @@ static void pch_spi_process_messages(struct work_struct *pwork)
 	} while (data->cur_trans != NULL);
 
 out:
-	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_HIGH);
+	pch_spi_writereg(data->host, PCH_SSNXCR, SSN_HIGH);
 	if (data->use_dma)
 		pch_spi_release_dma(data);
 }
@@ -1248,7 +1248,7 @@ static int pch_spi_get_resources(struct pch_spi_board_data *board_dat,
 	dev_dbg(&board_dat->pdev->dev, "%s ENTRY\n", __func__);
 
 	/* reset PCH SPI h/w */
-	pch_spi_reset(data->master);
+	pch_spi_reset(data->host);
 	dev_dbg(&board_dat->pdev->dev,
 		"%s pch_spi_reset invoked successfully\n", __func__);
 
@@ -1297,22 +1297,22 @@ static int pch_alloc_dma_buf(struct pch_spi_board_data *board_dat,
 static int pch_spi_pd_probe(struct platform_device *plat_dev)
 {
 	int ret;
-	struct spi_master *master;
+	struct spi_controller *host;
 	struct pch_spi_board_data *board_dat = dev_get_platdata(&plat_dev->dev);
 	struct pch_spi_data *data;
 
 	dev_dbg(&plat_dev->dev, "%s:debug\n", __func__);
 
-	master = spi_alloc_master(&board_dat->pdev->dev,
+	host = spi_alloc_host(&board_dat->pdev->dev,
 				  sizeof(struct pch_spi_data));
-	if (!master) {
-		dev_err(&plat_dev->dev, "spi_alloc_master[%d] failed.\n",
+	if (!host) {
+		dev_err(&plat_dev->dev, "spi_alloc_host[%d] failed.\n",
 			plat_dev->id);
 		return -ENOMEM;
 	}
 
-	data = spi_master_get_devdata(master);
-	data->master = master;
+	data = spi_controller_get_devdata(host);
+	data->host = host;
 
 	platform_set_drvdata(plat_dev, data);
 
@@ -1330,13 +1330,13 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 	dev_dbg(&plat_dev->dev, "[ch%d] remap_addr=%p\n",
 		plat_dev->id, data->io_remap_addr);
 
-	/* initialize members of SPI master */
-	master->num_chipselect = PCH_MAX_CS;
-	master->transfer = pch_spi_transfer;
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
-	master->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
-	master->max_speed_hz = PCH_MAX_BAUDRATE;
-	master->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
+	/* initialize members of SPI host */
+	host->num_chipselect = PCH_MAX_CS;
+	host->transfer = pch_spi_transfer;
+	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+	host->bits_per_word_mask = SPI_BPW_MASK(8) | SPI_BPW_MASK(16);
+	host->max_speed_hz = PCH_MAX_BAUDRATE;
+	host->flags = SPI_CONTROLLER_MUST_RX | SPI_CONTROLLER_MUST_TX;
 
 	data->board_dat = board_dat;
 	data->plat_dev = plat_dev;
@@ -1365,25 +1365,25 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 	}
 	data->irq_reg_sts = true;
 
-	pch_spi_set_master_mode(master);
+	pch_spi_set_host_mode(host);
 
 	if (use_dma) {
 		dev_info(&plat_dev->dev, "Use DMA for data transfers\n");
 		ret = pch_alloc_dma_buf(board_dat, data);
 		if (ret)
-			goto err_spi_register_master;
+			goto err_spi_register_controller;
 	}
 
-	ret = spi_register_master(master);
+	ret = spi_register_controller(host);
 	if (ret != 0) {
 		dev_err(&plat_dev->dev,
-			"%s spi_register_master FAILED\n", __func__);
-		goto err_spi_register_master;
+			"%s spi_register_controller FAILED\n", __func__);
+		goto err_spi_register_controller;
 	}
 
 	return 0;
 
-err_spi_register_master:
+err_spi_register_controller:
 	pch_free_dma_buf(board_dat, data);
 	free_irq(board_dat->pdev->irq, data);
 err_request_irq:
@@ -1391,7 +1391,7 @@ static int pch_spi_pd_probe(struct platform_device *plat_dev)
 err_spi_get_resources:
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
 err_pci_iomap:
-	spi_master_put(master);
+	spi_controller_put(host);
 
 	return ret;
 }
@@ -1427,13 +1427,13 @@ static void pch_spi_pd_remove(struct platform_device *plat_dev)
 	/* disable interrupts & free IRQ */
 	if (data->irq_reg_sts) {
 		/* disable interrupts */
-		pch_spi_setclr_reg(data->master, PCH_SPCR, 0, PCH_ALL);
+		pch_spi_setclr_reg(data->host, PCH_SPCR, 0, PCH_ALL);
 		data->irq_reg_sts = false;
 		free_irq(board_dat->pdev->irq, data);
 	}
 
 	pci_iounmap(board_dat->pdev, data->io_remap_addr);
-	spi_unregister_master(data->master);
+	spi_unregister_controller(data->host);
 }
 #ifdef CONFIG_PM
 static int pch_spi_pd_suspend(struct platform_device *pd_dev,
@@ -1463,8 +1463,8 @@ static int pch_spi_pd_suspend(struct platform_device *pd_dev,
 	/* Free IRQ */
 	if (data->irq_reg_sts) {
 		/* disable all interrupts */
-		pch_spi_setclr_reg(data->master, PCH_SPCR, 0, PCH_ALL);
-		pch_spi_reset(data->master);
+		pch_spi_setclr_reg(data->host, PCH_SPCR, 0, PCH_ALL);
+		pch_spi_reset(data->host);
 		free_irq(board_dat->pdev->irq, data);
 
 		data->irq_reg_sts = false;
@@ -1498,8 +1498,8 @@ static int pch_spi_pd_resume(struct platform_device *pd_dev)
 		}
 
 		/* reset PCH SPI h/w */
-		pch_spi_reset(data->master);
-		pch_spi_set_master_mode(data->master);
+		pch_spi_reset(data->host);
+		pch_spi_set_host_mode(data->host);
 		data->irq_reg_sts = true;
 	}
 	return 0;
-- 
2.53.0


