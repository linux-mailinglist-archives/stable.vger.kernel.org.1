Return-Path: <stable+bounces-148362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D278ACA019
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 20:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BA21893957
	for <lists+stable@lfdr.de>; Sun,  1 Jun 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADEB13C8EA;
	Sun,  1 Jun 2025 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="jHOyLKUj"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D8981749;
	Sun,  1 Jun 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748803515; cv=none; b=qfwq03VjX2/XRE1IzPZOuexqS/T4Hi12i5Cdb711QgzfA6ma9rDwrhPpDUHhvjcmg0gjUFsiwh3kSpGBwFmjKQuYzhjHUrl7VwntR6Xiw+NJn8XyY7G9YkrNYLOt740aSwPPTNwQwtZu9iaVWk/EETTiBlsYFtZpiGlmjjjPXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748803515; c=relaxed/simple;
	bh=DdCzuF2jdAaCh5gSjoYZ6rWEzCiIX/pdVCDBIojq6q4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onjnkhO0s6YzurAhPGEMYdE/ixHMvIsjjsWIIhNfgqpeDLFHpy8a6n0TW9IbLHuzdMeve6e3YGBtF5JVBHbLMxQX9RxsAMcSWtjc7dxwjBy3E5CLFJ1CddwkN1UUTTAdFZ7xsYW1epWKN8415wp7OkOAhjqlun4p6ZcspG7OHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=jHOyLKUj; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 719C37D3B8;
	Sun,  1 Jun 2025 20:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1748803092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pGwguRJ3naXpD6hvNXG+LacN0qgAxSP4lCMkzOb+MWY=;
	b=jHOyLKUjCMWEmPvem9umpKBJHn/COElqT5c/33e+uYPCzlpM1pqLCL1MceFQrxMvsOX2mA
	/wuan5yJS109DR/AXx1XTocpgx3YmyasT2X+hYSpCoWIlpA5HW6Vz3iIzjyMu8OBZ0YCc1
	ZigfIpMeXS9Pa1XN5TQnb6Rn9Yd1pxY=
From: Achill Gilgenast <fossdd@pwned.life>
To: linux-kernel@vger.kernel.org
Cc: Achill Gilgenast <fossdd@pwned.life>,
	stable@vger.kernel.org
Subject: [PATCH] kallsyms: fix build without execinfo
Date: Sun,  1 Jun 2025 20:32:50 +0200
Message-ID: <20250601183309.225569-1-fossdd@pwned.life>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
2.49.0


