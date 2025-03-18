Return-Path: <stable+bounces-124813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C020EA67759
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA993AA0D1
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 15:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6E220E021;
	Tue, 18 Mar 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6S3fsIR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4620CCE7
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742310756; cv=none; b=fGJfJO0ylv08Sle95RrjdKNdeMpx/WLVasVREBNbsEj+YU3yepWS+Y1zOa7pL8l/j87Da9xi95/ZEESvoQIXUnpNoYyUzjbuUhhTf0yQultdcT3sLIfFOsRIBg00cmktO3kVUveUsHmBeBHQCSVrFp/GBIemKN64DtUXrqYNZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742310756; c=relaxed/simple;
	bh=O20+goNErizC+jfJZimGSn7lTxRTeN6yfuKTFcIRPwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYIqnTzIgkg9VqqynJW6+dX9LMbtH7i3Lp5s59bVRunI+C4wMj8LOtYrau2+RNrMzAft86nJ2bwNDaPSQpRWwzQR/Ryii6zodiLR92IjCXapjOa5yz7GyWsPXg72Q3tD89NHx/O19/TkzxGoY5lCyePIn6gGwoC+wlAx2MrWq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6S3fsIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A95EC4CEDD;
	Tue, 18 Mar 2025 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742310755;
	bh=O20+goNErizC+jfJZimGSn7lTxRTeN6yfuKTFcIRPwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P6S3fsIRnge7eXXkWWFYXMcdrWsQCf8WfKZ7WLdAcyfw4cJJY8gIzn7Veq2xm3v/s
	 IsidYEd7wGmZUNyh3KWFweC2wp1nEpzbzbo7KY214VHhRpYK8/I8sB4LHiDSCfWugl
	 JGSM98zCCCZcdr4AoEsZp9Oo++UNzanD8z1e1owR4MMFPI8kkY7Pw8QDlERzbaDAmV
	 SDkLZEDT98QTKXbAmmI9p27NegCDcrQLoRJZsUoDTvjEBhMc1iu9Gkvn4r2zUkrNvG
	 a+bklMRO1hVT0eJRjWXY/hfzesA7lM/10X5kv3OghXQVKF8hTAjCsd/h89BFLuOf+P
	 ptrOJ7zvwrKcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1&6.6 V2 2/3] sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
Date: Tue, 18 Mar 2025 11:12:33 -0400
Message-Id: <20250318082558-291596ddee8c1719@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250318110124.2160941-3-chenhuacai@loongson.cn>
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

The upstream commit SHA1 provided is correct: 467d60eddf55588add232feda325da7215ddaf30

WARNING: Author mismatch between patch and upstream commit:
Backport author: Huacai Chen<chenhuacai@loongson.cn>
Commit author: Jan Stancek<jstancek@redhat.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  467d60eddf555 ! 1:  8aff3a7abfb6f sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
    @@ Metadata
      ## Commit message ##
         sign-file,extract-cert: avoid using deprecated ERR_get_error_line()
     
    +    commit 467d60eddf55588add232feda325da7215ddaf30 upstream.
    +
         ERR_get_error_line() is deprecated since OpenSSL 3.0.
     
         Use ERR_peek_error_line() instead, and combine display_openssl_errors()
    @@ Commit message
         Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
         Reviewed-by: Neal Gompa <neal@gompa.dev>
         Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
    +    Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
     
      ## certs/extract-cert.c ##
     @@ certs/extract-cert.c: int main(int argc, char **argv)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

