Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3C76FAC98
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbjEHL0R (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235739AbjEHL0H (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:26:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4373C1DD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E18762D38
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF90C4339B;
        Mon,  8 May 2023 11:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545146;
        bh=VS6wU4A9hmfwwQFR6HvSLTXL2MbNWEQiJ0sff1ftbk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnRCNnegbwQvJNJoJqN1bheZ4cKQlDqC9a/fsvtCIQE2g02Ao9yRNcl5b7mq85eJC
         vF3pfcpriHRmNC8QUaqmCUQ1wP0nNX5NVoErMIMYixdBiVg4bItBPwV7e5aJGKAs2a
         vficnsRyW2PTZa35VuUlyZdixB2HVsPXyQWNIGqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 612/694] s390/checksum: always use cksm instruction
Date:   Mon,  8 May 2023 11:47:27 +0200
Message-Id: <20230508094455.274480780@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit e42ac7789df64120d7d3d57433dfc9f37ec0cb99 ]

Commit dfe843dce775 ("s390/checksum: support GENERIC_CSUM, enable it for
KASAN") switched s390 to use the generic checksum functions, so that KASAN
instrumentation also works checksum functions by avoiding architecture
specific inline assemblies.

There is however the problem that the generic csum_partial() function
returns a 32 bit value with a 16 bit folded checksum, while the original
s390 variant does not fold to 16 bit. This in turn causes that the
ipib_checksum in lowcore contains different values depending on kernel
config options.

The ipib_checksum is used by system dumpers to verify if pointers in
lowcore point to valid data. Verification is done by comparing checksum
values. The system dumpers still use 32 bit checksum values which are not
folded, and therefore the checksum verification fails (incorrectly).

Symptom is that reboot after dump does not work anymore when a KASAN
instrumented kernel is dumped.

Fix this by not using the generic checksum implementation. Instead add an
explicit kasan_check_read() so that KASAN knows about the read access from
within the inline assembly.

Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Fixes: dfe843dce775 ("s390/checksum: support GENERIC_CSUM, enable it for KASAN")
Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/Kconfig                | 4 ----
 arch/s390/include/asm/checksum.h | 9 ++-------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9809c74e12406..35f15c23c4913 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -26,10 +26,6 @@ config GENERIC_BUG
 config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
 
-config GENERIC_CSUM
-	bool
-	default y if KASAN
-
 config GENERIC_LOCKBREAK
 	def_bool y if PREEMPTION
 
diff --git a/arch/s390/include/asm/checksum.h b/arch/s390/include/asm/checksum.h
index d977a3a2f6190..1b6b992cf18ed 100644
--- a/arch/s390/include/asm/checksum.h
+++ b/arch/s390/include/asm/checksum.h
@@ -12,12 +12,7 @@
 #ifndef _S390_CHECKSUM_H
 #define _S390_CHECKSUM_H
 
-#ifdef CONFIG_GENERIC_CSUM
-
-#include <asm-generic/checksum.h>
-
-#else /* CONFIG_GENERIC_CSUM */
-
+#include <linux/kasan-checks.h>
 #include <linux/uaccess.h>
 #include <linux/in6.h>
 
@@ -40,6 +35,7 @@ static inline __wsum csum_partial(const void *buff, int len, __wsum sum)
 		.odd = (unsigned long) len,
 	};
 
+	kasan_check_read(buff, len);
 	asm volatile(
 		"0:	cksm	%[sum],%[rp]\n"
 		"	jo	0b\n"
@@ -135,5 +131,4 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold((__force __wsum)(sum >> 32));
 }
 
-#endif /* CONFIG_GENERIC_CSUM */
 #endif /* _S390_CHECKSUM_H */
-- 
2.39.2



