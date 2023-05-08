Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E3D6FA8B1
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbjEHKod (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjEHKnv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:43:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCED26EBD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36E466285D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2AEC433D2;
        Mon,  8 May 2023 10:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542559;
        bh=nwKkOU7fRPygFwl7dL6Q7xGSBIAmTYHM68+y6GOfCVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAeQa3pk6rP8Idsa08FaRI40F8Edm2nX6WXj+wguNH/UnbCGbInL7BJcVM12AInqy
         kI6+oKXqwVLkQDyqecvffpWXUJw0i80eIzlkcj6lzSzJvNjALwBfQI3bAqSKXgfhMH
         zM3gTyZnCXggzJ3fa+jQy6i3c5lMTK0DnU2ZoMF4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 474/663] HID: amd_sfh: Add support for shutdown operation
Date:   Mon,  8 May 2023 11:45:00 +0200
Message-Id: <20230508094443.646050265@linuxfoundation.org>
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

[ Upstream commit 1353ecaf1830d6d1b74f3225378a9498b4e14fdd ]

As soon as the system is booted after shutdown, the sensors may remain in
a weird state and fail to initialize. Therefore, all sensors should be
turned off during shutdown.

Fixes: 4f567b9f8141 ("SFH: PCIe driver to add support of AMD sensor fusion hub")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 47774b9ab3de0..c936d6a51c0cd 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -367,6 +367,14 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	return devm_add_action_or_reset(&pdev->dev, privdata->mp2_ops->remove, privdata);
 }
 
+static void amd_sfh_shutdown(struct pci_dev *pdev)
+{
+	struct amd_mp2_dev *mp2 = pci_get_drvdata(pdev);
+
+	if (mp2 && mp2->mp2_ops)
+		mp2->mp2_ops->stop_all(mp2);
+}
+
 static int __maybe_unused amd_mp2_pci_resume(struct device *dev)
 {
 	struct amd_mp2_dev *mp2 = dev_get_drvdata(dev);
@@ -401,6 +409,7 @@ static struct pci_driver amd_mp2_pci_driver = {
 	.id_table	= amd_mp2_pci_tbl,
 	.probe		= amd_mp2_pci_probe,
 	.driver.pm	= &amd_mp2_pm_ops,
+	.shutdown	= amd_sfh_shutdown,
 };
 module_pci_driver(amd_mp2_pci_driver);
 
-- 
2.39.2



