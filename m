Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490AA75D1A3
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjGUSvL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGUSvK (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:51:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA9B30CA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70502619FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849BAC433C7;
        Fri, 21 Jul 2023 18:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965468;
        bh=uaIbwgGTIwlDkwrwNfOQpJkRm4Y2mcnvNXXyprB9IeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYil8hPfsi5MjG1fVxWmQIthlpVX4W8nO6cdhPEeM23Cpvf+/Mp2rEzCAzq7qM/kB
         rrnvBduzBiHlVxx8c39zJ9rIdOlmUf4r0lCp4KLKHkfLX7UNTwv547a0pM+8h3A4gj
         d8e18QYpieE6iO8aBTNfepge24xEepD8l/gvj9KI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bikash Hazarika <bhazarika@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.4 284/292] scsi: qla2xxx: Fix potential NULL pointer dereference
Date:   Fri, 21 Jul 2023 18:06:33 +0200
Message-ID: <20230721160541.167521547@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bikash Hazarika <bhazarika@marvell.com>

commit 464ea494a40c6e3e0e8f91dd325408aaf21515ba upstream.

Klocwork tool reported 'cur_dsd' may be dereferenced.  Add fix to validate
pointer before dereferencing the pointer.

Cc: stable@vger.kernel.org
Signed-off-by: Bikash Hazarika <bhazarika@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230607113843.37185-3-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -607,7 +607,8 @@ qla24xx_build_scsi_type_6_iocbs(srb_t *s
 	put_unaligned_le32(COMMAND_TYPE_6, &cmd_pkt->entry_type);
 
 	/* No data transfer */
-	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE) {
+	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE ||
+	    tot_dsds == 0) {
 		cmd_pkt->byte_count = cpu_to_le32(0);
 		return 0;
 	}


