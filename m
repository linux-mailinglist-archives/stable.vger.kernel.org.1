Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA57070CA0C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjEVTyY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjEVTyY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:54:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452C895
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:54:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2DB662B68
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50B4C433EF;
        Mon, 22 May 2023 19:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785262;
        bh=jI3ffsR6MUaqjplfpOOioCascQGWN2tvgN+A2cRPa6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YKgTaHpjAhQnOwBteteB2km0SYFV/E3C3Dk8mb6YpLq/HLC3WFNNS3sGs0ap+Ju5N
         IiVJKTyUTyXFPykp6sRREEw1swyKmNrBBu0tz/2mLyS7PcNcADO2RFTaKan6y46YJt
         uW+quxoLsG2ZG85vjnodw6FJsvJvggrVkRvpUQkw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wenchao Hao <haowenchao2@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.3 364/364] scsi: Revert "scsi: core: Do not increase scsi_devices iorequest_cnt if dispatch failed"
Date:   Mon, 22 May 2023 20:11:09 +0100
Message-Id: <20230522190421.868093897@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wenchao Hao <haowenchao2@huawei.com>

commit 6ca9818d1624e136a76ae8faedb6b6c95ca66903 upstream.

The "atomic_inc(&cmd->device->iorequest_cnt)" in scsi_queue_rq() would
cause kernel panic because cmd->device may be freed after returning from
scsi_dispatch_cmd().

This reverts commit cfee29ffb45b1c9798011b19d454637d1b0fe87d.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Reported-by: Ming Lei <ming.lei@redhat.com>
Closes: https://lore.kernel.org/r/ZF+zB+bB7iqe0wGd@ovpn-8-17.pek2.redhat.com
Link: https://lore.kernel.org/r/20230515070156.1790181-2-haowenchao2@huawei.com
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_lib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1463,6 +1463,8 @@ static int scsi_dispatch_cmd(struct scsi
 	struct Scsi_Host *host = cmd->device->host;
 	int rtn = 0;
 
+	atomic_inc(&cmd->device->iorequest_cnt);
+
 	/* check if the device is still usable */
 	if (unlikely(cmd->device->sdev_state == SDEV_DEL)) {
 		/* in SDEV_DEL we error all commands. DID_NO_CONNECT
@@ -1761,7 +1763,6 @@ static blk_status_t scsi_queue_rq(struct
 		goto out_dec_host_busy;
 	}
 
-	atomic_inc(&cmd->device->iorequest_cnt);
 	return BLK_STS_OK;
 
 out_dec_host_busy:


