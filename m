Return-Path: <stable+bounces-134867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A866CA953A4
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92449189466B
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220571DDC28;
	Mon, 21 Apr 2025 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqGtsvUP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57207FBA2
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249990; cv=none; b=KC6AS76tFgEwY4cizGhis2mQ8tjrC0/fNqZuoFwnzDXDKOgHgkASFFaGFEGaT+UqJ5NwQbrcqL3C4oVyAkd8xd4NIaA1b0ldPsz15EiHoZcCBqzw7HVaJP1VRPw+XK3PpxVW7nWEys+7JSpXuBX3+4pLRjjntuAQG4i2uAtYOF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249990; c=relaxed/simple;
	bh=ccZApOb3cZrGMEG/phtSzl59bE7Et037S/+lZ6mNOes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c3mjj8HBR8bOTAxOL6Jmq2Tnfr6SoJjV6E3xLki5fUAQB3VobSEmgaWswrn/n5LMlY6zkda1rBb1USPVMq0VR/9pFd0XzauGiaKRLl6VAKjb/FM2vV+XN4dZJERENb9TC3lei1IbGJUr7Xdmi0O76Pv7KYKKKt52/q5OlTtyx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqGtsvUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C02C4CEE4;
	Mon, 21 Apr 2025 15:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745249990;
	bh=ccZApOb3cZrGMEG/phtSzl59bE7Et037S/+lZ6mNOes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqGtsvUPFBCpU655qL8KoQyME3YulmQudHHJMAiyU2VnCnuJeEmnPo+Q7nZcGbUn/
	 cPF47f6oK3O0nlD42geFO6cqR5wtyMnC1hGu/CyMzprW7AyOAHMu2nl5zlf2wBewyf
	 MXdldRD5Jmx4zh+NsMxhbk8HVOLWJGhImSMGFAYdtvXXCIMUQDbnUr5jTHY6lU7kpe
	 /YlnOQLp/fG7exgqabGUJZl0FOT3YROBCFZPOS7R6ZPY+Cg58QaS46j9rbWfeqr+N5
	 QdBPqobqrq8XD7Jeabn4IOHfNjBcVACvdrBX8WrfL04SjPX/A6j5zm0IxldZO2wznq
	 Kps5QrDA45iDQ==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	kees@kernel.org
Subject: [PATCH 6.12] lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
Date: Mon, 21 Apr 2025 08:39:19 -0700
Message-ID: <20250421153918.3248505-2-nathan@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042120-backward-waged-41cf@gregkh>
References: <2025042120-backward-waged-41cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit ed2b548f1017586c44f50654ef9febb42d491f31 upstream.

CONFIG_UBSAN_INTEGER_WRAP is 'default UBSAN', which is problematic for a
couple of reasons.

The first is that this sanitizer is under active development on the
compiler side to come up with a solution that is maintainable on the
compiler side and usable on the kernel side. As a result of this, there
are many warnings when the sanitizer is enabled that have no clear path
to resolution yet but users may see them and report them in the meantime.

The second is that this option was renamed from
CONFIG_UBSAN_SIGNED_WRAP, meaning that if a configuration has
CONFIG_UBSAN=y but CONFIG_UBSAN_SIGNED_WRAP=n and it is upgraded via
olddefconfig (common in non-interactive scenarios such as CI),
CONFIG_UBSAN_INTEGER_WRAP will be silently enabled again.

Remove 'default UBSAN' from CONFIG_UBSAN_INTEGER_WRAP until it is ready
for regular usage and testing from a broader community than the folks
actively working on the feature.

Cc: stable@vger.kernel.org
Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250414-drop-default-ubsan-integer-wrap-v1-1-392522551d6b@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
[nathan: Fix conflict due to lack of rename from ed2b548f1017 in stable]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 lib/Kconfig.ubsan | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 1d4aa7a83b3a..37655f58b855 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -118,7 +118,6 @@ config UBSAN_UNREACHABLE
 
 config UBSAN_SIGNED_WRAP
 	bool "Perform checking for signed arithmetic wrap-around"
-	default UBSAN
 	depends on !COMPILE_TEST
 	# The no_sanitize attribute was introduced in GCC with version 8.
 	depends on !CC_IS_GCC || GCC_VERSION >= 80000

base-commit: b6efa8ce222e58cfe2bbaa4e3329818c2b4bd74e
-- 
2.49.0


