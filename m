Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75E46FA7EC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234832AbjEHKgO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjEHKfp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:35:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EE5828AA4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E58D6273F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4A0C433D2;
        Mon,  8 May 2023 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542113;
        bh=bv3cQEKRrqQvoSzswDMpHsDUglDuCdGu7wMDyGPuyf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2DwAxCGwZSYf2FaqZB+CvNjFoI/UslSNlHaL7qMzvD4DqcOMVXISWems8CraXTxp
         nVpUJYKJHW3TAF4kPcZSOm10tZIAgXHaAgYSVWvKOL1jsxKpjbqc+F6wjVy36VyRPK
         DZXcADR1p2+1hEg7FfMhDdO4CibzrSJjpq/4pWvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 313/663] scsi: target: iscsit: Stop/wait on cmds during conn close
Date:   Mon,  8 May 2023 11:42:19 +0200
Message-Id: <20230508094438.346750996@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 395cee83d02de3073211b04fc85724f4abc663ad ]

This fixes a bug added in commit f36199355c64 ("scsi: target: iscsi: Fix
cmd abort fabric stop race").

If we have multiple sessions to the same se_device we can hit a race where
a LUN_RESET on one session cleans up the se_cmds from under another
session which is being closed. This results in the closing session freeing
its conn/session structs while they are still in use.

The bug is:

 1. Session1 has IO se_cmd1.

 2. Session2 can also have se_cmds for I/O and optionally TMRs for ABORTS
    but then gets a LUN_RESET.

 3. The LUN_RESET on session2 sees the se_cmds on session1 and during the
    drain stages marks them all with CMD_T_ABORTED.

 4. session1 is now closed so iscsit_release_commands_from_conn() only sees
    se_cmds with the CMD_T_ABORTED bit set and returns immediately even
    though we have outstanding commands.

 5. session1's connection and session are freed.

 6. The backend request for se_cmd1 completes and it accesses the freed
    connection/session.

This hooks the iscsit layer into the cmd counter code, so we can wait for
all outstanding se_cmds before freeing the connection.

Fixes: f36199355c64 ("scsi: target: iscsi: Fix cmd abort fabric stop race")
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Link: https://lore.kernel.org/r/20230319015620.96006-6-michael.christie@oracle.com
Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 11115c2078446..83b0071412294 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4245,6 +4245,16 @@ static void iscsit_release_commands_from_conn(struct iscsit_conn *conn)
 		iscsit_free_cmd(cmd, true);
 
 	}
+
+	/*
+	 * Wait on commands that were cleaned up via the aborted_task path.
+	 * LLDs that implement iscsit_wait_conn will already have waited for
+	 * commands.
+	 */
+	if (!conn->conn_transport->iscsit_wait_conn) {
+		target_stop_cmd_counter(conn->cmd_cnt);
+		target_wait_for_cmds(conn->cmd_cnt);
+	}
 }
 
 static void iscsit_stop_timers_for_cmds(
-- 
2.39.2



