Return-Path: <stable+bounces-155004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED0AE162E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 10:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073D75A6692
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890F218E97;
	Fri, 20 Jun 2025 08:33:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1430E85B;
	Fri, 20 Jun 2025 08:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408432; cv=none; b=UJXzfOaC0Ok/FmfWJTabN6N3gPEjrPxdle848QpaAzRMsZSXl5zenXRm303CiPZHeIvpLxwbaP3EDptDus9YIQ1VxhCuqdsAtQN4Tz4tnPNSfn8y5/pmg93769TmZXqGXQ7CBhHZNcQU4wqEZHyUJ4qB6d32TrkcUdRDj5n3IjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408432; c=relaxed/simple;
	bh=2Ki+wwxCYsJ7rcLAzKRHBKRLvOF/if+BYd1HOF7l/Hk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EqGWT0ZG1q3Vsyts/trIfR7PiXDqIQP0HKrG9nm78ALZsDsodiAcZOm5sBBprJf8CXBgnwT1HhYb/F/vGHq3Pju8kYHMwJIsm5/KQAeNTrBl9W+NsQwtBlP3SquPh4KshQ7MQC10qHQhWF6oG7hk4MyKeVpYl45FuVM/yNM+F6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 55K8XVMM024432;
	Fri, 20 Jun 2025 10:33:31 +0200
From: Willy Tarreau <w@1wt.eu>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
        stable@vger.kernel.org
Subject: [PATCH] tools/nolibc: fix spelling of FD_SETBITMASK in FD_* macros
Date: Fri, 20 Jun 2025 10:33:25 +0200
Message-Id: <20250620083325.24390-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

While nolibc-test does test syscalls, it doesn't test as much the rest
of the macros, and a wrong spelling of FD_SETBITMASK in commit
feaf75658783a broke programs using either FD_SET() or FD_CLR() without
being noticed. Let's fix these macros.

Fixes: feaf75658783a ("nolibc: fix fd_set type")
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 30904be544ed0..16c6e9ec9451f 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -128,7 +128,7 @@ typedef struct {
 		int __fd = (fd);					\
 		if (__fd >= 0)						\
 			__set->fds[__fd / FD_SETIDXMASK] &=		\
-				~(1U << (__fd & FX_SETBITMASK));	\
+				~(1U << (__fd & FD_SETBITMASK));	\
 	} while (0)
 
 #define FD_SET(fd, set) do {						\
@@ -145,7 +145,7 @@ typedef struct {
 		int __r = 0;						\
 		if (__fd >= 0)						\
 			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
-1U << (__fd & FD_SET_BITMASK));						\
+1U << (__fd & FD_SETBITMASK));						\
 		__r;							\
 	})
 
-- 
2.17.5


