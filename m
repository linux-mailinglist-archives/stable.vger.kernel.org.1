Return-Path: <stable+bounces-169765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F02B2839E
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 18:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A911C23568
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 16:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CB63090CF;
	Fri, 15 Aug 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FnwTQyzI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F52308F1C
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755274213; cv=none; b=BfGKRptiq4kH2GWUBcQKMbzToXd++jsMbPMfhSZQ4e/FhBhzaQ3TWzgNDVjNbucr72X+klvhHvdWl405JeN5PcyGneI8TfyDmXleqq0uquML3DOzroFn9j30LJB8EEldY2lb2tyEapFBJuctUfsxnmrfNg6ChRnQ/93F0BfSXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755274213; c=relaxed/simple;
	bh=pwgE4Xy7dtPhbHIbOKO4n8aroOksnWffMUIZBZADTxE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vBN0hvavJ4vtd2O+dAiG5uonQ9Rv6qgB+s8Qiw6KhDAx7kI//WFd6ELfAk2IDHUo7vt9tajG65a4PuSYXGqvefmkX4u2OUlscScGzQMUtFkqAYbRy44J5KhB9dBPVE3jk+zxsAUJLHBOwTgtWmArpK7C5GrAWAqPojYt83YoVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FnwTQyzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D10EC4CEEB;
	Fri, 15 Aug 2025 16:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755274213;
	bh=pwgE4Xy7dtPhbHIbOKO4n8aroOksnWffMUIZBZADTxE=;
	h=Subject:To:Cc:From:Date:From;
	b=FnwTQyzIu+J9y9p4kGPmdk5ikfOGa1hpkDLpK7vw24TyhJVHKzJMm9MzZvV4IYM7V
	 EAYOMArZnhmc9HJ5am7tV49tQcPKyM/nRehKF6+AWxqpVcZP3iTLShPVvDa9bQj1ec
	 mh/5+O9jg/4Wr9W2mbf7VSrUJZHtHvhm0qYmqaiQ=
Subject: FAILED: patch "[PATCH] lib/crypto: arm64/poly1305: Fix register corruption in" failed to apply to 5.10-stable tree
To: ebiggers@kernel.org,ardb@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Aug 2025 18:09:58 +0200
Message-ID: <2025081558-designate-eatery-407a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x eec76ea5a7213c48529a46eed1b343e5cee3aaab
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081558-designate-eatery-407a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eec76ea5a7213c48529a46eed1b343e5cee3aaab Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@kernel.org>
Date: Sun, 6 Jul 2025 16:10:58 -0700
Subject: [PATCH] lib/crypto: arm64/poly1305: Fix register corruption in
 no-SIMD contexts

Restore the SIMD usability check that was removed by commit a59e5468a921
("crypto: arm64/poly1305 - Add block-only interface").

This safety check is cheap and is well worth eliminating a footgun.
While the Poly1305 functions should not be called when SIMD registers
are unusable, if they are anyway, they should just do the right thing
instead of corrupting random tasks' registers and/or computing incorrect
MACs.  Fixing this is also needed for poly1305_kunit to pass.

Just use may_use_simd() instead of the original crypto_simd_usable(),
since poly1305_kunit won't rely on crypto_simd_disabled_for_test.

Fixes: a59e5468a921 ("crypto: arm64/poly1305 - Add block-only interface")
Cc: stable@vger.kernel.org
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250706231100.176113-4-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>

diff --git a/lib/crypto/arm64/poly1305-glue.c b/lib/crypto/arm64/poly1305-glue.c
index c9a74766785b..31aea21ce42f 100644
--- a/lib/crypto/arm64/poly1305-glue.c
+++ b/lib/crypto/arm64/poly1305-glue.c
@@ -7,6 +7,7 @@
 
 #include <asm/hwcap.h>
 #include <asm/neon.h>
+#include <asm/simd.h>
 #include <crypto/internal/poly1305.h>
 #include <linux/cpufeature.h>
 #include <linux/jump_label.h>
@@ -33,7 +34,7 @@ void poly1305_blocks_arch(struct poly1305_block_state *state, const u8 *src,
 			  unsigned int len, u32 padbit)
 {
 	len = round_down(len, POLY1305_BLOCK_SIZE);
-	if (static_branch_likely(&have_neon)) {
+	if (static_branch_likely(&have_neon) && likely(may_use_simd())) {
 		do {
 			unsigned int todo = min_t(unsigned int, len, SZ_4K);
 


