Return-Path: <stable+bounces-135278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6DBA98984
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09EF5445340
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B48F1EB1B7;
	Wed, 23 Apr 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mL5MsS1j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD233062
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745410632; cv=none; b=RFVAps/dDyuIbej05RuUg2MMHw84IMKP8xGdi6DW1sl9Ysp/cigUd4aEfSFrCz6XI+XOjFTf6FoaBuh7FS6q/+cA8jVSW8yuf1j0QnXv7nKYU5gAy71aZ52CDv6SAdpDwNgyXp2qQ/dmczWQVhN5JBKP+kGkMLbC21oynsQVga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745410632; c=relaxed/simple;
	bh=3HelZ71pn8NXPgJ9rd89oQ1wbd6XH24nuTO5uBylj+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KhKrCWQhzJEE5owGVgM5D6P+kwBDhcCqLgDDRh3Pmo1oekk85gS7qEihacMbT0fnLbYehMgo5S1+ApNmFuck8E25DH7BbUjHNXpBlKCgLfJNKQ1NaVHgRThWx4AMehY89Fi2HTCl/bv4yKr7ck6gSF2GOvsuQF8qZZ4VqJqqB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mL5MsS1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F99C4CEE2;
	Wed, 23 Apr 2025 12:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745410631;
	bh=3HelZ71pn8NXPgJ9rd89oQ1wbd6XH24nuTO5uBylj+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mL5MsS1jZ8BuKbmd+5YKMPKe7AK8Q2826nOI3yRZLDUroA+uuuZcEC3MsSCRjlw17
	 14HQdvMDbd4fhTCdn8BAgndKWuuGS9nh6iuKSQkDxazFNBl5j46sUpcODqV8PTGbM6
	 3mpUtO+w06RDyDC3BnIE+AlTYY9d9inmNYHh70kiuMP6Rpp5+T2I5B58RTqV7YqEeU
	 m8vmaZGe7b8021/Hkwu3lLZ846G8O3HUSmDqtIESPLPNMcTbYgGy5r2jc125QQ9BKW
	 LkqXWZo724H+FrSG45UDIz1ZElP9qR/QFsKGbkpgilaXPACxHngYO2Fj8TC9jfkt+p
	 Pf9w6YVE+a63g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] net/sched: act_mirred: don't override retval if we already lost the skb
Date: Wed, 23 Apr 2025 08:17:09 -0400
Message-Id: <20250423074044-a7d9e56457b4d7cd@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423085923.2890055-1-jianqi.ren.cn@windriver.com>
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
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Jakub Kicinski<kuba@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 28cdbbd38a44)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  166c2c8a6a4dc < -:  ------------- net/sched: act_mirred: don't override retval if we already lost the skb
-:  ------------- > 1:  8441358cb4fa4 net/sched: act_mirred: don't override retval if we already lost the skb
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

