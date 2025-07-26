Return-Path: <stable+bounces-164804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F25B127F9
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA36AC0EEC
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48493BBC9;
	Sat, 26 Jul 2025 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/QMGVTF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C028FD
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489500; cv=none; b=D9iU/IZ1tXemi2Uc1TZlhpzJGPZTiiw/RSA1PW1yDy8cEZspRCoRi52hd3YHNioSUjzGBlyhaKnN92TEvWrETCYBfBvi9W7CzGOW+/H1cfiRQIZLbwQH/299z5rNVbroFnbEmxSgsa9byGwZaNN6aK8I9mfoCE0HkuBcSAhDB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489500; c=relaxed/simple;
	bh=ouEaoS10fzdUUNewOnxPRn+yUIfuDEseUqu//BSjC18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNxE5CQ73QLcmC7/ovEXYsLwWdfkfgWCfDdLucBhwPHhn1wHKkpbkO/GudDmhlDvfiPJlbt/KEVN2Ks6HOHtSOzs2eCMm1IA3zQpAKt0S6p1z9Ip0tMQ4B6rrUcF2WMq3+82wE67JEaPGZ+MqMV0mvKS+mZuU9ooK7/A/KiASzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/QMGVTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF774C4CEF4;
	Sat, 26 Jul 2025 00:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489500;
	bh=ouEaoS10fzdUUNewOnxPRn+yUIfuDEseUqu//BSjC18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/QMGVTF6ZHNTAJ19f7XVwNZg+yaPQZ3f7e3uNsG4TYarsk/yYD4xeLFBf/LWqFtm
	 K5LeHLu6LmtifG3uGcGMcmV0gnpgOrBHcfgmW4lCWLtrCCK15saxtAgdq5sfUeoUsH
	 smOROfrDuR4KwT/JoRNyn9lxozf+ygNBkqX7jN4NMiwvjLtkUJvZqxv6Jp4xxzxnwJ
	 A8yC4bOOf6WUH1BYYGqkVr0IlTjrJqfpCEN/a95N5CaeSTPXErdT/CKlNLO1+p3SBQ
	 T6vxsOi79g1ojJSlPdnSdL97umn5dzVkPITHEeXLLdazEu3xGzBkZpXww2cXTCEiNP
	 IhzcazSeAx2qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 3/8] net: sched: extract qstats update code into functions
Date: Fri, 25 Jul 2025 20:24:57 -0400
Message-Id: <1753463716-f2f3419a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724192619.217203-4-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: 26b537a88ca5b7399c7ab0656e06dbd9da9513c1

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Vlad Buslov <vladbu@mellanox.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

