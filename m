Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C0713F2A
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjE1Tmi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjE1Tmg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:42:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66909B
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66ECA61EF1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85283C433EF;
        Sun, 28 May 2023 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302954;
        bh=lk1wWdsbLW4wOPjgWmLz3wOUFdOeuHgSlmLrTc975jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujvddKgYec94mxhS2pzabiq+jVpPbhwVDo/bItsHfElMaRsGS3oZbuQrV+tLsSEj/
         iYCIhnCMymQa2zyOruPlojx2+Xaa+aEhgpSWwfZbKwGyz6JWRwx6Xge3VEuYvAgrOI
         OZnmlvavt5rNzULjFxMFBY9RX6MCt/2KnJBeiyic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 095/211] ALSA: firewire-digi00x: prevent potential use after free
Date:   Sun, 28 May 2023 20:10:16 +0100
Message-Id: <20230528190845.961883486@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit c0e72058d5e21982e61a29de6b098f7c1f0db498 ]

This code was supposed to return an error code if init_stream()
failed, but it instead freed dg00x->rx_stream and returned success.
This potentially leads to a use after free.

Fixes: 9a08067ec318 ("ALSA: firewire-digi00x: support AMDTP domain")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/r/c224cbd5-d9e2-4cd4-9bcf-2138eb1d35c6@kili.mountain
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/digi00x/digi00x-stream.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
index 405d6903bfbc3..62a54f5ab84d7 100644
--- a/sound/firewire/digi00x/digi00x-stream.c
+++ b/sound/firewire/digi00x/digi00x-stream.c
@@ -259,8 +259,10 @@ int snd_dg00x_stream_init_duplex(struct snd_dg00x *dg00x)
 		return err;
 
 	err = init_stream(dg00x, &dg00x->tx_stream);
-	if (err < 0)
+	if (err < 0) {
 		destroy_stream(dg00x, &dg00x->rx_stream);
+		return err;
+	}
 
 	err = amdtp_domain_init(&dg00x->domain);
 	if (err < 0) {
-- 
2.39.2



