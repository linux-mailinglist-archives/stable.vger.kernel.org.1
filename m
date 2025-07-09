Return-Path: <stable+bounces-161430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A87AFE7D7
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727BF1886FC1
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464C2C324C;
	Wed,  9 Jul 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2J4hEy+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E89252906
	for <stable@vger.kernel.org>; Wed,  9 Jul 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060737; cv=none; b=tWbh7Ae+kpaOjk2NcQx0JSC9tkXda2YuvTsUtKegwuzTKPk+pr0bxm92d2I129R78/Ze87uMzxWamYIojePQ8HSMSqXQS16TzmtMGpJ6jeXzXQUDtSVxbHnsiko7v4jOhdcaMDUvKS3Yhi4C0QjAj5yvgVfdCb9tvuTKNQahrac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060737; c=relaxed/simple;
	bh=lH7EI557zxTgw6tUvUQmeRVGow0Z9dzJEfXC1eC+Itw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXdw69TkKlg6CO81Ozm7jKefeHScHxyDkVQwFfS9ilW3XzCg+Tu8YIHoFgQOYIYGJE4yuWK4GcHEpQArwQrikLrEC+cNKLzqegwD6TOIQR2fUgtWKw2umYWGhx5qorWbafF2iufeFdttdnFcuR78w9DmpM7LaED43nldwiGiaRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2J4hEy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733E1C4CEEF;
	Wed,  9 Jul 2025 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752060736;
	bh=lH7EI557zxTgw6tUvUQmeRVGow0Z9dzJEfXC1eC+Itw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q2J4hEy+WRmoDZvdmzWKyT0Yd42kSaDPU8R2R6Z4N2HskM6g7/6CZdfYoVd3vb1h3
	 oLS6pyhs9Bwt0Q+b7wyQSkLNii2vYI15cHgibQJIAi1pOUDdGkS20ZY+y3+gvuRRW0
	 D6SCTMeZ7rp4wc9MMawsCl/QG2vna9ZCnLwFqUa0oNTRCAhKe0JEeolCVG+xSh8Z3o
	 bpZtTpBdvWFUGfF6TvFL9rglFXqDWeZErNeym/s6DPyflqcZ5tOoI5FBoB+joaWt3O
	 BVsQtSDde6ncFKwhl34F13Ugb/iRNbPSr/L6z6sc3zWstCBWXAw8hxqcJ8rFM3M3Tr
	 hpWaR2Y156dqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12,6.15] crypto: s390/sha - Fix uninitialized variable in SHA-1 and SHA-2
Date: Wed,  9 Jul 2025 07:32:14 -0400
Message-Id: <20250708223901-092cb868c0c5d78a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250708214423.3786226-1-ebiggers@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 68279380266a5fa70e664de754503338e2ec3f43

Status in newer kernel trees:
6.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  68279380266a5 ! 1:  99e83b12f4bdf crypto: s390/sha - Fix uninitialized variable in SHA-1 and SHA-2
    @@ Metadata
      ## Commit message ##
         crypto: s390/sha - Fix uninitialized variable in SHA-1 and SHA-2
     
    +    commit 68279380266a5fa70e664de754503338e2ec3f43 upstream.
    +
         Commit 88c02b3f79a6 ("s390/sha3: Support sha3 performance enhancements")
         added the field s390_sha_ctx::first_message_part and made it be used by
         s390_sha_update() (now s390_sha_update_blocks()).  At the time,
    @@ arch/s390/crypto/sha1_s390.c: static int s390_sha1_init(struct shash_desc *desc)
      	return 0;
      }
     @@ arch/s390/crypto/sha1_s390.c: static int s390_sha1_import(struct shash_desc *desc, const void *in)
    - 	sctx->count = ictx->count;
      	memcpy(sctx->state, ictx->state, sizeof(ictx->state));
    + 	memcpy(sctx->buf, ictx->buffer, sizeof(ictx->buffer));
      	sctx->func = CPACF_KIMD_SHA_1;
     +	sctx->first_message_part = 0;
      	return 0;
      }
      
     
    + ## arch/s390/crypto/sha256_s390.c ##
    +@@ arch/s390/crypto/sha256_s390.c: static int s390_sha256_init(struct shash_desc *desc)
    + 	sctx->state[7] = SHA256_H7;
    + 	sctx->count = 0;
    + 	sctx->func = CPACF_KIMD_SHA_256;
    ++	sctx->first_message_part = 0;
    + 
    + 	return 0;
    + }
    +@@ arch/s390/crypto/sha256_s390.c: static int sha256_import(struct shash_desc *desc, const void *in)
    + 	memcpy(sctx->state, ictx->state, sizeof(ictx->state));
    + 	memcpy(sctx->buf, ictx->buf, sizeof(ictx->buf));
    + 	sctx->func = CPACF_KIMD_SHA_256;
    ++	sctx->first_message_part = 0;
    + 	return 0;
    + }
    + 
    +@@ arch/s390/crypto/sha256_s390.c: static int s390_sha224_init(struct shash_desc *desc)
    + 	sctx->state[7] = SHA224_H7;
    + 	sctx->count = 0;
    + 	sctx->func = CPACF_KIMD_SHA_256;
    ++	sctx->first_message_part = 0;
    + 
    + 	return 0;
    + }
    +
      ## arch/s390/crypto/sha512_s390.c ##
     @@ arch/s390/crypto/sha512_s390.c: static int sha512_init(struct shash_desc *desc)
    + 	*(__u64 *)&ctx->state[14] = SHA512_H7;
      	ctx->count = 0;
    - 	ctx->sha512.count_hi = 0;
      	ctx->func = CPACF_KIMD_SHA_512;
     +	ctx->first_message_part = 0;
      
      	return 0;
      }
     @@ arch/s390/crypto/sha512_s390.c: static int sha512_import(struct shash_desc *desc, const void *in)
    - 
      	memcpy(sctx->state, ictx->state, sizeof(ictx->state));
    + 	memcpy(sctx->buf, ictx->buf, sizeof(ictx->buf));
      	sctx->func = CPACF_KIMD_SHA_512;
     +	sctx->first_message_part = 0;
      	return 0;
      }
      
     @@ arch/s390/crypto/sha512_s390.c: static int sha384_init(struct shash_desc *desc)
    + 	*(__u64 *)&ctx->state[14] = SHA384_H7;
      	ctx->count = 0;
    - 	ctx->sha512.count_hi = 0;
      	ctx->func = CPACF_KIMD_SHA_512;
     +	ctx->first_message_part = 0;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.15.y       |  Success    |  Success   |

