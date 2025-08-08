Return-Path: <stable+bounces-166879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C661CB1EDBE
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 19:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385993BE883
	for <lists+stable@lfdr.de>; Fri,  8 Aug 2025 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C91E2606;
	Fri,  8 Aug 2025 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKBYKVMg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC191E00B4
	for <stable@vger.kernel.org>; Fri,  8 Aug 2025 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673671; cv=none; b=bkptgHoxpQBDBLuZl04fuRNGWq4PVeWpA/yrBs/r00JfrxVahqkQQC1KjpGV9TcLf5NjHwQftwW9t9vbiWwBhxMAGfWLQycTBgzfxLcXN4bBygTjo1NzfD8IS50ycmkDZUlwNDO0RPSHknSxvQt0tfHvCauKUlCEnJa38f2gFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673671; c=relaxed/simple;
	bh=V64WQAfHjyP580LdGYzip4UsKdzR75tym+XhLSmS7X8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSYN3UjF4O8Il6O+zQ36e2nS4xnTxwczBHFnCfELBgkzkiY8mPieXVj3uXxc8XVkgBYpylQCVqSAE5dfS7DEqcA3ArisW8CZI9sgQFYTJm/7dbbXWxTvmDpSFS1OqkF2NWB/mSDwl8GD9//MVvTG5W9EEIqLm64r6rIyLEmpiOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKBYKVMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB05C4CEED;
	Fri,  8 Aug 2025 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754673671;
	bh=V64WQAfHjyP580LdGYzip4UsKdzR75tym+XhLSmS7X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKBYKVMg7YlLB+G5th+hLkQdcVlIHDAeRv5sUVGAkEnm82OSzf5EuaYlndeU1Kbs2
	 mVes5tEeppKBntR9EoKEspKhZvi8CWebDgMcz2mWMFiD8C513pBYmruDYbgyve5XO+
	 eepy7MY4pmNpi2Q5PH8XCaHUQ/fhCJHIXy9mUdfachxdT5Edb682ifoz0/kdxnT6ID
	 9cH1ngYZkFPC7NIjheOruCF3YFQ+ERJ+VX50zY+nhLgXPt6ATsYDkDejyJr477m88f
	 ZoES10kzFXkE/2D/ykiA42/2HuxRKRaAeL32Ysjefrt0YJStB1hmBuYKFEWThpulOd
	 n4J+Mv13p3lqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v2] ice/ptp: fix crosstimestamp reporting
Date: Fri,  8 Aug 2025 13:21:08 -0400
Message-Id: <1754608665-d0efc2d5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807-ice_crosstimestamp_reporting-v2-1-85746f1cf9f8@blochl.de>
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

The upstream commit SHA1 provided is correct: a5a441ae283d54ec329aadc7426991dc32786d52

WARNING: Author mismatch between patch and upstream commit:
Backport author: Markus Blöchl <markus@blochl.de>
Commit author: Anton Nadezhdin <anton.nadezhdin@intel.com>

Status in newer kernel trees:
6.15.y | Present (different SHA1: f20899b1a877)

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-6.12.y       | Success     | Success    |

