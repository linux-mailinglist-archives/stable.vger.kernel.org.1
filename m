Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6739379BBE0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbjIKVkp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbjIKPFR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:05:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD9125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:05:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32A7C433CB;
        Mon, 11 Sep 2023 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444713;
        bh=gU1882pj9OpII++LCNyI2/kg9lVdpEzeoEMbMm9Eo2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ma4ABkzHV3Xt1ticPOaq9XHLEnUiaOJ7Amn2Cbdb4rUpi6iUV+Gz0hpVEct0QFNBg
         lm+M0/t1Sm20hHGJcdgL2duk0QZG0zxqE1kBo+lld+sX0brioZfz7ln6u3PBPEj131
         /Wlxwv7wjk3az0xovA2JnUy7zOK9yCTRR6R/pHjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Sean Christopherson <seanjc@google.com>,
        Luiz Capitulino <luizcap@amazon.com>
Subject: [PATCH 6.1 082/600] KVM: x86/mmu: Use kstrtobool() instead of strtobool()
Date:   Mon, 11 Sep 2023 15:41:55 +0200
Message-ID: <20230911134636.036424575@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 11b36fe7d4500c8ef73677c087f302fd713101c2 upstream.

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/670882aa04dbdd171b46d3b20ffab87158454616.1673689135.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Luiz Capitulino <luizcap@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/mmu/mmu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -42,6 +42,7 @@
 #include <linux/uaccess.h>
 #include <linux/hash.h>
 #include <linux/kern_levels.h>
+#include <linux/kstrtox.h>
 #include <linux/kthread.h>
 
 #include <asm/page.h>
@@ -6667,7 +6668,7 @@ static int set_nx_huge_pages(const char
 		new_val = 1;
 	else if (sysfs_streq(val, "auto"))
 		new_val = get_nx_auto_mode();
-	else if (strtobool(val, &new_val) < 0)
+	else if (kstrtobool(val, &new_val) < 0)
 		return -EINVAL;
 
 	__set_nx_huge_pages(new_val);


