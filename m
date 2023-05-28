Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C845713EAF
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjE1Thy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjE1Thx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:37:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5299C7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 653F261E72
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82648C433D2;
        Sun, 28 May 2023 19:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302670;
        bh=D3VxdUrhLXJfpaUNtbuYkeiprPSvDf1PPCHPUXc05jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZexWIwr2rHyL8To/IAWVij8YQ9ijXtV+10kn93M0wCUCxTYTiaqJ9eQTqiwF8caeu
         X3/RLDBU/Av3DMoxoDimwoacrG77tAo0aMUlJpTOZ7kZCqQ9erMza7OlW3qv7xxU04
         VvNo+ZSl22XVlkkaUhv/Q/QnEbXEBD7mns2j9aeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 097/119] ASoC: Intel: avs: Fix declaration of enum avs_channel_config
Date:   Sun, 28 May 2023 20:11:37 +0100
Message-Id: <20230528190838.754999255@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

commit 1cf036deebcdec46d6348842bd2f8931202fd4cd upstream.

Constant 'C4_CHANNEL' does not exist on the firmware side. Value 0xC is
reserved for 'C7_1' instead.

Fixes: 580a5912d1fe ("ASoC: Intel: avs: Declare module configuration types")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20230519201711.4073845-5-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/avs/messages.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/intel/avs/messages.h
+++ b/sound/soc/intel/avs/messages.h
@@ -611,7 +611,7 @@ enum avs_channel_config {
 	AVS_CHANNEL_CONFIG_DUAL_MONO = 9,
 	AVS_CHANNEL_CONFIG_I2S_DUAL_STEREO_0 = 10,
 	AVS_CHANNEL_CONFIG_I2S_DUAL_STEREO_1 = 11,
-	AVS_CHANNEL_CONFIG_4_CHANNEL = 12,
+	AVS_CHANNEL_CONFIG_7_1 = 12,
 	AVS_CHANNEL_CONFIG_INVALID
 };
 


