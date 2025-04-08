Return-Path: <stable+bounces-131040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D7A8076E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC511B6683A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F5526A0E9;
	Tue,  8 Apr 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z39Cv/pL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F2B269CEB;
	Tue,  8 Apr 2025 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115327; cv=none; b=hSkv3ikscnP+iN5d2zNoVRfhbFPK2epFFKQ6XHWsGvwJoBayx9VeM7PHYKTiwR2GD+OZhtBrXLPO/hnOzuR4NMxF06fNVvoYoZZVtYLKWiKiiLLkd1TsJG89yKHYOMy/d/SnG4VbEHYOsToLBZmr678dGwXOvOK3E+LDJr9iiLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115327; c=relaxed/simple;
	bh=UcjN6t3JW0fR+Uer2x7xJbPmBQszJiHiCnPszPK9EYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzhwIVQbxoMdogkvd4tohIEcbRlgd2SkRIj+cRl2+o13A8MDtiijfpM6jRlh3bKj2+9N8W7wusXCAdltqx7R5rqTqoiAtTNlY4Rapb4H2ycN+SVib9YcLomU2ToNGukAwufgn2niWk9ZGYbEKS2ktSrSo3uZ7jjB+pNFks8kdfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z39Cv/pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF21C4CEE7;
	Tue,  8 Apr 2025 12:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115327;
	bh=UcjN6t3JW0fR+Uer2x7xJbPmBQszJiHiCnPszPK9EYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z39Cv/pLCHf3aABbsdx8dQaSYqaVQsIMt+4fY6PpzNqEYsSFzDGE4jyH1wPtd8BHx
	 0AqoLJ16iLS/5o+m8eQI3sT9JtlwQb2JtoLQ38EGRyKcn+OIi1mPmZt6zjJoATPr2d
	 BywD8izinUPr/Jn8PL7dIBxGgo2Elr1ruA4ZO7n4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	WANG Rui <wangrui@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.13 434/499] rust: Fix enabling Rust and building with GCC for LoongArch
Date: Tue,  8 Apr 2025 12:50:46 +0200
Message-ID: <20250408104902.053928232@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: WANG Rui <wangrui@loongson.cn>

commit 13c23cb4ed09466d73f1beae8956810b95add6ef upstream.

This patch fixes a build issue on LoongArch when Rust is enabled and
compiled with GCC by explicitly setting the bindgen target and skipping
C flags that Clang doesn't support.

Cc: stable@vger.kernel.org
Acked-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: WANG Rui <wangrui@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 rust/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/rust/Makefile
+++ b/rust/Makefile
@@ -230,7 +230,8 @@ bindgen_skip_c_flags := -mno-fp-ret-in-3
 	-mfunction-return=thunk-extern -mrecord-mcount -mabi=lp64 \
 	-mindirect-branch-cs-prefix -mstack-protector-guard% -mtraceback=no \
 	-mno-pointers-to-nested-functions -mno-string \
-	-mno-strict-align -mstrict-align \
+	-mno-strict-align -mstrict-align -mdirect-extern-access \
+	-mexplicit-relocs -mno-check-zero-division \
 	-fconserve-stack -falign-jumps=% -falign-loops=% \
 	-femit-struct-debug-baseonly -fno-ipa-cp-clone -fno-ipa-sra \
 	-fno-partial-inlining -fplugin-arg-arm_ssp_per_task_plugin-% \
@@ -244,6 +245,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-3
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
+BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
 # All warnings are inhibited since GCC builds are very experimental,



