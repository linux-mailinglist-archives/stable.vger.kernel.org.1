Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998B27A801B
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjITMc6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbjITMc5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:32:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FD392
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:32:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0DEC433C7;
        Wed, 20 Sep 2023 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213170;
        bh=HxApunOINuhpow4tbXPPK0hWVBAf13PwYBKHLhels3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdhjnIE01o+tZ6PxOqxs/61Rha6LlqhRq+1tmUZaXZS1ZJddM4YO2NZG8mPkKOqPI
         81yEqx6dj3vG33XcLVaQDsBeIDWfLOe6+WKGMdq8WrO9atm036TmV995UH7Uu1oO7C
         n/eWVSTY60FEgXASJuslNqMaMdi1OaDKvBJRbN+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Chris Leech <cleech@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 160/367] scsi: be2iscsi: Add length check when parsing nlattrs
Date:   Wed, 20 Sep 2023 13:28:57 +0200
Message-ID: <20230920112902.792880006@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit ee0268f230f66cb472df3424f380ea668da2749a ]

beiscsi_iface_set_param() parses nlattr with nla_for_each_attr and assumes
every attributes can be viewed as struct iscsi_iface_param_info.

This is not true because there is no any nla_policy to validate the
attributes passed from the upper function iscsi_set_iface_params().

Add the nla_len check before accessing the nlattr data and return EINVAL if
the length check fails.

Fixes: 0e43895ec1f4 ("[SCSI] be2iscsi: adding functionality to change network settings using iscsiadm")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Link: https://lore.kernel.org/r/20230723075938.3713864-1-linma@zju.edu.cn
Reviewed-by: Chris Leech <cleech@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/be2iscsi/be_iscsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index 2058d50d62e12..737d7087723af 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -441,6 +441,10 @@ int beiscsi_iface_set_param(struct Scsi_Host *shost,
 	}
 
 	nla_for_each_attr(attrib, data, dt_len, rm_len) {
+		/* ignore nla_type as it is never used */
+		if (nla_len(attrib) < sizeof(*iface_param))
+			return -EINVAL;
+
 		iface_param = nla_data(attrib);
 
 		if (iface_param->param_type != ISCSI_NET_PARAM)
-- 
2.40.1



