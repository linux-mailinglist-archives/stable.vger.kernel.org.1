Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5F75D1A2
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjGUSvJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGUSvH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDD130CF
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A66F9619FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:51:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7802C433CA;
        Fri, 21 Jul 2023 18:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965466;
        bh=gkB3REGsF5o97wgZvMRxcjRg28/5XzpN7gib3dDo0Ew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPyOYNN+07VNbycLSP+Yfvmgy5q1C+ly1UrcaGL+4FgD17T4llU5t5EeP0WfirZuH
         9n9859gzUIM5bAd8iSgFyErPKNBkZN7zdX8YhdfbJwkC86twUBOJ+BYUKIqYwaZmy2
         9Qt+GJMynolpr43ptg7cS4f6QD8TRmG8B4dwsHIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.4 283/292] scsi: qla2xxx: Fix buffer overrun
Date:   Fri, 21 Jul 2023 18:06:32 +0200
Message-ID: <20230721160541.125804754@linuxfoundation.org>
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

From: Quinn Tran <qutran@marvell.com>

commit b68710a8094fdffe8dd4f7a82c82649f479bb453 upstream.

Klocwork warning: Buffer Overflow - Array Index Out of Bounds

Driver uses fc_els_flogi to calculate size of buffer.  The actual buffer is
nested inside of fc_els_flogi which is smaller.

Replace structure name to allow proper size calculation.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230607113843.37185-6-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5549,7 +5549,7 @@ static void qla_get_login_template(scsi_
 	__be32 *q;
 
 	memset(ha->init_cb, 0, ha->init_cb_size);
-	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
+	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
 	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
 					    ha->init_cb, sz);
 	if (rval != QLA_SUCCESS) {


