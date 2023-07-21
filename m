Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4421075CA5D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGUOnH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjGUOm4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:42:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F3E30C7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:42:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B05F761CC7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F56C433C7;
        Fri, 21 Jul 2023 14:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950574;
        bh=ZHtWEenhzcxhnffYuWhlyAyrCVpp0SdGHpqHhzz9NPE=;
        h=Subject:To:Cc:From:Date:From;
        b=U1/6USH5K/4JQ8lHVqgLkfyS1VV70itnlvfyJ4URGJwT6+1fJf0Zymer78ReTS80x
         QqPl9M3TgwCaiLzWHJXZJ55ep2iUjzgs85sPWaJMM2eg582Ry6gYD4uxdNkC0dfn0y
         q8Y4ZMDYn86VWX2x1ViklfGdxZJWi1CJRuMsDeVw=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Array index may go out of bound" failed to apply to 4.14-stable tree
To:     njavali@marvell.com, bhazarika@marvell.com,
        himanshu.madhani@oracle.com, martin.petersen@oracle.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:42:41 +0200
Message-ID: <2023072141-freezable-tactical-2c4a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x d721b591b95cf3f290f8a7cbe90aa2ee0368388d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072141-freezable-tactical-2c4a@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

d721b591b95c ("scsi: qla2xxx: Array index may go out of bound")
250bd00923c7 ("scsi: qla2xxx: Fix inconsistent format argument type in qla_os.c")
a4239945b8ad ("scsi: qla2xxx: Add switch command to simplify fabric discovery")
9cd883f07a54 ("scsi: qla2xxx: Fix session cleanup for N2N")
82abdcaf3ede ("scsi: qla2xxx: Allow target mode to accept PRLI in dual mode")
11aea16ab3f5 ("scsi: qla2xxx: Add ability to send PRLO")
9b3e0f4d4147 ("scsi: qla2xxx: Move work element processing out of DPC thread")
f13515acdcb5 ("scsi: qla2xxx: Replace GPDB with async ADISC command")
2853192e154b ("scsi: qla2xxx: Use IOCB path to submit Control VP MBX command")
4005a995668b ("scsi: qla2xxx: Fix Relogin being triggered too fast")
5ef696aa9f3c ("scsi: qla2xxx: Relogin to target port on a cable swap")
414d9ff3f803 ("scsi: qla2xxx: Fix login state machine stuck at GPDB")
2d73ac6102d9 ("scsi: qla2xxx: Serialize GPNID for multiple RSCN")
25ad76b703d9 ("scsi: qla2xxx: Retry switch command on time out")
a084fd68e1d2 ("scsi: qla2xxx: Fix re-login for Nport Handle in use")
a01c77d2cbc4 ("scsi: qla2xxx: Move session delete to driver work queue")
2d57b5efda51 ("scsi: qla2xxx: Query FC4 type during RSCN processing")
edd05de19759 ("scsi: qla2xxx: Changes to support N2N logins")
c0c462c8a061 ("scsi: qla2xxx: Allow MBC_GET_PORT_DATABASE to query and save the port states")
08eb7f45de61 ("scsi: qla2xxx: Cocci spatch "pool_zalloc-simple"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d721b591b95cf3f290f8a7cbe90aa2ee0368388d Mon Sep 17 00:00:00 2001
From: Nilesh Javali <njavali@marvell.com>
Date: Wed, 7 Jun 2023 17:08:36 +0530
Subject: [PATCH] scsi: qla2xxx: Array index may go out of bound

Klocwork reports array 'vha->host_str' of size 16 may use index value(s)
16..19.  Use snprintf() instead of sprintf().

Cc: stable@vger.kernel.org
Co-developed-by: Bikash Hazarika <bhazarika@marvell.com>
Signed-off-by: Bikash Hazarika <bhazarika@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230607113843.37185-2-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index bc89d3da8fd0..3bace9ea6288 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -5088,7 +5088,8 @@ struct scsi_qla_host *qla2x00_create_host(const struct scsi_host_template *sht,
 	}
 	INIT_DELAYED_WORK(&vha->scan.scan_work, qla_scan_work_fn);
 
-	sprintf(vha->host_str, "%s_%lu", QLA2XXX_DRIVER_NAME, vha->host_no);
+	snprintf(vha->host_str, sizeof(vha->host_str), "%s_%lu",
+		 QLA2XXX_DRIVER_NAME, vha->host_no);
 	ql_dbg(ql_dbg_init, vha, 0x0041,
 	    "Allocated the host=%p hw=%p vha=%p dev_name=%s",
 	    vha->host, vha->hw, vha,

