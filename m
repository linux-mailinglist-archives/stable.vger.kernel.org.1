Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6DB7ECC0D
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjKOT0l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbjKOT0Z (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D310EC
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04186C433C8;
        Wed, 15 Nov 2023 19:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076382;
        bh=S659Bn7qhti+oqr9G2CYozHAhOiLtOQW+xXJYxYkUuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RyZijaEYKHTmbNmnzEwoqCjMxeaLfLcaFbhzmdvzvPU3yYKqxz7C2eRBzSWuXu6eA
         qExs3BTxkRRmNmYlOPYV0rbAutkcFQULKUBm+BiC0Yhx3OT+hd7FtMgYezZmwUBYza
         zKCwV8Ck8hPq6tQQ3LW5b8huu4vT1iR5b4iGya24=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 249/550] xenbus: fix error exit in xenbus_init()
Date:   Wed, 15 Nov 2023 14:13:53 -0500
Message-ID: <20231115191617.951304123@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

[ Upstream commit 44961b81a9e9059b5c0443643915386db7035227 ]

In case an error occurs in xenbus_init(), xen_store_domain_type should
be set to XS_UNKNOWN.

Fix one instance where this action is missing.

Fixes: 5b3353949e89 ("xen: add support for initializing xenstore later as HVM domain")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202304200845.w7m4kXZr-lkp@intel.com/
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Link: https://lore.kernel.org/r/20230822091138.4765-1-jgross@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xenbus/xenbus_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 639bf628389ba..3205e5d724c8c 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -1025,7 +1025,7 @@ static int __init xenbus_init(void)
 			if (err < 0) {
 				pr_err("xenstore_late_init couldn't bind irq err=%d\n",
 				       err);
-				return err;
+				goto out_error;
 			}
 
 			xs_init_irq = err;
-- 
2.42.0



