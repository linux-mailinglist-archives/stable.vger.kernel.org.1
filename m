Return-Path: <stable+bounces-86380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF899F6B2
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 21:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E00C287AAC
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 19:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5BD1F76AB;
	Tue, 15 Oct 2024 19:00:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA61F5849
	for <stable@vger.kernel.org>; Tue, 15 Oct 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018812; cv=none; b=QW/jNoUQXBgNnw+C+CYiLUiepY9kuS1I8gPOiv8a89hp04K/Kc+//1iJhPKCE4IWd5Shl50GsLKDCsjLMZ97ULeMqfHW76Ib7Ajhc4dXoI6VexYm5r+/z9LgxCgZX0zj/b0RK3ZUqEudpyZKDBA6TEhSGy+rtmS6URPv1AXPHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018812; c=relaxed/simple;
	bh=woT8qcFngC8AijBbaJeyhl9A5ehwUZCggR+svTaXmFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZhE40ZACQfnxwCsofi5RC/f1JqCQmNHAZ4pX5YClFfh+znfvp3uWDVtihN+C6Ncjct0/YpNb+X+4FO5kZlH9ZhzUpk/s9bMy6XpRrv9S7vV4U2zZuLo42rJ2d3UDmKIdbv+lcIPe/lRUNOIS1x6B4bdmy3oFZTZbOID7t8HBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC0DC4CEC6;
	Tue, 15 Oct 2024 19:00:10 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>,
	catalin.marnias@arm.com,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH 0/6] arm64: probes: fixes and cleanup
Date: Tue, 15 Oct 2024 20:00:08 +0100
Message-Id: <172901867520.2735310.14810844137002647016.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
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

Applied to arm64 (for-next/probes), thanks! The branch also contains the
first three patches in the series from arm64 for-next/fixes.

[4/6] arm64: probes: Move kprobes-specific fields
      https://git.kernel.org/arm64/c/6105c5d46d0b
[5/6] arm64: probes: Cleanup kprobes endianness conversions
      https://git.kernel.org/arm64/c/dd0eb50e7c71
[6/6] arm64: probes: Remove probe_opcode_t
      https://git.kernel.org/arm64/c/14762109de02

-- 
Catalin


