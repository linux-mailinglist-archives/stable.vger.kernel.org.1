Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB1B703B2C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbjEOSA2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245050AbjEOR74 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E519F04
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:57:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C1D963002
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B278C433EF;
        Mon, 15 May 2023 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173433;
        bh=y1HNHUJJlWCRjJ0YQ+Iep+I0vnMpYxtFmTB57TxKaXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neVcTU9y1YABqPn7s4tKVW4BL4U/GQy3ijQH21w+AxtJvxrOoZ3NxzEg+b4/pVb6j
         Vma30kK3tAUdVpcaXKAZPGVt5wqjcyA2QZZ4hvbzt5Z21hFdiGWH1lsUZcdCvo42XS
         /hJYDaI1S0b022buIjnAtFcaRkEZwlwTQ4pI7zio=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Chen <harperchen1110@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 092/282] wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()
Date:   Mon, 15 May 2023 18:27:50 +0200
Message-Id: <20230515161725.023703896@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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
index c8db166a7dc80..3866ea300a70b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -298,8 +298,8 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -307,7 +307,7 @@ static ssize_t rtl_debugfs_set_write_reg(struct file *filp,
 	num = sscanf(tmp, "%x %x %x", &addr, &val, &len);
 
 	if (num !=  3)
-		return count;
+		return -EINVAL;
 
 	switch (len) {
 	case 1:
-- 
2.39.2



