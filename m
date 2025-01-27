Return-Path: <stable+bounces-110854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E554A1D544
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEFA118875C3
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2CE1FECA4;
	Mon, 27 Jan 2025 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjBSLwU7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C51FCF6B
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977115; cv=none; b=qzN1WuJiiG4ze0aoVc3qTdPCr/yWLHfEZINIyKgEe9/tLzHht5GUIN6zA+QHxfRoQKZNxDtFU1xyYxDn+GXbD3m5Zr3VVXAoAkUS0fPBdnPBN/uHNaobNwE3xJRb9eg9lzKiHvLDcOARRMmJJ6Av01RyNau0fEg0O/BgNnp/yWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977115; c=relaxed/simple;
	bh=VMSZcDKeYyaGtJK2cgAqvBR3o1OL7BeLQSUtSlgKTcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVVR8RYh5rq3lPaA0j8IznwyOWzfbcjszZ3wl9mmDL9UJ6UWCFBzkJXyuiDSCDxpjeDC8E6F1bT15GQ6KvXMFaTTurwuzQJJmsRtKdViV3deRuWm9fFbLGgoXql5nd6hfXWu71aezfUFiXsy2+cNWVlfzmwhuloFUAeP7JrRV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjBSLwU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA16C4CED2;
	Mon, 27 Jan 2025 11:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737977114;
	bh=VMSZcDKeYyaGtJK2cgAqvBR3o1OL7BeLQSUtSlgKTcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjBSLwU7Pvqa2K30LHiMWXVeL7d5ztjuQGTTvuh8h+SArxcE6HyWoQ0I05dPHJI3Q
	 8D1rd48uHrdaoM+X3utAPTH368Y8RuKdx7UFEd1pocop3KsnzQxcRgfuzZ8wyDzsxk
	 q4WfAfBcfV4Wb7pt1FdEqLDzkdZ8hSRqO8cStouLUpkID0sP9kjOwqsavUkaijisDF
	 u73NjoeNM/g8ldArTRnv+5Jkb6Pu089flryFDgcdjdxxU2nmm8kbmoeO5YInoSxOMS
	 rbKV1wjS4L0gxHOLLKeIABvy7Lqyx7moCO3o6FCdPWCKtd8bCcR5PIU4fNeLZ3ceLx
	 8O9SR2+WnSGhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 2/5] md/md-bitmap: remove the last parameter for bimtap_ops->endwrite()
Date: Mon, 27 Jan 2025 06:25:13 -0500
Message-Id: <20250127042050-8c42327b37d3cf1d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127085214.3197761-3-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 4f0e7d0e03b7b80af84759a9e7cfb0f81ac4adae

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yu Kuai<yukuai1@huaweicloud.com>
Commit author: Yu Kuai<yukuai3@huawei.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

