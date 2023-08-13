Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1DE77AB70
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHMVV7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjHMVV6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:21:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105AC10DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:22:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3E65627E4
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1862C433C8;
        Sun, 13 Aug 2023 21:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961720;
        bh=R15l1BKXod8hZEPiErcBzYQA82uGFFFFFen6jImXGo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hyt0I84SFM2vF4npw8fqx+K3zHDCShwKm5KXY1n2bzWleUrVTYMaZDh2SPl/dcJ1o
         oq3QOE+vOJa6WI7QTqS6JYGn4QIF37IU6fj9szfC+bFqFIjsU4/75/Q54R1fatuNHQ
         3zlRd5euZaV7+kU44l+u7UvRU/y79VYPIOBGgQjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>,
        Alexandra Diupina <adiupina@astralinux.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 23/26] scsi: 53c700: Check that command slot is not NULL
Date:   Sun, 13 Aug 2023 23:19:16 +0200
Message-ID: <20230813211703.848550401@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211702.980427106@linuxfoundation.org>
References: <20230813211702.980427106@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexandra Diupina <adiupina@astralinux.ru>

commit 8366d1f1249a0d0bba41d0bd1298d63e5d34c7f7 upstream.

Add a check for the command slot value to avoid dereferencing a NULL
pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Signed-off-by: Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Link: https://lore.kernel.org/r/20230728123521.18293-1-adiupina@astralinux.ru
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/53c700.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1594,7 +1594,7 @@ NCR_700_intr(int irq, void *dev_id)
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
-			} else if(dsp >= to32bit(&slot->pSG[0].ins) &&
+			} else if (slot && dsp >= to32bit(&slot->pSG[0].ins) &&
 				  dsp <= to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer = NCR_700_readl(host, DBC_REG) & 0xffffff;
 				int SGcount = (dsp - to32bit(&slot->pSG[0].ins))/sizeof(struct NCR_700_SG_List);


