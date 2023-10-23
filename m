Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE017D35CA
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbjJWLwB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjJWLv6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:51:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EB210F7
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:51:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF5AC433C8;
        Mon, 23 Oct 2023 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061906;
        bh=3PDAipX367pKIut6wOO90XEnYUBV25vqb2z1UqhCmmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbikgRtly/8PccbA159HaY94q//D2yRD9rRjenEeL1kkTJIFE7nNhsg/aoK4tSIaO
         DIXt2MqwAfB0gVfPe2JC0ueYTGxyxHqnQv2zzsFrzqHJUyqaeyGEKUPJAxZ/gVJE88
         bxrrFoNNeEdEIeMPFkLOCipEGbGlpgvB+/WkOAOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, welsh@cassens.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.10 184/202] nvme-pci: add BOGUS_NID for Intel 0a54 device
Date:   Mon, 23 Oct 2023 12:58:11 +0200
Message-ID: <20231023104831.832057816@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104826.569169691@linuxfoundation.org>
References: <20231023104826.569169691@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <kbusch@kernel.org>

commit 5c3f4066462a5f6cac04d3dd81c9f551fabbc6c7 upstream.

These ones claim cmic and nmic capable, so need special consideration to ignore
their duplicate identifiers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
Reported-by: welsh@cassens.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3181,7 +3181,8 @@ static const struct pci_device_id nvme_i
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },


