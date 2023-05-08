Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8938D6FA787
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbjEHKbn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234709AbjEHKbT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E4724A84
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:31:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D65626D5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E83C433EF;
        Mon,  8 May 2023 10:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541868;
        bh=45TUghb7z81EybmeblL2XNVdvREe9kqYDNJ67uuIYuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GgwrfrOLmMI/sGg4WJj0VU63qcLO2eWDLeBHtYcFXiP3KKOQslIOCAZtPhCDwbCqL
         HWU2hJ70lON/gCXr16cfd1jytPZWNx5rYnpDLDExk8wgVSzVxsPoQeIXnsL/B51/Z1
         undVWJkMCbDPFEEbDYysFD1qtaBF2sgdl/LYwWh8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 253/663] media: dm1105: Fix use after free bug in dm1105_remove due to race condition
Date:   Mon,  8 May 2023 11:41:19 +0200
Message-Id: <20230508094436.469302963@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 5abda7a16698d4d1f47af1168d8fa2c640116b4a ]

In dm1105_probe, it called dm1105_ir_init and bound
&dm1105->ir.work with dm1105_emit_key.
When it handles IRQ request with dm1105_irq,
it may call schedule_work to start the work.

When we call dm1105_remove to remove the driver, there
may be a sequence as follows:

Fix it by finishing the work before cleanup in dm1105_remove

CPU0                  CPU1

                    |dm1105_emit_key
dm1105_remove      |
  dm1105_ir_exit       |
    rc_unregister_device |
    rc_free_device  |
    rc_dev_release  |
    kfree(dev);     |
                    |
                    | rc_keydown
                    |   //use

Fixes: 34d2f9bf189c ("V4L/DVB: dm1105: use dm1105_dev & dev instead of dm1105dvb")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/dm1105/dm1105.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index 4ac645a56c14e..9e9c7c071accc 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -1176,6 +1176,7 @@ static void dm1105_remove(struct pci_dev *pdev)
 	struct dvb_demux *dvbdemux = &dev->demux;
 	struct dmx_demux *dmx = &dvbdemux->dmx;
 
+	cancel_work_sync(&dev->ir.work);
 	dm1105_ir_exit(dev);
 	dmx->close(dmx);
 	dvb_net_release(&dev->dvbnet);
-- 
2.39.2



