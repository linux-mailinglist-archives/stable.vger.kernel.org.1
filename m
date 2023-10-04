Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6907B8A0E
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244341AbjJDSbt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbjJDSbt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:31:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59563C0
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:31:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF92C433C7;
        Wed,  4 Oct 2023 18:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444304;
        bh=uiFeQETSv4hIzEoz8Wr5GaMtf/VMDjEE4/jmUarf0ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjeDRzAF08cmhl20KdC6NJFnSApiDM0zlPmWirLnuy9npHyEqolqNnir1cs1Rhpe8
         TqKJKLJS6hVY/HbEk5w1hwa7ILRjBykGPAH+7waBsMqfWB5Z2dtK7MQlXNZacvQZ28
         GN2Br3XeQ01ITT2vGRhPYa44j+bVA2qnmXGJV2sI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 202/321] ata: libata-eh: do not thaw the port twice in ata_eh_reset()
Date:   Wed,  4 Oct 2023 19:55:47 +0200
Message-ID: <20231004175238.595472448@linuxfoundation.org>
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

From: Niklas Cassel <niklas.cassel@wdc.com>

[ Upstream commit 7a3bc2b3989e05bbaa904a63279049a401491c84 ]

commit 1e641060c4b5 ("libata: clear eh_info on reset completion") added
a workaround that broke the retry mechanism in ATA EH.

Tejun himself suggested to remove this workaround when it was identified
to cause additional problems:
https://lore.kernel.org/linux-ide/20110426135027.GI878@htj.dyndns.org/

He even said:
"Hmm... it seems I wasn't thinking straight when I added that work around."
https://lore.kernel.org/linux-ide/20110426155229.GM878@htj.dyndns.org/

While removing the workaround solved the issue, however, the workaround was
kept to avoid "spurious hotplug events during reset", and instead another
workaround was added on top of the existing workaround in commit
8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").

Because these IRQs happened when the port was frozen, we know that they
were actually a side effect of PxIS and IS.IPS(x) not being cleared before
the COMRESET. This is now done in commit 94152042eaa9 ("ata: libahci: clear
pending interrupt status"), so these workarounds can now be removed.

Since commit 1e641060c4b5 ("libata: clear eh_info on reset completion") has
now been reverted, the ATA EH retry mechanism is functional again, so there
is once again no need to thaw the port more than once in ata_eh_reset().

This reverts "the workaround on top of the workaround" introduced in commit
8c56cacc724c ("libata: fix unexpectedly frozen port after ata_eh_reset()").

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index d7914c7d1a0d1..960ef5c6f2c10 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2829,9 +2829,6 @@ int ata_eh_reset(struct ata_link *link, int classify,
 		slave->eh_info.serror = 0;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
-	if (ata_port_is_frozen(ap))
-		ata_eh_thaw_port(ap);
-
 	/*
 	 * Make sure onlineness and classification result correspond.
 	 * Hotplug could have happened during reset and some
-- 
2.40.1



