Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5223726B78
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjFGUZi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjFGUZe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF3D26BE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:25:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6657564444
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74425C433EF;
        Wed,  7 Jun 2023 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169503;
        bh=LEXUqYnFYNBp/lSZwiBu4F7bB23102+sZXyYbD4ZC0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsmlCN2pGSoJUHdbBH6Pk/CB/yXq6/OzSTZBle8MCfwdOX1fTl0RdYappbabixQpU
         FkQUXkO41huW0pNQhVP8A1SvpqGD82mmFZMHvWwC4kuFenJa2RNVIv5VKdn0dHPC5E
         dV0JFA5Dd7/QNC6+h80TY0BWdh5k9YUDjmWRrFY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 098/286] hwmon: (k10temp) Add PCI ID for family 19, model 78h
Date:   Wed,  7 Jun 2023 22:13:17 +0200
Message-ID: <20230607200926.261175307@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 7d8accfaa0ab65e4282c8e58950f7d688342cd86 ]

Enable k10temp on this system.

  [ bp: Massage. ]

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230427053338.16653-3-mario.limonciello@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index be8bbb1c3a02d..823d0ca1d6059 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -507,6 +507,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.39.2



