Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982EA76AF79
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjHAJrq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjHAJrc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:47:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5A2D72
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B533614F3
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E76C433C8;
        Tue,  1 Aug 2023 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883165;
        bh=ceVYweKrZD7TSpKQEnjPHVKuOhWdHWTMG4Er0YHkMGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e3es1oZuPvCcp1aeGkHRMle3zRgInH5n05p2MTcuNzQobWnRsmR0dTQs9L+XZFfBv
         w1YzYCRea6DSXFutt3xAEpuM4p+ZwVuO4NfY95qpwS57PymIm1TjecIrSojv4rDgaQ
         LYlrQalkD9nYGPaLAiDTj3IPxq3tNr7/9belRsMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 139/239] ata: pata_ns87415: mark ns87560_tf_read static
Date:   Tue,  1 Aug 2023 11:20:03 +0200
Message-ID: <20230801091930.701136440@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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
index d60e1f69d7b02..c697219a61a2d 100644
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



