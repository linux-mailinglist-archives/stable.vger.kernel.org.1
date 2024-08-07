Return-Path: <stable+bounces-65801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC74B94ABFB
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C9AB2219E
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F80D839E4;
	Wed,  7 Aug 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nNaUxgRx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E26C78C92;
	Wed,  7 Aug 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043445; cv=none; b=ATSIkAi6C+CZ7/l+rSLtdkYP+Xq07+BXMdL2xiL6NQbwBkKoPXRMY0ynxk9wupISjjqvnwF0USu/epfjNwy/WpyFH/O9VsfiHVZFuGb3OB929pwBjbqit48SglHyJZFzf4xnWo/B7QQpSQqARDYDWnVY+aMu9jAVXq9xii+N5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043445; c=relaxed/simple;
	bh=02sk7rTobK4Ey+1Bd1dFup8q2kA4Gme4RTXupcNLpZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4MGy49exxfMs9PSiztWBnHakD5yV8AIyKUXrWwsnLiG4NqCYRsVbwGFhJxz210A6+QzH6pQ0OcriS4O8bnYExklO7ZAIz6u4m9GgImgThqzlIlJuLC2dzhrgSSpOOIShb09U81TVARwRi6pVIXleUYaHYFymIY2ZB3D/nFLz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nNaUxgRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FC3C32781;
	Wed,  7 Aug 2024 15:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043445;
	bh=02sk7rTobK4Ey+1Bd1dFup8q2kA4Gme4RTXupcNLpZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNaUxgRxB0FjK2M59fF+KOSioFApm/er+0wf5neceQ0ccE7NI42hTf+oXHj4xttRE
	 gHjx9RYGfN/lRJkkV7cWdkTH7ZoyOU0nG0XMsLYLu/C4NcEtgjeRmV1OOuQpMLf8wY
	 rJdL7nYOnVqilv0aeGmudt3CqUoOZUE5q9yEihW4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.6 094/121] rust: SHADOW_CALL_STACK is incompatible with Rust
Date: Wed,  7 Aug 2024 17:00:26 +0200
Message-ID: <20240807150022.468097291@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alice Ryhl <aliceryhl@google.com>

commit f126745da81783fb1d082e67bf14c6795e489a88 upstream.

When using the shadow call stack sanitizer, all code must be compiled
with the -ffixed-x18 flag, but this flag is not currently being passed
to Rust. This results in crashes that are extremely difficult to debug.

To ensure that nobody else has to go through the same debugging session
that I had to, prevent configurations that enable both SHADOW_CALL_STACK
and RUST.

It is rather common for people to backport 724a75ac9542 ("arm64: rust:
Enable Rust support for AArch64"), so I recommend applying this fix all
the way back to 6.1.

Cc: stable@vger.kernel.org # 6.1 and later
Fixes: 724a75ac9542 ("arm64: rust: Enable Rust support for AArch64")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://lore.kernel.org/r/20240729-shadow-call-stack-v4-1-2a664b082ea4@google.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1898,6 +1898,7 @@ config RUST
 	depends on !MODVERSIONS
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
+	depends on !SHADOW_CALL_STACK
 	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
 	help
 	  Enables Rust support in the kernel.



