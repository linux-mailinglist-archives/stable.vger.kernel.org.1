Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F746FA8CF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbjEHKpf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjEHKpR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3765A27F27
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:44:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEC8E6287D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:44:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06D9C433D2;
        Mon,  8 May 2023 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542650;
        bh=vNOmNtAn3cq21wXC0/F3vb0CHXvm+wABlSecA9RM07g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0cCYn9YrlfKjugZ2uXwwA4jlEfmKa3MClA/yFOLUOXw+AnqrOo2XRH0FKSFTYe0s
         HTtLwBi5PwWe9EST4BobLOaG88m2FCCyr9A5/K3d7sJfeTQsDUaQ1Bj6d6++xT+Uym
         OJuJR+eN2wuZb16Zdy/VKVxgou3Avf6jLH/H0LkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 504/663] powerpc/perf: Properly detect mpc7450 family
Date:   Mon,  8 May 2023 11:45:30 +0200
Message-Id: <20230508094444.952164567@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit e7299f961fe5e4496db0bfaa9e819f5e97f3846b ]

Unlike PVR_POWER8, etc ...., PVR_7450 represents a full PVR
value and not a family value.

To avoid confusion, do like E500 family and define the relevant
PVR_VER_xxxx values for the 7450 family:
  0x8000 ==> 7450
  0x8001 ==> 7455
  0x8002 ==> 7447
  0x8003 ==> 7447A
  0x8004 ==> 7448

And use them to detect 7450 family for perf events.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202302260657.7dM9Uwev-lkp@intel.com/
Fixes: ec3eb9d941a9 ("powerpc/perf: Use PVR rather than oprofile field to determine CPU version")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/99ca1da2e5a6cf82a8abf4bc034918e500e31781.1677513277.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/reg.h  | 5 +++++
 arch/powerpc/perf/mpc7450-pmu.c | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1e8b2e04e626a..8fda87af2fa5e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1310,6 +1310,11 @@
 #define PVR_VER_E500MC	0x8023
 #define PVR_VER_E5500	0x8024
 #define PVR_VER_E6500	0x8040
+#define PVR_VER_7450	0x8000
+#define PVR_VER_7455	0x8001
+#define PVR_VER_7447	0x8002
+#define PVR_VER_7447A	0x8003
+#define PVR_VER_7448	0x8004
 
 /*
  * For the 8xx processors, all of them report the same PVR family for
diff --git a/arch/powerpc/perf/mpc7450-pmu.c b/arch/powerpc/perf/mpc7450-pmu.c
index 552d51a925d37..db451b9aac35e 100644
--- a/arch/powerpc/perf/mpc7450-pmu.c
+++ b/arch/powerpc/perf/mpc7450-pmu.c
@@ -417,9 +417,9 @@ struct power_pmu mpc7450_pmu = {
 
 static int __init init_mpc7450_pmu(void)
 {
-	unsigned int pvr = mfspr(SPRN_PVR);
-
-	if (PVR_VER(pvr) != PVR_7450)
+	if (!pvr_version_is(PVR_VER_7450) && !pvr_version_is(PVR_VER_7455) &&
+	    !pvr_version_is(PVR_VER_7447) && !pvr_version_is(PVR_VER_7447A) &&
+	    !pvr_version_is(PVR_VER_7448))
 		return -ENODEV;
 
 	return register_power_pmu(&mpc7450_pmu);
-- 
2.39.2



