Return-Path: <stable+bounces-127686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2A3A7A71B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECAA163A83
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1D124CEE8;
	Thu,  3 Apr 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MscS55rq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C824CEE2
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694731; cv=none; b=J+xwEwR8DttbGcMhi4s5g2wXv3U1STDTLRFWR094H62ljL3wKowR2Of/iZVBUwdPx1U2RzoQ7EYppNqVEycDOLjPC/KieYn54MJaoyClnJLsBwVDx6oyG93SKaEZTdtmM2TcBNUqhkvVOYCJGw5zpaSxKc2mEEmpCRnM4E32rQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694731; c=relaxed/simple;
	bh=KZ9koFTvcMWwplN9jcQ6vgHauVNNdDkzSKiI6F2yJLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baPwDZflc/vIAGUiucZ7CyYTcgbDygl3TiJpFAC5ZRA+JW5lkArGi1y+afzK6eG73ukLMYFiLO/TKKtSYhAFavimGL8CnqQdfRIiPIHikI0kil3vgak2hIhIiUC/1aCuAGsSMB9UVQ04dpcCx1gIskmUrMQprGhALffn0+/wQ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MscS55rq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D68C4CEE3;
	Thu,  3 Apr 2025 15:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694731;
	bh=KZ9koFTvcMWwplN9jcQ6vgHauVNNdDkzSKiI6F2yJLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MscS55rqH33rlfRK0XJek5Sam9NJYsqEh/+S7jJdZHvCXRgtcbR68zXhsBKtGdwGb
	 plphK1gqs4madcfPsCPlErWSMm/PPADzK8NEA2XN68x8L0LrM20gH6+4eqCRTKrrPb
	 Do1mXoaElZec6GwSadmGcQU/AC0XiBKDVikrLH07FBZfKvwk2/AVu/47kXWG24l/eM
	 x0/N+unAz5iFn9J0DHidzrUj3q2prx+MWFKK0SBx3r54B0GlUAvEOhyhT/2H55/Lhd
	 Y8Oj3Y7FwKkzWpBUERGfhtXuVrrIl+5KDZFBSXW6dGijrqk9zxKTd56xhRiPHCLKBP
	 zscLzRjRL65+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	xiangyu.chen@eng.windriver.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/2] smb: client: Fix use-after-free of network namespace.
Date: Thu,  3 Apr 2025 11:38:46 -0400
Message-Id: <20250403113756-8c51a4e8bdd46433@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403064736.3716535-3-xiangyu.chen@eng.windriver.com>
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
ℹ️ This is part 2/2 of a series
⚠️ Found follow-up fixes in mainline

The upstream commit SHA1 provided is correct: ef7134c7fc48e1441b398e55a862232868a6f0a7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: e8c714941811)
6.1.y | Not found

Found fixes commits:
4e7f1644f2ac smb: client: Fix netns refcount imbalance causing leaks and use-after-free
e9f2517a3e18 smb: client: fix TCP timers deadlock after rmmod

Note: The patch differs from the upstream commit:
---
1:  ef7134c7fc48e < -:  ------------- smb: client: Fix use-after-free of network namespace.
-:  ------------- > 1:  459e4f5660c21 smb: client: Fix use-after-free of network namespace.
---

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

