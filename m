Return-Path: <stable+bounces-83339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BCB99847C
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 13:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC5B1F21127
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FFA1C3F28;
	Thu, 10 Oct 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCaWecAc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4E1BFE12
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558386; cv=none; b=dCFQZ5VznsFVrcUMKK2L80xzpN755RS1y6mDA770+LUwspCQQ1gRA2kjbbMsRDWHuOHxKW8LZWDNtlfMBafwrKq66ZGYqdsg82pS8ewu7fCaJZW3zcwKxG1ZEGc7eKei8jiNCMxDztIaZ4yy4TBEbnhRc9t3ywxctIPr57ZP1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558386; c=relaxed/simple;
	bh=ZMwcJD454pk2ZkrgECKttjWN+aKe5Uz7EajItvMlugA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDGxkiWXnypyITnHAf59SFcrGNMaBQoOT8y67K3sv0a8w9nPDsa4dcY5OmzSs+hHNifP9Bru4CpE4NLyaexRQj+M4qNb7DFPbxIp5n3AqhGKjTiZHZb2OlsgZrTdmt81gnPqVsbv+LQgaynMS/d1CeRftzcr4Pw+c4IGF0YdRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCaWecAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1F2C4CEC6;
	Thu, 10 Oct 2024 11:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728558385;
	bh=ZMwcJD454pk2ZkrgECKttjWN+aKe5Uz7EajItvMlugA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCaWecAcICax7tU/Eo5not0FiGpinW6CrvpEA0nm0VzwerXXI2KNJ0oDDudWJ7A22
	 j6lNnS3vLC6INZXZC5t3Nv6rZeKuZPGr1dXrpBsmplpVOrFSnd3frcwHKY7g8t+vJB
	 Se3DmSAcPjC2OmohjvyVKekfeea3WcU1GLmJ/oj2GB2DRgWIyd2f0qLWitSP2oQFY+
	 GxAhcilT8fjMF4w8m8dMYhUz8u1q5mz7B2r7nhZCIpj8p2P9gNRj/QtP9ilX0oCck2
	 DGsRRflRwCiN4uEBsqz/1j/lSbkeID42uLw4SNiMiPmujwilqo9oz1BkedRPgO3qtj
	 UtlVZ8xMNTHnQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	catalin.marnias@arm.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/6] arm64: probes: fixes and cleanup
Date: Thu, 10 Oct 2024 12:06:17 +0100
Message-Id: <172848941572.620474.9652832732261228620.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241008155851.801546-1-mark.rutland@arm.com>
References: <20241008155851.801546-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 08 Oct 2024 16:58:45 +0100, Mark Rutland wrote:
> These patches address some issues I spotted while looking at kprobes and
> uprobes.
> 
> Patch 1 is the most pressing, as a uprobes user can trigger a kernel
> BUG(). Patches 2 and 3 fix latent endianness bugs which only manifest on
> big-endian kernels, and patchs 4-6 clean things up so that it's harder
> to get this wrong again in future.
> 
> [...]

Applied first three (fixes) to arm64 (for-next/fixes), thanks!

[1/6] arm64: probes: Remove broken LDR (literal) uprobe support
      https://git.kernel.org/arm64/c/acc450aa0709
[2/6] arm64: probes: Fix simulate_ldr*_literal()
      https://git.kernel.org/arm64/c/50f813e57601
[3/6] arm64: probes: Fix uprobes for big-endian kernels
      https://git.kernel.org/arm64/c/13f8f1e05f1d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

