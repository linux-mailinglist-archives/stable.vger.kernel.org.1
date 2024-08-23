Return-Path: <stable+bounces-69976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0050995CEB8
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337F71C238CE
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6999618BBBE;
	Fri, 23 Aug 2024 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8ZG/fW8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C2F18BBB3;
	Fri, 23 Aug 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421714; cv=none; b=a98jneVS/cCHhz18yWJBcNdI7pZ2a09uWLiEXQ5aEUnz/xJ5AU237Q0TrM9AAPHInNJZ5yTUTpgFjr06C/QMtWUcaDTdExz1bNyjfHuznZPLbQSOg9oQdjjXS8TZnQAO2+/qp7R73YkV/ZsWKDijODTf2rAGQHs3dqQ2pp7/x/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421714; c=relaxed/simple;
	bh=HpzWuszcJLuggQ8rgfy/cDUP/7cyd8c8AaQHEj9LYAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1zfGtCgjy/34A+kUhpHt5fsslDCGWiTPVroPVUQced8wWtQ6GemoQ2r1Apy5z5WO1lUyga8h7JZeAE9kUWHS3Y2TQFbo/lWcM6HMjNuG6a/aTHweI4Lckaj79YitjJD/omr9ExklYxY5+vhQuhd8YXrDu7PsSZoEjSU6+6bHmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8ZG/fW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79443C32786;
	Fri, 23 Aug 2024 14:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421713;
	bh=HpzWuszcJLuggQ8rgfy/cDUP/7cyd8c8AaQHEj9LYAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8ZG/fW8JPk1NfgPg3qy4oZYOqNSzSQyeYKUeTz9u7mF5vpW4feAI6hMeEjKStOK1
	 vSMqP1iYA4t5AalvvQeE/fYtVZ080T4GD46ZKtAGcsLYlhYJaTw73MDCOyob8YeUSY
	 X6jM031aXwFP84WZeOhYi3Zfwe3mKECWqzPuPy9v/YcZ9VMVJqJUPjRIQlCr6PI8po
	 T5jWXxAm4sBaF0pRX6Bi8GZrLZ2LokyuKlOKRIit8vaWfRH4oHjgbUYGZSJmhmJbvJ
	 1v6uHPBpPD0YcuNjYGa7WsphpLEWGzMZh6TrMVbqSuw7/zzJzh40ilKxDvl+0lFuVA
	 xUk3cnwzLPCSQ==
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
Subject: [PATCH AUTOSEL 6.10 09/24] kbuild: rust: skip -fmin-function-alignment in bindgen flags
Date: Fri, 23 Aug 2024 10:00:31 -0400
Message-ID: <20240823140121.1974012-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140121.1974012-1-sashal@kernel.org>
References: <20240823140121.1974012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.6
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
index f70d5e244fee5..5a41ace9fea10 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -281,7 +281,7 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fno-reorder-blocks -fno-allow-store-data-races -fasan-shadow-offset=% \
 	-fzero-call-used-regs=% -fno-stack-clash-protection \
 	-fno-inline-functions-called-once -fsanitize=bounds-strict \
-	-fstrict-flex-arrays=% \
+	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	--param=% --param asan-%
 
 # Derived from `scripts/Makefile.clang`.
-- 
2.43.0


