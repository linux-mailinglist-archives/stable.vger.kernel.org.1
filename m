Return-Path: <stable+bounces-108590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB78A10704
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 13:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892FE3A3E52
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 12:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F004A236A94;
	Tue, 14 Jan 2025 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amoKAnm6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEBA236A91
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736858636; cv=none; b=aF0z1laokbw3/GTK7OrQnPmWEDCTgRtpjHx44SXhl4TLxynrzTtebehb1LCrYtlx0c4sF6/mXPfWz211GFy4vCaEUmb2ljdE4t6qSovRNdhtzOZxeQIAyVFllqgGub7Bhj8qqV5YTOcXHQodB8zncWkn7jUFuBLkuVCOYC1Nmcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736858636; c=relaxed/simple;
	bh=fhfDfibzxCHxD/0yVIUeWHUSwQhP8o7RLp9PikAzncw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tRNAKIEOY+beqUAmHPnEgXuKmlSguzITpL3urBqE2dpPZCVLA5UM2khjjiqM8KB111yqINPCdiqlWZ1lcSPPqhzRrxLiG5cquCAJ5wPryKcX0M2pIRNFv/ia1K/B5A0Y2pNq3tFP0N9hEEAJrrlx/KbzIe5Aw4mmSZS2NbqQCoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amoKAnm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99C1C4CEDD;
	Tue, 14 Jan 2025 12:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736858636;
	bh=fhfDfibzxCHxD/0yVIUeWHUSwQhP8o7RLp9PikAzncw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amoKAnm6LqYP7wfstcDE8ei/04di4PFPLxPdtAS+jMAFoXh/vNeReuuHmJ46tW7i+
	 Vz0QIce8PaKdXh/T+HIAhhkdFpNd0UhWSrpnNNF6gLOyAP8eiTtuRSzXhUb8el/6Qw
	 iKgUKB+x5/Ik45FpP+07TAK/S4NH9RsrCDkgg+7cvsx0MV3WrdSGOilTifHSlELZw4
	 ASlNNbq2zrrjBmIueG75kvgMoH8W3vyA4Oz9zRtaxOL3xfnOz4WxogtULlF+m3SGFf
	 1nPVEpNK+UUHmnicYURL6iOiMpO+zo66O5In2+XscERjfmqgdQKD6s0Z7c+vi7NRK/
	 oj4RAy5rL1BzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: lanbincn@qq.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] RDMA/rxe: Fix the qp flush warnings in req
Date: Tue, 14 Jan 2025 07:43:54 -0500
Message-Id: <20250114073101-d2f9eb44d297de58@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_92588BE248C1F834ECD126D5EC7E0048320A@qq.com>
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

The upstream commit SHA1 provided is correct: ea4c990fa9e19ffef0648e40c566b94ba5ab31be

WARNING: Author mismatch between patch and upstream commit:
Backport author: lanbincn@qq.com
Commit author: Zhu Yanjun<yanjun.zhu@linux.dev>


Status in newer kernel trees:
6.12.y | Present (different SHA1: cc341b5d761a)
6.6.y | Present (different SHA1: 31978d5c5aef)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ea4c990fa9e1 < -:  ------------ RDMA/rxe: Fix the qp flush warnings in req
-:  ------------ > 1:  cd4186530dfd RDMA/rxe: Fix the qp flush warnings in req
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

