Return-Path: <stable+bounces-1577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2077F805D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A902825B4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC7F33CC2;
	Fri, 24 Nov 2023 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LoGyYzVq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F1339BE;
	Fri, 24 Nov 2023 18:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9EFC433C9;
	Fri, 24 Nov 2023 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851748;
	bh=ZNDz8myisqet+1rkZ7itwghKLa6GxUJwenYMNl7D310=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LoGyYzVqxB+8OvggvJEWXs0+rVVcGifsFv1N8ZRjJKIn1mR4Bz64PvCKjY39tTfZ3
	 fuNhlv2PJ2KDbd7h5LiYzZUCvRHShohmVmZMOwg8Rh30Rqi/as9NJL7/foMk2Imu/o
	 iDmzwFpi+eMkwFYrRv9koAeh/3uGE+2395t+KEsM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 055/372] ASoC: soc-card: Add storage for PCI SSID
Date: Fri, 24 Nov 2023 17:47:22 +0000
Message-ID: <20231124172012.312210341@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 47f56e38a199bd45514b8e0142399cba4feeaf1a ]

Add members to struct snd_soc_card to store the PCI subsystem ID (SSID)
of the soundcard.

The PCI specification provides two registers to store a vendor-specific
SSID that can be read by drivers to uniquely identify a particular
"soundcard". This is defined in the PCI specification to distinguish
products that use the same silicon (and therefore have the same silicon
ID) so that product-specific differences can be applied.

PCI only defines 0xFFFF as an invalid value. 0x0000 is not defined as
invalid. So the usual pattern of zero-filling the struct and then
assuming a zero value unset will not work. A flag is included to
indicate when the SSID information has been filled in.

Unlike DMI information, which has a free-format entirely up to the vendor,
the PCI SSID has a strictly defined format and a registry of vendor IDs.

It is usual in Windows drivers that the SSID is used as the sole identifier
of the specific end-product and the Windows driver contains tables mapping
that to information about the hardware setup, rather than using ACPI
properties.

This SSID is important information for ASoC components that need to apply
hardware-specific configuration on PCI-based systems.

As the SSID is a generic part of the PCI specification and is treated as
identifying the "soundcard", it is reasonable to include this information
in struct snd_soc_card, instead of components inventing their own custom
ways to pass this information around.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230912163207.3498161-2-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-card.h | 37 +++++++++++++++++++++++++++++++++++++
 include/sound/soc.h      | 11 +++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/sound/soc-card.h b/include/sound/soc-card.h
index 9d31a5c0db33c..40d3023cf0d16 100644
--- a/include/sound/soc-card.h
+++ b/include/sound/soc-card.h
@@ -44,6 +44,43 @@ int snd_soc_card_add_dai_link(struct snd_soc_card *card,
 void snd_soc_card_remove_dai_link(struct snd_soc_card *card,
 				  struct snd_soc_dai_link *dai_link);
 
+#ifdef CONFIG_PCI
+static inline void snd_soc_card_set_pci_ssid(struct snd_soc_card *card,
+					     unsigned short vendor,
+					     unsigned short device)
+{
+	card->pci_subsystem_vendor = vendor;
+	card->pci_subsystem_device = device;
+	card->pci_subsystem_set = true;
+}
+
+static inline int snd_soc_card_get_pci_ssid(struct snd_soc_card *card,
+					    unsigned short *vendor,
+					    unsigned short *device)
+{
+	if (!card->pci_subsystem_set)
+		return -ENOENT;
+
+	*vendor = card->pci_subsystem_vendor;
+	*device = card->pci_subsystem_device;
+
+	return 0;
+}
+#else /* !CONFIG_PCI */
+static inline void snd_soc_card_set_pci_ssid(struct snd_soc_card *card,
+					     unsigned short vendor,
+					     unsigned short device)
+{
+}
+
+static inline int snd_soc_card_get_pci_ssid(struct snd_soc_card *card,
+					    unsigned short *vendor,
+					    unsigned short *device)
+{
+	return -ENOENT;
+}
+#endif /* CONFIG_PCI */
+
 /* device driver data */
 static inline void snd_soc_card_set_drvdata(struct snd_soc_card *card,
 					    void *data)
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 37bbfc8b45cb2..108617cea9c67 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -911,6 +911,17 @@ struct snd_soc_card {
 #ifdef CONFIG_DMI
 	char dmi_longname[80];
 #endif /* CONFIG_DMI */
+
+#ifdef CONFIG_PCI
+	/*
+	 * PCI does not define 0 as invalid, so pci_subsystem_set indicates
+	 * whether a value has been written to these fields.
+	 */
+	unsigned short pci_subsystem_vendor;
+	unsigned short pci_subsystem_device;
+	bool pci_subsystem_set;
+#endif /* CONFIG_PCI */
+
 	char topology_shortname[32];
 
 	struct device *dev;
-- 
2.42.0




