Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3F79B7DC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378660AbjIKWgV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbjIKOHQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A60CF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503BCC433C9;
        Mon, 11 Sep 2023 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441231;
        bh=qgF+bY/sfqUn3lown4rSIVl++eh/M9WxAEc4NZeOf2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnQGo/MilZwBbo5fs0HbhZjNgDGywX7VYoSkxFtEN4AAWEQn1keb14d+wJ583UqUo
         CoYw00orrCAqI0no8z9YQoZsMEJoTylx8tcg0w+2wLXOAB2Iyphxbtz5rfoTdtdGXN
         P0bYns+fyOze4PLhdOotG+n0YyEASs788MqeV9gg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 314/739] smackfs: Prevent underflow in smk_set_cipso()
Date:   Mon, 11 Sep 2023 15:41:53 +0200
Message-ID: <20230911134659.883078735@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

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
index 5590eaad241bb..25f67d1b5c73e 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -896,7 +896,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 
 	ret = sscanf(rule, "%d", &catlen);
-	if (ret != 1 || catlen > SMACK_CIPSO_MAXCATNUM)
+	if (ret != 1 || catlen < 0 || catlen > SMACK_CIPSO_MAXCATNUM)
 		goto out;
 
 	if (format == SMK_FIXED24_FMT &&
-- 
2.40.1



