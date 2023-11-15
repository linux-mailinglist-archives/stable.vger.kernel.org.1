Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340247ECB20
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjKOTUS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjKOTUR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:20:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70C319E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:20:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AE1C433C7;
        Wed, 15 Nov 2023 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076013;
        bh=fEUFCngFyN1dWVLNIqm/1CsUWjBqghaHILFwtH/L7JI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMCxzXpzuuyRUV2BeqM4OdzJfFIVlV/8qqUlX3MchJHYvZHQi/E9FSo3Euqi6onTB
         YnJyq1LbcJQSFGffLLPW1gIxIkb57RiygoLINUpCBYcuNp9mUEPd5orrnJjodWUnR+
         L22lrxMZd4xOtkDToFD0LsXMtArCeCoUwpZzdbeI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Derick Marks <derick.w.marks@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 020/550] ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window
Date:   Wed, 15 Nov 2023 14:10:04 -0500
Message-ID: <20231115191602.120300069@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alison Schofield <alison.schofield@intel.com>

[ Upstream commit 8f1004679987302b155f14b966ca6d4335814fcb ]

Commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
CFMWS not in SRAT") did not account for the case where the BIOS
only partially describes a CFMWS Window in the SRAT. That means
the omitted address ranges, of a partially described CFMWS Window,
do not get assigned to a NUMA node.

Replace the call to phys_to_target_node() with numa_add_memblks().
Numa_add_memblks() searches an HPA range for existing memblk(s)
and extends those memblk(s) to fill the entire CFMWS Window.

Extending the existing memblks is a simple strategy that reuses
SRAT defined proximity domains from part of a window to fill out
the entire window, based on the knowledge* that all of a CFMWS
window is of a similar performance class.

*Note that this heuristic will evolve when CFMWS Windows present
a wider range of characteristics. The extension of the proximity
domain, implemented here, is likely a step in developing a more
sophisticated performance profile in the future.

There is no change in behavior when the SRAT does not describe
the CFMWS Window at all. In that case, a new NUMA node with a
single memblk covering the entire CFMWS Window is created.

Fixes: fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")
Reported-by: Derick Marks <derick.w.marks@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Derick Marks <derick.w.marks@intel.com>
Link: https://lore.kernel.org/all/eaa0b7cffb0951a126223eef3cbe7b55b8300ad9.1689018477.git.alison.schofield%40intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/numa/srat.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 1f4fc5f8a819d..12f330b0eac01 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -310,11 +310,16 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	start = cfmws->base_hpa;
 	end = cfmws->base_hpa + cfmws->window_size;
 
-	/* Skip if the SRAT already described the NUMA details for this HPA */
-	node = phys_to_target_node(start);
-	if (node != NUMA_NO_NODE)
+	/*
+	 * The SRAT may have already described NUMA details for all,
+	 * or a portion of, this CFMWS HPA range. Extend the memblks
+	 * found for any portion of the window to cover the entire
+	 * window.
+	 */
+	if (!numa_fill_memblks(start, end))
 		return 0;
 
+	/* No SRAT description. Create a new node. */
 	node = acpi_map_pxm_to_node(*fake_pxm);
 
 	if (node == NUMA_NO_NODE) {
-- 
2.42.0



