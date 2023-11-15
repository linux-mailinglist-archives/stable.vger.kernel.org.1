Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC227ED4C8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344825AbjKOU7H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344746AbjKOU54 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:57:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D933A1BDC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:57:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E461C4AF75;
        Wed, 15 Nov 2023 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081425;
        bh=4aTZj3HIGlHREWlOC3pWSaCQrEMg7Ce8FU3eNfHdfpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cBNgMKFcSFKgqpsb7XUKvwsXjdOgugN0HRs32GQhAUBe3b2Thy1dSjkEGo687NAuX
         GlluF3GBPpI/qTek4XCFLQXDoGRmHiDC/FU4H+TwFrvoem7Q/nnMA9fozGiAWuJiSa
         aLsl7xR/4VOaZLLUEkq4j2B9kVBp1xdlcb4zvJ6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 147/244] RDMA/hfi1: Workaround truncation compilation error
Date:   Wed, 15 Nov 2023 15:35:39 -0500
Message-ID: <20231115203557.153455772@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit d4b2d165714c0ce8777d5131f6e0aad617b7adc4 ]

Increase name array to be large enough to overcome the following
compilation error.

drivers/infiniband/hw/hfi1/efivar.c: In function ‘read_hfi1_efi_var’:
drivers/infiniband/hw/hfi1/efivar.c:124:44: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  124 |         snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
      |                                            ^
drivers/infiniband/hw/hfi1/efivar.c:124:9: note: ‘snprintf’ output 2 or more bytes (assuming 65) into a destination of size 64
  124 |         snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/infiniband/hw/hfi1/efivar.c:133:52: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  133 |                 snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
      |                                                    ^
drivers/infiniband/hw/hfi1/efivar.c:133:17: note: ‘snprintf’ output 2 or more bytes (assuming 65) into a destination of size 64
  133 |                 snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[6]: *** [scripts/Makefile.build:243: drivers/infiniband/hw/hfi1/efivar.o] Error 1

Fixes: c03c08d50b3d ("IB/hfi1: Check upper-case EFI variables")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Link: https://lore.kernel.org/r/238fa39a8fd60e87a5ad7e1ca6584fcdf32e9519.1698159993.git.leonro@nvidia.com
Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/efivar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
index f275dd1abed85..7a3caf2cd9071 100644
--- a/drivers/infiniband/hw/hfi1/efivar.c
+++ b/drivers/infiniband/hw/hfi1/efivar.c
@@ -110,7 +110,7 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
 		      unsigned long *size, void **return_data)
 {
 	char prefix_name[64];
-	char name[64];
+	char name[128];
 	int result;
 	int i;
 
-- 
2.42.0



