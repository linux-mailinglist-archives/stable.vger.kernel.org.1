Return-Path: <stable+bounces-77617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17656985F67
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D035B2AA62
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2B6188901;
	Wed, 25 Sep 2024 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcXwrzXD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB18D21F430;
	Wed, 25 Sep 2024 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266491; cv=none; b=DLyikP0jTdJhW68KTQzaurqJNmTfYtL9ZzSYkaz8kSf1jx4Ta/c4WIoiVLHVwYI3gOLFGrItR1CWCa8ObDXZn+hzH0Dska9r8MCwrtRBBFDFoNxF95Bjq2dfxfo14Lfrj5KufhqqZ7UVsWDbj8mJf1wmRzmYkRn3RHSQ3FZ6WNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266491; c=relaxed/simple;
	bh=pqDl/oLKye0IY1Vk4RElG6W96LZcmJEPguI00iQo6Zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJIKqAZ/g1GY7Q029sxA3W0uH0ZQhQ3xwWFvVtQe0tJFDcJWZWTU8X2y+uAG//yIPvhcsadPGEwY78gBqLiOAiqxptOv8c7lCe0J32wdJce++76V0EaDUnpLJATyb3LrVeIoqGlmrxPvoGIoBFVBab0UYY86gFOw/AetnIaxv24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcXwrzXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F7AC4CEC7;
	Wed, 25 Sep 2024 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266490;
	bh=pqDl/oLKye0IY1Vk4RElG6W96LZcmJEPguI00iQo6Zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rcXwrzXD0b9xMlDmXf7HFDTCEwM3L9awLcq+4JnfJEM9mifA3XNtJ0mJWdxGv5N3J
	 qWarl9tGRmReK/F1VsTtpy8W0o5SkqqCpgFbbr250jXbmz2m5kEgvlasS2TJGGvwWc
	 oHe40Y37TdYmWOYVJI6OrxIA+uSWSqcJFB2lz6gkkGXdHKdetZN8g+eg5jacKqj/s5
	 mDAfHMRpSdDo1SbW6BTkFho5F6gvp5C51AhFQ8lyy2wu+VZIG/cy5WpXM6621tUpTP
	 igxGh1hh1o5yewEg1Y4ZHOEFwV/NTk2Sk1NVd5TVfjj8DrD1viI2tNLNgULydeDG1w
	 ijmeyqll0BMnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Willy Tarreau <w@1wt.eu>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 070/139] tools/nolibc: powerpc: limit stack-protector workaround to GCC
Date: Wed, 25 Sep 2024 08:08:10 -0400
Message-ID: <20240925121137.1307574-70-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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


