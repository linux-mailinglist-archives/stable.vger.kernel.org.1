Return-Path: <stable+bounces-98829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23589E58BD
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD3E16C441
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B663218AD3;
	Thu,  5 Dec 2024 14:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXoQzAh/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7842185BF
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409924; cv=none; b=r8grJwD7QD3I2I/qL24/kRj60X8Gu/7UvmSwfZTEBW7VEBvi+Na952yYVgDOBDMCRNgZ2apVRdZPtWutjvpRxB+zfqOSiYXN6tXaaIM1c0yiEqSJ1D/tDbMOURayVSPUrK+w637nOI1JLVOGHpZTXS6yYFkBInxmz7sa34DGNF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409924; c=relaxed/simple;
	bh=QX0uvZ/XwfpJNYrhuuxZQrEiYyxYWRWDhtfd7p/LCr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9OU2EfO8whunPPL2/B8rtUjJWNG8GI27Ov6IG5a/YAuuLbmZZjIuseTT0TYkcHUYYEdrdoXpGskrCi3dsH1QzhjZSG/iWPag1mSxhBu0DRHLN3WFUlpVUvjNlP3SzzlSrNmDcTjaV0B/nB3XqzQcl96+D0gFIqnSaMq/1qufCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXoQzAh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEBCC4CED1;
	Thu,  5 Dec 2024 14:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733409923;
	bh=QX0uvZ/XwfpJNYrhuuxZQrEiYyxYWRWDhtfd7p/LCr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXoQzAh/R1ilw5JnDqaUcFv0Z01Nmi/zbElpcL5CVWpclArgy1MpLtcN+NkcT0qTb
	 nwWVeG93l/8FxrPn9dU0wda3+onBKByrsqk2DgRMEF1KcG9jutyMncj4upqVDgGB3A
	 Ptl2C2s+1DIrJlmTc7hbi8CUS0aDcvOOqXrDXCJmyYuC3f2NmfVbTydfba3tXLEnUL
	 0TSKRkUs0kzA8aEMTUcaUkW0veazj8aIsQbfE9bSVWyAdJs+Jyi4K79bQWlN/9zhI1
	 f9oeJ/Zyuzr+yQXiggITB1u9MHowyvfKQ5r4bkW4QIZmTM9S3dhMxGW24IMl6VAO02
	 eWMHWWctC3Tyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Beno=C3=AEt=20Sevens?=" <bsevens@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.10.y] ALSA: usb-audio: Fix out of bounds reads when finding clock sources
Date: Thu,  5 Dec 2024 08:34:04 -0500
Message-ID: <20241205083141-0cc6866de638de36@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241205130758.981732-1-bsevens@google.com>
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
-:  ------------- > 1:  da041121a6262 ALSA: usb-audio: Fix out of bounds reads when finding clock sources
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

