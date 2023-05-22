Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345C070C935
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbjEVTp4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjEVTpv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D8119
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE7262A88
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:45:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C62C433EF;
        Mon, 22 May 2023 19:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784746;
        bh=cpPJWJSWWa9E4BUMA9J+31Go0wT6pdtTmADwTloNQ+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RckgUE95336hgi/q+fOBjbpWG+wXeRa1UwWyfGJjN9z1olAczVh9rPKFb0exliUdV
         63NJS0amflazaaQNBfU2as9BKlcYVyArGpeVBzi0LO62wzg36ZfQQIsCMq19fYThag
         Yw1bKrxXyxDP/CZgr47Y6oWm8qsI64xhfG4M3K4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 160/364] ASoC: amd: Add check for acp config flags
Date:   Mon, 22 May 2023 20:07:45 +0100
Message-Id: <20230522190416.741142489@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

[ Upstream commit bddcfb0802eb69b0f51293eab5db33d344c0262f ]

We have SOF and generic ACP support enabled for Rembrandt and
pheonix platforms on some machines. Since we have same PCI id
used for probing, add check for machine configuration flag to
avoid conflict with newer pci drivers. Such machine flag has
been initialized via dmi match on few Chrome machines. If no
flag is specified probe and register older platform device.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://lore.kernel.org/r/20230412091638.1158901-1-Syed.SabaKareem@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/Kconfig        | 2 ++
 sound/soc/amd/ps/acp63.h     | 2 ++
 sound/soc/amd/ps/pci-ps.c    | 8 +++++++-
 sound/soc/amd/yc/acp6x.h     | 3 +++
 sound/soc/amd/yc/pci-acp6x.c | 8 +++++++-
 5 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index c88ebd84bdd50..08e42082f5e96 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -90,6 +90,7 @@ config SND_SOC_AMD_VANGOGH_MACH
 
 config SND_SOC_AMD_ACP6x
 	tristate "AMD Audio Coprocessor-v6.x Yellow Carp support"
+	select SND_AMD_ACP_CONFIG
 	depends on X86 && PCI
 	help
 	  This option enables Audio Coprocessor i.e ACP v6.x support on
@@ -130,6 +131,7 @@ config SND_SOC_AMD_RPL_ACP6x
 
 config SND_SOC_AMD_PS
         tristate "AMD Audio Coprocessor-v6.3 Pink Sardine support"
+	select SND_AMD_ACP_CONFIG
         depends on X86 && PCI && ACPI
         help
           This option enables Audio Coprocessor i.e ACP v6.3 support on
diff --git a/sound/soc/amd/ps/acp63.h b/sound/soc/amd/ps/acp63.h
index 6bf29b520511d..dd36790b25aef 100644
--- a/sound/soc/amd/ps/acp63.h
+++ b/sound/soc/amd/ps/acp63.h
@@ -111,3 +111,5 @@ struct acp63_dev_data {
 	u16 pdev_count;
 	u16 pdm_dev_index;
 };
+
+int snd_amd_acp_find_config(struct pci_dev *pci);
diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 688a1d4643d91..afddb9a77ba49 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -247,11 +247,17 @@ static int snd_acp63_probe(struct pci_dev *pci,
 {
 	struct acp63_dev_data *adata;
 	u32 addr;
-	u32 irqflags;
+	u32 irqflags, flag;
 	int val;
 	int ret;
 
 	irqflags = IRQF_SHARED;
+
+	/* Return if acp config flag is defined */
+	flag = snd_amd_acp_find_config(pci);
+	if (flag)
+		return -ENODEV;
+
 	/* Pink Sardine device check */
 	switch (pci->revision) {
 	case 0x63:
diff --git a/sound/soc/amd/yc/acp6x.h b/sound/soc/amd/yc/acp6x.h
index 036207568c048..2de7d1edf00b7 100644
--- a/sound/soc/amd/yc/acp6x.h
+++ b/sound/soc/amd/yc/acp6x.h
@@ -105,3 +105,6 @@ static inline void acp6x_writel(u32 val, void __iomem *base_addr)
 {
 	writel(val, base_addr - ACP6x_PHY_BASE_ADDRESS);
 }
+
+int snd_amd_acp_find_config(struct pci_dev *pci);
+
diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 77c5fa1f7af14..7af6a349b1d41 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -149,10 +149,16 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 	int index = 0;
 	int val = 0x00;
 	u32 addr;
-	unsigned int irqflags;
+	unsigned int irqflags, flag;
 	int ret;
 
 	irqflags = IRQF_SHARED;
+
+	/* Return if acp config flag is defined */
+	flag = snd_amd_acp_find_config(pci);
+	if (flag)
+		return -ENODEV;
+
 	/* Yellow Carp device check */
 	switch (pci->revision) {
 	case 0x60:
-- 
2.39.2



