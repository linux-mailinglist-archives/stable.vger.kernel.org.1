Return-Path: <stable+bounces-98831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9259E58C0
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E901284C9B
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1921A437;
	Thu,  5 Dec 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+lCGSp/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653C21A421
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409928; cv=none; b=DxrcIqKRODc2sGrA06iEZWaYxqnhbUBcj/MDInBQUwyGrf9kBnjF5PIvS+1DVyx8Wg2DL+mFhi3bKwNOGILtlkVTV0MaB9It3PSqFoYTdTkCrmTjNHHDyI4r+8ayMYuhxxvFYXkyXwiEA2Z6pJU+wfEUW9iiVWTDLxf61wOZDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409928; c=relaxed/simple;
	bh=/Z3rLvKKBrxJ0XaBzhdSMpXdBEdmSKhMjppROL2Kxmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBudnGvhcnOUriFwUdekIsAZIMf3nV4pyyrEyVWB4JpbJCNPe7zPFLCZfJ7366I98qZFm1u46Q4WbQDkO4Y7OK1TFBQpsw2c5BEe1p2bPUbKpxasHRMpCBahlDb663AU2p6gHPqqs19AFGWlzIkqliRASOWWMU+7cJleWrF3ByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+lCGSp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92122C4CED1;
	Thu,  5 Dec 2024 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409928;
	bh=/Z3rLvKKBrxJ0XaBzhdSMpXdBEdmSKhMjppROL2Kxmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+lCGSp/2rXdunTzV/SFu5EtEWfh4hvtrYw+buzvXLIpg8K+Wozssydu0Dd9AV425
	 hsM0riWbwsZuDURsKTdArDx2cgY4LWXOrf4VW9BixPrENKRDhReT/DK3wGxd2yKQEJ
	 kn178tfVZBcISCTjjcP9MUJd50uVCB4O3L2ihlgom/vrCreqbgim32gMNa3BkRdtRd
	 YWvN90Nrwxu4yoC8KLBSdJ7JXVbXedb/qim8Quhg2wWKgWXfEhpsvpuGJQKtGAlFiT
	 YygYpjLIArPITUTQMTkOtEbqjdHO8WymR5qRRx4nlOKg0ulzQdBDBhKnIuYBSaGYfi
	 P9bO091pboi8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] ALSA: usb-audio: Fix out of bounds reads when finding clock sources
Date: Thu,  5 Dec 2024 08:34:08 -0500
Message-ID: <20241205065732-e7e6763aef9f6e97@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241205092925.922510-1-bsevens@google.com>
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

Found matching upstream commit: a3dd4d63eeb452cfb064a13862fb376ab108f6a6

WARNING: Author mismatch between patch and found commit:
Backport author: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>
Commit author: Takashi Iwai <tiwai@suse.de>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 164800d08b1a)
6.11.y | Present (different SHA1: 827fb529653f)
6.6.y | Present (different SHA1: e257c95fc2e3)
6.1.y | Present (different SHA1: 88bbac17b356)
5.15.y | Present (different SHA1: a53c8f496d27)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a3dd4d63eeb45 < -:  ------------- ALSA: usb-audio: Fix out of bounds reads when finding clock sources
-:  ------------- > 1:  ffc4b5492cccd ALSA: usb-audio: Fix out of bounds reads when finding clock sources
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

