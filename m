Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C279B7CF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243129AbjIKU7H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241031AbjIKPAP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:00:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D81B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:00:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4053C433C8;
        Mon, 11 Sep 2023 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444411;
        bh=A5R10nuCdMOKJJ30O9kEIBoUJlnRfor0y7GjoTMv4sM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ygRTLBG133GBgUuDQgCjHH9KS+nsRV+4Yizj1XvxUjxf5IWGF25sWp/3gC3XW1x3B
         iWw+TjOl7tit8Tm8GwcTtN5l7fiNI87OVlIqSHoCiGuRwA845S0oACDfHJo+bFz+Gk
         QLSkXB2J1m7bqdEBXk2stFY3nUVdxH3WSt354ZS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yunlong Xing <yunlong.xing@unisoc.com>,
        Enlin Mu <enlin.mu@unisoc.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 6.4 703/737] pstore/ram: Check start of empty przs during init
Date:   Mon, 11 Sep 2023 15:49:22 +0200
Message-ID: <20230911134710.159047777@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Enlin Mu <enlin.mu@unisoc.com>

commit fe8c3623ab06603eb760444a032d426542212021 upstream.

After commit 30696378f68a ("pstore/ram: Do not treat empty buffers as
valid"), initialization would assume a prz was valid after seeing that
the buffer_size is zero (regardless of the buffer start position). This
unchecked start value means it could be outside the bounds of the buffer,
leading to future access panics when written to:

 sysdump_panic_event+0x3b4/0x5b8
 atomic_notifier_call_chain+0x54/0x90
 panic+0x1c8/0x42c
 die+0x29c/0x2a8
 die_kernel_fault+0x68/0x78
 __do_kernel_fault+0x1c4/0x1e0
 do_bad_area+0x40/0x100
 do_translation_fault+0x68/0x80
 do_mem_abort+0x68/0xf8
 el1_da+0x1c/0xc0
 __raw_writeb+0x38/0x174
 __memcpy_toio+0x40/0xac
 persistent_ram_update+0x44/0x12c
 persistent_ram_write+0x1a8/0x1b8
 ramoops_pstore_write+0x198/0x1e8
 pstore_console_write+0x94/0xe0
 ...

To avoid this, also check if the prz start is 0 during the initialization
phase. If not, the next prz sanity check case will discover it (start >
size) and zap the buffer back to a sane state.

Fixes: 30696378f68a ("pstore/ram: Do not treat empty buffers as valid")
Cc: Yunlong Xing <yunlong.xing@unisoc.com>
Cc: stable@vger.kernel.org
Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
Link: https://lore.kernel.org/r/20230801060432.1307717-1-yunlong.xing@unisoc.com
[kees: update commit log with backtrace and clarifications]
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/pstore/ram_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -519,7 +519,7 @@ static int persistent_ram_post_init(stru
 	sig ^= PERSISTENT_RAM_SIG;
 
 	if (prz->buffer->sig == sig) {
-		if (buffer_size(prz) == 0) {
+		if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
 			pr_debug("found existing empty buffer\n");
 			return 0;
 		}


