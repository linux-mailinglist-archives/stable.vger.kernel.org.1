Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCCC7B8889
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244103AbjJDSRE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244057AbjJDSQ5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:16:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA8FBF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:16:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FD5C433C7;
        Wed,  4 Oct 2023 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443412;
        bh=h7vIKCIBGv+4k/APfsTCw1MdSwQX//aC1t8/vtuGX3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wd8Gf9N7gtFiMuQXR9HejnoUf8EnVOEonDACIvS7vsLxCRot1FRM1IkKZBLTqoy+t
         +pqqgSoiWIIrlWyT82KohoS51HOf+7qamapQecVyJqEIsU/6p5rdwCMUPwU0Oou9DG
         PmOTq3WRfvyGZtbKutFEd/1/ibUEDuGiUEmfu+I8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nigel Kirkland <nkirkland2304@gmail.com>,
        James Smart <jsmart2021@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 147/259] nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()
Date:   Wed,  4 Oct 2023 19:55:20 +0200
Message-ID: <20231004175224.054815931@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

From: Nigel Kirkland <nkirkland2304@gmail.com>

[ Upstream commit 8ae5b3a685dc59a8cf7ccfe0e850999ba9727a3c ]

The nvme_fc_fcp_op structure describing an AEN operation is initialized with a
null request structure pointer. An FC LLDD may make a call to
nvme_fc_io_getuuid passing a pointer to an nvmefc_fcp_req for an AEN operation.

Add validation of the request structure pointer before dereference.

Signed-off-by: Nigel Kirkland <nkirkland2304@gmail.com>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6c3d469eed7e3..177a365b8ec55 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1911,7 +1911,7 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
 	struct request *rq = op->rq;
 
-	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
+	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq || !rq->bio)
 		return NULL;
 	return blkcg_get_fc_appid(rq->bio);
 }
-- 
2.40.1



