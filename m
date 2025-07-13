Return-Path: <stable+bounces-161762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65EB03110
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C027A8F4F
	for <lists+stable@lfdr.de>; Sun, 13 Jul 2025 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E98A27702C;
	Sun, 13 Jul 2025 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my0fjZQ0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCBA6FC3
	for <stable@vger.kernel.org>; Sun, 13 Jul 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752411968; cv=none; b=eX3OKEwX65w3JWFyRSOsez+bDoWpmzlU78LMp/9ylzvytuIJaAWqUQHCwpdWadyI3h4RN5q4IVteW7yUm+Lf+8iHs7yrI/xjYCz2E+uSfJFB98/orz/4XKgPwdr8oEN9qcPoEgmC/CH4lrVF7TXzgf4xhOtPZuVoMIrkoE5+SKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752411968; c=relaxed/simple;
	bh=z7JeVj6sVv6OUcBIOL+N7sL67T/GTcIjF7ZndPaAOEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tahfPLpALx6wofUhAF1Ka86zJEvS4ISHOHSQKsaRn1tvn34+0q0es2XhiN6KPgDiZMpR2QX5bdwrC6GhNxKS6bbEogOFQFQKVco9BKnHq+c7FOKMe353GJV/l0r5Yhcqc5HhXM00+jmCiunBQQeqRnAdLMOenVxRxvjYqSEj9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my0fjZQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C18C4CEE3;
	Sun, 13 Jul 2025 13:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752411967;
	bh=z7JeVj6sVv6OUcBIOL+N7sL67T/GTcIjF7ZndPaAOEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=my0fjZQ0Z7vIBCeWsTAXUc+ZJiBV47+dalZUZNEeH8N9PmeRYOjBZiNiIQfapTB8h
	 xdEEwq2H57yPGUoDgvlDKFv0rXyJz8+mIRyKmbztTzKKurEhXFEQFqXbtvSdEYVS4u
	 y+6xveLhfDUH6AnAbaOEiDRSZBoemkNRk2N6jBFtlkZKByD1BkD4/xtsPGj4oz22vU
	 QeNqWOsCGcW1q4kMQVrsm7EQnhCZy0cHalpNdUMHd8hR9kL1Qt6bopACnPAyVtylXM
	 Qe5YdX1xiSLk539+u2TymQNVXd6Iu8W4qt3Vrgybxw/DNLx8pF0q7FAGeh7kC4rDDV
	 7FRDUo7vPNopw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bp@alien8.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15-stable] x86/CPU/AMD: Properly check the TSA microcode
Date: Sun, 13 Jul 2025 09:06:05 -0400
Message-Id: <20250712211157-88bc729ab524b77b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250711194558.GLaHFp9kw1s5dSmBUa@fat_crate.local>
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
| stable/linux-5.15.y       |  Success    |  Success   |

