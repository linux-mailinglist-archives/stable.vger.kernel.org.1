Return-Path: <stable+bounces-143822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C52AB41CB
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DE3019E815C
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F629B79C;
	Mon, 12 May 2025 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+dfSYdf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9829B796
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073095; cv=none; b=eOU7uO4u+98n2g4J7qmuyO+plTcmR0jmWIP7BltvtihNa4E2lts0QMahLsE9usYpdzfh8HY7UJPScwTCW1Y3bCLc35PZkA6POgpLiR6/sD0ASCpFyBb+WJiJHMUEvbQ1XGmNK05JnUFU807DfevYQObdH9JJRevh0jg9ihs+WBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073095; c=relaxed/simple;
	bh=Y/UwDHOzgo7mvKL2TTsdVqmNE9hLk7gv5x9ot09/j54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqDljN8Yd9lfqSRtRPvlfUacf7uGQHvD6dpI5go6sezxycA+oDfcZYzI9Up5h50pMaWT9u+SX4auAtPoXqRc5Y3qfcoNbcUFLqE132zJ9G0Bm7KLDVh+6vA7I91P3XBWPdvrd5up226FMGJ+QoXlq5MnqyQQZ7VrDSf0YqpmZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+dfSYdf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99238C4CEE9;
	Mon, 12 May 2025 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073095;
	bh=Y/UwDHOzgo7mvKL2TTsdVqmNE9hLk7gv5x9ot09/j54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+dfSYdf3OUX2JfXF5fivICdd5We17Ib/RhjHQkucx+P4O8W3f0Xd3g29gpeyGIHf
	 Zm5cANUJ6yFvnw7XhBqTP7xlecjMLZs3Yfh36oPi7myLBJa4Aw1gx3yclBaACaoyj6
	 cTEtEMQJWBoiFKwdfwvuAt1eAAKp1vJQliDHQ1SPdffu9D/iXUfDTembp72gxKkcHZ
	 QbSxhqahaJ5UPki4jLoyx2hGSZiJ7BCLULDX5D4IdFghsaCzVjDScrAIEQ55i4t475
	 NpcYANrrigI6rJoj8jYvcAEDKIbvUO6N2sl3S6JvOyDhfQ4CMONfctyamZXHb+vMkp
	 1iseM5cxMYwWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhaoyang Li <lizy04@hust.edu.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] arm64/sme: Always exit sme_alloc() early with existing storage
Date: Mon, 12 May 2025 14:04:50 -0400
Message-Id: <20250511213756-8ec688ee2920d032@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250510054424.346532-1-lizy04@hust.edu.cn>
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

The upstream commit SHA1 provided is correct: dc7eb8755797ed41a0d1b5c0c39df3c8f401b3d9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zhaoyang Li<lizy04@hust.edu.cn>
Commit author: Mark Brown<broonie@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 569156e4fa34)

Note: The patch differs from the upstream commit:
---
1:  dc7eb8755797e < -:  ------------- arm64/sme: Always exit sme_alloc() early with existing storage
-:  ------------- > 1:  c63c796b955ce arm64/sme: Always exit sme_alloc() early with existing storage
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

