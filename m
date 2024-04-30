Return-Path: <stable+bounces-42522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 356158B736E
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4481F22A47
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C312CDAE;
	Tue, 30 Apr 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QnPg8Lic"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADA8801;
	Tue, 30 Apr 2024 11:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475934; cv=none; b=lr0P4CsJJql0DEuuIa9q4KddbJqJFoRJ7nAn1ddPrQbHmoH4yRSXSlM46ZgKd96LyPu/LcIyoGJq2wGqPqwX+b1Yp/2wpz+b+EPRqpLohfNGMMzOldQVNaMJnBUDGgJcnWps6YPh/vkVmYOJw8uws/IkVbR/1vhfi1BcicbPXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475934; c=relaxed/simple;
	bh=NIqZxR8ZOaBhayCbv3d7qAkgboYTnGJRQG8ew38XzWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l5bdELrITDQEdqdzKQMSxk+3U9jzJNk9+S0qfr5VG7obuDOyvpsIIs9OerrbrWyI1WszlnHE168zl3einLhvMZ3Awm/Q8kckFkDIg+AVF8o3aC2LvVJBP3aWB8Yj4UTwCtGqPqmpa1IsF7rrr0/v0x/Aw2socx+mEgBKBl6Bh24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QnPg8Lic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A88C2BBFC;
	Tue, 30 Apr 2024 11:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714475934;
	bh=NIqZxR8ZOaBhayCbv3d7qAkgboYTnGJRQG8ew38XzWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnPg8LicofH9bxRTR7wPFUI7dVfveBqPLaUIc/061+jUTiC9VRSQMwBfF/jDXa2H8
	 xbR/XonpxCIkDLhwnDTgfZOxv9XrTuRltzrxxZ+1tdqEFepbnd7VLHXEGk7DMhLOBD
	 C5LWfGTbUQe1+5t7MP3mFzLkbG9+eVBZnVIItvlQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guanrui Huang <guanrui.huang@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <maz@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 5.15 62/80] irqchip/gic-v3-its: Prevent double free on error
Date: Tue, 30 Apr 2024 12:40:34 +0200
Message-ID: <20240430103045.249712614@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103043.397234724@linuxfoundation.org>
References: <20240430103043.397234724@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guanrui Huang <guanrui.huang@linux.alibaba.com>

commit c26591afd33adce296c022e3480dea4282b7ef91 upstream.

The error handling path in its_vpe_irq_domain_alloc() causes a double free
when its_vpe_init() fails after successfully allocating at least one
interrupt. This happens because its_vpe_irq_domain_free() frees the
interrupts along with the area bitmap and the vprop_page and
its_vpe_irq_domain_alloc() subsequently frees the area bitmap and the
vprop_page again.

Fix this by unconditionally invoking its_vpe_irq_domain_free() which
handles all cases correctly and by removing the bitmap/vprop_page freeing
from its_vpe_irq_domain_alloc().

[ tglx: Massaged change log ]

Fixes: 7d75bbb4bc1a ("irqchip/gic-v3-its: Add VPE irq domain allocation/teardown")
Signed-off-by: Guanrui Huang <guanrui.huang@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240418061053.96803-2-guanrui.huang@linux.alibaba.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/irqchip/irq-gic-v3-its.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4530,13 +4530,8 @@ static int its_vpe_irq_domain_alloc(stru
 		set_bit(i, bitmap);
 	}
 
-	if (err) {
-		if (i > 0)
-			its_vpe_irq_domain_free(domain, virq, i);
-
-		its_lpi_free(bitmap, base, nr_ids);
-		its_free_prop_table(vprop_page);
-	}
+	if (err)
+		its_vpe_irq_domain_free(domain, virq, i);
 
 	return err;
 }



