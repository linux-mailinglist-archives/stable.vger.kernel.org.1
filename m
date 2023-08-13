Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF577AD53
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjHMVs1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjHMVsJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:48:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5EC1FCB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97EA260B9D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04FFC433C8;
        Sun, 13 Aug 2023 21:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962939;
        bh=4v+94prT9e4Zj/BHMucDr/oLfG8GPskabnTBqsh/0Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HT8pQq7PZxwNdl/gaBtmUUixf37ydUr8kQtFdvxjNpQkw1TfX+icwnFsBVLtbUrsn
         0M+yL9m636iKltWQNBEkeiyUndXgig42xZ4oLNZ8hMfCK/ojXQ9ts/GkkEV9/JIH1h
         52zO94yZtKOFq1GTJRoWNduq9QdsIr/QPZKP1dMo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhu Wang <wangzhu9@huawei.com>,
        Narsimhulu Musini <nmusini@cisco.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.10 63/68] scsi: snic: Fix possible memory leak if device_add() fails
Date:   Sun, 13 Aug 2023 23:20:04 +0200
Message-ID: <20230813211710.060470529@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211708.149630011@linuxfoundation.org>
References: <20230813211708.149630011@linuxfoundation.org>
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


