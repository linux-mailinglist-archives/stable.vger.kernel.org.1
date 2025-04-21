Return-Path: <stable+bounces-134807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40028A9520E
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 15:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C2E18844C0
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C16266588;
	Mon, 21 Apr 2025 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0xMDMsqf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5127463
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243722; cv=none; b=pj+G/UlVGar0Rg2RNq7S7DWX8sSCxLirkszEVipzpkZ1foSogFQwjvgsMTJLk/JkaKsCJ1DZqX8lkNsYGwnwWwxULrgDzGGh4JRJDds4zAzhLf6Iflcad9e1pCHjFA8fLhg7P+UYysK4qKZ6V1sutbi5VMpZsUnQJJJJOCSYUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243722; c=relaxed/simple;
	bh=VQz7qN/iObWL8+jRQO05QjhyCq3KQ+0qDopEVBnLM00=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Jhnv2ChFDmkDvhSkN/8ipqoJ8JCp/WDBFoiltwBp/pmO8zLRdZ54HNSP4ZZfcMN6FfnN2lNzuT/FfjrQWjm/7EssCu9dYI01H62oCjtyCYTuEAStDyioq4XCFgy37ZoiHLNoVv2bkluh/e0l+FEMfoEN5B7pASWAKR3T1B+gZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0xMDMsqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB90C4CEE4;
	Mon, 21 Apr 2025 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745243722;
	bh=VQz7qN/iObWL8+jRQO05QjhyCq3KQ+0qDopEVBnLM00=;
	h=Subject:To:Cc:From:Date:From;
	b=0xMDMsqfqEqmUZKKXFCuGIgOGNqdyK6B1EPyIF3jNjvlk8UhPBgnJn0d84yM8CQMr
	 Z4TPtTevWWBZZT+4PK5doB+Rb+NEz8rMvgArV/ZLSbxcoe2cu8rchxwIZXhg+XFcl/
	 NO3rCjQ7UEoZFqOHN1dmPE6KblwY/LkGeNuBCxVw=
Subject: FAILED: patch "[PATCH] lib/Kconfig.ubsan: Remove 'default UBSAN' from" failed to apply to 6.14-stable tree
To: nathan@kernel.org,kees@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Apr 2025 15:55:19 +0200
Message-ID: <2025042119-imbecile-greeter-0ce1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.14.y
git checkout FETCH_HEAD
git cherry-pick -x cdc2e1d9d929d7f7009b3a5edca52388a2b0891f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025042119-imbecile-greeter-0ce1@gregkh' --subject-prefix 'PATCH 6.14.y' HEAD^..

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


