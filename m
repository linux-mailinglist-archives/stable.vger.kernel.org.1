Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1900793D86
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 15:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjIFNRU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 09:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjIFNRU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 09:17:20 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1993410C8
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 06:17:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-500913779f5so6135607e87.2
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1694006234; x=1694611034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xB8fvBBCpzdEO/4t/OsdBZTIqwaBnNUU3v23BBtYZ1o=;
        b=XXPC73HeemVC1MiqlGMQhR4IK0x8J+r0Qk3VetHqKRkJBua0vOin1WvR8yXcliqPuV
         k7C0hFpc5iv9PoWQk7dZS/QPO/F43FgmelDNVR4hg+uQoGBPPVpY40KDdxpP4If8uztq
         hgJ6E9nfafyz+C1ezvIv9crQfhdoxeTlcV7IadP1KqU7md6hWR/aR9VRuAeEiPwIUkcF
         WPTCieA1vHj3Flk4aVZsSc4QUbYtZcuWbP98chRaFoxLY9YRkDKDl1diwACex9vygQzX
         4GilXWxxk8vcwfO5icIAqJnJFaOnLfPgackD05V6uTvTBvZz1zrKaMAelMZuZpr1E/Ho
         CrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694006234; x=1694611034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xB8fvBBCpzdEO/4t/OsdBZTIqwaBnNUU3v23BBtYZ1o=;
        b=XnPIutQ5FkHF7VKecc5MByrErcpV/qQYJFh1tKvC5CB2QJ7FimGoagwZp4dpGOf9oH
         3Yb1X+w0IRyOOrY/zgBdvh5AJ2LmAHPYa/iyDtbnZW0UrPEroOucmUY0h1ktCzufgs3K
         8SybDychgj1LgvZ1RrrCsiHdKOY+708hesWo2JOGqdqE1nS+K4B89jFRKY4S7ZZWAhSS
         x9I5nFQhZRVY5cVIXhoNTlyl/rAtrDKHdQQ20i/VqWY4zGjKylicLSX7wm5WS37k2eRN
         /zwkBujO81dnaIFoUVA/wJm82Z/nreGfvWRK3LDno+VBS1j+vr5+8l+YJLOynl9Oiz0r
         1vMQ==
X-Gm-Message-State: AOJu0Ywbqr785BLADGBLWgFgkiHvoIv2lk9Oz0z0VVUpFuqlISkmSBQ2
        dhPELmmqpYkrP3EV7oAr66GI2g==
X-Google-Smtp-Source: AGHT+IGVK6ISHbpx2ka3Ffs9bHpHBD4qFyD2gWM5N5MBrnXlWJIFJOnK86fFvCYcRhbWYiisKlYXFA==
X-Received: by 2002:a05:6512:3713:b0:500:b8bc:bd9a with SMTP id z19-20020a056512371300b00500b8bcbd9amr2153930lfr.49.1694006234325;
        Wed, 06 Sep 2023 06:17:14 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:1407:8d00:b7a3:eef6:4043:da6e])
        by smtp.gmail.com with ESMTPSA id a25-20020a1709064a5900b009a2202bfce5sm8938825ejv.118.2023.09.06.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:17:13 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     x86@kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        stable@vger.kernel.org, Yu Zhang <yu.zhang@ionos.com>,
        Kai Huang <kai.huang@intel.com>
Subject: [PATCHv4] x86/sgx: Avoid softlockup from sgx_vepc_release
Date:   Wed,  6 Sep 2023 15:17:12 +0200
Message-Id: <20230906131712.143629-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

We hit softlocup with following call trace:

? asm_sysvec_apic_timer_interrupt+0x16/0x20
xa_erase+0x21/0xb0
? sgx_free_epc_page+0x20/0x50
sgx_vepc_release+0x75/0x220
__fput+0x89/0x250
task_work_run+0x59/0x90
do_exit+0x337/0x9a0

Similar like commit 8795359e35bc ("x86/sgx: Silence softlockup detection
when releasing large enclaves"). The test system has 64GB of enclave memory,
and all assigned to a single VM. Release vepc take longer time and triggers
the softlockup warning.

Add cond_resched() to give other tasks a chance to run and placate
the softlockup detector.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Haitao Huang <haitao.huang@linux.intel.com>
Cc: stable@vger.kernel.org
Cc: x86@kernel.org
Fixes: 540745ddbc70 ("x86/sgx: Introduce virtual EPC for use by KVM guests")
Reported-by: Yu Zhang <yu.zhang@ionos.com>
Tested-by: Yu Zhang <yu.zhang@ionos.com>
Acked-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
v4: add rob from Kai.

 arch/x86/kernel/cpu/sgx/virt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index c3e37eaec8ec..7aaa3652e31d 100644
--- a/arch/x86/kernel/cpu/sgx/virt.c
+++ b/arch/x86/kernel/cpu/sgx/virt.c
@@ -204,6 +204,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			continue;
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -222,6 +223,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 			list_add_tail(&epc_page->list, &secs_pages);
 
 		xa_erase(&vepc->page_array, index);
+		cond_resched();
 	}
 
 	/*
@@ -243,6 +245,7 @@ static int sgx_vepc_release(struct inode *inode, struct file *file)
 
 		if (sgx_vepc_free_page(epc_page))
 			list_add_tail(&epc_page->list, &secs_pages);
+		cond_resched();
 	}
 
 	if (!list_empty(&secs_pages))
-- 
2.34.1

