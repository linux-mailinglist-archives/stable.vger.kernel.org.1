Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E424175FB55
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 17:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGXP7N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 24 Jul 2023 11:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGXP7M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 24 Jul 2023 11:59:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FA68E
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 08:59:11 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so6436278a12.1
        for <stable@vger.kernel.org>; Mon, 24 Jul 2023 08:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690214349; x=1690819149;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40oJa3uydCuVwJnGM+1GqaodlYKJAonZxfGECVd8tAA=;
        b=CzwleuSEhujqjp5189VkkdZxmUypQMDwGLzj3UdDQS0Bd3TpXD3b817Jr8VUrIDnP4
         7nBIMItdioQxHAE/w0P8ydSX7759fa8HvKgW//dOzxVprv0uKObnc/FfMhjOiFpkLsPj
         mfyyEeXWRPOYn66ogk58U0Bb5SjqkfoE3yipDpyt6cu41CLw3eC5s3s33D1G7+CoXEt0
         4h4TTgSBxwL+k9SXBFskyiq19ZgxB+by7Wiyv8ubditM23TBx+nM8Tz8MMY23dpIM092
         e/1H/SDz/0M8AMDPIb1AVXxYYPn+a53OLpAAA6wzAaaAuhYtA52d60NxvziZn0YqDElf
         ntAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214349; x=1690819149;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40oJa3uydCuVwJnGM+1GqaodlYKJAonZxfGECVd8tAA=;
        b=Vo6uThLkIFtRu3yV8AFE4CotM8EDTfYbEhI2Ro+lF4uEVJp3uCWi8IyYw3St8ucOoi
         ypkRJsDmYzSe43U8TWVizAIKVlWbidA74DhTBcHqqLaTMLloR4UQFC2/TaVIFOtV4fXx
         K+95A6vbe1CH7J7rp3vL+X7kBLCe+Ox+dKx1+aHM6JUHKlbW4ErxV+8BZMLP8F3dGv+G
         4tXyDcD+r9macm3LwFFAqyHFPwlOP3lT9jeGeXgsdEXcTc3kHiHvVnVPF6fM18hB54tc
         N4LMxFyGF3nysBvC7luNYsasQvYIZSefA0/f5HjZyO3iSBxDbi+DsWFZPWsrcAP8jF6B
         SLvA==
X-Gm-Message-State: ABy/qLYVnpRfVdz74SDN36ki+mP11kh+YxdnW42DVPXNZVhvmPzgQ5Pq
        BUiphJ+YDo6r12/Of2CQjfzMu9oc6E0=
X-Google-Smtp-Source: APBJJlHp5DrZn9oZ04fZJ8OTdvaxh8+jep/zBxB5Eb3/ikYk6YLSBXW6VIrqCMtA1Voptr8QSEay3g==
X-Received: by 2002:aa7:d9c9:0:b0:522:2aee:6832 with SMTP id v9-20020aa7d9c9000000b005222aee6832mr3759444eds.9.1690214349255;
        Mon, 24 Jul 2023 08:59:09 -0700 (PDT)
Received: from ?IPV6:2a02:3100:904e:4d00:8d5a:dd56:14c5:dfa5? (dynamic-2a02-3100-904e-4d00-8d5a-dd56-14c5-dfa5.310.pool.telefonica.de. [2a02:3100:904e:4d00:8d5a:dd56:14c5:dfa5])
        by smtp.googlemail.com with ESMTPSA id k6-20020a056402048600b0051bfc85afaasm6311600edv.86.2023.07.24.08.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:59:08 -0700 (PDT)
Message-ID: <38cddf6d-f894-55a1-6275-87945b265e8b@gmail.com>
Date:   Mon, 24 Jul 2023 17:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, kuba@kernel.org
References: <2023072337-dreamlike-rewrite-a12e@gregkh>
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] r8169: revert 2ab19de62d67 ("r8169: remove ASPM restrictions
 now that ASPM is disabled during NAPI poll")
In-Reply-To: <2023072337-dreamlike-rewrite-a12e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

There have been reports that on a number of systems this change breaks
network connectivity. Therefore effectively revert it. Mainly affected
seem to be systems where BIOS denies ASPM access to OS.
Due to later changes we can't do a direct revert.

Fixes: 2ab19de62d67 ("r8169: remove ASPM restrictions now that ASPM is disabled during NAPI poll")
Cc: stable@vger.kernel.org # v6.4.y
Link: https://lore.kernel.org/netdev/e47bac0d-e802-65e1-b311-6acb26d5cf10@freenet.de/T/
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217596
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/57f13ec0-b216-d5d8-363d-5b05528ec5fb@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ca0140963..2cbbdf872 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -623,6 +623,7 @@ struct rtl8169_private {
 	int cfg9346_usage_count;
 
 	unsigned supports_gmii:1;
+	unsigned aspm_manageable:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -2746,7 +2747,8 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	if (tp->mac_version < RTL_GIGA_MAC_VER_32)
 		return;
 
-	if (enable) {
+	/* Don't enable ASPM in the chip if OS can't control ASPM */
+	if (enable && tp->aspm_manageable) {
 		rtl_mod_config5(tp, 0, ASPM_en);
 		rtl_mod_config2(tp, 0, ClkReqEn);
 
@@ -5149,6 +5151,16 @@ static void rtl_init_mac_address(struct rtl8169_private *tp)
 	rtl_rar_set(tp, mac_addr);
 }
 
+/* register is set if system vendor successfully tested ASPM 1.2 */
+static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
+{
+	if (tp->mac_version >= RTL_GIGA_MAC_VER_61 &&
+	    r8168_mac_ocp_read(tp, 0xc0b2) & 0xf)
+		return true;
+
+	return false;
+}
+
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct rtl8169_private *tp;
@@ -5220,6 +5232,19 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	tp->mac_version = chipset;
 
+	/* Disable ASPM L1 as that cause random device stop working
+	 * problems as well as full system hangs for some PCIe devices users.
+	 * Chips from RTL8168h partially have issues with L1.2, but seem
+	 * to work fine with L1 and L1.1.
+	 */
+	if (rtl_aspm_is_safe(tp))
+		rc = 0;
+	else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
+		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
+	else
+		rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1);
+	tp->aspm_manageable = !rc;
+
 	tp->dash_type = rtl_check_dash(tp);
 
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
-- 
2.41.0


