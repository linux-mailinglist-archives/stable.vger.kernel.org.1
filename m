Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D3B755326
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGPUP5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjGPUPy (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:15:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4871B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06DF060EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:15:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1770FC433C7;
        Sun, 16 Jul 2023 20:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538551;
        bh=l3BnC9lTfNA0mw2u8w+KVqo7jzgA9BlHXG6sq0MJOlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MI3gUpVfOlkcQ0RnLcQUtHobQ9t/NsOVDBCDiF3zB5PmsfitsvrhqjBrE1yHSgky0
         NnD3kKHuQBE83xyZWSkAjSxJR0DNuvSbIJoMHwQ7n81YJQyj5UbX6UeWySgT9LJX5s
         l63iKQdWQU7Vl2hPpDmJ8qw6sZ8+VwO9JwxzU8kg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 460/800] platform/x86: think-lmi: Correct NVME password handling
Date:   Sun, 16 Jul 2023 21:45:13 +0200
Message-ID: <20230716194959.766033352@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Mark Pearson <mpearson-lenovo@squebb.ca>

[ Upstream commit 4cebb42412248d28df6de01420cfac5654428d41 ]

NVME passwords identifier have been standardised across the Lenovo
systems and now use udrp and adrp (user and admin level) instead of
unvp and mnvp.

This should apparently be backwards compatible.

Fixes: 640a5fa50a42 ("platform/x86: think-lmi: Opcode support")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230601200552.4396-6-mpearson-lenovo@squebb.ca
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/think-lmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index e6060aa2f7953..e4047ee0a7546 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -461,9 +461,9 @@ static ssize_t new_password_store(struct kobject *kobj,
 				sprintf(pwd_type, "mhdp%d", setting->index);
 		} else if (setting == tlmi_priv.pwd_nvme) {
 			if (setting->level == TLMI_LEVEL_USER)
-				sprintf(pwd_type, "unvp%d", setting->index);
+				sprintf(pwd_type, "udrp%d", setting->index);
 			else
-				sprintf(pwd_type, "mnvp%d", setting->index);
+				sprintf(pwd_type, "adrp%d", setting->index);
 		} else {
 			sprintf(pwd_type, "%s", setting->pwd_type);
 		}
-- 
2.39.2



