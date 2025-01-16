Return-Path: <stable+bounces-109193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38DA12FA6
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429E2163676
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6099A94A;
	Thu, 16 Jan 2025 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJuel/OW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F4D79EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987150; cv=none; b=nhTxvDQKO5iZGNqvevWdkD3z1tyO+BMOX/qKzmcbR7gILt4PgRWbpByiRLcUw7RI5M453DYa49qcSny9Sx3n5fE8CZtW+acJjwz9uGT9QHbb5S4pLGp7p3p1yEMz0cdN5rRtkXSoi0nrFaxTWCBawmlgHEfwz1glNeiNEhCM4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987150; c=relaxed/simple;
	bh=OBzEvbiu9qYrMRa5D/FYJUAXvN+8NamPnd0sMR/aYio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bhRA5WOxAYOBVM2ba6IPuY4ITptvtlNDM4x+g9WNajYOm7DLi/dzspKEnSerG/49XPW/9932Mm33uTOgtEiD/l/f1lNne5a1ivKM88rrsDS/dxgUSD+oGdL6Uv+Mh9BOBUPNICFHbXcyZ3mGKDTkBPc3cUZtYounxsAgEJkUs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJuel/OW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBDCC4CED1;
	Thu, 16 Jan 2025 00:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987150;
	bh=OBzEvbiu9qYrMRa5D/FYJUAXvN+8NamPnd0sMR/aYio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJuel/OWd7qThony9Ld0lm9XsZt18b1Nt+qNZjYj3FOBswznCQwNgZuRwsMxTucQA
	 0xzvn7QvDKLDxRGwQ28JGgpfNR1J+7k0YknrYuJL8V1TmaFc1T9aidSKoopx1KHfP2
	 8kvEHdIGUDeaGq9YkJ3DLOJmZL+0q+0gtG8Tm+j8dDHrN1FiO/M5x9KMaeRbhJPocG
	 wxEW2CqdXWQmWG6uvUVT+/ZeEhqP+xQBeYKFV6C8c1CFe/ojpmlUhHJNaEGBHsEtcE
	 IcKZrH4Ob6HSHgqfNLIf0iWr2AJ8TyGW6pYXLtuJQSheT3wAz1f6GBY0mNgQL7XEbU
	 UeQomvRkLwjvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "d . privalov" <d.privalov@omp.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 1/1] tcp/dccp: Don't use timer_pending() in reqsk_queue_unlink().
Date: Wed, 15 Jan 2025 19:25:47 -0500
Message-Id: <20250115153726-7ee8adec75a5728b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115073532.212653-1-d.privalov@omp.ru>
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

The upstream commit SHA1 provided is correct: e8c526f2bdf1845bedaf6a478816a3d06fa78b8f

WARNING: Author mismatch between patch and upstream commit:
Backport author: d.privalov<d.privalov@omp.ru>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 997ae8da14f1)
6.1.y | Present (different SHA1: 5071beb59ee4)
5.15.y | Present (different SHA1: 8459d61fbf24)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Failed     |  N/A       |

