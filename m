Return-Path: <stable+bounces-61394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385BC93C23E
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DC01C20D96
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52849199EBE;
	Thu, 25 Jul 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQyG8H8k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ADF26281
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911390; cv=none; b=FvOMvpp4WKZNj3aFaTWzL2hOz/vfT7V5jlHQJb55Y3WglvFSTJxD6fzJ5niWPKmwolBmziKy1y2tuutQ/4vbJs64m19fL44NHrCt7FxjH2UmL1DGy+DUrgFPzm/ZOWZCCkcghJiJGqEpJei4Qz2sdfdI8T4YP2z82lHTIazMgac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911390; c=relaxed/simple;
	bh=JeI4DQ9YoM8V7YYCXQrDN8/023QOt7/fH91jyaS5oak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jI07Ucq3qJOpLnck7xA4Pt1g8Ja67MM8A8WjMrux2NiWDWiYW4C8a+k2lv575m2KeRKBnskf5BscA9Dv3kumVivJEnyQtoepSZEkRhx+wdo6c4ZZrJkCcYWHH1NdIRdKM4lh6tOF2x/h6bFhGezffrZEbJKEOBJVLaJzNhN8slU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQyG8H8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0C9C4AF0B;
	Thu, 25 Jul 2024 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721911389;
	bh=JeI4DQ9YoM8V7YYCXQrDN8/023QOt7/fH91jyaS5oak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQyG8H8krsHT94wY1Pt8D7oDACLmhwz3JziX3v5NaJYPzUWelLfBvCeP9PtPuu6aD
	 N2t34TmBvnHqjeoXTzlpf335SpeuUNFB39GuTEUbwFCCdotA5zr9NHfQoKTqHTDnPR
	 Qtnok9XaMxBGCGXjy9+hQeX7nw6jiZ/C8V5dVkDnCBmDWlbx7CkYmhALF0nXn1bO+I
	 CKWc+qL3NqgkgJ7oIJrLoyErPeDHBnrLFx3xIPAoQ12FAUj5aHGUwrmLT3DL0wpDS6
	 WE/U+DFTinfN0TmbMhYrgwgChpZrFn7FWSvaop3Vj3Rm5TUy20jRiI//DFODhsAbMy
	 Zhsg6Bv1RZ+zQ==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Will Deacon <will@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH] arm64: mm: Fix lockless walks with static and dynamic page-table folding
Date: Thu, 25 Jul 2024 13:43:00 +0100
Message-Id: <172191005619.4039653.10092210051964314188.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240725090345.28461-1-will@kernel.org>
References: <20240725090345.28461-1-will@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 25 Jul 2024 10:03:45 +0100, Will Deacon wrote:
> Lina reports random oopsen originating from the fast GUP code when
> 16K pages are used with 4-level page-tables, the fourth level being
> folded at runtime due to lack of LPA2.
> 
> In this configuration, the generic implementation of
> p4d_offset_lockless() will return a 'p4d_t *' corresponding to the
> 'pgd_t' allocated on the stack of the caller, gup_fast_pgd_range().
> This is normally fine, but when the fourth level of page-table is folded
> at runtime, pud_offset_lockless() will offset from the address of the
> 'p4d_t' to calculate the address of the PUD in the same page-table page.
> This results in a stray stack read when the 'p4d_t' has been allocated
> on the stack and can send the walker into the weeds.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: mm: Fix lockless walks with static and dynamic page-table folding
      https://git.kernel.org/arm64/c/36639013b346

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

