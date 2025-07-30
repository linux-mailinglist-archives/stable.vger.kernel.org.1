Return-Path: <stable+bounces-165567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A05DB164B2
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657CD18C6B6F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E172DEA95;
	Wed, 30 Jul 2025 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdVH+CxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE06D2D838B
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892980; cv=none; b=Yx83Xu8aY4y8zHZiMx1hYOJTMwsu64HENthAY+6/ZLt8odlfQS2PUx7HWZMaLd+oDcKoSkc2HNX94EfZ2yLqWwtJlha9wRQKoaEuW6xRgtTcQEf9bMWjHhW8EivadMW2+OSdcfn9QV3o2jXlVaVFaBZ9E3ITQhqiADpV4+ZH/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892980; c=relaxed/simple;
	bh=UFcw4Z5unEhmOuzPFmdNToM/QaTUqD63Nb7UFWNZFec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5enE2LNQnBiadVD8keIBcsg1ehO5BAFV668tDMPkv368lJcUNTaFkaFO8Ug+O+MVkYfIh9F8kL6VYKLOP6B5xajQbZixHuOngKqc09U8I/AWYtivpoyCyz6UBL2dsUU0m4hYgWqaj1+31gPN69WH8OWrdjGC3F9HiSoBjY90WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdVH+CxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D69C4CEE3;
	Wed, 30 Jul 2025 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892980;
	bh=UFcw4Z5unEhmOuzPFmdNToM/QaTUqD63Nb7UFWNZFec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EdVH+CxUTJ2zd4Xdn89A5SfHlldochwLZmgQgmZ31Tft6V1vKWcc5W5BNTgN0WH5o
	 7hPKPsMU0ZH9Xp9Z5xXH+rh1URzo/DyEConhW/Qd6W2svGFh5MtrT3umL/aMk07CwV
	 NbtMTjdgC8jAwao3wP58jfK8PywjAM/CHPoVhUBXkdb8EvfXdBAM8LVxjQPfBv6E9J
	 Bsg0tbWp4kg/MrN6C/DVo1YlPMG9y7EdmbjY8M8iJqUcSrZJwq2DWSeclPXSZvxmoa
	 xQ3JBhMrEf9pe4DCVLG5F9rASsrLO6Dg8QwnEXshRji/6mVYJYUDxSn0OgjCCwAz9p
	 p5LTkik6HTEjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 3/4] mm: reinstate ability to map write-sealed memfd mappings read-only
Date: Wed, 30 Jul 2025 12:29:38 -0400
Message-Id: <1753857258-5fe8e302@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730015337.31730-4-isaacmanjarres@google.com>
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

The upstream commit SHA1 provided is correct: 8ec396d05d1b737c87311fb7311f753b02c2a6b1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Isaac J. Manjarres <isaacmanjarres@google.com>
Commit author: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 464770df4609)
6.6.y | Not found
6.1.y | Not found

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

