Return-Path: <stable+bounces-96050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A33EE9E04FE
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 15:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA09B3D235
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F3205ABF;
	Mon,  2 Dec 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+3wkgoH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41B82040A8
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149606; cv=none; b=PVAWz5z1GI3GT17iQ4vJvbMdV+yzUB5QzVdZSb7j0oXZXifGerWsfCh80N4VjuWNzWv8p9qrOHLQl6PWfpXTCTBO/qITm07FXSZx8MXyiFhigQStWOgLqsuZBeNXeSFwZ3LgWuSPinykbnZTKLlby/Lk17Mv+owHb8zZaf4rTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149606; c=relaxed/simple;
	bh=Wq1Ula5OQhj7L8dX1dTOj+yoAd3qGUzFYYO2J3yGmkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6ub43dz/2wOhTxDNsrS/shocITd1uXtp+CxK99C8nvlZny1tRv4YUXUWPHPgl/dtRuuswtbsCyoYij7nxRCDCC074Rp4ZyFTQ8YHDqA6USNqZMeHrZur78UrRNHcUmUR/zVfPLDZHVfgElSbd/1ngNglrr4CKD8LJXpYC9eylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+3wkgoH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7C1C4CED1;
	Mon,  2 Dec 2024 14:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149606;
	bh=Wq1Ula5OQhj7L8dX1dTOj+yoAd3qGUzFYYO2J3yGmkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+3wkgoHoo5v/qm81ExSYoY9WeTk8FySnZzz5/S5D34SfH6+PEYVJhR+n4LHuLKa+
	 oDSo5YC5WXyZF3cP4Qn3OC/9JOkVrPgqwAg/9U/uzTqtF8u+VmPnGu17ywLeEpjPXn
	 C3ZsHTG+8gC8AL7/DvTHIeZwOX2lP9ckmo+3978GWmuqg+9mvR5p58w34s66EPj/5Z
	 0ceWk+SjB3UL1eHpiJlII7MxdkUCFjTcgo5JESEUbxFg7wIcC88cpoBj1jgqtxA1P2
	 ntBFACaBIA6Cvc2GBuZ7uKw+jhvUCjVoUnK+pE3R3fB2DBh9IDyTQ709w3BzkdYPHP
	 kZiOOiz0wF+zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 1/3] dt-bindings: net: fec: add pps channel property
Date: Mon,  2 Dec 2024 09:26:44 -0500
Message-ID: <20241202075917-cfa0a5cfc0edf7bf@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202110000.3454508-2-csokas.bence@prolan.hu>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 1aa772be0444a2bd06957f6d31865e80e6ae4244

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1aa772be0444a = 1:  be7b289f4b046 dt-bindings: net: fec: add pps channel property
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

