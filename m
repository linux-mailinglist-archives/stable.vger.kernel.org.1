Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A57ECDC8
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjKOTiY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjKOTiY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:38:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6342CA4
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:38:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD283C433C7;
        Wed, 15 Nov 2023 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077101;
        bh=mRLGl0NOfWGDfFqSttyZBE+SCVhEas1W7R+Rrv8DFIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2TjOHfHbiFwDGZYkT3ed51pJVZviz4fIJ8VM0HiDaO9A1TPnSpHwxKuPLpLIovPQ
         rD23bHzMoLf/oJnu4X4gvHPFTHLXdT/oY3Ryj6KSelD0lRhBbFYpdd2Awv/kvELpTf
         vmJAYCdFzMS837qpV1UeOSbpJYGdj3jEUD2b/1Og=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 108/603] selftests/bpf: Define SYS_NANOSLEEP_KPROBE_NAME for riscv
Date:   Wed, 15 Nov 2023 14:10:53 -0500
Message-ID: <20231115191620.685603598@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Björn Töpel <bjorn@rivosinc.com>

[ Upstream commit b55b775f03166b8da60af80ef33da8bf83ca96c1 ]

Add missing sys_nanosleep name for RISC-V, which is used by some tests
(e.g. attach_probe).

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/bpf/20231004110905.49024-4-bjorn@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_progs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index 77bd492c60248..2f9f6f250f171 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -417,6 +417,8 @@ int get_bpf_max_tramp_links(void);
 #define SYS_NANOSLEEP_KPROBE_NAME "__s390x_sys_nanosleep"
 #elif defined(__aarch64__)
 #define SYS_NANOSLEEP_KPROBE_NAME "__arm64_sys_nanosleep"
+#elif defined(__riscv)
+#define SYS_NANOSLEEP_KPROBE_NAME "__riscv_sys_nanosleep"
 #else
 #define SYS_NANOSLEEP_KPROBE_NAME "sys_nanosleep"
 #endif
-- 
2.42.0



