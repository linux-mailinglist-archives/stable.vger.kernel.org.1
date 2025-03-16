Return-Path: <stable+bounces-124545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 865E2A63649
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 16:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74427A4A77
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8888F3B1AB;
	Sun, 16 Mar 2025 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMPUp7ZO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4620B381C4
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742139525; cv=none; b=hef014JoIF0+gl2m2MZWXRyuD3CptvgFGh2SXxrJd4+wQOut6sY+b/XNNq+zoSoaISXRiR7qwtrSHFhcaU+vf9geyvQ/hOBRVRoQ00iF6lBlP1RqwOXaQK2m2eV8JNI6h3FhoPgzxGvuoRupk7sp5OxBq4cgOoOPNr+gOkTsL/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742139525; c=relaxed/simple;
	bh=ItP7N3/e9YH4qpH8fEkqNYKAKoSDmr19olpsQZz0mAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV3W1E8rDRk5j+1gvIDhgx3jEinGl71rM+O8DTDHMAVl5WrAwI7j9aaNK0+orWaJZD85nVzfPCCtuoC9Jz4ZDue0Ex1yfU+Y4IDJoSPnZglsJAQHSflaCa11ibHrwNUXl7wn1didTOjHNxN8eIq1YEjtg9nyvc3nip9uiOMbSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMPUp7ZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C533FC4CEDD;
	Sun, 16 Mar 2025 15:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742139523;
	bh=ItP7N3/e9YH4qpH8fEkqNYKAKoSDmr19olpsQZz0mAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lMPUp7ZOGqqOjXanAPIUgmyXUCyaKuY4tVKUIkRrq/Mua+CZrqpPGUbySPinea3/R
	 pN3t3/io21/PZg4n0SUlzRDxE++mQbKF2MUc54uxFv/MYH83AkiMKw4v6DShepCL6d
	 dgclvBPi6JHejKLlpRLnOOe51/0uONU142u1y4FCWuR/umrJNNUMyez0BVRhT9kDoh
	 1zSaL3+q+znlwUJ+t8H8g5bpAs9xNOAjikxRfAFV8MVFEqmvWcuGVx1vsONg9fa0tc
	 KECKntbOWZ89dI7OI1lsuIMKjx8nCTigadywfa9OaD97wKz9kVLzrnmgI2La26/6vv
	 SGeN3t6+EDVFA==
From: Miguel Ojeda <ojeda@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.1.y] rust: Disallow BTF generation with Rust + LTO
Date: Sun, 16 Mar 2025 16:38:25 +0100
Message-ID: <20250316153825.2402903-1-ojeda@kernel.org>
In-Reply-To: <2025031622-rocker-narrow-b1e3@gregkh>
References: <2025031622-rocker-narrow-b1e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Maurer <mmaurer@google.com>

commit 5daa0c35a1f0e7a6c3b8ba9cb721e7d1ace6e619 upstream.

The kernel cannot currently self-parse BTF containing Rust debug
information. pahole uses the language of the CU to determine whether to
filter out debug information when generating the BTF. When LTO is
enabled, Rust code can cross CU boundaries, resulting in Rust debug
information in CUs labeled as C. This results in a system which cannot
parse its own BTF.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
Cc: stable@vger.kernel.org
Fixes: c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
Link: https://lore.kernel.org/r/20250108-rust-btf-lto-incompat-v1-1-60243ff6d820@google.com
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 2825c8cfde3b..b6786ddc88a8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1925,7 +1925,7 @@ config RUST
 	depends on !GCC_PLUGINS
 	depends on !RANDSTRUCT
 	depends on !SHADOW_CALL_STACK
-	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
+	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
 	help
 	  Enables Rust support in the kernel.
 
-- 
2.49.0


