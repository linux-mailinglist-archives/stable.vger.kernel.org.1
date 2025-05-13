Return-Path: <stable+bounces-144233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40779AB5CB6
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A93865125
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3F92BEC3F;
	Tue, 13 May 2025 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghJbsHne"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677CB1B3950
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162159; cv=none; b=orGxRZkVRw8SbgjbDsi7XCUbn/9TmrqGr9itWKtE4XWI9RbWi6r8SKm2JgNh52sVWnY5Hh6g5HZMrYD/hIOzRDpsj0NiG9TGw5mo6ZUcuu/uaYxwZVOlnAvtzUzGHlimZDu4iYztvJMcxcRThjCC4eBqTTPDS7w2nrf1hYfvKrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162159; c=relaxed/simple;
	bh=VZIurN3D/1iQD2YQGIjlLIc2KcDDbU+y7Mc15ZcEszQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3KM6JafuKO6nKtRWx1EemqS9H7I5amebyFJnV03qvGUJy6EC4TZB4JK4N4/+vVt3NjBwLbsvmsCo7wo8oDH0/6Q2l3v4MW6N5flogar6CkQXoV0M4VSaXIDWnHpzqsINo6rLCSpe/fFbpjJ3yuM3aTPoilpOTZUSEDn9mShQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghJbsHne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D79C4CEE4;
	Tue, 13 May 2025 18:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162157;
	bh=VZIurN3D/1iQD2YQGIjlLIc2KcDDbU+y7Mc15ZcEszQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghJbsHne6tugZErS7UJQx8ByU+rv9Aoc0eJc7DPUCXsoybC75meeA6wnwusPZhcqM
	 40LASfsbXfwOACLhfYz3J04pkKepfcCUIA1jkZBFaF/LD1ACmTC3DJUsbpVZ2rJwFK
	 3IMtoOxEDda2QQ6fZDGPhpw0rcjB3m1N6bL9ht3oq0QM1iJNFJWCB/Qeo5zfRdw2Wb
	 kHh8fLKgICJMfrj03Vo29Zj4I/rTdrNPHEYfg94vwRPa5Pddqm+wIU/8noZaUrqnsx
	 EUFkiZ+0Ndeg3OgS6NScgoRj8aUcsaql2sYdjPtRbtI6L1tDA+p9VSsYQt/D2halHq
	 RE4879IWjvmIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aditya Garg <gargaditya08@live.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 1/2] Input: synaptics - enable SMBus for HP Elitebook 850 G1
Date: Tue, 13 May 2025 14:49:13 -0400
Message-Id: <20250513094026-e79c0376e6e9b96c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <PN3PR01MB9597BAE0F2CA6845408AAD36B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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

The upstream commit SHA1 provided is correct: f04f03d3e99bc8f89b6af5debf07ff67d961bc23

WARNING: Author mismatch between patch and upstream commit:
Backport author: Aditya Garg<gargaditya08@live.com>
Commit author: Dmitry Torokhov<dmitry.torokhov@gmail.com>

Note: The patch differs from the upstream commit:
---
1:  f04f03d3e99bc < -:  ------------- Input: synaptics - enable SMBus for HP Elitebook 850 G1
-:  ------------- > 1:  e2d3e1fdb5301 Linux 6.14.6
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

