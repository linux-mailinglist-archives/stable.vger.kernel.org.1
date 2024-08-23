Return-Path: <stable+bounces-69999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9359B95CF03
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FEF1F285C0
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699DE19884C;
	Fri, 23 Aug 2024 14:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1ol+Y/p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2011619883C;
	Fri, 23 Aug 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421813; cv=none; b=EspFMvFlc4AuP/WMdO5slqc9nynf2OO4seUPR2t4ayfvqnDyDJGcUhXaqvNSBGEGymPxk4NS0B7KUML5CjD9G60CwKZJmx8lzfwD2P548lWjYGQAIZM/RiAP8VViodjMQthGvTbJZYN9IkY9Zt1ec6ZXc3mY98wc6LKI+Wlr9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421813; c=relaxed/simple;
	bh=ntfl7zuZiLFrM9Q0L6Eab2yHkT558+2Bfn1q6TFM5Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYZktJdLRmd/g2gVK9QhMZqYvvFiFSb3QTS2hkPHHk1e3Ek1fJf0edgFW1ttIwozFcY+N/qpFIljjBqhyJ6Azx3MtlmI4VsltEHcx8DnFHdDjNad4uKx8SDyXcwHpptUFrIyEcifWrHCY6rBtwoOigCfKHl1Vr9r6gQ0Bc2K8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1ol+Y/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2599BC4AF0B;
	Fri, 23 Aug 2024 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421812;
	bh=ntfl7zuZiLFrM9Q0L6Eab2yHkT558+2Bfn1q6TFM5Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1ol+Y/ptZY2RStw6ffzBnyfA9vZ3mW7LLecjn0lWdsSGZ6uNKM/8xW3mLD0Ir60H
	 X+zxcz6ks857qKzdGjTAwscuqluw+U2zlqe99hjbkLAM8+4XuIyvM/ts1ZkTFkwRw/
	 lUQw4LdcbdZqTyuNsjgHKEz7Em0XYJ9u5Cip/AUaKZTqDLFxF1BKpWN5btqW9ubAJD
	 vpNB8MeB17xKwLRSGevsEkfTnOWIWyDbk2fRfBRDET5anEjB0Vme8kFnC5EfcUyQWY
	 2A3+J6x4HduCgnwo1wa+aM5m2shtnj40e9CdrSaxRHCMQvdHh/Jq9NvkQaT/hcDssQ
	 tfBMV9lOfsYig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zehui Xu <zehuixu@whu.edu.cn>,
	Alice Ryhl <aliceryhl@google.com>,
	Neal Gompa <neal@gompa.dev>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	rust-for-linux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/20] kbuild: rust: skip -fmin-function-alignment in bindgen flags
Date: Fri, 23 Aug 2024 10:02:22 -0400
Message-ID: <20240823140309.1974696-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140309.1974696-1-sashal@kernel.org>
References: <20240823140309.1974696-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.47
Content-Transfer-Encoding: 8bit

From: Zehui Xu <zehuixu@whu.edu.cn>

[ Upstream commit 869b5016e94eced02f2cf99bf53c69b49adcee32 ]

GCC 14 recently added -fmin-function-alignment option and the
root Makefile uses it to replace -falign-functions when available.
However, this flag can cause issues when passed to the Rust
Makefile and affect the bindgen process. Bindgen relies on
libclang to parse C code, and currently does not support the
-fmin-function-alignment flag, leading to compilation failures
when GCC 14 is used.

This patch addresses the issue by adding -fmin-function-alignment
to the bindgen_skip_c_flags in rust/Makefile. This prevents the
flag from causing compilation issues.

[ Matthew and Gary confirm function alignment should not change
  the ABI in a way that bindgen would care about, thus we did
  not need the extra logic for bindgen from v2. - Miguel ]

Link: https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pavlu@suse.com/
Signed-off-by: Zehui Xu <zehuixu@whu.edu.cn>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://lore.kernel.org/r/20240731134346.10630-1-zehuixu@whu.edu.cn
[ Reworded title. - Miguel ]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 rust/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Makefile b/rust/Makefile
index e5619f25b55ca..060ba8cfa9149 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -288,7 +288,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fno-reorder-blocks -fno-allow-store-data-races -fasan-shadow-offset=% \
 	-fzero-call-used-regs=% -fno-stack-clash-protection \
 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
-	-fstrict-flex-arrays=% \
+	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	--param=% --param asan-%
 
 # Derived from `scripts/Makefile.clang`.
-- 
2.43.0


