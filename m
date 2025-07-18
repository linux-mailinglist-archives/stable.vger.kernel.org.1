Return-Path: <stable+bounces-163314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B82B09937
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB2E17F415
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A311581EE;
	Fri, 18 Jul 2025 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrBdlBdC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23323398B
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802479; cv=none; b=uZkIqPVJB8FAU+mMAdMHFJ/n7l7Aq2y7SESjZGqB4G/sQrB+MfqcX7iOAcL4pejeoWUNoCKtdt6LdelHIBd33vsHatPFVDDAyFmZ/DvRiJ31IVggGR7esmdCfLoIsNWHWULsaUOyTVUwPN9ybrHRGCEb9C38mkPPAexX4DmNsgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802479; c=relaxed/simple;
	bh=E62KsOzzfxMa5qTU3lUAqf6/UAV1UElYo2yGHME6rFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU9+wqI6EYXEavgspABno+Bt7wmz+0tU9mwlzgZzxZ59blad1/vs5AQRCXXPwFgmbH7qOUPVFOd9YER6ui3hGmskDFRwyv92xKzDwjIR1lV0KN06dtGaywO/t6MUO74T60kxW/RnnjgNTLAGt9DesLoNFxIQtfghiQP943/d2p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrBdlBdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8711CC4CEE3;
	Fri, 18 Jul 2025 01:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802479;
	bh=E62KsOzzfxMa5qTU3lUAqf6/UAV1UElYo2yGHME6rFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VrBdlBdCjFtoTSusRRTnVU9C+uQ/KALoA6rms1WyXRsTxqeo/1tv8EEjNBNDRVctB
	 mDIzie0wJRKLFGp2UBFGAmyrJAGqbOu/iFvAdF/lgQW6+CQSmiP7PcjsIb7uBs30lh
	 Ddbdpt6GBunej/G3Sc7k3b+D+PuaHQTrkMDho/J936f3uuDanPqu8PCXSFneYyl40f
	 bY+ewcSRLACQC10nZr8pvy7drn5uPAaI2oMYadCOo3+qdX2S36gBAwfj01VTowqDk2
	 Hz2eiocpCIhpmzOuZEyp7xG8lqnwD9v+p1Yseh0ie4I/GKO5vIJUJCpTDBo51GADDY
	 tamoT+3kJHJkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	giovanni.cabiddu@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] crypto: qat - fix ring to service map for QAT GEN4
Date: Thu, 17 Jul 2025 21:34:36 -0400
Message-Id: <1752795908-8533c229@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717170835.25211-1-giovanni.cabiddu@intel.com>
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
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: a238487f7965d102794ed9f8aff0b667cd2ae886

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 82e4aa18bb6d)

Found fixes commits:
df018f82002a crypto: qat - fix ring to service map for dcc in 4xxx

Note: The patch differs from the upstream commit:
---
1:  a238487f7965 < -:  ------------ crypto: qat - fix ring to service map for QAT GEN4
-:  ------------ > 1:  1c3a13c46a06 crypto: qat - fix ring to service map for QAT GEN4

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.1.y        | Success     | Success    |

