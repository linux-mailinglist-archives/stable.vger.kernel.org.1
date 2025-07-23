Return-Path: <stable+bounces-164380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E23CB0E9A8
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 06:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1AB1883FE6
	for <lists+stable@lfdr.de>; Wed, 23 Jul 2025 04:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A7A1DE2B5;
	Wed, 23 Jul 2025 04:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPlEARnw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326D2AE72
	for <stable@vger.kernel.org>; Wed, 23 Jul 2025 04:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245260; cv=none; b=ORySTBT0ekeQQTQhYiRXnjszYGgscN8cvmk6AccCjFNiZFrSG1MJAW6MjOFNpPcCKp3+qKUTQ0xukPcKtqIBMWlpTuJx4m+udYiTHUrSs0L+Mz5tHROppRlkNWz8kBbIwsKLCK8zlsPpriKaXo9FsYS7r4qQnuKTjugWk0BafbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245260; c=relaxed/simple;
	bh=hr8sBv6eg9uubcfo97W4t2puExF8g2FQ2bUOxK5quV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgxG6AJkoqc+Flor6gaHEXllQgrpJ/mcO5lvXEx/gy8WeGOONVNGmyCxxLQKqEqnowxvhuCfQTbi3kAOGKH4njD1ooCziUn95h7pjyX6ige+p2lqIa2Sh25lrPEWTlpmhR0bzCwJin1ja/dOlK1z3BKCTh+RCtWuEEPyweT7hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPlEARnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1351EC4CEE7;
	Wed, 23 Jul 2025 04:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753245258;
	bh=hr8sBv6eg9uubcfo97W4t2puExF8g2FQ2bUOxK5quV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPlEARnwkfS2OFZHjWNEKmB4n7V+NJ96Czj2dCZCHmiv01cR8h7DZ2/bSaXqXsPTg
	 XzVK8vqyqeyB0N1BCmlqof1lIA8KGNZ91cyh8gkha3q/sOIAfoqliG9jxWUDswczLU
	 s/0Te6zSB+ue2YYZE3IiZIUhLfM91stVLDaEflhNSFQLlb7PbkueqsFKHeFThfEf3S
	 kajJw2fdk9i40vLsfPHdBPBL3TBrSUA/+IOW4R3W/NQXN3hI+3lFmGcBVegVxwCRZ7
	 hZla6gQ6XQiRYauB/4RwsnPJxsfT4SAMNa7Wb7687LmQM2pTVl8YqPvb8QR2n3vEVf
	 HfU+fhLIlz4Tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	siddhi.katage@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 3/4] x86: Fix __get_wchan() for !STACKTRACE
Date: Wed, 23 Jul 2025 00:34:16 -0400
Message-Id: <1753233380-e3b23421@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722062642.309842-4-siddhi.katage@oracle.com>
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
ℹ️ This is part 3/4 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: 5d1ceb3969b6b2e47e2df6d17790a7c5a20fcbb4

WARNING: Author mismatch between patch and upstream commit:
Backport author: Siddhi Katage <siddhi.katage@oracle.com>
Commit author: Peter Zijlstra <peterz@infradead.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Found fixes commits:
0dc636b3b757 x86: Pin task-stack in __get_wchan()

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

