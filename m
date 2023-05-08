Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515686FA71B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjEHK1y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbjEHK10 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:27:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C32D50
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 159F96262D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E265C433EF;
        Mon,  8 May 2023 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541609;
        bh=njPBRV4vdROTsIb9eYX4JgIGLB626mQFNTaz78hpzFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3LpDRb2KlvO2PBf7AsRnUNLASC7m7bGslGf0YpxawWPgrZ6edw/cJXYKXlW7TKUP
         Qx9ordR0gpKKJQEnSufl6NARHUXR7ia8+7TYX28Dm7C+l+HCc2fBmHpzSrk39A2lsL
         oPipwrmPNLHV0yyjucQMF6EJl1BWYv/QzmXSDcpA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Terry Bowman <terry.bowman@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Feng Tang <feng.tang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 138/663] tools/x86/kcpuid: Fix avx512bw and avx512lvl fields in Fn00000007
Date:   Mon,  8 May 2023 11:39:24 +0200
Message-Id: <20230508094433.002334930@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Terry Bowman <terry.bowman@amd.com>

[ Upstream commit 4e347bdf44c1fd4296a7b9657a2c0e1bd900fa50 ]

Leaf Fn00000007 contains avx512bw at bit 26 and avx512vl at bit 28. This
is incorrect per the SDM. Correct avx512bw to be bit 30 and avx512lvl to
be bit 31.

Fixes: c6b2f240bf8d ("tools/x86: Add a kcpuid tool to show raw CPU features")
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Link: https://lore.kernel.org/r/20230206141832.4162264-2-terry.bowman@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/arch/x86/kcpuid/cpuid.csv | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index 4f1c4b0c29e98..9914bdf4fc9ec 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -184,8 +184,8 @@
 	 7,    0,  EBX,     27, avx512er, AVX512 Exponent Reciproca instr
 	 7,    0,  EBX,     28, avx512cd, AVX512 Conflict Detection instr
 	 7,    0,  EBX,     29, sha, Intel Secure Hash Algorithm Extensions instr
-	 7,    0,  EBX,     26, avx512bw, AVX512 Byte & Word instr
-	 7,    0,  EBX,     28, avx512vl, AVX512 Vector Length Extentions (VL)
+	 7,    0,  EBX,     30, avx512bw, AVX512 Byte & Word instr
+	 7,    0,  EBX,     31, avx512vl, AVX512 Vector Length Extentions (VL)
 	 7,    0,  ECX,      0, prefetchwt1, X
 	 7,    0,  ECX,      1, avx512vbmi, AVX512 Vector Byte Manipulation Instructions
 	 7,    0,  ECX,      2, umip, User-mode Instruction Prevention
-- 
2.39.2



