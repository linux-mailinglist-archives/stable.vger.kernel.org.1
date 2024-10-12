Return-Path: <stable+bounces-83538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9A99B3B6
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 13:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D5971F2469C
	for <lists+stable@lfdr.de>; Sat, 12 Oct 2024 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C11AAE22;
	Sat, 12 Oct 2024 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfA6+TS6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F171AAE19;
	Sat, 12 Oct 2024 11:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732456; cv=none; b=Xy5v1u24k20C4z4Jc1Dp+pBsfFsmT24p+FAgsH5soBiMFjRX972Lglea9XsGl9KAURiuibX05Nr+4a6YwPhAzLbdw4Nzc2mynZswbdcKScqNXoo5kLLuVznyGtRHFolxnQks1cYuT2LUkBB4kDT4tFYpgIpGPtsQLVHPQNjQr6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732456; c=relaxed/simple;
	bh=ntfl7zuZiLFrM9Q0L6Eab2yHkT558+2Bfn1q6TFM5Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhaAevhcJoFdewpw71a0yZJQd4X8H9lojUXPi/ZJmqbmHb21gklNCNQ7O9cEloLvBWnb4T0tYq7gKRB3peCFtW5EbJIptHrTH7vDBWo2nFWqhM4XsAjmqW9fYcK+AzvZthTunoYz/XJCoK+3Z7CTBn6T/xTJOzm4cH2IoNYTuPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfA6+TS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A0FDC4CEC7;
	Sat, 12 Oct 2024 11:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732455;
	bh=ntfl7zuZiLFrM9Q0L6Eab2yHkT558+2Bfn1q6TFM5Kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfA6+TS64XMl1KJGDJPZUMYGRFtq3e/c02tVTmGNMNmvGaHplrP8AmoZIxS9cZLVm
	 0T2xhMP561zxs1seMApIJFcTugxRYMM7XrKbF0FjtfTMPY4ZN+uKhDVEg+bt36Pxul
	 OEtCrtplNiL1708AX0ya3jvpb9GoFBfdxmlqbsI0Y5HpH+GyYs4TLcND7IYX2ahEaU
	 /OBUO6g1nhGxJqbXdBhEwoNudRoSOvt54Q66ctSgCxq1Y23Tb15M9+BodYFpgLxQpk
	 CUn3doefqw3VLh080WHm+703mtYPFF/BuyM2UHLQQhLJlC/jrW4oRXiw5ZghV7igGu
	 OgMVkTkWcc0kA==
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
	rust-for-linux@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/20] kbuild: rust: skip -fmin-function-alignment in bindgen flags
Date: Sat, 12 Oct 2024 07:26:40 -0400
Message-ID: <20241012112715.1763241-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241012112715.1763241-1-sashal@kernel.org>
References: <20241012112715.1763241-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.56
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


