Return-Path: <stable+bounces-242670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uE6jHnc192nQdQIAu9opvQ
	(envelope-from <stable+bounces-242670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:45:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E964B5585
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 13:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7F13D3001A60
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 11:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782973128B0;
	Sun,  3 May 2026 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pBFQ+pqF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2891F3BA4
	for <stable@vger.kernel.org>; Sun,  3 May 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777808752; cv=none; b=jfsfu4LKntgwKNMmjQyxWiMmtA+u2mh/0/P5sVKack+xyc3GaYK216HHB/QYbnbPvZNYAVbxXWJepXfJ45ypMv7EiLgbBLW1KDQIPk3XyVqvZCNFPDKw00GLXjX9ibNXU52ZLQc2VeJ1JdBAlphNZ9Llgv/HWHClpsEXMVCpKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777808752; c=relaxed/simple;
	bh=pi4wRwOB+/ouSaDzeX7zM/GxGGMaFtp9o725GWdkH3E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Arhq2c6qsLPcjq3DDzwziSBsklpF6H57qtaLCho/jNZ7ps1k6ujMBEi9xKflWTIyr0bvy5myX8EMGQYG6sa9cNFc351BwmmTCe3vfcxNaMMh6489oGtVDz9a0qcddSXsKEZ2p+gP5EtpIkxGR41b7fRLpQbJqhmHei36NTrIc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pBFQ+pqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B71C2BCB4;
	Sun,  3 May 2026 11:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777808751;
	bh=pi4wRwOB+/ouSaDzeX7zM/GxGGMaFtp9o725GWdkH3E=;
	h=Subject:To:Cc:From:Date:From;
	b=pBFQ+pqFn9Lx2QL9AWwIQve5rZdTXLrWzOo3Y5olfmTKY2KlEE1LWlo9E4uo9xRQF
	 XlZS6mh+wTgc7PMigNMLRcfOT1bH4VI42pU+x8iNqVk4IALTYzHfVSUSDf43EN6oPs
	 cf68omzLBsM2hoEwDpmxpz7d4STBdCcvVDNU65Ac=
Subject: FAILED: patch "[PATCH] firmware: exynos-acpm: Drop fake 'const' on handle pointer" failed to apply to 6.18-stable tree
To: krzysztof.kozlowski@oss.qualcomm.com,krzk@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 May 2026 13:45:49 +0200
Message-ID: <2026050349-catalyst-slot-b514@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 74E964B5585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242670-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,msgid.link:url,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a2be37eedb52ea26938fa4cc9de1ff84963c57ad
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050349-catalyst-slot-b514@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a2be37eedb52ea26938fa4cc9de1ff84963c57ad Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 24 Feb 2026 11:42:04 +0100
Subject: [PATCH] firmware: exynos-acpm: Drop fake 'const' on handle pointer

All the functions operating on the 'handle' pointer are claiming it is a
pointer to const thus they should not modify the handle.  In fact that's
a false statement, because first thing these functions do is drop the
cast to const with container_of:

  struct acpm_info *acpm = handle_to_acpm_info(handle);

And with such cast the handle is easily writable with simple:

  acpm->handle.ops.pmic_ops.read_reg = NULL;

The code is not correct logically, either, because functions like
acpm_get_by_node() and acpm_handle_put() are meant to modify the handle
reference counting, thus they must modify the handle.  Modification here
happens anyway, even if the reference counting is stored in the
container which the handle is part of.

The code does not have actual visible bug, but incorrect 'const'
annotations could lead to incorrect compiler decisions.

Fixes: a88927b534ba ("firmware: add Exynos ACPM protocol driver")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260224104203.42950-2-krzysztof.kozlowski@oss.qualcomm.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

diff --git a/drivers/clk/samsung/clk-acpm.c b/drivers/clk/samsung/clk-acpm.c
index b90809ce3f88..d8944160793a 100644
--- a/drivers/clk/samsung/clk-acpm.c
+++ b/drivers/clk/samsung/clk-acpm.c
@@ -20,7 +20,7 @@ struct acpm_clk {
 	u32 id;
 	struct clk_hw hw;
 	unsigned int mbox_chan_id;
-	const struct acpm_handle *handle;
+	struct acpm_handle *handle;
 };
 
 struct acpm_clk_variant {
@@ -113,7 +113,7 @@ static int acpm_clk_register(struct device *dev, struct acpm_clk *aclk,
 
 static int acpm_clk_probe(struct platform_device *pdev)
 {
-	const struct acpm_handle *acpm_handle;
+	struct acpm_handle *acpm_handle;
 	struct clk_hw_onecell_data *clk_data;
 	struct clk_hw **hws;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.c b/drivers/firmware/samsung/exynos-acpm-dvfs.c
index 17e7be7757b3..06bdf62dea1f 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.c
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.c
@@ -43,7 +43,7 @@ static void acpm_dvfs_init_set_rate_cmd(u32 cmd[4], unsigned int clk_id,
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-int acpm_dvfs_set_rate(const struct acpm_handle *handle,
+int acpm_dvfs_set_rate(struct acpm_handle *handle,
 		       unsigned int acpm_chan_id, unsigned int clk_id,
 		       unsigned long rate)
 {
@@ -63,7 +63,7 @@ static void acpm_dvfs_init_get_rate_cmd(u32 cmd[4], unsigned int clk_id)
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-unsigned long acpm_dvfs_get_rate(const struct acpm_handle *handle,
+unsigned long acpm_dvfs_get_rate(struct acpm_handle *handle,
 				 unsigned int acpm_chan_id, unsigned int clk_id)
 {
 	struct acpm_xfer xfer;
diff --git a/drivers/firmware/samsung/exynos-acpm-dvfs.h b/drivers/firmware/samsung/exynos-acpm-dvfs.h
index 9f2778e649c9..b37b15426102 100644
--- a/drivers/firmware/samsung/exynos-acpm-dvfs.h
+++ b/drivers/firmware/samsung/exynos-acpm-dvfs.h
@@ -11,10 +11,10 @@
 
 struct acpm_handle;
 
-int acpm_dvfs_set_rate(const struct acpm_handle *handle,
+int acpm_dvfs_set_rate(struct acpm_handle *handle,
 		       unsigned int acpm_chan_id, unsigned int id,
 		       unsigned long rate);
-unsigned long acpm_dvfs_get_rate(const struct acpm_handle *handle,
+unsigned long acpm_dvfs_get_rate(struct acpm_handle *handle,
 				 unsigned int acpm_chan_id,
 				 unsigned int clk_id);
 
diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
index 26a9024d8ed8..0c50993cc9a8 100644
--- a/drivers/firmware/samsung/exynos-acpm-pmic.c
+++ b/drivers/firmware/samsung/exynos-acpm-pmic.c
@@ -77,7 +77,7 @@ static void acpm_pmic_init_read_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan)
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-int acpm_pmic_read_reg(const struct acpm_handle *handle,
+int acpm_pmic_read_reg(struct acpm_handle *handle,
 		       unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 		       u8 *buf)
 {
@@ -107,7 +107,7 @@ static void acpm_pmic_init_bulk_read_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
 		 FIELD_PREP(ACPM_PMIC_VALUE, count);
 }
 
-int acpm_pmic_bulk_read(const struct acpm_handle *handle,
+int acpm_pmic_bulk_read(struct acpm_handle *handle,
 			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			u8 count, u8 *buf)
 {
@@ -150,7 +150,7 @@ static void acpm_pmic_init_write_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-int acpm_pmic_write_reg(const struct acpm_handle *handle,
+int acpm_pmic_write_reg(struct acpm_handle *handle,
 			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			u8 value)
 {
@@ -187,7 +187,7 @@ static void acpm_pmic_init_bulk_write_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
 	}
 }
 
-int acpm_pmic_bulk_write(const struct acpm_handle *handle,
+int acpm_pmic_bulk_write(struct acpm_handle *handle,
 			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			 u8 count, const u8 *buf)
 {
@@ -220,7 +220,7 @@ static void acpm_pmic_init_update_cmd(u32 cmd[4], u8 type, u8 reg, u8 chan,
 	cmd[3] = ktime_to_ms(ktime_get());
 }
 
-int acpm_pmic_update_reg(const struct acpm_handle *handle,
+int acpm_pmic_update_reg(struct acpm_handle *handle,
 			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			 u8 value, u8 mask)
 {
diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.h b/drivers/firmware/samsung/exynos-acpm-pmic.h
index 078421888a14..88ae9aada2ae 100644
--- a/drivers/firmware/samsung/exynos-acpm-pmic.h
+++ b/drivers/firmware/samsung/exynos-acpm-pmic.h
@@ -11,19 +11,19 @@
 
 struct acpm_handle;
 
-int acpm_pmic_read_reg(const struct acpm_handle *handle,
+int acpm_pmic_read_reg(struct acpm_handle *handle,
 		       unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 		       u8 *buf);
-int acpm_pmic_bulk_read(const struct acpm_handle *handle,
+int acpm_pmic_bulk_read(struct acpm_handle *handle,
 			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			u8 count, u8 *buf);
-int acpm_pmic_write_reg(const struct acpm_handle *handle,
+int acpm_pmic_write_reg(struct acpm_handle *handle,
 			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			u8 value);
-int acpm_pmic_bulk_write(const struct acpm_handle *handle,
+int acpm_pmic_bulk_write(struct acpm_handle *handle,
 			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			 u8 count, const u8 *buf);
-int acpm_pmic_update_reg(const struct acpm_handle *handle,
+int acpm_pmic_update_reg(struct acpm_handle *handle,
 			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
 			 u8 value, u8 mask);
 #endif /* __EXYNOS_ACPM_PMIC_H__ */
diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index c616ac951a0d..16c46ed60837 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -410,7 +410,7 @@ static int acpm_wait_for_message_response(struct acpm_chan *achan,
  *
  * Return: 0 on success, -errno otherwise.
  */
-int acpm_do_xfer(const struct acpm_handle *handle, const struct acpm_xfer *xfer)
+int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 {
 	struct acpm_info *acpm = handle_to_acpm_info(handle);
 	struct exynos_mbox_msg msg;
@@ -674,7 +674,7 @@ static int acpm_probe(struct platform_device *pdev)
  * acpm_handle_put() - release the handle acquired by acpm_get_by_phandle.
  * @handle:	Handle acquired by acpm_get_by_phandle.
  */
-static void acpm_handle_put(const struct acpm_handle *handle)
+static void acpm_handle_put(struct acpm_handle *handle)
 {
 	struct acpm_info *acpm = handle_to_acpm_info(handle);
 	struct device *dev = acpm->dev;
@@ -700,9 +700,11 @@ static void devm_acpm_release(struct device *dev, void *res)
  * @np:		ACPM device tree node.
  *
  * Return: pointer to handle on success, ERR_PTR(-errno) otherwise.
+ *
+ * Note: handle CANNOT be pointer to const
  */
-static const struct acpm_handle *acpm_get_by_node(struct device *dev,
-						  struct device_node *np)
+static struct acpm_handle *acpm_get_by_node(struct device *dev,
+					    struct device_node *np)
 {
 	struct platform_device *pdev;
 	struct device_link *link;
@@ -743,10 +745,10 @@ static const struct acpm_handle *acpm_get_by_node(struct device *dev,
  *
  * Return: pointer to handle on success, ERR_PTR(-errno) otherwise.
  */
-const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
-						struct device_node *np)
+struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
+					  struct device_node *np)
 {
-	const struct acpm_handle **ptr, *handle;
+	struct acpm_handle **ptr, *handle;
 
 	ptr = devres_alloc(devm_acpm_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
diff --git a/drivers/firmware/samsung/exynos-acpm.h b/drivers/firmware/samsung/exynos-acpm.h
index 8392fcb91f45..5df8354dc96c 100644
--- a/drivers/firmware/samsung/exynos-acpm.h
+++ b/drivers/firmware/samsung/exynos-acpm.h
@@ -17,7 +17,7 @@ struct acpm_xfer {
 
 struct acpm_handle;
 
-int acpm_do_xfer(const struct acpm_handle *handle,
+int acpm_do_xfer(struct acpm_handle *handle,
 		 const struct acpm_xfer *xfer);
 
 #endif /* __EXYNOS_ACPM_H__ */
diff --git a/drivers/mfd/sec-acpm.c b/drivers/mfd/sec-acpm.c
index 537ea65685bf..0e23b9d9f7ee 100644
--- a/drivers/mfd/sec-acpm.c
+++ b/drivers/mfd/sec-acpm.c
@@ -367,7 +367,7 @@ static const struct regmap_config s2mpg11_regmap_config_meter = {
 };
 
 struct sec_pmic_acpm_shared_bus_context {
-	const struct acpm_handle *acpm;
+	struct acpm_handle *acpm;
 	unsigned int acpm_chan_id;
 	u8 speedy_channel;
 };
@@ -390,7 +390,7 @@ static int sec_pmic_acpm_bus_write(void *context, const void *data,
 				   size_t count)
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
-	const struct acpm_handle *acpm = ctx->shared->acpm;
+	struct acpm_handle *acpm = ctx->shared->acpm;
 	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
 	size_t val_count = count - BITS_TO_BYTES(ACPM_ADDR_BITS);
 	const u8 *d = data;
@@ -410,7 +410,7 @@ static int sec_pmic_acpm_bus_read(void *context, const void *reg_buf, size_t reg
 				  void *val_buf, size_t val_size)
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
-	const struct acpm_handle *acpm = ctx->shared->acpm;
+	struct acpm_handle *acpm = ctx->shared->acpm;
 	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
 	const u8 *r = reg_buf;
 	u8 reg;
@@ -429,7 +429,7 @@ static int sec_pmic_acpm_bus_reg_update_bits(void *context, unsigned int reg, un
 					     unsigned int val)
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
-	const struct acpm_handle *acpm = ctx->shared->acpm;
+	struct acpm_handle *acpm = ctx->shared->acpm;
 	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
 
 	return pmic_ops->update_reg(acpm, ctx->shared->acpm_chan_id, ctx->type, reg & 0xff,
@@ -480,7 +480,7 @@ static int sec_pmic_acpm_probe(struct platform_device *pdev)
 	struct regmap *regmap_common, *regmap_pmic, *regmap;
 	const struct sec_pmic_acpm_platform_data *pdata;
 	struct sec_pmic_acpm_shared_bus_context *shared_ctx;
-	const struct acpm_handle *acpm;
+	struct acpm_handle *acpm;
 	struct device *dev = &pdev->dev;
 	int ret, irq;
 
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index 2091da965a5a..13f17dc4443b 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -14,30 +14,24 @@ struct acpm_handle;
 struct device_node;
 
 struct acpm_dvfs_ops {
-	int (*set_rate)(const struct acpm_handle *handle,
-			unsigned int acpm_chan_id, unsigned int clk_id,
-			unsigned long rate);
-	unsigned long (*get_rate)(const struct acpm_handle *handle,
+	int (*set_rate)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			unsigned int clk_id, unsigned long rate);
+	unsigned long (*get_rate)(struct acpm_handle *handle,
 				  unsigned int acpm_chan_id,
 				  unsigned int clk_id);
 };
 
 struct acpm_pmic_ops {
-	int (*read_reg)(const struct acpm_handle *handle,
-			unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			u8 *buf);
-	int (*bulk_read)(const struct acpm_handle *handle,
-			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			 u8 count, u8 *buf);
-	int (*write_reg)(const struct acpm_handle *handle,
-			 unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			 u8 value);
-	int (*bulk_write)(const struct acpm_handle *handle,
-			  unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			  u8 count, const u8 *buf);
-	int (*update_reg)(const struct acpm_handle *handle,
-			  unsigned int acpm_chan_id, u8 type, u8 reg, u8 chan,
-			  u8 value, u8 mask);
+	int (*read_reg)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			u8 type, u8 reg, u8 chan, u8 *buf);
+	int (*bulk_read)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			 u8 type, u8 reg, u8 chan, u8 count, u8 *buf);
+	int (*write_reg)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			 u8 type, u8 reg, u8 chan, u8 value);
+	int (*bulk_write)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			  u8 type, u8 reg, u8 chan, u8 count, const u8 *buf);
+	int (*update_reg)(struct acpm_handle *handle, unsigned int acpm_chan_id,
+			  u8 type, u8 reg, u8 chan, u8 value, u8 mask);
 };
 
 struct acpm_ops {
@@ -56,12 +50,12 @@ struct acpm_handle {
 struct device;
 
 #if IS_ENABLED(CONFIG_EXYNOS_ACPM_PROTOCOL)
-const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
-						struct device_node *np);
+struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
+					  struct device_node *np);
 #else
 
-static inline const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
-							      struct device_node *np)
+static inline struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
+							struct device_node *np)
 {
 	return NULL;
 }


