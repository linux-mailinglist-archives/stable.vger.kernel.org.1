Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9031B77D1AE
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 20:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbjHOSXc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 14:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjHOSXD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 14:23:03 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF71BC3
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 11:23:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so9369966e87.2
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1692123780; x=1692728580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75p/Ga3OF+rL1HqSOI9gCDFvimOS3BgZhss1tX+cqHo=;
        b=a9nDnGEGMcDJVZOvNqJk532O22A1oTj0ctz3bNuNN0dCOFVtDqfkp70Z08IrusG1ym
         UlP4QTYG4GvZXeMiwlBdf7fRJIGezYpZxFQk8FkFTJNqsGcMfzGt999WuOAblTQ7iukA
         fZ4gn4FckYhd9gKCWRaoyyZIHGaZFFHrxJVWoZku3tdUAbBHtYY53MqapIChAwOd5rri
         yIBlJ4hy3K8biJXuSGl6+JUwdcTrlCPr30XNpPP3LHhAJ3vCXoApdClmWn1DUsrV4W6M
         MfHJHppBfNnJueUZFRS20LvfttAEkcqh34ISq4jeYN1u11U4G35KoU/tb9+PnYzFYn8q
         o9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692123780; x=1692728580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75p/Ga3OF+rL1HqSOI9gCDFvimOS3BgZhss1tX+cqHo=;
        b=kKwFIZsODx7hTAwNmnYtQepxbOByAWfIiDOeu8YQdSI7hE/0ig0bzKuO3YlWgCIU1f
         l3QagFLx/YWv6ghZGmdEM7PxL6n7QAimKD90CNugFRKyjK/RGgEwY4KZ0ZduIxHZ6jSJ
         gClASICLJh3t8nj4TbUstgTu3T5TLn39bKsmGlsOziPppbZCknlFsRJsTyoI3yyu57Gf
         iFFV3fdHdJcYW8iKi12X8csNhmk3g47jQM37hdHJ9GijVEFNvgd3aa8m8iCTuN/K9y7l
         M93MNOjIPpAzllSuNc7ap8aoJFrsVMx19nY4zOzDtNdG2zB6vbm9fhevL+kCGw898TmZ
         fSzQ==
X-Gm-Message-State: AOJu0YyilIE7Z8MLQyJ2vSuBvcFdL5AbZd5tpG3U0j41ZTTbZLg1lycy
        POhJ8Tx//vxOqdyjbOZhnrj9zgVwpRH18L0NxN8=
X-Google-Smtp-Source: AGHT+IH1t5vrX0QGlomCKTzArjoVD7IMDRxcf52K7O6ZEZgMiHFjK9kLIiQg5rcUC19y6+k0wMO0xg==
X-Received: by 2002:ac2:5f6c:0:b0:4fb:2c1e:4e03 with SMTP id c12-20020ac25f6c000000b004fb2c1e4e03mr9027078lfc.32.1692123779663;
        Tue, 15 Aug 2023 11:22:59 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:141f:7d00:9f1e:dc4b:3dfb:993])
        by smtp.gmail.com with ESMTPSA id b13-20020a05640202cd00b0052544441babsm4610931edx.72.2023.08.15.11.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 11:22:59 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        stable@vger.kernel.org, Yu Zhang <yu.zhang@ionos.com>
Subject: [PATCHv2] x86/sgx: Avoid softlockup from sgx_vepc_release
Date:   Tue, 15 Aug 2023 20:22:58 +0200
Message-Id: <20230815182258.177153-1-jinpu.wang@ionos.com>
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

Similar like commit
8795359e35bc ("x86/sgx: Silence softlockup detection when releasing large enclaves")
The test system has 64GB of enclave memory, and all assigned to a single
VM. Release vepc take longer time and triggers the softlockup warning.

Add a cond_resched() to give other tasks a chance to run and placate
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
v2: 
* collects review and test by.
* add fixes tag
* trim call trace.

 arch/x86/kernel/cpu/sgx/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/virt.c b/arch/x86/kernel/cpu/sgx/virt.c
index c3e37eaec8ec..01d2795792cc 100644
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
-- 
2.34.1

