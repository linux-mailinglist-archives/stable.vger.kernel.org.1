Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8534D79AFCB
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345995AbjIKVWs (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbjIKPGo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:06:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32127FA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:06:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B64AC433C8;
        Mon, 11 Sep 2023 15:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444799;
        bh=CJY/nidx3RHgG2Rm3IJLEcHNRl6F7dZQo4pBRupqgq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcipyLfoj6PaI/TIb5eb7nzB9U1QE7pmPRsIUweSqL+TIEC5PCu5KJiTY3A/iajwM
         r2prgEL2jvSu/lMXA2SeqDVodt0/fXRSH0bt4QsB/0k2QBI215VyO1jWdM7zrwi/Nx
         L15VRQrleQ2JKddCakxfolhC+m5i7GlfHAZXOzHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 119/600] arm64/sme: Dont use streaming mode to probe the maximum SME VL
Date:   Mon, 11 Sep 2023 15:42:32 +0200
Message-ID: <20230911134637.125708871@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit fcd3d2c082b2a19da2326b2b38ba5a05536dcd32 ]

During development the architecture added the RDSVL instruction which means
we do not need to enter streaming mode to enumerate the SME VLs, use it
when we probe the maximum supported VL. Other users were already updated.

No functional change.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20221223-arm64-sme-probe-max-v1-1-cbde68f67ad0@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Stable-dep-of: 01948b09edc3 ("arm64/fpsimd: Only provide the length to cpufeature for xCR registers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 8cd59d387b90b..4aa579ff3125d 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1296,7 +1296,6 @@ u64 read_smcr_features(void)
 	unsigned int vq_max;
 
 	sme_kernel_enable(NULL);
-	sme_smstart_sm();
 
 	/*
 	 * Set the maximum possible VL.
@@ -1306,11 +1305,9 @@ u64 read_smcr_features(void)
 
 	smcr = read_sysreg_s(SYS_SMCR_EL1);
 	smcr &= ~(u64)SMCR_ELx_LEN_MASK; /* Only the LEN field */
-	vq_max = sve_vq_from_vl(sve_get_vl());
+	vq_max = sve_vq_from_vl(sme_get_vl());
 	smcr |= vq_max - 1; /* set LEN field to maximum effective value */
 
-	sme_smstop_sm();
-
 	return smcr;
 }
 
-- 
2.40.1



