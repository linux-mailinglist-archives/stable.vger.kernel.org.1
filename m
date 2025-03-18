Return-Path: <stable+bounces-124823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82FAA67762
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902E73B9B44
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7520A5E5;
	Tue, 18 Mar 2025 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpvtiAGy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F791586C8
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310776; cv=none; b=djA02KbcGn+hs7WBP+6/Cz0AStoOszwH0X9iKiB+sfphkCNZNTFAgA8Uy3+nqfVTAnDufZQJ7NiYd4OP7wICUTWuv0pksx4nvpTEJtAIooQYjAX6nlqdaFthIjBwLUZlJ3l4Qd0FfOnZujD3bax8YvdAFvGk5MW6ooywC99Zems=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310776; c=relaxed/simple;
	bh=sDCPQRspKguGeLgfPjgWT/XbANCsj8yo0JSUnPYGbj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=louaDCR+9vA3WnIHE37KvExTh+7Kd/EAjaivs/a/ItQW65aA2itqK69Yg4cfyutIQfcQEC7NGYdQg8MQOgnVb1QsRPWgbGMhOchoLSs1X+xHYN68pD35dZHOoEpkz5pIxpiEemDyfwtUxnUg5FBATYasmKt8Yh6Xh5B39bKojT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpvtiAGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D77BC4CEDD;
	Tue, 18 Mar 2025 15:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310776;
	bh=sDCPQRspKguGeLgfPjgWT/XbANCsj8yo0JSUnPYGbj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpvtiAGyEhtFPMCD48n0cWkZu6sqTvniNNhtPiw5hiDQcZDa3XG7zTJqks/k6t3oR
	 xbDWdoSl157Rg1Fnkyz61BGZGm0GtkuL0hnVPff2UuTPA7HlufdwE0WJVIAFVanLxN
	 ZNcwOrT1lulHjOcI7XvbpU2f25z8UEjBdhg+oqTP5kr/xGkxFIPMADyDKS65AqVaNI
	 oa1k+JmX+OxkahLV57iV3EMTvbuSeQ7PljKtHIA6KaICxY0SIHWBpq/dU/hvMhNiiF
	 sIPMUS16lLU4KOpDr5vNq66Em6vlzZWGK9V+NwIPO4QLIxwU5xQT5S1ZLpYC5kSVBI
	 2CnHx37MrbdjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 1/3] sign-file,extract-cert: move common SSL helper functions to a header
Date: Tue, 18 Mar 2025 11:12:55 -0400
Message-Id: <20250318081737-cf93b15b18accff5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318110124.2160941-2-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: 300e6d4116f956b035281ec94297dc4dc8d4e1d3

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Jan Stancek<jstancek@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  300e6d4116f95 ! 1:  685d9913a2def sign-file,extract-cert: move common SSL helper functions to a header
    @@ Metadata
      ## Commit message ##
         sign-file,extract-cert: move common SSL helper functions to a header
     
    +    commit 300e6d4116f956b035281ec94297dc4dc8d4e1d3 upstream.
    +
         Couple error handling helpers are repeated in both tools, so
         move them to a common header.
     
    @@ Commit message
         Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
         Reviewed-by: Neal Gompa <neal@gompa.dev>
         Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## MAINTAINERS ##
     @@ MAINTAINERS: S:	Maintained
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

