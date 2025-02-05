Return-Path: <stable+bounces-113250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B542AA290AD
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2461D1887C29
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C65A16DC3C;
	Wed,  5 Feb 2025 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZvOHOzh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE701714D0;
	Wed,  5 Feb 2025 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766327; cv=none; b=rFnch4mtdRLZ8o+MvfuclvgW5GCGJJixVYVhJX184SzQhaMFqvNy4CDzmSJoXTCl8BZoFguh7yW+oRIoNziJkfaEOZ2mtDMY0llTyWcnN2mr2+8d/pfkSg339oXjfqGPBwuy6t0r2/+NB0Va7N5xAiIn3xpvBdG4V3g4zVC0q9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766327; c=relaxed/simple;
	bh=C6Sd2qlaZtzlc9O2dG42ji4oo/YzbruzmSIFsk9M9s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QmV1k+AhsvQdSTbupmhkdxyVWG/U6RBWhYx2xK9jZ2w2bezwUWyTbNpp1463KXmf92DfEmg/OThDd116YQf647nMSPSXKzw6+RWobX1l+14QoGndONFxZ5lS42eSBfoCcKEEp9MqBDk3ZhAjrazdwQ8qeueBBReI6O7Nwlg3w7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GZvOHOzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A1FC4CED1;
	Wed,  5 Feb 2025 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766326;
	bh=C6Sd2qlaZtzlc9O2dG42ji4oo/YzbruzmSIFsk9M9s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZvOHOzh71ONveuAn4x3Ig6a0lXSeafxHIrvkKc4P16g2VOQxUBCJGfxVnrswTFZX
	 Q8hgY7GeRO++QGCdr/fivEnHrwPRSN5IZXf0xhjx37CuwlMOfjOMzf7hjwAt3AWeyw
	 bv4JGVYMEpFimuNc4gaB80kk/tsRfiC0oI+5f0+w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Herbert Xu <herbert.xu@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 263/623] crypto: api - Fix boot-up self-test race
Date: Wed,  5 Feb 2025 14:40:05 +0100
Message-ID: <20250205134506.292455278@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>
References: <20250205134456.221272033@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 8dd458cbc5be9ce4427ffce7a9dcdbff4dfc4ac9 ]

During the boot process self-tests are postponed so that all
algorithms are registered when the test starts.  In the event
that algorithms are still being registered during these tests,
which can occur either because the algorithm is registered at
late_initcall, or because a self-test itself triggers the creation
of an instance, some self-tests may never start at all.

Fix this by setting the flag at the start of crypto_start_tests.

Note that this race is theoretical and has never been observed
in practice.

Fixes: adad556efcdd ("crypto: api - Fix built-in testing dependency failures")
Signed-off-by: Herbert Xu <herbert.xu@redhat.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/algapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 16f7c7a9d8ab6..7e061d8a1d52d 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -1016,6 +1016,8 @@ static void __init crypto_start_tests(void)
 	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
 		return;
 
+	set_crypto_boot_test_finished();
+
 	for (;;) {
 		struct crypto_larval *larval = NULL;
 		struct crypto_alg *q;
@@ -1047,8 +1049,6 @@ static void __init crypto_start_tests(void)
 		if (!larval)
 			break;
 	}
-
-	set_crypto_boot_test_finished();
 }
 
 static int __init crypto_algapi_init(void)
-- 
2.39.5




