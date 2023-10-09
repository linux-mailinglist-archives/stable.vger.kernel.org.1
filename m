Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71607BDECF
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376442AbjJINXZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376439AbjJINXZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:23:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189FC8F
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:23:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5814AC433C7;
        Mon,  9 Oct 2023 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857801;
        bh=coihKcqwiyuGHtuTu4BlHycKWS8vg/P5F13kDCThYnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxXQmo+CB/Ja0te+CgdcVOsnjQNIZLwjMQpBOm7r8V/MYyggdUDLIPOuD2MQ9PSTA
         df5Y7RcgDSwHLBrjnZFMEgZ5ol1tVppmt9Skx+oODTWNU27fKeN+JuRWFck1Cy2w5Y
         lwi0WD8M8g9T1b7ZPj5Nhgp89xHvi46zSN/JogDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 134/162] HID: sony: remove duplicate NULL check before calling usb_free_urb()
Date:   Mon,  9 Oct 2023 15:01:55 +0200
Message-ID: <20231009130126.611625239@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130122.946357448@linuxfoundation.org>
References: <20231009130122.946357448@linuxfoundation.org>
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

From: Jiri Kosina <jkosina@suse.cz>

[ Upstream commit b328dd02e19cb9d3b35de4322f5363516a20ac8c ]

usb_free_urb() does the NULL check itself, so there is no need to duplicate
it prior to calling.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e1cd4004cde7c9 ("HID: sony: Fix a potential memory leak in sony_probe()")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 5b3f58e068807..f7f7252d839ee 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -3074,8 +3074,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 
 err:
-	if (sc->ghl_urb)
-		usb_free_urb(sc->ghl_urb);
+	usb_free_urb(sc->ghl_urb);
 
 	hid_hw_stop(hdev);
 	return ret;
-- 
2.40.1



