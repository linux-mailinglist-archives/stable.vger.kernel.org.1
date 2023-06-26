Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5679673E896
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjFZS1U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjFZS0z (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:26:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1810D2
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:26:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED8B60EFC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A383C433CA;
        Mon, 26 Jun 2023 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803992;
        bh=zLFmXR4yc5DU/V5y29p2DeWsmiV4dH7qGzetBSpoCIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uw074w/ptesdCbPWzTguxvTrEMim7E0+THuAnBR+AWXytnHR/ezkBgPCPMfjeVTou
         mEATQLVqNuNKOZxU1ptkERzhAVQTQMxgNsdDi8F40rIBCReLQevOPX8Itv/5FIj1wV
         AXLyr0dUNckHrO0nY8coA+aG9ckg1R26zeIzgY3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/41] s390/cio: unregister device when the only path is gone
Date:   Mon, 26 Jun 2023 20:11:58 +0200
Message-ID: <20230626180737.581146563@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180736.243379844@linuxfoundation.org>
References: <20230626180736.243379844@linuxfoundation.org>
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

From: Vineeth Vijayan <vneethv@linux.ibm.com>

[ Upstream commit 89c0c62e947a01e7a36b54582fd9c9e346170255 ]

Currently, if the device is offline and all the channel paths are
either configured or varied offline, the associated subchannel gets
unregistered. Don't unregister the subchannel, instead unregister
offline device.

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index c9bc9a6bd73b7..ee4338158ae2e 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1353,6 +1353,7 @@ void ccw_device_set_notoper(struct ccw_device *cdev)
 enum io_sch_action {
 	IO_SCH_UNREG,
 	IO_SCH_ORPH_UNREG,
+	IO_SCH_UNREG_CDEV,
 	IO_SCH_ATTACH,
 	IO_SCH_UNREG_ATTACH,
 	IO_SCH_ORPH_ATTACH,
@@ -1385,7 +1386,7 @@ static enum io_sch_action sch_get_action(struct subchannel *sch)
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
 		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
-			return IO_SCH_UNREG;
+			return IO_SCH_UNREG_CDEV;
 		return IO_SCH_DISC;
 	}
 	if (device_is_disconnected(cdev))
@@ -1447,6 +1448,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	case IO_SCH_ORPH_ATTACH:
 		ccw_device_set_disconnected(cdev);
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 	case IO_SCH_UNREG:
 		if (!cdev)
@@ -1480,6 +1482,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 		if (rc)
 			goto out;
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 		spin_lock_irqsave(sch->lock, flags);
 		if (cdev->private->flags.resuming) {
-- 
2.39.2



