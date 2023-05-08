Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912A76FA51C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbjEHKGE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjEHKGD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:06:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E10B30446
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E58526233D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029DAC433D2;
        Mon,  8 May 2023 10:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540361;
        bh=Aq/d4i+GK5DvfiAcJnUegvuKHf+jHkitvqjRI7ykFak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eiBsHsrJg3YIApWH3s9O8Lkl6JRlcC8ZWJSvgNvEm2QmCgk/WkfjJsuU5OIFIjcTf
         vA/3MSW7fp3bBphZBo+ZbFQdo1KgbXP0DuNefxmeqGqHo969V6YbKTcg9aK067YsnV
         GDTDEleikzl50YuzWrngY+WPtZ7ige9uhqbCkdvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 335/611] nvmet: fix Identify Active Namespace ID list handling
Date:   Mon,  8 May 2023 11:42:57 +0200
Message-Id: <20230508094433.307995485@linuxfoundation.org>
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
index ea7ad4617f6e9..d414269756c82 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -719,13 +719,8 @@ static void nvmet_execute_identify(struct nvmet_req *req)
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



