Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5731C73E8AA
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjFZS2S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjFZS2B (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:28:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6A10F5
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:27:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7625360F30
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD6FC433C0;
        Mon, 26 Jun 2023 18:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804041;
        bh=14PYt22mXfBsz2DM4t+yTBZLs+GenebVco4YNAARrI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPFXQinpR3Io/940cT6PW/MkEjrWwynipUPrPNP+77wkL7ygYDOuIHDOqTKyK7zaR
         ra1M7GZXD9/ITvIj+XpLWwJKf/f5/Y243mGUjEEzh4uUMa1LDXuN1QZPIF/N4AnjN3
         tIDpKANOPmOTy4EetwLpdKR/Dlk3IJHAY8EdbUoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        "Limonciello, Mario" <mario.limonciello@amd.com>
Subject: [PATCH 6.1 009/170] tpm_crb: Add support for CRB devices based on Pluton
Date:   Mon, 26 Jun 2023 20:09:38 +0200
Message-ID: <20230626180800.952276496@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

commit 4d2732882703791ea4b670df433f88fc4b40a5cb upstream.

Pluton is an integrated security processor present in some recent Ryzen
parts. If it's enabled, it presents two devices - an MSFT0101 ACPI device
that's broadly an implementation of a Command Response Buffer TPM2, and an
MSFT0200 ACPI device whose functionality I haven't examined in detail yet.
This patch only attempts to add support for the TPM device.

There's a few things that need to be handled here. The first is that the
TPM2 ACPI table uses a previously undefined start method identifier. The
table format appears to include 16 bytes of startup data, which corresponds
to one 64-bit address for a start message and one 64-bit address for a
completion response. The second is that the ACPI tables on the Thinkpad Z13
I'm testing this on don't define any memory windows in _CRS (or, more
accurately, there are two empty memory windows). This check doesn't seem
strictly necessary, so I've skipped that.

Finally, it seems like chip needs to be explicitly asked to transition into
ready status on every command. Failing to do this means that if two
commands are sent in succession without an idle/ready transition in
between, everything will appear to work fine but the response is simply the
original command. I'm working without any docs here, so I'm not sure if
this is actually the required behaviour or if I'm missing something
somewhere else, but doing this results in the chip working reliably.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_crb.c |  100 ++++++++++++++++++++++++++++++++++++++++-----
 include/acpi/actbl3.h      |    1 
 2 files changed, 91 insertions(+), 10 deletions(-)

--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -98,6 +98,8 @@ struct crb_priv {
 	u8 __iomem *rsp;
 	u32 cmd_size;
 	u32 smc_func_id;
+	u32 __iomem *pluton_start_addr;
+	u32 __iomem *pluton_reply_addr;
 };
 
 struct tpm2_crb_smc {
@@ -108,6 +110,11 @@ struct tpm2_crb_smc {
 	u32 smc_func_id;
 };
 
+struct tpm2_crb_pluton {
+	u64 start_addr;
+	u64 reply_addr;
+};
+
 static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
 				unsigned long timeout)
 {
@@ -127,6 +134,25 @@ static bool crb_wait_for_reg_32(u32 __io
 	return ((ioread32(reg) & mask) == value);
 }
 
+static int crb_try_pluton_doorbell(struct crb_priv *priv, bool wait_for_complete)
+{
+	if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
+		return 0;
+
+	if (!crb_wait_for_reg_32(priv->pluton_reply_addr, ~0, 1, TPM2_TIMEOUT_C))
+		return -ETIME;
+
+	iowrite32(1, priv->pluton_start_addr);
+	if (wait_for_complete == false)
+		return 0;
+
+	if (!crb_wait_for_reg_32(priv->pluton_start_addr,
+				 0xffffffff, 0, 200))
+		return -ETIME;
+
+	return 0;
+}
+
 /**
  * __crb_go_idle - request tpm crb device to go the idle state
  *
@@ -145,6 +171,8 @@ static bool crb_wait_for_reg_32(u32 __io
  */
 static int __crb_go_idle(struct device *dev, struct crb_priv *priv)
 {
+	int rc;
+
 	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
@@ -152,6 +180,10 @@ static int __crb_go_idle(struct device *
 
 	iowrite32(CRB_CTRL_REQ_GO_IDLE, &priv->regs_t->ctrl_req);
 
+	rc = crb_try_pluton_doorbell(priv, true);
+	if (rc)
+		return rc;
+
 	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
 				 CRB_CTRL_REQ_GO_IDLE/* mask */,
 				 0, /* value */
@@ -188,12 +220,19 @@ static int crb_go_idle(struct tpm_chip *
  */
 static int __crb_cmd_ready(struct device *dev, struct crb_priv *priv)
 {
+	int rc;
+
 	if ((priv->sm == ACPI_TPM2_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_START_METHOD) ||
 	    (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC))
 		return 0;
 
 	iowrite32(CRB_CTRL_REQ_CMD_READY, &priv->regs_t->ctrl_req);
+
+	rc = crb_try_pluton_doorbell(priv, true);
+	if (rc)
+		return rc;
+
 	if (!crb_wait_for_reg_32(&priv->regs_t->ctrl_req,
 				 CRB_CTRL_REQ_CMD_READY /* mask */,
 				 0, /* value */
@@ -371,6 +410,10 @@ static int crb_send(struct tpm_chip *chi
 		return -E2BIG;
 	}
 
+	/* Seems to be necessary for every command */
+	if (priv->sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON)
+		__crb_cmd_ready(&chip->dev, priv);
+
 	memcpy_toio(priv->cmd, buf, len);
 
 	/* Make sure that cmd is populated before issuing start. */
@@ -394,7 +437,10 @@ static int crb_send(struct tpm_chip *chi
 		rc = tpm_crb_smc_start(&chip->dev, priv->smc_func_id);
 	}
 
-	return rc;
+	if (rc)
+		return rc;
+
+	return crb_try_pluton_doorbell(priv, false);
 }
 
 static void crb_cancel(struct tpm_chip *chip)
@@ -524,15 +570,18 @@ static int crb_map_io(struct acpi_device
 		return ret;
 	acpi_dev_free_resource_list(&acpi_resource_list);
 
-	if (resource_type(iores_array) != IORESOURCE_MEM) {
-		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
-		return -EINVAL;
-	} else if (resource_type(iores_array + TPM_CRB_MAX_RESOURCES) ==
-		IORESOURCE_MEM) {
-		dev_warn(dev, "TPM2 ACPI table defines too many memory resources\n");
-		memset(iores_array + TPM_CRB_MAX_RESOURCES,
-		       0, sizeof(*iores_array));
-		iores_array[TPM_CRB_MAX_RESOURCES].flags = 0;
+	/* Pluton doesn't appear to define ACPI memory regions */
+	if (priv->sm != ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+		if (resource_type(iores_array) != IORESOURCE_MEM) {
+			dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
+			return -EINVAL;
+		} else if (resource_type(iores_array + TPM_CRB_MAX_RESOURCES) ==
+			   IORESOURCE_MEM) {
+			dev_warn(dev, "TPM2 ACPI table defines too many memory resources\n");
+			memset(iores_array + TPM_CRB_MAX_RESOURCES,
+			       0, sizeof(*iores_array));
+			iores_array[TPM_CRB_MAX_RESOURCES].flags = 0;
+		}
 	}
 
 	iores = NULL;
@@ -656,6 +705,22 @@ out_relinquish_locality:
 	return ret;
 }
 
+static int crb_map_pluton(struct device *dev, struct crb_priv *priv,
+	       struct acpi_table_tpm2 *buf, struct tpm2_crb_pluton *crb_pluton)
+{
+	priv->pluton_start_addr = crb_map_res(dev, NULL, NULL,
+					      crb_pluton->start_addr, 4);
+	if (IS_ERR(priv->pluton_start_addr))
+		return PTR_ERR(priv->pluton_start_addr);
+
+	priv->pluton_reply_addr = crb_map_res(dev, NULL, NULL,
+					      crb_pluton->reply_addr, 4);
+	if (IS_ERR(priv->pluton_reply_addr))
+		return PTR_ERR(priv->pluton_reply_addr);
+
+	return 0;
+}
+
 static int crb_acpi_add(struct acpi_device *device)
 {
 	struct acpi_table_tpm2 *buf;
@@ -663,6 +728,7 @@ static int crb_acpi_add(struct acpi_devi
 	struct tpm_chip *chip;
 	struct device *dev = &device->dev;
 	struct tpm2_crb_smc *crb_smc;
+	struct tpm2_crb_pluton *crb_pluton;
 	acpi_status status;
 	u32 sm;
 	int rc;
@@ -700,6 +766,20 @@ static int crb_acpi_add(struct acpi_devi
 		priv->smc_func_id = crb_smc->smc_func_id;
 	}
 
+	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON) {
+		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_pluton))) {
+			dev_err(dev,
+				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
+				buf->header.length,
+				ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON);
+			return -EINVAL;
+		}
+		crb_pluton = ACPI_ADD_PTR(struct tpm2_crb_pluton, buf, sizeof(*buf));
+		rc = crb_map_pluton(dev, priv, buf, crb_pluton);
+		if (rc)
+			return rc;
+	}
+
 	priv->sm = sm;
 	priv->hid = acpi_device_hid(device);
 
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -443,6 +443,7 @@ struct acpi_tpm2_phy {
 #define ACPI_TPM2_RESERVED10                        10
 #define ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC       11	/* V1.2 Rev 8 */
 #define ACPI_TPM2_RESERVED                          12
+#define ACPI_TPM2_COMMAND_BUFFER_WITH_PLUTON        13
 
 /* Optional trailer appears after any start_method subtables */
 


