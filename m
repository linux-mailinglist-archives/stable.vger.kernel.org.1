Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839E06FA60F
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjEHKPs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjEHKPr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAC83AA0A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFBF6248A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EACCC433D2;
        Mon,  8 May 2023 10:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540945;
        bh=gg0wWCJjlLBpsAl2t/fYYFgCGyh4qfQb8ZDKeNIUork=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQQpoKfSkxquPYb2u7S7gwQwQKBTIT3lz9qFTFPwsMGN8tD7S0f7FIG9KwNsx+411
         cLXeOtnExZtJISgwj19HZ14U/UA6fpKWRkroqWBADzzVEQBP2TC2R9b/Rvo+3pzCv+
         A7MWITpP3HPztbDSjZBEMliuiPLJz0UQ5jKUMu5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phong Hoang <phong.hoang.wz@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 526/611] pinctrl: renesas: r8a779f0: Fix tsn1_avtp_pps pin group
Date:   Mon,  8 May 2023 11:46:08 +0200
Message-Id: <20230508094439.102407623@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Phong Hoang <phong.hoang.wz@renesas.com>

[ Upstream commit 60003351e99167d8cfa7c161e95856efc016f381 ]

Correct a typo mistake in the definition of the tsn1_avtp_pps pin group
mux.

Signed-off-by: Phong Hoang <phong.hoang.wz@renesas.com>
Fixes: babe298e9caaa3d7 ("pinctrl: renesas: r8a779f0: Add Ethernet pins, groups, and functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/45ea6e87b91c36fd0b9706cf58ff50a4d1a99c44.1674825039.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pfc-r8a779f0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779f0.c b/drivers/pinctrl/renesas/pfc-r8a779f0.c
index 417c357f16b19..65c141ce909ac 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779f0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779f0.c
@@ -1213,7 +1213,7 @@ static const unsigned int tsn1_avtp_pps_pins[] = {
 	RCAR_GP_PIN(3, 13),
 };
 static const unsigned int tsn1_avtp_pps_mux[] = {
-	TSN0_AVTP_PPS_MARK,
+	TSN1_AVTP_PPS_MARK,
 };
 static const unsigned int tsn1_avtp_capture_a_pins[] = {
 	/* TSN1_AVTP_CAPTURE_A */
-- 
2.39.2



