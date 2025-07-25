Return-Path: <stable+bounces-164792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819FCB12766
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE0F5A3101
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C298426057A;
	Fri, 25 Jul 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQKljsA7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B1E25A334
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485982; cv=none; b=CQ5X3qb1vr34xmnLvutR7KyfelHcXKmU3uFxOX7VXDc4O1kpkETNci9W6klNf3qPwn0g7gX60xR0MebSYYSe3oip3Pz+nL3WoNwrNR6TKiE0D4+ss60iczDbhtZgEUQXDbevNPy7WOnLGPH+lJQspYOHm+5DMRdwarcsnQNOrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485982; c=relaxed/simple;
	bh=W9dfdHgRHoJ/5N+qHlmmwRQcdaBUTmNhV9BgZbkjbfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgRRC9h5TwfYCeLPmBMrB2wzvARbnKCEXARR7ct7n4tlXvwaDdNpmEk17CRnGyK7UjPtk4d1/vERr+Aeki2MVO91GE46fhgfSOSEiorJxQy0vh1BkO2bCkBU2AzZ6wcqh8iwSAv5ntZvwol+gM2lZ00cK8lEK09iXp6tC+rJTuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQKljsA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EAFC4CEE7;
	Fri, 25 Jul 2025 23:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485982;
	bh=W9dfdHgRHoJ/5N+qHlmmwRQcdaBUTmNhV9BgZbkjbfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQKljsA7E3QUf9yWmfp6f+MO/b8mQWOX1EXB6ImZ/3dCnxTawNV5rFEok+VoHZFsd
	 DwTDS+uh59C443IK7KZ2AKVmy/gIWDnYRJ49Ico5F6QB2zoWS2ZaupVLFinBWGNC50
	 HkgZpCoxR2tkh3VClc44HXayFIl5k8oJ+y/gDjWaOvAZb9eaVB1vwWr78BzaauPDuZ
	 mWQeiP/piKYuvmxwfe2FA6p9VxLM5Pk+5zQlR6qMNHjlB5lkHtNKs//bAoMLdrTKi8
	 MBLj23ZwBrPbqb7AB4uOxznjBbNKJdx/UF/rN9QgeGPldnYnha1QM5P4p+APGiwpsg
	 9hb3iLS+r9PhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 5/8] selftests: forwarding: tc_actions.sh: add matchall mirror test
Date: Fri, 25 Jul 2025 19:26:19 -0400
Message-Id: <1753463901-a5b136b7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724192619.217203-6-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: 075c8aa79d541ea08c67a2e6d955f6457e98c21c

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Jiri Pirko <jiri@mellanox.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  075c8aa79d54 ! 1:  95b6e294fcde selftests: forwarding: tc_actions.sh: add matchall mirror test
    @@ Metadata
      ## Commit message ##
         selftests: forwarding: tc_actions.sh: add matchall mirror test
     
    +    [ Upstream commit 075c8aa79d541ea08c67a2e6d955f6457e98c21c ]
    +
         Add test for matchall classifier with mirred egress mirror action.
     
         Signed-off-by: Jiri Pirko <jiri@mellanox.com>
         Signed-off-by: Ido Schimmel <idosch@mellanox.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    Stable-dep-of: ca22da2fbd69 ("act_mirred: use the backlog for nested calls to mirred ingress")
    +    Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
     
      ## tools/testing/selftests/net/forwarding/tc_actions.sh ##
     @@

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

