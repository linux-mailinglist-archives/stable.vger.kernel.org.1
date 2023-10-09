Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CD97BDD64
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376778AbjJINKD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376789AbjJINKB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:10:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5570BCA
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:09:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A19FC433C7;
        Mon,  9 Oct 2023 13:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856999;
        bh=xXkoqQr71+tjcfZhj3sbSj4H+li9XkBEStboXjhFQR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q71ixQxtwchzLXmnA04P8JAmknBzXqa4ubbTSLKHkqNhOCylqB+tEO32UFkR5oY1M
         9YcCfsVmEdGbymhYZGOawjQu4HlvnJKIT4RdXywSa83aYrUfSJ9hjZelmMTHj/ABxp
         1Jspe5LGSA1l2LtxHMskDPPi9pwMBd4Org5OWFfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.5 035/163] Bluetooth: hci_codec: Fix leaking content of local_codecs
Date:   Mon,  9 Oct 2023 14:59:59 +0200
Message-ID: <20231009130124.972803841@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

commit b938790e70540bf4f2e653dcd74b232494d06c8f upstream.

The following memory leak can be observed when the controller supports
codecs which are stored in local_codecs list but the elements are never
freed:

unreferenced object 0xffff88800221d840 (size 32):
  comm "kworker/u3:0", pid 36, jiffies 4294898739 (age 127.060s)
  hex dump (first 32 bytes):
    f8 d3 02 03 80 88 ff ff 80 d8 21 02 80 88 ff ff  ..........!.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffb324f557>] __kmalloc+0x47/0x120
    [<ffffffffb39ef37d>] hci_codec_list_add.isra.0+0x2d/0x160
    [<ffffffffb39ef643>] hci_read_codec_capabilities+0x183/0x270
    [<ffffffffb39ef9ab>] hci_read_supported_codecs+0x1bb/0x2d0
    [<ffffffffb39f162e>] hci_read_local_codecs_sync+0x3e/0x60
    [<ffffffffb39ff1b3>] hci_dev_open_sync+0x943/0x11e0
    [<ffffffffb396d55d>] hci_power_on+0x10d/0x3f0
    [<ffffffffb30c99b4>] process_one_work+0x404/0x800
    [<ffffffffb30ca134>] worker_thread+0x374/0x670
    [<ffffffffb30d9108>] kthread+0x188/0x1c0
    [<ffffffffb304db6b>] ret_from_fork+0x2b/0x50
    [<ffffffffb300206a>] ret_from_fork_asm+0x1a/0x30

Cc: stable@vger.kernel.org
Fixes: 8961987f3f5f ("Bluetooth: Enumerate local supported codec and cache details")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_core.c  |    1 +
 net/bluetooth/hci_event.c |    1 +
 net/bluetooth/hci_sync.c  |    1 +
 3 files changed, 3 insertions(+)

--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2784,6 +2784,7 @@ void hci_release_dev(struct hci_dev *hde
 	hci_conn_params_clear_all(hdev);
 	hci_discovery_filter_clear(hdev);
 	hci_blocked_keys_clear(hdev);
+	hci_codec_list_clear(&hdev->local_codecs);
 	hci_dev_unlock(hdev);
 
 	ida_simple_remove(&hci_index_ida, hdev->id);
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -33,6 +33,7 @@
 
 #include "hci_request.h"
 #include "hci_debugfs.h"
+#include "hci_codec.h"
 #include "a2mp.h"
 #include "amp.h"
 #include "smp.h"
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5095,6 +5095,7 @@ int hci_dev_close_sync(struct hci_dev *h
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
 	bacpy(&hdev->random_addr, BDADDR_ANY);
+	hci_codec_list_clear(&hdev->local_codecs);
 
 	hci_dev_put(hdev);
 	return err;


