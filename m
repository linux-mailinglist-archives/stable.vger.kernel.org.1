Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B3C78128F
	for <lists+stable@lfdr.de>; Fri, 18 Aug 2023 20:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379349AbjHRSH1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 18 Aug 2023 14:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239418AbjHRSHH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 Aug 2023 14:07:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C92D65
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 11:07:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe9c20f449so11530025e9.3
        for <stable@vger.kernel.org>; Fri, 18 Aug 2023 11:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1692382024; x=1692986824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ybd5yyd6YPV5Ukw6R+oarLWdbTsGmZVeo8e1MUfnCNk=;
        b=IVgb6wF+DgM2LW2BjIlxOVqKd8enLOBEGI9VJRaF5I4i0Pwm0P4S/qAT96LLMVePEv
         NRQsugxM8rBWCQ06/M8nSsKLj980bxymVrLzH/Gog1S+EAqjF7TBR7XKgzt68zpHlZR1
         /HMW0bOZdtBUAVWnKoQwfFd/S0v5CpctmAEyyq3Sis6WmFw2AvhpmjDV6oh5n/FqFtS1
         Ahu/bI8kGgh94YSQrjz0uONR22FjgtDe8h9mCZ4NnKa7Y21L7UMlintD9j4pniWvxvPS
         5TNkZuv6nIrSacvepIJDf1OUKaXjCDqP0qzV6lQ6w4rmn5MHajwo+0QESD+usnBeLMsc
         wQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692382024; x=1692986824;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ybd5yyd6YPV5Ukw6R+oarLWdbTsGmZVeo8e1MUfnCNk=;
        b=f1xudaYnL/NJ9NjmBTi2AkrR80VOP7IAxJFyRoNTFBn13Aqxm9gRp4QPZ4tnOhHC/T
         fsVNC1/UWByHYQsskbU7vZfcIIh+j2JBMJmv0OFb/FMLe8Wyfpf/fwmjufA927lLIQlD
         mBXQnY0GFU/LoCUhcxUAq/qSdkt3qMxKWkyc5Fsi0kZG2aQljIzo33khDk1JaGnRU6Y6
         /NZRaox/6GthwQRiQysDSxfLRvnrN6cOzu92Q7uRRVBg0qCXWGGLYCfTAAA+GeenADRO
         pnz4HFT5uNDpzaHseQghStZzfYKKeSN3KugCHYhSVdlshgsCWW73RiVQ91ofwDQJcXtH
         g6mw==
X-Gm-Message-State: AOJu0Yz14iOeT2u5W7AxrSKz8o+2A/vFeUm3PKFPvtCVWQlrQtTKVZeo
        vi2EsVA6pV02wP4tC4UZk6cd+Q==
X-Google-Smtp-Source: AGHT+IG3k8VDft0IXTOYWnrwOq54Zv5ydFeCuga3yOyBe2p3bbKhtYF735Slv4/DMbpe5PG5YNi4Tw==
X-Received: by 2002:a05:600c:2247:b0:3fe:45e5:f6ee with SMTP id a7-20020a05600c224700b003fe45e5f6eemr2677098wmm.19.1692382023671;
        Fri, 18 Aug 2023 11:07:03 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143a:700:a783:2119:a004:e85])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b003176c6e87b1sm3556230wrm.81.2023.08.18.11.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:07:03 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        stable@vger.kernel.org, Yu Zhang <yu.zhang@ionos.com>
Subject: [PATCHv3] x86/sgx: Avoid softlockup from sgx_vepc_release
Date:   Fri, 18 Aug 2023 20:07:02 +0200
Message-Id: <20230818180702.4621-1-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Fixes: 540745ddbc70 ("x86/sgx: Introduce virtual EPC for use by KVM guests")
Reported-by: Yu Zhang <yu.zhang@ionos.com>
Tested-by: Yu Zhang <yu.zhang@ionos.com>
Acked-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
v3:
* improve commit message as suggested.
* Add cond_resched() to the 3rd loop too.
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

