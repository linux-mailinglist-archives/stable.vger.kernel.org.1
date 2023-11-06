Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA247E23F7
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjKFNQp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjKFNQo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:16:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36056F1
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:16:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B52C433C8;
        Mon,  6 Nov 2023 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276600;
        bh=iWpPfdkyxx/LXzjzGOFBfjxQuJ2Ubp6hzMUheiQIDoY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WliRl7Cfmv0tOkih+TqIzCCQVnZjvNT7s+uPkWu1/MGmbmpjP+OoNKC8OtmACq3ic
         xJpy9QpnJg8r9M3CQHa3XqCrP29jzyBlPblPZznAe+q8vqYzuLujnnkZx+7MXRybAr
         D9PRF9gxiaHNLM4CaaW9B/u0ut1vdKsGp7L77Fsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nikolay Borisov <nik.borisov@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 34/88] x86/efistub: Dont try to print after ExitBootService()
Date:   Mon,  6 Nov 2023 14:03:28 +0100
Message-ID: <20231106130307.057627261@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nik.borisov@suse.com>

[ Upstream commit ff07186b4d774ac22a5345d30763045af4569416 ]

setup_e820() is executed after UEFI's ExitBootService has been called.
This causes the firmware to throw an exception because the Console IO
protocol is supposed to work only during boot service environment. As
per UEFI 2.9, section 12.1:

 "This protocol is used to handle input and output of text-based
 information intended for the system user during the operation of code
 in the boot services environment."

So drop the diagnostic warning from this function. We might add back a
warning that is issued later when initializing the kernel itself.

Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 146477da2b98c..a5a856a7639e1 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -648,11 +648,8 @@ setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_s
 			break;
 
 		case EFI_UNACCEPTED_MEMORY:
-			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY)) {
-				efi_warn_once(
-"The system has unaccepted memory,  but kernel does not support it\nConsider enabling CONFIG_UNACCEPTED_MEMORY\n");
+			if (!IS_ENABLED(CONFIG_UNACCEPTED_MEMORY))
 				continue;
-			}
 			e820_type = E820_TYPE_RAM;
 			process_unaccepted_memory(d->phys_addr,
 						  d->phys_addr + PAGE_SIZE * d->num_pages);
-- 
2.42.0



