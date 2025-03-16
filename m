Return-Path: <stable+bounces-124515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FDFA6346E
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 08:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353A216E1C1
	for <lists+stable@lfdr.de>; Sun, 16 Mar 2025 07:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B1717D346;
	Sun, 16 Mar 2025 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GS2n6NYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67298BE5
	for <stable@vger.kernel.org>; Sun, 16 Mar 2025 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742109469; cv=none; b=j8qN7nbbkmoXlHsJaW4gyY1gEg270vEimHdBPqja3VtD1W4ROrnRdN3alaKgySIB1W1KPGZF9O+faBMQQY6mNy31VjBaChHdy05LTNQF1cLd1gTqnndjv+j3+Fqz9spMiFdZdFV+QFH37ReE4uF8q38cXoIGqf3KbTXId3N+WQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742109469; c=relaxed/simple;
	bh=D5AC9cNjWF1ZpfC0D1DyK1trH3f++TqRQpfWNsu4hVs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EZzYNGPNk+zD8RZ72wvq8o15aMG3IjtM0pX5ihW9f4ht/3q32vhJC3u2q32vI7vCS2TSQAXQMjzB4z3HlHm66/zt5NjLToJ+9ZlHfdu2NDX+7IuJAI8xTsreozc3tTJTLQR7Pc2kSIzCKjn15g11gW5fSzoz+J/caDhM1xpbZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GS2n6NYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8ABC4CEDD;
	Sun, 16 Mar 2025 07:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742109469;
	bh=D5AC9cNjWF1ZpfC0D1DyK1trH3f++TqRQpfWNsu4hVs=;
	h=Subject:To:Cc:From:Date:From;
	b=GS2n6NYMDFqTf3JDkSlqocBM0ztCld+b5uF55ZOgFiISdzCMpnZ/0lc0oX2mkts7W
	 mh30A4j/bUpbzvnXR56/nsXYwvkL9THkE1yc/WTkCCXNnk3xFX4T12h861Q8F77Pel
	 RaggCeruczu4yCNd15G0JuciuIzR6Ii/3gQ9SO58=
Subject: FAILED: patch "[PATCH] rust: Disallow BTF generation with Rust + LTO" failed to apply to 6.1-stable tree
To: mmaurer@google.com,ojeda@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 16 Mar 2025 08:16:22 +0100
Message-ID: <2025031622-rocker-narrow-b1e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5daa0c35a1f0e7a6c3b8ba9cb721e7d1ace6e619
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025031622-rocker-narrow-b1e3@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5daa0c35a1f0e7a6c3b8ba9cb721e7d1ace6e619 Mon Sep 17 00:00:00 2001
From: Matthew Maurer <mmaurer@google.com>
Date: Wed, 8 Jan 2025 23:35:08 +0000
Subject: [PATCH] rust: Disallow BTF generation with Rust + LTO

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

diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b..324c2886b2ea 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1973,7 +1973,7 @@ config RUST
 	depends on !MODVERSIONS || GENDWARFKSYMS
 	depends on !GCC_PLUGIN_RANDSTRUCT
 	depends on !RANDSTRUCT
-	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
+	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
 	depends on !CFI_CLANG || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
 	select CFI_ICALL_NORMALIZE_INTEGERS if CFI_CLANG
 	depends on !CALL_PADDING || RUSTC_VERSION >= 108100


