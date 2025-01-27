Return-Path: <stable+bounces-110855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D127A1D545
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 12:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6253A5867
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 11:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEC91FE451;
	Mon, 27 Jan 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhyDn4QI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB971FCF6B
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737977117; cv=none; b=uCcTcIK5Zx2dt8t2xqLszq0enm1NC82sqoM4tJIyagjPaI7/dIgaUB5DDBoAUy8/UfU39gAYn4iLf6SjBF334dA9hRIIQZwVHGSUdVUhMjOe1XQZAjIzb6H+BLDwaZfNoUz7b7T9fqUa/zOQXEY07no5XuEzaunVfOAFpDvhtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737977117; c=relaxed/simple;
	bh=1wDVLjZkqC4DV3cCPsHKMLUN4ro4IiF735T4oLai+Pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q56RCz1Pl45Ply4vN0XhkzTm/Q6p23ynTLwduixyamjnGpq7xUfpF2S69YTyEhAI8MsKyIjpxZAaMBBzuvEnyQHlaeRaQEUBq5zq0pHuT+VwzaSRiVMo8htfUAGnLDpmM/RNlf2dyy6HaLbGJpPFy1rC+yWJK1Xe3ZpZmXPCExo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhyDn4QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AABC4CED2;
	Mon, 27 Jan 2025 11:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737977117;
	bh=1wDVLjZkqC4DV3cCPsHKMLUN4ro4IiF735T4oLai+Pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhyDn4QIpLi9e0QRBQxzCaR0w27Ri5/9tVBuVQ/LO/PYxyV+NUgheJzGdWXYZZRCd
	 1J1RxnUW57a767w3VvSCdL+Sx0n2LtWS9xO1+GNQWK699zFQfbSKS/5FEKka7Vqjwl
	 ezx3udTkEAA5bkudeEjK5LcE3TptgnkC7juAb9Jzx9iNOGlq2ABDgymKQywsHFJnIi
	 KrTWU7Pn2oJrmHhFssanMVin6IUmVDBTfwmjCUk+AFfxu3fYNnkJ9nHRV+mbu0Ap3o
	 C5hQsHX+XID1VgM89MnnVdoo5v3aeI/1nF5QIH+Xfe7XMUptdrud5l/SQ0zkBj5yX4
	 ywY+om0HappZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yu Kuai <yukuai1@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 5/5] md/md-bitmap: move bitmap_{start, end}write to md upper layer
Date: Mon, 27 Jan 2025 06:25:15 -0500
Message-Id: <20250127042655-23e1158f105baa74@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127085214.3197761-6-yukuai1@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: cd5fc653381811f1e0ba65f5d169918cab61476f

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

