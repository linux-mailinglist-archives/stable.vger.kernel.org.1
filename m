Return-Path: <stable+bounces-125765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A68A6C172
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A2E1898552
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7D22D7AD;
	Fri, 21 Mar 2025 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRrQv9Qm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D021DEFFC
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577999; cv=none; b=E/ThwGmgok4Ip3UxeWWpfAyqCIvW+ojzQQaRlsFo3RXbskJA4Z/ianzw1LN4lbQ41wyQMsqPvAmy+It5HoK5mYyOi7BDnH6uYI96SPSrqT4lb2I/IEqWgSCt3vITm110CkDAzPtzT+6+fRTFxN0Bpo3OPIdS5LpZBrQsGtIhz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577999; c=relaxed/simple;
	bh=GU4zbkXC2UTsMr2mIwg9W4sn2283fQEIzWPmN2LhaD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGJmoRTxyJm+uGNFfjvjdMDKZ+6WECK/LLr800Trj8Im5a+4FwHD+j0CrRtvLgo0gmhFf54effh6PNKpHaKvWBVr2qlDug8pCEqzYF4snXGxYLFPJc2h8ebmu1p5zdYkcp/Yrcz7yZnS4WKqqeGZQwv9AdHGpn0Pdc1M73qD2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRrQv9Qm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EA2C4CEE3;
	Fri, 21 Mar 2025 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742577999;
	bh=GU4zbkXC2UTsMr2mIwg9W4sn2283fQEIzWPmN2LhaD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gRrQv9QmH0CWJTxyFAcREYb3YDu+rIsxY0bk/X97ace5xMosS53kPBkOOKLEX+mrH
	 VeamrI8zeYcAkkngAYWqFP82Wx7y18CQRQJ2yqlVH+OWfbdzZJkjQLGO/cLD/xQeEX
	 1FJKJ8BXYhLBet9qFqkMQ2AgTVHhfPBLwV/KXdvvw1xu9X373P/F3nCYcQrMqvNhPr
	 /5OE0brl1nHywl4sR/S4PvH/v88/yUVM9V5h+j1gLbNe+XwXP9YZ9pQ1oQIDxC4l6V
	 hPzp4N9Nz1x/u+ZYl4jQZavlsaziAh6SpFFxuC//9rbPdfTYZC0MQzyL9Noqew6rtw
	 L3yCmztT9IvtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 5/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
Date: Fri, 21 Mar 2025 13:26:27 -0400
Message-Id: <20250321121411-450a78e04f3352a5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-6-v1-5-0b3a6a14ea53@kernel.org>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 407a99c4654e8ea65393f412c421a55cac539f5b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: bc7676732238)
6.12.y | Present (different SHA1: 203f00e1eaa5)

Note: The patch differs from the upstream commit:
---
1:  407a99c4654e8 < -:  ------------- KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
-:  ------------- > 1:  32f79779116dd KVM: arm64: Remove VHE host restore of CPACR_EL1.SMEN
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

