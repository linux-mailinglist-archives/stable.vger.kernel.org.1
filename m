Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C26877AC6A
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjHMVcu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjHMVcu (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:32:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9216210E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24A0862BF8
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E041C433C8;
        Sun, 13 Aug 2023 21:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962371;
        bh=Ub6X6dlBZATCSM2/RUFOM5pJM3Y9N4IuTIa4sBcJSx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L6jj66GW2Z6PsdhHlZNkr4BGo8wSBNPn/+uNTwK+cc/MIJTF4M94e9h/T8yrbA2F4
         h9yjDPJbL7bVhRxR1SLK7sir6pgHFl4JHbnd4xgQ9JkPCxmTiwya99NHqNBHPOMWwE
         b9J+5VUVnDkA7lXC26Mt80z7mzZZ9PtOinBtGUkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>,
        Alexandra Diupina <adiupina@astralinux.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.4 192/206] scsi: 53c700: Check that command slot is not NULL
Date:   Sun, 13 Aug 2023 23:19:22 +0200
Message-ID: <20230813211730.514693622@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
@@ -1598,7 +1598,7 @@ NCR_700_intr(int irq, void *dev_id)
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, return %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset = hostdata->pScript + Ent_SendMessagePhaseMismatch;
-			} else if(dsp >= to32bit(&slot->pSG[0].ins) &&
+			} else if (slot && dsp >= to32bit(&slot->pSG[0].ins) &&
 				  dsp <= to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer = NCR_700_readl(host, DBC_REG) & 0xffffff;
 				int SGcount = (dsp - to32bit(&slot->pSG[0].ins))/sizeof(struct NCR_700_SG_List);


