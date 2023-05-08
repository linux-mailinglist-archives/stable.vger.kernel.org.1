Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3F6FA4EC
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbjEHKEe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjEHKEb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:04:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1263930164
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BAFD6231E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAA1C433EF;
        Mon,  8 May 2023 10:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540269;
        bh=NmQ9S07EWOcHjHpT33NuPI/wRgG+XzcY4Cfz1QHexdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7aMEiP9jtYYwWox/2S/8X+gZvDZiUOCWDdH5LFDBIvQsJUw0EnqkHLDS35WqYw1j
         t4MjPjOYJ7NBKjLvLLwBxt6634ASqnLHkkPwM0VFTZk1xUMirMvrvBI4zuYNKsjODQ
         CZjujx4oyT71TBPLrgyoPCKDkToOMJ83C5/+b++o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 300/611] scsi: target: iscsit: Fix TAS handling during conn cleanup
Date:   Mon,  8 May 2023 11:42:22 +0200
Message-Id: <20230508094432.159030458@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

[ Upstream commit cc79da306ebb2edb700c3816b90219223182ac3c ]

Fix a bug added in commit f36199355c64 ("scsi: target: iscsi: Fix cmd abort
fabric stop race").

If CMD_T_TAS is set on the se_cmd we must call iscsit_free_cmd() to do the
last put on the cmd and free it, because the connection is down and we will
not up sending the response and doing the put from the normal I/O
path.

Add a check for CMD_T_TAS in iscsit_release_commands_from_conn() so we now
detect this case and run iscsit_free_cmd().

Fixes: f36199355c64 ("scsi: target: iscsi: Fix cmd abort fabric stop race")
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Link: https://lore.kernel.org/r/20230319015620.96006-9-michael.christie@oracle.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 83b0071412294..3f7a9f7f5f4e3 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4220,9 +4220,12 @@ static void iscsit_release_commands_from_conn(struct iscsit_conn *conn)
 	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_list, i_conn_node) {
 		struct se_cmd *se_cmd = &cmd->se_cmd;
 
-		if (se_cmd->se_tfo != NULL) {
-			spin_lock_irq(&se_cmd->t_state_lock);
-			if (se_cmd->transport_state & CMD_T_ABORTED) {
+		if (!se_cmd->se_tfo)
+			continue;
+
+		spin_lock_irq(&se_cmd->t_state_lock);
+		if (se_cmd->transport_state & CMD_T_ABORTED) {
+			if (!(se_cmd->transport_state & CMD_T_TAS))
 				/*
 				 * LIO's abort path owns the cleanup for this,
 				 * so put it back on the list and let
@@ -4230,11 +4233,10 @@ static void iscsit_release_commands_from_conn(struct iscsit_conn *conn)
 				 */
 				list_move_tail(&cmd->i_conn_node,
 					       &conn->conn_cmd_list);
-			} else {
-				se_cmd->transport_state |= CMD_T_FABRIC_STOP;
-			}
-			spin_unlock_irq(&se_cmd->t_state_lock);
+		} else {
+			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
 		}
+		spin_unlock_irq(&se_cmd->t_state_lock);
 	}
 	spin_unlock_bh(&conn->cmd_lock);
 
-- 
2.39.2



