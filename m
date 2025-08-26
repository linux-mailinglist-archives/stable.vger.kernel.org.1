Return-Path: <stable+bounces-175667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A81B369C3
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AAA01C8392C
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFC3568E3;
	Tue, 26 Aug 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qTNbMoia"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82D35337D;
	Tue, 26 Aug 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217651; cv=none; b=hMAGxHiVA499kmCtqGq+ZgIHLMEmnnfKk62JA37XLX/5TTAOv80hdATs3rlIOMqRGZ1WWVe5m1ukYQLDotdkP3QrJFR9HcN/GzoEcR8UdVwdglCLP80qprVSSNyBwsXE66TukyAuf1W3IuXsTanQgkFYxthdMRS31zqfdTvMLA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217651; c=relaxed/simple;
	bh=jH6NCTB8SbmlKrqthmgF/XNajfVSS4ukyLIE6ZXBZp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+90sycu03m6hmS23jqNyl4/hu+nrQ4nLcQsDQ20HrhWefM+3Bp9GMLD4SsaKwEuyD9HWi5K4eIGz4mx8S+WUjr5MQB/L4mYyRDx8VS4RtgdrhFQYrXRo4hkeNM/VqXPeyHLAg+0TgTAYrXSjnf/KCLVl7NoG4bM1tyvJ3EAmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qTNbMoia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC7CC4CEF1;
	Tue, 26 Aug 2025 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217651;
	bh=jH6NCTB8SbmlKrqthmgF/XNajfVSS4ukyLIE6ZXBZp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTNbMoiannNnP2VL6t22BoFSBwG1g/f57jS5vIKvRw8iIuFkaWNPxw9UODDgnQBnH
	 217ec+s2XOcrEElas7N0E88toTW528KKm876k84ZiuAn6WhJBoHW9283/HrWpbJXyf
	 MQNxnIgr0ZWALNtpBD2+/754FIbDKFxbvAB+FRKw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cynthia Huang <cynthia@andestech.com>,
	Ben Zong-You Xie <ben717@andestech.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 223/523] selftests/futex: Define SYS_futex on 32-bit architectures with 64-bit time_t
Date: Tue, 26 Aug 2025 13:07:13 +0200
Message-ID: <20250826110929.961641101@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cynthia Huang <cynthia@andestech.com>

[ Upstream commit 04850819c65c8242072818655d4341e70ae998b5 ]

The kernel does not provide sys_futex() on 32-bit architectures that do not
support 32-bit time representations, such as riscv32.

As a result, glibc cannot define SYS_futex, causing compilation failures in
tests that rely on this syscall. Define SYS_futex as SYS_futex_time64 in
such cases to ensure successful compilation and compatibility.

Signed-off-by: Cynthia Huang <cynthia@andestech.com>
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Link: https://lore.kernel.org/all/20250710103630.3156130-1-ben717@andestech.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/futex/include/futextest.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..7a5fd1d5355e 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -47,6 +47,17 @@ typedef volatile u_int32_t futex_t;
 					 FUTEX_PRIVATE_FLAG)
 #endif
 
+/*
+ * SYS_futex is expected from system C library, in glibc some 32-bit
+ * architectures (e.g. RV32) are using 64-bit time_t, therefore it doesn't have
+ * SYS_futex defined but just SYS_futex_time64. Define SYS_futex as
+ * SYS_futex_time64 in this situation to ensure the compilation and the
+ * compatibility.
+ */
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
-- 
2.39.5




