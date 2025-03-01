Return-Path: <stable+bounces-119992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74888A4A882
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 05:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC007AA611
	for <lists+stable@lfdr.de>; Sat,  1 Mar 2025 04:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2997192B82;
	Sat,  1 Mar 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgmPiQxn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8269F2C9A
	for <stable@vger.kernel.org>; Sat,  1 Mar 2025 04:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740802869; cv=none; b=D5HD/t0l38pwVyGFvcZVBOhYf7ogK60KNPlxshu3xI3G7xZ3k/9kGjtItcyQckzmZuZgLyzI4FAICOckncDhWz5zHS9YvRupF4MqtYMsDJ3W9yS4COdFppIcfJ0uAg7fz+kTzs3jXxNU4fSMoOD0YNrq0fH4tjwkek/uiqKKCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740802869; c=relaxed/simple;
	bh=GgAk44fiXzEYXgqufKGkq5O5avGMu4N3hNvfbL9lwKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O2+1xGWHoCzisq7Tqend7CIn49/wmgW51jC9PzBwawoTNJKbo/RUrcF0whX/MjyQ44do+RS6U6TTKp8h+nbz4uPHwiugzMzL1mFwvGgHAAnI25MfrFYeMKx5I5JAHB623zoB4Og3HsjMUcol1VIq9EK2WxjCTT/qZWMr0zTHRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgmPiQxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1381FC4CEF3;
	Sat,  1 Mar 2025 04:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740802869;
	bh=GgAk44fiXzEYXgqufKGkq5O5avGMu4N3hNvfbL9lwKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cgmPiQxnMS6Mf3xzXs4Kn+zrC7DVLl48z17plcGaCd4GfQazBzifA2f3S4M0LbROV
	 6+pcPPuhVi1wnrsfGKEk/jfrKripEKcAwmwMcytsYgkEdaiNiXXpvRiMjzClP+RVvh
	 jQXKMxt7PxlFwcLs3lbX2P5FtjNmt3KZcrXbbuRykxyM4zybzyc7YL5pZDb74Gmrde
	 Khlxeqc7KP8lTxvs/xCqx+PSUz4Oox0gWeaxRTC4Jx/SnVxHT5ZJtHKVtF9Gs/Tpo1
	 fPtmtbft5OY+egaHFAhr/OUIz44kkcz35iu8D8OsCQfB+vii0gfh8rD/z7RfuvwA+y
	 GR0nFFaiPQd4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	tglozar@redhat.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 2/4] Revert "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads"
Date: Fri, 28 Feb 2025 23:20:46 -0500
Message-Id: <20250228191048-d5bd83ca91733c18@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250228135708.604410-3-tglozar@redhat.com>
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
ℹ️ This is part 2/4 of a series
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

