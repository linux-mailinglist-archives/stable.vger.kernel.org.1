Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71A67B8B33
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjJDSsZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244500AbjJDSgb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:36:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD2FC1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:36:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6CCC433C9;
        Wed,  4 Oct 2023 18:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444588;
        bh=S/s6/qsiSHqLKqDtW8n8csBI1agpzXyic78wVC+PKB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+PCPePjJrcTZt+GU0f6PHzvwaVkNNMUsUXBhcuVBNzytd/ftx3gU02pyNxK8X1dv
         ZvDvpRTVwMlAu1Z8xRUJuE/dAnbfpcE2PZe/1KGeE+5tYiKfMeCJuoJiVgZ8VeMP4/
         AeMLilUZ7bnrTkXJD2RYXl6PcrN3ajStF7sIn/4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Liao <liaoyu15@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 6.5 275/321] ACPI: NFIT: Fix incorrect calculation of idt size
Date:   Wed,  4 Oct 2023 19:57:00 +0200
Message-ID: <20231004175242.029379469@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Liao <liaoyu15@huawei.com>

commit 33908660e814203e996f6e775d033c5c32fcf9a7 upstream.

acpi_nfit_interleave's field 'line_offset' is switched to flexible array [1],
but sizeof_idt() still calculates the size in the form of 1-element array.

Therefore, fix incorrect calculation in sizeof_idt().

[1] https://lore.kernel.org/lkml/2652195.BddDVKsqQX@kreacher/

Fixes: 2a5ab99847bd ("ACPICA: struct acpi_nfit_interleave: Replace 1-element array with flexible array")
Cc: stable@vger.kernel.org # v6.4+
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Link: https://lore.kernel.org/r/20230826071654.564372-1-liaoyu15@huawei.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index f0e6738ae3c9..f96bf32cd368 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -855,7 +855,7 @@ static size_t sizeof_idt(struct acpi_nfit_interleave *idt)
 {
 	if (idt->header.length < sizeof(*idt))
 		return 0;
-	return sizeof(*idt) + sizeof(u32) * (idt->line_count - 1);
+	return sizeof(*idt) + sizeof(u32) * idt->line_count;
 }
 
 static bool add_idt(struct acpi_nfit_desc *acpi_desc,
-- 
2.42.0



