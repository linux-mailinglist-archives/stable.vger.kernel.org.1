Return-Path: <stable+bounces-164787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA6DB12764
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579EC5A2FFF
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBD1261585;
	Fri, 25 Jul 2025 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L006ly6b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247525F998
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485968; cv=none; b=AyPWAcZra6GXwA/QCBIjldDqiRRWD53DKNjE1YoTMtXgBhWUJw/kfr/aPn0ia4LqpScl3STcy0Z3MyXDxWCF4T8aelMoqOCmyj+0KiRoC/+0EyXTDr6D+PLGsac59hqa8Nmhj3htgE6tLx0YeftHbbRXupVvgQ6XckIOy+CKxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485968; c=relaxed/simple;
	bh=mT3rLcYwNGf4lgwPv9taIy1bH7YSK7fzancl5jreML8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUwHcZXkep/X9DawKuyloCMoXXcnGXyNl9KDUvjLrG5D/KpgQfm4OgFU4tJ/3b9LT+rdbfR3A7A+ABHlUZRd87QPhio13Tfc903eJ4tQxVSiuyqOaOFhCE5+KUhRYoHGEYhtRpFgyjP/Dl/GC44n1T0PZe4Rxn04QA66InyIKgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L006ly6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D0BC4CEE7;
	Fri, 25 Jul 2025 23:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485968;
	bh=mT3rLcYwNGf4lgwPv9taIy1bH7YSK7fzancl5jreML8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L006ly6bGGvrBULSykEBTEBFcXYUMAur8AqrMnkiV0+1qQJjOBxAPPJUgoECunbOV
	 tdy+W8YDk16SEdUM5/laHtBIubqfFORdF7bommDHW0icZd/jEIfVi+94rjYqsLkL9o
	 BG6ZTaxvH6BGYQ0/Pdq5ws6OwdTtQE6OXXSuLzHxBLmtSdB3oI0vGGu72uRtR5uw4B
	 fdeW6bdr+d4pqS7Gt0ICPhriTsIbnY7GlK69F01aJ+tktv7XFgY4DSyrKUlYgCC73j
	 RdTjaQgq9FJ7BSg+yQqtSRny5wpeZOlhnBvsB4tMZtB7bdW1zP3seo0XymIy9CT4H4
	 f9k0udUEk9FXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	abbotti@mev.co.uk
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
Date: Fri, 25 Jul 2025 19:26:06 -0400
Message-Id: <1753465192-da4c3231@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724182218.292203-1-abbotti@mev.co.uk>
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
❌ Build failures detected

The upstream commit SHA1 provided is correct: 08ae4b20f5e82101d77326ecab9089e110f224cc

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  08ae4b20f5e8 < -:  ------------ comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large
-:  ------------ > 1:  480e150b6535 comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.4.y        | Success     | Failed     |

Build Errors:
origin/linux-5.4.y:
    Build error: Building current HEAD with log output
    Build x86: exited with code 2
    Cleaning up worktrees...
    Cleaning up worktrees...
    Cleaning up worktrees...
    Cleaning up worktrees...


