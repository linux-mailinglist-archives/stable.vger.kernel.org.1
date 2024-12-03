Return-Path: <stable+bounces-98146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F889E2AB3
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 19:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A22AEB28068
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B90F1FC0FD;
	Tue,  3 Dec 2024 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrt1EemJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47F1FA840
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249592; cv=none; b=YtHiaYHNwndEF2frHRwco19d2nrcyAc65dsWZwDzs0O8Na8FyfJLFb69Z0XvyNcPdpy2K/UaH5ujdZwhBzeyDEMC9KAQFGjS/0BiatBxMfDd35w6CDsQq8dBMqDVJRCN3EIWyTupvU3Mw9+L8upj9xINi7Lj9Oiud0QN/1nO3xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249592; c=relaxed/simple;
	bh=l7NH6pn0e10ZXjr5p08hMutSQQQkyLTnd1Nlrn40sJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RA2ezYOgiLnWYAYRQWb3saRLHc9+rUJjFmtTuNIFnmHoUNze11wWAiHesiKmJWu7WbzASDWTEgSw9F5OOZDY11SJ0d8o1ljlhja51zMoTEk6AUm0k5GqmimP1/9VZJ7mobvacHHPAMbE8NZbUcHq/lGYoCpFSRTK4UxdoZGEalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrt1EemJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F6BC4CECF;
	Tue,  3 Dec 2024 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249591;
	bh=l7NH6pn0e10ZXjr5p08hMutSQQQkyLTnd1Nlrn40sJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jrt1EemJuOprmU1Js7aw/Q+dWr2S4irx6HMlHthBwKVJguCSMn6Xw2DPumBFo47kw
	 5t4ClUT9+IJH1ma5B5I7lT9qEg+3SrQxtMv4wKL0bN51GURxVyb665cAjHTL6qX25f
	 HrVzC4ZefgeG12AEwdzTwJw5ehg4de1WiMHDElypHxve6TPtt6anbvGgSktaGSr+wd
	 JARliSZpJSFzQbCXa1Ey1FpxJF6IVUlbwH7XEmQbnA64GMil2feN9tigXNTa/+9lfJ
	 083oVnGtOVE8wtCN+n9bSwA5VOXRzCwqy3sti1AmSkBVaXVtMJ8JVvK04W+/eeO/p3
	 6/ogZO1B+Hbyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10-v6.1] driver core: bus: Fix double free in driver API bus_register()
Date: Tue,  3 Dec 2024 13:13:09 -0500
Message-ID: <20241202140724-6a2ef98a8a604527@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241202183330.3741233-1-brennan.lamoreaux@broadcom.com>
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

The upstream commit SHA1 provided is correct: bfa54a793ba77ef696755b66f3ac4ed00c7d1248

WARNING: Author mismatch between patch and upstream commit:
Backport author: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Commit author: Zijun Hu <quic_zijuhu@quicinc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 9ce15f68abed)
6.6.y | Present (different SHA1: d885c464c250)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bfa54a793ba77 < -:  ------------- driver core: bus: Fix double free in driver API bus_register()
-:  ------------- > 1:  488cd01e46650 driver core: bus: Fix double free in driver API bus_register()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |

