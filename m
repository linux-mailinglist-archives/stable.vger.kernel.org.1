Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931A47D3319
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjJWL0q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbjJWL0q (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:26:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B55592
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:26:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB0CC433C7;
        Mon, 23 Oct 2023 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060403;
        bh=Olwpl6IpUHbZ2Tb6BQILlaK3pmEYma6F2uYGi1uuMEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ix8PWOArZ/9k9MFAUDDSU2m+SM2/6/r1AZJUrlZ0Vcef4avFxNAQS6OAJxbuG/uCU
         em8RjX0FjGiSlU/utOIAqOaQXgucUQ9YbTKd7lhGyEj0hjZphYMy07p8UxaA8LT+NH
         xXpmLM7vCNuUfjAvXNtHc8DSpsUc0peJLyd5t90M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, welsh@cassens.com,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.1 160/196] nvme-pci: add BOGUS_NID for Intel 0a54 device
Date:   Mon, 23 Oct 2023 12:57:05 +0200
Message-ID: <20231023104832.973045886@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3439,7 +3439,8 @@ static const struct pci_device_id nvme_i
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },


