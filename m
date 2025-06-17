Return-Path: <stable+bounces-153364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E7BADD450
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B869C194330F
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313752EA155;
	Tue, 17 Jun 2025 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qM3iWzZm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6FF2EA14F;
	Tue, 17 Jun 2025 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175711; cv=none; b=eQk68KMLfGf7L/3ye3nCr51Fi/5XuN2e7tWqZN1NgPhlgT/QstsNctj4u1q3Iyc64nk60ydYY7YC3An+Z2RLn3pVYMj1Jt1ozqcumeLOnUtb6+XPKTeH/ujS7fOkOSQLR8GcynpwKyMRG8XJslxuHXPRqWHmu+YAMp8wvV5lRf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175711; c=relaxed/simple;
	bh=FfZW0Jv0Bs/jKdwdR0PYysYWcr2z9QbDGjlKwuCSv9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ/7uROD229nuS/ZDse0nWDiOzSIheV+GQhhbAoOPL86Rm8Iaksao7IBYmJ4nPdfkZXV7/sEK6MnmXtggc4eMMlw3Xkk1hqR8rK14/LBq24MIW/MxrMk/D6X+dyqi2ugJiL7louJIu6YlT9b5vt6eCJCoMHnEtvTxSbpNSDZC54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qM3iWzZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F905C4CEE3;
	Tue, 17 Jun 2025 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175710;
	bh=FfZW0Jv0Bs/jKdwdR0PYysYWcr2z9QbDGjlKwuCSv9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qM3iWzZmPKyvv8Mj+GdnbpkPTkUhc+e4P+EQ6Nb0b8u01/YDbnJNZssy0tV7rpnM1
	 Yw0xS5WWo7GpI/HlvQC/DT+UJLUJEbl6LDjSKV4ROt5LOjTUoBWWWtzXnycj50GdCM
	 K+JK+gs58E7RveL9joNKsO6U73AFLHIRleXq7Nws=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Wiepert <jonathan.wiepert@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 138/512] Use thread-safe function pointer in libbpf_print
Date: Tue, 17 Jun 2025 17:21:44 +0200
Message-ID: <20250617152425.192282393@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonathan Wiepert <jonathan.wiepert@gmail.com>

[ Upstream commit 91dbac4076537b464639953c055c460d2bdfc7ea ]

This patch fixes a thread safety bug where libbpf_print uses the
global variable storing the print function pointer rather than the local
variable that had the print function set via __atomic_load_n.

Fixes: f1cb927cdb62 ("libbpf: Ensure print callback usage is thread-safe")
Signed-off-by: Jonathan Wiepert <jonathan.wiepert@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Link: https://lore.kernel.org/bpf/20250424221457.793068-1-jonathan.wiepert@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c6eceae4d6ff6..bb24f6bac2073 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -285,7 +285,7 @@ void libbpf_print(enum libbpf_print_level level, const char *format, ...)
 	old_errno = errno;
 
 	va_start(args, format);
-	__libbpf_pr(level, format, args);
+	print_fn(level, format, args);
 	va_end(args);
 
 	errno = old_errno;
-- 
2.39.5




