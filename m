Return-Path: <stable+bounces-52098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42676907C9B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 21:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2601F21F3C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9258514D29A;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvLMgEjN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9A13791F;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307005; cv=none; b=VoAQQs5O9dHeI6lDpGQuNyXfmg5OB7i0GjrXwzAS8b0YmOQTGMMb+Yl0XJD7C9Gpr+gB//+HaoKPVTG+YlBTl50P3W9UQax9XAGZNReAB4C7vg9nSTkg7r2bpk9r88Kr/Ceyx+pxe1CPcoqCwLV0hhTMAkxR7SWmOG5gRXkPVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307005; c=relaxed/simple;
	bh=kVxt7q6qSBJNpz37zpAlA50Me+Di16dbWYYrG1BOi4Y=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eaJQQboP+OjK0fEY/biEM74U1F7qO3f2Mo30sB0iSftM1VKG8JsBFkOtdZ6ZTdIAFNVxvvS42ynGUlWIpDd8IEpH98h7kn86eqEaY3BE5wKyHcZd9pI6Q4uD7ACEX0B/W4OWdM2TrGnPW62cvoQrkqHeosV5KZs0Jy+8zdwTJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvLMgEjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BC0CC2BBFC;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718307005;
	bh=kVxt7q6qSBJNpz37zpAlA50Me+Di16dbWYYrG1BOi4Y=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AvLMgEjNUKf+juzSw15h4da5hUIZCRkbpgEJkgtWNzSabG/ZfKMrlK2nsgtlE7Dbi
	 TIxDJmUCAiIiOofG3BSoqNZcgzmTRc2ctFQm5a5AVMMgK2rusVltDY1FyGL9Kkuxxg
	 zB7lLTvEP9fpjacDYWeJ+UtIQY8ANdf/aKABBsNBw/jdf7zawdakrX6hSRlUBWKIk7
	 M3mqb10n9q9cMfLgORhaEARfofBpAqetWr+1sQeZMUnMGFMATF1qhvZCvXdFuFFH36
	 CHRmmIbZ7Cmku/3IM5Mi1KUO9XY8j/84PWK+fX0IEKVpQJErQoBfOW2QZUYVTBvH6J
	 gDQO8If++u/Fg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1426CC43612;
	Thu, 13 Jun 2024 19:30:05 +0000 (UTC)
Subject: Re: [GIT PULL] memblock:fix validation of NUMA coverage
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zmr9oBecxdufMTeP@kernel.org>
References: <Zmr9oBecxdufMTeP@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zmr9oBecxdufMTeP@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock refs/heads/master
X-PR-Tracked-Commit-Id: 3ac36aa7307363b7247ccb6f6a804e11496b2b36
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3572597ca844f625a3c9ba629ed0872b64c16179
Message-Id: <171830700505.20849.16920899447397395682.pr-tracker-bot@kernel.org>
Date: Thu, 13 Jun 2024 19:30:05 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>, Mike Rapoport <rppt@kernel.org>, Narasimhan V <Narasimhan.V@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 13 Jun 2024 17:09:36 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3572597ca844f625a3c9ba629ed0872b64c16179

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

