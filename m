Return-Path: <stable+bounces-158591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EFAE85BD
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108A4173217
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3650126528F;
	Wed, 25 Jun 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TG+86qyb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FD026528D
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860542; cv=none; b=evXNuShUfob8acVe0afo4VIkrH1odOTX7AyusMFVOUko7minuEN+cEivbgiw4JrmL8iUkDJMUhWQgtflW2z/vT0JHPk7Ex7ZNwgSBhMhFNXc+gkfLZqkvvkIUubalE+Ki1ZFzE9CcC0nTyc9+yFacA9u6TSqs10S6jwHSq7RE3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860542; c=relaxed/simple;
	bh=XQMLLndhZ9qeoeBoOYTJgfiQnERc1x8+d0SQ0wX91tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8At+51J3pLJRAA5nX2ZF7wfWN2sf3dCVuXbgfLG3GhJS20k8quhfTOvM2ikZWRf8BxUxJiqSzpDNjmaQL9a76yabh6Jl9PGaOmkPYFCw6TdkvqyV2VgWKWbuInFU7uXoxvotgTIzfPUTmHKOkWUQMJghUNzZh3akYTaOONsM1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TG+86qyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1332C4CEEA;
	Wed, 25 Jun 2025 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860541;
	bh=XQMLLndhZ9qeoeBoOYTJgfiQnERc1x8+d0SQ0wX91tI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TG+86qybIu+DVLswyJT1B8MXs1JEQq+G4e6li9VoT61MQ/FUYs9CgdLpRyFp2sBg0
	 o67O3tQi1l1JjjF4Gfn7g+M/JH/O9e7Yhuovkq4l0W2+aBE3oev0RQnbFc/4mZycUc
	 59TJFdoX60A5u1T/AS8Y8GysaGqU7li0/Yo1XqxOzmgx+Y65Hc0SN8rfdCSHdiX2Wy
	 ldT4gLz5GALUqsiBAvMHihsONMDuk/B1zeLAD0Jvm4lNGvHp1NyE8mBAAsHiJjLQJ5
	 1J5P7dzvKT3/3LvjG3LG1J3Bihll7Ip1TvB7LPxNGQHXfmdAFx8J1t0WK8r/0eQF5H
	 Y7YA/gAQBAzvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 2/4] rust: revocable: indicate whether `data` has been revoked already
Date: Wed, 25 Jun 2025 10:09:01 -0400
Message-Id: <20250624235025-5d3f0fe8161a1549@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250624135856.60250-3-dakr@kernel.org>
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

The upstream commit SHA1 provided is correct: 4b76fafb20dd4a2becb94949d78e86bc88006509

Note: The patch differs from the upstream commit:
---
1:  4b76fafb20dd4 ! 1:  b26ce8d6f1c62 rust: revocable: indicate whether `data` has been revoked already
    @@ Metadata
      ## Commit message ##
         rust: revocable: indicate whether `data` has been revoked already
     
    +    [ Upstream commit 4b76fafb20dd4a2becb94949d78e86bc88006509 ]
    +
         Return a boolean from Revocable::revoke() and Revocable::revoke_nosync()
         to indicate whether the data has been revoked already.
     
    @@ Commit message
         Signed-off-by: Danilo Krummrich <dakr@kernel.org>
     
      ## rust/kernel/revocable.rs ##
    -@@ rust/kernel/revocable.rs: pub unsafe fn access(&self) -> &T {
    +@@ rust/kernel/revocable.rs: pub fn try_access_with_guard<'a>(&'a self, _guard: &'a rcu::Guard) -> Option<&'a
          /// # Safety
          ///
          /// Callers must ensure that there are no more concurrent users of the revocable object.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

