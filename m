Return-Path: <stable+bounces-201599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EB7CC3C89
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8861330C6228
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8056C349B00;
	Tue, 16 Dec 2025 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKrgRoQc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C81A349B06;
	Tue, 16 Dec 2025 11:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885168; cv=none; b=VEvXepCAYyJlHhw0mr0m0s/MAFJ28upBBYaRb5Ar4WOLtsUgkCg0spRmX1ll94x1fkO1c/tgA/vmrIX2frSthttdZyBdBaO3vtPAvm1cwucPb/YEBb3aRIMiU2GgiYNkTieo0PZyv5TuGyoApjPTeYvLVVwfqaKkQBxebN+orYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885168; c=relaxed/simple;
	bh=8skelLiE3dWpJHNWy1ozUHp4tcANgLE6VNxnTsnUqk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/XcgJyLRqH6/9HRG/cxnYLEFp43AuixGLlh+OO9N+HZK+Lh7X0MtacP81L4r0qSsRmIsyxrFLb4/wk2XZAp2aPw9igoQbes/e9Sm5FJjIndelihWyac2VIO69pck+16HapNzjt82Au/cTNKhSADnUi2EgJOHbR6OtwOK/sCTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKrgRoQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78195C4CEF1;
	Tue, 16 Dec 2025 11:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885168;
	bh=8skelLiE3dWpJHNWy1ozUHp4tcANgLE6VNxnTsnUqk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKrgRoQctI3m/LDA5yU7fzeGo1+OOGgvnkaRG+WI3b2TpEaV8wvFbT9/QrwoeZLkI
	 098BBQnIuSozx/UQ3GgksjMMdw52DbDW1D5St3S/oRtGQtI73huUj3C/DVvlDRzbY7
	 P4xC0uZHA+gXdWrqEiHOmksjOk1VXdBFhBIu3MvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	T Pratham <t-pratham@ti.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 057/507] crypto: aead - Fix reqsize handling
Date: Tue, 16 Dec 2025 12:08:18 +0100
Message-ID: <20251216111347.608265987@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: T Pratham <t-pratham@ti.com>

[ Upstream commit 9b04d8f00569573796dd05397f5779135593eb24 ]

Commit afddce13ce81d ("crypto: api - Add reqsize to crypto_alg")
introduced cra_reqsize field in crypto_alg struct to replace type
specific reqsize fields. It looks like this was introduced specifically
for ahash and acomp from the commit description as subsequent commits
add necessary changes in these alg frameworks.

However, this is being recommended for use in all crypto algs
instead of setting reqsize using crypto_*_set_reqsize(). Using
cra_reqsize in aead algorithms, hence, causes memory corruptions and
crashes as the underlying functions in the algorithm framework have not
been updated to set the reqsize properly from cra_reqsize. [1]

Add proper set_reqsize calls in the aead init function to properly
initialize reqsize for these algorithms in the framework.

[1]: https://gist.github.com/Pratham-T/24247446f1faf4b7843e4014d5089f6b

Fixes: afddce13ce81d ("crypto: api - Add reqsize to crypto_alg")
Signed-off-by: T Pratham <t-pratham@ti.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 crypto/aead.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/crypto/aead.c b/crypto/aead.c
index 5d14b775036ee..51ab3af691af2 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -120,6 +120,7 @@ static int crypto_aead_init_tfm(struct crypto_tfm *tfm)
 	struct aead_alg *alg = crypto_aead_alg(aead);
 
 	crypto_aead_set_flags(aead, CRYPTO_TFM_NEED_KEY);
+	crypto_aead_set_reqsize(aead, crypto_tfm_alg_reqsize(tfm));
 
 	aead->authsize = alg->maxauthsize;
 
-- 
2.51.0




