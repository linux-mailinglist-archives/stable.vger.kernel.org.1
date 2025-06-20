Return-Path: <stable+bounces-154875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A99AE1302
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 07:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3873BDE5D
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 05:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AF01EFF92;
	Fri, 20 Jun 2025 05:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vchJOvUz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116521DED53
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750397872; cv=none; b=BPtvGuIwQlQe87pq+nK0s8fdxfEJyHjhLlLG9ejF2SyXnwAYp1IYGiJfRc6fuko+5+SU6qrPbMkRU/MR85DqhDeBcBSsvfoTywbiD1UDEuizW831NFjbIfSSvAXxpuqKyFi5lsVCimj3ZZ5GBDDaF9+sh94m+iwH1hhcbWEfB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750397872; c=relaxed/simple;
	bh=etaFizRWH6bdGXgeeFID++inEc60UB4wdc8oRwtZHbM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iAWPRYtAYiniu1IG1TArDetFVDWVP53P0R+9Kz6gO6TIm/vvg/VWnbRQu/GjHt7+TBNuxqjZFjN1IAEp0VSGyCpCR18MVIx+RGjzVbQdmrFxOmixOPEhwDm+UhrXXF30VTEZuLfWYZulm6TdH0bTf+FlFNQRHT39OwU33QGh0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vchJOvUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59243C4CEE3;
	Fri, 20 Jun 2025 05:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750397871;
	bh=etaFizRWH6bdGXgeeFID++inEc60UB4wdc8oRwtZHbM=;
	h=Subject:To:Cc:From:Date:From;
	b=vchJOvUzeOH8aYQVOU862csN/W7iXMxJh5No5KDMaZN9zJpjixMS4Pj0Ti1MYDGDK
	 omWXMkweSNWgEPsOSpLyitBRx7VXWY88pftSbdz1BnJsmHx6WngA0MOC1H6cR3V+fz
	 zRGo1QVw409Zfv61u127X0c02BU/wTdQlONyBEAY=
Subject: FAILED: patch "[PATCH] crypto: powerpc/poly1305 - add depends on BROKEN for now" failed to apply to 6.12-stable tree
To: ebiggers@google.com,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 07:37:40 +0200
Message-ID: <2025062040-renderer-tremor-6a52@gregkh>
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
git cherry-pick -x bc8169003b41e89fe7052e408cf9fdbecb4017fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062040-renderer-tremor-6a52@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


