Return-Path: <stable+bounces-74525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E242972FC8
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5812286E47
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3236218C002;
	Tue, 10 Sep 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b8Mn0HF2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E316818A6D2;
	Tue, 10 Sep 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962061; cv=none; b=nVhjmRfxFGOFhG/onYyr8J+ENkFlG9TDgC6WFrXTvjndNB6jW7rWyh3/ILyUOp15NbxDEqjOQMD/JCoDJ8RaCFB1JCttiZ7T5+Vx54Dm/3N7P3N3tXFFp1g7TkUvi90o1vYC2B5jweReU0qrtaK1asgcVexxBpVIMKKpmw2IVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962061; c=relaxed/simple;
	bh=4vGVyg+1BHNgyk3O0+WPazoxGJ5vi2ee5YPXLzLHQQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6rFIo7OPzznJJHe1STOJvRJsxem+n5PQtlEA/qmNJqK5pI1etCcMSlCEk9ZCNitXzC4QfvUswSpWmrmnSMzS6cFg+w5oCuTFKmjR+y4A0TuWAo4dFcZZnYZhYs2btANEF6S2/QAeGdIXfWjXQVj7ETT+alfoWPjreMc1W+S26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b8Mn0HF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD36C4CEC3;
	Tue, 10 Sep 2024 09:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725962060;
	bh=4vGVyg+1BHNgyk3O0+WPazoxGJ5vi2ee5YPXLzLHQQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8Mn0HF2+u1eIs6rFg4/gvkW+1jd9D5KKLORolvGIkJ9j9m7kKmgn5iLuuODY5oYg
	 cQFDA72aR440722xxZOi6Wcjph5AeMRyuOdhg67jAGYIwX1kIPjU6rn2YUfuDu8rdF
	 mCHXHa2csNoa1bg6/jJVr6NhWaMHF4GTEi+DxLMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 254/375] LoongArch: Use correct API to map cmdline in relocate_kernel()
Date: Tue, 10 Sep 2024 11:30:51 +0200
Message-ID: <20240910092631.081170216@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>
References: <20240910092622.245959861@linuxfoundation.org>
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

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 0124fbb4c6dba23dbdf80c829be68adbccde2722 ]

fw_arg1 is in memory space rather than I/O space, so we should use
early_memremap_ro() instead of early_ioremap() to map the cmdline.
Moreover, we should unmap it after using.

Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/relocate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 1acfa704c8d0..0eddd4a66b87 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -13,6 +13,7 @@
 #include <asm/bootinfo.h>
 #include <asm/early_ioremap.h>
 #include <asm/inst.h>
+#include <asm/io.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
 
@@ -170,7 +171,7 @@ unsigned long __init relocate_kernel(void)
 	unsigned long kernel_length;
 	unsigned long random_offset = 0;
 	void *location_new = _text; /* Default to original kernel start */
-	char *cmdline = early_ioremap(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
+	char *cmdline = early_memremap_ro(fw_arg1, COMMAND_LINE_SIZE); /* Boot command line is passed in fw_arg1 */
 
 	strscpy(boot_command_line, cmdline, COMMAND_LINE_SIZE);
 
@@ -182,6 +183,7 @@ unsigned long __init relocate_kernel(void)
 		random_offset = (unsigned long)location_new - (unsigned long)(_text);
 #endif
 	reloc_offset = (unsigned long)_text - VMLINUX_LOAD_ADDRESS;
+	early_memunmap(cmdline, COMMAND_LINE_SIZE);
 
 	if (random_offset) {
 		kernel_length = (long)(_end) - (long)(_text);
-- 
2.43.0




