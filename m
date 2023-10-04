Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB35F7B8845
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbjJDSOb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244000AbjJDSOb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:14:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B873A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:14:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C144AC433C8;
        Wed,  4 Oct 2023 18:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443267;
        bh=YDyeLmiTYfaeiQI3od4LSwImmnz6iIh8uavTF/vEGlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQEWpo3bVbO+ZTaZLSpDmydmCXaTl8ir/jjpkgYgo4yPRZw4vberJQGanhCnzWeiV
         BKpvWPkQc1ajmizbA9yoLMx6QY/z40l/Qj2Ryy4Jr41Towqci+/WFX85QQr0G9YZZq
         ib1VGXyCZcoZDn+EWrFj1QSP1SA9nIIX1STY4xA0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 067/259] x86/srso: Fix srso_show_state() side effect
Date:   Wed,  4 Oct 2023 19:54:00 +0200
Message-ID: <20231004175220.470079567@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit a8cf700c17d9ca6cb8ee7dc5c9330dbac3948237 ]

Reading the 'spec_rstack_overflow' sysfs file can trigger an unnecessary
MSR write, and possibly even a (handled) exception if the microcode
hasn't been updated.

Avoid all that by just checking X86_FEATURE_IBPB_BRTYPE instead, which
gets set by srso_select_mitigation() if the updated microcode exists.

Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/27d128899cb8aee9eb2b57ddc996742b0c1d776b.1693889988.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 3a893ab398a01..5f38d60532a99 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2692,7 +2692,7 @@ static ssize_t srso_show_state(char *buf)
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
-			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
+			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
 }
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
-- 
2.40.1



