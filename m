Return-Path: <stable+bounces-145685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF8ABDFA5
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 17:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD4717AEE6
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856A261571;
	Tue, 20 May 2025 15:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7ugSNHm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41D17CA17
	for <stable@vger.kernel.org>; Tue, 20 May 2025 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747756338; cv=none; b=kOH9hnHvwHpu2JIXrR7kp8laYCmvyFoVfx1MTSHTgiAvblOApSYyccQ1g9uzkAImjDZLxobNPAV5sUrK2qKBBaK/M6Kr2BjFlrpsO4LX+X7GNpY95l5VAIa25m4PBh3gfaxicLhseL99fhkMuyMO/gtpqkDBt6/lueyvRlX0P48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747756338; c=relaxed/simple;
	bh=xK8XDsYUKuUgowbn2/Wop0yvLZgrd49AvwLxp20Dbp0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek8N/FbLT2viiIH1j8TtL0ORiD/LBOAQxhbWnI9jnuA+loVDLGYgu8O6QzSTBhb4ZE2OFYwgLu85uYnIqSlWWUaLvDCOJ9cPHCf49c9Z+h/i9/0fijVd7wAoVb63+x0PLW+a86yX2l1S7D65W5Xuxf+1NY1YxzOADTEKXdBED78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7ugSNHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3422C4CEE9;
	Tue, 20 May 2025 15:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747756334;
	bh=xK8XDsYUKuUgowbn2/Wop0yvLZgrd49AvwLxp20Dbp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7ugSNHmo2RQgN0PZ9I5KNuPx+VwoQWNl2oGliMhSM5ktsg1tMuXMV09pE+KgWBsA
	 bKHwZ23E5n5VUDiQXraPpI1q+WYaOzsDVizMIrSwwiFAdZ4XoTTL227e4QPjyGjlap
	 An6rwmnVQpFMLFuMceqQNYsbYnZK7x4rsWAdXudsrMRv/8KwN4NEnLEfECFvEdnXKw
	 6egJVnWL7ZRRKdwzDupleVfwNvd0plkkCJ+l8zfQ7WFhMwJsFIblrIVO8FQUHKkThv
	 +ujzuEVHTpGkptFaG/zyKnJv4Es2ZRIhlLi0leSoKpPGlPqyOXDUVbiUn4a8kphk/m
	 0DZBCNMGB5d7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] net: decrease cached dst counters in dst_release
Date: Tue, 20 May 2025 11:52:12 -0400
Message-Id: <20250520113747-b8617aebcac0d099@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520083436.1956589-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 3a0a3ff6593d670af2451ec363ccb7b18aec0c0a

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Antoine Tenart<atenart@kernel.org>

Status in newer kernel trees:
6.14.y | Present (different SHA1: e833e7ad64eb)
6.12.y | Present (different SHA1: 92a5c1851311)
6.6.y | Present (different SHA1: ccc331fd5bca)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3a0a3ff6593d6 < -:  ------------- net: decrease cached dst counters in dst_release
-:  ------------- > 1:  a44adf5ab0f65 net: decrease cached dst counters in dst_release
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

