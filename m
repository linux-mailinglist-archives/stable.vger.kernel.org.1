Return-Path: <stable+bounces-160269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42117AFA21D
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 23:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CEC1BC89FA
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 21:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97775264FB3;
	Sat,  5 Jul 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqqU6ek7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E1264617
	for <stable@vger.kernel.org>; Sat,  5 Jul 2025 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751751633; cv=none; b=dEHYy1CNUW1B38aNwlwvFGj6MSbdtrmx6lUYhE7MKBGn1d9elOE+Pqux03/y2AYDtxSf/74DMip4nhPzAuZgDM0grbPMugzn8QPdH0eg63mQMpB+R/BqlPsVWjFI/Bzhc4cw10+pY8WZvGXFD6LxM+y/wIte9AaqbByHz/pNW7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751751633; c=relaxed/simple;
	bh=VsaipNoMhWTkPnmIq35Oa5hX2r6+ARGLlakvwut18eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+pfZ4xzf9cXxtARJJWOENff357cOsknQMg9wqrNnCrsrR/Res7dzMjyOFaA5OEAFnWAiT81ZFMBlXGbrn4D3iZXLK6b3PEqavUc0QG6LicnQXLZ15qyPm+dO9xi3snJikH1JzjJZA3Q19cDWTzk6JrUqtzQasO518sbTCKFrUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqqU6ek7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75730C4CEED;
	Sat,  5 Jul 2025 21:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751751632;
	bh=VsaipNoMhWTkPnmIq35Oa5hX2r6+ARGLlakvwut18eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqqU6ek7bP/o9KxuWVTrTIuh5vdpcQpbxRBDIh1FqMaZA0yQAHTHJw0IZ94WMpeYH
	 AbuxdLQGMG5YU4NoB0pUgQ7gG72ONjHngvzySK13HpF48u4agOORkZt1luISjMnulf
	 vvWLsHqG4ZAiaOcBfCl+A/vVwqED9qCAvMHLu01Nt2GV2wAbgrRR3scL9AP6xM4nYx
	 dzbEUzNRU4Cw29FhQeK9I/E6GCEynd2t92HfCroPf9HJNRT80Qm9ZuTCpS1kJHCYeV
	 b5S0m2MibP197xRLK0G/ndbER8hqcWrewnPo32vj78tWI4PZsecp9u7i4y4FDZgJMq
	 BhwT13m3Z5dEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Liam.Howlett@oracle.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
Date: Sat,  5 Jul 2025 17:40:31 -0400
Message-Id: <20250705095844-448fdd14a40518f7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250704150826.140145-1-Liam.Howlett@oracle.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: fba46a5d83ca8decb338722fb4899026d8d9ead2

Status in newer kernel trees:
6.15.y | Present (different SHA1: 0c23ae32bfba)
6.12.y | Present (different SHA1: 1d026fb05207)

Note: The patch differs from the upstream commit:
---
1:  fba46a5d83ca8 < -:  ------------- maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
-:  ------------- > 1:  5ecdcc8d43f31 maple_tree: fix MA_STATE_PREALLOC flag in mas_preallocate()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

