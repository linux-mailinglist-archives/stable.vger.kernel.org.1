Return-Path: <stable+bounces-127692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA29A7A711
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6049D189673F
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A49C2505A6;
	Thu,  3 Apr 2025 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnpPDV+A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3A824CEE5
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694761; cv=none; b=jCQItMkAjG33KFFzs8UgXOMM7Nhvu8KmVaCuRJXM/BwfvitgDUfcmNRr3CjWnvUwX2XCpPEffwwcQP1g5/8aamWi+TpPYt+DFZkHJcyyztu08fXGq6q3zVbU+s81CaxAY7QWO45vULDaJVPtdWnQO2VNz+p9aT0AiIUImQrsnzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694761; c=relaxed/simple;
	bh=bQE9o1tkVGTJGxsqtiq2PVgxtz09MuB0/DajcfGQuag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FauG/oKeKtoYReYchjZLl6sadfrVo8Bln6ne9T0M5nThUL1Cns8wrWUfp0QqvpEScKSAoLU7VHM2N9VN+2Ctwq63nBKuUK0/a97/uI8powCkqjIYGxpDFp9UYrlmpT2zEcpew9CPfZ6XktROaCx79kKA5AJ6D5jN3jAu+ewCBfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnpPDV+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D629FC4CEE7;
	Thu,  3 Apr 2025 15:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694758;
	bh=bQE9o1tkVGTJGxsqtiq2PVgxtz09MuB0/DajcfGQuag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnpPDV+AXImQDPzcInI8x2Pj4Sdf/XaIVAComYRoCxRvPjXER0MCAUqKYlRu2SqZ1
	 befxnazFU5EGmA4npypSCatDFQa/dl1rxNHfjr56RPqjcxVPy3ZymM4URDU2R/48hD
	 d06B38pzeoFu/4gu7QB5wAUZYmvweTwlDVrjok1RwqFXjBULC4VeJQ48ktnCP/qQ/T
	 QrMxGElpVBEeXzPR5iLRExcF+L0d2Dhoy9abdr7jwg6gDuDc+JiT3lw9RjQTifRyad
	 Mul0+jb15dtkYYbuyPbGcvPi7e11j39RjCmFUTk/cEhkjF4ZBVV8e9ZUPtEFaob3dI
	 LxgkrkAWjozJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 07/10] KVM: arm64: Remove host FPSIMD saving for non-protected KVM
Date: Thu,  3 Apr 2025 11:39:14 -0400
Message-Id: <20250403110017-abb988506967722b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403-stable-sve-5-15-v2-7-30a36a78a20a@kernel.org>
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

The upstream commit SHA1 provided is correct: 8eca7f6d5100b6997df4f532090bc3f7e0203bef

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 49ff7456c61d)
6.12.y | Present (different SHA1: f845093588b2)
6.6.y | Present (different SHA1: ed01c7d341d6)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8eca7f6d5100b < -:  ------------- KVM: arm64: Remove host FPSIMD saving for non-protected KVM
-:  ------------- > 1:  89b26e48bff0d KVM: arm64: Remove host FPSIMD saving for non-protected KVM
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

