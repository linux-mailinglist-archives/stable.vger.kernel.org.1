Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2137A3A3D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbjIQUAe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240373AbjIQUAS (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:00:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF089138
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:00:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EDEC433C7;
        Sun, 17 Sep 2023 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980808;
        bh=DYbHVSOdOaKMpCfD5hGWuQ+CeVwJaSLyb9lGx56xZfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UJg5bldRtu/HgLZ0GhlnfcsKFhirPkGSGZsa9JnzZkz0PGNK2wrFqGpbpQNS5xAe0
         V6M0tW323WZ2i9xguF/jH6zgXEIrcRpbNj3aI0+qBGRz3VOM1IvswmqYYrZiPaKWiw
         1RcosHq9zkd33NbQTG5tb9RZb+psAMt0AC51ncQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quinn Tran <qutran@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.1 014/219] scsi: qla2xxx: fix inconsistent TMF timeout
Date:   Sun, 17 Sep 2023 21:12:21 +0200
Message-ID: <20230917191041.499722397@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quinn Tran <qutran@marvell.com>

commit 009e7fe4a1ed52276b332842a6b6e23b07200f2d upstream.

Different behavior were experienced of session being torn down vs not when
TMF is timed out. When FW detects the time out, the session is torn down.
When driver detects the time out, the session is not torn down.

Allow TMF error to return to upper layer without session tear down.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Link: https://lore.kernel.org/r/20230714070104.40052-10-njavali@marvell.com
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/qla2xxx/qla_isr.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -2539,7 +2539,6 @@ qla24xx_tm_iocb_entry(scsi_qla_host_t *v
 	case CS_PORT_BUSY:
 	case CS_INCOMPLETE:
 	case CS_PORT_UNAVAILABLE:
-	case CS_TIMEOUT:
 	case CS_RESET:
 		if (atomic_read(&fcport->state) == FCS_ONLINE) {
 			ql_dbg(ql_dbg_disc, fcport->vha, 0x3021,


