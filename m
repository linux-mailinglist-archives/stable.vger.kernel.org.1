Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09E7B8948
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbjJDSY1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244153AbjJDSY0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:24:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCF098
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:24:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39D8C433C7;
        Wed,  4 Oct 2023 18:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443863;
        bh=lbbOtcJTkNJwKTochjKakW1cOoyXW23q7TlPSHkuclU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg83j5fhbg1FzT+1inwZdQvZIDae/D50jefsS7KQLTAoDhh+2kl5EkksZvE0ElObQ
         Ae28+D9tWkYqhaCCOpcvPG+S+SAYWiInNEv4B5hGh8gdaewTLOODK16DuYwjNz1XQ8
         gExI7YXpsPqJz2uELzGH9FNwk0kT5pCSuZEg3nUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 046/321] ASoC: SOF: ipc4-topology: fix wrong sizeof argument
Date:   Wed,  4 Oct 2023 19:53:11 +0200
Message-ID: <20231004175231.305595878@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 6ba59c008f08e84b3c87be10f3391c9735e4f833 ]

available_fmt is a pointer.

Fixes: 4fdef47a44d6 ("ASoC: SOF: ipc4-topology: Add new tokens for input/output pin format count")
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://lore.kernel.org/r/20230914132504.18463-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 11361e1cd6881..8fb6582e568e7 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -218,7 +218,7 @@ static int sof_ipc4_get_audio_fmt(struct snd_soc_component *scomp,
 
 	ret = sof_update_ipc_object(scomp, available_fmt,
 				    SOF_AUDIO_FMT_NUM_TOKENS, swidget->tuples,
-				    swidget->num_tuples, sizeof(available_fmt), 1);
+				    swidget->num_tuples, sizeof(*available_fmt), 1);
 	if (ret) {
 		dev_err(scomp->dev, "Failed to parse audio format token count\n");
 		return ret;
-- 
2.40.1



