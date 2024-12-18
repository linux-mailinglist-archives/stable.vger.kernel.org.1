Return-Path: <stable+bounces-105235-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EB59F6F20
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 22:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB3A189058C
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 21:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DA01FAC5F;
	Wed, 18 Dec 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXIQJ5Zv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B0715697B
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 21:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555673; cv=none; b=cUMNIUqX/bxAn9+eBHu7MD9KcXrnZuyxceMj8v2bd5JUIb+ew2lEKbusNZbJ+dBKQ/GieBNm8VofQ7PDmABlic894d1Nvl8rPWY0q0WEjpYVSw1gPdv00snPxvnYPdIwkimtbUm+CXjnp3f78gqc4vm7l3s0CuvSiNJ6vtW+NE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555673; c=relaxed/simple;
	bh=b7Br8FxnrSjIsJj84TiFWPugpfQPZYW7Asv3YPBnsSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hptTl79tVcDRjCDTTb+6WGHAzW4RlHQ6ZREbX/K6E+n6Ic2YR8FnTUU3G4Rp5PL0RBUlpLbU97REY6Zuj8iGqJmUj88TaMDJoMlzNzXj/F5uUN22UkudDORBXAcWKUbOqw7LK9l6p+f+NBAj2uQSI51luw46gCU4X5RmfHLH344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXIQJ5Zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C757C4CECD;
	Wed, 18 Dec 2024 21:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734555673;
	bh=b7Br8FxnrSjIsJj84TiFWPugpfQPZYW7Asv3YPBnsSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXIQJ5ZvSymyBxZDS5lLdV1JwDye3QumrCuut238sBqEB4o+3j3icQcTEbEYFUf0D
	 D6o23x0ocYcjuB953bp9qhute1aHZR/VPwAsw8SUsc+16r/5pvu2OWRj/PDh4fiKsM
	 z3mT3MiFBTU8Th7B1r1RkK9T1FoOJOZLuUKzKjk3iq5jt0EoqpskwPdLRDJ1bPqmFZ
	 HpyvwZuMmtGrIQJoWBw0extPORJAa7RTs37qcvCvzUUF0ebZwxJ/mXKiCd7f0HginN
	 iNfEEWUy/T/Z07H7ir4vfKmIwNfhuoZwf4HyOJWBJHTns5jqHL+O5tokOsrc98vYz1
	 ndQN+Nwg/Jwiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 12/17] xfs: attr forks require attr, not attr2
Date: Wed, 18 Dec 2024 16:01:11 -0500
Message-Id: <20241218155157-b0c79d27d96c74eb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241218191725.63098-13-catherine.hoang@oracle.com>
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

The upstream commit SHA1 provided is correct: 73c34b0b85d46bf9c2c0b367aeaffa1e2481b136

WARNING: Author mismatch between patch and upstream commit:
Backport author: Catherine Hoang <catherine.hoang@oracle.com>
Commit author: Darrick J. Wong <djwong@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...

interdiff error output:
/home/sasha/stable/mailbot.sh: line 525: interdiff: command not found
interdiff failed, falling back to standard diff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed (series apply)  |  N/A       |
| stable/linux-6.6.y        |  Success    |  Success   |

