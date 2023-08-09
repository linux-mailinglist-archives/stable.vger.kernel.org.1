Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1523777585E
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjHIKwQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbjHIKvE (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D920C2686
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F86E63137
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722ECC433BB;
        Wed,  9 Aug 2023 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578239;
        bh=sc06U4RR1eaFwU9DQlRlff9KWyeU+3QPspxLNzP20bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vd7JXuxzIwPt4ZtZxv4618NcrZkw81mF74Y0YFPPq+86MWv1Lu/GVRgyi41w8paLp
         5qbVI1d0v1/UBUdANeV096PlVx/fhGn+QvVqWM/laL4o/Q5ElC2Hezx9WagHyKsZdl
         SJcYgp0/EI4eHqKaYhoTPrI9P+Gj2b8ArwATPVEc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 154/165] powerpc/mm/altmap: Fix altmap boundary check
Date:   Wed,  9 Aug 2023 12:41:25 +0200
Message-ID: <20230809103647.811423966@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index fe1b83020e0df..0ec5b45b1e86a 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -314,8 +314,7 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
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



