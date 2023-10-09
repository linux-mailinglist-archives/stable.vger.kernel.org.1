Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7467BDE8E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbjJINUj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjJINUh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:20:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FCC99
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:20:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B596DC433C9;
        Mon,  9 Oct 2023 13:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857636;
        bh=ZpNh7U8auLYhXNBi0f7rbF42CVheHGUaUR8wfSaX9MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSDWqgcN1nEo07Wv+wrau6I+VbiRkip1COq69k5GP1fGaGBDbNZAOXkFhtlrv/cWm
         pL1otPe7n76dJ7SeGCHdTP18OqAP4egmkn9PsTzq/eljDo2RPJs9PAgGE/EfTmttE2
         sAPwMlNVWtW9ucfojZGVGrWHq4VhXEJsoVfTFY50=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 072/162] HID: sony: Fix a potential memory leak in sony_probe()
Date:   Mon,  9 Oct 2023 15:00:53 +0200
Message-ID: <20231009130124.909061697@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit e1cd4004cde7c9b694bbdd8def0e02288ee58c74 ]

If an error occurs after a successful usb_alloc_urb() call, usb_free_urb()
should be called.

Fixes: fb1a79a6b6e1 ("HID: sony: fix freeze when inserting ghlive ps3/wii dongles")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sony.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 03691cdcfb8e1..5b3f58e068807 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -3074,6 +3074,9 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 
 err:
+	if (sc->ghl_urb)
+		usb_free_urb(sc->ghl_urb);
+
 	hid_hw_stop(hdev);
 	return ret;
 }
-- 
2.40.1



