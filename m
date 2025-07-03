Return-Path: <stable+bounces-160103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702F1AF8039
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 20:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9103A15FC
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 18:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB12F531A;
	Thu,  3 Jul 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmpesC/3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34672F272F
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751567685; cv=none; b=WIZn69xFIPPp5EAtX4h4Xr5lUB90OX7ltOYJlTu9zUH1mdvuHnSv4IxhqLPSfU0j3L7egorjtZqC9UTHYvJuFPpRVv/JoM/PuXAHQyp1yvYglMWRSbPQoapDL+6NfJ7aBdCIHAAmeasHL9MSoanWoV+VqmpzPxIuAebEFX13WQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751567685; c=relaxed/simple;
	bh=UVp/F5J/5TYmbwu15wosk7xWVJeyw9xHb0Zv/y/xOsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZKVzHQ+MvmFgZmMHTgnnBV/40KDzNJh1P1sGhG4j354i0Q3vLd1V9MHhWfVV8bDoJ29LelZ6pNNBQDMVJF+iSBAKy1cVOkm0kRE9FB9JdCNTBAle3XjxitFlrK0+FJJUf38Ntt+09embp/1ZW9NLc//BQ48CtNlhJz2rhwsleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmpesC/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3342BC4CEF1;
	Thu,  3 Jul 2025 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751567684;
	bh=UVp/F5J/5TYmbwu15wosk7xWVJeyw9xHb0Zv/y/xOsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UmpesC/3D6xEgl8gbtwBkSEKksVaAk7bcblRsKFY4AG6OGwqVaWVkM0/+Nkpqk1ro
	 jw8VUfyFXfSLV92fcbCypjeBCyr4TUURl+fnbaBwovZw2zuk6XAaEZdukRXUQeC2d6
	 fBDFoD0e4etHAKyjJgjcqMmk57pOhKemz5jKub9rW1gA/zCeJACALaFPkFWEq50sn4
	 M5LtGln2uMjJB9nP75WIi4LM6R2sJSA+hRBV4CaQUjS7UDKZRdfz3e/KHV8qhxHsme
	 p103qk+pYj+zeXVleO3zri/vugg+/KEn6G15FFIJBLTrFjQNfU0wmqz2qXLfvOtFvI
	 oXqePUlbZVfig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xinyu Zheng <zhengxinyu6@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10] vhost-scsi: protect vq->log_used with vq->mutex
Date: Thu,  3 Jul 2025 14:34:43 -0400
Message-Id: <20250703112547-6bc1d2921101421a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250702082945.4164475-1-zhengxinyu6@huawei.com>
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

The upstream commit SHA1 provided is correct: f591cf9fce724e5075cc67488c43c6e39e8cbe27

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xinyu Zheng<zhengxinyu6@huawei.com>
Commit author: Dongli Zhang<dongli.zhang@oracle.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: bd8c9404e44a)
6.6.y | Present (different SHA1: ca85c2d0db5f)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f591cf9fce724 < -:  ------------- vhost-scsi: protect vq->log_used with vq->mutex
-:  ------------- > 1:  4cd7a98212613 vhost-scsi: protect vq->log_used with vq->mutex
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

