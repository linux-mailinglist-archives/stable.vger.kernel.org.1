Return-Path: <stable+bounces-51878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8D0907209
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65AF21C23D25
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB001428FC;
	Thu, 13 Jun 2024 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaWtlqaP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D1681ABE;
	Thu, 13 Jun 2024 12:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282581; cv=none; b=EEhfNFxFO0Ka5/937Rme9/SFeWWvw0ypyywZTiNVksw2XET7opyAb5/5fYw8UWEa/KJT4+h99Q8VoLOZ2zTORQ1oCWiAS1f5Dj0WrgBtcBGs2sE5VlNocKEIX1xcW8qw4f3MujcyNPMSPZoP+pex2/IVvPkOLLMOp1zkPcWetVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282581; c=relaxed/simple;
	bh=gOO/pFfZT3mYnNh00yn47j84xsT7hH/t/KYguQmjO30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZnh9At5cTt+T04rJH1SMSEKh7faacngzwsCBUbfvmLagoGNTutWA+3dM0o+jjwvzWJ0ZTJOoum2OUg7tOBB07hX2D7xBI7LtsTUoYE8mxsbMyTzywnu5rutVBCu8+a7iR7jR23vjx5Zd0h8glBT6P3l6uSTmt3dQHcovTwVHU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaWtlqaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921CDC2BBFC;
	Thu, 13 Jun 2024 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282581;
	bh=gOO/pFfZT3mYnNh00yn47j84xsT7hH/t/KYguQmjO30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PaWtlqaPicZhPsgJGuP1eKKeJmM0PuyQNkhC2YNclUlNSGqFGk75ufpLyaMDhUPHV
	 ooOOK/ALtYnXSUMGLz25DUOon/PH+lorvBwrshVNv8NHDL5t8YkQ+fSEPGER9RMfLw
	 DTEcfTY/KDoyx2ksOBmZxFV09c4sPrAyDm9NeYtw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 326/402] net: ena: Add capabilities field with support for ENI stats capability
Date: Thu, 13 Jun 2024 13:34:43 +0200
Message-ID: <20240613113314.855182180@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit a2d5d6a70fa5211e071747876fa6a7621c7257fd ]

This bitmask field indicates what capabilities are supported by the
device.

The capabilities field differs from the 'supported_features' field which
indicates what sub-commands for the set/get feature commands are
supported. The sub-commands are specified in the 'feature_id' field of
the 'ena_admin_set_feat_cmd' struct in the following way:

        struct ena_admin_set_feat_cmd cmd;

        cmd.aq_common_descriptor.opcode = ENA_ADMIN_SET_FEATURE;
        cmd.feat_common.feature_

The 'capabilities' field, on the other hand, specifies different
capabilities of the device. For example, whether the device supports
querying of ENI stats.

Also add an enumerator which contains all the capabilities. The
first added capability macro is for ENI stats feature.

Capabilities are queried along with the other device attributes (in
ena_com_get_dev_attr_feat()) during device initialization and are stored
in the ena_com_dev struct. They can be later queried using the
ena_com_get_cap() helper function.

Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2dc8b1e7177d ("net: ena: Fix redundant device NUMA node override")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_admin_defs.h | 10 +++++++++-
 drivers/net/ethernet/amazon/ena/ena_com.c        |  8 ++++++++
 drivers/net/ethernet/amazon/ena/ena_com.h        | 13 +++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index f5ec35fa4c631..466ad9470d1f4 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -48,6 +48,11 @@ enum ena_admin_aq_feature_id {
 	ENA_ADMIN_FEATURES_OPCODE_NUM               = 32,
 };
 
+/* device capabilities */
+enum ena_admin_aq_caps_id {
+	ENA_ADMIN_ENI_STATS                         = 0,
+};
+
 enum ena_admin_placement_policy_type {
 	/* descriptors and headers are in host memory */
 	ENA_ADMIN_PLACEMENT_POLICY_HOST             = 1,
@@ -455,7 +460,10 @@ struct ena_admin_device_attr_feature_desc {
 	 */
 	u32 supported_features;
 
-	u32 reserved3;
+	/* bitmap of ena_admin_aq_caps_id, which represents device
+	 * capabilities.
+	 */
+	u32 capabilities;
 
 	/* Indicates how many bits are used physical address access. */
 	u32 phys_addr_width;
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index e37c82eb62326..4db689372980e 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -1974,6 +1974,7 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 	       sizeof(get_resp.u.dev_attr));
 
 	ena_dev->supported_features = get_resp.u.dev_attr.supported_features;
+	ena_dev->capabilities = get_resp.u.dev_attr.capabilities;
 
 	if (ena_dev->supported_features & BIT(ENA_ADMIN_MAX_QUEUES_EXT)) {
 		rc = ena_com_get_feature(ena_dev, &get_resp,
@@ -2226,6 +2227,13 @@ int ena_com_get_eni_stats(struct ena_com_dev *ena_dev,
 	struct ena_com_stats_ctx ctx;
 	int ret;
 
+	if (!ena_com_get_cap(ena_dev, ENA_ADMIN_ENI_STATS)) {
+		netdev_err(ena_dev->net_device,
+			   "Capability %d isn't supported\n",
+			   ENA_ADMIN_ENI_STATS);
+		return -EOPNOTSUPP;
+	}
+
 	memset(&ctx, 0x0, sizeof(ctx));
 	ret = ena_get_dev_stats(ena_dev, &ctx, ENA_ADMIN_GET_STATS_TYPE_ENI);
 	if (likely(ret == 0))
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 73b03ce594129..3c5081d9d25d6 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -314,6 +314,7 @@ struct ena_com_dev {
 
 	struct ena_rss rss;
 	u32 supported_features;
+	u32 capabilities;
 	u32 dma_addr_bits;
 
 	struct ena_host_attribute host_attr;
@@ -967,6 +968,18 @@ static inline void ena_com_disable_adaptive_moderation(struct ena_com_dev *ena_d
 	ena_dev->adaptive_coalescing = false;
 }
 
+/* ena_com_get_cap - query whether device supports a capability.
+ * @ena_dev: ENA communication layer struct
+ * @cap_id: enum value representing the capability
+ *
+ * @return - true if capability is supported or false otherwise
+ */
+static inline bool ena_com_get_cap(struct ena_com_dev *ena_dev,
+				   enum ena_admin_aq_caps_id cap_id)
+{
+	return !!(ena_dev->capabilities & BIT(cap_id));
+}
+
 /* ena_com_update_intr_reg - Prepare interrupt register
  * @intr_reg: interrupt register to update.
  * @rx_delay_interval: Rx interval in usecs
-- 
2.43.0




