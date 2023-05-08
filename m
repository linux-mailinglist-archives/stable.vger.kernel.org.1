Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BAC6FA4F7
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbjEHKFA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbjEHKE7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:04:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B373014A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:04:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 564B062325
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696B1C433EF;
        Mon,  8 May 2023 10:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540297;
        bh=ht4eD109vJ3wW+ZjBtY5hoH5e2hvHJKXeQfGyZOYbrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sUThUxEyToI/I2vY+SXdFtz34cqVMKgR4Z79hR8oztIEPo0Z2ZdnEEg8YZTpOI9cg
         bwX+huk8zJwQy9vCYgRzO+JPWH3aYG8DhHu76PjILOn6qB+533VMOBkQQ88g0VPFxY
         h5VSfRG6Bq3/SexQrzE6+ajuyxSCKIIRsy/12+qo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Chen <harperchen1110@gmail.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 310/611] wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()
Date:   Mon,  8 May 2023 11:42:32 +0200
Message-Id: <20230508094432.508053403@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

[ Upstream commit 905a9241e4e8c15d2c084fee916280514848fe35 ]

If there is a failure during copy_from_user or user-provided data buffer
is invalid, rtl_debugfs_set_write_rfreg should return negative error code
instead of a positive value count.

Fix this bug by returning correct error code. Moreover, the check of buffer
against null is removed since it will be handled by copy_from_user.

Fixes: 610247f46feb ("rtlwifi: Improve debugging by using debugfs")
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230326053138.91338-1-harperchen1110@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtlwifi/debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 0b1bc04cb6adb..602717928887d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -375,8 +375,8 @@ static ssize_t rtl_debugfs_set_write_rfreg(struct file *filp,
 
 	tmp_len = (count > sizeof(tmp) - 1 ? sizeof(tmp) - 1 : count);
 
-	if (!buffer || copy_from_user(tmp, buffer, tmp_len))
-		return count;
+	if (copy_from_user(tmp, buffer, tmp_len))
+		return -EFAULT;
 
 	tmp[tmp_len] = '\0';
 
@@ -386,7 +386,7 @@ static ssize_t rtl_debugfs_set_write_rfreg(struct file *filp,
 	if (num != 4) {
 		rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
 			"Format is <path> <addr> <mask> <data>\n");
-		return count;
+		return -EINVAL;
 	}
 
 	rtl_set_rfreg(hw, path, addr, bitmask, data);
-- 
2.39.2



