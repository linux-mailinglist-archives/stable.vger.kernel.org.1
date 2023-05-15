Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8721703990
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244570AbjEORno (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244569AbjEORn1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A4914362
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABCD662E41
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB8CC433D2;
        Mon, 15 May 2023 17:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172455;
        bh=WEAmJZGfFKqctGT2vUqWC3klLrFDB7+B8pLgO0w/uAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYhJBX/Zz2wZeNh80kTlEcm7phxJow1UV/W86hbjhvHv0htYIZc4ocjE2WXXZ2fNz
         bTL5P0sE6KT+OZfIzw3xSMwwZKgN4u0NyQb+0uL6jT9jO4AM7cdWhpy2G2xPugCsUK
         gB+hNz7Id+PnqJ6Y5qvwYbJsgLjlqPRuubKcImLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Chen <harperchen1110@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 158/381] wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()
Date:   Mon, 15 May 2023 18:26:49 +0200
Message-Id: <20230515161743.956393356@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Chen <harperchen1110@gmail.com>

[ Upstream commit 5dbe1f8eb8c5ac69394400a5b86fd81775e96c43 ]

If there is a failure during copy_from_user or user-provided data buffer is
invalid, rtl_debugfs_set_write_reg should return negative error code instead
of a positive value count.

Fix this bug by returning correct error code. Moreover, the check of buffer
against null is removed since it will be handled by copy_from_user.

Fixes: 610247f46feb ("rtlwifi: Improve debugging by using debugfs")
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230326054217.93492-1-harperchen1110@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 602717928887d..9eb26dfe4ca92 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -278,8 +278,8 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -287,7 +287,7 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 	num = sscanf(tmp, "%x %x %x", &addr, &val, &len);
 
 	if (num !=  3)
-		return count;
+		return -EINVAL;
 
 	switch (len) {
 	case 1:
-- 
2.39.2



