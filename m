Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4767B8A39
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244390AbjJDSdb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244383AbjJDSd3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:33:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B879498
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:33:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D817C433C8;
        Wed,  4 Oct 2023 18:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444405;
        bh=RybLq0S8P7lb2v40qz3UQBS0g52zCFnSvRdMo8ThFvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GHilURku1wMBBz2uAGZfScImM+WMcWItYc5POtOBg3oAm9bV9Ldjm0Y8/YfvtN3Ja
         kzcgdOfUqPO1b0e/cSA/w/gIayM4oWHoxYtRqDeST3Q9I8j3X0aiGPFirZO5fJdaYj
         8iKc9r4lqNTz+UMT7f4JMK5ywERDauhclZb0AY7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 238/321] ASoC: cs35l56: Call pm_runtime_dont_use_autosuspend()
Date:   Wed,  4 Oct 2023 19:56:23 +0200
Message-ID: <20231004175240.267986268@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

From: Richard Fitzgerald <rf@opensource.cirrus.com>

commit ec03804552e9a723569e14d2512f36a8e70dc640 upstream

Driver remove() must call pm_runtime_dont_use_autosuspend().

Drivers that call pm_runtime_use_autosuspend() must disable
it in driver remove(). Unfortunately until recently this was
only mentioned in 1 line in a 900+ line document so most
people hadn't noticed this. It has only recently been added
to the kerneldoc of pm_runtime_use_autosuspend().

Backport note: This is the same change as the upstream
commit but the cs35l56->base.dev argument in the upstream
code is cs35l56->dev in older releases.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230908101716.2658582-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l56.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index fd06b9f9d496d..7e241908b5f16 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1594,6 +1594,7 @@ void cs35l56_remove(struct cs35l56_private *cs35l56)
 	flush_workqueue(cs35l56->dsp_wq);
 	destroy_workqueue(cs35l56->dsp_wq);
 
+	pm_runtime_dont_use_autosuspend(cs35l56->dev);
 	pm_runtime_suspend(cs35l56->dev);
 	pm_runtime_disable(cs35l56->dev);
 
-- 
2.40.1



