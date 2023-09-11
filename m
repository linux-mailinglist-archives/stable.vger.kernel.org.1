Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AFA79BB2A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbjIKV3M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbjIKOZg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:25:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE879DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:25:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE99C433C7;
        Mon, 11 Sep 2023 14:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442331;
        bh=GQS+OrgjP/ZfJNMjtCeHhUdk5Melgb+1OVuHAhU/Stc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fv9we5aL3i6sF6db/IxyMgrSphhfHBHpFUQNEr+vorV5cs28ZhJOhHsgyBbgEi9A
         PvS+Hm9ni5hVc0P53BX7fjHXTYdVxCnIwR1PADKp8L5wTp/3gSshtl6bbMNfq80qgg
         HROThhgTwEzQqncq8CNtbPLxsJNP5XNSYuYYAbKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Song Liu <song@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.5 726/739] x86/build: Fix linker fill bytes quirk/incompatibility for ld.lld
Date:   Mon, 11 Sep 2023 15:48:45 +0200
Message-ID: <20230911134711.351686864@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Liu <song@kernel.org>

commit 65e710899fd19f435f40268f3a92dfaa11f14470 upstream.

With ":text =0xcccc", ld.lld fills unused text area with 0xcccc0000.
Example objdump -D output:

	ffffffff82b04203:       00 00                   add    %al,(%rax)
	ffffffff82b04205:       cc                      int3
	ffffffff82b04206:       cc                      int3
	ffffffff82b04207:       00 00                   add    %al,(%rax)
	ffffffff82b04209:       cc                      int3
	ffffffff82b0420a:       cc                      int3

Replace it with ":text =0xcccccccc", so we get the following instead:

	ffffffff82b04203:       cc                      int3
	ffffffff82b04204:       cc                      int3
	ffffffff82b04205:       cc                      int3
	ffffffff82b04206:       cc                      int3
	ffffffff82b04207:       cc                      int3
	ffffffff82b04208:       cc                      int3

gcc/ld doesn't seem to have the same issue. The generated code stays the
same for gcc/ld.

Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP for linker fill bytes")
Link: https://lore.kernel.org/r/20230906175215.2236033-1-song@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/vmlinux.lds.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -156,7 +156,7 @@ SECTIONS
 		ALIGN_ENTRY_TEXT_END
 		*(.gnu.warning)
 
-	} :text =0xcccc
+	} :text = 0xcccccccc
 
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;


