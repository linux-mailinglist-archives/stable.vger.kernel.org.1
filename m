Return-Path: <stable+bounces-139741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CCFAA9CF9
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90C31A80AF8
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 20:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C9E25D8E3;
	Mon,  5 May 2025 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzFrx2W1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F31DED52;
	Mon,  5 May 2025 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746475479; cv=none; b=H+aa4vVIUiXpglumD/3a0zATsu2MdE/7yDbXLUoMxH/undcZi+6UssvvXuYGjGBzpY2F+W/JvrMwwj1Dh5EAliSQvDpvoAbvJGdXYzc1TQ2DhS8uSFNTi/75fISfOKdYsXVt0fz1FzoD9Rb85wWjU/35t2FSfIQ275VQNHjmpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746475479; c=relaxed/simple;
	bh=o3q/CCax1yynPtK0SNqzAqmcHX11U+7EM6LralLP3Co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZA4DmJ9s8QZ52PmQr5gwnGB1IHejuTDr/Ek5g3PwbC4tyGT+pkF0AvMv265hWkpCrT4NX+PYHlWoHt6PXwEPCU/fTPRcOPnKwDshGzXd9seerOTYhLS8iPL+puA1MMuJz1uNUJLiNVX84RtO5RwI2o6R9SzfRnF6KN621ePpOSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzFrx2W1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40878C4CEE4;
	Mon,  5 May 2025 20:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746475478;
	bh=o3q/CCax1yynPtK0SNqzAqmcHX11U+7EM6LralLP3Co=;
	h=Date:From:To:Cc:Subject:From;
	b=CzFrx2W1syeVAPXfZryXHyD1SAXFzGoqXZojf5/9cXudjekAYz3qbG91f4EeK6bbe
	 yvL75hwGs/c629E0lzevZdNyVt3F7OIQzYs+Hf8TjkClwjTZ1TunYki2KPsTw4pKIP
	 0IaMjl+VB6vZaXPyTBnO3q5f1sK/HUWIm+sGsxur/0xKpuYu73/Qp5h9C8I06wKKDF
	 NVT8AbPpMC60uvEgHtmY2mjID0RdY3yps6YbmfGySk2Xp9BOBP7wyJ0moXyf9bstv+
	 6JgqgLhZKHhkYgQ65cXXD+blFJBLNzz3kgbk4DSi+L4WE35eF9TiOeyf1uHI0S/cqa
	 0voYGb5eqt/cg==
Date: Mon, 5 May 2025 22:04:34 +0200
From: Helge Deller <deller@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pranjal Shrivastava <praan@google.com>, linux-parisc@vger.kernel.org
Subject: [PATCH] parisc stable patch for kernel v6.13
Message-ID: <aBkZ0v05A44yjoqc@carbonx1>
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

This upstream patch does not apply cleanly against v6.13, and
backporting all intermediate changes are too big, so I created this
trivial standalone patch instead.

Can you please add the patch below to the stable queue for v6.13?

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

Patch modified for kernel 6.13 by Helge Deller.

Fixes: 8f0b3cc9a4c10 ("tcp: RX path for devmem TCP")
Signed-off-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git b/arch/parisc/include/uapi/asm/socket.h a/arch/parisc/include/uapi/asm/socket.h
index d268d69bfcd2..96831c988606 100644
--- b/arch/parisc/include/uapi/asm/socket.h
+++ a/arch/parisc/include/uapi/asm/socket.h
@@ -132,13 +132,15 @@
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
-
-#define SCM_TS_OPT_ID		0x404C
+#define SO_DEVMEM_DONTNEED	0x4050
 
 #if !defined(__KERNEL__)
 

