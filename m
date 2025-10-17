Return-Path: <stable+bounces-187681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B36EBEB112
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 19:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BF524E413D
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDE3306486;
	Fri, 17 Oct 2025 17:29:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A337E305E2D
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722157; cv=none; b=k3TDdXmRVESexOC1/XIvnLrLFE1IBNrZO9xHTMHHMuJS9e08JTej5sqJHD5ZTFjMs3Ogpob3M35C+aK+ceOJM+Cv/o4UXhCz0uOtdKDCdXavOdTxOr0IARGUzz6DXT8TorV8OgvLm2UNONVcMbD+EMpgCyRuVPD8Ege3c4ISD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722157; c=relaxed/simple;
	bh=d/gsrwGbUjXm4F9ncPTS8pbD96FdvFYctQZW4AJOBnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrJ0x/+KUyP/EEivbKBxLqTIPiXmn7zWuKlGPo3kuBCLv9b8RExOJVBKNWE5d9MomEwXzcrsQsLWT358dM9EqRSyhXvUJg3YGshYdyO4uIWViCzGY6+UPmusEvbxjGHPFBdG7LYahr3l5929VswXVBzMIjCIhKwD8SNKoJEPkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0F8C4CEE7;
	Fri, 17 Oct 2025 17:29:15 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: debug: always unmask interrupts in el0_softstp()
Date: Fri, 17 Oct 2025 18:28:37 +0100
Message-ID: <176072211693.2071457.12794183998113158672.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014092536.18831-1-ada.coupriediaz@arm.com>
References: <20251013174317.74791-1-ada.coupriediaz@arm.com> <20251014092536.18831-1-ada.coupriediaz@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 14 Oct 2025 10:25:36 +0100, Ada Couprie Diaz wrote:
> EL0 exception handlers should always call `exit_to_user_mode()` with
> interrupts unmasked.
> When handling a completed single-step, we skip the if block and
> `local_daif_restore(DAIF_PROCCTX)` never gets called,
> which ends up calling `exit_to_user_mode()` with interrupts masked.
> 
> This is broken if pNMI is in use, as `do_notify_resume()` will try
> to enable interrupts, but `local_irq_enable()` will only change the PMR,
> leaving interrupts masked via DAIF.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks! I used Mark's commit log.

[1/1] arm64: debug: always unmask interrupts in el0_softstp()
      https://git.kernel.org/arm64/c/ea0d55ae4b32

-- 
Catalin


