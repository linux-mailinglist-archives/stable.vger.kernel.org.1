Return-Path: <stable+bounces-154850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC061AE1116
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D31A19E252A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 02:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57713B788;
	Fri, 20 Jun 2025 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMWhO5pc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9E9137C37
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 02:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750386300; cv=none; b=bnpoDpfLoPdBsmJAe6jVUPRooD3Ss49VKL9pviJYrIny4/svL56lamra/wQiza7PQMlH0HNYdWC7WD7BmnX41ZkIr7HSiMjwTa6zkK5/Xi2C7DwSkzYn7f6abC9MdVVoLQaw4i3sqEFvOTpzr/wSVcHqBQL2sDEyBU32JzW48n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750386300; c=relaxed/simple;
	bh=yr8LHi92yz5lDILsEeP//mgcCvVWqpCn6HaSUnyGesU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PEHkdS/WcA9oj/xX/uEOT6bpL31SPda+Z7WYw0IhRGP8WxmsWs3k3IGPGo34UsR9h+mg3caLX+98v8aHtaprgwUUvrqbIqp7U7i40OqQG+379epfEUHYlIpoxFAB9bU5GEJhZ5U6Rbbnc6PF4eXApSMCGZlLyOcqE6KqM/hznZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMWhO5pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68F9C4CEEA;
	Fri, 20 Jun 2025 02:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750386300;
	bh=yr8LHi92yz5lDILsEeP//mgcCvVWqpCn6HaSUnyGesU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cMWhO5pcuHL3r7sxPAt1LIJQ+tJyls2FOPjpu3XaHj8mxw1sVaGqG0fJoucEEmkKi
	 MDIyjGVzXjgCnJm7aheZHwtbRa7rEmMnsTTfc5YMjhwQQpOgvXwctMZo75EfsQQBJ+
	 kD6FTaBS1fWiSh++cryWit1GCOy4SpnwJf8E9EDMN+BRViUjmbkLAHeWT7Fek1KNMM
	 ee4jhG1cOGINEIKTQo9lWChAEVvKWUW0oNCHygoNVEftaRhAqULAi5BePscdI689/g
	 uMefrJrAnjmguPN1zDsZDmgM/q7SPkNwtLLQEzvCQsoCyZyH04SYEE0B/xAgMJeZz2
	 H2ZqqiyR1+pcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4~6.12] Input: sparcspkr - avoid unannotated fall-through
Date: Thu, 19 Jun 2025 22:24:58 -0400
Message-Id: <20250619051524-b2210a304ee572f0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <5C0E9B30D2B39A0D+20250619065241.37834-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: 8b1d858cbd4e1800e9336404ba7892b5a721230d

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  8b1d858cbd4e1 ! 1:  0805e2574890e Input: sparcspkr - avoid unannotated fall-through
    @@ Metadata
      ## Commit message ##
         Input: sparcspkr - avoid unannotated fall-through
     
    +    [ Upstream commit 8b1d858cbd4e1800e9336404ba7892b5a721230d ]
    +
         Fix follow warnings with clang-21i (and reformat for clarity):
           drivers/input/misc/sparcspkr.c:78:3: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
              78 |                 case SND_TONE: break;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |

