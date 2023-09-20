Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83E07A7C99
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbjITMCp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbjITMCd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:02:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3A5A3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:02:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B06C433CA;
        Wed, 20 Sep 2023 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211347;
        bh=vJbXT4wHUpZZL0do69IKhxIdSxiB+tXXi1ciBto6Zxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNxqFArrLPO15Vfzx/b55KrbaQYolkOremj6gkY0Q7fRO8c87Ty51t0dHbEmbCMaZ
         MC22ylEi/7e/w8o1uFimH6wqjTwbnsg6oTrwWh3NvgY4bEvpr/AvJZO0RSL+YnWczL
         UQEPoaSYTzVjWPyXvYf7VDGd7aL7L7oEMRKgz6Co=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 060/186] smackfs: Prevent underflow in smk_set_cipso()
Date:   Wed, 20 Sep 2023 13:29:23 +0200
Message-ID: <20230920112839.060802111@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 3ad49d37cf5759c3b8b68d02e3563f633d9c1aee ]

There is a upper bound to "catlen" but no lower bound to prevent
negatives.  I don't see that this necessarily causes a problem but we
may as well be safe.

Fixes: e114e473771c ("Smack: Simplified Mandatory Access Control Kernel")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index a9c516362170a..61e734baa332a 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -923,7 +923,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 
 	ret = sscanf(rule, "%d", &catlen);
-	if (ret != 1 || catlen > SMACK_CIPSO_MAXCATNUM)
+	if (ret != 1 || catlen < 0 || catlen > SMACK_CIPSO_MAXCATNUM)
 		goto out;
 
 	if (format == SMK_FIXED24_FMT &&
-- 
2.40.1



