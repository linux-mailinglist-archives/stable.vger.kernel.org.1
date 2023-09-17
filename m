Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10B7A3965
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbjIQTsv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbjIQTso (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:48:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFAA189
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:48:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1666C433C7;
        Sun, 17 Sep 2023 19:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980110;
        bh=IFK0CWamUz1bH+HfxUv1NDI9JlSix+HSjGjtywd7gtk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQ11yP43nXSfzm0Wt2Jic4uCETRDBTRglg6VuO9r9xx/aE36xFJjCxNmgOvb+uC9d
         iRlptCgTn61If3w14Y8pCm74jPt5jJ7RLhJ86RuaGLsZbOxl0F2L0tveeT/5wQZwDb
         G36N21hMS03jVio27663/VOTprQkbroxzHcdzi1o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: [PATCH 6.5 063/285] kconfig: fix possible buffer overflow
Date:   Sun, 17 Sep 2023 21:11:03 +0200
Message-ID: <20230917191053.890593865@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

[ Upstream commit a3b7039bb2b22fcd2ad20d59c00ed4e606ce3754 ]

Buffer 'new_argv' is accessed without bound check after accessing with
bound check via 'new_argc' index.

Fixes: e298f3b49def ("kconfig: add built-in function support")
Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/preprocess.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/kconfig/preprocess.c b/scripts/kconfig/preprocess.c
index 748da578b418c..d1f5bcff4b62d 100644
--- a/scripts/kconfig/preprocess.c
+++ b/scripts/kconfig/preprocess.c
@@ -396,6 +396,9 @@ static char *eval_clause(const char *str, size_t len, int argc, char *argv[])
 
 		p++;
 	}
+
+	if (new_argc >= FUNCTION_MAX_ARGS)
+		pperror("too many function arguments");
 	new_argv[new_argc++] = prev;
 
 	/*
-- 
2.40.1



