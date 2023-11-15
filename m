Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167787ED37D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjKOUxA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjKOUw7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:52:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2F98F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:52:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87985C4E777;
        Wed, 15 Nov 2023 20:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081576;
        bh=7y6Dk8/fF4eAh+9pY8az+cNQY44omaEQvkEMQ0FrGpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPp1C8iEtrBLHR0GF4vswNvyLK+C78fcolsjLAlaatOxbMaKcTzEn7N+Lk3+MRe6k
         ZniHtZTr1VXXQQv/kGC6qryNZoO8ae5EcDiT/JtBY5c2+wVtb4yTXgsBqW14n75DNf
         yABgxqCanOYVq+jTH7Pjb4fVBvQFsn/7FkrLu3M0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 239/244] fbdev: imsttfb: Fix error path of imsttfb_probe()
Date:   Wed, 15 Nov 2023 15:37:11 -0500
Message-ID: <20231115203602.667140582@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
References: <20231115203548.387164783@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Helge Deller <deller@gmx.de>

[ Upstream commit 518ecb6a209f6ff678aeadf9f2bf870c0982ca85 ]

Release ressources when init_imstt() returns failure.

Signed-off-by: Helge Deller <deller@gmx.de>
Stable-dep-of: aba6ab57a910 ("fbdev: imsttfb: fix a resource leak in probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/imsttfb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 1b2fb8ed76237..876ddf05e133a 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1525,8 +1525,10 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto error;
 	info->pseudo_palette = par->palette;
 	ret = init_imstt(info);
-	if (!ret)
-		pci_set_drvdata(pdev, info);
+	if (ret)
+		goto error;
+
+	pci_set_drvdata(pdev, info);
 	return ret;
 
 error:
-- 
2.42.0



