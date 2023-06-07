Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86DB726FE3
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 23:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjFGVDI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 17:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbjFGVCv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 17:02:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD412D40
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 14:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D770364952
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 21:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1DDC433EF;
        Wed,  7 Jun 2023 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171728;
        bh=fB2t+XiNwgunXLLsIRauPibcBJeUjBXSOPg0QfRyofo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSxMtb+PmYSH9dNe6yFczRriYNTPzymv40ov2H86lEBPgfDyRgqKpYfIdXX8tbr3W
         AY7bfSebn0HvaQOnM3UWwwzfOSxwjPfF+29GWANiPgtucyafK+NlSRJZckZNE1ETYd
         qquw+OsAncFfr7drtsu+9+CsQXq+zyUA6uS90Bx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jon Pan-Doh <pandoh@google.com>,
        Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Nadav Amit <namit@vmware.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 5.15 127/159] iommu/amd: Fix domain flush size when syncing iotlb
Date:   Wed,  7 Jun 2023 22:17:10 +0200
Message-ID: <20230607200907.834747082@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jon Pan-Doh <pandoh@google.com>

commit 2212fc2acf3f6ee690ea36506fb882a19d1bfcab upstream.

When running on an AMD vIOMMU, we observed multiple invalidations (of
decreasing power of 2 aligned sizes) when unmapping a single page.

Domain flush takes gather bounds (end-start) as size param. However,
gather->end is defined as the last inclusive address (start + size - 1).
This leads to an off by 1 error.

With this patch, verified that 1 invalidation occurs when unmapping a
single page.

Fixes: a270be1b3fdf ("iommu/amd: Use only natural aligned flushes in a VM")
Cc: stable@vger.kernel.org # >= 5.15
Signed-off-by: Jon Pan-Doh <pandoh@google.com>
Tested-by: Sudheer Dantuluri <dantuluris@google.com>
Suggested-by: Gary Zibrat <gzibrat@google.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Acked-by: Nadav Amit <namit@vmware.com>
Link: https://lore.kernel.org/r/20230426203256.237116-1-pandoh@google.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/amd/iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2222,7 +2222,7 @@ static void amd_iommu_iotlb_sync(struct
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_pages(dom, gather->start, gather->end - gather->start, 1);
+	domain_flush_pages(dom, gather->start, gather->end - gather->start + 1, 1);
 	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }


