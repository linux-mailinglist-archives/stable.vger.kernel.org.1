Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3658A703751
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbjEORTg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243943AbjEORTN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1903310E79
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E019461FBB
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58F5C433D2;
        Mon, 15 May 2023 17:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171040;
        bh=QxKW70SDUOcM4ZzlccBHnO5C9wSOqYL2IMHRXM7Zdjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=szSvs+TG10nSqsB/hc5x12tTwfvSY66vha2iRer7NLlYyEHAW+pZamAgGt0hamDC3
         UfQ1CN4Bu8Hj012dtCCcTmYUCY+YkHQ26azPCXBmEiuYrjQEa6jyEGFsKcFDzgvPeC
         FbG7A8laZh21T8/0mKN9aVODqk76M2bLCn7nTr28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruliang Lin <u202112092@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Daniel Mack <daniel@zonque.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 082/242] ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`
Date:   Mon, 15 May 2023 18:26:48 +0200
Message-Id: <20230515161724.358172640@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ruliang Lin <u202112092@hust.edu.cn>

[ Upstream commit 0d727e1856ef22dd9337199430258cb64cbbc658 ]

Smatch complains that:
snd_usb_caiaq_input_init() warn: missing error code 'ret'

This patch adds a new case to handle the situation where the
device does not support any input methods in the
`snd_usb_caiaq_input_init` function. It returns an `-EINVAL` error code
to indicate that no input methods are supported on the device.

Fixes: 523f1dce3743 ("[ALSA] Add Native Instrument usb audio device support")
Signed-off-by: Ruliang Lin <u202112092@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
Acked-by: Daniel Mack <daniel@zonque.org>
Link: https://lore.kernel.org/r/20230504065054.3309-1-u202112092@hust.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/caiaq/input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 1e2cf2f08eecd..84f26dce7f5d0 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -804,6 +804,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 
 	default:
 		/* no input methods supported on this device */
+		ret = -EINVAL;
 		goto exit_free_idev;
 	}
 
-- 
2.39.2



