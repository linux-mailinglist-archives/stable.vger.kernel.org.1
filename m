Return-Path: <stable+bounces-77205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B64985A24
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844C51C23808
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B831B3B01;
	Wed, 25 Sep 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eycXHC4g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51A1B3755;
	Wed, 25 Sep 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264508; cv=none; b=D8vCBqFIjrByRwjvTYj6winPh4ae21A0IjHjk04B5gjsLi5lY/o4ZgSpCYOAPZZL/HWsEY4/iL3wGiGG0XNKTnLx9khhrpGQRY7dk8OxqpmZQwyfO7SgIQbHN/bMTL09ZhTJMUDRwwvnzfCkUkeSZnGgba+7oh6d0wDywkrCzx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264508; c=relaxed/simple;
	bh=pqDl/oLKye0IY1Vk4RElG6W96LZcmJEPguI00iQo6Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/No8w46hI/Zt+zEvFQw85S9c2Engww+vE668hkQt73JDBRdsyhu/F9Bu0LfsLt92i0PDLf/qD7ShvpNuckkzYA+FOY6OvL7mrwtQ/iC65D/m3FoQAFkhuoyUMv1jbUVMeFi5hbmnUX3MP3iavlm2ZpAnz47ujRkNTwJAAIoEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eycXHC4g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086DBC4CECD;
	Wed, 25 Sep 2024 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264508;
	bh=pqDl/oLKye0IY1Vk4RElG6W96LZcmJEPguI00iQo6Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eycXHC4gQLd0BTQlyC/yr9LR4HFcXvuHIz6kWmmWDJFNRSXIw3/v3sBm9+WhDwl8Y
	 viVYoXwqPA6Rq4dRss4uVuwUhUhXYCinLWh+EmuANku+BiSM6OX3k6+rHC9ITPrRkF
	 HwJggBOxmTXkMG10PbTngqvqRf3k1VhFMOZAMRXO2t0zzgt9ZBnHzPEgqTUe17X0mY
	 4hotFdg7BM7TWRzPknf5hivVnFoij8sm8j4JNAsZGWOYM6g0Uu2nTUMJYTbEwenMHE
	 77dBhNJQfJdbR4We1VQLdywJgYodZXBb9OkLiAOrR9ZjHoLKKwguYcJBvySGLi4mGr
	 6X3xuVkKhe+AA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 107/244] tools/nolibc: powerpc: limit stack-protector workaround to GCC
Date: Wed, 25 Sep 2024 07:25:28 -0400
Message-ID: <20240925113641.1297102-107-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit 1daea158d0aae0770371f3079305a29fdb66829e ]

As mentioned in the comment, the workaround for
__attribute__((no_stack_protector)) is only necessary on GCC.
Avoid applying the workaround on clang, as clang does not recognize
__attribute__((__optimize__)) and would fail.

Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20240807-nolibc-llvm-v2-3-c20f2f5fc7c2@weissschuh.net
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/nolibc/arch-powerpc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index ac212e6185b26..41ebd394b90c7 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -172,7 +172,7 @@
 	_ret;                                                                \
 })
 
-#ifndef __powerpc64__
+#if !defined(__powerpc64__) && !defined(__clang__)
 /* FIXME: For 32-bit PowerPC, with newer gcc compilers (e.g. gcc 13.1.0),
  * "omit-frame-pointer" fails with __attribute__((no_stack_protector)) but
  * works with __attribute__((__optimize__("-fno-stack-protector")))
-- 
2.43.0


