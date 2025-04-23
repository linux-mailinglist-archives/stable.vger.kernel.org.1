Return-Path: <stable+bounces-136460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9128EA9968C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 19:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4F07AC17E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2570428A1E8;
	Wed, 23 Apr 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwGGpqYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07F28B50E
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745429134; cv=none; b=MUjw7emDL10YYwzuvo27mU3RRZefEhyuRZ0aAaCCdoK02cSE+e86c4DqIfzkJRp+1oM/qUbjwBDnIuVZJh3zUGUpdo7Gf4KNaSioU/l1fslJKQdBCNllueHHzXTSqS0ge7+p74B799qzCqWcNVsAHZRpxdm6pftxP9/dxnSX/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745429134; c=relaxed/simple;
	bh=m2NnblMxaxOcIaLbafnubhrGJ9wMgY5KgogBfJAbkYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcxoO3O/eCPPcYHI68F+q8OIiHRUzorVUwf6naCusGJbEm3U4ljacfIZEJCqwbSw0QMjM6Gj1/aE5X3K/Y1YEWBw/uqc3iq2iGeCuglGNkiVGDu8jcWP/HD8xnnFFgbOyb8B+JSKyK9XQDjsAAE4QKSQhX+ASeqAdY9RDdUDjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwGGpqYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DCEC4CEE2;
	Wed, 23 Apr 2025 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745429134;
	bh=m2NnblMxaxOcIaLbafnubhrGJ9wMgY5KgogBfJAbkYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwGGpqYCYLXkXrk+w0M6vXgEl7jEBisD1re1zNdENVjFaq2l1RhuvJodxebqWI7Y4
	 yowuAGFc+2DGdWxDv0yoeQm5ABOYc1pTEuNLxn4UVM+W/GEwz96sPxRSgWToTwWeMX
	 sB22xuiiVNcOlmBTPhQFmAYeQdVHbjjbYF1uAxREcOrhgc4rhUhlQVvGbLYbObwChd
	 hw6KMYZ98k4JNCeuTzaJP4esFgFUk98G+I6SuwYqTBduJPiDHY6lr9TEeN1/90Y4Nb
	 tZb1mNBa9lszMfta+uAPUlzjKmXeI61vb0LWGoc9t4YzPq42/SUrxK795Kk6vQW3+O
	 iJ6qzAFwfF14Q==
From: Nathan Chancellor <nathan@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	nathan@kernel.org,
	kees@kernel.org
Subject: [PATCH 6.14 v2] lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
Date: Wed, 23 Apr 2025 10:25:05 -0700
Message-ID: <20250423172504.1334237-2-nathan@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025042119-imbecile-greeter-0ce1@gregkh>
References: <2025042119-imbecile-greeter-0ce1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit cdc2e1d9d929d7f7009b3a5edca52388a2b0891f upstream.

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
v1 -> v2: Correct upstream ID
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

base-commit: d12acd7bc3d4ca813dc2360e6f5ca6bb1682c290
-- 
2.49.0


