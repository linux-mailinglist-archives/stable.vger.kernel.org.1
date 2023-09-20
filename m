Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA37A7E05
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbjITMOf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjITMOf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:14:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29C993
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:14:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EE3C433C8;
        Wed, 20 Sep 2023 12:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212069;
        bh=swkpIMDzSku8yOJzRGNGfoLS174qVrmT25jCQv21YvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCB1IBQGKYB6OlMa7XWwQUB7H0Aoq8sc6w6S88zkHItEt7YzNunsdNzY+BeVvKdku
         pJ573SaoimWwL2Idtg5wyMSQzp5ipwIKneEDSewy/n9sm6SL7baYi5nPvuYhRhwgsN
         oFAtI17edYV2w4h/ZloLWqL5KilPVpwFmfgTRWGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Chris Leech <cleech@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 140/273] scsi: be2iscsi: Add length check when parsing nlattrs
Date:   Wed, 20 Sep 2023 13:29:40 +0200
Message-ID: <20230920112850.853613967@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index c8f0a2144b443..818a690771e05 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -445,6 +445,10 @@ int beiscsi_iface_set_param(struct Scsi_Host *shost,
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



