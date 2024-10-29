Return-Path: <stable+bounces-89223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C6F9B4F11
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 17:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64C011F24EBA
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 16:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09611991CD;
	Tue, 29 Oct 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/+Zrme6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855631993B5;
	Tue, 29 Oct 2024 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218528; cv=none; b=JZ7PjufkMPX1mH6P0Z3oW+GYUS4a26+uRisLlF99PgzlVbC5ADF8zKXbc6nrOTpJ1bJL9nuDK46xQQbWrhLJ9dW9vDmLr6gXboRnT6eaRrTc1tLOtpDleCS5RdjJlQP1ZRWA+mEL3x0CA+jYEbrpDvwLmGOvAbUos8SXEgviRIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218528; c=relaxed/simple;
	bh=i9WM0s810nFXSxm0IvLGmYRKqPNMDw16wIj+exh5hto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eunk2pDDdr+5Cl/qJOHnbtOPBWYND6nWLA0F2S8qeKILxv6PTISkfBM1e+JRMnDdKZtuY8J7VyrnDTo2NlRMmV2xgpV6gCJIJKzDodS3yl3eSwaGQ10YXf001khd0sG8g/2E0vOzqVpUYMnrum6ALOHSzEEMMXOarK8TLOLSBJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/+Zrme6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24DA2C4CEE4;
	Tue, 29 Oct 2024 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730218528;
	bh=i9WM0s810nFXSxm0IvLGmYRKqPNMDw16wIj+exh5hto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b/+Zrme6lq1K/IkcOZ5fvRy8Lxiz/RQhLrmWdupPapsplmm40A7NZSSYjWLrDVcnF
	 /HEVieklcc/gIKMua3hOfZCAMpdyKeb0PlTJN5ve8GhcwG9yx+iMrnPgTQR8BT+g1Z
	 zSrYwuzy+07BgWrJ22Tzf/q45E8npT+Ob3L5b0+K7qCvZIg3ywJmCPGt9Q4lUdHSWl
	 K2IS3E9OI6MaWYjrRkf/VHIN+nVyY6SFvSwbiF7qXcfe4RynwR8yKS/J/Rq9hEJXwd
	 FSm2ZK+WAK9/CdcloXYX28GhSvZbfaVAAX7qPjOARBQOSM8raKi6gqZD0s6F7H7qWY
	 LG35ad6meUoKw==
From: Will Deacon <will@kernel.org>
To: Pratyush Brahma <quic_pbrahma@quicinc.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	joro@8bytes.org,
	jgg@ziepe.ca,
	jsnitsel@redhat.com,
	robdclark@chromium.org,
	quic_c_gdjako@quicinc.com,
	dmitry.baryshkov@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	quic_charante@quicinc.com,
	stable@vger.kernel.org,
	Prakash Gupta <quic_guptap@quicinc.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Defer probe of clients after smmu device bound
Date: Tue, 29 Oct 2024 16:15:13 +0000
Message-Id: <173021496151.4097715.14758035881649445798.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
References: <20241004090428.2035-1-quic_pbrahma@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 04 Oct 2024 14:34:28 +0530, Pratyush Brahma wrote:
> Null pointer dereference occurs due to a race between smmu
> driver probe and client driver probe, when of_dma_configure()
> for client is called after the iommu_device_register() for smmu driver
> probe has executed but before the driver_bound() for smmu driver
> has been called.
> 
> Following is how the race occurs:
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Defer probe of clients after smmu device bound
      https://git.kernel.org/will/c/229e6ee43d2a

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

