Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC7B7ECF30
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjKOTqz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbjKOTqy (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:46:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4653D1A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:46:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE7CCC433C7;
        Wed, 15 Nov 2023 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077610;
        bh=9Vl1w5mjQAci7I082/bwIWcqES+Wvyrs0QX9BaK11ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoU4LIlD+PJiRMWJCwq/oCqP6Z16X9HG7ejR6F0W2ZxCxgVUMoDFvFGzUT08aLH8S
         hjHdsHsOQxTE5wzSP0XNr/MIVLFmECX14s7yxUGWx4rhCJQcb11sXa7rLSwZtE74cK
         p0pGXdeYgVc6PY1g7fZMi7uqV28eM9en6Sbw+8Ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 409/603] mfd: core: Un-constify mfd_cell.of_reg
Date:   Wed, 15 Nov 2023 14:15:54 -0500
Message-ID: <20231115191641.323660608@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

[ Upstream commit 3c70342f1f0045dc827bb2f02d814ce31e0e0d05 ]

Enable dynamically filling in the whole mfd_cell structure. All other
fields already allow that.

Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Link: https://lore.kernel.org/r/b73fe4bc4bd6ba1af90940a640ed65fe254c0408.1693253717.git.mirq-linux@rere.qmqm.pl
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mfd/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 47e7a3a61ce69..e8bcad641d8c2 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -92,7 +92,7 @@ struct mfd_cell {
 	 * (above) when matching OF nodes with devices that have identical
 	 * compatible strings
 	 */
-	const u64 of_reg;
+	u64 of_reg;
 
 	/* Set to 'true' to use 'of_reg' (above) - allows for of_reg=0 */
 	bool use_of_reg;
-- 
2.42.0



