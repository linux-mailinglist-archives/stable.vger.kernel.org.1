Return-Path: <stable+bounces-126158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AFAA6FFAA
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C8B178E3E
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0459266F02;
	Tue, 25 Mar 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cGRXM/Y2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6CC266EF3;
	Tue, 25 Mar 2025 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905708; cv=none; b=cYVoLhBmubEwoaY6xAkNKjVcPfBD6TIAryJIiaGlfL2ta005WpzHmRVc8NihpthHUZf6PKke56aMM0peZS3cWEkzLQ7EmjbwK5z2vL6Yta3FO7fgXR4VQgM0hPFmXY3+PrrAX+cK3APQgwv/g6EIx/2VAffviKHEPhkYeJ4OgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905708; c=relaxed/simple;
	bh=rlpOlDxN3WzmR+CuR/9q+d9b+2wDmqLAOndV9rCNat4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lrvlb64nfYzmnPFtVtMG42QrScY+xYeEpJnW4R+Oy0bKXPM7sH0W+UVGVJtWL44aqE+rVI1mSBScYIU/fNHuXibdvg7PSc1XfPtVHVOGdAfjX7lfj4x4D+kOX6bRN1aih/x+RuKEOyhHp4AK5OqMC83rKJuMfYXZ/vx4lPJUxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cGRXM/Y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08561C4CEE4;
	Tue, 25 Mar 2025 12:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742905708;
	bh=rlpOlDxN3WzmR+CuR/9q+d9b+2wDmqLAOndV9rCNat4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGRXM/Y2nyTfRcn1GUC4ADCkTPoJbLk9aSphLgTUgEHYkIDUk0nZMOf5jV682SsVp
	 tk7xXUiTY6y6EY8/zgAmecWXlAQFQOxAVFzvvGj4RJ9mVEzlbeSOGEyvG3UG8hufzS
	 T3LgLF3uLvm74gjPqNnGnkGl8ZY9fSYZQwt94cKU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Maurer <mmaurer@google.com>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.1 121/198] rust: Disallow BTF generation with Rust + LTO
Date: Tue, 25 Mar 2025 08:21:23 -0400
Message-ID: <20250325122159.829227300@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122156.633329074@linuxfoundation.org>
References: <20250325122156.633329074@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 



