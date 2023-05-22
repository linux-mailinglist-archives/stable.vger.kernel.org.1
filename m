Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00F70C8CA
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbjEVTmP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjEVTmM (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C63F1708
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2757362A20
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D04C433EF;
        Mon, 22 May 2023 19:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784506;
        bh=7WQMsDnkLJaAHW6RZwpPou3kFutnRgwSnTU7HM1QZHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLHQI98761FAHg0NMkTIiUs4KhB2nFExAQpZorHiNOfZxJesf1H2VRXNhGR5ERdzo
         DWVXPsp8//2jv0j/qOdxxlUvsM1UjoHp94zMHA2NaiHe4nsgV9JwKXTaJeNGAZw5vE
         nlKkZoE3gszLmm6UT0iwxVOTR7p4DN7H2BjRRv3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Forza <forza@tnonline.net>,
        Dmitry Bogdanov <d.bogdanov@yadro.com>,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 104/364] scsi: target: iscsit: Free cmds before session free
Date:   Mon, 22 May 2023 20:06:49 +0100
Message-Id: <20230522190415.360845252@linuxfoundation.org>
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

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

[ Upstream commit d8990b5a4d065f38f35d69bcd627ec5a7f8330ca ]

Commands from recovery entries are freed after session has been closed.
That leads to use-after-free at command free or NPE with such call trace:

Time2Retain timer expired for SID: 1, cleaning up iSCSI session.
BUG: kernel NULL pointer dereference, address: 0000000000000140
RIP: 0010:sbitmap_queue_clear+0x3a/0xa0
Call Trace:
 target_release_cmd_kref+0xd1/0x1f0 [target_core_mod]
 transport_generic_free_cmd+0xd1/0x180 [target_core_mod]
 iscsit_free_cmd+0x53/0xd0 [iscsi_target_mod]
 iscsit_free_connection_recovery_entries+0x29d/0x320 [iscsi_target_mod]
 iscsit_close_session+0x13a/0x140 [iscsi_target_mod]
 iscsit_check_post_dataout+0x440/0x440 [iscsi_target_mod]
 call_timer_fn+0x24/0x140

Move cleanup of recovery enrties to before session freeing.

Reported-by: Forza <forza@tnonline.net>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Link: https://lore.kernel.org/r/20230319015620.96006-7-michael.christie@oracle.com
Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 3f7a9f7f5f4e3..07e196b44b91d 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4531,6 +4531,9 @@ int iscsit_close_session(struct iscsit_session *sess, bool can_sleep)
 	iscsit_stop_time2retain_timer(sess);
 	spin_unlock_bh(&se_tpg->session_lock);
 
+	if (sess->sess_ops->ErrorRecoveryLevel == 2)
+		iscsit_free_connection_recovery_entries(sess);
+
 	/*
 	 * transport_deregister_session_configfs() will clear the
 	 * struct se_node_acl->nacl_sess pointer now as a iscsi_np process context
@@ -4554,9 +4557,6 @@ int iscsit_close_session(struct iscsit_session *sess, bool can_sleep)
 
 	transport_deregister_session(sess->se_sess);
 
-	if (sess->sess_ops->ErrorRecoveryLevel == 2)
-		iscsit_free_connection_recovery_entries(sess);
-
 	iscsit_free_all_ooo_cmdsns(sess);
 
 	spin_lock_bh(&se_tpg->session_lock);
-- 
2.39.2



