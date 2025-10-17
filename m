Return-Path: <stable+bounces-187684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C25CBEB148
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4DF1AA5E76
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF3230649A;
	Fri, 17 Oct 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsq7R4KM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAECD1C6A3;
	Fri, 17 Oct 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722437; cv=none; b=JdvASWvf6yZM6ZcAJ+UvDRSJ9YdeIbhaGpsUSorIK/1+u146UXLzqdI1sa+HhLY3WqggIiOHnn3Isi7jekXlYKRxtJZWFNmIso1lmphL1JU1wBrbmZuGy0ySVGbW7hZYZcv3Wp2NUESQuTo+m9g5LhOdUARjpld8ddasv5PsTT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722437; c=relaxed/simple;
	bh=yT/exZAwSgNTWXWPg6lAIP7rb6scxbRZ8v/wejJx7Sw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MrLSCY3myynzLZwXqMhqtKZeC8ty3yDFIcq7sJKXt9AergPsPafigu7A5wtjg5notHo5nZNRl+3GbO6lLhVz5hX+NUKKpBEGFMU/KpEsK/zB8lAjE2hY8kZhXuk+BbXR0tRGv0iPHdWGCfWSE0Aa8H0DYtbFZ9M6BPjuS8TF75Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsq7R4KM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB3BC113D0;
	Fri, 17 Oct 2025 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760722437;
	bh=yT/exZAwSgNTWXWPg6lAIP7rb6scxbRZ8v/wejJx7Sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lsq7R4KMdh0Dqu158vl43PhsQHA6w6GvulZ2S43Nn5t9EyI8vFLL3yJ2XGHN5FyLd
	 nfh08F3kkggjI0LGN2bcuWKAjvEOuaAHQ020Ka/9XPWcDrO+usX7qMMobvNRU6eJQr
	 mLsqOSvFaLkOZQ01s+avGeGWou5xiJxkBxauRlFHCMvw8joVWLT3C2ci2XiL/TP9vD
	 NUlivpPSa+L6KkAKAuRoqholIbv2I55/MYv4xailR78ag8XQkwKAqRGa76Gk9/SD/O
	 /pTC4q5K44dFDo89wHzM3BFhN6/iEQjiq+PJ5XlWXKlVPsg7gGQLirYaTGDW4SHcQC
	 bJAWzkUS2HQLQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 17 Oct 2025 19:33:39 +0200
Subject: [PATCH 5.4.y 2/5] efi: libstub: Use '-std=gnu11' to fix build with
 GCC 15
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251017-v5-4-gcc-15-v1-2-6d6367ee50a1@kernel.org>
References: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
In-Reply-To: <20251017-v5-4-gcc-15-v1-0-6d6367ee50a1@kernel.org>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Kostadin Shishmanov <kostadinshishmanov@protonmail.com>, 
 Jakub Jelinek <jakub@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ELW/Y8j9ZMNwC5DLPH9KGkFyK2XO4/+Obnzq5n+sFLQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDI+1f4UucbFl/RO/23wwoTiVRfzdjJXTQ4N33Dmf39lz
 mIvnRLRjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlkTmL47/csZfrsAP3Hys8m
 eXdr6JxcEJFyzlvAwMhP/wtbf27nFEaGtslaYg3GUYZhCYk73yxUMJymZB3Df953zinmtRFbVWZ
 yAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Nathan Chancellor <nathan@kernel.org>

commit 8ba14d9f490aef9fd535c04e9e62e1169eb7a055 upstream.

GCC 15 changed the default C standard version to C23, which should not
have impacted the kernel because it requests the gnu11 standard via
'-std=' in the main Makefile. However, the EFI libstub Makefile uses its
own set of KBUILD_CFLAGS for x86 without a '-std=' value (i.e., using
the default), resulting in errors from the kernel's definitions of bool,
true, and false in stddef.h, which are reserved keywords under C23.

  ./include/linux/stddef.h:11:9: error: expected identifier before ‘false’
     11 |         false   = 0,
  ./include/linux/types.h:35:33: error: two or more data types in declaration specifiers
     35 | typedef _Bool                   bool;

Set '-std=gnu11' in the x86 cflags to resolve the error and consistently
use the same C standard version for the entire kernel. All other
architectures reuse KBUILD_CFLAGS from the rest of the kernel, so this
issue is not visible for them.

Cc: stable@vger.kernel.org
Reported-by: Kostadin Shishmanov <kostadinshishmanov@protonmail.com>
Closes: https://lore.kernel.org/4OAhbllK7x4QJGpZjkYjtBYNLd_2whHx9oFiuZcGwtVR4hIzvduultkgfAIRZI3vQpZylu7Gl929HaYFRGeMEalWCpeMzCIIhLxxRhq4U-Y=@protonmail.com/
Reported-by: Jakub Jelinek <jakub@redhat.com>
Closes: https://lore.kernel.org/Z4467umXR2PZ0M1H@tucnak/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
[ Conflict in the context, because commit bbf8e8b0fe04 ("efi/libstub:
  Optimize for size instead of speed") is not in this version.
  '-std=gnu11' can still be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 8c5b5529dbc0..0dc80564bbd2 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -7,7 +7,7 @@
 #
 cflags-$(CONFIG_X86_32)		:= -march=i386
 cflags-$(CONFIG_X86_64)		:= -mcmodel=small
-cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 \
+cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ -O2 -std=gnu11 \
 				   -fPIC -fno-strict-aliasing -mno-red-zone \
 				   -mno-mmx -mno-sse -fshort-wchar \
 				   -Wno-pointer-sign \

-- 
2.51.0


