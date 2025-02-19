Return-Path: <stable+bounces-117348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F16EBA3B640
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3032E3BAAB5
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6881DE8BC;
	Wed, 19 Feb 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pEi6mbT2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762311DE8B7;
	Wed, 19 Feb 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954998; cv=none; b=KNrBuDKV3MeK4Je6Jpoxl93l48jAMfa1NPHxy3Y9rMYTsdlUhbPuCPx9GbTdpyyXhX6gQQB/UZRTgd93lfuGa0w3SpGM5N6H9JJtdgdgfOtQGmbDr4L/fWpNPjdZ898uNNKh6Vg22bWkdclHAR5cS20l/n683oJLOLH263goJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954998; c=relaxed/simple;
	bh=PKNpCxKiZsqXll6CJBJNR6a44xVom/Vj4nCX/F9IvME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDoX/qHmz6TVdJyOCjNQD0JrbBR5cEzJHGkraQDLab5nOBvfUkQVJ7m+Lr2zVguuxV3aPyM+qyC8evIHD3C934zenZwGDq2YY6vEsvf2iouuYnM0albucOZ0lkWj/bhy7t0sbekES4RCetcbaYeTCV17TqL0hi/oHy95kVHF26Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pEi6mbT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7940C4CED1;
	Wed, 19 Feb 2025 08:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739954998;
	bh=PKNpCxKiZsqXll6CJBJNR6a44xVom/Vj4nCX/F9IvME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pEi6mbT2yerYDcZGGpDVZtqr4kAly9g4e8e1OXyUnrQX5UdZvpKHuHiG76kioMEcI
	 G3UJ6WE9XocneIRwknHwBVWoqiJ7POkrQpl4gDH+xmUOqfQi87R+MSPQbBcQ3HYyDc
	 H56n8HI1DBEIXRjQmnEiPthG/0B5/WX3Vv4NkgnQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Jelinek <jakub@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 093/230] kbuild: Use -fzero-init-padding-bits=all
Date: Wed, 19 Feb 2025 09:26:50 +0100
Message-ID: <20250219082605.336276053@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
References: <20250219082601.683263930@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <kees@kernel.org>

[ Upstream commit dce4aab8441d285b9a78b33753e0bf583c1320ee ]

GCC 15 introduces a regression in "= { 0 }" style initialization of
unions that Linux has depended on for eliminating uninitialized variable
contents. GCC does not seem likely to fix it[1], instead suggesting[2]
that affected projects start using -fzero-init-padding-bits=unions.

To avoid future surprises beyond just the current situation with unions,
enable -fzero-init-padding-bits=all when available (GCC 15+). This will
correctly zero padding bits in unions and structs that might have been
left uninitialized, and will make sure there is no immediate regression
in union initializations. As seen in the stackinit KUnit selftest union
cases, which were passing before, were failing under GCC 15:

    not ok 18 test_small_start_old_zero
    ok 29 test_small_start_dynamic_partial # SKIP XFAIL uninit bytes: 63
    ok 32 test_small_start_assigned_dynamic_partial # SKIP XFAIL uninit bytes: 63
    ok 67 test_small_start_static_partial # SKIP XFAIL uninit bytes: 63
    ok 70 test_small_start_static_all # SKIP XFAIL uninit bytes: 56
    ok 73 test_small_start_dynamic_all # SKIP XFAIL uninit bytes: 56
    ok 82 test_small_start_assigned_static_partial # SKIP XFAIL uninit bytes: 63
    ok 85 test_small_start_assigned_static_all # SKIP XFAIL uninit bytes: 56
    ok 88 test_small_start_assigned_dynamic_all # SKIP XFAIL uninit bytes: 56

The above all now pass again with -fzero-init-padding-bits=all added.

This also fixes the following cases for struct initialization that had
been XFAIL until now because there was no compiler support beyond the
larger "-ftrivial-auto-var-init=zero" option:

    ok 38 test_small_hole_static_all # SKIP XFAIL uninit bytes: 3
    ok 39 test_big_hole_static_all # SKIP XFAIL uninit bytes: 124
    ok 40 test_trailing_hole_static_all # SKIP XFAIL uninit bytes: 7
    ok 42 test_small_hole_dynamic_all # SKIP XFAIL uninit bytes: 3
    ok 43 test_big_hole_dynamic_all # SKIP XFAIL uninit bytes: 124
    ok 44 test_trailing_hole_dynamic_all # SKIP XFAIL uninit bytes: 7
    ok 58 test_small_hole_assigned_static_all # SKIP XFAIL uninit bytes: 3
    ok 59 test_big_hole_assigned_static_all # SKIP XFAIL uninit bytes: 124
    ok 60 test_trailing_hole_assigned_static_all # SKIP XFAIL uninit bytes: 7
    ok 62 test_small_hole_assigned_dynamic_all # SKIP XFAIL uninit bytes: 3
    ok 63 test_big_hole_assigned_dynamic_all # SKIP XFAIL uninit bytes: 124
    ok 64 test_trailing_hole_assigned_dynamic_all # SKIP XFAIL uninit bytes: 7

All of the above now pass when built under GCC 15. Tests can be seen
with:

    ./tools/testing/kunit/kunit.py run stackinit --arch=x86_64 \
        --make_option CC=gcc-15

Clang continues to fully initialize these kinds of variables[3] without
additional flags.

Suggested-by: Jakub Jelinek <jakub@redhat.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=118403 [1]
Link: https://lore.kernel.org/linux-toolchains/Z0hRrrNU3Q+ro2T7@tucnak/ [2]
Link: https://github.com/llvm/llvm-project/commit/7a086e1b2dc05f54afae3591614feede727601fa [3]
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Acked-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/r/20250127191031.245214-3-kees@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Makefile.extrawarn | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index d75897559d184..dc081cf46d211 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -82,6 +82,9 @@ KBUILD_CFLAGS += $(call cc-option,-Werror=designated-init)
 # Warn if there is an enum types mismatch
 KBUILD_CFLAGS += $(call cc-option,-Wenum-conversion)
 
+# Explicitly clear padding bits during variable initialization
+KBUILD_CFLAGS += $(call cc-option,-fzero-init-padding-bits=all)
+
 KBUILD_CFLAGS += -Wextra
 KBUILD_CFLAGS += -Wunused
 
-- 
2.39.5




