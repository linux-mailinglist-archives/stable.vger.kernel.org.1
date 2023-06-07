Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BF726D23
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjFGUjk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjFGUjZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC0C2D60
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797B063C18
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DF9C433EF;
        Wed,  7 Jun 2023 20:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170330;
        bh=yApZuqIbofxMYM5DrfnV9eiNQQefv/T/16Of+jCksHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uEXEwFWiuTHg7sG0nCgpGprBp37CfWxxKSlctK1oY6ykAA4/dyNCndVESXY85lW1h
         4Lv7uEQ10QKP/Wy/OrwIOTEDSShix9Uf/xk7CmfxAjbhWmPxqz+I+dZ5qVwtomhN9p
         mDpJqLTBd5gtuD9OD3e8Tt1hfIL8IQ3ZCSMlVK7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Alan Adamson <alan.adamson@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 043/225] nvme: fix the name of Zone Append for verbose logging
Date:   Wed,  7 Jun 2023 22:13:56 +0200
Message-ID: <20230607200915.768032139@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 856303797724d28f1d65b702f0eadcee1ea7abf5 ]

No Management involved in Zone Appened.

Fixes: bd83fe6f2cd2 ("nvme: add verbose error logging")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/constants.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index e958d50155857..5766ceba2fec9 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -21,7 +21,7 @@ static const char * const nvme_ops[] = {
 	[nvme_cmd_resv_release] = "Reservation Release",
 	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
 	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
-	[nvme_cmd_zone_append] = "Zone Management Append",
+	[nvme_cmd_zone_append] = "Zone Append",
 };
 
 static const char * const nvme_admin_ops[] = {
-- 
2.39.2



