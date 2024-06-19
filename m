Return-Path: <stable+bounces-54326-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6463890EDAB
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 15:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E737A1F227D1
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F42146D49;
	Wed, 19 Jun 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yuanrkty"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5E14659A;
	Wed, 19 Jun 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718803249; cv=none; b=W39Yo+WAh7xkED+w4fZJYk9A+63CpIfNRxP1BUg3mWFmz30e3A+4Y4UrA2sVvzfrtYk3uc+UWofCRJmEWXnSFkoLbtRe1U0xb4OXxf8oT0McuuwfP0jh6VHf5ogshM1A2wtK4PPvnBSiaE2DQbvPfYHBc2KF5KqR9hUVoKAlCRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718803249; c=relaxed/simple;
	bh=vuAESSiXHe5vqOcaMt2PsiUK7QvIUoduXnZXDWNAKJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kV8NrrnzcB7lySDLZUhuFpNkWAcWqziKCBjTb4iuWXkMqwBdcwz4XOCbbE6hyEatgI236mtwh9eJPm/sNJkfCa23y1JQLSUpVeqrTb+p613sGuaEj7p92HzFjDiRtf+fAjQsz3pP8afVM1XpeJkQtKyOdccp7jPqNHDRbTu2xyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yuanrkty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF48BC32786;
	Wed, 19 Jun 2024 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718803249;
	bh=vuAESSiXHe5vqOcaMt2PsiUK7QvIUoduXnZXDWNAKJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yuanrktyr36aYZRBsX84Cf/Ye5LC7GyyKizBmECAKLyMBXcgq1jl39JsJiUrzx9tb
	 IgJMgY3JKXycyx+Q4NkvPV31QVQpz1mSAEtXXiFsOJR3qruyckXD4SxG7oRxRkBYQX
	 lOBWp/wJ/qmtkMwtvvAd9LJpBNoXRyb2vhqo5h9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	stable@kernel.org
Subject: [PATCH 6.9 203/281] RAS/AMD/ATL: Use system settings for MI300 DRAM to normalized address translation
Date: Wed, 19 Jun 2024 14:56:02 +0200
Message-ID: <20240619125617.762677980@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619125609.836313103@linuxfoundation.org>
References: <20240619125609.836313103@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit ba437905b4fbf0ee1686c175069239a1cc292558 upstream.

The currently used normalized address format is not applicable to all
MI300 systems. This leads to incorrect results during address
translation.

Drop the fixed layout and construct the normalized address from system
settings.

Fixes: 87a612375307 ("RAS/AMD/ATL: Add MI300 DRAM to normalized address translation support")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20240607-mi300-dram-xl-fix-v1-2-2f11547a178c@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ras/amd/atl/internal.h |    2 
 drivers/ras/amd/atl/system.c   |    2 
 drivers/ras/amd/atl/umc.c      |  157 ++++++++++++++++++++++++++++++-----------
 3 files changed, 117 insertions(+), 44 deletions(-)

--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -224,7 +224,7 @@ int df_indirect_read_broadcast(u16 node,
 
 int get_df_system_info(void);
 int determine_node_id(struct addr_ctx *ctx, u8 socket_num, u8 die_num);
-int get_addr_hash_mi300(void);
+int get_umc_info_mi300(void);
 
 int get_address_map(struct addr_ctx *ctx);
 
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -127,7 +127,7 @@ static int df4_determine_df_rev(u32 reg)
 	if (reg == DF_FUNC0_ID_MI300) {
 		df_cfg.flags.heterogeneous = 1;
 
-		if (get_addr_hash_mi300())
+		if (get_umc_info_mi300())
 			return -EINVAL;
 	}
 
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -68,6 +68,8 @@ struct xor_bits {
 };
 
 #define NUM_BANK_BITS	4
+#define NUM_COL_BITS	5
+#define NUM_SID_BITS	2
 
 static struct {
 	/* UMC::CH::AddrHashBank */
@@ -80,7 +82,22 @@ static struct {
 	u8		bank_xor;
 } addr_hash;
 
+static struct {
+	u8 bank[NUM_BANK_BITS];
+	u8 col[NUM_COL_BITS];
+	u8 sid[NUM_SID_BITS];
+	u8 num_row_lo;
+	u8 num_row_hi;
+	u8 row_lo;
+	u8 row_hi;
+	u8 pc;
+} bit_shifts;
+
 #define MI300_UMC_CH_BASE	0x90000
+#define MI300_ADDR_CFG		(MI300_UMC_CH_BASE + 0x30)
+#define MI300_ADDR_SEL		(MI300_UMC_CH_BASE + 0x40)
+#define MI300_COL_SEL_LO	(MI300_UMC_CH_BASE + 0x50)
+#define MI300_ADDR_SEL_2	(MI300_UMC_CH_BASE + 0xA4)
 #define MI300_ADDR_HASH_BANK0	(MI300_UMC_CH_BASE + 0xC8)
 #define MI300_ADDR_HASH_PC	(MI300_UMC_CH_BASE + 0xE0)
 #define MI300_ADDR_HASH_PC2	(MI300_UMC_CH_BASE + 0xE4)
@@ -90,17 +107,42 @@ static struct {
 #define ADDR_HASH_ROW_XOR	GENMASK(31, 14)
 #define ADDR_HASH_BANK_XOR	GENMASK(5, 0)
 
+#define ADDR_CFG_NUM_ROW_LO	GENMASK(11, 8)
+#define ADDR_CFG_NUM_ROW_HI	GENMASK(15, 12)
+
+#define ADDR_SEL_BANK0		GENMASK(3, 0)
+#define ADDR_SEL_BANK1		GENMASK(7, 4)
+#define ADDR_SEL_BANK2		GENMASK(11, 8)
+#define ADDR_SEL_BANK3		GENMASK(15, 12)
+#define ADDR_SEL_BANK4		GENMASK(20, 16)
+#define ADDR_SEL_ROW_LO		GENMASK(27, 24)
+#define ADDR_SEL_ROW_HI		GENMASK(31, 28)
+
+#define COL_SEL_LO_COL0		GENMASK(3, 0)
+#define COL_SEL_LO_COL1		GENMASK(7, 4)
+#define COL_SEL_LO_COL2		GENMASK(11, 8)
+#define COL_SEL_LO_COL3		GENMASK(15, 12)
+#define COL_SEL_LO_COL4		GENMASK(19, 16)
+
+#define ADDR_SEL_2_BANK5	GENMASK(4, 0)
+#define ADDR_SEL_2_CHAN		GENMASK(15, 12)
+
 /*
  * Read UMC::CH::AddrHash{Bank,PC,PC2} registers to get XOR bits used
- * for hashing. Do this during module init, since the values will not
- * change during run time.
+ * for hashing.
+ *
+ * Also, read UMC::CH::Addr{Cfg,Sel,Sel2} and UMC::CH:ColSelLo registers to
+ * get the values needed to reconstruct the normalized address. Apply additional
+ * offsets to the raw register values, as needed.
+ *
+ * Do this during module init, since the values will not change during run time.
  *
  * These registers are instantiated for each UMC across each AMD Node.
  * However, they should be identically programmed due to the fixed hardware
  * design of MI300 systems. So read the values from Node 0 UMC 0 and keep a
  * single global structure for simplicity.
  */
-int get_addr_hash_mi300(void)
+int get_umc_info_mi300(void)
 {
 	u32 temp;
 	int ret;
@@ -130,6 +172,44 @@ int get_addr_hash_mi300(void)
 
 	addr_hash.bank_xor = FIELD_GET(ADDR_HASH_BANK_XOR, temp);
 
+	ret = amd_smn_read(0, MI300_ADDR_CFG, &temp);
+	if (ret)
+		return ret;
+
+	bit_shifts.num_row_hi = FIELD_GET(ADDR_CFG_NUM_ROW_HI, temp);
+	bit_shifts.num_row_lo = 10 + FIELD_GET(ADDR_CFG_NUM_ROW_LO, temp);
+
+	ret = amd_smn_read(0, MI300_ADDR_SEL, &temp);
+	if (ret)
+		return ret;
+
+	bit_shifts.bank[0] = 5 + FIELD_GET(ADDR_SEL_BANK0, temp);
+	bit_shifts.bank[1] = 5 + FIELD_GET(ADDR_SEL_BANK1, temp);
+	bit_shifts.bank[2] = 5 + FIELD_GET(ADDR_SEL_BANK2, temp);
+	bit_shifts.bank[3] = 5 + FIELD_GET(ADDR_SEL_BANK3, temp);
+	/* Use BankBit4 for the SID0 position. */
+	bit_shifts.sid[0]  = 5 + FIELD_GET(ADDR_SEL_BANK4, temp);
+	bit_shifts.row_lo  = 12 + FIELD_GET(ADDR_SEL_ROW_LO, temp);
+	bit_shifts.row_hi  = 24 + FIELD_GET(ADDR_SEL_ROW_HI, temp);
+
+	ret = amd_smn_read(0, MI300_COL_SEL_LO, &temp);
+	if (ret)
+		return ret;
+
+	bit_shifts.col[0] = 2 + FIELD_GET(COL_SEL_LO_COL0, temp);
+	bit_shifts.col[1] = 2 + FIELD_GET(COL_SEL_LO_COL1, temp);
+	bit_shifts.col[2] = 2 + FIELD_GET(COL_SEL_LO_COL2, temp);
+	bit_shifts.col[3] = 2 + FIELD_GET(COL_SEL_LO_COL3, temp);
+	bit_shifts.col[4] = 2 + FIELD_GET(COL_SEL_LO_COL4, temp);
+
+	ret = amd_smn_read(0, MI300_ADDR_SEL_2, &temp);
+	if (ret)
+		return ret;
+
+	/* Use BankBit5 for the SID1 position. */
+	bit_shifts.sid[1] = 5 + FIELD_GET(ADDR_SEL_2_BANK5, temp);
+	bit_shifts.pc	  = 5 + FIELD_GET(ADDR_SEL_2_CHAN, temp);
+
 	return 0;
 }
 
@@ -146,9 +226,6 @@ int get_addr_hash_mi300(void)
  * The MCA address format is as follows:
  *	MCA_ADDR[27:0] = {S[1:0], P[0], R[14:0], B[3:0], C[4:0], Z[0]}
  *
- * The normalized address format is fixed in hardware and is as follows:
- *	NA[30:0] = {S[1:0], R[13:0], C4, B[1:0], B[3:2], C[3:2], P, C[1:0], Z[4:0]}
- *
  * Additionally, the PC and Bank bits may be hashed. This must be accounted for before
  * reconstructing the normalized address.
  */
@@ -158,18 +235,10 @@ int get_addr_hash_mi300(void)
 #define MI300_UMC_MCA_PC	BIT(25)
 #define MI300_UMC_MCA_SID	GENMASK(27, 26)
 
-#define MI300_NA_COL_1_0	GENMASK(6, 5)
-#define MI300_NA_PC		BIT(7)
-#define MI300_NA_COL_3_2	GENMASK(9, 8)
-#define MI300_NA_BANK_3_2	GENMASK(11, 10)
-#define MI300_NA_BANK_1_0	GENMASK(13, 12)
-#define MI300_NA_COL_4		BIT(14)
-#define MI300_NA_ROW		GENMASK(28, 15)
-#define MI300_NA_SID		GENMASK(30, 29)
-
 static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
 {
-	u16 i, col, row, bank, pc, sid, temp;
+	u16 i, col, row, bank, pc, sid;
+	u32 temp;
 
 	col  = FIELD_GET(MI300_UMC_MCA_COL,  addr);
 	bank = FIELD_GET(MI300_UMC_MCA_BANK, addr);
@@ -199,34 +268,38 @@ static unsigned long convert_dram_to_nor
 	/* Reconstruct the normalized address starting with NA[4:0] = 0 */
 	addr  = 0;
 
-	/* NA[6:5] = Column[1:0] */
-	temp  = col & 0x3;
-	addr |= FIELD_PREP(MI300_NA_COL_1_0, temp);
-
-	/* NA[7] = PC */
-	addr |= FIELD_PREP(MI300_NA_PC, pc);
-
-	/* NA[9:8] = Column[3:2] */
-	temp  = (col >> 2) & 0x3;
-	addr |= FIELD_PREP(MI300_NA_COL_3_2, temp);
-
-	/* NA[11:10] = Bank[3:2] */
-	temp  = (bank >> 2) & 0x3;
-	addr |= FIELD_PREP(MI300_NA_BANK_3_2, temp);
-
-	/* NA[13:12] = Bank[1:0] */
-	temp  = bank & 0x3;
-	addr |= FIELD_PREP(MI300_NA_BANK_1_0, temp);
-
-	/* NA[14] = Column[4] */
-	temp  = (col >> 4) & 0x1;
-	addr |= FIELD_PREP(MI300_NA_COL_4, temp);
+	/* Column bits */
+	for (i = 0; i < NUM_COL_BITS; i++) {
+		temp  = (col >> i) & 0x1;
+		addr |= temp << bit_shifts.col[i];
+	}
 
-	/* NA[28:15] = Row[13:0] */
-	addr |= FIELD_PREP(MI300_NA_ROW, row);
+	/* Bank bits */
+	for (i = 0; i < NUM_BANK_BITS; i++) {
+		temp  = (bank >> i) & 0x1;
+		addr |= temp << bit_shifts.bank[i];
+	}
+
+	/* Row lo bits */
+	for (i = 0; i < bit_shifts.num_row_lo; i++) {
+		temp  = (row >> i) & 0x1;
+		addr |= temp << (i + bit_shifts.row_lo);
+	}
 
-	/* NA[30:29] = SID[1:0] */
-	addr |= FIELD_PREP(MI300_NA_SID, sid);
+	/* Row hi bits */
+	for (i = 0; i < bit_shifts.num_row_hi; i++) {
+		temp  = (row >> (i + bit_shifts.num_row_lo)) & 0x1;
+		addr |= temp << (i + bit_shifts.row_hi);
+	}
+
+	/* PC bit */
+	addr |= pc << bit_shifts.pc;
+
+	/* SID bits */
+	for (i = 0; i < NUM_SID_BITS; i++) {
+		temp  = (sid >> i) & 0x1;
+		addr |= temp << bit_shifts.sid[i];
+	}
 
 	pr_debug("Addr=0x%016lx", addr);
 	pr_debug("Bank=%u Row=%u Column=%u PC=%u SID=%u", bank, row, col, pc, sid);



