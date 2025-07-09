Return-Path: <stable+bounces-161377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B5AFDDA4
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 04:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD69A3BDB7D
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 02:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355861BD9CE;
	Wed,  9 Jul 2025 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPyHP2Y2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C83208;
	Wed,  9 Jul 2025 02:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029242; cv=none; b=SBuEj6U4Xlpg9RNOzfM735m+BVnINmXehoTidDBPM646d6bRffzFvBsEpjxeddVT5Zdeftpn4GSQsuE9DYR4mZjOA3d7prph/nEm7Y+TLbi3r9FxdVm9OEgjAAzzlFyBGABeChMOcbzHCxDvC+fe+SE35baJvJJafbaFHsskOlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029242; c=relaxed/simple;
	bh=3VgP4mJZ34ycn9lW6iroMPClWMf8x1qOlN6CIfcZaz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q/X5KblXnYdULNJ39G21T9X7Sl13RElEIz6Wpsty6I4K2vaKqm2F+paBj0IvwPYpMT/4+6qI6IzukCmOcHIny/EacW2N9uhILdKDohWCb/V7AeXRVDZItIPQrI8rnAd7/nrGxTKhTiBmB5mstpp2/28bi3a8k3ck+Y3UuiNRH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPyHP2Y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32264C4CEED;
	Wed,  9 Jul 2025 02:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752029239;
	bh=3VgP4mJZ34ycn9lW6iroMPClWMf8x1qOlN6CIfcZaz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPyHP2Y2827cUxl3b5+ERO25HxWdhDyFuNox63DJZIYeRKEySqhuQ2bShNifqKjpO
	 qjuGVKRUcKyrLsMjneEyCA14d2ngLszWvIliO/0uye/fNltEAVc/Rzv3/Ta8tadEv8
	 3JPZE+P7E5aGKni6WiShnzLKGzu2uwTTsVaDKNFzMpJYVSloXHSI3QfCSwVUVjG38H
	 cznIt9C7QNHizYDBef9Xan4Xj5KwJyrfxZobxvPxG4w5kCCw9I3P89mVCmhYq5ybmH
	 VPf7T4uj1ncQhrv3u8n0/UDylfgihVqFSGPqghyx8jXSP/lNr3f1i3PDY+PgA/M8+K
	 Ez3U5Sm5dyfiA==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Bijan Tabatabai <bijantabatab@micron.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/core: Commit damos->target_nid
Date: Tue,  8 Jul 2025 19:47:15 -0700
Message-Id: <20250709024716.58326-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709004729.17252-1-bijan311@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Jul 2025 19:47:29 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

> From: Bijan Tabatabai <bijantabatab@micron.com>
> 
> When committing new scheme parameters from the sysfs, the target_nid
> field of the damos struct would not be copied. This would result in the
> target_nid field to retain its original value, despite being updated in
> the sysfs interface.
> 
> This patch fixes this issue by copying target_nid in damos_commit().

Thank you for fixing this, Bijan!
> 
> Cc: stable@vger.kernel.org
> Fixes: 83dc7bbaecae ("mm/damon/sysfs: use damon_commit_ctx()")
> Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

