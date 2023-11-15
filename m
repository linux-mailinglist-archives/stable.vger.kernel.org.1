Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49587ECCF5
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbjKOTdf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjKOTda (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED02B9E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72749C433C8;
        Wed, 15 Nov 2023 19:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076807;
        bh=qEGEOlliKdR+zWxudznqumfRxM5bVRW/i+XFhM/I2B8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmk7TxnVCd9acSmGck0BtfrE0pScOqTDJeXaX8GFLVY32//aQFNCSlJ6yCIO3YPnI
         LO3/wVrH4m0XGiENMu9FJ1doyniAJMP1RLBM57qvz3ZvfIHs6i/vRnLZAhfPxSaCH8
         lJ8EvvxLnwpZH6k+Ui93C1ly9u2tlR3wbhM96P00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aaron Plattner <aplattner@nvidia.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 009/603] objtool: Propagate early errors
Date:   Wed, 15 Nov 2023 14:09:14 -0500
Message-ID: <20231115191613.783469044@linuxfoundation.org>
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

From: Aaron Plattner <aplattner@nvidia.com>

[ Upstream commit e959c279d391c10b35ce300fb4b0fe3b98e86bd2 ]

If objtool runs into a problem that causes it to exit early, the overall
tool still returns a status code of 0, which causes the build to
continue as if nothing went wrong.

Note this only affects early errors, as later errors are still ignored
by check().

Fixes: b51277eb9775 ("objtool: Ditch subcommands")
Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
Link: https://lore.kernel.org/r/cb6a28832d24b2ebfafd26da9abb95f874c83045.1696355111.git.aplattner@nvidia.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/objtool.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index c54f7235c5d94..f40febdd6e36a 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -146,7 +146,5 @@ int main(int argc, const char **argv)
 	exec_cmd_init("objtool", UNUSED, UNUSED, UNUSED);
 	pager_init(UNUSED);
 
-	objtool_run(argc, argv);
-
-	return 0;
+	return objtool_run(argc, argv);
 }
-- 
2.42.0



