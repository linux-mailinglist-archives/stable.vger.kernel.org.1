Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A977A3C2B
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240929AbjIQU1r (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239691AbjIQU1b (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:27:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9008B10F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:27:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2EC433C7;
        Sun, 17 Sep 2023 20:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982442;
        bh=m9BRi6XnsLGUROcWSlO5y8XGYmviE3/tNj5b9ltwsT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hRYDlI0ouY8T1HuJYMktF39rUFc+7xEFdZ9DhMZYL/Ynd9DZqwmqRG89Of8ORzIhK
         UiKW0bgehEHf1YZKmqDsOhOZIykSAK5x0jrPtfStugai6/zXpDrzztkpbHPZpZMPPH
         mJBjuqeCMtLqK2khZDRMOeoOfpndPuRQTVmWVcW8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wenchao Hao <haowenchao@huawei.com>,
        Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 252/511] scsi: iscsi: Rename iscsi_set_param() to iscsi_if_set_param()
Date:   Sun, 17 Sep 2023 21:11:19 +0200
Message-ID: <20230917191119.907710486@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenchao Hao <haowenchao@huawei.com>

[ Upstream commit 0c26a2d7c98039e913e63f9250fde738a3f88a60 ]

There are two iscsi_set_param() functions defined in libiscsi.c and
scsi_transport_iscsi.c respectively which is confusing.

Rename the one in scsi_transport_iscsi.c to iscsi_if_set_param().

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Link: https://lore.kernel.org/r/20221122181105.4123935-1-haowenchao@huawei.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Stable-dep-of: 971dfcb74a80 ("scsi: iscsi: Add length check for nlattr payload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_transport_iscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 4d23e5af20d30..2d237246281fb 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -3034,7 +3034,7 @@ iscsi_if_destroy_conn(struct iscsi_transport *transport, struct iscsi_uevent *ev
 }
 
 static int
-iscsi_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
+iscsi_if_set_param(struct iscsi_transport *transport, struct iscsi_uevent *ev)
 {
 	char *data = (char*)ev + sizeof(*ev);
 	struct iscsi_cls_conn *conn;
@@ -3988,7 +3988,7 @@ iscsi_if_recv_msg(struct sk_buff *skb, struct nlmsghdr *nlh, uint32_t *group)
 			err = -EINVAL;
 		break;
 	case ISCSI_UEVENT_SET_PARAM:
-		err = iscsi_set_param(transport, ev);
+		err = iscsi_if_set_param(transport, ev);
 		break;
 	case ISCSI_UEVENT_CREATE_CONN:
 	case ISCSI_UEVENT_DESTROY_CONN:
-- 
2.40.1



