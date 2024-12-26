Return-Path: <stable+bounces-106118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7859FC759
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 02:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC4C160205
	for <lists+stable@lfdr.de>; Thu, 26 Dec 2024 01:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E588F49;
	Thu, 26 Dec 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI7v2N7V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BD4C9F
	for <stable@vger.kernel.org>; Thu, 26 Dec 2024 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735176118; cv=none; b=JNWCtWFpnARR8dxQnu2m1nRX2ka79vBu5Hsj39GxcOK1ouArQWS4JGUcyHnv4+WPLcJdiOh7uG0nE+MIiQJbUbZvtafbGCWsAdKKWmnWyA/hAWah1bMFNUi86R3Zuft/kHEDoI/DpR6kfYNzp/dJuKLwq4ZY+aA5HNhWc5I447E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735176118; c=relaxed/simple;
	bh=6vmcjOR4T+uKoZLsPmy/R5i8LQxbX/O6Wd9x66tZEno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGjskuRnpAPBs7TqfXqU6Yz/Czxzy0LbzdBy6HYLsroxG8vidyJGNcAuoa3LFJ0ztMmg4OCMK7+Em8ZwFnBS0ZzqK0TFs+KgnYFndaDezv+Pi/eAeTXqri+Tn5rRreKf+buddI3s2Y/I/9PxLb8/VM2v5I+eKF6AbqQNLJLNt+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI7v2N7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4B7C4CECD;
	Thu, 26 Dec 2024 01:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735176118;
	bh=6vmcjOR4T+uKoZLsPmy/R5i8LQxbX/O6Wd9x66tZEno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nI7v2N7VVWnrOQnVkShfbeWUMdSbutd8cGj/ikgSket61Qeqfagxx3yMs+fQ7XVFM
	 knbFfM/R8kjiV9DQRDtstL+m/g6ZjOJsy5kBdegF4aFX2YwDYQQbq4m/eAH/H1C6KZ
	 /NzLCtI0nCmb7dN17arWzhFkG0GJ2cmBXeUtmXD9YvbNcBhbfky5s7ATd54KNd+U7C
	 K/n7n8BAV4hMAqoPYLb0Dnluc/QdpYLzY3nFCdaUmzVONjYoA5P3FLy9qjiFxWSv4v
	 8ItKTcHrmCPXazG3IDN/obY72Dcwzpxai93eS8fsFInNivgm4Gq1GVdeYQ0NaRzA4M
	 VViKvEogQtdiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] vmalloc: fix accounting with i915
Date: Wed, 25 Dec 2024 20:21:56 -0500
Message-Id: <20241225183106-cee20b35fc2f9d72@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241223200729.4000320-1-willy@infradead.org>
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

Found matching upstream commit: a2e740e216f5bf49ccb83b6d490c72a340558a43

WARNING: Author mismatch between patch and found commit:
Backport author: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Commit author: Matthew Wilcox (Oracle) <willy@infradead.org>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a2e740e216f5 < -:  ------------ vmalloc: fix accounting with i915
-:  ------------ > 1:  e85bcde84558 vmalloc: fix accounting with i915
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

