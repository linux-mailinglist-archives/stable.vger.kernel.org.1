Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57477791D36
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243664AbjIDSgU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349133AbjIDSgT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 14:36:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A181702
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 11:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93711616CC
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 18:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67ECC433C7;
        Mon,  4 Sep 2023 18:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693852572;
        bh=0o0K5fduYPQwiQvZH5GjCwDM3+alAL5XocwGwgDv6A8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0CPfcGkI1+5M3aVmRIvEXKzkc5Li5ELSnTe6+mZaKg+qzmXFFYd4+MHmT+KKrnvYx
         COixFAcZwbcpVlrGLz1zgusZ1jH0YHisDXa2/YZKNDmFv9vmcVsRSBwDDds/tx8zs/
         kfyftEOiirqi9lghDHM4T1k9SO8mnyR+fjYhI5/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        "Denis Efremov (Oracle)" <efremov@linux.com>
Subject: [PATCH 5.15 16/28] Bluetooth: btsdio: fix use after free bug in btsdio_remove due to race condition
Date:   Mon,  4 Sep 2023 19:30:47 +0100
Message-ID: <20230904182945.945335299@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
References: <20230904182945.178705038@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -355,6 +355,7 @@ static void btsdio_remove(struct sdio_fu
 	if (!data)
 		return;
 
+	cancel_work_sync(&data->work);
 	hdev = data->hdev;
 
 	sdio_set_drvdata(func, NULL);


