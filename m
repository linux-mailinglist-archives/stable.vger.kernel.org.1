Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5342C7614E9
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjGYLXz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjGYLXy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:23:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0811F13D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:23:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE0FD61600
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ADEC433C8;
        Tue, 25 Jul 2023 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284227;
        bh=uQUY7r8hlWpVURkaCRdL+RvZiSBJ6hX8ALGCIB7YQLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GUmOlCTcZxO9A3wRP8hZlDoENGvWqvqMbWTDHjwc3IR1O4kOf9hQHH/O8zJgSD9sh
         86Rldx6JDMcoij3R1to7tlUZj3aQBOvpGd8ESGt2bekGT6a/Yqd/VirCpLsaTcxRPa
         FeYo3L5RdBZuriHYIK0gUK/ljAvbSEc6oydSTiOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 251/509] mfd: stmfx: Fix error path in stmfx_chip_init
Date:   Tue, 25 Jul 2023 12:43:10 +0200
Message-ID: <20230725104605.224673701@linuxfoundation.org>
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

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

[ Upstream commit f592cf624531286f8b52e40dcfc157a5a7fb115c ]

In error path, disable vdd regulator if it exists, but don't overload ret.
Because if regulator_disable() is successful, stmfx_chip_init will exit
successfully while chip init failed.

Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://lore.kernel.org/r/20230609092804.793100-1-amelie.delaunay@foss.st.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmfx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 988e2ba6dd0f3..41e74b5dd9901 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -387,7 +387,7 @@ static int stmfx_chip_init(struct i2c_client *client)
 
 err:
 	if (stmfx->vdd)
-		return regulator_disable(stmfx->vdd);
+		regulator_disable(stmfx->vdd);
 
 	return ret;
 }
-- 
2.39.2



