Return-Path: <stable+bounces-111918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C47AA24C32
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E583A47D5
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556CD1CACF7;
	Sat,  1 Feb 2025 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBdKGiRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155F11CC881
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454016; cv=none; b=X9Y4UxM7Jmy7C79UVRl3ARsHDu+1whgCUAcWeqGsMP6dLZMNBxmhml16eWxBa/t6DTBgVfD5tJ1pniHu6o8aD4An8UxoAcYh+twuOVJgXQto+28Ps5rDX2zgdtY3d4vmvQvcQBM585jaBzeAOkTnr4u+ip6ONQVEDEFw1pH4vgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454016; c=relaxed/simple;
	bh=mX4hcQUv2gtnEkqFIyjJqyFDiHKYgk1XIuGY6lDySso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDLr8zehYyg7CzNhwu6l2+bi60fkE/oSacil7lmDSObf36j+fercaG+KkrZjsk2B4DN+uViQlINBLh10wBb6M/3FoKPwnsHT5UqiKl1MU8zA4MWpHSOkcLL03NGjcET4y59ws2UWyBaMfCfAwM9+cK0/FsPT94aV+5dU10RpLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBdKGiRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B48C4CEE1;
	Sat,  1 Feb 2025 23:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454015;
	bh=mX4hcQUv2gtnEkqFIyjJqyFDiHKYgk1XIuGY6lDySso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBdKGiRngROuxTMJJobX+TNGaAeHvR9ODRusC33D/AaUg/gcI3ZT3OyK520xH8G+P
	 qpqdr2VrmXcCEkdsHapwSGxHrlBPfrkz1R+lJd0T0BPS+pVG5uNtm/K2qq1yizThOo
	 051YCTUSo8mRwMwi22QlMVEcYeDglzx+znZe5DeWWPc8Jh/wmrjTIiH/IVVkABHi+3
	 Cn+8ONag/Y7Rucd3qsghI89R1ttVmbFPtparYmzkL93+SWv4x87p7rMvX2TKjnQwnv
	 9GP+9t9spjqXTZrOueKENoQ/x9+slFcFtWj1dJ04f/m7MzGVLGJiFkIlXvmyljSLTx
	 AlUQcq3I9qDvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Leah Rumancik <leah.rumancik@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 17/19] xfs: dquot recovery does not validate the recovered dquot
Date: Sat,  1 Feb 2025 18:53:33 -0500
Message-Id: <20250201150410-4d8e3259eea92028@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129184717.80816-18-leah.rumancik@gmail.com>
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

The upstream commit SHA1 provided is correct: 9c235dfc3d3f901fe22acb20f2ab37ff39f2ce02

WARNING: Author mismatch between patch and upstream commit:
Backport author: Leah Rumancik<leah.rumancik@gmail.com>
Commit author: Darrick J. Wong<djwong@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3581868f51a2)
6.1.y | Present (different SHA1: f3eceedfd713)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

