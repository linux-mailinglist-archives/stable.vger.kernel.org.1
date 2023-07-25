Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB64C7614EA
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjGYLX7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjGYLX4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C791B8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFC5261691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF89C433C7;
        Tue, 25 Jul 2023 11:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284230;
        bh=ig4R60prGrQS1rLLv0Q9aNv9X50c8B1yKfTsH8g1I1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gnAE3Ky/tlOE8aKMyEgjHRv8M5G8HWclgoKJADnQLRFg07fU+qLx7v4Ay5/1Y7Ih
         5Fk5iChs1bjayp3BIXpB4VjRYbmDyBZYTC/duHxxzjdOZiMhityMR4rSNjCrw8FwQ5
         zhce/3czk03aUPBJIwZDPPJL1XEHr7TI5u1FT8nA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 252/509] mfd: stmfx: Nullify stmfx->vdd in case of error
Date:   Tue, 25 Jul 2023 12:43:11 +0200
Message-ID: <20230725104605.274302707@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

[ Upstream commit 7c81582c0bccb4757186176f0ee12834597066ad ]

Nullify stmfx->vdd in case devm_regulator_get_optional() returns an error.
And simplify code by returning an error only if return code is not -ENODEV,
which means there is no vdd regulator and it is not an issue.

Fixes: d75846ed08e6 ("mfd: stmfx: Fix dev_err_probe() call in stmfx_chip_init()")
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Link: https://lore.kernel.org/r/20230609092804.793100-2-amelie.delaunay@foss.st.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/stmfx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 41e74b5dd9901..b45d7b0b842c5 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -330,9 +330,8 @@ static int stmfx_chip_init(struct i2c_client *client)
 	stmfx->vdd = devm_regulator_get_optional(&client->dev, "vdd");
 	ret = PTR_ERR_OR_ZERO(stmfx->vdd);
 	if (ret) {
-		if (ret == -ENODEV)
-			stmfx->vdd = NULL;
-		else
+		stmfx->vdd = NULL;
+		if (ret != -ENODEV)
 			return dev_err_probe(&client->dev, ret, "Failed to get VDD regulator\n");
 	}
 
-- 
2.39.2



