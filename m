Return-Path: <stable+bounces-154756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA7AE012B
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA7A5A464F
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB172749E1;
	Thu, 19 Jun 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4iNJxDc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5B92741AB
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323758; cv=none; b=tjTTwPgtnkelLoSuHwzcVanusI/0PiggIRI1B+Gcqb/HO0J1kzV+TmTYIFMZf2FHWLPFBAePZn/btJxKbX3mqjmwJM3/D9I//C3klDQ9iYxDKWDb52cqze82OZcR/8IeIGUudP0MEhqsZ3qIXA91AYVIAnrKVR1yTQQ/fL6c22I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323758; c=relaxed/simple;
	bh=gNZc6MqJvKLv8uEjKy4yT7ZuGZpLFaKrm265ugrt77Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1FsCjnHB5YvOBgLR0Z5EKV7/kXDEpnSB5Irko8JIJXjt1v1iIX/Cm2+c+WfDs8pjJdiawQC1p8kYCc7UjpYa9VBWcFswOt887ykQs7KCfm60GU2GURal9LUIdydvVxcAm0lUysWzkpRMqZONrGih2U6XMDib5Mgy0UeitllV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4iNJxDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6993C4CEED;
	Thu, 19 Jun 2025 09:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323758;
	bh=gNZc6MqJvKLv8uEjKy4yT7ZuGZpLFaKrm265ugrt77Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A4iNJxDczxjZQsp0EJ/yMCxKdtYagyouUvWlvFskDvavYoGXiGGwUIbd5kwKAcBp3
	 tIFHiwSJrEykpGziVdbbqCQqsjBZ0ZtAr9FbgGTm3RH70PUfGDP8yGUQWv60ClBIQc
	 RPk1r6oXtAEXY3Ioh7xZpz0+ioAvonjd5yVsTdTEPz8+uRtlnekUSZc8oMPZkktsT7
	 VF1ZOipnZEbaJmM85Tw1FeAfXWkOjHFFTokraErxWP/zc0LJvokIuBwkwEiSEByz1D
	 e0jprO31WbPfo1AlkGPABtjBDECldp8krgIZD7ku1DH0wC9xECtCo+JP/pC1RszCiF
	 eLllbCTluJurQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 15/16] x86/its: Fix build errors when CONFIG_MODULES=n
Date: Thu, 19 Jun 2025 05:02:36 -0400
Message-Id: <20250618191757-ed868369f64f9a03@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-15-3e925a1512a1@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Eric Biggers<ebiggers@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: bb85c3abbfd8)
6.6.y | Present (different SHA1: 9f69fe3888f6)
6.1.y | Present (different SHA1: c2bece04baf8)
5.15.y | Present (different SHA1: e7117657695b)

Note: The patch differs from the upstream commit:
---
1:  9f35e33144ae5 < -:  ------------- x86/its: Fix build errors when CONFIG_MODULES=n
-:  ------------- > 1:  774e8b31d8263 x86/its: Fix build errors when CONFIG_MODULES=n
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

