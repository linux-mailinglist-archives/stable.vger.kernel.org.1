Return-Path: <stable+bounces-194170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A18C4AE32
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6111897297
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF84337BAE;
	Tue, 11 Nov 2025 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qFkEH/vr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D862BB17;
	Tue, 11 Nov 2025 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824970; cv=none; b=K+W56R6Rpq/TkM1gIO+VQQG+4qlLqe+G9UYth5pSWXXYRsIQz4cDVSXj3RDfmHpdzdcRomEttpLJmeaUy+LZj6sNgrvkrBun4bkM/PP8hZXDlgFsf7qaDAmXcBMK8FvJNzOSa0AQQUqSm4dOfsxY+EIy0f3qg6ov/zRogdztiF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824970; c=relaxed/simple;
	bh=ok6M+oYbjteZO0B0sgcWpfmO2O74WaHSZX3shj+qXQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5eoYoZTBftlsnbgn9gx37MCk26yw9PVP23L1o4mvyDIy0fina5Z+G8et8tzATOWGmIEKgrCr3gbLS2brwN2ltCcq1XMq3xw3MgS8Z6IvLcyPF6uRkty9rARVrLOqyfFC/UK789f/TqnMJRCUmS87x0tc5A7FWBFpZsL9R2AWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qFkEH/vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E994C19425;
	Tue, 11 Nov 2025 01:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824970;
	bh=ok6M+oYbjteZO0B0sgcWpfmO2O74WaHSZX3shj+qXQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFkEH/vrPMNJlft4sZ0OtPrODEo41C1Pjqnc8i1CLJZ/6xg5Hx+tajYMOpdLm5R30
	 SypD1RqFLTbfakEobECa0x2qdmMRWD2rMX6zF8m6Nn67SRZS0cJ7bPOQLPvRarRaE0
	 hUyGrmbzYYngQCWrve3dSON+weA2asYOGZRrI56A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andreas Larsson <andreas@gaisler.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 607/849] sparc64: fix prototypes of reads[bwl]()
Date: Tue, 11 Nov 2025 09:42:57 +0900
Message-ID: <20251111004551.095496162@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

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




