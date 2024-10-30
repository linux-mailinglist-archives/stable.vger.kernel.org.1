Return-Path: <stable+bounces-89366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C6D9B6E1D
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 21:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6191B2334D
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FE820E31C;
	Wed, 30 Oct 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/1jmtKz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEE11EF94E;
	Wed, 30 Oct 2024 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321386; cv=none; b=lRqZhx8aP8OcyUzNMuK099ThdfNAABkqvs0ulFVhACwHaGRM0CWSXh0tyJxJXLEBfcxdv4n+JJP1l1jmOUlHT4g6qzCPRBq6SWjdlPS5dCv97Z9J0RfvXORRuFuuNPIQ2K4v7MYzNpXbuHJ71SRRyEHkiN6Ycv4PYMLgwQshayQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321386; c=relaxed/simple;
	bh=+yvwE337Qdag2rGuNvdsfIda3dNqnIov5peBktID6b0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=e9KqJS7JvgyDxNjNZlp6Vp9QSAFh4MHL+ZxiaUSdxmgBuefFY0AyMNJl7if9j/gYy9srFV2Veuj4/nAKpvimgEDgPcLwBcGUw/+3MvjU33iQblKKwTQ4e/kd+J6cGbohXhY4hFwAWhFqaauWTg3pFjVT2k343MN/jORwILCFL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/1jmtKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804A3C4CECE;
	Wed, 30 Oct 2024 20:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730321385;
	bh=+yvwE337Qdag2rGuNvdsfIda3dNqnIov5peBktID6b0=;
	h=From:Subject:Date:To:Cc:From;
	b=n/1jmtKzwNjxrgBgr0XHhgb5joWzPDKskC4fLKe8EGDkTBSzI/HcVjnV0CDBIxCtl
	 B+9fZMh4aMIaW6aHFZPAcBqfGLorbZmaAD60I3yJPVQ0Fi8MRqDz9w9UEK4iI7eqBY
	 X7Bf36R90rtMJVzm1LXgDWU8DxSXHENUszkIF0CEnf/1MXrGrk4TiD9Fx0VfKlJXb9
	 hOAOoy2mhUuTflyScniRBSJu3Lx0/QosykyAgjDEHQH2KDJJhnNm6tckVDim2UYTBq
	 CUn/R91nby6UcRpNXcub5SHAqgKJmGpzdfrpcaDyRBndP2ODXxulftFVazu/r2DTnv
	 fOXpyYsn1vDog==
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/2] arm64/fp: Fix missing invalidation when working with
 in memory FP state
Date: Wed, 30 Oct 2024 20:23:49 +0000
Message-Id: <20241030-arm64-fpsimd-foreign-flush-v1-0-bd7bd66905a2@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANaVImcC/x3MQQqEMAwAwK9IzgbaWgT9injo2lQDWiVBWZD+f
 cse5zIvKAmTwti8IPSw8pkrbNvAsoW8EnKsBmect6YzGOToPaZL+YiYTiFeM6b91g37wXYhOL/
 E4QM1uIQSf//5NJfyA/2/8d5sAAAA
X-Change-ID: 20241030-arm64-fpsimd-foreign-flush-6913aa24cd9b
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+yvwE337Qdag2rGuNvdsfIda3dNqnIov5peBktID6b0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIpvlHIiKxtAocRm8OBK6Yaj+uT1brtqrjz3czmlG
 kLb0yaGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyKb5QAKCRAk1otyXVSH0E5RB/
 4s5DbIvSqJpDZMrMzsulo88M4R3g/tC8Nk8ioDiV9SYLMmPwAIr4PYSvIxaIga3ck4r80tFkT/bOqb
 LpEP72Ya7iAsBesvmh6McFvsRdqZ4rXzvlGOIIi7vjdmDU0NaqmPAp0m2MMkEa0U1BfzPYSkEQCQRr
 Who3UZks5d0DNAaDLUhP0rkTzrk9Mwz752Ut1Ngku9AtrRkQS32mjdw6ECjfIDM/LzsqkmleCrmp59
 LLc+z7IaJxSNnSZF7opBj++RRFKN8SdJHjwi6hCzgObDSerHDWbDXfkQvVVW6MkpRNKFsO6TtH+d4a
 JLZ6ytDa3w9bcJnTFUmO/79Tdkq3IY
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Mark Rutland identified a repeated pattern where we update the in memory
floating point state for tasks but do not invalidate the tracking of the
last CPU that the task's state was loaded on, meaning that we can
incorrectly fail to load the state from memory due to the checking in
fpsimd_thread_switch().  When we change the in-memory state we need to
also invalidate the last CPU information so that the state is corretly
identified as needing to be reloaded from memory.

This series adds the missing invalidations.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (2):
      arm64/sve: Flush foreign register state in sve_init_regs()
      arm64/sme: Flush foreign register state in do_sme_acc()

 arch/arm64/kernel/fpsimd.c | 3 +++
 1 file changed, 3 insertions(+)
---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241030-arm64-fpsimd-foreign-flush-6913aa24cd9b

Best regards,
-- 
Mark Brown <broonie@kernel.org>


