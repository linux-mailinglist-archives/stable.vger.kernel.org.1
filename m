Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06EC6FADC8
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235944AbjEHLiJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjEHLhy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C940C2DD5E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A91EA63372
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B0C433EF;
        Mon,  8 May 2023 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545836;
        bh=tlBL5eAyzhc85dbQWz/9IbJLu6EJUFszUcMny6Lk7fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2EXZ0GwdxRfUFATIMP/zZVim3O0ReleE1k15UZFd0Vk+EB6yMyJPt9MqbZ+9s4v2
         KBh61DfRkGImcRjoTm6yKUYrvvOINyYa5gGsHxm//6nFm75L6lLZeGlyP9ELENzU7/
         4SJN82n+6MRHtRAHNkqtzvZkLAV8VuY9fOpyX7lM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danila Chernetsov <listdansp@mail.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 170/371] scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS
Date:   Mon,  8 May 2023 11:46:11 +0200
Message-Id: <20230508094818.880537541@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Danila Chernetsov <listdansp@mail.ru>

[ Upstream commit 75cb113cd43f06aaf4f1bda0069cfd5b98e909eb ]

When cmdid == CMDID_INT_CMDS, the 'cmds' pointer is NULL but is
dereferenced below.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0f2bb84d2a68 ("[SCSI] megaraid: simplify internal command handling")
Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
Link: https://lore.kernel.org/r/20230317175109.18585-1-listdansp@mail.ru
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index 7dd6dd74d2bc2..6122cc60a8b3d 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1443,6 +1443,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 		 */
 		if (cmdid == CMDID_INT_CMDS) {
 			scb = &adapter->int_scb;
+			cmd = scb->cmd;
 
 			list_del_init(&scb->list);
 			scb->state = SCB_FREE;
-- 
2.39.2



