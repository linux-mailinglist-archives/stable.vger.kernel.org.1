Return-Path: <stable+bounces-151963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20893AD16D3
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211563AA7A0
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C45B2459C5;
	Mon,  9 Jun 2025 02:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ws7wGk0b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D124503E
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436456; cv=none; b=M3Fik/1U0QZy0pk2WS3IGbQRKvVcOcQb1COJK7zt9FeonPxcvgVUusUMWH616qkEkzpPsWuMa6Bg2TKsEZasKjbgMMWos0DunA7eoBgQGq+AUnpJyOYc33BV2IAbiFILhD/Q6Zy8GsbZGFL+FhS9Q1+kQYHBQuRyph8gLWaNqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436456; c=relaxed/simple;
	bh=/cAur+Ku5Oi85vgjIls/4WjdIbjX8hlbDHQ11Cg39vM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lmw2Y+GhhMtpwDdrmEZmoQeFGJ1iha44aB6SNpOg0NY8SH1E5+NWieF7S1xee636m9ZlpRG5HqCfEuFxpONCQlE/K54VZd65S8YtdCLrBsmE0gIGxeFFfip7/Xih/gtz5Sjp71Uf+TsOuH8YdxgImZf0A2y8WVA1PtZU5OOZOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ws7wGk0b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C5EC4CEEE;
	Mon,  9 Jun 2025 02:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436455;
	bh=/cAur+Ku5Oi85vgjIls/4WjdIbjX8hlbDHQ11Cg39vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ws7wGk0b1jzI3djRF3K67ev4i65MqTjKGyjYJSUYZtN1FQ4SGChzBHNSIdHhhEAip
	 YvZaKext3ZBd+N6Rsp7IAP/KgxWo7hdf+naB3m93kGDWHPVlt9hSZBnouo8HjFJvMl
	 H2mJSIQY8cL4oTe1KHhwaT+pnpacxrWLBEc1KAwzixBr03fRjd8AeTk9QZzdiGx/6h
	 4emyTXkJRY6bwDM3kupSOS78sFXAPGtZOyBZ8T7oaQRQv9LkQ12BoX2Y6VpKOA+WN4
	 CVewIACHB3fGbgD5r1kzf7Iv73kYIzNsqddrzfrUceA8VA2bpdYgiCdCiEyUn4pSzW
	 VeP96pju68XuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pulehui@huaweicloud.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 08/14] arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists
Date: Sun,  8 Jun 2025 22:34:13 -0400
Message-Id: <20250608192729-81dde4f7a8a2602c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607152521.2828291-9-pulehui@huaweicloud.com>
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

Summary of potential issues:
ℹ️ This is part 8/14 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: a5951389e58d2e816eed3dbec5877de9327fd881

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: Douglas Anderson<dianders@chromium.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (different SHA1: e060dbb7393e)
6.12.y | Present (different SHA1: 9ca4fe357464)
6.6.y | Present (different SHA1: 4117975672c4)
6.1.y | Present (different SHA1: a53b3599d9bf)
5.15.y | Present (different SHA1: 46e22de65eb4)

Found fixes commits:
fee4d171451c arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays

Note: The patch differs from the upstream commit:
---
1:  a5951389e58d2 ! 1:  b739a64740293 arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists
    @@ Metadata
      ## Commit message ##
         arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected() lists
     
    +    [ Upstream commit a5951389e58d2e816eed3dbec5877de9327fd881 ]
    +
         When comparing to the ARM list [1], it appears that several ARM cores
         were missing from the lists in spectre_bhb_loop_affected(). Add them.
     
    @@ Commit message
         Reviewed-by: James Morse <james.morse@arm.com>
         Link: https://lore.kernel.org/r/20250107120555.v4.5.I4a9a527e03f663040721c5401c41de587d015c82@changeid
         Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/kernel/proton-pack.c ##
     @@ arch/arm64/kernel/proton-pack.c: static u8 spectre_bhb_loop_affected(void)
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

