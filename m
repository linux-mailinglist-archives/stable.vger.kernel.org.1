Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B107D33E2
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjJWLe7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjJWLe5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:34:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFF8DB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:34:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A54C433C7;
        Mon, 23 Oct 2023 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060895;
        bh=M/t4p0612jsrSHk+9f1E5JrSilt/bGVS4EHiWYtzI6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XT4sqo4hmVfg8QzUorR9evTEH72pilRteEPPhmOYq27IBWoRGd/Qrtma7N9zcvkow
         gX3qd4I3wS9sphf7Rn6bgxTEExthvbRKDcUey63ZVfmTaJbndGJqxNOVOgvFoqAnGs
         2YrVcAPk/+augT4G3lcwoHUxo+/Ow+SgAjyFc5Vw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 104/123] mtd: physmap-core: Restore map_rom fallback
Date:   Mon, 23 Oct 2023 12:57:42 +0200
Message-ID: <20231023104821.200572428@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 6792b7fce610bcd1cf3e07af3607fe7e2c38c1d8 upstream.

When the exact mapping type driver was not available, the old
physmap_of_core driver fell back to mapping the region as ROM.
Unfortunately this feature was lost when the DT and pdata cases were
merged.  Revive this useful feature.

Fixes: 642b1e8dbed7bbbf ("mtd: maps: Merge physmap_of.c into physmap-core.c")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/550e8c8c1da4c4baeb3d71ff79b14a18d4194f9e.1693407371.git.geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/maps/physmap-core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -533,6 +533,17 @@ static int physmap_flash_probe(struct pl
 		if (info->probe_type) {
 			info->mtds[i] = do_map_probe(info->probe_type,
 						     &info->maps[i]);
+
+			/* Fall back to mapping region as ROM */
+			if (!info->mtds[i] && IS_ENABLED(CONFIG_MTD_ROM) &&
+			    strcmp(info->probe_type, "map_rom")) {
+				dev_warn(&dev->dev,
+					 "map_probe() failed for type %s\n",
+					 info->probe_type);
+
+				info->mtds[i] = do_map_probe("map_rom",
+							     &info->maps[i]);
+			}
 		} else {
 			int j;
 


