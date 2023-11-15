Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB177ECCFD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjKOTdo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjKOTdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EE812C
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC358C433C8;
        Wed, 15 Nov 2023 19:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076819;
        bh=LR7OgexGTdbU/da0YC1V2v0I+rAeOEvCJwpHyngCbfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C+Yr5tt7cTnu4LQs/qQCWlE2WHWcidKV3ujSPFl65izVp1iTTGM6wJPk31tUT8ZJD
         lXFJKAviqqkQVOgLy5qs4kapy5prUlhTK/aTxVwxGHe4J8ODvBw9P/QhKvt+xFQs6G
         pb9GwmlWN4wshFT02jXSFOdSUbAk0zj5pBD+aTFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Gray <bgray@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 433/550] powerpc/xive: Fix endian conversion size
Date:   Wed, 15 Nov 2023 14:16:57 -0500
Message-ID: <20231115191630.782732813@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Gray <bgray@linux.ibm.com>

[ Upstream commit ff7a60ab1e065257a0e467c13b519f4debcd7fcf ]

Sparse reports a size mismatch in the endian swap. The Opal
implementation[1] passes the value as a __be64, and the receiving
variable out_qsize is a u64, so the use of be32_to_cpu() appears to be
an error.

[1]: https://github.com/open-power/skiboot/blob/80e2b1dc73/hw/xive.c#L3854

Fixes: 88ec6b93c8e7 ("powerpc/xive: add OPAL extensions for the XIVE native exploitation support")
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231011053711.93427-2-bgray@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/xive/native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 9f0af4d795d88..f1c0fa6ece21d 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -802,7 +802,7 @@ int xive_native_get_queue_info(u32 vp_id, u32 prio,
 	if (out_qpage)
 		*out_qpage = be64_to_cpu(qpage);
 	if (out_qsize)
-		*out_qsize = be32_to_cpu(qsize);
+		*out_qsize = be64_to_cpu(qsize);
 	if (out_qeoi_page)
 		*out_qeoi_page = be64_to_cpu(qeoi_page);
 	if (out_escalate_irq)
-- 
2.42.0



