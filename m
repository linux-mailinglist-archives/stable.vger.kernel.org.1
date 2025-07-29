Return-Path: <stable+bounces-165124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29464B153A2
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D830542D76
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 19:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2431325484D;
	Tue, 29 Jul 2025 19:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zohgxlzt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70CB294A1B
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817850; cv=none; b=Vt6I22jHBSHdKzFoquDad1iQcqKWt3tL0+UnngYjp5QDGTND2P5W7b/AhevN7duj89hC2yasHygXCWIV6Qdl/QxFuOOkWRddguGiIsjFqRG8FNno5Cx4sXNKlzw0/gS4OLSc60hvq6cl7d4tGsmdDZ5eSGxa+LY7DbJjyn8bA5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817850; c=relaxed/simple;
	bh=gIVoc/Gh1WvSBk6tBwEL4EcdjtpeKvkbHitmNicllfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+qQcryYFkoKD0sPIaN3oX/3SHQLqrL8iJNeI6ahHVY0o8yT8YuqeX7nyn8ovVtdOUr07ll087cu/75yQDIYnzaFl0TUAf9G+IA7tP2YMU6FVm7PMR2wiEgHztmomSy74SQ8N2xBJIlO+DZ0fnzQwEIkLKFhTOi7ExXHb8KoV+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zohgxlzt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC14C4CEF6;
	Tue, 29 Jul 2025 19:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753817848;
	bh=gIVoc/Gh1WvSBk6tBwEL4EcdjtpeKvkbHitmNicllfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zohgxlzt/TQVRC9aPkPOydp8LYh5O3qYrX2FiRP/FCxDfDPOEgijYCg6HLwF1b2CI
	 t6QADBEQHqB8Q9rpAW01nuAg8V/iooJCiGybrcZlQ19uL3Y2qL608WrRz6HiinzNP2
	 Aat7bi5lWFsOgj+oxTwyNv8T/n0MdfZQ3LPfK0X/UNGBqJ79J7N3pwPezCCakFD5I0
	 //ll07OtEccf8vZk3HZgWD6lQiOiknLi1Foh8e/k4EyiaEZ2YoIw4kDV7UBr2cOjeF
	 ShLJrMS2szLBfeVpKsxEmNoY5tXtr8crbZ1hQYUCKcJjndp8K5YbOsEaw09TqnpfIM
	 AAtbOnd+xjOpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shung-hsi.yu@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 1/1] Revert "selftests/bpf: Add a cgroup prog bpf_get_ns_current_pid_tgid() test"
Date: Tue, 29 Jul 2025 15:37:25 -0400
Message-Id: <1753811514-0a6263d5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729053652.73667-1-shung-hsi.yu@suse.com>
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
| 6.6                       | Success     | Success    |

