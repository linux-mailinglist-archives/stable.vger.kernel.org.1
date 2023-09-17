Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29037A3C22
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbjIQU1P (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbjIQU0x (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:26:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10522101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:26:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A28C433C8;
        Sun, 17 Sep 2023 20:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982407;
        bh=gbqdj+Qn+G3UR9RR4Y5NAkEyVCI2EtLnlphmXNLNlq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SFdWrR7wy24Sank/GFUhZrTI4Ts2DXXy81R29mF8b+xuObGBkCIeLgBn7qZo4z+AJ
         uaD8lozMaeBbzhufy4uDL1bHupxfvdkoexYH7xrUQgTlBBscKbCvzBq3EcF9NRBgBo
         NNYFaSMXzQ2aN3xF7u88YP1l0CkTcYQTn0yDaZx0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniil Dulov <d.dulov@aladdin.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 241/511] media: dib7000p: Fix potential division by zero
Date:   Sun, 17 Sep 2023 21:11:08 +0200
Message-ID: <20230917191119.635189941@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit a1db7b2c5533fc67e2681eb5efc921a67bc7d5b8 ]

Variable loopdiv can be assigned 0, then it is used as a denominator,
without checking it for 0.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 713d54a8bd81 ("[media] DiB7090: add support for the dib7090 based")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil: (bw != NULL) -> bw]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/dib7000p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index 55bee50aa8716..1f0b0690198ef 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -497,7 +497,7 @@ static int dib7000p_update_pll(struct dvb_frontend *fe, struct dibx000_bandwidth
 	prediv = reg_1856 & 0x3f;
 	loopdiv = (reg_1856 >> 6) & 0x3f;
 
-	if ((bw != NULL) && (bw->pll_prediv != prediv || bw->pll_ratio != loopdiv)) {
+	if (loopdiv && bw && (bw->pll_prediv != prediv || bw->pll_ratio != loopdiv)) {
 		dprintk("Updating pll (prediv: old =  %d new = %d ; loopdiv : old = %d new = %d)\n", prediv, bw->pll_prediv, loopdiv, bw->pll_ratio);
 		reg_1856 &= 0xf000;
 		reg_1857 = dib7000p_read_word(state, 1857);
-- 
2.40.1



