Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C27757AC
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjHIKsr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjHIKsq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:48:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EBF10F3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05AA56310A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE414C433D9;
        Wed,  9 Aug 2023 10:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578125;
        bh=1g4NKE7ziG5yB3fVf2fTsDUzYjCajxUhRMOqE15E93E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1h5rTCje9bNJyChu0Kal3OrqU6AqzPKQDQmv90Wf/b9AMLAuRCzphYTz7OSB0Ct3I
         ceJ+yxDJUaafulVEm4Wh8Eu6+aCIFJrrhze9/6du8Ex9B2lulowDK4BeiJuhd1LrF1
         /XViTnWm4c5weDgOSG4utdepr8HXtttn8v+WH38g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Block <bblock@linux.ibm.com>,
        Fedor Loshakov <loshakov@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.4 097/165] scsi: zfcp: Defer fc_rport blocking until after ADISC response
Date:   Wed,  9 Aug 2023 12:40:28 +0200
Message-ID: <20230809103645.952154656@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Steffen Maier <maier@linux.ibm.com>

commit e65851989001c0c9ba9177564b13b38201c0854c upstream.

Storage devices are free to send RSCNs, e.g. for internal state changes. If
this happens on all connected paths, zfcp risks temporarily losing all
paths at the same time. This has strong requirements on multipath
configuration such as "no_path_retry queue".

Avoid such situations by deferring fc_rport blocking until after the ADISC
response, when any actual state change of the remote port became clear.
The already existing port recovery triggers explicitly block the fc_rport.
The triggers are: on ADISC reject or timeout (typical cable pull case), and
on ADISC indicating that the remote port has changed its WWPN or
the port is meanwhile no longer open.

As a side effect, this also removes a confusing direct function call to
another work item function zfcp_scsi_rport_work() instead of scheduling
that other work item. It was probably done that way to have the rport block
side effect immediate and synchronous to the caller.

Fixes: a2fa0aede07c ("[SCSI] zfcp: Block FC transport rports early on errors")
Cc: stable@vger.kernel.org #v2.6.30+
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Fedor Loshakov <loshakov@linux.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Link: https://lore.kernel.org/r/20230724145156.3920244-1-maier@linux.ibm.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/scsi/zfcp_fc.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -534,8 +534,7 @@ static void zfcp_fc_adisc_handler(void *
 
 	/* re-init to undo drop from zfcp_fc_adisc() */
 	port->d_id = ntoh24(adisc_resp->adisc_port_id);
-	/* port is good, unblock rport without going through erp */
-	zfcp_scsi_schedule_rport_register(port);
+	/* port is still good, nothing to do */
  out:
 	atomic_andnot(ZFCP_STATUS_PORT_LINK_TEST, &port->status);
 	put_device(&port->dev);
@@ -595,9 +594,6 @@ void zfcp_fc_link_test_work(struct work_
 	int retval;
 
 	set_worker_desc("zadisc%16llx", port->wwpn); /* < WORKER_DESC_LEN=24 */
-	get_device(&port->dev);
-	port->rport_task = RPORT_DEL;
-	zfcp_scsi_rport_work(&port->rport_work);
 
 	/* only issue one test command at one time per port */
 	if (atomic_read(&port->status) & ZFCP_STATUS_PORT_LINK_TEST)


