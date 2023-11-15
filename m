Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B957ED13C
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344075AbjKOUAQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:00:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344096AbjKOUAO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:00:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375CFD42
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:00:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BAFC433CA;
        Wed, 15 Nov 2023 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078410;
        bh=wawxS7oO100s4uqACvMXLhL0U7QFAW6k62VmTAlgNR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Utjr/wfrYvo+gigd3dPhghbd5LB+4nI3lkeXlTleOmnfZn5tggGrZDYGLLCfpoR7k
         5eCsRR6T4DjOsBntVdCda4Ugm4yZJDZiBB+rPkPa/6mk91yuB5d2DsNR60H6xJBc96
         CbuF0qZ5/Hiqqc4iDDAwBl4qkgHB4sN8aRonFzXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wang Yufen <wangyufen@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 299/379] powerpc/pseries: fix potential memory leak in init_cpu_associativity()
Date:   Wed, 15 Nov 2023 14:26:14 -0500
Message-ID: <20231115192702.831385141@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Yufen <wangyufen@huawei.com>

[ Upstream commit 95f1a128cd728a7257d78e868f1f5a145fc43736 ]

If the vcpu_associativity alloc memory successfully but the
pcpu_associativity fails to alloc memory, the vcpu_associativity
memory leaks.

Fixes: d62c8deeb6e6 ("powerpc/pseries: Provide vcpu dispatch statistics")
Signed-off-by: Wang Yufen <wangyufen@huawei.com>
Reviewed-by: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/1671003983-10794-1-git-send-email-wangyufen@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/lpar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 2c2812a87d470..541199c6a587d 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -524,8 +524,10 @@ static ssize_t vcpudispatch_stats_write(struct file *file, const char __user *p,
 
 	if (cmd) {
 		rc = init_cpu_associativity();
-		if (rc)
+		if (rc) {
+			destroy_cpu_associativity();
 			goto out;
+		}
 
 		for_each_possible_cpu(cpu) {
 			disp = per_cpu_ptr(&vcpu_disp_data, cpu);
-- 
2.42.0



