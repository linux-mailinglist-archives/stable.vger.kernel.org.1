Return-Path: <stable+bounces-244780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPCCHzn5/WlilQAAu9opvQ
	(envelope-from <stable+bounces-244780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:54:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13394F8287
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C81C3074C69
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427473F54C5;
	Fri,  8 May 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGXMKWZ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6A3ED5A3
	for <stable@vger.kernel.org>; Fri,  8 May 2026 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251982; cv=none; b=t0T3T4AL5ijESPBtWUl2CBNN+Ekfm8AvfUzHruz3qVI0dGQMnTf0HP38b4YNF1SxKzFXhet2UH1Pp5WnnvlRlzh5wG9HvZqiCUB741EZNuB+wo/oVjJ+U60S1xGwUdtmtYhrRtAZMpiRR9XOT+mgmnwzUym5+LDNi6TVmctmVo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251982; c=relaxed/simple;
	bh=DbuCWpiHP3aIywP6T+eUTGtTdZq1ODthX8y0JXvl49k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Htpdlw4U/9UrZc2Ad6/UGbtASqGHampkxsE7QLYaHxA2fDwNmixQ85whSIfvPaSTuU4B9onC3U9ShYMFLHzk7J3iUTY9sNu8Cwj69LujJ8EQgZw3i9EupHdmaNBNp7J3UQRI1fLQ3jTRtj4M9kEeWs7//58M06DdR1m4LJVXIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGXMKWZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C50C2BCB0;
	Fri,  8 May 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778251981;
	bh=DbuCWpiHP3aIywP6T+eUTGtTdZq1ODthX8y0JXvl49k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGXMKWZ4foqzlb/A1NI3HIYJEGonjErlOxKQKmakttJLYlOm4mSqtSEx6WL+ITwtr
	 2UGfaLDnJBHVKYZQ/L1jr9OAAuKIO7aqr/z1YwPbVmnRxKAXm0wAndwlfP/X4HdUoP
	 UnmpwGnZ719hbk5J/bB4/Uz20B7ugh0BW68zeiiQL81iQSvTOZKdlpVij1sAwiwv2g
	 a6dN1aRIu1ZhqefGuuVCqNPwLboy1r11409TPfYbla8sBJAjpsER3WjQP95kCYUAVD
	 pvvq3sLeh8Km2gkMYZMiTrBKrMTqT6NiCeKt0G0JMZBoboCi8RolBMGRenXcYgtq22
	 feaBvQjGd418Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] firmware: exynos-acpm: Drop fake 'const' on handle pointer
Date: Fri,  8 May 2026 10:52:59 -0400
Message-ID: <20260508145259.1514616-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050349-catalyst-slot-b514@gregkh>
References: <2026050349-catalyst-slot-b514@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F13394F8287
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244780-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

[ Upstream commit a2be37eedb52ea26938fa4cc9de1ff84963c57ad ]

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
[ dropped hunks for DVFS/clk-acpm files and `acpm_dvfs_ops` struct that don't exist in 6.18 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/samsung/exynos-acpm-pmic.c   | 10 +++----
 drivers/firmware/samsung/exynos-acpm-pmic.h   | 10 +++----
 drivers/firmware/samsung/exynos-acpm.c        | 16 +++++-----
 drivers/firmware/samsung/exynos-acpm.h        |  2 +-
 drivers/mfd/sec-acpm.c                        | 10 +++----
 .../firmware/samsung/exynos-acpm-protocol.h   | 29 ++++++++-----------
 6 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm-pmic.c b/drivers/firmware/samsung/exynos-acpm-pmic.c
index 961d7599e4224..52e89d1b790f0 100644
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
index 078421888a140..88ae9aada2aea 100644
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
index 3a69fe3234c75..6572cd7be9d17 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -409,7 +409,7 @@ static int acpm_wait_for_message_response(struct acpm_chan *achan,
  *
  * Return: 0 on success, -errno otherwise.
  */
-int acpm_do_xfer(const struct acpm_handle *handle, const struct acpm_xfer *xfer)
+int acpm_do_xfer(struct acpm_handle *handle, const struct acpm_xfer *xfer)
 {
 	struct acpm_info *acpm = handle_to_acpm_info(handle);
 	struct exynos_mbox_msg msg;
@@ -649,7 +649,7 @@ static int acpm_probe(struct platform_device *pdev)
  * acpm_handle_put() - release the handle acquired by acpm_get_by_phandle.
  * @handle:	Handle acquired by acpm_get_by_phandle.
  */
-static void acpm_handle_put(const struct acpm_handle *handle)
+static void acpm_handle_put(struct acpm_handle *handle)
 {
 	struct acpm_info *acpm = handle_to_acpm_info(handle);
 	struct device *dev = acpm->dev;
@@ -675,9 +675,11 @@ static void devm_acpm_release(struct device *dev, void *res)
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
@@ -718,10 +720,10 @@ static const struct acpm_handle *acpm_get_by_node(struct device *dev,
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
index 2d14cb58f98c9..6417550f89aa9 100644
--- a/drivers/firmware/samsung/exynos-acpm.h
+++ b/drivers/firmware/samsung/exynos-acpm.h
@@ -17,7 +17,7 @@ struct acpm_xfer {
 
 struct acpm_handle;
 
-int acpm_do_xfer(const struct acpm_handle *handle,
+int acpm_do_xfer(struct acpm_handle *handle,
 		 const struct acpm_xfer *xfer);
 
 #endif /* __EXYNOS_ACPM_H__ */
diff --git a/drivers/mfd/sec-acpm.c b/drivers/mfd/sec-acpm.c
index 8b31c816d65b8..9e529536a210b 100644
--- a/drivers/mfd/sec-acpm.c
+++ b/drivers/mfd/sec-acpm.c
@@ -217,7 +217,7 @@ static const struct regmap_config s2mpg10_regmap_config_meter = {
 };
 
 struct sec_pmic_acpm_shared_bus_context {
-	const struct acpm_handle *acpm;
+	struct acpm_handle *acpm;
 	unsigned int acpm_chan_id;
 	u8 speedy_channel;
 };
@@ -240,7 +240,7 @@ static int sec_pmic_acpm_bus_write(void *context, const void *data,
 				   size_t count)
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
-	const struct acpm_handle *acpm = ctx->shared->acpm;
+	struct acpm_handle *acpm = ctx->shared->acpm;
 	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
 	size_t val_count = count - BITS_TO_BYTES(ACPM_ADDR_BITS);
 	const u8 *d = data;
@@ -260,7 +260,7 @@ static int sec_pmic_acpm_bus_read(void *context, const void *reg_buf, size_t reg
 				  void *val_buf, size_t val_size)
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
-	const struct acpm_handle *acpm = ctx->shared->acpm;
+	struct acpm_handle *acpm = ctx->shared->acpm;
 	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
 	const u8 *r = reg_buf;
 	u8 reg;
@@ -279,7 +279,7 @@ static int sec_pmic_acpm_bus_reg_update_bits(void *context, unsigned int reg, un
 					     unsigned int val)
 {
 	struct sec_pmic_acpm_bus_context *ctx = context;
-	const struct acpm_handle *acpm = ctx->shared->acpm;
+	struct acpm_handle *acpm = ctx->shared->acpm;
 	const struct acpm_pmic_ops *pmic_ops = &acpm->ops.pmic_ops;
 
 	return pmic_ops->update_reg(acpm, ctx->shared->acpm_chan_id, ctx->type, reg & 0xff,
@@ -335,7 +335,7 @@ static int sec_pmic_acpm_probe(struct platform_device *pdev)
 	struct regmap *regmap_common, *regmap_pmic, *regmap;
 	const struct sec_pmic_acpm_platform_data *pdata;
 	struct sec_pmic_acpm_shared_bus_context *shared_ctx;
-	const struct acpm_handle *acpm;
+	struct acpm_handle *acpm;
 	struct device *dev = &pdev->dev;
 	int ret, irq;
 
diff --git a/include/linux/firmware/samsung/exynos-acpm-protocol.h b/include/linux/firmware/samsung/exynos-acpm-protocol.h
index f628bf1862c25..c0d796c5a2b89 100644
--- a/include/linux/firmware/samsung/exynos-acpm-protocol.h
+++ b/include/linux/firmware/samsung/exynos-acpm-protocol.h
@@ -14,21 +14,16 @@ struct acpm_handle;
 struct device_node;
 
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
@@ -45,7 +40,7 @@ struct acpm_handle {
 
 struct device;
 
-const struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
-						struct device_node *np);
+struct acpm_handle *devm_acpm_get_by_node(struct device *dev,
+					  struct device_node *np);
 
 #endif /* __EXYNOS_ACPM_PROTOCOL_H */
-- 
2.53.0


