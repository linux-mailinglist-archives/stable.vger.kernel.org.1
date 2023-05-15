Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3425703C17
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbjEOSJW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243053AbjEOSIz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B9283F1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02C8F630E1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD76C4339B;
        Mon, 15 May 2023 18:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684174008;
        bh=qUwQsvNznCDDRqWvbe412XaoqyGTuAfKS9745Akftf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kC+NpcvyjoCuVwbTR+I1iaY1MmL1uXbQ0JwsB1FIE1mArJ8NyLfq0aVfFHCmt+FB4
         b5uOvMBELEQleTp3JhBfdiAEcKpX6m1UgpJHNJ1G9D+l1ytsTItHZUSyeUl/QloY5v
         LP5VaPNbRTm0ANdVj8vPWGNB9sOF9UFx3xgKIsHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH 5.4 278/282] firmware: raspberrypi: fix possible memory leak in rpi_firmware_probe()
Date:   Mon, 15 May 2023 18:30:56 +0200
Message-Id: <20230515161730.708685864@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Yang Yingliang <yangyingliang@huawei.com>

commit 7b51161696e803fd5f9ad55b20a64c2df313f95c upstream.

In rpi_firmware_probe(), if mbox_request_channel() fails, the 'fw' will
not be freed through rpi_firmware_delete(), fix this leak by calling
kfree() in the error path.

Fixes: 1e7c57355a3b ("firmware: raspberrypi: Keep count of all consumers")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20221117070636.3849773-1-yangyingliang@huawei.com
Acked-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/raspberrypi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -261,6 +261,7 @@ static int rpi_firmware_probe(struct pla
 		int ret = PTR_ERR(fw->chan);
 		if (ret != -EPROBE_DEFER)
 			dev_err(dev, "Failed to get mbox channel: %d\n", ret);
+		kfree(fw);
 		return ret;
 	}
 


