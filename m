Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3944D6FAE0A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjEHLkd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbjEHLkF (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2BF1FAB9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:40:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F391863448
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61EDC433D2;
        Mon,  8 May 2023 11:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546003;
        bh=uvo1swOl0IwUn84x7tsZ4FrxpjHpHgyDDF8igUS5Tm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXQ0hOHn+7q4AT4397GBN4SrGvDnu/GXBJmf/G6+MTwIYl5qWXwQJ6NBdadZ8Gb/d
         UXfPT1hHT+dBGsgwqMbIh4JczoSgfwiC5oVyqwubMWqH3sc+zT2nzMSIQmYmh/wFpE
         0bBYfexA5cgGVGA98LB79wAOHmL+V0CEyx8UEGuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 196/371] nvmet: fix Identify Active Namespace ID list handling
Date:   Mon,  8 May 2023 11:46:37 +0200
Message-Id: <20230508094819.898456443@linuxfoundation.org>
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

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[ Upstream commit 97416f67d55fb8b866ff1815ca7ef26b6dfa6a5e ]

The identify command with cns set to NVME_ID_CNS_NS_ACTIVE_LIST does
not depend on the command set. The execution of this command should
thus not look at the csi field specified in the command. Simplify
nvmet_execute_identify() to directly call
nvmet_execute_identify_nslist() without the csi switch-case.

Fixes: ab5d0b38c047 ("nvmet: add Command Set Identifier support")
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0638be507a645..2b8227259786c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -713,13 +713,8 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		}
 		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
-		switch (req->cmd->identify.csi) {
-		case NVME_CSI_NVM:
-			return nvmet_execute_identify_nslist(req);
-		default:
-			break;
-		}
-		break;
+		nvmet_execute_identify_nslist(req);
+		return;
 	case NVME_ID_CNS_NS_DESC_LIST:
 		if (nvmet_handle_identify_desclist(req) == true)
 			return;
-- 
2.39.2



