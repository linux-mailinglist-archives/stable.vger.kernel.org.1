Return-Path: <stable+bounces-135171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B61A7A97540
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2C21B61902
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B823F28FFC7;
	Tue, 22 Apr 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROaJIyYb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748861DDA1E
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745349443; cv=none; b=tIRxmoV4OKSPZDohfhOyWM3R9DVKIRLmo87I2SXo4dlIcK1aJ6n0ZJg6cwJ7ZElEEY1Khk4ZPXQMC/r0nLuc+UjDcuYuuRlrcLlPNY8XtPwQhCBkcCxuE7JMOqxXSRf+IRHZMs2l9Wn3NQdlgNAcB0vhWOcrAbKKJBXtMkXy3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745349443; c=relaxed/simple;
	bh=3WvsCYtWJMc4hM52AGdDgTqYbvpYgpgDP1fa7eIr/b0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cSGbEjcJywoXZciOpz0F9cHgaIm7uMiIHaRSQHclLvGRjIOEY8o+It3AQq6SRaJFR4PU9WJPAg/72hH/yb6yIZSu5o66z0iwHprwHBd52nkFW/y/62yBy1FjjfWUQdEAi35fAuexN67xA/eokh/y9y+pkKuQ0ZSkNG/pMj3q/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROaJIyYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A1EC4CEE9;
	Tue, 22 Apr 2025 19:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745349442;
	bh=3WvsCYtWJMc4hM52AGdDgTqYbvpYgpgDP1fa7eIr/b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ROaJIyYb6alta5ubzR4wQtKnNtsd6oD1NWYpXGA+Ud+hbpgjC5uQeaDd5moGNYk3Z
	 Lmjnpztrv6xkbiKojmGPwVjYn/buf9oiYimooCyZBlcZziZB9OtiNnTOHaFW3RCqkh
	 MuR+Wy3vjWDo579eXh60NkVAcbmv8c/OFQEimEWnog+wNdDahxuR8djH+CYDshDZoY
	 VDdpjLlfh6V2gtNlNZ//alBJwvRbjBeYgBGV5Nrk0RPFFvPyGXQtXxdT+wmwB/ndNN
	 Aqf5voXpjsIInJIWSDRRl6HQRs90Cm7tloGa35rI0GNdOHJB9kG0WM+GvmbxToq59w
	 yDUWlIDlEF96g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 V4 1/3] sign-file,extract-cert: move common SSL helper functions to a header
Date: Tue, 22 Apr 2025 15:17:17 -0400
Message-Id: <20250422132532-7ec41846b08adfab@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250422123135.1784083-2-chenhuacai@loongson.cn>
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
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  300e6d4116f95 ! 1:  18d2cf948caec sign-file,extract-cert: move common SSL helper functions to a header
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
| stable/linux-6.6.y        |  Success    |  Success   |

