Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839397A7F52
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbjITM0Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjITM0P (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:26:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CFCE6
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:26:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB3DC433CC;
        Wed, 20 Sep 2023 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212767;
        bh=TBa8nFEsW81o7irTuW+LEpYeOqTQ1q8PX6E0dLvfWD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmiOQXUxVD6sE8YXRLn5k1+JLAkW91ap72fUENFXBxE4Hz4SQyR6x0ypbUhwbJHfE
         ydxaNTptkaUUGzkGeATeGg+HwDA755HJh0sKiNgLD7ef37Dis6xD55VhjHYk4rWcgM
         CRjY5b/KZn6VLmn62IFZDSBNN/ibHmFUat7QAeTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "Denis Efremov (Oracle)" <efremov@linux.com>
Subject: [PATCH 5.4 011/367] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
Date:   Wed, 20 Sep 2023 13:26:28 +0200
Message-ID: <20230920112858.794072521@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Wang <zyytlz.wz@163.com>

commit 73f7b171b7c09139eb3c6a5677c200dc1be5f318 upstream.

In btsdio_probe, the data->work is bound with btsdio_work. It will be
started in btsdio_send_frame.

If the btsdio_remove runs with a unfinished work, there may be a race
condition that hdev is freed but used in btsdio_work. Fix it by
canceling the work before do cleanup in btsdio_remove.

Fixes: CVE-2023-1989
Fixes: ddbaf13e3609 ("[Bluetooth] Add generic driver for Bluetooth SDIO devices")
Cc: stable@vger.kernel.org
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ Denis: Added CVE-2023-1989 and fixes tags. ]
Signed-off-by: Denis Efremov (Oracle) <efremov@linux.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btsdio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -346,6 +346,7 @@ static void btsdio_remove(struct sdio_fu
 	if (!data)
 		return;
 
+	cancel_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);


