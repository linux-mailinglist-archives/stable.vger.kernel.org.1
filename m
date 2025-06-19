Return-Path: <stable+bounces-154755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C41AAE012C
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764EA5A4644
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE4278761;
	Thu, 19 Jun 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1xuovNd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE54721C9E3
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323758; cv=none; b=nL3rDXiWVR4+q0c+NvaCrv5LCV10dGPz+DEGrBQ05Ou1D9KxwZA8WUXJnof7OyjiVSHUt94vv4wQBv+vYZ0naNiG4gI3zwBCEWEnlFc5HLS45G5kEqpovy5eRE0acVYGtLxfTZ4CE9EXrcg5W146LTXQL5npLQQ05Jz++PEzTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323758; c=relaxed/simple;
	bh=YBd0pybWVshEOo+kwzE8KNFtJevFbIYdcITvFASwAiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uie9f2Qh1OYyf5irurK4I6mkRdsdpJq4sm9FsrrrQEsM1zSUnXj1XcuK3KqTJSoURX2j25QKhAPAalerFTM6N+LZunMjH7+rQBgREha4O0sYJiJRnZl/KFh7h9lrJtSt6nkXd5B1WnIUa6Z65kh1lqKicpCb9A5WNMzk7d5VtpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1xuovNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98F7C4CEEA;
	Thu, 19 Jun 2025 09:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323756;
	bh=YBd0pybWVshEOo+kwzE8KNFtJevFbIYdcITvFASwAiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y1xuovNdE2/eJDLkbx2ScThT3HT5aXQiqeXt2i98907vakbAhf8mw0M3v88pZbj4K
	 4tJJEFFuXEe4d8qty3LOY9arEOXnKNHJGbAjXiGZqnvGPbgw723ZzbEq6Je4MR8zTq
	 R+HBRcoJmn4+5MQdZ3oT/V0OT2Zi5DnX4AYQLS9E8uG1KlVn4rtQ081v9Nb8nz3iRe
	 kwR4AlM089r+2kjhD1CaQ6noVdBF03EjVB/o9MnDshLkBDNKXfa9cRKlutwrKQD+0m
	 DBDjXI/8MzUTOTl9V+ge1gGH5+YxI6yIYjbK18VNk4LVPGcWGYZJTPrNjkzXYNJhaV
	 VKXCnIg/ARQdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paul Chaignon <paul.chaignon@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1-6.12 2/2] bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE
Date: Thu, 19 Jun 2025 05:02:34 -0400
Message-Id: <20250618163137-41f2bb4635744d15@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <ad27219689eb849a3b8ec0672591b6384bb2bbcc.1750168920.git.paul.chaignon@gmail.com>
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

The upstream commit SHA1 provided is correct: ead7f9b8de65632ef8060b84b0c55049a33cfea1

Status in newer kernel trees:
6.15.y | Present (different SHA1: 147c9e7472c9)
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ead7f9b8de656 < -:  ------------- bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE
-:  ------------- > 1:  f1d24c2d9cdcc net: Fix checksum update for ILA adj-transport
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

