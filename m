Return-Path: <stable+bounces-152674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA92ADA318
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 21:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADF247A5D7D
	for <lists+stable@lfdr.de>; Sun, 15 Jun 2025 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1C627A46E;
	Sun, 15 Jun 2025 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="VSxSX4dp"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D51AF4D5;
	Sun, 15 Jun 2025 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750014318; cv=none; b=fVeYBPPbxObeG2tg56THAUJIPbTyGmrzcIO4zhF4PONTo7533qL77u0WtoKgFPf5KR3iQqMEEtsxcKu0Zk0NWNr+4vXskw8l6/UfpiGPi+q2wVNDOYVmrImJb426SxPVrnCVDSsfZAnQ0mubHQiqZa180rhc1ix0Ch9ccPFaREQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750014318; c=relaxed/simple;
	bh=FWrHqk/kzJNwxJWyGilx6u1wYekkIj8F1GAZAsnWbwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5NwCvKQ48Xm8jn4+ATqiqr8sx9As48v5kALI8tUyXGqTQQ8bOuY81WoGW4EEJRcagTIF0+Dej6ZwMND37tI2WWTLTV4A+++j35GHzNMrXhqk+JwTBqURGP5NWGeK/J12ypE21tEt/XLSxH7Jp9Bwtp/htEcdPTZKPIjIfkkOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=VSxSX4dp; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 1289F7D326;
	Sun, 15 Jun 2025 20:58:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1750013905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bPq4P3vMMBYE0Ng/6PCq2aBifA04302QKM865sr86Yw=;
	b=VSxSX4dpBa4hHDk88OOllPTl5j8mgbV0ubSIp3AK5W/5o62cKSzjPPZhvcHLCapKrWowoE
	kocBjbuOy9LClCMLLIZJnqYYefAVtHwmEZVt+70cLY24wD4AEZyEXu2gfrjKuDF3NZ4+Mi
	vFSau0OQn1HYMXyeGD2xMVanNcRTAPg=
From: Achill Gilgenast <fossdd@pwned.life>
To: linux-kernel@vger.kernel.org
Cc: Achill Gilgenast <fossdd@pwned.life>,
	stable@vger.kernel.org
Subject: [PATCH v2] kallsyms: fix build without execinfo
Date: Sun, 15 Jun 2025 20:58:17 +0200
Message-ID: <20250615185821.824140-1-fossdd@pwned.life>
X-Mailer: git-send-email 2.50.0.rc2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some libc's like musl libc don't provide execinfo.h since it's not part
of POSIX. In order to fix compilation on musl, only include execinfo.h
if available (HAVE_BACKTRACE_SUPPORT)

This was discovered with c104c16073b7 ("Kunit to check the longest symbol length")
which starts to include linux/kallsyms.h with Alpine Linux' configs.

Signed-off-by: Achill Gilgenast <fossdd@pwned.life>
Cc: stable@vger.kernel.org
---
 tools/include/linux/kallsyms.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/linux/kallsyms.h b/tools/include/linux/kallsyms.h
index 5a37ccbec54f..f61a01dd7eb7 100644
--- a/tools/include/linux/kallsyms.h
+++ b/tools/include/linux/kallsyms.h
@@ -18,6 +18,7 @@ static inline const char *kallsyms_lookup(unsigned long addr,
 	return NULL;
 }
 
+#ifdef HAVE_BACKTRACE_SUPPORT
 #include <execinfo.h>
 #include <stdlib.h>
 static inline void print_ip_sym(const char *loglvl, unsigned long ip)
@@ -30,5 +31,8 @@ static inline void print_ip_sym(const char *loglvl, unsigned long ip)
 
 	free(name);
 }
+#else
+static inline void print_ip_sym(const char *loglvl, unsigned long ip) {}
+#endif
 
 #endif
-- 
2.50.0.rc2


