Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638C07D3481
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjJWLkV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjJWLkT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:40:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF89DB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:40:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBD5C433C8;
        Mon, 23 Oct 2023 11:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061217;
        bh=wxP/CrDIP79ZVTw/ggCTWRwrDka7MRLB/dVBw+kEPps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1rFi/a51KNJ72O5V+zkIp1UQkHhSOqzvISNUrX97AuMSrWwwPRJ34m1d/+UJYhDoO
         uNJGlX7uKmkCS4G0kEFEnFsXC3KqDQAs98kOXhV4rc5w2GjteKWqyA8C+mkdMrebUX
         FnE+RrfGv0ZlrUq2Q9SYphivoMCYIjigfu8skUmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Damien Le Moal <dlemoal@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 075/137] ata: libata-core: Fix compilation warning in ata_dev_config_ncq()
Date:   Mon, 23 Oct 2023 12:57:12 +0200
Message-ID: <20231023104823.460833888@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit ed518d9ba980dc0d27c7d1dea1e627ba001d1977 ]

The 24 bytes length allocated to the ncq_desc string in
ata_dev_config_lba() for ata_dev_config_ncq() to use is too short,
causing the following gcc compilation warnings when compiling with W=1:

drivers/ata/libata-core.c: In function ‘ata_dev_configure’:
drivers/ata/libata-core.c:2378:56: warning: ‘%d’ directive output may be truncated writing between 1 and 2 bytes into a region of size between 1 and 11 [-Wformat-truncation=]
 2378 |                 snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
      |                                                        ^~
In function ‘ata_dev_config_ncq’,
    inlined from ‘ata_dev_config_lba’ at drivers/ata/libata-core.c:2649:8,
    inlined from ‘ata_dev_configure’ at drivers/ata/libata-core.c:2952:9:
drivers/ata/libata-core.c:2378:41: note: directive argument in the range [1, 32]
 2378 |                 snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/ata/libata-core.c:2378:17: note: ‘snprintf’ output between 16 and 31 bytes into a destination of size 24
 2378 |                 snprintf(desc, desc_sz, "NCQ (depth %d/%d)%s", hdepth,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 2379 |                         ddepth, aa_desc);
      |                         ~~~~~~~~~~~~~~~~

Avoid these warnings and the potential truncation by changing the size
of the ncq_desc string to 32 characters.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 96786d6fcf37b..383398af836c8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2382,7 +2382,7 @@ static int ata_dev_config_lba(struct ata_device *dev)
 	struct ata_port *ap = dev->link->ap;
 	const u16 *id = dev->id;
 	const char *lba_desc;
-	char ncq_desc[24];
+	char ncq_desc[32];
 	int ret;
 
 	dev->flags |= ATA_DFLAG_LBA;
-- 
2.40.1



