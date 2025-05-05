Return-Path: <stable+bounces-139739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF9AA9CF0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09B1717D280
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 20:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FFF1B5EB5;
	Mon,  5 May 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7NRILBW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023FF34CF5;
	Mon,  5 May 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746475214; cv=none; b=cqSo400jissaCKCs//n3dx+lAJBYGOozWylaQIwY+gMDusxbATR8SLPbN63d5HsD3XXkx4YGk+VQmvgqsmAQzFbseHMmvLaC1UlXywdnL9QBZQ4HWNa5e6S4e/s8wpsypDQo2+HJGKNeZqZDgGDR99I5eJVMB4vS92o6BGT0Xjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746475214; c=relaxed/simple;
	bh=nn4mB8H4ufY4kw1Y9euB8H1PuuLGUJug1P4n+1/nRFg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E0jWV3Z4O23DqXa0LTsxqXFu4Z2Wh2C4m5PotM/POIOeu/30EuOdkrJTbF5V0olQKL0VjdOpa/K2nmONQIzT4+3Xw/OLpDr4uZUpykVp8ImJUQRKO/3rLht5q7LCG63wry/3VUOrTB+9NIuS/hCj0dodmdcOW35SgaMOjhdwEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7NRILBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B36EC4CEE4;
	Mon,  5 May 2025 20:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746475213;
	bh=nn4mB8H4ufY4kw1Y9euB8H1PuuLGUJug1P4n+1/nRFg=;
	h=Date:From:To:Cc:Subject:From;
	b=W7NRILBWo26BjRzhS2ooaBcA5gplnZBFpmkF3oM+/WmYGYlSGFAZ9jK1pFauF+0hy
	 51YN4X75djshtQkoMTKF6EO4F6dUZlmm7D1kExjOwFkFUirNI0X2lcCsCDIlBqUtee
	 O90JyvjIra0snBjn6kxr2rBezbJ4rV+BjFULQauzVkToLovV5GXw2XK/vEVFThI4Tk
	 OwwL1j8t7G1tiRnH/NdUwc7qhRnJFbxgRQ80wkhs0mLMaz9NGu8qC0ea28fdX6d7Ij
	 /TlbMdXmoXMBghAYjuQDS5/1jJUPwEaH7qRTuFD6dbNItXajtROLFbFZZNbcgu85TI
	 H1/ouTOQs/+vA==
Date: Mon, 5 May 2025 22:00:08 +0200
From: Helge Deller <deller@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pranjal Shrivastava <praan@google.com>, linux-parisc@vger.kernel.org
Subject: [PATCH] parisc stable patch for kernel v6.12
Message-ID: <aBkYyCNo1ebnzZgp@carbonx1>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg,

below is a backport for upstream patch 
fd87b7783802 ("net: Fix the devmem sock opts and msgs for parisc").

This upstream patch does not apply cleanly against v6.12, and
backporting all intermediate changes are too big, so I created this
trivial standalone patch instead.

Can you please add the patc below to the stable queue for v6.12?

Thanks!
Helge

---

From: Pranjal Shrivastava <praan@google.com>
Date: Mon, 24 Mar 2025 07:42:27 +0000
Subject: [PATCH] net: Fix the devmem sock opts and msgs for parisc

The devmem socket options and socket control message definitions
introduced in the TCP devmem series[1] incorrectly continued the socket
definitions for arch/parisc.

The UAPI change seems safe as there are currently no drivers that
declare support for devmem TCP RX via PP_FLAG_ALLOW_UNREADABLE_NETMEM.
Hence, fixing this UAPI should be safe.

Fix the devmem socket options and socket control message definitions to
reflect the series followed by arch/parisc.

[1] https://lore.kernel.org/lkml/20240910171458.219195-10-almasrymina@google.com/

Patch modified for kernel 6.12 by Helge Deller.

Fixes: 8f0b3cc9a4c10 ("tcp: RX path for devmem TCP")
Signed-off-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git b/arch/parisc/include/uapi/asm/socket.h a/arch/parisc/include/uapi/asm/socket.h
index 38fc0b188e08..96831c988606 100644
--- b/arch/parisc/include/uapi/asm/socket.h
+++ a/arch/parisc/include/uapi/asm/socket.h
@@ -132,11 +132,15 @@
 #define SO_PASSPIDFD		0x404A
 #define SO_PEERPIDFD		0x404B
 
-#define SO_DEVMEM_LINEAR	78
+#define SCM_TS_OPT_ID		0x404C
+
+#define SO_RCVPRIORITY		0x404D
+
+#define SO_DEVMEM_LINEAR	0x404E
 #define SCM_DEVMEM_LINEAR	SO_DEVMEM_LINEAR
-#define SO_DEVMEM_DMABUF	79
+#define SO_DEVMEM_DMABUF	0x404F
 #define SCM_DEVMEM_DMABUF	SO_DEVMEM_DMABUF
-#define SO_DEVMEM_DONTNEED	80
+#define SO_DEVMEM_DONTNEED	0x4050
 
 #if !defined(__KERNEL__)
 

