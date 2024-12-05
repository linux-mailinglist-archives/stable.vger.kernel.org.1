Return-Path: <stable+bounces-98833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C66B9E58C3
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD22280CCE
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E99A218EA7;
	Thu,  5 Dec 2024 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5qcYrsc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6C9218AA3
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409932; cv=none; b=D4m02gtR3X+sJp1TtHSieuAv9gbIEb8Grl6AOmFATEemDpwbGftPtAUqmqlfhD8yA4JYduJTWmRUgNw++F1D228e+9ds9nBOxN2vH9VFClY5jSWL5ND2CygD5/KuS5BzcidnN2KxWury2NrW+ofy4+MUCZ0nS2XICILFf4nWtsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409932; c=relaxed/simple;
	bh=2662CFvNfJ5O34Sx5/h7Hg1OIB7VTNKNdFrOAm3pnfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhuYRAw29q1pEsrRoZ1zDf1AmPvDUwRxlHphffAmFAGipaydldyjUvw6MG73V4GA6MflyNqhATNzRJLmOJbyFhrAsGxF6vfP5BoUmhsVuLCSfsjZuLN1OVP3+KUAam4t2AQt9dSr4PCT+wrZAXdRCJtmvTwrgjEzqGEJMNR8so0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5qcYrsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7008CC4CED1;
	Thu,  5 Dec 2024 14:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409931;
	bh=2662CFvNfJ5O34Sx5/h7Hg1OIB7VTNKNdFrOAm3pnfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5qcYrscLOFtDgU+LdWHbpzYugc+wYHcDcsu8br8rLzXl6NdnmWoMPrtBzOolrz4b
	 mw57LyvIyexYplWF5KTPbiBQLOifWgV/oIfzJDmU80day+rTF1GEVmH12vTnGNgcdR
	 0igiC3MqqCkrBK36qdPFervC4wmLjHt2s6kId0Xp1yRnUOy/zaSvdi0TmvrX/KAJab
	 Ftv6ogXudtc50/SRJLP+Du0ngqCwz5rfqQklF0ubt7uccfrz/+X6T+7WlXtIXTUoGP
	 /pUqWvHthOBFsB4cNL0te9RIvD5Z2iVMtv4AKQwKZmtt93XdSzF45B1oTp1XsmPsqL
	 dPPClV1H7iWZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] tpm: Lock TPM chip in tpm_pm_suspend() first
Date: Thu,  5 Dec 2024 08:34:12 -0500
Message-ID: <20241205065248-dd3b2441dd98089b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241205022644.164941-1-bin.lan.cn@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 9265fed6db601ee2ec47577815387458ef4f047a

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Jarkko Sakkinen <jarkko@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: bc203fe416ab)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9265fed6db601 ! 1:  7fcb4bafb7f2d tpm: Lock TPM chip in tpm_pm_suspend() first
    @@ Metadata
      ## Commit message ##
         tpm: Lock TPM chip in tpm_pm_suspend() first
     
    +    [ Upstream commit 9265fed6db601ee2ec47577815387458ef4f047a ]
    +
         Setting TPM_CHIP_FLAG_SUSPENDED in the end of tpm_pm_suspend() can be racy
         according, as this leaves window for tpm_hwrng_read() to be called while
         the operation is in progress. The recent bug report gives also evidence of
    @@ Commit message
         Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
         Tested-by: Mike Seo <mikeseohyungjin@gmail.com>
         Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
    +    [ Don't call tpm2_end_auth_session() for this function does not exist
    +      in 6.6.y.]
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
     
      ## drivers/char/tpm/tpm-chip.c ##
     @@ drivers/char/tpm/tpm-chip.c: static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, bool wait)
    @@ drivers/char/tpm/tpm-interface.c: int tpm_pm_suspend(struct device *dev)
      
     -	rc = tpm_try_get_ops(chip);
     -	if (!rc) {
    --		if (chip->flags & TPM_CHIP_FLAG_TPM2) {
    --			tpm2_end_auth_session(chip);
    +-		if (chip->flags & TPM_CHIP_FLAG_TPM2)
     -			tpm2_shutdown(chip, TPM2_SU_STATE);
    --		} else {
    +-		else
     -			rc = tpm1_pm_suspend(chip, tpm_suspend_pcr);
    --		}
     -
     -		tpm_put_ops(chip);
     +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
    -+		tpm2_end_auth_session(chip);
     +		tpm2_shutdown(chip, TPM2_SU_STATE);
     +		goto suspended;
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

