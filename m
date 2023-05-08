Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11F76FA51A
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjEHKGC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjEHKF6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A813014B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAB0B62342
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA30EC433EF;
        Mon,  8 May 2023 10:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540356;
        bh=06uzWRcUqrQiHQFJK3U1WQnr55n65FZQ1Mlg6h1VgoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaWvLF4v93VwyBbpdRSlx46VFQKcnmRSsaf8ZJ0dqTVqUOxt+bO2078cBuTPErujJ
         SzLbyIO2k3fjJMGoshRb6ap+uvH4CGNbwXhA/nmI58dixHgwo7VxOfB7UOWYZL0GKc
         1Eb1fHBG555gH43Mdqfkch8yTICfWKKukTIJKlmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 333/611] nvmet: fix Identify Namespace handling
Date:   Mon,  8 May 2023 11:42:55 +0200
Message-Id: <20230508094433.240919087@linuxfoundation.org>
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

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[ Upstream commit 8c098aa00118c35108f0c19bd3cdc45e11574948 ]

The identify command with cns set to NVME_ID_CNS_NS does not directly
depend on the command set. The NVMe specifications is rather confusing
here as it appears that this command only applies to the NVM command
set. However, footnote 8 of Figure 273 in the NVMe 2.0 base
specifications clearly state that this command applies to NVM command
sets that support logical blocks, that is, NVM and ZNS. Both the NVM and
ZNS command set specifications also list this identify as mandatory.

The command handling should thus not look at the csi field since it is
defined as unused for this command. Given that we do not support the
KV command set, simply remove the csi switch-case for that command
handling and call directly nvmet_execute_identify_ns() in
nvmet_execute_identify().

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
index 76ceaadd6eeaf..d4c6550c5a4a4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -693,13 +693,8 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 
 	switch (req->cmd->identify.cns) {
 	case NVME_ID_CNS_NS:
-		switch (req->cmd->identify.csi) {
-		case NVME_CSI_NVM:
-			return nvmet_execute_identify_ns(req);
-		default:
-			break;
-		}
-		break;
+		nvmet_execute_identify_ns(req);
+		return;
 	case NVME_ID_CNS_CS_NS:
 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 			switch (req->cmd->identify.csi) {
-- 
2.39.2



