Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB5B6FA8B3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjEHKom (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbjEHKoA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415362A9DC
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:42:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 760BE62857
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA50C433D2;
        Mon,  8 May 2023 10:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542565;
        bh=StmVsysVd4p1rnWmO2N1aV30ZfZtt5Np3+56CZNJ9fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pAxJeIPlK+z7uUij5Ey+RE3rWUmj1Kziqm+tCrrqxVvqyUYz5mAVoJKtxZTwz27PM
         owGu5E/V3IJebdB74YZH+7NSB08dq7s9Zat85yOxJeDx6yRR21woGW9YAPU49zdrrI
         bERSop2mmrxdwm0ZOUWP9TRh1hcBI57QVdU66B4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 476/663] HID: amd_sfh: Increase sensor command timeout for SFH1.1
Date:   Mon,  8 May 2023 11:45:02 +0200
Message-Id: <20230508094443.730044147@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit 571dc8f59dd477037bb5a029e8d1b5a4a4d9dd63 ]

The initialization of SFH1.1 sensors may take some time. Hence, increase
sensor command timeouts in order to obtain status responses within a
maximum timeout.

Fixes: 93ce5e0231d7 ("HID: amd_sfh: Implement SFH1.1 functionality")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index 6f6047f7f12e9..4f81ef2d4f56e 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -16,11 +16,11 @@ static int amd_sfh_wait_response(struct amd_mp2_dev *mp2, u8 sid, u32 cmd_id)
 {
 	struct sfh_cmd_response cmd_resp;
 
-	/* Get response with status within a max of 1600 ms timeout */
+	/* Get response with status within a max of 10000 ms timeout */
 	if (!readl_poll_timeout(mp2->mmio + AMD_P2C_MSG(0), cmd_resp.resp,
 				(cmd_resp.response.response == 0 &&
 				cmd_resp.response.cmd_id == cmd_id && (sid == 0xff ||
-				cmd_resp.response.sensor_id == sid)), 500, 1600000))
+				cmd_resp.response.sensor_id == sid)), 500, 10000000))
 		return cmd_resp.response.response;
 
 	return -1;
-- 
2.39.2



