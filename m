Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE77555BB
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGPUoD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjGPUoC (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:44:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3DEE4B
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E5DD60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFEDC433C7;
        Sun, 16 Jul 2023 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540240;
        bh=ZuYXkoNjGp6D8fVKFriqmvprRiocY/enJHcUGzJTes4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsY7sMEVkYAavVgOxf6l2rAyCMigZfwMz3mmUiaHVqZH9zUVKsyyj6SHNmYN6nz/d
         i1wvgg+yxgbhTmzAq61B0O4mcWxUoxM7d1L9YBNlcnjAkmrK0xsF+hmLYcI9Sqinu1
         Ub+CVza4cv5bqEA7ZdCmWI7S5Ltz0KxZsrFWUeps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yuchen Yang <u202114568@hust.edu.cn>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 293/591] scsi: 3w-xxxx: Add error handling for initialization failure in tw_probe()
Date:   Sun, 16 Jul 2023 21:47:12 +0200
Message-ID: <20230716194931.474869913@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yuchen Yang <u202114568@hust.edu.cn>

[ Upstream commit 2e2fe5ac695a00ab03cab4db1f4d6be07168ed9d ]

Smatch complains that:

tw_probe() warn: missing error code 'retval'

This patch adds error checking to tw_probe() to handle initialization
failure. If tw_reset_sequence() function returns a non-zero value, the
function will return -EINVAL to indicate initialization failure.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yuchen Yang <u202114568@hust.edu.cn>
Link: https://lore.kernel.org/r/20230505141259.7730-1-u202114568@hust.edu.cn
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/3w-xxxx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index ffdecb12d654c..9bd70e4618d52 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2305,8 +2305,10 @@ static int tw_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 	TW_DISABLE_INTERRUPTS(tw_dev);
 
 	/* Initialize the card */
-	if (tw_reset_sequence(tw_dev))
+	if (tw_reset_sequence(tw_dev)) {
+		retval = -EINVAL;
 		goto out_release_mem_region;
+	}
 
 	/* Set host specific parameters */
 	host->max_id = TW_MAX_UNITS;
-- 
2.39.2



