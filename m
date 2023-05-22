Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397EA70C9FD
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjEVTxy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235494AbjEVTxw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:53:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207ACA3
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:53:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B26562B58
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A924EC433D2;
        Mon, 22 May 2023 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785230;
        bh=sGEfzEU4J9EVVpL60o5S2n9YBq1DDYpJhnVnfCVv1ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Va5Dr2Awaj7QT/eU66EB5W9M13G2XRIh4vsunCYU0Y8n9FH13JGOO3kY1mEwMueiR
         zQsoS3GE7AZCthjVqeV1tpowjaurKXRY/PSq3ngsFhPq7rGQfpMugGb0hWJK17UAYR
         3BICEzDQGJzG2JP5H27YMguD/LqEstHtQqlkN2EU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Hartmayer <mhartmay@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.3 353/364] s390/crypto: use vector instructions only if available for ChaCha20
Date:   Mon, 22 May 2023 20:10:58 +0100
Message-Id: <20230522190421.602879302@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

commit 8703dd6b238da0ec6c276e53836f8200983d3d9b upstream.

Commit 349d03ffd5f6 ("crypto: s390 - add crypto library interface for
ChaCha20") added a library interface to the s390 specific ChaCha20
implementation. However no check was added to verify if the required
facilities are installed before branching into the assembler code.

If compiled into the kernel, this will lead to the following crash,
if vector instructions are not available:

data exception: 0007 ilc:3 [#1] SMP
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc7+ #11
Hardware name: IBM 3931 A01 704 (KVM/Linux)
Krnl PSW : 0704e00180000000 000000001857277a (chacha20_vx+0x32/0x818)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000037f0000000a ffffffffffffff60 000000008184b000 0000000019f5c8e6
           0000000000000109 0000037fffb13c58 0000037fffb13c78 0000000019bb1780
           0000037fffb13c58 0000000019f5c8e6 000000008184b000 0000000000000109
           00000000802d8000 0000000000000109 0000000018571ebc 0000037fffb13718
Krnl Code: 000000001857276a: c07000b1f80b        larl    %r7,0000000019bb1780
           0000000018572770: a708000a            lhi     %r0,10
          #0000000018572774: e78950000c36        vlm     %v24,%v25,0(%r5),0
          >000000001857277a: e7a060000806        vl      %v26,0(%r6),0
           0000000018572780: e7bf70004c36        vlm     %v27,%v31,0(%r7),4
           0000000018572786: e70b00000456        vlr     %v0,%v27
           000000001857278c: e71800000456        vlr     %v1,%v24
           0000000018572792: e74b00000456        vlr     %v4,%v27
Call Trace:
 [<000000001857277a>] chacha20_vx+0x32/0x818
Last Breaking-Event-Address:
 [<0000000018571eb6>] chacha20_crypt_s390.constprop.0+0x6e/0xd8
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Fix this by adding a missing MACHINE_HAS_VX check.

Fixes: 349d03ffd5f6 ("crypto: s390 - add crypto library interface for ChaCha20")
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Cc: <stable@vger.kernel.org> # 5.19+
Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
[agordeev@linux.ibm.com: remove duplicates in commit message]
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/crypto/chacha-glue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/crypto/chacha-glue.c
+++ b/arch/s390/crypto/chacha-glue.c
@@ -82,7 +82,7 @@ void chacha_crypt_arch(u32 *state, u8 *d
 	 * it cannot handle a block of data or less, but otherwise
 	 * it can handle data of arbitrary size
 	 */
-	if (bytes <= CHACHA_BLOCK_SIZE || nrounds != 20)
+	if (bytes <= CHACHA_BLOCK_SIZE || nrounds != 20 || !MACHINE_HAS_VX)
 		chacha_crypt_generic(state, dst, src, bytes, nrounds);
 	else
 		chacha20_crypt_s390(state, dst, src, bytes,


