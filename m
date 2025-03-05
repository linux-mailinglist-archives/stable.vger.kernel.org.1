Return-Path: <stable+bounces-120848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C772A508AD
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBFB31888ABD
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBD02517A0;
	Wed,  5 Mar 2025 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t4cPU2DN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB024887A;
	Wed,  5 Mar 2025 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198150; cv=none; b=ksM4zAlcg2pd9Uoaw5q/kI2Tr9OyBYTZriC6nCWBD352dZtHChqgOXC0wPY8zn+LbcbfH0p4yS1L8ElGNvWvpUOfjDpEP/vcRJyXuzmjoCLMjwFEZz57YMcRLNNKPfFlzYBTbAoUgSRSJ63FvOqDDYslXH5VDR3ergXrPYtkMoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198150; c=relaxed/simple;
	bh=oc3LLRhVOjTye9o/9ZHjrDhDnmdrHLlt34OCjygto7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8WtU9G99fvLcIY5e5tfTMW4rcMQU9/X1JrA8uSqFLqnQqZyQkYbionoLc8/FQHp/hchLQyvqtq6TbtvB+nAhurKGqSE4GzVawo8XQFTOWsybLNZ5BCi6SvVjFMDCP0vlNw6rcmz6o5wctN5r3Mu4WHdP0JYBYre00Nib+lC/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t4cPU2DN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52D7C4CED1;
	Wed,  5 Mar 2025 18:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198150;
	bh=oc3LLRhVOjTye9o/9ZHjrDhDnmdrHLlt34OCjygto7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4cPU2DN/RuE5ZEk2LjC6SZsx2I8ad2nsollWYuZc/iVXkmomkx0Qfss7U8o7iuJd
	 VNwEk8ra4YjMxtPNiZgRZ7P3DVyXflL4WTLKYNNJGaj+kHPAIPUPAjhpb6B63XVPnu
	 Em7QArW+zshPZYrz2IEzqNQGhAwxlZf4o49RBdcE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 050/150] ASoC: cs35l56: Prevent races when soft-resetting using SPI control
Date: Wed,  5 Mar 2025 18:47:59 +0100
Message-ID: <20250305174505.834531569@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174503.801402104@linuxfoundation.org>
References: <20250305174503.801402104@linuxfoundation.org>
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

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 769c1b79295c38d60fde4c0a8f5f31e01360c54f ]

When SPI is used for control, the driver must hold the SPI bus lock
while issuing the sequence of writes to perform a soft reset.

>From the time the driver writes the SYSTEM_RESET command until the
driver does a write to terminate the reset, there must not be any
activity on the SPI bus lines. If there is any SPI activity during the
soft-reset, another soft-reset will be triggered. The state of the SPI
chip select is irrelevant.

A repeated soft-reset does not in itself cause any problems, and it is
not an infinite loop. The problem is a race between these resets and
the driver polling for boot completion. There is a time window between
soft resets where the driver could read HALO_STATE as 2 (fully booted)
while the chip is actually soft-resetting. Although this window is
small, it is long enough that it is possible to hit it in normal
operation.

To prevent this race and ensure the chip really is fully booted, the
driver calls spi_bus_lock() to prevent other activity while resetting.
It then issues the SYSTEM_RESET mailbox command. After allowing
sufficient time for reset to take effect, the driver issues a PING
mailbox command, which will force completion of the full soft-reset
sequence. The SPI bus lock can then be released. The mailbox is
checked for any boot or wakeup response from the firmware, before the
value in HALO_STATE will be trusted.

This does not affect SoundWire or I2C control.

Fixes: 8a731fd37f8b ("ASoC: cs35l56: Move utility functions to shared file")
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://patch.msgid.link/20250225131843.113752-3-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/cs35l56.h           | 31 ++++++++++++
 sound/pci/hda/cs35l56_hda_spi.c   |  3 ++
 sound/soc/codecs/cs35l56-shared.c | 80 +++++++++++++++++++++++++++++++
 sound/soc/codecs/cs35l56-spi.c    |  3 ++
 4 files changed, 117 insertions(+)

diff --git a/include/sound/cs35l56.h b/include/sound/cs35l56.h
index 3dc7a1551ac35..5d653a3491d07 100644
--- a/include/sound/cs35l56.h
+++ b/include/sound/cs35l56.h
@@ -12,6 +12,7 @@
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
+#include <linux/spi/spi.h>
 #include <sound/cs-amp-lib.h>
 
 #define CS35L56_DEVID					0x0000000
@@ -61,6 +62,7 @@
 #define CS35L56_IRQ1_MASK_8				0x000E0AC
 #define CS35L56_IRQ1_MASK_18				0x000E0D4
 #define CS35L56_IRQ1_MASK_20				0x000E0DC
+#define CS35L56_DSP_MBOX_1_RAW				0x0011000
 #define CS35L56_DSP_VIRTUAL1_MBOX_1			0x0011020
 #define CS35L56_DSP_VIRTUAL1_MBOX_2			0x0011024
 #define CS35L56_DSP_VIRTUAL1_MBOX_3			0x0011028
@@ -224,6 +226,7 @@
 #define CS35L56_HALO_STATE_SHUTDOWN			1
 #define CS35L56_HALO_STATE_BOOT_DONE			2
 
+#define CS35L56_MBOX_CMD_PING				0x0A000000
 #define CS35L56_MBOX_CMD_AUDIO_PLAY			0x0B000001
 #define CS35L56_MBOX_CMD_AUDIO_PAUSE			0x0B000002
 #define CS35L56_MBOX_CMD_AUDIO_REINIT			0x0B000003
@@ -254,6 +257,16 @@
 #define CS35L56_NUM_BULK_SUPPLIES			3
 #define CS35L56_NUM_DSP_REGIONS				5
 
+/* Additional margin for SYSTEM_RESET to control port ready on SPI */
+#define CS35L56_SPI_RESET_TO_PORT_READY_US (CS35L56_CONTROL_PORT_READY_US + 2500)
+
+struct cs35l56_spi_payload {
+	__be32	addr;
+	__be16	pad;
+	__be32	value;
+} __packed;
+static_assert(sizeof(struct cs35l56_spi_payload) == 10);
+
 struct cs35l56_base {
 	struct device *dev;
 	struct regmap *regmap;
@@ -269,6 +282,7 @@ struct cs35l56_base {
 	s8 cal_index;
 	struct cirrus_amp_cal_data cal_data;
 	struct gpio_desc *reset_gpio;
+	struct cs35l56_spi_payload *spi_payload_buf;
 };
 
 static inline bool cs35l56_is_otp_register(unsigned int reg)
@@ -276,6 +290,23 @@ static inline bool cs35l56_is_otp_register(unsigned int reg)
 	return (reg >> 16) == 3;
 }
 
+static inline int cs35l56_init_config_for_spi(struct cs35l56_base *cs35l56,
+					      struct spi_device *spi)
+{
+	cs35l56->spi_payload_buf = devm_kzalloc(&spi->dev,
+						sizeof(*cs35l56->spi_payload_buf),
+						GFP_KERNEL | GFP_DMA);
+	if (!cs35l56->spi_payload_buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline bool cs35l56_is_spi(struct cs35l56_base *cs35l56)
+{
+	return IS_ENABLED(CONFIG_SPI_MASTER) && !!cs35l56->spi_payload_buf;
+}
+
 extern const struct regmap_config cs35l56_regmap_i2c;
 extern const struct regmap_config cs35l56_regmap_spi;
 extern const struct regmap_config cs35l56_regmap_sdw;
diff --git a/sound/pci/hda/cs35l56_hda_spi.c b/sound/pci/hda/cs35l56_hda_spi.c
index 7f02155fe61e3..7c94110b6272a 100644
--- a/sound/pci/hda/cs35l56_hda_spi.c
+++ b/sound/pci/hda/cs35l56_hda_spi.c
@@ -22,6 +22,9 @@ static int cs35l56_hda_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	cs35l56->base.dev = &spi->dev;
+	ret = cs35l56_init_config_for_spi(&cs35l56->base, spi);
+	if (ret)
+		return ret;
 
 #ifdef CS35L56_WAKE_HOLD_TIME_US
 	cs35l56->base.can_hibernate = true;
diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
index e45e9ae01bc66..195841a567c3d 100644
--- a/sound/soc/codecs/cs35l56-shared.c
+++ b/sound/soc/codecs/cs35l56-shared.c
@@ -10,6 +10,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <sound/cs-amp-lib.h>
 
@@ -303,6 +304,79 @@ void cs35l56_wait_min_reset_pulse(void)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_wait_min_reset_pulse, SND_SOC_CS35L56_SHARED);
 
+static const struct {
+	u32 addr;
+	u32 value;
+} cs35l56_spi_system_reset_stages[] = {
+	{ .addr = CS35L56_DSP_VIRTUAL1_MBOX_1, .value = CS35L56_MBOX_CMD_SYSTEM_RESET },
+	/* The next write is necessary to delimit the soft reset */
+	{ .addr = CS35L56_DSP_MBOX_1_RAW, .value = CS35L56_MBOX_CMD_PING },
+};
+
+static void cs35l56_spi_issue_bus_locked_reset(struct cs35l56_base *cs35l56_base,
+					       struct spi_device *spi)
+{
+	struct cs35l56_spi_payload *buf = cs35l56_base->spi_payload_buf;
+	struct spi_transfer t = {
+		.tx_buf		= buf,
+		.len		= sizeof(*buf),
+	};
+	struct spi_message m;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(cs35l56_spi_system_reset_stages); i++) {
+		buf->addr = cpu_to_be32(cs35l56_spi_system_reset_stages[i].addr);
+		buf->value = cpu_to_be32(cs35l56_spi_system_reset_stages[i].value);
+		spi_message_init_with_transfers(&m, &t, 1);
+		ret = spi_sync_locked(spi, &m);
+		if (ret)
+			dev_warn(cs35l56_base->dev, "spi_sync failed: %d\n", ret);
+
+		usleep_range(CS35L56_SPI_RESET_TO_PORT_READY_US,
+			     2 * CS35L56_SPI_RESET_TO_PORT_READY_US);
+	}
+}
+
+static void cs35l56_spi_system_reset(struct cs35l56_base *cs35l56_base)
+{
+	struct spi_device *spi = to_spi_device(cs35l56_base->dev);
+	unsigned int val;
+	int read_ret, ret;
+
+	/*
+	 * There must not be any other SPI bus activity while the amp is
+	 * soft-resetting.
+	 */
+	ret = spi_bus_lock(spi->controller);
+	if (ret) {
+		dev_warn(cs35l56_base->dev, "spi_bus_lock failed: %d\n", ret);
+		return;
+	}
+
+	cs35l56_spi_issue_bus_locked_reset(cs35l56_base, spi);
+	spi_bus_unlock(spi->controller);
+
+	/*
+	 * Check firmware boot by testing for a response in MBOX_2.
+	 * HALO_STATE cannot be trusted yet because the reset sequence
+	 * can leave it with stale state. But MBOX is reset.
+	 * The regmap must remain in cache-only until the chip has
+	 * booted, so use a bypassed read.
+	 */
+	ret = read_poll_timeout(regmap_read_bypassed, read_ret,
+				(val > 0) && (val < 0xffffffff),
+				CS35L56_HALO_STATE_POLL_US,
+				CS35L56_HALO_STATE_TIMEOUT_US,
+				false,
+				cs35l56_base->regmap,
+				CS35L56_DSP_VIRTUAL1_MBOX_2,
+				&val);
+	if (ret) {
+		dev_err(cs35l56_base->dev, "SPI reboot timed out(%d): MBOX2=%#x\n",
+			read_ret, val);
+	}
+}
+
 static const struct reg_sequence cs35l56_system_reset_seq[] = {
 	REG_SEQ0(CS35L56_DSP1_HALO_STATE, 0),
 	REG_SEQ0(CS35L56_DSP_VIRTUAL1_MBOX_1, CS35L56_MBOX_CMD_SYSTEM_RESET),
@@ -315,6 +389,12 @@ void cs35l56_system_reset(struct cs35l56_base *cs35l56_base, bool is_soundwire)
 	 * accesses other than the controlled system reset sequence below.
 	 */
 	regcache_cache_only(cs35l56_base->regmap, true);
+
+	if (cs35l56_is_spi(cs35l56_base)) {
+		cs35l56_spi_system_reset(cs35l56_base);
+		return;
+	}
+
 	regmap_multi_reg_write_bypassed(cs35l56_base->regmap,
 					cs35l56_system_reset_seq,
 					ARRAY_SIZE(cs35l56_system_reset_seq));
diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
index b07b798b0b45d..568f554a8638b 100644
--- a/sound/soc/codecs/cs35l56-spi.c
+++ b/sound/soc/codecs/cs35l56-spi.c
@@ -33,6 +33,9 @@ static int cs35l56_spi_probe(struct spi_device *spi)
 
 	cs35l56->base.dev = &spi->dev;
 	cs35l56->base.can_hibernate = true;
+	ret = cs35l56_init_config_for_spi(&cs35l56->base, spi);
+	if (ret)
+		return ret;
 
 	ret = cs35l56_common_probe(cs35l56);
 	if (ret != 0)
-- 
2.39.5




