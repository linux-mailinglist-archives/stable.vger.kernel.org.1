Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308BC7E2395
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjKFNMz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:12:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjKFNMy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:12:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DEC125
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:12:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E59AC433C8;
        Mon,  6 Nov 2023 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276371;
        bh=JbOhGG0L+nOujUWVMF9FT48n5SkBbTxOktCeoHIIITM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q9LKSYtDz6CJqBYbiXFCU+Rq9TmNpg2BkKxzit0/CgqZPTJvHG6T0KMcqzx7oWAVU
         YJ5opTxtvotCopm1RlDQMkHkMPok5P1FUVtEuJcFXvIj/WwhFtXESk0RIsUzEqLCxs
         NSQOgQqtfHzXJiocyUq5FLq/Qq4ojx2gKovZMqEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuan-Wei Chiu <visitorckw@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 20/62] efi: fix memory leak in krealloc failure handling
Date:   Mon,  6 Nov 2023 14:03:26 +0100
Message-ID: <20231106130302.548256565@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuan-Wei Chiu <visitorckw@gmail.com>

[ Upstream commit 0d3ad1917996839a5042d18f04e41915cfa1b74a ]

In the previous code, there was a memory leak issue where the
previously allocated memory was not freed upon a failed krealloc
operation. This patch addresses the problem by releasing the old memory
before setting the pointer to NULL in case of a krealloc failure. This
ensures that memory is properly managed and avoids potential memory
leaks.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/efi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index b43e5e6ddaf6e..b7c0e8cc0764f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -245,9 +245,13 @@ static __init int efivar_ssdt_load(void)
 		if (status == EFI_NOT_FOUND) {
 			break;
 		} else if (status == EFI_BUFFER_TOO_SMALL) {
-			name = krealloc(name, name_size, GFP_KERNEL);
-			if (!name)
+			efi_char16_t *name_tmp =
+				krealloc(name, name_size, GFP_KERNEL);
+			if (!name_tmp) {
+				kfree(name);
 				return -ENOMEM;
+			}
+			name = name_tmp;
 			continue;
 		}
 
-- 
2.42.0



