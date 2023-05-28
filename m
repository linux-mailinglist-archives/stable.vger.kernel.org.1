Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81275713D4F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjE1TYB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjE1TYB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:24:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37308B1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9CC061B84
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38A6C433EF;
        Sun, 28 May 2023 19:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301839;
        bh=kSat0sJ/N0+p8ggDTwS2c1Cf9r4fIShQhZT+PG8AXTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOR4t0+A09PV+LPf4RdYulppquoCQ6wERZ0K4IalzzBJSmpUozZIi0V5jLATIzuOn
         vyQBjZOWc+oJnjzfpGVvc0rMR+uJQkvfsV8aSorPTG6+mGGyUfPJhFit/zQDDHKwqj
         MjF1woNlubp6N3wMHP3P7NbNlLoo8KMnd1hVaGPU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qiang Ning <qning0106@126.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 056/161] mfd: dln2: Fix memory leak in dln2_probe()
Date:   Sun, 28 May 2023 20:09:40 +0100
Message-Id: <20230528190838.977407271@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
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

From: Qiang Ning <qning0106@126.com>

[ Upstream commit 96da8f148396329ba769246cb8ceaa35f1ddfc48 ]

When dln2_setup_rx_urbs() in dln2_probe() fails, error out_free forgets
to call usb_put_dev() to decrease the refcount of dln2->usb_dev.

Fix this by adding usb_put_dev() in the error handling code of
dln2_probe().

Signed-off-by: Qiang Ning <qning0106@126.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230330024353.4503-1-qning0106@126.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/dln2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 707f4287ab4a0..80952237e4b43 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -797,6 +797,7 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
+	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
-- 
2.39.2



