Return-Path: <stable+bounces-164815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0F2B12857
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A636E3BE964
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAEF2AF11;
	Sat, 26 Jul 2025 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcgBCluT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBC012DDA1
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491700; cv=none; b=G1zC8BLXzLic+kwZfw1YrOfcSMNsgbU7/G0DQpRDNgMjBjBN7zSAHvS9GRm0qAvxoM9AQ0yGfL8UHWeraTLfO/V6X0XfFUpxa5y5RevyGml8In1aZJ7lSFP/mSAvB47JaszrspnvXOedeOUiQcxdPyEzmN+E15+F0d9e2xdnEv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491700; c=relaxed/simple;
	bh=LKvurYOBxQCg40nYzTIzKQ2N/2XochTKv7cbwW7j8ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bibK6UvYbmd5+UrSQkvUcpOyhVt8BpzlWm0cDRpJKo4riXbeYZfrtoHtaMAUgorY2p2D4UgAefklWcqt7G6pIRsuLd4yBFbrm+Dw7DEwVjvRQw8uaSSb2eQAkfZWGMAp1m2An5Y/vEaVMXz3prM3+vHX9kc40m09cs0fLwFNfq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcgBCluT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCFBC4CEE7;
	Sat, 26 Jul 2025 01:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753491700;
	bh=LKvurYOBxQCg40nYzTIzKQ2N/2XochTKv7cbwW7j8ow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcgBCluTUTCDUoJsOP9D7voTejPTtoxOjMqUT1xOcAYD9lAbEZMgrjC9pjAjDwW0m
	 PUK5OEp+F5xMmziybzIyzXiGzyFA4N2B0ZiLv0/Ypz74NpzSNGc/rUOMKC03s1n1pJ
	 /L849r96GcOW6BwRJmoTU75FyQjM7xHRilh82MdSrF02kKVO6vJiJsVa02AuHX0GGX
	 dHqNUmVGddUOZdMJCZYJ2X8wmULUma+SXYo6er/YtF/hQzkRwVa2vHZoqVw1lrC2bq
	 8gx9+xKU++zDyN0bBin2JV+dmmi26Ag/XyJ451te1wYronFm7XZSZK1CTD4outjfUu
	 42eBLatz91RGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	skulkarni@mvista.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 8/8] act_mirred: use the backlog for nested calls to mirred ingress
Date: Fri, 25 Jul 2025 21:01:37 -0400
Message-Id: <1753464140-e7196da4@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724192619.217203-9-skulkarni@mvista.com>
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
ℹ️ This is part 8/8 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: ca22da2fbd693b54dc8e3b7b54ccc9f7e9ba3640

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Davide Caratti <dcaratti@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 4c8fc3fe28e4)
5.15.y | Present (different SHA1: 169a41073993)
5.10.y | Present (different SHA1: 532451037863)

Found fixes commits:
5e8670610b93 selftests: forwarding: tc_actions: Use ncat instead of nc

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

