Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB276AEDF
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjHAJmn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjHAJmb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:42:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DAD5BA0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5963614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58B8C433C7;
        Tue,  1 Aug 2023 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882807;
        bh=JsutQyQYYvaNaN24RytUNgnTDSMBdmWfuAHv/Nkvs8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1fPq8MH3cdKaFd/BFuWYAG4moNbBCyCU0K1Zg9/pIsZ8bu1sj6us2Twy/dnQ1ZHJz
         +RGJnwZE9Vqgk2OyRhMoeYhDBwVviAbMKvtnvgc5MQsdzKJD6vTrzUpuv2XTP/jv0F
         GHdQxgSRAUr5IarhwPzlLBh2ngO/PGVB1SzKF5Qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marc Hartmayer <mhartmay@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 010/239] KVM: s390: pv: simplify shutdown and fix race
Date:   Tue,  1 Aug 2023 11:17:54 +0200
Message-ID: <20230801091926.031512391@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

[ Upstream commit 5ff92181577a89ed12ad4e0e5813751faf16a139 ]

Simplify the shutdown of non-protected VMs. There is no need to do
complex manipulations of the counter if it was zero.

This also fixes a very rare race which caused pages to be torn down
from the address space with a non-zero counter even on older machines
that don't support the UVC instruction, causing a crash.

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: fb491d5500a7 ("KVM: s390: pv: asynchronous destroy for reboot")
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20230705111937.33472-2-imbrenda@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kvm/pv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 3ce5f4351156a..899f3b8ac0110 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -411,8 +411,12 @@ int kvm_s390_pv_deinit_cleanup_all(struct kvm *kvm, u16 *rc, u16 *rrc)
 	u16 _rc, _rrc;
 	int cc = 0;
 
-	/* Make sure the counter does not reach 0 before calling s390_uv_destroy_range */
-	atomic_inc(&kvm->mm->context.protected_count);
+	/*
+	 * Nothing to do if the counter was already 0. Otherwise make sure
+	 * the counter does not reach 0 before calling s390_uv_destroy_range.
+	 */
+	if (!atomic_inc_not_zero(&kvm->mm->context.protected_count))
+		return 0;
 
 	*rc = 1;
 	/* If the current VM is protected, destroy it */
-- 
2.39.2



