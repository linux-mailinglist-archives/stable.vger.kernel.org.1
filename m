Return-Path: <stable+bounces-175005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CEFB36658
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDB15800B8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586A334723;
	Tue, 26 Aug 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qkB4jLvy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149926B747;
	Tue, 26 Aug 2025 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215889; cv=none; b=QJ5CjDI21O98EGXeaS2/5I6w0lG5TVVES+Z6IK2cyyQHtBWpkr1nAce0SvfYcDNscU/LrdD3djxUlFNygH1Uon4xNhDPuzvxc72sp+DPUuloSPZIZyGfdwaZiC9eCkkS43GZTWqQKt0iEiEBIRPFcFSlaxTnDGYllGwtfFEJZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215889; c=relaxed/simple;
	bh=LboJAlHVSuDYPmyq4CDA18KEjcoGI7gFyIqyYpurE0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kIiQYm34BCvLCSk2AjXsK2Nutr1mpCd6Xr8t5ufuHIRxFjSnxzkWv+kUmr2YRTkYSExFOajaFi+4RBf+qdQXuVpvxQYZT6pWiycPkO2En4ICHQSKh3yhGnLM3PRZHd63gD6RSLnY8ocFKrIJSipT13vmc27E94Tk3f87aoPQox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qkB4jLvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B958AC116B1;
	Tue, 26 Aug 2025 13:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756215889;
	bh=LboJAlHVSuDYPmyq4CDA18KEjcoGI7gFyIqyYpurE0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkB4jLvyyvXgn/3fQo0zHLhvFXVO3aiEEhtxW88S/zCE3MBaBT87hSOO1QutvAzBY
	 yM3yvz6XqOvBIi/dEJ6J6RxoyYEpYTijrXWL9slpjuxOqXheURuI2jNtLjdmLiG3O+
	 wkTvtsJ3PyR1LLc+SLr6kUUdzDQANJQpfFHXo4UM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 205/644] module: Restore the moduleparam prefix length check
Date: Tue, 26 Aug 2025 13:04:56 +0200
Message-ID: <20250826110951.514127132@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
index 962cd41a2cb5..061e19c94a6b 100644
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




