Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67876AE66
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjHAJiR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbjHAJhl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:37:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E441BD8
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:36:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8981561507
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71789C433C7;
        Tue,  1 Aug 2023 09:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882564;
        bh=Z0j17gW43x9D+CBrLA+IfYo9ja2zAPqOlz84PxwP1ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dr0XI7WZ/K60ytxa0Ep/67kvL50y5ld17YJH9kZF9dHlZTV7OKbfSqNz5G6Y8TyGA
         zo2rzEyg5PVF3clpImvMS+r9+K051e1vgMeUMJyE16NJ0mpXWkjUixNOdljhd++UQP
         O/pw2Jj8VOqm3U1XaBzZTEbqd4G6ipLPxh/ufmb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 143/228] ata: pata_ns87415: mark ns87560_tf_read static
Date:   Tue,  1 Aug 2023 11:20:01 +0200
Message-ID: <20230801091928.051413769@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3fc2febb0f8ffae354820c1772ec008733237cfa ]

The global function triggers a warning because of the missing prototype

drivers/ata/pata_ns87415.c:263:6: warning: no previous prototype for 'ns87560_tf_read' [-Wmissing-prototypes]
  263 | void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)

There are no other references to this, so just make it static.

Fixes: c4b5b7b6c4423 ("pata_ns87415: Initial cut at 87415/87560 IDE support")
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/pata_ns87415.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_ns87415.c b/drivers/ata/pata_ns87415.c
index 9dd6bffefb485..602472d4e693e 100644
--- a/drivers/ata/pata_ns87415.c
+++ b/drivers/ata/pata_ns87415.c
@@ -260,7 +260,7 @@ static u8 ns87560_check_status(struct ata_port *ap)
  *	LOCKING:
  *	Inherited from caller.
  */
-void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+static void ns87560_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
 {
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
-- 
2.40.1



