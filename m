Return-Path: <stable+bounces-259741-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAh8FHSQHmodlAkAu9opvQ
	(envelope-from <stable+bounces-259741-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 10:12:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BACE962A462
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 10:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC50E305117B
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE08A3BFE31;
	Tue,  2 Jun 2026 08:04:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB043BE147;
	Tue,  2 Jun 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387473; cv=none; b=DlKoeP3U+32sVb9A9irPSEldSmxrPKVifrMUDjIbpwf/6XyW0ZQUN3kzmXBEfgpxdNoAXn91PTnh/IlQdeY+ZJcP4ppCaZFlI5RdAzFUTHLZv927EWFdxXB+TLMJoCB9roqW364AD4ekQApdG4aK2qNFeQjGzUz0uTZRM0XLfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387473; c=relaxed/simple;
	bh=OETo9jbPAvqC90MNsOMYY31pyLMfQavt0YIuX8WZ1iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T9JN46WLoZ8wgS71Fj1YYHJEr409VV0jpjC6BeGfGBc6FjxCFI3D+ynBaE0IMdcUVbUFDUObrfVPybO69GQne/XX3FhHajtyT8DqBuMfsJNq7yXMnLHXGPLD8yFgEX/fPh9bRYiVY9QvPCuw46NPUceyLZPHXMXCoGQMdpwORrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a86d62fa5e5911f1aa26b74ffac11d73-20260602
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2f781195-e581-4dbf-9a50-258240510d26,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:93f029c7c46a1e7e9f12274d0a1f2f49,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a86d62fa5e5911f1aa26b74ffac11d73-20260602
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 369047598; Tue, 02 Jun 2026 16:04:19 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: deller@gmx.de,
	kees@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: omap2: fix use-after-free in omapfb_mmap
Date: Tue,  2 Jun 2026 16:04:15 +0800
Message-Id: <20260602080415.171378-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259741-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,126.com,kylinos.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BACE962A462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

omapfb_mmap() has a race condition with OMAPFB_SETUP_PLANE ioctl that
can lead to use-after-free:

The fb_mmap() entry point holds mm_lock but not lock (fb_info->lock),
while ioctl handlers like OMAPFB_SETUP_PLANE hold lock but not mm_lock.
This allows concurrent execution.

In omapfb_mmap():
1. rg = omapfb_get_mem_region(ofbi->region);      // Get old region ref
2. start = omapfb_get_region_paddr(ofbi);          // Read from NEW region
3. len = fix->smem_len;                             // Read from NEW region
4. vm_iomap_memory(vma, start, len);               // Map NEW region memory
5. atomic_inc(&rg->map_count);                      // Increment OLD region!

Concurrently, OMAPFB_SETUP_PLANE can:
- Reassign ofbi->region = new_rg
- Update fix->smem_len
- OMAPFB_SETUP_MEM then checks NEW region's map_count (0!) and frees it

This leaves userspace with a mapping to freed physical memory.

The fix is to read all required values (start, len) from the same
region reference (rg) that will have its map_count incremented,
preventing the region from being freed while still mapped.

Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index d70deb6a9150..853bd55621ec 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1099,8 +1099,11 @@ static int omapfb_mmap(struct fb_info *fbi, struct vm_area_struct *vma)
 
 	rg = omapfb_get_mem_region(ofbi->region);
 
-	start = omapfb_get_region_paddr(ofbi);
-	len = fix->smem_len;
+	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
+		start = rg->vrfb.paddr[0];
+	else
+		start = rg->paddr;
+	len = rg->size;
 
 	DBG("user mmap region start %lx, len %d, off %lx\n", start, len,
 			vma->vm_pgoff << PAGE_SHIFT);
-- 
2.25.1


