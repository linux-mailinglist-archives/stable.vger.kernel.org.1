Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F274A79B9EB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjIKWKA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240672AbjIKOug (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:50:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE8A106
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:50:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD72AC433C8;
        Mon, 11 Sep 2023 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443832;
        bh=PSIjA8qXUnbtXkfscTGbVvTIWWIdmphAaBZDxVHeXbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCV2FXpnQCOgoYQfUTBVUQR8dz6/vEuTlmwfAv3J84HQhmUnZEbNZTbN3xyO6V/Y8
         oMbd/DThIrgv4yrCGQ3Lal/Qfyo3hZ651UzlqOXxyzwU2d+f8gfkZNbXCFA/39jIGs
         yB63zT5ZfTR5enAjHmRlJFnjdTuTXiDkbQEYDiPg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniil Dulov <d.dulov@aladdin.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 490/737] media: cx24120: Add retval check for cx24120_message_send()
Date:   Mon, 11 Sep 2023 15:45:49 +0200
Message-ID: <20230911134704.264008388@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniil Dulov <d.dulov@aladdin.ru>

[ Upstream commit 96002c0ac824e1773d3f706b1f92e2a9f2988047 ]

If cx24120_message_send() returns error, we should keep local struct
unchanged.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5afc9a25be8d ("[media] Add support for TechniSat Skystar S2")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/dvb-frontends/cx24120.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/cx24120.c b/drivers/media/dvb-frontends/cx24120.c
index d8acd582c7111..0f778660c72b8 100644
--- a/drivers/media/dvb-frontends/cx24120.c
+++ b/drivers/media/dvb-frontends/cx24120.c
@@ -973,7 +973,9 @@ static void cx24120_set_clock_ratios(struct dvb_frontend *fe)
 	cmd.arg[8] = (clock_ratios_table[idx].rate >> 8) & 0xff;
 	cmd.arg[9] = (clock_ratios_table[idx].rate >> 0) & 0xff;
 
-	cx24120_message_send(state, &cmd);
+	ret = cx24120_message_send(state, &cmd);
+	if (ret != 0)
+		return;
 
 	/* Calculate ber window rates for stat work */
 	cx24120_calculate_ber_window(state, clock_ratios_table[idx].rate);
-- 
2.40.1



