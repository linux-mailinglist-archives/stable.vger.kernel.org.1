Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D842713F26
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjE1Tmb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjE1Tm1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466CBC7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C987A61ECC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F4AC433EF;
        Sun, 28 May 2023 19:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302945;
        bh=m8VNee3bA+lgpiWAyRUMwnimPC/EadPMf/JdyNqFKu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWFgaUVVgf/5ab05IS8x5vsSmz35tLny+U86Hwi23lZRXlMBb5l5Xfwjzz/KNs47G
         dSnKhOxskM6DwD6Fc7a1MAcT0kdaleRD9SAcePFwwVx7NSt5T/xeT7i41azvbHqlL5
         7H7tDDH4q3WFXLfsrJnDdtKGIBPr6DZq3KnLkqaY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
        Eli Cohen <elic@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 052/211] lib: cpu_rmap: Avoid use after free on rmap->obj array entries
Date:   Sun, 28 May 2023 20:09:33 +0100
Message-Id: <20230528190844.884642995@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Eli Cohen <elic@nvidia.com>

[ Upstream commit 4e0473f1060aa49621d40a113afde24818101d37 ]

When calling irq_set_affinity_notifier() with NULL at the notify
argument, it will cause freeing of the glue pointer in the
corresponding array entry but will leave the pointer in the array. A
subsequent call to free_irq_cpu_rmap() will try to free this entry again
leading to possible use after free.

Fix that by setting NULL to the array entry and checking that we have
non-zero at the array entry when iterating over the array in
free_irq_cpu_rmap().

The current code does not suffer from this since there are no cases
where irq_set_affinity_notifier(irq, NULL) (note the NULL passed for the
notify arg) is called, followed by a call to free_irq_cpu_rmap() so we
don't hit and issue. Subsequent patches in this series excersize this
flow, hence the required fix.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/cpu_rmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/cpu_rmap.c b/lib/cpu_rmap.c
index f08d9c56f712e..e77f12bb3c774 100644
--- a/lib/cpu_rmap.c
+++ b/lib/cpu_rmap.c
@@ -232,7 +232,8 @@ void free_irq_cpu_rmap(struct cpu_rmap *rmap)
 
 	for (index = 0; index < rmap->used; index++) {
 		glue = rmap->obj[index];
-		irq_set_affinity_notifier(glue->notify.irq, NULL);
+		if (glue)
+			irq_set_affinity_notifier(glue->notify.irq, NULL);
 	}
 
 	cpu_rmap_put(rmap);
@@ -268,6 +269,7 @@ static void irq_cpu_rmap_release(struct kref *ref)
 		container_of(ref, struct irq_glue, notify.kref);
 
 	cpu_rmap_put(glue->rmap);
+	glue->rmap->obj[glue->index] = NULL;
 	kfree(glue);
 }
 
@@ -297,6 +299,7 @@ int irq_cpu_rmap_add(struct cpu_rmap *rmap, int irq)
 	rc = irq_set_affinity_notifier(irq, &glue->notify);
 	if (rc) {
 		cpu_rmap_put(glue->rmap);
+		rmap->obj[glue->index] = NULL;
 		kfree(glue);
 	}
 	return rc;
-- 
2.39.2



