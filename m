Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A202700201
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 09:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjELH7N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 03:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239930AbjELH7M (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 03:59:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C857100FD
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683878347; x=1715414347;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NT9e/+oGub32EsxUnjqZafN9u8vt5LV96UJsUhKCpko=;
  b=wD6/CiGDUTXqDJ+W5Q2G8TCJE1sJ7b7c/mdkk42GOVWrJU1WCuW+2p8S
   WS7HXKqyDuVDucWLS8tyzhm+32c8UXEaQAbizLpIwhTNFRDjHel0F8ooZ
   TfOrDCjjdN4dEYYQE5HgZx0X3c/VtIsBXb79iCxkgruUdSDNTF2upL8XW
   TWLodxdtJF8QDxt60RsM2z0RVPH2ZLC+zjXr4qPo7pVTxthYhLqXx5E9E
   5YmwwR+ESik1mtOw8kezxSrJgsDqsjl1g7u4yCP5hYnP0P0Nv/BRnWBev
   HM9Ok9R77tkdbU/QjK3D3kGvybREvSxlpyUaPUB+VW20oKowel9RLuKXb
   A==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="scan'208";a="151693581"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 00:59:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 00:59:02 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 00:59:01 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <stable@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        <sasha@kernel.org>, <palmer@dabbelt.com>, <linux@roeck-us.net>,
        Chris Hofstaedtler <zeha@debian.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "Palmer Dabbelt" <palmer@rivosinc.com>
Subject: [PATCH 6.1 v2 2/2] RISC-V: fix taking the text_mutex twice during sifive errata patching
Date:   Fri, 12 May 2023 08:58:19 +0100
Message-ID: <20230512-john-corridor-e244877180f7@wendy>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512-unbroken-preppy-8d726731e8e7@wendy>
References: <20230512-unbroken-preppy-8d726731e8e7@wendy>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3130; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NT9e/+oGub32EsxUnjqZafN9u8vt5LV96UJsUhKCpko=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmxH2el2R+XTGk9OvdF2FOzqwkT1Ri+vjPN11N+rvVi/c+Z 7Sx1HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjIJHuGfwYBTzbbH7Rs84lek1HA71 bBwST2IWJdcMNz5a1x5yWCvzL8z+/Z+GP1Ju+G88dWRq6+wbye2XwGz9qStPVdktpxD5N/MgEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit bf89b7ee52af5a5944fa3539e86089f72475055b upstream.

Chris pointed out that some bonehead, *cough* me *cough*, added two
mutex_locks() to the SiFive errata patching. The second was meant to
have been a mutex_unlock().

This results in errors such as

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000030
Oops [#1]
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted
6.2.0-rc1-starlight-00079-g9493e6f3ce02 #229
Hardware name: BeagleV Starlight Beta (DT)
epc : __schedule+0x42/0x500
 ra : schedule+0x46/0xce
epc : ffffffff8065957c ra : ffffffff80659a80 sp : ffffffff81203c80
 gp : ffffffff812d50a0 tp : ffffffff8120db40 t0 : ffffffff81203d68
 t1 : 0000000000000001 t2 : 4c45203a76637369 s0 : ffffffff81203cf0
 s1 : ffffffff8120db40 a0 : 0000000000000000 a1 : ffffffff81213958
 a2 : ffffffff81213958 a3 : 0000000000000000 a4 : 0000000000000000
 a5 : ffffffff80a1bd00 a6 : 0000000000000000 a7 : 0000000052464e43
 s2 : ffffffff8120db41 s3 : ffffffff80a1ad00 s4 : 0000000000000000
 s5 : 0000000000000002 s6 : ffffffff81213938 s7 : 0000000000000000
 s8 : 0000000000000000 s9 : 0000000000000001 s10: ffffffff812d7204
 s11: ffffffff80d3c920 t3 : 0000000000000001 t4 : ffffffff812e6dd7
 t5 : ffffffff812e6dd8 t6 : ffffffff81203bb8
status: 0000000200000100 badaddr: 0000000000000030 cause: 000000000000000d
[<ffffffff80659a80>] schedule+0x46/0xce
[<ffffffff80659dce>] schedule_preempt_disabled+0x16/0x28
[<ffffffff8065ae0c>] __mutex_lock.constprop.0+0x3fe/0x652
[<ffffffff8065b138>] __mutex_lock_slowpath+0xe/0x16
[<ffffffff8065b182>] mutex_lock+0x42/0x4c
[<ffffffff8000ad94>] sifive_errata_patch_func+0xf6/0x18c
[<ffffffff80002b92>] _apply_alternatives+0x74/0x76
[<ffffffff80802ee8>] apply_boot_alternatives+0x3c/0xfa
[<ffffffff80803cb0>] setup_arch+0x60c/0x640
[<ffffffff80800926>] start_kernel+0x8e/0x99c
---[ end trace 0000000000000000 ]---

Reported-by: Chris Hofstaedtler <zeha@debian.org>
Fixes: 9493e6f3ce02 ("RISC-V: take text_mutex during alternative patching")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230302174154.970746-1-conor@kernel.org
[Palmer: pick up Geert's bug report from the thread]
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
The Author: field for this patch was broken upstream due to a b4 bug.
I've fixed it here, it was just an s/@kernel.org/@microchip.com/.
---
 arch/riscv/errata/sifive/errata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 5b77d7310e39..c24a349dd026 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -110,7 +110,7 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
 		if (cpu_req_errata & tmp) {
 			mutex_lock(&text_mutex);
 			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
-			mutex_lock(&text_mutex);
+			mutex_unlock(&text_mutex);
 			cpu_apply_errata |= tmp;
 		}
 	}
-- 
2.39.2

