Return-Path: <stable+bounces-100027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C9C9E7DFA
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 03:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CC916C688
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 02:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0985417758;
	Sat,  7 Dec 2024 02:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt+wkzdl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD973FF1
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537239; cv=none; b=bbHRnfLX5P5Wz39agOLA4N5zkrRFOD/LGsNl7Y47xa+bXz4+3saR0yILp5HT+0a+NdkErDZinOUYXz5Foax9omX9XgbDd3nLc5K9lbvJeCRTc9xSNOtqJL8y3Oq/EwGp90SGCltuGBbmIL317d/tZAJ6Wm/1DTQFEW6a8/wYjX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537239; c=relaxed/simple;
	bh=qeUvXBdUsvsPSWt6D3Af2TvcRwds5KMGodLYHrvIJ4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rD3fMl9gT4IjYdIcLYCmAPvgeN5cEPfki7eNvr+unXV7NhX7lA6VK/3UvFyjF28s021iO2BIYcGH/3cVgu+YpspJuYZF0++UPoowY7z4CibBBX83IVA4qZFi0XdYxNSljUJhrODocT69wlMzFGlNfRwCjE6rzkhI45MUy7O0XMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt+wkzdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260D9C4CEDC;
	Sat,  7 Dec 2024 02:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537239;
	bh=qeUvXBdUsvsPSWt6D3Af2TvcRwds5KMGodLYHrvIJ4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mt+wkzdlrLBVIjciFlGojpmFHZrKQkeo6k7if4i4RAqmcx1v+ZnkBn0P+0lw05/E/
	 DVGN9Da9qE4LRGLuisdDcYASr1ncDmovHixy3+IDy3g3+NRJwMhFdEKVmW1RfozE0v
	 7M0vzjZP9egrCHLLu/6K4iV/4veWYCu+/DBLsWN06KE5v2hhiMck5oD/joNijx2auM
	 cZNZOXAz/QMstIAhTsxquJWDmE3aBaAKSmlfWwUX0B6247axPWxpMqlGUsh0Nx/SrC
	 DR4bI1sPSxXSL8L4jrKB3fTPSRDWS8LH/7tBOi6PEtJs3YoLFhRDojRnn4CUJE9sF5
	 d1fE7Cxskbw0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: SeongJae Park <sj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 2/2] mm/damon/vaddr: fix issue in damon_va_evenly_split_region()
Date: Fri,  6 Dec 2024 21:07:17 -0500
Message-ID: <20241206190745-abe441e38c8b001e@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206181620.91603-3-sj@kernel.org>
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

Found matching upstream commit: f3c7a1ede435e2e45177d7a490a85fb0a0ec96d1

WARNING: Author mismatch between patch and found commit:
Backport author: SeongJae Park <sj@kernel.org>
Commit author: Zheng Yejian <zhengyejian@huaweicloud.com>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

