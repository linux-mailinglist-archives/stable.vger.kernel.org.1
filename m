Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304907ECC77
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjKOTai (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjKOTah (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:30:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3652419E
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:30:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBCFC433C8;
        Wed, 15 Nov 2023 19:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076633;
        bh=9S9UmVNEkzz7MPC7epabKj1naUDRltKZx3XtPyKLCo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U8v58AK6vtMllkRg+VxJceaOKwsJfCWrT228IQkfREFNZt1Fa/WIcwmE9V0IMe73o
         D+LTVB51kDtGSKrppPvYa2bW1H/646rmmAF60RcHXNEHf/0SF3TPMKSNVNtntTsA1o
         uveMfoTCEHuk9T/PL9BXfWFuCzwfZuFGsXWxctxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 327/550] ASoC: SOF: ipc4-topology: Use size_add() in call to struct_size()
Date:   Wed, 15 Nov 2023 14:15:11 -0500
Message-ID: <20231115191623.431102714@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavoars@kernel.org>

[ Upstream commit 3746284c233d5cf5f456400e61cd4a46a69c6e8c ]

If, for any reason, the open-coded arithmetic causes a wraparound,
the protection that `struct_size()` adds against potential integer
overflows is defeated. Fix this by hardening call to `struct_size()`
with `size_add()`.

Fixes: f9efae954905 ("ASoC: SOF: ipc4-topology: Add support for base config extension")
Signed-off-by: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/ZQSr15AYJpDpipg6@work
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 8fb6582e568e7..98ed20cafb573 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -882,7 +882,8 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
 	if (process->init_config == SOF_IPC4_MODULE_INIT_CONFIG_TYPE_BASE_CFG_WITH_EXT) {
 		struct sof_ipc4_base_module_cfg_ext *base_cfg_ext;
 		u32 ext_size = struct_size(base_cfg_ext, pin_formats,
-						swidget->num_input_pins + swidget->num_output_pins);
+					   size_add(swidget->num_input_pins,
+						    swidget->num_output_pins));
 
 		base_cfg_ext = kzalloc(ext_size, GFP_KERNEL);
 		if (!base_cfg_ext) {
-- 
2.42.0



