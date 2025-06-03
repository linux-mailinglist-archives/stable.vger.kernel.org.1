Return-Path: <stable+bounces-150749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569B4ACCD21
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E33A6723
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A531E7C10;
	Tue,  3 Jun 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umPCLgCu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8210BA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975755; cv=none; b=kTzAIqCLuZbHSYWcg9mtm5bnubHEq3MDkCAcv1/6S01z8lW9Y/A/KaboMLaOfeTLZ3KAOjPrqqsDuW7rogp6MnpyDAvPndltD6Ebr0z7XsQGM3Zbr94vfGCtTiRZIaHCK+3t5zdmGtlHukK5cmWVhjrgx8B9Gs5v1Zl8WOpV94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975755; c=relaxed/simple;
	bh=0q4B5V8F198wr9krIjrsVnYDX8T2hg/0cum/cW/F06k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIzg08/iO0TWwHNIVBgehpOm+bl2MNMyZokZ0ivNf9GP/A5OJ113QzzFIjYDDnQ97xcpA9cpgyJyDJQA1v2Gmx0q3y/Aajhl/5fXU5Hqrft4HS0zNtKn8HepRXPsc+7Fr4pbDLA33AEnWbOVBsZuw7+3MCqH00junHhIHhWoDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umPCLgCu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA2DC4CEED;
	Tue,  3 Jun 2025 18:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975755;
	bh=0q4B5V8F198wr9krIjrsVnYDX8T2hg/0cum/cW/F06k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umPCLgCuDGYwoSy8ly+vJ6kQbO58iVXKFhYaHtPnI0kFqLcj8YgXIcm32iDMOXuT6
	 i6GaliPiWduq0gCT+4XBKxscNcY1uhWQfs5Y8iqB0jBUHNveRMxXnDxPrlQlMdd9aF
	 UOXxFHfb+w50j1JeEAFULVAB6mKMOfUYNzTU+kZtc5QcHfgEQreUooqos1UqsITQmk
	 fBQisqqG+KIjj5OxfNnLU5NhbdktXiAO0EGJtLqNn9K5BMtmeUn8UGWE0P1jbkbA+6
	 St3qCTaGPindBDlV5E8raAkMf4GuFPH4/wxd7KHVjNO8tjQzZWUswLPdFxyaEyVGQ9
	 ZljDivS5tnm9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jm@ti.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
Date: Tue,  3 Jun 2025 14:35:53 -0400
Message-Id: <20250603135927-abc85ac94b23d237@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250602223132.87435-1-jm@ti.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: f55c9f087cc2e2252d44ffd9d58def2066fc176e

Status in newer kernel trees:
6.15.y | Present (different SHA1: 4f35dcb075c0)
6.14.y | Present (different SHA1: 4a4594de75b5)
6.12.y | Present (different SHA1: 084b88703921)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f55c9f087cc2e < -:  ------------- arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
-:  ------------- > 1:  3d44ad8924530 arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

