Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516027CAC07
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjJPOsu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbjJPOst (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:48:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B39FA
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:48:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEA7C433C7;
        Mon, 16 Oct 2023 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467727;
        bh=ZnV8Z35GuuSoKKT5ZfTA37/1KmUZwjLtQxCtXU8ULUI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wj5IPWwJlYKla7w+YPu5UtphAjrJcXwC7PZcZFvfh9qeB/8PfkF9jRs6YH5ZqCt1S
         EXJUt36yUN2MT6I6sBpiRMsC27D+v3CAQJhrFZTiHbspvavLng2gd4rNrWSi4Y+U03
         SuPL7MBBLa9oGBSlguIQiIIdFeUuOybKZVgM/pko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Simon Horman <horms@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 077/191] net/smc: Fix dependency of SMC on ISM
Date:   Mon, 16 Oct 2023 10:41:02 +0200
Message-ID: <20231016084017.202679994@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gerd Bayer <gbayer@linux.ibm.com>

[ Upstream commit a72178cfe855c283224f393d94a1332b90d1483e ]

When the SMC protocol is built into the kernel proper while ISM is
configured to be built as module, linking the kernel fails due to
unresolved dependencies out of net/smc/smc_ism.o to
ism_get_smcd_ops, ism_register_client, and ism_unregister_client
as reported via the linux-next test automation (see link).
This however is a bug introduced a while ago.

Correct the dependency list in ISM's and SMC's Kconfig to reflect the
dependencies that are actually inverted. With this you cannot build a
kernel with CONFIG_SMC=y and CONFIG_ISM=m. Either ISM needs to be 'y',
too - or a 'n'. That way, SMC can still be configured on non-s390
architectures that do not have (nor need) an ISM driver.

Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/linux-next/d53b5b50-d894-4df8-8969-fd39e63440ae@infradead.org/
Co-developed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Link: https://lore.kernel.org/r/20231006125847.1517840-1-gbayer@linux.ibm.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/Kconfig | 2 +-
 net/smc/Kconfig          | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 9c67b97faba2b..610ad8a801a57 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -103,7 +103,7 @@ config CCWGROUP
 
 config ISM
 	tristate "Support for ISM vPCI Adapter"
-	depends on PCI && SMC
+	depends on PCI
 	default n
 	help
 	  Select this option if you want to use the Internal Shared Memory
diff --git a/net/smc/Kconfig b/net/smc/Kconfig
index 1ab3c5a2c5ada..746be39967683 100644
--- a/net/smc/Kconfig
+++ b/net/smc/Kconfig
@@ -2,6 +2,7 @@
 config SMC
 	tristate "SMC socket protocol family"
 	depends on INET && INFINIBAND
+	depends on m || ISM != m
 	help
 	  SMC-R provides a "sockets over RDMA" solution making use of
 	  RDMA over Converged Ethernet (RoCE) technology to upgrade
-- 
2.40.1



