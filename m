Return-Path: <stable+bounces-35363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5C689439A
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE9028370C
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB50482CA;
	Mon,  1 Apr 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qR4b7Hnl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB11DFF4;
	Mon,  1 Apr 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991152; cv=none; b=sdOuFliKbx44BVxsnvwGWw/sJgkE0hYr1ZjXRGcnRajs2cRPS5pQimIs7dGX3UkKO1XkLLwnIobBwowaX7QW8L1qGQAIcU6LnQwZ9obKXToA3/I01CC3uZdvqRflzjoqXA7VkeIp7Lc8BfuTD5Zt1NYouH1t6TrXt+5l1d/38AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991152; c=relaxed/simple;
	bh=+oJLAjKb9soYZZX/prvsCFXe3LHAYFmeHwqRJSX/NwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9q1Td13aCnVfhP9OaA6jDz7ywqlUZKNMEeAr6hgbTYbTdNw4TPzEfEW1YDufK/XHzHECfhYkxyYdMIWOrrfsGnNtPhavJIpzJWEfz52x0EnX+E7n8FK9WxSyiajOZafn7iZy4nGI2e+PbaLOw0bS44ilpsIFdK/LwogJeV+5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qR4b7Hnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B555C433C7;
	Mon,  1 Apr 2024 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711991152;
	bh=+oJLAjKb9soYZZX/prvsCFXe3LHAYFmeHwqRJSX/NwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qR4b7HnlxQ5lEzlPP5xyf7rVufqVcKe7IpGfFujALdkN/M0S7ybRFgiTzPH5Trcxh
	 6xodswoTjpgtHBvKLyY03gELHS1AA5rXUhtgyWXzFWonQs3ccYloBeRbOLkRb7go61
	 dALGRMN7OZt9oigQ0NYUQv3HKdHHUvMVWmbkNZZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lu Yao <yaolu@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Marc=20Aur=C3=A8le=20La=20France?= <tsi@tuyoix.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 150/272] init/Kconfig: lower GCC version check for -Warray-bounds
Date: Mon,  1 Apr 2024 17:45:40 +0200
Message-ID: <20240401152535.387716413@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 3e00f5802fabf2f504070a591b14b648523ede13 upstream.

We continue to see false positives from -Warray-bounds even in GCC 10,
which is getting reported in a few places[1] still:

security/security.c:811:2: warning: `memcpy' offset 32 is out of the bounds [0, 0] [-Warray-bounds]

Lower the GCC version check from 11 to 10.

Link: https://lkml.kernel.org/r/20240223170824.work.768-kees@kernel.org
Reported-by: Lu Yao <yaolu@kylinos.cn>
Closes: https://lore.kernel.org/lkml/20240117014541.8887-1-yaolu@kylinos.cn/
Link: https://lore.kernel.org/linux-next/65d84438.620a0220.7d171.81a7@mx.google.com [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Paul Moore <paul@paul-moore.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Marc Aurèle La France <tsi@tuyoix.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 init/Kconfig |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -902,14 +902,14 @@ config CC_IMPLICIT_FALLTHROUGH
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
 	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
 
-# Currently, disable gcc-11+ array-bounds globally.
+# Currently, disable gcc-10+ array-bounds globally.
 # It's still broken in gcc-13, so no upper bound yet.
-config GCC11_NO_ARRAY_BOUNDS
+config GCC10_NO_ARRAY_BOUNDS
 	def_bool y
 
 config CC_NO_ARRAY_BOUNDS
 	bool
-	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC11_NO_ARRAY_BOUNDS
+	default y if CC_IS_GCC && GCC_VERSION >= 100000 && GCC10_NO_ARRAY_BOUNDS
 
 #
 # For architectures that know their GCC __int128 support is sound



