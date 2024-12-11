Return-Path: <stable+bounces-100667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7190A9ED1F1
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6A881882D9D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D974D1DD9AC;
	Wed, 11 Dec 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chl+mAv0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE61DD9A6
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934780; cv=none; b=X8F6+yijblBhIRzD5LMrlBRT+mwVLEvAYnNJRgeIFVLon7q4JucoDgAtsguFes4SB+tAN/C0Bb2hfJTdSpiGkoMPX0+6kXKB4E3fCmCa23vjYB24TJWWe5UmdkxJS8GcgskQFLJfmZzVvfHIQjS+BWVsYtMJ/Y6LgwppoFuE02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934780; c=relaxed/simple;
	bh=gF3UlUEUBec8AEbQ/umcuOCuPeeMebLxQnwL8fT2bb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vCs047D+TLvqvBEfny8kByyh2nbpf5Yg0ULwODQgFL72lCX3Mfr0As33kv56ZWp+y39sKKmagqcwWmtb/WiSnfIEuej/gjExFzDdWYD2ZdMZudDjno7wJtie+kD7J1xyEudmSlK3B/Lqjg2e8bDTBzmgiCOUFXu5LAF/mss2UAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chl+mAv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07053C4CED2;
	Wed, 11 Dec 2024 16:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934780;
	bh=gF3UlUEUBec8AEbQ/umcuOCuPeeMebLxQnwL8fT2bb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chl+mAv0iZRzyw/K+nRgUxDn4CFl/Bxixjg4c6x0Ty9HLZ7sLjB/XoTusWUtkPUVI
	 fFBUS7SQxnAz1kpG65CyKPe4pU+XARchbMst7M5E9ljmjWd4Ai/S4YaN03oFHUivHN
	 i88TsEufzThgyrNcE0Tu3YiPs2xlA9XAez/Q+udaPZPDmVoB2aPSJhEjt0gBZA7DN9
	 Ppno0VnOa/5mmX9XH5qhNb0+TcR/p3d9h3hDsnxAOO6b3tM9akxZTAXsKKdTidQCAM
	 hmwkaHh/L8sW0IJn3bzNYpbNHpTWdvVkRlhmxNYopir4VPglwrUNTgfrmTblyZ+i48
	 eXgYLBEr9V7pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] driver core: bus: Fix double free in driver API bus_register()
Date: Wed, 11 Dec 2024 11:32:58 -0500
Message-ID: <20241211102107-494acd07af72d497@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211101338.2070869-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: bfa54a793ba77ef696755b66f3ac4ed00c7d1248

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Zijun Hu <quic_zijuhu@quicinc.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: d885c464c250)
6.1.y | Present (different SHA1: 25d339a6e63b)

Note: The patch differs from the upstream commit:
---
1:  bfa54a793ba77 < -:  ------------- driver core: bus: Fix double free in driver API bus_register()
-:  ------------- > 1:  eda23201cf4ef driver core: bus: Fix double free in driver API bus_register()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

