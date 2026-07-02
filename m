Return-Path: <stable+bounces-271524-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R96jF0+cRmp1aAsAu9opvQ
	(envelope-from <stable+bounces-271524-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:13:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A236FB268
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:13:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ewIzGzJ+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271524-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271524-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A49EE3481465
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722B3101C8;
	Thu,  2 Jul 2026 17:02:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339F91FA859;
	Thu,  2 Jul 2026 17:02:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011768; cv=none; b=bYvgD6jzJFnLxLOTr1NeG5oFo39xGxo75bhWTxkDhVUh2OlvRfp8vjaKCZkp4DCq7ruHzGCuJm+1a7z6DZxbBNfiOYexa7N8k5M6GR8+GS5EpCpuuIgiWr2QXL5n+coF9qj773ULtQq95qtFY0QbSHD0GmgnvE+ih9OavV/FqNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011768; c=relaxed/simple;
	bh=/bPeA9xeup5phmepzJi3LXmLXiYxe/feqILskgQQLpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGjrr0oWqoxLnvCxo3FGHisax/AyUzJvzefD5R3SccqqYpKIbQI6/7rw85lUgJItp4OalXYJKi0Vi4yFAVpEFl7tnr/bUucJsOX7zcfvVKqK8RJiSTjE64okrw42p7pgVMaiwM6MfW3UvcpwIFO1s6cJQOEBrLhEdatCv2nc2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ewIzGzJ+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B821F00A3A;
	Thu,  2 Jul 2026 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011767;
	bh=UV7sO0SSyeax+8jOXQwNi/yNR6dZf8mVOTLz/rGYmHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ewIzGzJ+ztoPl8jEYa9xZRPfknpOO9Fr0vtZWOazpMkjlR6ANJj7mvKi0McfHwXsM
	 buB5AUNStDd3DVZQSK3NIl6e8CRAPQbOr5mX/iL1ncnLQyj9F6lpvNjXcPeRM9ZyDz
	 MvVOcG9GVEcWg84EKIckka4KKK6ptxJL2U4peEIA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 7.1 101/120] fbdev: omap2: fix use-after-free in omapfb_mmap
Date: Thu,  2 Jul 2026 18:21:37 +0200
Message-ID: <20260702155115.046925573@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155112.964534952@linuxfoundation.org>
References: <20260702155112.964534952@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-271524-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zenghongling@kylinos.cn,m:deller@gmx.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kylinos.cn,gmx.de];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3A236FB268

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongling Zeng <zenghongling@kylinos.cn>

commit 7958e67375aa111522086286bba13cfc0816ce8d upstream.

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
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1099,7 +1099,11 @@ static int omapfb_mmap(struct fb_info *f
 
 	rg = omapfb_get_mem_region(ofbi->region);
 
-	start = omapfb_get_region_paddr(ofbi);
+	if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB)
+		start = rg->vrfb.paddr[0];
+	else
+		start = rg->paddr;
+
 	len = fix->smem_len;
 
 	DBG("user mmap region start %lx, len %d, off %lx\n", start, len,
@@ -1109,6 +1113,8 @@ static int omapfb_mmap(struct fb_info *f
 	vma->vm_ops = &mmap_user_ops;
 	vma->vm_private_data = rg;
 
+	atomic_inc(&rg->map_count);
+
 	r = vm_iomap_memory(vma, start, len);
 	if (r)
 		goto error;
@@ -1121,6 +1127,7 @@ static int omapfb_mmap(struct fb_info *f
 	return 0;
 
 error:
+	atomic_dec(&rg->map_count);
 	omapfb_put_mem_region(rg);
 
 	return r;



