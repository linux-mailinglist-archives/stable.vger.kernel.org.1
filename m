Return-Path: <stable+bounces-100047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D329E802D
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 14:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90D9166D8B
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 13:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2925D1448E4;
	Sat,  7 Dec 2024 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiAGTICv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC391DDEA
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733577906; cv=none; b=LvhM/Ii1YcGyu9YWZwQ9rgdCqN59ilpbt+kaODihZIvvWZ49985jKV1h7jiZ/6EWyFp7Ndv4cpgbSC/IhRg8tayoBrdZHzZ/W4+GMpVJEl0UF4Q1/ok1gJoKn2P1DTfXO67yxXhXbQ0cya6FjxbHC0YGe+Y3oia6qRgurxe+U48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733577906; c=relaxed/simple;
	bh=h+EWEMXckDsXhnpL4PeuGyTMaZzWXohHR0kd89GJsQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRzVj2F8isEdsV/dnndNFs5Dffq5zMq3aStKvYU8mqyCRRKfIYh0wopIEhNEPricv3C+7fKHa4J9a3Yla5HAYMEXYwf2X7nrtgJLYyrdkxMb4OHIcuFVUlB0VYKuirOjoSkd3664IerMsFHc05TGqKlPtJt+xmL7ZdgyeygG3pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiAGTICv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF17AC4CECD;
	Sat,  7 Dec 2024 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733577906;
	bh=h+EWEMXckDsXhnpL4PeuGyTMaZzWXohHR0kd89GJsQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UiAGTICvQuWKfpmG3s5RNTLGFSNhl0OWrrgwZtYk8BRQEpvcUe7WPvFd2ROjypEuO
	 NdTGccp0TYm5ASGHx3kjwxgN6zH5sy8tEI4qkvmlYBVsY+cdIg59wJH+wAjsCRDE7h
	 wHRB+7Z43NAPlNHPzYPwAzxGGf72ejq7tXw0ae/jm5QZgledJ7MJRloIBZwcS6+Uyu
	 8+D0Wj9l4mzousu4pBbQbKgbhwJYZdgrrAnH1nUcZD/UsIeK5CV4t5GrTm76a245Sp
	 oQR+86TF3PYeT5Yi2SUkTvMq2lzgcvxaDelEQZkjRDupXMAi91zw4/z+mhOMUdDtqL
	 M63o/HII6K3Zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 v2] media: mediatek: vcodec: Handle invalid decoder vsi
Date: Sat,  7 Dec 2024 08:25:04 -0500
Message-ID: <20241207082134-e84e4f54782cf198@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241207112042.748861-1-bin.lan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 59d438f8e02ca641c58d77e1feffa000ff809e9f

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@eng.windriver.com
Commit author: Irui Wang <irui.wang@mediatek.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 1c109f23b271)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  59d438f8e02ca < -:  ------------- media: mediatek: vcodec: Handle invalid decoder vsi
-:  ------------- > 1:  51597d231df9f media: mediatek: vcodec: Handle invalid decoder vsi
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

