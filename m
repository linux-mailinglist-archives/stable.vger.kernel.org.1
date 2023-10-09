Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5147BDEF7
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376614AbjJINZC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376626AbjJINZB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:25:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48690CA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:25:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E79EC433C8;
        Mon,  9 Oct 2023 13:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857899;
        bh=FNaUEuZyx/z/bqXG87F267eBDzQTHk11B6XOXdFYaUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wg80ijAuq3wlfll/GqsZSwp4IB6hC/AtN+ksdBgIpSAy7rJsBsRdaCfma+0yhYt1l
         l3RseXIxk94MqeJRWLU0Tr0DADFk4z0w0s1juvBT/PgYLjVTL+g5YSr3nvaMgwZMH9
         n+kQJhDBCqc2UPtAkvycZOI7PVV+fFL0IlB2kf3g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 28/75] HID: sony: Fix a potential memory leak in sony_probe()
Date:   Mon,  9 Oct 2023 15:01:50 +0200
Message-ID: <20231009130112.216847429@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 60ec2b29d54de..3ab18811b0090 100644
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



