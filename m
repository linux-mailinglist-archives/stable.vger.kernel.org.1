Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F379B045
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240802AbjIKU4k (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241487AbjIKPJt (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:09:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19983FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:09:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED20C433CA;
        Mon, 11 Sep 2023 15:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444984;
        bh=NPqbVrC8EztM/pXf+JSr5rfxHSiR1D3SWlu5B3lOmmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLC55sNS3pHFsQVjDJ4Ym6fdODIHqJtWg2R0cgyh7FpIKmMjF6D2bPx7n+zzPHHft
         GfqOBmLaN/JYQEy86gkZzyB5J7ABuXjqgJA53kSVXXbpaKA6eyAeuu2GerIjyfc7/f
         SjxUQFAVsyGy8qJh1wphFjpTkmu3prgVkiG1ldxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Brian Norris <briannorris@chromium.org>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 186/600] wifi: mwifiex: fix memory leak in mwifiex_histogram_read()
Date:   Mon, 11 Sep 2023 15:43:39 +0200
Message-ID: <20230911134639.116237363@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 9c8fd72a5c2a031cbc680a2990107ecd958ffcdb ]

Always free the zeroed page on return from 'mwifiex_histogram_read()'.

Fixes: cbf6e05527a7 ("mwifiex: add rx histogram statistics support")

Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230802160726.85545-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/debugfs.c b/drivers/net/wireless/marvell/mwifiex/debugfs.c
index bda53cb91f376..63f232c723374 100644
--- a/drivers/net/wireless/marvell/mwifiex/debugfs.c
+++ b/drivers/net/wireless/marvell/mwifiex/debugfs.c
@@ -253,8 +253,11 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	if (!p)
 		return -ENOMEM;
 
-	if (!priv || !priv->hist_data)
-		return -EFAULT;
+	if (!priv || !priv->hist_data) {
+		ret = -EFAULT;
+		goto free_and_exit;
+	}
+
 	phist_data = priv->hist_data;
 
 	p += sprintf(p, "\n"
@@ -309,6 +312,8 @@ mwifiex_histogram_read(struct file *file, char __user *ubuf,
 	ret = simple_read_from_buffer(ubuf, count, ppos, (char *)page,
 				      (unsigned long)p - page);
 
+free_and_exit:
+	free_page(page);
 	return ret;
 }
 
-- 
2.40.1



