Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31227CACAD
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjJPO6O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjJPO6N (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:58:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65648D9
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:58:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB236C433C8;
        Mon, 16 Oct 2023 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468292;
        bh=NR2SfBwVry8Tuqe08V/v++uMiVQtiCiARw1fXdvP5DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hzIKmrf33KxFX364j1vCa+2D8dFosZmCE0qCP4FMIGSkdVZkUyrgW/XZSMGK3Z54d
         wk47SckJ2akfbhepXLb+kYiJHZc8Reo9YSesnE9mmYZBX1XSjsqTIJy770/ENffC5K
         3kNzprz/r7mmaDiYQdKa4NY7lFv0RAL8rWoNuFK8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Song Shuai <songshuaishuai@tinylab.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.5 171/191] riscv: Remove duplicate objcopy flag
Date:   Mon, 16 Oct 2023 10:42:36 +0200
Message-ID: <20231016084019.367824912@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Shuai <songshuaishuai@tinylab.org>

commit 505b02957e74f0c5c4655647ccb04bdc945d18f6 upstream.

There are two duplicate `-O binary` flags when objcopying from vmlinux
to Image/xipImage.

RISC-V set `-O binary` flag in both OBJCOPYFLAGS in the top-level riscv
Makefile and OBJCOPYFLAGS_* in the boot/Makefile, and the objcopy cmd
in Kbuild would join them together.

The `-O binary` flag is only needed for objcopying Image, so remove the
OBJCOPYFLAGS in the top-level riscv Makefile.

Fixes: c0fbcd991860 ("RISC-V: Build flat and compressed kernel images")
Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20230914091334.1458542-1-songshuaishuai@tinylab.org
Cc: stable@vger.kernel.org
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/Makefile |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -6,7 +6,6 @@
 # for more details.
 #
 
-OBJCOPYFLAGS    := -O binary
 LDFLAGS_vmlinux := -z norelro
 ifeq ($(CONFIG_RELOCATABLE),y)
 	LDFLAGS_vmlinux += -shared -Bsymbolic -z notext --emit-relocs


