Return-Path: <stable+bounces-154874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13697AE1301
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE8318998C1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D97B1EFF92;
	Fri, 20 Jun 2025 05:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fhUZGawd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3141DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397863; cv=none; b=Br2aiEXq9ONfeWqlz8MsC0sseseKJIjsqr6OIbGMIEJZZc66tCrarV0gTPn9rRmDSnRZ35Gk1oDH0rWIOriRCvM5FuPKsFNAIdnq/gtMI9vH5tje1ENkF8FG2Iz2zi+EF2lykQFt2Oec8spjRpx6Spg0Ov5hB35BKdh7quxSdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397863; c=relaxed/simple;
	bh=wrA2XH+ueYjhLMBy23DptWrmqKDp1yDifkEqB8oYTzo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oebbV5xk3ZSRyEocO00lK3HDJ9ZHZPUHrI5p9qaqRQfctrcu3B6nNOqp5lWXHfWsLHqG3ic9+mUKY9/sc0/yVG7oCCZoU6RhITI24Lcb6GtrJz7pQozz0ISAGqU6Sig9K1jkOwOTQiiu3tuagCV7zOEHEQrHp57PL7M6K++lsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fhUZGawd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABADC4CEED;
	Fri, 20 Jun 2025 05:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750397863;
	bh=wrA2XH+ueYjhLMBy23DptWrmqKDp1yDifkEqB8oYTzo=;
	h=Subject:To:Cc:From:Date:From;
	b=fhUZGawdB5YYIDOKHYZkQqiBiOh909BhsNnF7i7YZ16NfGai0rkPjNcq1PCTiNyde
	 fylNc2uLIflM1h7fYB5+LF92em1JZx3FSRkqFBR/QNOoWq9JH4LlCdPDNiwD2Kn4pi
	 nkioRdEfM9RobOo4pQ1/LIti7EcREh/oeC4srby4=
Subject: FAILED: patch "[PATCH] crypto: powerpc/poly1305 - add depends on BROKEN for now" failed to apply to 6.15-stable tree
To: ebiggers@google.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:37:40 +0200
Message-ID: <2025062040-slinging-salvaging-1638@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.15.y
git checkout FETCH_HEAD
git cherry-pick -x bc8169003b41e89fe7052e408cf9fdbecb4017fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062040-slinging-salvaging-1638@gregkh' --subject-prefix 'PATCH 6.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bc8169003b41e89fe7052e408cf9fdbecb4017fe Mon Sep 17 00:00:00 2001
From: Eric Biggers <ebiggers@google.com>
Date: Tue, 20 May 2025 10:39:29 +0800
Subject: [PATCH] crypto: powerpc/poly1305 - add depends on BROKEN for now

As discussed in the thread containing
https://lore.kernel.org/linux-crypto/20250510053308.GB505731@sol/, the
Power10-optimized Poly1305 code is currently not safe to call in softirq
context.  Disable it for now.  It can be re-enabled once it is fixed.

Fixes: ba8f8624fde2 ("crypto: poly1305-p10 - Glue code for optmized Poly1305 implementation for ppc64le")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/arch/powerpc/lib/crypto/Kconfig b/arch/powerpc/lib/crypto/Kconfig
index ffa541ad6d5d..3f9e1bbd9905 100644
--- a/arch/powerpc/lib/crypto/Kconfig
+++ b/arch/powerpc/lib/crypto/Kconfig
@@ -10,6 +10,7 @@ config CRYPTO_CHACHA20_P10
 config CRYPTO_POLY1305_P10
 	tristate
 	depends on PPC64 && CPU_LITTLE_ENDIAN && VSX
+	depends on BROKEN # Needs to be fixed to work in softirq context
 	default CRYPTO_LIB_POLY1305
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	select CRYPTO_LIB_POLY1305_GENERIC


