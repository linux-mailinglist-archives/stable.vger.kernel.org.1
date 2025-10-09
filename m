Return-Path: <stable+bounces-183693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAC8BC9066
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 14:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C585188B5FE
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6252E2DD0;
	Thu,  9 Oct 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ee2oM8RM"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B72E1F06
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013043; cv=none; b=KbxmVWEzSBszDA+8nZNFM1YjE9ET8Z009RSKh7FkfmlEXWDysob/VFtkzoi/QQkhZvlB3Ts0n5j7FJ5qmDbrvC8BzisI5Il/g82pMOmnSVlQTcPBJ+sNdEj6zORdBwYOOMZq3qvPSowzjO/Nr0lb+XbcgLLfoB7E31O9HQhBB3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013043; c=relaxed/simple;
	bh=t9ylgHY+PljaKu8kJBcIBeNSsNWev04iThKtIuBpAP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDbrDD42wul0cIp8IrCCQuTpAR9P08R03AjPolvN9Q0taEu6gCPsX9Qy695ZItzhp8KkbD3GMXOKhjZTQ/z2X5uGBTQjktjl8Nl+nPP2XmjyaM4T0o/EsusRU0CtAHd9rjWqWDDIOMg/ndBEgBMC59VUdkFbwFttMHTFOZU4ywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ee2oM8RM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760013041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyzFZxJbO2L5avzgNukRA/OHc7c+vIBxWzW6CopjW/U=;
	b=Ee2oM8RMxllvs/YkserRvdFNMURkdfAgiAsLkghH/+1pQIcPDgBO+n/BVdV4cuomYP9zDu
	c4CkcPbMl1Sz9NzZub7t4WcJuz2IiJFEM9ho96evS78qqyrs+2t13DahQb0nWGQvbBj5dl
	M9eoUFsz1hZa4Hu8F2t0SBJT+hPsraM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-Ys3Hi_-hOVit_MVKA0Ie8g-1; Thu,
 09 Oct 2025 08:30:39 -0400
X-MC-Unique: Ys3Hi_-hOVit_MVKA0Ie8g-1
X-Mimecast-MFC-AGG-ID: Ys3Hi_-hOVit_MVKA0Ie8g_1760013038
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 027001800587;
	Thu,  9 Oct 2025 12:30:38 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9328180035E;
	Thu,  9 Oct 2025 12:30:34 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6/6] drm/panic: Fix 24bit pixel crossing page boundaries
Date: Thu,  9 Oct 2025 14:24:53 +0200
Message-ID: <20251009122955.562888-7-jfalempe@redhat.com>
In-Reply-To: <20251009122955.562888-1-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When using page list framebuffer, and using RGB888 format, some
pixels can cross the page boundaries, and this case was not handled,
leading to writing 1 or 2 bytes on the next virtual address.

Add a check and a specific function to handle this case.

Fixes: c9ff2808790f0 ("drm/panic: Add support to scanout buffer as array of pages")
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 46 +++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index bc5158683b2b..d4b6ea42db0f 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -174,6 +174,33 @@ static void drm_panic_write_pixel24(void *vaddr, unsigned int offset, u32 color)
 	*p = color & 0xff;
 }
 
+/*
+ * Special case if the pixel crosses page boundaries
+ */
+static void drm_panic_write_pixel24_xpage(void *vaddr, struct page *next_page,
+					  unsigned int offset, u32 color)
+{
+	u8 *vaddr2;
+	u8 *p = vaddr + offset;
+
+	vaddr2 = kmap_local_page_try_from_panic(next_page);
+
+	*p++ = color & 0xff;
+	color >>= 8;
+
+	if (offset == PAGE_SIZE - 1)
+		p = vaddr2;
+
+	*p++ = color & 0xff;
+	color >>= 8;
+
+	if (offset == PAGE_SIZE - 2)
+		p = vaddr2;
+
+	*p = color & 0xff;
+	kunmap_local(vaddr2);
+}
+
 static void drm_panic_write_pixel32(void *vaddr, unsigned int offset, u32 color)
 {
 	u32 *p = vaddr + offset;
@@ -231,7 +258,14 @@ static void drm_panic_blit_page(struct page **pages, unsigned int dpitch,
 					page = new_page;
 					vaddr = kmap_local_page_try_from_panic(pages[page]);
 				}
-				if (vaddr)
+				if (!vaddr)
+					continue;
+
+				// Special case for 24bit, as a pixel might cross page boundaries
+				if (cpp == 3 && offset + 3 > PAGE_SIZE)
+					drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
+								      offset, fg32);
+				else
 					drm_panic_write_pixel(vaddr, offset, fg32, cpp);
 			}
 		}
@@ -321,7 +355,15 @@ static void drm_panic_fill_page(struct page **pages, unsigned int dpitch,
 				page = new_page;
 				vaddr = kmap_local_page_try_from_panic(pages[page]);
 			}
-			drm_panic_write_pixel(vaddr, offset, color, cpp);
+			if (!vaddr)
+				continue;
+
+			// Special case for 24bit, as a pixel might cross page boundaries
+			if (cpp == 3 && offset + 3 > PAGE_SIZE)
+				drm_panic_write_pixel24_xpage(vaddr, pages[page + 1],
+							      offset, color);
+			else
+				drm_panic_write_pixel(vaddr, offset, color, cpp);
 		}
 	}
 	if (vaddr)
-- 
2.51.0


