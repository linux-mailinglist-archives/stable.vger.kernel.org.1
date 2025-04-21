Return-Path: <stable+bounces-134808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B993A9520F
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616F07A57E1
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A604A265CB6;
	Mon, 21 Apr 2025 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tQ4E8vXE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFC27463
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243731; cv=none; b=DfQVSR30CfdYDJKmdUgr/AMMJRhzOYsweYvsdihfGak5aNCsOX9kzs27haDABe6ECbKFXlhzBiqYfEjZn9BM8JVI5Uts47+Yg9y2VyySEuBzVcJonWZBFEdZK8XMhdFXN5KJnDZuj6UL92EgFBIWnNsBlTankvqRc0hGOPbTYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243731; c=relaxed/simple;
	bh=oaOXEMkFwnVgQuioSbiEiGmVgJCCs7XHky9xIopd6OI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZOz8wTPixIBzyqSF0UKew70OiHbfT3qpnDXDMDzk/kG7G1qPdDZmEyUeHaNPqLFC5xtK4pAC3pSbrIJdtJ1FDcGYYhNliqVFia3HmU48SxsSx6SRWfXSBxvgiPuf2IFs95RUBvY1rT7ikN0D6Y0qHeaPa5Lq+cbSiAfjCYhU5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tQ4E8vXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB43C4CEE4;
	Mon, 21 Apr 2025 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243730;
	bh=oaOXEMkFwnVgQuioSbiEiGmVgJCCs7XHky9xIopd6OI=;
	h=Subject:To:Cc:From:Date:From;
	b=tQ4E8vXEovrEYzLdssPvbd3qXQE2us6CKfmITzU/tR9FBXsASwPT4w4fpu8mfdrpW
	 U4A7+RbXDGBUm7XfoaV444PEgTsl4TtHURMMSOE4COu87Zf5FGp2kkpsY9bMulGSUq
	 gyAuAECWVZU9bvue3l8pGJA0d0A++gJM8Rg0GyO8=
Subject: FAILED: patch "[PATCH] lib/Kconfig.ubsan: Remove 'default UBSAN' from" failed to apply to 6.12-stable tree
To: nathan@kernel.org,kees@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:55:20 +0200
Message-ID: <2025042120-backward-waged-41cf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cdc2e1d9d929d7f7009b3a5edca52388a2b0891f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042120-backward-waged-41cf@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cdc2e1d9d929d7f7009b3a5edca52388a2b0891f Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 14 Apr 2025 15:00:59 -0700
Subject: [PATCH] lib/Kconfig.ubsan: Remove 'default UBSAN' from
 UBSAN_INTEGER_WRAP

CONFIG_UBSAN_INTEGER_WRAP is 'default UBSAN', which is problematic for a
couple of reasons.

The first is that this sanitizer is under active development on the
compiler side to come up with a solution that is maintainable on the
compiler side and usable on the kernel side. As a result of this, there
are many warnings when the sanitizer is enabled that have no clear path
to resolution yet but users may see them and report them in the meantime.

The second is that this option was renamed from
CONFIG_UBSAN_SIGNED_WRAP, meaning that if a configuration has
CONFIG_UBSAN=y but CONFIG_UBSAN_SIGNED_WRAP=n and it is upgraded via
olddefconfig (common in non-interactive scenarios such as CI),
CONFIG_UBSAN_INTEGER_WRAP will be silently enabled again.

Remove 'default UBSAN' from CONFIG_UBSAN_INTEGER_WRAP until it is ready
for regular usage and testing from a broader community than the folks
actively working on the feature.

Cc: stable@vger.kernel.org
Fixes: 557f8c582a9b ("ubsan: Reintroduce signed overflow sanitizer")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20250414-drop-default-ubsan-integer-wrap-v1-1-392522551d6b@kernel.org
Signed-off-by: Kees Cook <kees@kernel.org>

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 4216b3a4ff21..f6ea0c5b5da3 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -118,7 +118,6 @@ config UBSAN_UNREACHABLE
 
 config UBSAN_INTEGER_WRAP
 	bool "Perform checking for integer arithmetic wrap-around"
-	default UBSAN
 	depends on !COMPILE_TEST
 	depends on $(cc-option,-fsanitize-undefined-ignore-overflow-pattern=all)
 	depends on $(cc-option,-fsanitize=signed-integer-overflow)


