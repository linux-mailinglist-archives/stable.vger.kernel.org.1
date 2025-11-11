Return-Path: <stable+bounces-193942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AE3C4A94C
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74B1F347C84
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8B8306491;
	Tue, 11 Nov 2025 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B3VORrvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC81248F6A;
	Tue, 11 Nov 2025 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824429; cv=none; b=BIdOco+YnILBNIY8i7jF03g3h/0k26euPk5BPIHhmkTwFDkKmm674OB6uYVFXMmvAMtyQtA5CF9W2lUj4LDu28om+GB2CFlwoO+w3XGa5fRthyQ/2j4siGmbxiCLoE0zudzT2PrkOcLZNFnQFQL4MY/YfEcKRrXABxM0w4rX9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824429; c=relaxed/simple;
	bh=5Or4kSrZR7Rldrx8ldwSnhM7Yx9aqgY4FIvzJb31RbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbPWGborRHmchrJYrwscPBgVoOMNPPfy8izH3DZeEpqeZJ6bShkE0PKqp8l9FvDK8Bd6vweyeVZ9jsfZykSeNdtkxdPUQ+S3+TRoUOit5X8f4xm6CAbBWuy16vchDaTGqpEGs8krDa99oc2W8Y26Y3UFqQ/LFkbQsO1K+9V2Uw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B3VORrvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDD5C19425;
	Tue, 11 Nov 2025 01:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824429;
	bh=5Or4kSrZR7Rldrx8ldwSnhM7Yx9aqgY4FIvzJb31RbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B3VORrvJ0+5tn6X7WTJRVK/azCJibFJfqILF7t1R57JbRS2ONuxt0DXSdQg9FyT+s
	 HyW1/Dwv98lInbGXxP+7vb8mB+2Re8ct1YBhoQLnKinLrCPd72AGiGr+dyMaR+mETa
	 W6pd9BoTQbB/LZPQY750DLg1eDt3ePd26v/2NtVg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Larsson <andreas@gaisler.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 404/565] sparc64: fix prototypes of reads[bwl]()
Date: Tue, 11 Nov 2025 09:44:20 +0900
Message-ID: <20251111004535.961840373@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 7205ef77dfe167df1b83aea28cf00fc02d662990 ]

Conventions for readsl() are the same as for readl() - any __iomem
pointer is acceptable, both const and volatile ones being OK.  Same
for readsb() and readsw().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Andreas Larsson <andreas@gaisler.com> # Making sparc64 subject prefix
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/include/asm/io_64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index c9528e4719cd2..d8ed296624afd 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -250,19 +250,19 @@ void insl(unsigned long, void *, unsigned long);
 #define insw insw
 #define insl insl
 
-static inline void readsb(void __iomem *port, void *buf, unsigned long count)
+static inline void readsb(const volatile void __iomem *port, void *buf, unsigned long count)
 {
 	insb((unsigned long __force)port, buf, count);
 }
 #define readsb readsb
 
-static inline void readsw(void __iomem *port, void *buf, unsigned long count)
+static inline void readsw(const volatile void __iomem *port, void *buf, unsigned long count)
 {
 	insw((unsigned long __force)port, buf, count);
 }
 #define readsw readsw
 
-static inline void readsl(void __iomem *port, void *buf, unsigned long count)
+static inline void readsl(const volatile void __iomem *port, void *buf, unsigned long count)
 {
 	insl((unsigned long __force)port, buf, count);
 }
-- 
2.51.0




