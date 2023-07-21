Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38A675CA65
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjGUOnp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGUOnp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D72F0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:43:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E159061CB7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 14:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2577C433C8;
        Fri, 21 Jul 2023 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689950623;
        bh=RH/h1gL4MtliqdYe8WScLLWXrbwNWz9VfFcoHQTiZSc=;
        h=Subject:To:Cc:From:Date:From;
        b=0g0NSx4HO7pQiU/R4Vv7KkXV430jZ6Wf9ogD1gYtmXBQCtWMimGOW3U5p0temKZp/
         AWBXSTseAqO8PzBbstC2cRSG0+X0VtRpWbse65Q+zD0vfUIMQZPcQWcU9FoV34B0Me
         yWBe18fnUOx37UmewcBClnfMos3VR2e9AMwA5kw0=
Subject: FAILED: patch "[PATCH] scsi: qla2xxx: Fix buffer overrun" failed to apply to 4.14-stable tree
To:     qutran@marvell.com, himanshu.madhani@oracle.com,
        martin.petersen@oracle.com, njavali@marvell.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 16:43:25 +0200
Message-ID: <2023072125-washbowl-subtitle-bab2@gregkh>
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
git cherry-pick -x b68710a8094fdffe8dd4f7a82c82649f479bb453
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072125-washbowl-subtitle-bab2@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

b68710a8094f ("scsi: qla2xxx: Fix buffer overrun")
44f5a37d1e3e ("scsi: qla2xxx: Fix buffer-buffer credit extraction error")
897d68eb816b ("scsi: qla2xxx: Fix WARN_ON in qla_nvme_register_hba")
9f2475fe7406 ("scsi: qla2xxx: SAN congestion management implementation")
62e9dd177732 ("scsi: qla2xxx: Change in PUREX to handle FPIN ELS requests")
818dbde78e0f ("Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b68710a8094fdffe8dd4f7a82c82649f479bb453 Mon Sep 17 00:00:00 2001
From: Quinn Tran <qutran@marvell.com>
Date: Wed, 7 Jun 2023 17:08:40 +0530
Subject: [PATCH] scsi: qla2xxx: Fix buffer overrun

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

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 0df6eae7324e..b0225f6f3221 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5549,7 +5549,7 @@ static void qla_get_login_template(scsi_qla_host_t *vha)
 	__be32 *q;
 
 	memset(ha->init_cb, 0, ha->init_cb_size);
-	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
+	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
 	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
 					    ha->init_cb, sz);
 	if (rval != QLA_SUCCESS) {

