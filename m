Return-Path: <stable+bounces-41740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00E8B5B92
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 16:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0ADB20BF8
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 14:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBB87E0F0;
	Mon, 29 Apr 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UsP3XMgz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NW5BH63a"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB5DDB1
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401652; cv=none; b=DijWR1jQy7VHX/uXKo9gWnnuISkDC44dtuI/2/0FEdAgY/oRbWuz21vscNOA+f9atPL+8LchB/4BTAH7CpMk8Q2JE4ZO+PNZZaY2MuIh91cSi9G9qhXIrLdMrn+MJZqJUCMsordqMuujQffp7/a5qvTtwH4CyQI5Pm2AcuhWl5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401652; c=relaxed/simple;
	bh=mS8ttat710VBK9QJf0hRgzMsHv3u/PyVD9M6d7hyLis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JxfjoDfios+0TADCWs16Oc0u5vpaKqXMd7tMi1+YeKRBsQ3wxw+cr+Op6ZfpAFhCUAvaIQM4jtOWzZGxUMRmtVaSxP1kiRFMYEoYx3mMgiF2B0XitfEEYMJgMj5D57EwzrR15301KH2DKLspS5yzXkFC1GFQ3EkWNkRr8xPCYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UsP3XMgz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NW5BH63a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714401648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KccofC6hY1MJk/QarpwJUkUvg3ipD1utkskQrScjO4M=;
	b=UsP3XMgzCswgKvHl32L6VeJt8j0EHimIC54MmGWQ9wXEvU1kOtNiKVOfN406H0nz5Nt2sQ
	N1tGUF8mFjJLGNoKNTHspSYiS47tsItDZOphp0ukawVYCAvdHA3MFzTQHUHlilBG4l2TZ+
	6uGFzsLU6nAxzqHf79/FbofdMGM66DmvpHOelgebK5HH/5swIW9og2CIh5llU/SnPYX3E7
	6A6f+hssoOnH6AndjONQcb9skuTxQTba02C8jJ7T0l1+o4B1AEh5BP3Cipv9mu5H3iwq0I
	/6PmcbFIlylbZiKjrDtpf+EbOBwlIjmvBR2pI03nA3Vjm+36AYz0XH+dyN1vZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714401648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KccofC6hY1MJk/QarpwJUkUvg3ipD1utkskQrScjO4M=;
	b=NW5BH63az4EhNpIaLv9qK1D/w/PaD/vY10voDwfNGqJOhkm/DGSzue2ZyC4IK1xn8JI2nn
	BePJnTnJSRtoPsCw==
To: stable@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5.15.y] fbdev: fix incorrect address computation in deferred IO
Date: Mon, 29 Apr 2024 16:40:41 +0200
Message-Id: <20240429144041.3498362-1-namcao@linutronix.de>
In-Reply-To: <2024042951-barbell-aeration-a1ce@gregkh>
References: <2024042951-barbell-aeration-a1ce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 78d9161d2bcd442d93d917339297ffa057dbee8c upstream.

With deferred IO enabled, a page fault happens when data is written to the
framebuffer device. Then driver determines which page is being updated by
calculating the offset of the written virtual address within the virtual
memory area, and uses this offset to get the updated page within the
internal buffer. This page is later copied to hardware (thus the name
"deferred IO").

This offset calculation is only correct if the virtual memory area is
mapped to the beginning of the internal buffer. Otherwise this is wrong.
For example, if users do:
    mmap(ptr, 4096, PROT_WRITE, MAP_FIXED | MAP_SHARED, fd, 0xff000);

Then the virtual memory area will mapped at offset 0xff000 within the
internal buffer. This offset 0xff000 is not accounted for, and wrong page
is updated.

Correct the calculation by using vmf->pgoff instead. With this change, the
variable "offset" will no longer hold the exact offset value, but it is
rounded down to multiples of PAGE_SIZE. But this is still correct, because
this variable is only used to calculate the page offset.

Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Closes: https://lore.kernel.org/linux-fbdev/271372d6-e665-4e7f-b088-dee5f4ab341a@oracle.com
Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240423115053.4490-1-namcao@linutronix.de
[rebase to v5.15]
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 drivers/video/fbdev/core/fb_defio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 1f12c2043603..c2a0a936d5fb 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -149,7 +149,7 @@ static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
 	unsigned long offset;
 	vm_fault_t ret;
 
-	offset = (vmf->address - vmf->vma->vm_start);
+	offset = vmf->pgoff << PAGE_SHIFT;
 
 	/* this is a callback we get when userspace first tries to
 	write to the page. we schedule a workqueue. that workqueue
-- 
2.39.2


