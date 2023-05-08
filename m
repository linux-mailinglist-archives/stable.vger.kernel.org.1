Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D857E6FA4A6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjEHKBv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjEHKBp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:01:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B182E6AB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:01:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11682622C3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:01:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067FFC433D2;
        Mon,  8 May 2023 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540095;
        bh=mCHETOXHoZHktRoq32n/qCx+jYqqgkdt4xtbP3NPo7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I+GMJyugDf/GJ6H/+OQf23EBHXStnlRr9yxHg+d23hHihgd/vtMknRPx8qimGZJX+
         DHdGuy/69c6582NhgRjj0Q+53gkllSBVah1K7n8OIeop1808GeNLitzA7U6Y7v53VQ
         nwO7rr5HwWVu4VNTurWBxY6egGZItfo/HiBwTTx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 236/611] platform/x86/amd: pmc: Dont try to read SMU version on Picasso
Date:   Mon,  8 May 2023 11:41:18 +0200
Message-Id: <20230508094430.067239670@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit b845772677ea19b8e4c032bc07393ef32de4ee39 ]

Picasso doesn't support the command in the uPEP mailbox to try to
read the SMU version.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2449
Fixes: f6045de1f532 ("platform/x86: amd-pmc: Export Idlemask values based on the APU")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230409185348.556161-2-Shyam-sundar.S-k@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index be1b49824edbd..5ff284b6c3eb4 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -373,6 +373,9 @@ static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
 	int rc;
 	u32 val;
 
+	if (dev->cpu_id == AMD_CPU_ID_PCO)
+		return -ENODEV;
+
 	rc = amd_pmc_send_cmd(dev, 0, &val, SMU_MSG_GETSMUVERSION, 1);
 	if (rc)
 		return rc;
-- 
2.39.2



