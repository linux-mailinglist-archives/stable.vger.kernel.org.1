Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163AE7ED701
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 23:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbjKOWEy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 17:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344425AbjKOWEx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 17:04:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA4A19B
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 14:04:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D755CC433C8;
        Wed, 15 Nov 2023 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700085890;
        bh=df1XWUnrXvDAC7tAFhVGXi0K3BjdX9PV1b3zVZuFEbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DprA3gsXOBvVRj6hAO5twE3ko3LRVkPZFURO8Qb25bf+4Al+1Em5IACWEUr12+cAb
         yCBX9gUPArxGUfwW+s+TDkq/AD7EjB7HevAVDfSBhIEChWUNtY0WwUtrAWDsu/249e
         CIT0BiJPUzZUc/5RPIyaAsWznv+pDnQeqEDV5JB8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 115/119] fbdev: imsttfb: Fix error path of imsttfb_probe()
Date:   Wed, 15 Nov 2023 17:01:45 -0500
Message-ID: <20231115220136.239207625@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
References: <20231115220132.607437515@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 9670e5b5fe326..0c8b72702ce59 100644
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



