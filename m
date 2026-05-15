Return-Path: <stable+bounces-248139-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2E5eAvFHB2qrwQIAu9opvQ
	(envelope-from <stable+bounces-248139-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:21:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC105530F0
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DBE030A6D3D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14ED3E00A2;
	Fri, 15 May 2026 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVxsN4ea"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8466E30569C;
	Fri, 15 May 2026 16:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860970; cv=none; b=JAJIGVzMAgYNzoOnePcFME5y2SsjRfU7AtPmTngRIPugNaRTE5xyL58k1CPL+Qc+TphN+elWsm8Le9X3re+3j6q0K6zocwbI6CQUXciPBTYOxMUAb/VYpQH+Cg+cp6l5TSIG7y69m8FyMK3aLphxd8o8B3wojoGj2PGz3YErZKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860970; c=relaxed/simple;
	bh=Yc7CMBHGBZxR3NvOq1fdnu4PDW8nQ1jla5YZXmVFLgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4ARsP8z3W7dni4bcGzHSfECYMS/qNXrtik6igOpXYIa40O620kwoilWDFUKzexvg00AFHazhmXpvnHp80P5Vt7NpRBNtwjx+Yn87hKRtFtA0sDDxt0wAn4BP2eC7g2u68dNka/k6l/+OMNopZirVgUPszKUNzpqTADCAaurcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVxsN4ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1F3C2BCB0;
	Fri, 15 May 2026 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860970;
	bh=Yc7CMBHGBZxR3NvOq1fdnu4PDW8nQ1jla5YZXmVFLgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tVxsN4eaJaLThwnc5ZzYVeBNHsoBAXIUfHAkuGNTz1QUqw7IldwqLaNslL7AlDr3H
	 CASDD7/NDQyL3QOXcymmg/iRS7rtziwnY+TVKb8suUSaquyYN5RbvdJxe7Ie0zxer1
	 7DOe88ZpHqNa6k8bFUD7AT7MRmtMPmMmthQvF1lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rajat Gupta <rajgupt@qti.qualcomm.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6 148/474] fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent use-after-free
Date: Fri, 15 May 2026 17:44:17 +0200
Message-ID: <20260515154718.229278223@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EC105530F0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248139-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,qti.qualcomm.com,gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,gmx.de:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rajat Gupta <rajgupt@qti.qualcomm.com>

commit 8de779dc40d35d39fa07387b6f921eb11df0f511 upstream.

dlfb_ops_mmap() uses remap_pfn_range() to map vmalloc framebuffer pages
to userspace but sets no vm_ops on the VMA. This means the kernel cannot
track active mmaps. When dlfb_realloc_framebuffer() replaces the backing
buffer via FBIOPUT_VSCREENINFO, existing mmap PTEs are not invalidated.
On USB disconnect, dlfb_ops_destroy() calls vfree() on the old pages
while userspace PTEs still reference them, resulting in a use-after-free:
the process retains read/write access to freed kernel pages.

Add vm_operations_struct with open/close callbacks that maintain an
atomic mmap_count on struct dlfb_data. In dlfb_realloc_framebuffer(),
check mmap_count and return -EBUSY if the buffer is currently mapped,
preventing buffer replacement while userspace holds stale PTEs.

Tested with PoC using dummy_hcd + raw_gadget USB device emulation.

Signed-off-by: Rajat Gupta <rajgupt@qti.qualcomm.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/udlfb.c |   31 ++++++++++++++++++++++++++++++-
 include/video/udlfb.h       |    1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -321,12 +321,32 @@ static int dlfb_set_video_mode(struct dl
 	return retval;
 }
 
+static void dlfb_vm_open(struct vm_area_struct *vma)
+{
+	struct dlfb_data *dlfb = vma->vm_private_data;
+
+	atomic_inc(&dlfb->mmap_count);
+}
+
+static void dlfb_vm_close(struct vm_area_struct *vma)
+{
+	struct dlfb_data *dlfb = vma->vm_private_data;
+
+	atomic_dec(&dlfb->mmap_count);
+}
+
+static const struct vm_operations_struct dlfb_vm_ops = {
+	.open  = dlfb_vm_open,
+	.close = dlfb_vm_close,
+};
+
 static int dlfb_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
 {
 	unsigned long start = vma->vm_start;
 	unsigned long size = vma->vm_end - vma->vm_start;
 	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
 	unsigned long page, pos;
+	struct dlfb_data *dlfb = info->par;
 
 	if (info->fbdefio)
 		return fb_deferred_io_mmap(info, vma);
@@ -356,6 +376,9 @@ static int dlfb_ops_mmap(struct fb_info
 			size = 0;
 	}
 
+	vma->vm_ops = &dlfb_vm_ops;
+	vma->vm_private_data = dlfb;
+	atomic_inc(&dlfb->mmap_count);
 	return 0;
 }
 
@@ -1219,7 +1242,6 @@ static void dlfb_deferred_vfree(struct d
 
 /*
  * Assumes &info->lock held by caller
- * Assumes no active clients have framebuffer open
  */
 static int dlfb_realloc_framebuffer(struct dlfb_data *dlfb, struct fb_info *info, u32 new_len)
 {
@@ -1231,6 +1253,13 @@ static int dlfb_realloc_framebuffer(stru
 	new_len = PAGE_ALIGN(new_len);
 
 	if (new_len > old_len) {
+		if (atomic_read(&dlfb->mmap_count) > 0) {
+			dev_warn(info->dev,
+				"refusing realloc: %d active mmaps\n",
+				atomic_read(&dlfb->mmap_count));
+			return -EBUSY;
+		}
+
 		/*
 		 * Alloc system memory for virtual framebuffer
 		 */
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -56,6 +56,7 @@ struct dlfb_data {
 	spinlock_t damage_lock;
 	struct work_struct damage_work;
 	struct fb_ops ops;
+	atomic_t mmap_count;
 	/* blit-only rendering path metrics, exposed through sysfs */
 	atomic_t bytes_rendered; /* raw pixel-bytes driver asked to render */
 	atomic_t bytes_identical; /* saved effort with backbuffer comparison */



