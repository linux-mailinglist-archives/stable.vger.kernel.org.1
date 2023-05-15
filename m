Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85E770337E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbjEOQhw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242807AbjEOQht (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:37:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6731D18F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F39286283D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4029C4339B;
        Mon, 15 May 2023 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168667;
        bh=yY9eDA1nuYZABo8CIHXT8N890+Brn+Jhhwlkvv9RZWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrWw0MJOWWcOrkYowEL6YaJ5Od82DRRCb+Ap/NzUu/WMLYAv60Y/17aunBEi0gEq8
         GtQGx77XvxR/Dg2WDO1WC70b84WkZjVaLN3cP5hTdkcsbiEh7jC1FlxMDhOgRQqGmJ
         Gfh0ILVzD/YnOU8YYa9EdIudLYMDbL87Ec72i7U8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ruliang Lin <u202112092@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Daniel Mack <daniel@zonque.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 093/116] ALSA: caiaq: input: Add error handling for unsupported input methods in `snd_usb_caiaq_input_init`
Date:   Mon, 15 May 2023 18:26:30 +0200
Message-Id: <20230515161701.348454743@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 4b3fb91deecdf..0898d2dd14e40 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -808,6 +808,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
 
 	default:
 		/* no input methods supported on this device */
+		ret = -EINVAL;
 		goto exit_free_idev;
 	}
 
-- 
2.39.2



