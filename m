Return-Path: <stable+bounces-70932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A29469610BF
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47541C2310A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EBE1C5783;
	Tue, 27 Aug 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XzQm+GT8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2F73466;
	Tue, 27 Aug 2024 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771542; cv=none; b=OMBRVVvbwDGE2AIs0UcQIyWF2TlVKAYWyIzpSLzpI1+SqoXRUz2V64VttvDpRhhk88ahkWZ6n/MSO4gZlRwq0Xbvp7Jmn8UIMPdWqCbZA4KAig+go1DV/9qGSc5R6I5vcJAUKDOlulk/XqVYoaL31sir7sfvfUU8O1K3w0MDLSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771542; c=relaxed/simple;
	bh=ltIs5AUwDnAwgUsyRa5S28KLROETF1Z/100Mb4Cuk2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8R0rqTq3et2PmnSw9CheqCh6Z8lE1qQLuG0TFSY358zFfO5lWX7akkh1Pu3CePQEp4f3i7M5YBAODSpAkspwZeFxVTfhvdJhlGWsQMCh6Pb/9zyvrqVFLupFGzG7Np85yQsu8ouzf2aubYJcBWpnF5jJpUw12rjSUNyHGcIk7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XzQm+GT8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA4C4DDF2;
	Tue, 27 Aug 2024 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771541;
	bh=ltIs5AUwDnAwgUsyRa5S28KLROETF1Z/100Mb4Cuk2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XzQm+GT8ujDBURF5rcjNmc4OJl4h2OvnhcBBCo3YrztH3+O1ZARLEDrtkgCRRE/yA
	 cFcuZo1m48YvZSHIRmFqgChmi0qrcm4qwWiSHp77BIvnKKnMcjq2c+1ZuS1bwyp7ux
	 GRk6CFwJkSm6Iwm5a8aXubrIkqHjNGamEYdd3QqY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 219/273] s390/boot: Avoid possible physmem_info segment corruption
Date: Tue, 27 Aug 2024 16:39:03 +0200
Message-ID: <20240827143841.742004995@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit d7fd2941ae9a67423d1c7bee985f240e4686634f ]

When physical memory for the kernel image is allocated it does not
consider extra memory required for offsetting the image start to
match it with the lower 20 bits of KASLR virtual base address. That
might lead to kernel access beyond its memory range.

Suggested-by: Vasily Gorbik <gor@linux.ibm.com>
Fixes: 693d41f7c938 ("s390/mm: Restore mapping of kernel image using large pages")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/startup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 5a36d5538dae8..7797446620b64 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -446,9 +446,9 @@ void startup_kernel(void)
 	 */
 	kaslr_large_page_offset = __kaslr_offset & ~_SEGMENT_MASK;
 	if (kaslr_enabled()) {
-		unsigned long end = ident_map_size - kaslr_large_page_offset;
+		unsigned long size = kernel_size + kaslr_large_page_offset;
 
-		__kaslr_offset_phys = randomize_within_range(kernel_size, _SEGMENT_SIZE, 0, end);
+		__kaslr_offset_phys = randomize_within_range(size, _SEGMENT_SIZE, 0, ident_map_size);
 	}
 	if (!__kaslr_offset_phys)
 		__kaslr_offset_phys = nokaslr_offset_phys;
-- 
2.43.0




