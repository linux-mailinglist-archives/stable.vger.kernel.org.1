Return-Path: <stable+bounces-137068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2AAA0C0E
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 14:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AB58438EF
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944912C2593;
	Tue, 29 Apr 2025 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWPgytwp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED9E2701C4
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745930985; cv=none; b=O7iemXkfev98jVysXJV3Z6SGTXVCAKxSALEp3L1h0DnI7+lUzOsXWv1x9t9qc/M8AoJZnz3Cq5KdVGpUaMut8PmVZFTTDvIJ2zkdM4lOvICdbRCajG19kKWjzevDLFXLTjVeLM1MXpD0Kt9C9QPDYzhluJqr39+qB+bJUuxRcU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745930985; c=relaxed/simple;
	bh=TpJReOl+CAQMUHZmfi3hUdx929EALpZIQiwKlixibOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI5BtxSV+UvAYtzn8yR5nwM3GUq7Y9+e6VNPPwQ0Tx8eZ1zz5OIqBJJw1avPG9l+PNP3So19VxRUoulf/srYNd4WJNRtLCSWX3QFJTkQAiPQMWJuUE0h09wqVHrtAOkjAe/8AqMutRzw7U0NKq5lbT663G5pfKe1nVkIwcbVoP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWPgytwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39E9C4CEE3;
	Tue, 29 Apr 2025 12:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745930985;
	bh=TpJReOl+CAQMUHZmfi3hUdx929EALpZIQiwKlixibOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWPgytwp9fP/5msBXabs6+zsCFnIiCuVynnsB5ubR772NvI3I9uqWU36V+wBOOBmq
	 zbdz4GO2zMXAfFUm9lRQLEuDYpbxYY9lk8GcaSLZ5sfUd95iohJoER9rWROJmKQ38S
	 KFCuhrfImsLan216HIu1A74Mjt+XttcD6B8Y2JfvwpCnETwcYb6UlkY+oW4N3OX2XX
	 UNXZ9VXkklI8QrPO5088WNy/xIqQRow8bBfV24ku/kr5pDsputIq/USXWF3mlknq5Y
	 qNcngr4tIvhPQbcFKmUrTx1yjrgu9QOFi3p6bLbBOe6iFA4gmpi+K5neuruXPILIXc
	 aLIR1u4GX1dXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Ren, Jianqi (Jacky) (CN)" <Jianqi.Ren.CN@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: RE: [PATCH 6.1.y v2] net/sched: act_mirred: don't override retval if we already lost the skb
Date: Tue, 29 Apr 2025 08:49:41 -0400
Message-Id: <20250429003612-a826104ae757a23b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <IA1PR11MB6170EC372E8DA7BB8EB22441BB812@IA1PR11MB6170.namprd11.prod.outlook.com>
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

The upstream commit SHA1 provided is correct: 166c2c8a6a4dc2e4ceba9e10cfe81c3e469e3210

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Ren, Jianqi (Jacky) (CN)"<Jianqi.Ren.CN@windriver.com>
Commit author: Jakub Kicinski<kuba@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 28cdbbd38a44)

Note: The patch differs from the upstream commit:
---
1:  166c2c8a6a4dc < -:  ------------- net/sched: act_mirred: don't override retval if we already lost the skb
-:  ------------- > 1:  edf4ae9112f85 net/sched: act_mirred: don't override retval if we already lost the skb
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

