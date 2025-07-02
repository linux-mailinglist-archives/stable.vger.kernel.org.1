Return-Path: <stable+bounces-159212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65269AF0FB3
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 11:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A63446F55
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7C24113C;
	Wed,  2 Jul 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="xJbcQc7X";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="kZklyvij"
X-Original-To: stable@vger.kernel.org
Received: from mail186-10.suw21.mandrillapp.com (mail186-10.suw21.mandrillapp.com [198.2.186.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BD4246BA5
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 09:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.186.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447682; cv=none; b=UIfNzfR6NBwX3K7I2VXtlDdxJbSMByKeB0AoVKnaxERS9k7A7My3drfvX5lmp6HOuc6CwOcz8+F1ICdZS2Zy1YDnb3OIF9rXV/3JtDlwcqTrGDWiQ9J4J4+7V5gT6e2usebRk/Q7ym99CsjrwHM5blDeiSffgT9slwU3o5FrBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447682; c=relaxed/simple;
	bh=Si1a2Et2LYNNn6CB/OAkXf+8gYYVG6lXWvn6v9/6LJo=;
	h=From:Subject:To:Cc:Message-Id:Date:MIME-Version:Content-Type; b=oxcGSvh1UqP8rXtu3y/bgHoOQZcmoLpQN0Jkul4nAikhrlL4p6Ic98EWhsPSRlFyvNvIFsvrWaJThCvKW/3tRzV+Iywyyj+Fo0XneVyH44wXfWKaSvybBhTcfjCu7HqU8yWjiWmtUXL5HofIsQCkCATXvW5kM7dxBJ+UHSo0mJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=xJbcQc7X; dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b=kZklyvij; arc=none smtp.client-ip=198.2.186.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1751447680; x=1751717680;
	bh=CRG6VfCN4cKBDNecRFO7k0i/n5pBPOpFaCLwPgkXqR4=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=xJbcQc7XQgcT/BOXZTxTSyCp5MgWV6nF8aPwCjgR5nn70Z2ncuiYIRs+1Z8mcEvyC
	 BNvHvTPRPtncZGXk+JH6/JmQKhhOKPoKCWrQoOeKmDeszKBHxgdcaRnJ3o+WR9kbVh
	 D3tX4v6r5zq7APQE8YAQV1kRHzOAv2p2nJWZ4JhSsZnKAe0n+myy4RKcCRghFOP7Ml
	 OboNwnEKs61yF6FhBj/ebureESQQHoQDpC1TeFdIqBTyhz9lnEcrEBttgiP7xBuwcm
	 Vn461+ULjcfjXNys6hYRk3mnZPrYX4EIxQUkC2CwMNP1pEEEUtp0KNakCC1TUmUzlO
	 LM8VQ7OO2XuIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1751447680; x=1751708180; i=teddy.astie@vates.tech;
	bh=CRG6VfCN4cKBDNecRFO7k0i/n5pBPOpFaCLwPgkXqR4=;
	h=From:Subject:To:Cc:Message-Id:Feedback-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:CC:Date:Subject:From;
	b=kZklyvijFgte2MCu/fbRnmOgrymivt7WvZRT3BaF+Q4/kWIiTsoNxxYvCdTVFsP9C
	 azZ0y1zJRI7bQxa/QQ1zvuf38LMJllKcFEjTgj8Z86YjLWA4n2enbAavgbfIc8vODI
	 m7GpFEsCS9qbleeRQhIJVRWuZ9S9c4jOkNFS7B53lKuqcOLKZxpVUWn+DTdr4hoXqR
	 qe3sDXjVbJmmt7ExyPA0f3DIIxEqHzOxCDw5w2VNnphAXcM8Lgrqlo5RBQkwkfElug
	 iBvIfxEjuKkgWRr+J9x53dLV5pPYj/1bNe3mDdMpqWdLs/HwDyBu5VWF7FakckfX7l
	 mrW924jhreJUA==
Received: from pmta10.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail186-10.suw21.mandrillapp.com (Mailchimp) with ESMTP id 4bXDk81Gl6z5QkPWr
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 09:14:40 +0000 (GMT)
From: "Teddy Astie" <teddy.astie@vates.tech>
Subject: =?utf-8?Q?[PATCH=205.15.y]=20xen:=20replace=20xen=5Fremap()=20with=20memremap()?=
Received: from [37.26.189.201] by mandrillapp.com id 3d62def3b2d54855adb018878a221a41; Wed, 02 Jul 2025 09:14:40 +0000
X-Mailer: git-send-email 2.50.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1751447677873
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: "Teddy Astie" <teddy.astie@vates.tech>, "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, "Juergen Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Sasha Levin" <sashal@kernel.org>, "Jason Andryuk" <jason.andryuk@amd.com>, stable@vger.kernel.org, "kernel test robot" <lkp@intel.com>
Message-Id: <2398723b73ddd9923a9bb994364c2c7d3b89d21d.1751446695.git.teddy.astie@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.3d62def3b2d54855adb018878a221a41?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250702:md
Date: Wed, 02 Jul 2025 09:14:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

From: Juergen Gross <jgross@suse.com>

[ upstream commit 41925b105e345ebc84cedb64f59d20cb14a62613 ]

xen_remap() is used to establish mappings for frames not under direct
control of the kernel: for Xenstore and console ring pages, and for
grant pages of non-PV guests.

Today xen_remap() is defined to use ioremap() on x86 (doing uncached
mappings), and ioremap_cache() on Arm (doing cached mappings).

Uncached mappings for those use cases are bad for performance, so they
should be avoided if possible. As all use cases of xen_remap() don't
require uncached mappings (the mapped area is always physical RAM),
a mapping using the standard WB cache mode is fine.

As sparse is flagging some of the xen_remap() use cases to be not
appropriate for iomem(), as the result is not annotated with the
__iomem modifier, eliminate xen_remap() completely and replace all
use cases with memremap() specifying the MEMREMAP_WB caching mode.

xen_unmap() can be replaced with memunmap().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/r/20220530082634.6339-1-jgross@suse.com
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Teddy Astie <teddy.astie@vates.tech> [backport to 5.15.y]
---
 arch/x86/include/asm/xen/page.h   | 3 ---
 drivers/xen/grant-table.c         | 6 +++---
 drivers/xen/xenbus/xenbus_probe.c | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/xen/page.h b/arch/x86/include/asm/xen/page.h
index 1a162e559753..c183b7f9efef 100644
--- a/arch/x86/include/asm/xen/page.h
+++ b/arch/x86/include/asm/xen/page.h
@@ -355,9 +355,6 @@ unsigned long arbitrary_virt_to_mfn(void *vaddr);
 void make_lowmem_page_readonly(void *vaddr);
 void make_lowmem_page_readwrite(void *vaddr);
 
-#define xen_remap(cookie, size) ioremap((cookie), (size))
-#define xen_unmap(cookie) iounmap((cookie))
-
 static inline bool xen_arch_need_swiotlb(struct device *dev,
 					 phys_addr_t phys,
 					 dma_addr_t dev_addr)
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 0a2d24d6ac6f..a10e0741bec5 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -743,7 +743,7 @@ int gnttab_setup_auto_xlat_frames(phys_addr_t addr)
 	if (xen_auto_xlat_grant_frames.count)
 		return -EINVAL;
 
-	vaddr = xen_remap(addr, XEN_PAGE_SIZE * max_nr_gframes);
+	vaddr = memremap(addr, XEN_PAGE_SIZE * max_nr_gframes, MEMREMAP_WB);
 	if (vaddr == NULL) {
 		pr_warn("Failed to ioremap gnttab share frames (addr=%pa)!\n",
 			&addr);
@@ -751,7 +751,7 @@ int gnttab_setup_auto_xlat_frames(phys_addr_t addr)
 	}
 	pfn = kcalloc(max_nr_gframes, sizeof(pfn[0]), GFP_KERNEL);
 	if (!pfn) {
-		xen_unmap(vaddr);
+		memunmap(vaddr);
 		return -ENOMEM;
 	}
 	for (i = 0; i < max_nr_gframes; i++)
@@ -770,7 +770,7 @@ void gnttab_free_auto_xlat_frames(void)
 	if (!xen_auto_xlat_grant_frames.count)
 		return;
 	kfree(xen_auto_xlat_grant_frames.pfn);
-	xen_unmap(xen_auto_xlat_grant_frames.vaddr);
+	memunmap(xen_auto_xlat_grant_frames.vaddr);
 
 	xen_auto_xlat_grant_frames.pfn = NULL;
 	xen_auto_xlat_grant_frames.count = 0;
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 2068f83556b7..77ca24611293 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -982,8 +982,7 @@ static int __init xenbus_init(void)
 #endif
 		xen_store_gfn = (unsigned long)v;
 		xen_store_interface =
-			xen_remap(xen_store_gfn << XEN_PAGE_SHIFT,
-				  XEN_PAGE_SIZE);
+			memremap(xen_store_gfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE, MEMREMAP_WB);
 		break;
 	default:
 		pr_warn("Xenstore state unknown\n");
-- 
2.50.0



Teddy Astie | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


