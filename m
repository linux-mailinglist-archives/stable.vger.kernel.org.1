Return-Path: <stable+bounces-227275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHjyMAnju2njpQIAu9opvQ
	(envelope-from <stable+bounces-227275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:50:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 643022CA9F7
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE1463017013
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EA9384247;
	Thu, 19 Mar 2026 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="eYqAUH0R";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="yBoYE3fM"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FA377558;
	Thu, 19 Mar 2026 11:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920641; cv=pass; b=ppU2Yf0Pba/MhX/5RKtrr3qj9nqd+hhMvD0PMk89zxw9Dd2ZTOKaowqRy3zRlUzu8lsspUrB+F4M+IILP9wVQX9LpMOxMnNCE7r8pY/Xg2LxeMzmqh+uSuPZ7uBttk5JDURP4M75tafpdVt+LvCGKvzWowhktueIrlLSEhFlrZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920641; c=relaxed/simple;
	bh=DrFeadSQtCB8jsf0NMZHI+cYLPx4MLCnfloL7Q+lW6Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CCAL1gBGE8Vj8uxKY4R+ExLdpry5TPKud3ezsx+Q9yxmvddeqcpL6R1Lv6c079BmpFHY/L7h6RAStH3pNN/UCxq2cuS3NX3KYHd2XBCdQQwWB5A3FgC44VkwUGXFj/tUGoRdkRhL/pZy+8dIgI/N6zDrp9jVQR2lhLiuYlXK/uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=eYqAUH0R; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=yBoYE3fM; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
ARC-Seal: i=1; a=rsa-sha256; t=1773920596; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kSNwXc5l1aJ7hIGQ86RtJOAoSleE49YAuYk/xKjaZJU93XToJFUnf07HTWybiBrc/W
    f7qN1ae9NKz63ka6gNBKaeyISpc8BIs5H9xDAyQK0ZpCmf1daZWZ1URbgyDl/Gt5QAvS
    jM88BQz0WhBUoI+HEJBFtJDfoCMbF9c/B8P9+gIU8QvBDnD+fILiqQb5nUKb2yaH5o/0
    ngGQhPwAfKktNw5oE3ICddOYcEWQTy0OhZcYevF5TXXv6LqU6XzbkGWH5LsswABbBQhW
    9tXxetN/U+NW/7SkFnFcm23j78KzMmH1yzUgadz1kWx0JB/nGCumF5u8gZLf+SMHn8x2
    GjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773920596;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=pfMMyLzzsMT+XemQO4FfYPLmXUpfhJiBhG+oG+yUaxI=;
    b=mD4JoZfIIygD0wHiXo31mBtYbhe58/8Dzl9QLFAYiqDfwmnkVkQvVyXIMrnzBA0sr5
    0UkHBVSlu527/QmPetRIHqvRsww2UCtcNtp3GSt6Efkjmey/akNGj2YoU13+4HbDPD3I
    k/P6yBMCcKOOOdLLfnqtTYZGbbI0kpn9d2X+fW8OqTuFxE6rtdofV5/oQe2jDaapd0Aj
    PLZFryKiA+jFxgd7DNjRVI7R6TmCUvHvjrZKTeRacnymsC7z8XbZtt/Hyi1TR3SOBpP2
    NXLwAQNrR0eEsk9GWn4Rf85wzys5nt2flYoukKOuYuPUpSIV8qmVcR9ZAWlCUCc8/6sZ
    X2rw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773920596;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=pfMMyLzzsMT+XemQO4FfYPLmXUpfhJiBhG+oG+yUaxI=;
    b=eYqAUH0RgiSj38MVJh6C6x75gubvvrkMwVQ/JHmuFEnmfhpwxfTjeTWAnXZLKFn8ws
    xeAj1zkPW91IO17UF+x7KsSwXcc6rnLx9r7l06ThDBjvryRJOtFlL3qG4e0Y5dmHBJDI
    dyVOkEO132hIzJWiIdZWcKfZOelbBP3EcD9Rh4rw9byRND7wqKVkve0LahCCOMDJelwK
    mod7nbc3Oxg0BSBrr7PrkIpvI1Dx+Sv0RuyGPl3OvpP91e2jOrg0L0yHWdAJPwVdxQoM
    YtDt85MuW4YfYpdEMFIbU+mDliNiLrQOu/EK1Be2Vp+mI3bKsCVadxCUW1GdfSuGSii6
    JFzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773920596;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=pfMMyLzzsMT+XemQO4FfYPLmXUpfhJiBhG+oG+yUaxI=;
    b=yBoYE3fMjL+W0m+2lwtbuc474hyGoUCUsJr88POeushqCj0jZRiVLsejE7OMldbdw7
    uzsYjiRPMhr05nbb4BAw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSfNuhhDSDt3O2J2YOom0XQaPis+nU/5K"
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7934522JBhGDit
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 19 Mar 2026 12:43:16 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	Bean Huo <beanhuo@micron.com>,
	"Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Michael Walle <michael@walle.cc>
Subject: [PATCH] spi: Unify error codes by replacing -ENOTSUPP with -EOPNOTSUPP
Date: Thu, 19 Mar 2026 12:43:05 +0100
Message-Id: <20260319114305.1777261-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[iokpp.de,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[iokpp.de:s=strato-dkim-0002,iokpp.de:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227275-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[beanhuo@iokpp.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[iokpp.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,ozlabs.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 643022CA9F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bean Huo <beanhuo@micron.com>

From: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>

This commit updates the SPI subsystem, particularly affecting "SPI MEM"
drivers and core parts, by replacing the -ENOTSUPP error code with
-EOPNOTSUPP.

The key motivations for this change are as follows:
1. The spi-nor driver currently uses EOPNOTSUPP, whereas calls to spi-mem
might return ENOTSUPP. This update aims to unify the error reporting
within the SPI subsystem for clarity and consistency.

2. The use of ENOTSUPP has been flagged by checkpatch as inappropriate,
mainly being reserved for NFS-related errors. To align with kernel coding
standards and recommendations, this change is being made.

3. By using EOPNOTSUPP, we provide more specific context to the error,
indicating that a particular operation is not supported. This helps
differentiate from the more generic ENOTSUPP error, allowing drivers to
better handle and respond to different error scenarios.

Risks and Considerations:
While this change is primarily intended as a code cleanup and error code
unification, there is a minor risk of breaking user-space applications
that rely on specific return codes for unsupported operations. However,
this risk is considered low, as such use-cases are unlikely to be common
or critical. Nevertheless, developers and users should be aware of this
change, especially if they have scripts or tools that specifically handle
SPI error codes.

This commit does not introduce any functional changes to the SPI subsystem
or the affected drivers.

Signed-off-by: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20231129064311.272422-1-acelan.kao@canonical.com
Fixes: 90c517f435a9 ("mtd: spi-nor: micron-st: Skip FSR reading if SPI controller does not support it")
Cc: stable@vger.kernel.org # v5.18+
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Greg,

Please consider this upstream commit for stable backport.

This commit was merged as a cleanup but it fixes a real regression for
users of Micron SPI-NOR flash attached to SPI controllers that return
-ENOTSUPP (524) instead of -EOPNOTSUPP (95) for unsupported operations.

The regression was introduced by commit 90c517f435a9 ("mtd: spi-nor:
micron-st: Skip FSR reading if SPI controller does not support it"), which
added FSR read fallback logic in micron_st_nor_ready() but only checked
for -EOPNOTSUPP. When a controller returns -ENOTSUPP for the same
condition, the fallback is never triggered and the error propagates,
causing all subsequent erase/program operations on the flash to fail.

A targeted fix was proposed on the MTD mailing list but the maintainers
recommended backporting this commit to stable instead:

  https://patchwork.ozlabs.org/project/linux-mtd/patch/20260318131857.2685004-1-beanhuo@iokpp.de/

The Fixes tag and Cc: stable have been added to facilitate backport to
all stable trees carrying 90c517f435a9 (v5.18+).

 drivers/mtd/nand/spi/core.c | 2 +-
 drivers/mtd/spi-nor/core.c  | 2 +-
 drivers/spi/atmel-quadspi.c | 2 +-
 drivers/spi/spi-ath79.c     | 2 +-
 drivers/spi/spi-bcm-qspi.c  | 2 +-
 drivers/spi/spi-mem.c       | 6 +++---
 drivers/spi/spi-npcm-fiu.c  | 2 +-
 drivers/spi/spi-ti-qspi.c   | 4 ++--
 drivers/spi/spi-wpcm-fiu.c  | 2 +-
 include/linux/spi/spi-mem.h | 2 ++
 10 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 849ccfedbc72..e0b6715e5dfe 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -974,7 +974,7 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
 		spinand->manufacturer = manufacturer;
 		return 0;
 	}
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int spinand_id_detect(struct spinand_device *spinand)
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1c443fe568cf..87cb2047df80 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3146,7 +3146,7 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 	int ret;
 
 	ret = params->set_4byte_addr_mode(nor, enable);
-	if (ret && ret != -ENOTSUPP)
+	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
 	if (enable) {
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 3d1252566134..370c4d1572ed 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -272,7 +272,7 @@ static int atmel_qspi_find_mode(const struct spi_mem_op *op)
 		if (atmel_qspi_is_compatible(op, &atmel_qspi_modes[i]))
 			return i;
 
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static bool atmel_qspi_supports_op(struct spi_mem *mem,
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index c9f1d1e1dcf7..b7ada981464a 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -146,7 +146,7 @@ static int ath79_exec_mem_op(struct spi_mem *mem,
 	/* Only use for fast-read op. */
 	if (op->cmd.opcode != 0x0b || op->data.dir != SPI_MEM_DATA_IN ||
 	    op->addr.nbytes != 3 || op->dummy.nbytes != 1)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* disable GPIO mode */
 	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index ef08fcac2f6d..d96222e6d7d2 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1199,7 +1199,7 @@ static int bcm_qspi_exec_mem_op(struct spi_mem *mem,
 
 	if (!op->data.nbytes || !op->addr.nbytes || op->addr.nbytes > 4 ||
 	    op->data.dir != SPI_MEM_DATA_IN)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	buf = op->data.buf.in;
 	addr = op->addr.val;
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index edd7430d4c05..2dc8ceb85374 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -323,7 +323,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return ret;
 
 	if (!spi_mem_internal_supports_op(mem, op))
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (ctlr->mem_ops && ctlr->mem_ops->exec_op && !spi_get_csgpiod(mem->spi, 0)) {
 		ret = spi_mem_access_start(mem);
@@ -339,7 +339,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP)
+		if (!ret || ret != -ENOTSUPP || ret != -EOPNOTSUPP)
 			return ret;
 	}
 
@@ -559,7 +559,7 @@ spi_mem_dirmap_create(struct spi_mem *mem,
 	if (ret) {
 		desc->nodirmap = true;
 		if (!spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
-			ret = -ENOTSUPP;
+			ret = -EOPNOTSUPP;
 		else
 			ret = 0;
 	}
diff --git a/drivers/spi/spi-npcm-fiu.c b/drivers/spi/spi-npcm-fiu.c
index 03db9f016a11..f3bb8bbc192f 100644
--- a/drivers/spi/spi-npcm-fiu.c
+++ b/drivers/spi/spi-npcm-fiu.c
@@ -556,7 +556,7 @@ static int npcm_fiu_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		op->data.nbytes);
 
 	if (fiu->spix_mode || op->addr.nbytes > 4)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	if (fiu->clkrate != chip->clkrate) {
 		ret = clk_set_rate(fiu->clk, chip->clkrate);
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index fdc092a05284..a6a89c59c418 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -613,12 +613,12 @@ static int ti_qspi_exec_mem_op(struct spi_mem *mem,
 	/* Only optimize read path. */
 	if (!op->data.nbytes || op->data.dir != SPI_MEM_DATA_IN ||
 	    !op->addr.nbytes || op->addr.nbytes > 4)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	/* Address exceeds MMIO window size, fall back to regular mode. */
 	from = op->addr.val;
 	if (from + op->data.nbytes > qspi->mmap_size)
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 
 	mutex_lock(&qspi->list_lock);
 
diff --git a/drivers/spi/spi-wpcm-fiu.c b/drivers/spi/spi-wpcm-fiu.c
index 852ffe013d32..d76f7b5a9b97 100644
--- a/drivers/spi/spi-wpcm-fiu.c
+++ b/drivers/spi/spi-wpcm-fiu.c
@@ -361,7 +361,7 @@ static int wpcm_fiu_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	wpcm_fiu_stall_host(fiu, false);
 
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 static int wpcm_fiu_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 6b0a7dc48a4b..f866d5c8ed32 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -233,6 +233,8 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ *           not all driver provides supports_op(), so it can return -EOPNOTSUPP
+ *           if the op is not supported by the driver/controller
  * @get_name: get a custom name for the SPI mem device from the controller.
  *	      This might be needed if the controller driver has been ported
  *	      to use the SPI mem layer and a custom name is used to keep
-- 
2.34.1


