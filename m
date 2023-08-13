Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDC977AD33
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjHMVsN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbjHMVqR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:46:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53182D54
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 812E961B60
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910CAC433C7;
        Sun, 13 Aug 2023 21:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963175;
        bh=4v+94prT9e4Zj/BHMucDr/oLfG8GPskabnTBqsh/0Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2WKQQ1G8hBwoAwHgXGoz+sFD5vBgb4XwA4KfaEfkhWUxWA2H6KLrKwKcjPRJVjl3
         twbksj1u0AlliETLFnAJOhlil9p0Q9GPOg71M3vJ1cvB8+ABvhsTal2mKBspFXflaG
         VvNpEefF5ORjfy1QpeLOR/pDvtDKzcCI20rPLh+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhu Wang <wangzhu9@huawei.com>,
        Narsimhulu Musini <nmusini@cisco.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.15 80/89] scsi: snic: Fix possible memory leak if device_add() fails
Date:   Sun, 13 Aug 2023 23:20:11 +0200
Message-ID: <20230813211713.169529669@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211710.787645394@linuxfoundation.org>
References: <20230813211710.787645394@linuxfoundation.org>
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

From: Zhu Wang <wangzhu9@huawei.com>

commit 41320b18a0e0dfb236dba4edb9be12dba1878156 upstream.

If device_add() returns error, the name allocated by dev_set_name() needs
be freed. As the comment of device_add() says, put_device() should be used
to give up the reference in the error path. So fix this by calling
put_device(), then the name can be freed in kobject_cleanp().

Fixes: c8806b6c9e82 ("snic: driver for Cisco SCSI HBA")
Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
Acked-by: Narsimhulu Musini <nmusini@cisco.com>
Link: https://lore.kernel.org/r/20230801111421.63651-1-wangzhu9@huawei.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/snic/snic_disc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -317,6 +317,7 @@ snic_tgt_create(struct snic *snic, struc
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
+		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);


