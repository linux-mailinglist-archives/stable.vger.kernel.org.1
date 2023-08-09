Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25369775E03
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjHILnK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbjHILnJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F8109
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFD076370E
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA87FC433C8;
        Wed,  9 Aug 2023 11:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691581388;
        bh=ybseqyWhUpJ0uvBEMRC5EP+T66CKprywQss8Y2bfgfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xct1bQZxBNvppRmV3FTFrwnEBibbdd/dHpOSvgc6JNkS9uo+91kIFHL9SHNph8IPW
         JLjtL10s6bmbAKg7XI4rtfX8zFWm/KMeoJJnD00+MTNEjgkVUqdqvY0LjlG/QEJlbS
         TKwfBksUeFPjRpUkADVESX3L+/2GVHIe7MM0eFL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 185/201] powerpc/mm/altmap: Fix altmap boundary check
Date:   Wed,  9 Aug 2023 12:43:07 +0200
Message-ID: <20230809103649.996200414@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

[ Upstream commit 6722b25712054c0f903b839b8f5088438dd04df3 ]

altmap->free includes the entire free space from which altmap blocks
can be allocated. So when checking whether the kernel is doing altmap
block free, compute the boundary correctly, otherwise memory hotunplug
can fail.

Fixes: 9ef34630a461 ("powerpc/mm: Fallback to RAM if the altmap is unusable")
Signed-off-by: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230724181320.471386-1-aneesh.kumar@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/init_64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index b76cd49d521b9..db040f34c0046 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -313,8 +313,7 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
 	start = ALIGN_DOWN(start, page_size);
 	if (altmap) {
 		alt_start = altmap->base_pfn;
-		alt_end = altmap->base_pfn + altmap->reserve +
-			  altmap->free + altmap->alloc + altmap->align;
+		alt_end = altmap->base_pfn + altmap->reserve + altmap->free;
 	}
 
 	pr_debug("vmemmap_free %lx...%lx\n", start, end);
-- 
2.40.1



