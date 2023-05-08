Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EB96FA7FD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjEHKgx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234783AbjEHKga (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:36:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BC2242C0
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:36:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E89F62798
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73880C433EF;
        Mon,  8 May 2023 10:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542165;
        bh=o1QqK/1hVeCP5ino5z2TFM2sRjZ97XnycTGzsTaU678=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zE/Xj6av09M2Pqw2Y1GwBTayuyvhKiuryA60ZhV1Azxpe7QUSkmbToIZyP0WBfJHR
         lGm7Nbn2NABE8WYswhFm0wh11wvg10RWKX/fuxN05rvwrU4hggU+NqAUmkB2z1MGKY
         PPpa6+Erpz7ijBU4Qhp+WWQoh6pkcQlOiQ67XZ0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Danila Chernetsov <listdansp@mail.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 316/663] scsi: megaraid: Fix mega_cmd_done() CMDID_INT_CMDS
Date:   Mon,  8 May 2023 11:42:22 +0200
Message-Id: <20230508094438.447268997@linuxfoundation.org>
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
index bf491af9f0d65..16e2cf848c6ef 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -1441,6 +1441,7 @@ mega_cmd_done(adapter_t *adapter, u8 completed[], int nstatus, int status)
 		 */
 		if (cmdid == CMDID_INT_CMDS) {
 			scb = &adapter->int_scb;
+			cmd = scb->cmd;
 
 			list_del_init(&scb->list);
 			scb->state = SCB_FREE;
-- 
2.39.2



