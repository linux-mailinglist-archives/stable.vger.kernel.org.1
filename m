Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7B475D4EA
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjGUT01 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjGUT00 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F47359B
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:26:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EA1061B24
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33386C433CB;
        Fri, 21 Jul 2023 19:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967574;
        bh=D1vyrXCKBB0Cen5pA0p1h4NYP5nKPSdRyrIGJRgpGAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqnfgKqLSPyhRUlUSQdECHdbDh8L8lQbTtY7JD+ruWqvtsofSn01hPVkprvDX/5Zc
         937KND7eYDYLNUBQRA7s+UXqJYt0BCJGCpoN2Jozx2t33dVpDW2FiVHct0ImDg7mUq
         I9CkDHOCqCGdCl9Z9yBBysx+FVgnWinyhz+S2JRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bikash Hazarika <bhazarika@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 211/223] scsi: qla2xxx: Array index may go out of bound
Date:   Fri, 21 Jul 2023 18:07:44 +0200
Message-ID: <20230721160529.867617018@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nilesh Javali <njavali@marvell.com>

commit d721b591b95cf3f290f8a7cbe90aa2ee0368388d upstream.

Klocwork reports array 'vha->host_str' of size 16 may use index value(s)
16..19.  Use snprintf() instead of sprintf().

Cc: stable@vger.kernel.org
Co-developed-by: Bikash Hazarika <bhazarika@marvell.com>
Signed-off-by: Bikash Hazarika <bhazarika@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230607113843.37185-2-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_os.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5074,7 +5074,8 @@ struct scsi_qla_host *qla2x00_create_hos
 	}
 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
 
-	sprintf(vha->host_str, "%s_%lu", QLA2XXX_DRIVER_NAME, vha->host_no);
+	snprintf(vha->host_str, sizeof(vha->host_str), "%s_%lu",
+		 QLA2XXX_DRIVER_NAME, vha->host_no);
 	ql_dbg(ql_dbg_init, vha, 0x0041,
 	    "Allocated the host=%p hw=%p vha=%p dev_name=%s",
 	    vha->host, vha->hw, vha,


