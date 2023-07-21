Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAF375D3F9
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjGUTQc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbjGUTQb (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F481FD7
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC5F861D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC17C433C7;
        Fri, 21 Jul 2023 19:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966989;
        bh=4wTjTmdO5Xx1pVjMDzCbxMIE5fMT5jewO5B38Vy3So4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qUjF22AtLQWHUqS4IqKgOL9my/XQs0F5juBKmlEvL1VPc2uYEemQyOlRyLGHfQgMM
         jklzC7II2DcgAV2Xqy7NIhffonjAufs/Qv7ap0MhN1oBhSbMozeS96qu893hCBzPPa
         DNWKIpOovOw77/n5cpqDkg6zE6YTvU8htiIPyoWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        CKI <cki-project@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 5.15 509/532] s390/decompressor: fix misaligned symbol build error
Date:   Fri, 21 Jul 2023 18:06:53 +0200
Message-ID: <20230721160642.257219801@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

commit 938f0c35d7d93a822ab9c9728e3205e8e57409d0 upstream.

Nathan Chancellor reported a kernel build error on Fedora 39:

$ clang --version | head -1
clang version 16.0.5 (Fedora 16.0.5-1.fc39)

$ s390x-linux-gnu-ld --version | head -1
GNU ld version 2.40-1.fc39

$ make -skj"$(nproc)" ARCH=s390 CC=clang CROSS_COMPILE=s390x-linux-gnu- olddefconfig all
s390x-linux-gnu-ld: arch/s390/boot/startup.o(.text+0x5b4): misaligned symbol `_decompressor_end' (0x35b0f) for relocation R_390_PC32DBL
make[3]: *** [.../arch/s390/boot/Makefile:78: arch/s390/boot/vmlinux] Error 1

It turned out that the problem with misaligned symbols on s390 was fixed
with commit 80ddf5ce1c92 ("s390: always build relocatable kernel") for the
kernel image, but did not take into account that the decompressor uses its
own set of CFLAGS, which come without -fPIE.

Add the -fPIE flag also to the decompresser CFLAGS to fix this.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Reported-by: CKI <cki-project@redhat.com>
Suggested-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1747
Link: https://lore.kernel.org/32935.123062114500601371@us-mta-9.us.mimecast.lan/
Link: https://lore.kernel.org/r/20230622125508.1068457-1-hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -29,6 +29,7 @@ KBUILD_CFLAGS_DECOMPRESSOR += -fno-delet
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS_DECOMPRESSOR += -ffreestanding
 KBUILD_CFLAGS_DECOMPRESSOR += -fno-stack-protector
+KBUILD_CFLAGS_DECOMPRESSOR += -fPIE
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))


