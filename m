Return-Path: <stable+bounces-168008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16294B232F5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DC5188BCD7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF232E3B06;
	Tue, 12 Aug 2025 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJjB1nty"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13CE2DBF5E;
	Tue, 12 Aug 2025 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022732; cv=none; b=QY4K/GmnfNC33Jre9nwYXiv782GlhDhTsrKUXWtV4S06w7VXjpxjSi1xz4QdXhyL01/ZsU/Uk2FksX/eB24nVvA9VSKY3BXYA+3cBx01tfWbVGiq1BsBEchxYAEg6HaNu/Ck8jFwq9MtSxLlwsxbbbmi4vFx+iAI7D+auxI6Kls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022732; c=relaxed/simple;
	bh=KGNlEyd35qKlpApF8/L+Ab7lopzokvRJ0x/yDA+4xAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRP8+L9J3U+oOo5jseENM3A9AdfSgfANE7Sc3opB0NOfu2ww278hWSdkqfLA3jzqndRlz/vGzdwzAGJpL0q74Hj3qRU4MxwkK7W/yRfM7iu4UnKeoNkts8cpSOzqyKuulzHFzGziOEspmQxvkrRVqIg9qDZa4pxEmlfqVy/NJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJjB1nty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E7BC4CEF1;
	Tue, 12 Aug 2025 18:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022732;
	bh=KGNlEyd35qKlpApF8/L+Ab7lopzokvRJ0x/yDA+4xAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJjB1nty8FysBlc9ujpPXjZsdj9fUdSCvGDFi6msP3KrU/MYHs2HOFbvZcBQGX6WI
	 Q7GjNtyaBzhMTU2QXzJ7nYzRMqkJAA/VT02M1NWYfeiAGqNvGEtjOx81K0URRi0IZR
	 UKVJgXQW8F5RA07I4s74MYw9+3P4pUb5KKXyXO9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 241/369] module: Restore the moduleparam prefix length check
Date: Tue, 12 Aug 2025 19:28:58 +0200
Message-ID: <20250812173023.838019995@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

From: Petr Pavlu <petr.pavlu@suse.com>

[ Upstream commit bdc877ba6b7ff1b6d2ebeff11e63da4a50a54854 ]

The moduleparam code allows modules to provide their own definition of
MODULE_PARAM_PREFIX, instead of using the default KBUILD_MODNAME ".".

Commit 730b69d22525 ("module: check kernel param length at compile time,
not runtime") added a check to ensure the prefix doesn't exceed
MODULE_NAME_LEN, as this is what param_sysfs_builtin() expects.

Later, commit 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking
for sysfs perms.") removed this check, but there is no indication this was
intentional.

Since the check is still useful for param_sysfs_builtin() to function
properly, reintroduce it in __module_param_call(), but in a modernized form
using static_assert().

While here, clean up the __module_param_call() comments. In particular,
remove the comment "Default value instead of permissions?", which comes
from commit 9774a1f54f17 ("[PATCH] Compile-time check re world-writeable
module params"). This comment was related to the test variable
__param_perm_check_##name, which was removed in the previously mentioned
commit 58f86cc89c33.

Fixes: 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking for sysfs perms.")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
Link: https://lore.kernel.org/r/20250630143535.267745-4-petr.pavlu@suse.com
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/moduleparam.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..110e9d09de24 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -282,10 +282,9 @@ struct kparam_array
 #define __moduleparam_const const
 #endif
 
-/* This is the fundamental function for registering boot/module
-   parameters. */
+/* This is the fundamental function for registering boot/module parameters. */
 #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
-	/* Default value instead of permissions? */			\
+	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used __section("__param")					\
-- 
2.39.5




