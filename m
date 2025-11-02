Return-Path: <stable+bounces-192024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19EC28F83
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 14:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C31B3AAEF8
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DDA136672;
	Sun,  2 Nov 2025 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZRe+34PY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D4B25557
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 13:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762090729; cv=none; b=VO7N4XJ7VT44N85cEZxpTZzcOyarzD8nQ8Lp+8s4zS2jjpxQ9Tz0QOB20uLB5ghDNyMgK2aL5dqQ1BNTzGXTTXJx6xf4ihRimZjd85IkJScowr9XQ0hNTqpFgXTJprFqGesfF4SoAGGrS13nCVEj4F0wQecrin3cIovr4aIfob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762090729; c=relaxed/simple;
	bh=pQBsgM2QMPc1FXCX5C0F8rz0l5OJKrv7x8G+lX938/g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uJJMCJg8APeXNqKSea37L084dQnQe8mTCqBD5F3C2DHA3ofYtC7F+4Pw9qfOjBPJUHhem6nmHyrcjcKxqhWCL9ju9aQIheww3Ud1DbG1rKAIm8xYlTOOGkD8l8XMPVtmUBmhaWAgWjBA3C+LDojQx/pvGw3hdmbA779aXM73M3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZRe+34PY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B0DC4CEF7;
	Sun,  2 Nov 2025 13:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762090727;
	bh=pQBsgM2QMPc1FXCX5C0F8rz0l5OJKrv7x8G+lX938/g=;
	h=Subject:To:Cc:From:Date:From;
	b=ZRe+34PYV8aUvNK6tv4/2mYd67z6Us6yAaRhHXVMBPxPb+00FEgj7IGrnRQLbCp8T
	 uWrwpV5JN731nNlpHEKgZtLU0dAPoLjF9uOWWLaCFdh1Dnxw1ZEUUHXPfu0xA5zfpx
	 eJILFPz4k5xi8zbtX/GnvBxBdIYI71EhGfWkLb4Y=
Subject: WTF: patch "[PATCH] video: fb: Fix typo in comment in fb.h" was seriously submitted to be applied to the 6.17-stable tree?
To: mercmerc961@gmail.com,deller@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 02 Nov 2025 22:38:40 +0900
Message-ID: <2025110240-uncapped-overstep-8c1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

The patch below was submitted to be applied to the 6.17-stable tree.

I fail to see how this patch meets the stable kernel rules as found at
Documentation/process/stable-kernel-rules.rst.

I could be totally wrong, and if so, please respond to 
<stable@vger.kernel.org> and let me know why this patch should be
applied.  Otherwise, it is now dropped from my patch queues, never to be
seen again.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18cd0a9c7aaf880502e4aff3ea30022f97d6c103 Mon Sep 17 00:00:00 2001
From: PIYUSH CHOUDHARY <mercmerc961@gmail.com>
Date: Mon, 20 Oct 2025 00:05:08 +0530
Subject: [PATCH] video: fb: Fix typo in comment in fb.h

Fix typo: "verical" -> "vertical" in macro description

Signed-off-by: PIYUSH CHOUDHARY <mercmerc961@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org

diff --git a/include/uapi/linux/fb.h b/include/uapi/linux/fb.h
index cde8f173f566..22acaaec7b1c 100644
--- a/include/uapi/linux/fb.h
+++ b/include/uapi/linux/fb.h
@@ -319,7 +319,7 @@ enum {
 #define FB_VBLANK_HAVE_VCOUNT	0x020	/* the vcount field is valid */
 #define FB_VBLANK_HAVE_HCOUNT	0x040	/* the hcount field is valid */
 #define FB_VBLANK_VSYNCING	0x080	/* currently in a vsync */
-#define FB_VBLANK_HAVE_VSYNC	0x100	/* verical syncs can be detected */
+#define FB_VBLANK_HAVE_VSYNC	0x100	/* vertical syncs can be detected */
 
 struct fb_vblank {
 	__u32 flags;			/* FB_VBLANK flags */


