Return-Path: <stable+bounces-158587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F55BAE85B9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BF018857D9
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FDA264A7F;
	Wed, 25 Jun 2025 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+KnzGuC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0401D1F460B
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860538; cv=none; b=gdAB70IRnzm+LmiM3pIIwn3Qs0TEpVXtriJvSFqqc+R4FPuIoUpaN0wwVgaC7wjirWzA2qINxrmY2OBmePj0osdEHlHWl5QivKkP9LgIiNovvkFfxaa2ivLU5J04grbPmJaIALOKsMOP65tawVFrU4gA/A6yD9IELoMljHmf4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860538; c=relaxed/simple;
	bh=xVozyzTM11MNv/wukQTly06oVMWf8KG2kM2uAvtWUAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QilbZ46Xu6JvCvumUEcH6OOC4PA/pwUQLStM6Lj9L5ZZHxSysWgMfmT6SaB2rQaR8P9YQLKnp+wn2MCZjsCogkGlbzL17ULHWLsdFPwV7Dc0sxd5tYFatJjBkvukZZuSt9C15hbaJL310Wao+0SOfPyBJSI58bq3HvCZHJNfPN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+KnzGuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7836C4CEEA;
	Wed, 25 Jun 2025 14:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860537;
	bh=xVozyzTM11MNv/wukQTly06oVMWf8KG2kM2uAvtWUAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+KnzGuC/94oYgQu0wqEbmCRT5Rfd9xeZxgr+ALwLWJ1+n0lFr/5lXh3ICEKgOfMo
	 fWWBxzn0O2d5kXdc9bduri0strrUhjS/C5UYkeGtscGPEqIdtFnHgYjNmUuqob0JG7
	 UMjHWaxluQkmvgnNnE5/s4Jold9C6oK0kwfmWLChO9B0Ic7t0esCKwZamAnxwrB7st
	 gHAtCykjAA0yaTkaHeGr0YlLIv9uGszYCxoxI5Sjg2+hW/O46cOrHr0WV5uRF6upFF
	 dHBTDxa/gyGa6gWRAGZfecfo7JnlzkoRNe6D9YS/5ZqQjnaJdRtfU/DAaenAHtWARI
	 rruGJQp876wwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	schnelle@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] s390/pci: Fix __pcilg_mio_inuser() inline assembly
Date: Wed, 25 Jun 2025 10:08:56 -0400
Message-Id: <20250624192833-86b2ed42c775d7ef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623110715.3446009-1-schnelle@linux.ibm.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: c4abe6234246c75cdc43326415d9cff88b7cf06c

WARNING: Author mismatch between patch and found commit:
Backport author: Niklas Schnelle<schnelle@linux.ibm.com>
Commit author: Heiko Carstens<hca@linux.ibm.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: 003d60f4f2af)
6.12.y | Present (different SHA1: 578d93d06043)
6.6.y | Present (different SHA1: cc789e07bb87)
6.1.y | Present (different SHA1: e0e15f95a393)
5.15.y | Present (different SHA1: a8814ec473c6)

Note: The patch differs from the upstream commit:
---
1:  c4abe6234246c < -:  ------------- s390/pci: Fix __pcilg_mio_inuser() inline assembly
-:  ------------- > 1:  9a2f4b3653500 s390/pci: Fix __pcilg_mio_inuser() inline assembly
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

