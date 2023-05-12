Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB227001FF
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjELH7E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 03:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239922AbjELH7B (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 03:59:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD4E723
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683878339; x=1715414339;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zOIzgRZc6vlGrIT7OyqYI29Et5ix/J94Y6+a4Z5H4u4=;
  b=W2MVUzNBfLTqcZKOrDllXSqjj8nvh1IsfjGnsiV1zTRHa9W9Rlsogoxh
   UdJmf3+JcgqaHhy4aii9tO4omuXPCn97dFdSm0mWDo7hyKgAl2qyKjfyB
   pET4atCpnyDKdF4pQrYkuxwULJgdSujsa9ovYwxD5jTG8Yp/S9suSjSus
   mwhNMqNf09u4Nq/+b9vN0xLSg5baIJn3GXZi2ZN+PALxxseAzKXelG9Ar
   4+aGZJWt5GGDXXAVdbr0hk9hU0SznIcAOszgczHnw+hxOXLWp1mwslu24
   KxUlKRo7DWvC+JdKXENWv++1CUUyZDOXkS2siGDMTWFFjHiMoGDAbb7UB
   A==;
X-IronPort-AV: E=Sophos;i="5.99,269,1677567600"; 
   d="scan'208";a="215029621"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 May 2023 00:58:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 12 May 2023 00:58:59 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 12 May 2023 00:58:58 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <stable@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        <sasha@kernel.org>, <palmer@dabbelt.com>, <linux@roeck-us.net>
Subject: [PATCH 6.1 v2 0/2] RISC-V: fix lock splat in riscv_cpufeature_patch_func()
Date:   Fri, 12 May 2023 08:58:17 +0100
Message-ID: <20230512-unbroken-preppy-8d726731e8e7@wendy>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=690; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=zOIzgRZc6vlGrIT7OyqYI29Et5ix/J94Y6+a4Z5H4u4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmxH/uj4z8H+5fr6cw8FRhj4dtupTBBq8PZMXjtpMmVp9sn CIl2lLIwiHEwyIopsiTe7muRWv/HZYdzz1uYOaxMIEMYuDgFYCLH/zMyLDnY8+59zSSPRys7P89u9w 0M+JiWafvW4GW7Wolk+fp/lxn+cFdtW9TWwZcTdrRHeccDhS1rVuwtfuX8qj55b9paXtXZnAA=
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

Replacing <20230509-suspend-labrador-3eb6f0a8ac77@spud>, here's a more
complete backport of the patches for the lockdep splats during text
patching on RISC-V.
I've preserved the original broken patch & the subsequent fix to it.

CC: stable@vger.kernel.org
CC: sasha@kernel.org
CC: palmer@dabbelt.com
CC: linux@roeck-us.net

Conor Dooley (2):
  RISC-V: take text_mutex during alternative patching
  RISC-V: fix taking the text_mutex twice during sifive errata patching

 arch/riscv/errata/sifive/errata.c | 3 +++
 arch/riscv/errata/thead/errata.c  | 8 ++++++--
 arch/riscv/kernel/cpufeature.c    | 6 +++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.39.2

