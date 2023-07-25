Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5776155D
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjGYL2V (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjGYL2F (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D06997
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3629B61691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 416FEC433C8;
        Tue, 25 Jul 2023 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284483;
        bh=S5xdVl+uaT7ygnqQV8S8z6qH835ziR8pkTsPX0E1uCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDyvK9GH1JauNmb/KzPYaXPcFXO/T/hcjIHV6b3Cw7AwEAsEClJnlZNJWZcDJdxSY
         vCyVlf2xMtCJVPIHX4m2s6KRCTZO1LWmlD5st8NdhHrZrVMcT9ZfIHkbKhVwugzqSj
         EtWq9FVaOecYqfkO2fVlNrr1hWT6YglsZW62p1Pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Pavan Chebbi <pavan.chebbi@broadcom.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 371/509] netdevsim: fix uninitialized data in nsim_dev_trap_fa_cookie_write()
Date:   Tue, 25 Jul 2023 12:45:10 +0200
Message-ID: <20230725104610.696901091@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit f72207a5c0dbaaf6921cf9a6c0d2fd0bc249ea78 ]

The simple_write_to_buffer() function is designed to handle partial
writes.  It returns negatives on error, otherwise it returns the number
of bytes that were able to be copied.  This code doesn't check the
return properly.  We only know that the first byte is written, the rest
of the buffer might be uninitialized.

There is no need to use the simple_write_to_buffer() function.
Partial writes are prohibited by the "if (*ppos != 0)" check at the
start of the function.  Just use memdup_user() and copy the whole
buffer.

Fixes: d3cbb907ae57 ("netdevsim: add ACL trap reporting cookie as a metadata")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/7c1f950b-3a7d-4252-82a6-876e53078ef7@moroto.mountain
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netdevsim/dev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 9bbecf4d159b4..bcf354719745c 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -149,13 +149,10 @@ static ssize_t nsim_dev_trap_fa_cookie_write(struct file *file,
 	cookie_len = (count - 1) / 2;
 	if ((count - 1) % 2)
 		return -EINVAL;
-	buf = kmalloc(count, GFP_KERNEL | __GFP_NOWARN);
-	if (!buf)
-		return -ENOMEM;
 
-	ret = simple_write_to_buffer(buf, count, ppos, data, count);
-	if (ret < 0)
-		goto free_buf;
+	buf = memdup_user(data, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	fa_cookie = kmalloc(sizeof(*fa_cookie) + cookie_len,
 			    GFP_KERNEL | __GFP_NOWARN);
-- 
2.39.2



