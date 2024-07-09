Return-Path: <stable+bounces-58321-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C33D92B667
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD6A1C22451
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF58156F45;
	Tue,  9 Jul 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qZnsAkhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE5157A48;
	Tue,  9 Jul 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523584; cv=none; b=QNxWNxvZbGXXLuFK+MHUdI1NZh+jIrX3eLgIE3CGTJjyQCNCBFZ5r2PQpUteO6QNTtNKwvx9qQmSABo2pNCxJ5jge7VD0ApPLlbH0g02MXwDKjcQdmCFa1/MwXZFlqscaAoyf65E7dr71NlbJCWtF7TXGPxc4AYLoMEvfyaJfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523584; c=relaxed/simple;
	bh=S3P+J5nlmT/5dnAc0xokEpxilX5ItcHiO4dXv+Mxclk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6OVaDhbrRR7Yq6dksJL3TjRbZiPfxnMyeGuJVnetE0aoFS1eaziXfGhD4r5ie6fqXD/wuQ+W8gefDPV9K2TPEWuNkifjy1Lbqy9YTTDtGFy6EP3KBjmKx3lDLxkAXTQ4eBexsM2jFaIVwROm8hOcDBcmkec+hXHl1fMawEgVT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qZnsAkhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AA8C3277B;
	Tue,  9 Jul 2024 11:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523584;
	bh=S3P+J5nlmT/5dnAc0xokEpxilX5ItcHiO4dXv+Mxclk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZnsAkhGzTP1oAJ71tmYHiDmvFy8DHtnclAmLhkn0XRBYoNb+vQmt7jExbNZXx5QU
	 K6mIYIqYI/I6XnPlnVBLvediyaZ5qmmT7LYiLhNnFCecUntUTFZ5f4XM6uuNrk9N5s
	 erwevRxxwmZ0O4v1ezaIV2J74CxY5XQxp8RH+uco=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Ellerman <mpe@ellerman.id.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 041/139] powerpc/64: Set _IO_BASE to POISON_POINTER_DELTA not 0 for CONFIG_PCI=n
Date: Tue,  9 Jul 2024 13:09:01 +0200
Message-ID: <20240709110659.752143470@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit be140f1732b523947425aaafbe2e37b41b622d96 ]

There is code that builds with calls to IO accessors even when
CONFIG_PCI=n, but the actual calls are guarded by runtime checks.

If not those calls would be faulting, because the page at virtual
address zero is (usually) not mapped into the kernel. As Arnd pointed
out, it is possible a large port value could cause the address to be
above mmap_min_addr which would then access userspace, which would be
a bug.

To avoid any such issues, set _IO_BASE to POISON_POINTER_DELTA. That
is a value chosen to point into unmapped space between the kernel and
userspace, so any access will always fault.

Note that on 32-bit POISON_POINTER_DELTA is 0, so the patch only has an
effect on 64-bit.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20240503075619.394467-2-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 59cc25cb4578e..99419e87f5556 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -37,7 +37,7 @@ extern struct pci_dev *isa_bridge_pcidev;
  * define properly based on the platform
  */
 #ifndef CONFIG_PCI
-#define _IO_BASE	0
+#define _IO_BASE	POISON_POINTER_DELTA
 #define _ISA_MEM_BASE	0
 #define PCI_DRAM_OFFSET 0
 #elif defined(CONFIG_PPC32)
-- 
2.43.0




