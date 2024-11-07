Return-Path: <stable+bounces-91807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E091A9C0585
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C436B21172
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0431F473B;
	Thu,  7 Nov 2024 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNwjWDsM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2EA1DEFDC
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981977; cv=none; b=TFsWSsRpKkBvWZaN0l+V3/aTcsEZ4b1njbETdO8LuVx1sT+j5rn1sMJvhsyVFpw91r28CkHX3vIg02aYroF6FVDivVnmn0DkP19GzwT8pLbAdP5dRADvbiWUJcKXck4a00gtnMR5eMv9EPd+AVFrlRzgGuouOq61eWxlzNMQUW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981977; c=relaxed/simple;
	bh=tav3DE8VF7Wjy7Gk/JzYApcdv4trAn29ouTnbJqTPLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftWWLxx23Wuqio4I31hkAWe/slomBkJfy+ckWt7uX3FUoGCG2JWLlV+QslISSKSHW3eHrnFQpR/jGt1Usf6rQ4D0bsYhIvOSLDLfw3yOC9vF/GCwXltIF1RYUw/ueYI4JZj2jo5lm0AzZId8hD86iuFd6pfYqNza4a3uXJ/QJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNwjWDsM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7012AC4CED2;
	Thu,  7 Nov 2024 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730981976;
	bh=tav3DE8VF7Wjy7Gk/JzYApcdv4trAn29ouTnbJqTPLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QNwjWDsMxKqC2wtuI4g5vPLzTxnO9zxmi39YyuQooFeTMLUz1pgbjdibszg8zo2bb
	 f9BYJpwchESIlO0B6vZ3XReuuiW/2kp1S1NesZemLeW0QVOjo5FimxWftcKyNhZ8L+
	 eE6yR13OIAOzfQ4cMhwg1LH10vAxLrrTaMy/KZtMCFkm0kup4LzOdgYqXk9xVHMOX3
	 6R2YCrCh8D9HtWC5muI2NdNuZWccLXSRD0hCzBbRjWI+q4gqdJAinjipd08/A/wK5k
	 2OUsjMzXYy+2KeTaUr2rG5eqyabFm81icdD3uHoIe39DSNNghgZXPvmlfhRUTiX+cB
	 WL+FGOVrL5xcQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ardb@kernel.org,
	broonie@kernel.org,
	maz@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
Date: Thu,  7 Nov 2024 12:19:28 +0000
Message-Id: <173097833407.164112.5523983482147040653.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241106160448.2712997-1-mark.rutland@arm.com>
References: <20241106160448.2712997-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 06 Nov 2024 16:04:48 +0000, Mark Rutland wrote:
> SMCCCv1.3 added a hint bit which callers can set in an SMCCC function ID
> (AKA "FID") to indicate that it is acceptable for the SMCCC
> implementation to discard SVE and/or SME state over a specific SMCCC
> call. The kernel support for using this hint is broken and SMCCC calls
> may clobber the SVE and/or SME state of arbitrary tasks, though FPSIMD
> state is unaffected.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: smccc: Remove broken support for SMCCCv1.3 SVE discard hint
      https://git.kernel.org/arm64/c/8c462d56487e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

