Return-Path: <stable+bounces-128392-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3DA7C902
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 13:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76177189518D
	for <lists+stable@lfdr.de>; Sat,  5 Apr 2025 11:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6281DF990;
	Sat,  5 Apr 2025 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYb7cvFD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10068F64
	for <stable@vger.kernel.org>; Sat,  5 Apr 2025 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743854277; cv=none; b=VZXgozhLngjhjBhpTXIFZGwNLi55aBMcJHcY58m0SKsjBiW7PF9Msw/TcmIL5EE0ROk5vS6R49IrEYgqbUDVDtXJRiRZSMq9iH2ahq/FWQYNjN1LgARW77I2i1cG/jlnajO5YdQ4xxbMZTPFDBQrAhhFF9Y6GcvzATENOcGC9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743854277; c=relaxed/simple;
	bh=SDm6e/RUOqic0OkAydCIjcLL1aRxT3Ny4jIxeN1My00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u2O3Xzo99AH18Ioyo20l45MkXvBVed/PdpqgyvgVjbLmzmFoyG++cTu2Z9ZJsJuAkI47pNCD1FpR3gwZu++n3AtrympLJGldVSlj57c1YVT7bsmfhHP0x14go06YqxFJC1sDD1o5BxeNPPeZL2ay/YKzA5dI3vWc1dOmXSw1EdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYb7cvFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3902FC4CEE4;
	Sat,  5 Apr 2025 11:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743854277;
	bh=SDm6e/RUOqic0OkAydCIjcLL1aRxT3Ny4jIxeN1My00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TYb7cvFDZYx569xCXKDuA2YMDuj5feRYqc4JXj/DA6dvfCf1JOQZy59OTJ8lgvKoM
	 6uEjZvSa00mHDm/f0anudKVOjA765L6TvFbdsidU8hj4NB0aUIe75lQneBaGFR5iQS
	 Zt01E1hYKoVty9PiQSlraktXzCqOcIg4wj33n5w1BMuR5jBjy+2sXScdOJlLz7K9xf
	 CrPudVdj0akm6ypk/mvtMeGABxPiL6aQWtDv9ubESKymSuJ539gpH8fv/DoHPz1kkr
	 sSVt3ij2rZYdsBublNYAHYDpliFjSIbnJPteqhHjGy1CGyFn0Mbj5O9wslYvS6ky3n
	 QdmFlkqpB64Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Liu <yifei.l.liu@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH Linux-6.12.y 1/1] idpf: Don't hard code napi_struct size
Date: Sat,  5 Apr 2025 07:57:56 -0400
Message-Id: <20250404230238-3b3b9a1dcb3a14e1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250404224212.16753-1-yifei.l.liu@oracle.com>
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

The upstream commit SHA1 provided is correct: 49717ef01ce1b6dbe4cd12bee0fc25e086c555df

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yifei Liu<yifei.l.liu@oracle.com>
Commit author: Joe Damato<jdamato@fastly.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  49717ef01ce1b ! 1:  de77aeac67190 idpf: Don't hard code napi_struct size
    @@ Metadata
      ## Commit message ##
         idpf: Don't hard code napi_struct size
     
    +    commit 49717ef01ce1b6dbe4cd12bee0fc25e086c555df upstream.
    +
         The sizeof(struct napi_struct) can change. Don't hardcode the size to
         400 bytes and instead use "sizeof(struct napi_struct)".
     
    @@ Commit message
         Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
         Link: https://patch.msgid.link/20241004105407.73585-1-jdamato@fastly.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 49717ef01ce1b6dbe4cd12bee0fc25e086c555df)
    +    [Yifei: In Linux-6.12.y, it still hard code the size of napi_struct,
    +    adding a member will lead the entire build failed]
    +    Signed-off-by: Yifei Liu <yifei.l.liu@oracle.com>
     
      ## drivers/net/ethernet/intel/idpf/idpf_txrx.h ##
     @@ drivers/net/ethernet/intel/idpf/idpf_txrx.h: struct idpf_q_vector {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

