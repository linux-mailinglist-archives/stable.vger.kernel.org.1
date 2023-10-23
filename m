Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518C37D31BC
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjJWLMc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjJWLMa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:12:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4967FC2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:12:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6047EC433C8;
        Mon, 23 Oct 2023 11:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059549;
        bh=1MN5W0z9MLKZkUeHXT4VAfj/3MxcCa0/mhf2HznJ9TY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Av9OHNSoqzjLF2HZVx7qdUkltAb+YXuT9g/yFWFCAJdHYgVFJnxqPL91OCOuaQ+PR
         VVYQU7hMbUQVVv2GAyt0bS9QMHUepcp3jG6CYRJehRX5v5CGehzMr98BhPUaXUdjpq
         shKcVz1HlZT0enDnJ1AO5t2w7L9mYF4bGDbmfivI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 215/241] ASoC: cs35l56: Fix illegal use of init_completion()
Date:   Mon, 23 Oct 2023 12:56:41 +0200
Message-ID: <20231023104839.092559189@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit af5fd122d7bd739a2b66405f6e8ab92557279325 ]

Fix cs35l56_patch() to call reinit_completion() to reinitialize
the completion object.

It was incorrectly using init_completion().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
Link: https://lore.kernel.org/r/20231006164405.253796-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 7e241908b5f16..4d7ccf682647e 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -879,7 +879,7 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 
 	mutex_lock(&cs35l56->irq_lock);
 
-	init_completion(&cs35l56->init_completion);
+	reinit_completion(&cs35l56->init_completion);
 
 	cs35l56_system_reset(cs35l56);
 
-- 
2.42.0



