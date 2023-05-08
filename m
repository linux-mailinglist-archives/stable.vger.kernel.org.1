Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D625D6FA8B2
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbjEHKoh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjEHKnz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:43:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3DB2A9D2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B6B262869
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2940DC433EF;
        Mon,  8 May 2023 10:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542562;
        bh=W29Abkm0TWikFEtq8/EsxEVpSoYVm4vLwO0LW4PF61k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=An77RDVIdV2ziL4GePlBFIEFqRsjUqiA2tra/x+dOm7EjzfY+JpRIOMFvkxRCrlKV
         gejfDiIs/vipTpKeHYX7K7CGJXnNx05W5PxcSxzHIo/JEFq6HBVnV0r2d65eWN7Vqw
         m/+uKYGZY/QTMkNzMkFc6J9817l0OjmQnhlS7Cus=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 475/663] HID: amd_sfh: Correct the stop all command
Date:   Mon,  8 May 2023 11:45:01 +0200
Message-Id: <20230508094443.693848983@linuxfoundation.org>
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

[ Upstream commit 82c2a0d137794f5ef47982231593a00aee26ce3b ]

Misinterpreted the stop all command in SHF1.1 firmware. Therefore, it is
necessary to update the stop all command accordingly to disable all
sensors.

Fixes: 93ce5e0231d7 ("HID: amd_sfh: Implement SFH1.1 functionality")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
index 6e19ccc124508..6f6047f7f12e9 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.c
@@ -58,8 +58,10 @@ static void amd_stop_all_sensor(struct amd_mp2_dev *privdata)
 	struct sfh_cmd_base cmd_base;
 
 	cmd_base.ul = 0;
-	cmd_base.cmd.cmd_id = STOP_ALL_SENSORS;
+	cmd_base.cmd.cmd_id = DISABLE_SENSOR;
 	cmd_base.cmd.intr_disable = 0;
+	/* 0xf indicates all sensors */
+	cmd_base.cmd.sensor_id = 0xf;
 
 	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG(0));
 }
-- 
2.39.2



