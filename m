Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7603F703B41
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbjEOSBZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbjEOSBA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:01:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5CE4
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:58:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98FFB63015
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A136C433D2;
        Mon, 15 May 2023 17:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173494;
        bh=yzyO32OdFln+2y3T39bhhoxeUln21xmm6w9Oaa8fSdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TRCDQ4lgYwFCA822tihWEDaWp0Tukw/Ftx7mKduEeNawMlVEQAa7lENErvmN6AlhA
         Vhx+LX/7bzoePSxQd4yGAn++xQzvQjKh3y2BJw+zT9mVQ4vqGAqNYM9VKOTY+zmxnS
         1a4uayLX1X4Tg+I6jdV5ZVEorZd4DkwJg6dKJHHw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Liu Jian <liujian56@huawei.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 113/282] Revert "Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work"
Date:   Mon, 15 May 2023 18:28:11 +0200
Message-Id: <20230515161725.632281493@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit db2bf510bd5d57f064d9e1db395ed86a08320c54 ]

This reverts commit 1e9ac114c4428fdb7ff4635b45d4f46017e8916f.

This patch introduces a possible null-ptr-def problem. Revert it. And the
fixed bug by this patch have resolved by commit 73f7b171b7c0 ("Bluetooth:
btsdio: fix use after free bug in btsdio_remove due to race condition").

Fixes: 1e9ac114c442 ("Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btsdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 81125fb180351..fd9571d5fdac9 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -343,7 +343,6 @@ static void btsdio_remove(struct sdio_func *func)
 
 	BT_DBG("func %p", func);
 
-	cancel_work_sync(&data->work);
 	if (!data)
 		return;
 
-- 
2.39.2



