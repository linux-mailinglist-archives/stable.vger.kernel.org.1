Return-Path: <stable+bounces-154777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9737BAE015E
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838803B1196
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B881C26057E;
	Thu, 19 Jun 2025 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQT0SlFY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F1202F7B
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323868; cv=none; b=UT88x8fxBw1Qw8xcwEKyfotJUEjG7j6jzFFFgeIQlz/2XoRq9vp9yFFox5C2PF14cM7Iwpb4eURjJB4iiN3aH0D0Z1zkkXiBXMfeEq7PZ+rHggK4c+Bi+ZqxVwqsxtft8aODb0Xdclx7mn/7Sd9p8QoMKWNjPIUnFFIvW0TxYes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323868; c=relaxed/simple;
	bh=eUu6Kf1YBv9LXsN7aN4fvpkxM3qzuRUjj7rINrfX9yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fXjS7XNy6fwIN5IpuJRsdJniFFGieoXEhv7qWjiJnO+ryDPp6zXRgxwdEr/16Vu0n3+WkWcTbiCZnd/lpzCJlz1Oc+P7b1aHMB0LleJmITLYO6NW7IJL5DdP52/9mgc49QPdntcLM2+Qh6NvM4k79e8VQCsLSFEdpT+26HqwTas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQT0SlFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA9CC4CEEA;
	Thu, 19 Jun 2025 09:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323868;
	bh=eUu6Kf1YBv9LXsN7aN4fvpkxM3qzuRUjj7rINrfX9yk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQT0SlFYpGPWGOpG0oe1T6vMbY406dhj/xUZd0ZzsZGJeeYI8Pf9j0AzbjNFA08l0
	 wAtk672XME/mdVPis/tndmJsS3S02l+plX/UkIMORroogReUhi/OpEMVUp+nP6aMrq
	 Ulx2isMI3Nyl7HEkj7pnRmSkliw/30IVmwHyHYfn2tc5G4zGdtvwHpuCcwiAAUy53b
	 24wW7cRND1EEovsLfFm/K8z5x7nPtaQVxMcY/TayaI7DbQBv7qEo87EsCj+pH4IqoH
	 AL770cjvNqKPqqlFkjXcLT4xbvWiYKZ1S9uJo4aR25KlBhaW8tu0jYRrXD5agpfZzb
	 w4r2bnGYwGyXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul.chaignon@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1-6.12 1/2] net: Fix checksum update for ILA adj-transport
Date: Thu, 19 Jun 2025 05:04:26 -0400
Message-Id: <20250618161119-03858fcf2605b649@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <6520b247c2d367849f41689f71961e9741b1b7eb.1750168920.git.paul.chaignon@gmail.com>
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

The upstream commit SHA1 provided is correct: 6043b794c7668c19dabc4a93c75b924a19474d59

Status in newer kernel trees:
6.15.y | Present (different SHA1: ce211a9d9fc1)
6.12.y | Present (different SHA1: 0de96086526a)
6.6.y | Present (different SHA1: 5dd8c050f1bc)

Note: The patch differs from the upstream commit:
---
1:  6043b794c7668 ! 1:  7d341b6665368 net: Fix checksum update for ILA adj-transport
    @@ Metadata
      ## Commit message ##
         net: Fix checksum update for ILA adj-transport
     
    +    [ Upstream commit 6043b794c7668c19dabc4a93c75b924a19474d59 ]
    +
         During ILA address translations, the L4 checksums can be handled in
         different ways. One of them, adj-transport, consist in parsing the
         transport layer and updating any found checksum. This logic relies on
    @@ Commit message
         Acked-by: Daniel Borkmann <daniel@iogearbox.net>
         Link: https://patch.msgid.link/b5539869e3550d46068504feb02d37653d939c0b.1748509484.git.paul.chaignon@gmail.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
     
      ## include/net/checksum.h ##
     @@ include/net/checksum.h: void inet_proto_csum_replace16(__sum16 *sum, struct sk_buff *skb,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

