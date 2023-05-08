Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B56FAC06
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjEHLUB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjEHLTz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6637C74
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:19:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB3E62C63
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D0EC433EF;
        Mon,  8 May 2023 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544791;
        bh=2HE7cBAkhH1rYywG8/ZuDvlgZIOaAeoVhwQc1IRCbak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QS50uRmJyoRtQZpzcFh1onQRBGJR6IKY2Q0ZmEQyZgjyPRFJSOSxeELZjZkHYiTn4
         zbF7zGSjk1a5aCmvTpnR/rtD7MrHa6zYgbKOGdgTBRECsqobgGbOMg/sEWBD8dS3bH
         XFIu4ir4qdPC0UmKCu9OLQYFH3z21qZebSyS6F+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 525/694] HID: amd_sfh: Correct the sensor enable and disable command
Date:   Mon,  8 May 2023 11:46:00 +0200
Message-Id: <20230508094451.338337002@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit 0b9255bf11baa61cd526e6bd24d6c8e6d1eabf8d ]

In order to start or stop sensors, the firmware command needs to be
changed to add an additional default subcommand value. For this reason,
add a subcommand value to enable or disable sensors accordingly.

Fixes: 93ce5e0231d7 ("HID: amd_sfh: Implement SFH1.1 functionality")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index c6df959ec7252..6e19ccc124508 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -33,6 +33,7 @@ static void amd_start_sensor(struct amd_mp2_dev *privdata, struct amd_mp2_sensor
 	cmd_base.ul = 0;
 	cmd_base.cmd.cmd_id = ENABLE_SENSOR;
 	cmd_base.cmd.intr_disable = 0;
+	cmd_base.cmd.sub_cmd_value = 1;
 	cmd_base.cmd.sensor_id = info.sensor_idx;
 
 	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG(0));
@@ -45,6 +46,7 @@ static void amd_stop_sensor(struct amd_mp2_dev *privdata, u16 sensor_idx)
 	cmd_base.ul = 0;
 	cmd_base.cmd.cmd_id = DISABLE_SENSOR;
 	cmd_base.cmd.intr_disable = 0;
+	cmd_base.cmd.sub_cmd_value = 1;
 	cmd_base.cmd.sensor_id = sensor_idx;
 
 	writeq(0x0, privdata->mmio + AMD_C2P_MSG(1));
-- 
2.39.2



