Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8967A76ADA7
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjHAJbJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjHAJar (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:30:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E0A2114
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:29:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43372614BB
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5210BC433C8;
        Tue,  1 Aug 2023 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882174;
        bh=jTbswkzDPhIVOFs1/1bs6Q946Gf651tfGhjo+nxkGzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TW0UugMDvJvhUono55CUv+8tL3Zz49IxlYq5+I3lJ7iB2wWGl2hRlGkJGY2MG3gfe
         nT/cc4ParUIZnvYrQtvoG0VRcvnFhd8Mh1SJzygcwm5unODRlbxNUFcXTTjjE5D0DM
         cZPpyoGb657ZBR0M3H/dVM/UjDdgf8zcEhAmk/ok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 012/228] KVM: s390: pv: fix index value of replaced ASCE
Date:   Tue,  1 Aug 2023 11:17:50 +0200
Message-ID: <20230801091923.278441678@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
References: <20230801091922.799813980@linuxfoundation.org>
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

[ Upstream commit c2fceb59bbda16468bda82b002383bff59de89ab ]

The index field of the struct page corresponding to a guest ASCE should
be 0. When replacing the ASCE in s390_replace_asce(), the index of the
new ASCE should also be set to 0.

Having the wrong index might lead to the wrong addresses being passed
around when notifying pte invalidations, and eventually to validity
intercepts (VM crash) if the prefix gets unmapped and the notifier gets
called with the wrong address.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: faa2f72cb356 ("KVM: s390: pv: leak the topmost page table when destroy fails")
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20230705111937.33472-3-imbrenda@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/gmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 02d15c8dc92e9..243f673fa6515 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2843,6 +2843,7 @@ int s390_replace_asce(struct gmap *gmap)
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, CRST_ALLOC_ORDER);
 	if (!page)
 		return -ENOMEM;
+	page->index = 0;
 	table = page_to_virt(page);
 	memcpy(table, gmap->table, 1UL << (CRST_ALLOC_ORDER + PAGE_SHIFT));
 
-- 
2.39.2



