Return-Path: <stable+bounces-84613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824CC99D10F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32F11C21978
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3271AB505;
	Mon, 14 Oct 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zHFKy5z9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC091A76A5;
	Mon, 14 Oct 2024 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918616; cv=none; b=utROpuD9Cfh3qFt8q9GJt9upzkVeAplmr0TL94i5YisEFb4j2jbpuPD+doW91wTQAcBxIhU4rsssvWhJf3To0zYrr+gHCm+/NkjAUOguZ8lGTWxf0EYH2rm17sBoN94dP+k4cB4Rkh2FD7F7uvbiib0s5edkV1ge1JJF1qTNkdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918616; c=relaxed/simple;
	bh=TE9eABTqUB/6gOcNu8CXOiw+A4vFdfmwWfey9+HZNKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAJxP4XUfS2RkauOzNkshS2EcATJ7AT3EOm7VT4NnSqad7NTcl6Q6zrKdVtKjR1Ow1sKr7a8jA/CgSUZiDBWVMEe0Km+PQDdt9z2PegP38oTkBe08OJO07w9X8UG60vk7gDgt4maRb2jfZmT6U/Z1ge6VrshB5czFEa/w3KlzTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zHFKy5z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8083AC4CEC3;
	Mon, 14 Oct 2024 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918615;
	bh=TE9eABTqUB/6gOcNu8CXOiw+A4vFdfmwWfey9+HZNKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zHFKy5z9aCloAQojr+k1k1VplLjZwa4wtWqBtthxa8uVmD1DlXDQsWH5kZ90MhYSZ
	 xVZSVnPPM+DomVDGQIw5rwScUhcGC7mxMc3JqlmshbPIC7PBp4Bjwl56CxfoQByIdr
	 Gw9LOtf5y9KZQHVE25IZ59GVM4VIN2vZmNGDCmHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Erhard F." <erhard_f@mailbox.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6.1 373/798] powerpc: Allow CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2 with ld.lld 15+
Date: Mon, 14 Oct 2024 16:15:27 +0200
Message-ID: <20241014141232.607587414@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit a11334d8327b3fd7987cbfb38e956a44c722d88f upstream.

Commit 5017b4594672 ("powerpc/64: Option to build big-endian with ELFv2
ABI") restricted the ELFv2 ABI configuration such that it can only be
selected when linking with ld.bfd, due to lack of testing with LLVM.

ld.lld can link ELFv2 kernels without any issues; in fact, it is the
only ABI that ld.lld supports, as ELFv1 is not supported in ld.lld.

As this has not seen a ton of real world testing yet, be conservative
and only allow this option to be selected with the latest stable release
of LLVM (15.x) and newer.

While in the area, remove 'default n', as it is unnecessary to specify
it explicitly since all boolean/tristate configuration symbols default
to n.

Tested-by: "Erhard F." <erhard_f@mailbox.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20230118-ppc64-elfv2-llvm-v1-3-b9e2ec9da11d@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -593,8 +593,7 @@ config PPC64_BIG_ENDIAN_ELF_ABI_V2
 	bool "Build big-endian kernel using ELF ABI V2 (EXPERIMENTAL)"
 	depends on PPC64 && CPU_BIG_ENDIAN
 	depends on CC_HAS_ELFV2
-	depends on LD_IS_BFD && LD_VERSION >= 22400
-	default n
+	depends on LD_VERSION >= 22400 || LLD_VERSION >= 150000
 	help
 	  This builds the kernel image using the "Power Architecture 64-Bit ELF
 	  V2 ABI Specification", which has a reduced stack overhead and faster



