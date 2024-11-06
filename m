Return-Path: <stable+bounces-90864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4809BEB62
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC570284764
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D51EABA1;
	Wed,  6 Nov 2024 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EHcfxiGy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819191E7C1A;
	Wed,  6 Nov 2024 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897041; cv=none; b=Wy05tRa93DxusTdF3+TS/d/pOVC4fUlsfk+mxVSUfjnz7dDV1rkCZzoH2awz6EWNQTDPtOkYWzyvqiLMQ2BCFz3r+4pr4b2oDPxzwCKvxOACxCc+RYNQ66dzA67C0H0yrRRIsY1L+/KE8EimJt/7FV1x+uyLsp6+rCoK5iCVKis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897041; c=relaxed/simple;
	bh=ZCLbWahdkw8VpA/eM9lWqK6wQGnwIAJZCeox8yC2Ync=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvBjXRdfukxdH8B10orVTi20e0KTmYnC4pbMTpOi0Xy5oE3A3Hhx4DB/JbKGVaY8jT/AC9moLenFucBXp0kLOKoAtcX+d0e4lWG3YwcXXXxY22q4ooHWz2JLLsWmAMUfqRZxbJcjKJRYuadSJnw8STp6nIwxulzvZV/VRkm2D18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EHcfxiGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F02C4CECD;
	Wed,  6 Nov 2024 12:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897041;
	bh=ZCLbWahdkw8VpA/eM9lWqK6wQGnwIAJZCeox8yC2Ync=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EHcfxiGyuq7C3FYcMSQS6RuHKtaBeEJutCfItYVJ+ySbk1H22cyEZbXrAb+bYZIX5
	 4D7Ni/NPNjVmeKLrf3Y9K/8/v774BisAxU5vMvyPuXEZ9k2TSvqvizM0R4eRIoYRty
	 zDrx1VcoysehBDQAlssLgL5w3jPMQ4pWSMmZy9DI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+908886656a02769af987@syzkaller.appspotmail.com,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrew Pinski <pinskia@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Marco Elver <elver@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 047/126] kasan: Fix Software Tag-Based KASAN with GCC
Date: Wed,  6 Nov 2024 13:04:08 +0100
Message-ID: <20241106120307.376227428@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120306.038154857@linuxfoundation.org>
References: <20241106120306.038154857@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Marco Elver <elver@google.com>

[ Upstream commit 894b00a3350c560990638bdf89bdf1f3d5491950 ]

Per [1], -fsanitize=kernel-hwaddress with GCC currently does not disable
instrumentation in functions with __attribute__((no_sanitize_address)).

However, __attribute__((no_sanitize("hwaddress"))) does correctly
disable instrumentation. Use it instead.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117196 [1]
Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218854
Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
Tested-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Pinski <pinskia@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Fixes: 7b861a53e46b ("kasan: Bump required compiler version")
Link: https://lore.kernel.org/r/20241021120013.3209481-1-elver@google.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index b6050483ba421..74dc72b2c3a74 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -102,7 +102,11 @@
 #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
 
+#ifdef __SANITIZE_HWADDRESS__
+#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddress")))
+#else
 #define __no_sanitize_address __attribute__((__no_sanitize_address__))
+#endif
 
 #if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
 #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
-- 
2.43.0




