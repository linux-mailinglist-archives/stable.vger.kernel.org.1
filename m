Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C307ECE8F
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjKOTn4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbjKOTn4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:43:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A761AD
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:43:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14CFC433C7;
        Wed, 15 Nov 2023 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077432;
        bh=mT0LBlORao+FWIAoB4Oqkg5okfUqN+7L+DDv+GG8bAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2okFEU84oxx4F8PNzzgf5Eg3nKjyfXVh9fuUMQqGpBgybuD0sPhal1CwY2ewNI3FS
         4D7qyec3xarhYG6BgCjz+4c3Yq/HTDGpOy+ZLJoXm703V60fKDHrf4/NMPItkNW0cb
         5H4QV4h2gH4avpesU73u4ksE95e2UaO3FHgTJpHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jinjie Ruan <ruanjinjie@huawei.com>,
        Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 300/603] kunit: Fix the wrong kfree of copy for kunit_filter_suites()
Date:   Wed, 15 Nov 2023 14:14:05 -0500
Message-ID: <20231115191634.147506354@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinjie Ruan <ruanjinjie@huawei.com>

[ Upstream commit e44679515a7b803cf0143dc9de3d2ecbe907f939 ]

If the outer layer for loop is iterated more than once and it fails not
in the first iteration, the copy pointer has been moved. So it should free
the original copy's backup copy_start.

Fixes: abbf73816b6f ("kunit: fix possible memory leak in kunit_filter_suites()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/executor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index a037a46fae5ea..9358ed2df8395 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -243,7 +243,7 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
 
 free_copy:
 	if (*err)
-		kfree(copy);
+		kfree(copy_start);
 
 	return filtered;
 }
-- 
2.42.0



