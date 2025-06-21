Return-Path: <stable+bounces-155222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894D3AE2821
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 10:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1667817CEBD
	for <lists+stable@lfdr.de>; Sat, 21 Jun 2025 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D6E1E5718;
	Sat, 21 Jun 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1PwuX/M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D61DE2A0
	for <stable@vger.kernel.org>; Sat, 21 Jun 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750495935; cv=none; b=ZVDzOD6l8Qk4nPkpFlnqbzGWMLaM6F8xJ0hJxh0nS8CQaBWFCLkT9Js/ZaBLz55ABoTQwAwIcpQfGs5/LQpst65HXmEPa28NLvMBT5Bt5hrD2QX/+cL+wAusHpOy4BCUf9S/1UoJARZhGEq8EYQFbWHCwjNnUC880lvRRcTl/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750495935; c=relaxed/simple;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8TUaMMneJM7BD1nzT5FE5b/drff6Rg9wQ/7IZQvg3xY486OS+y21yBX1NN5wcnY9imP8oJHtWRktlT06v3vRhXuf4velfBLOxFVvh7GyfGLGO2ODX6qTyOS2RB6Md/sm1mZZlXsB0voBQEaHQ49dszHd3EtNLUoJpBkrMu3Omw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1PwuX/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72267C4CEE7;
	Sat, 21 Jun 2025 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750495934;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1PwuX/MgyErKJN9gfil5/IPlRVa+n/DtUCwWpjuc+OY5pzHQthG2zOQvtxgcayXD
	 q3GNhVEvf2s34S7lUf8p3+MJPohMbqQZnrG3KM1lMvM8/BaakSMLzQxdAVQ66Q2k4/
	 Ho8ey1FWpPTtM6dKrAzZJPMIPolZR930+/S572sJfUw9Z0guaTPRFl+E93Lu2yS/S4
	 FGfipzOQ2Ul/dI2dzGh4hYWIJu4XvRk89hbyOpH8O0QtvQoBdNa/my4icBMK6UJLTq
	 NaxyJxWzNPgmfMTC1VoMetxnIVVAVonCCooTFpqPyEKTMiBt/SAxSgRBfzEM3THeoP
	 X2npF79U6EmdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	leitao@debian.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable] Revert "x86/bugs: Make spectre user default depend on MITIGATION_SPECTRE_V2" on v6.6 and older
Date: Sat, 21 Jun 2025 04:52:13 -0400
Message-Id: <20250621011727-37e866318e6f1904@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250620-stable_revert_66-v1-1-841800dd2c68@debian.org>
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
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

