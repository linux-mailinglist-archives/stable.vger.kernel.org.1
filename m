Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B327ECB2E
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjKOTUi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjKOTUh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:20:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891112C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:20:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA12AC433C9;
        Wed, 15 Nov 2023 19:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076033;
        bh=xHXjuu60BFQjn0VzFv3/X84qpP4DHjfz5tE3w5KbI5w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDrqbr8ImZI5FNTBssYaF+YUt3cWnIBJCgwRsX9FTCf5BasgYbtlkOTWLMlYmrIx5
         eBUSZo+Cm4C3MHVwUpRCYPMfqiJsMkUbyfhND/jG2TS/aoSJldR3loBrYcIVxUIB3J
         16FYmPrhFI6ceuipG3RhRkTrPNEEdC7tD4DHUp9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aaron Plattner <aplattner@nvidia.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 009/550] objtool: Propagate early errors
Date:   Wed, 15 Nov 2023 14:09:53 -0500
Message-ID: <20231115191601.363945767@linuxfoundation.org>
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



