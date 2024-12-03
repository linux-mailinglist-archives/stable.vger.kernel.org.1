Return-Path: <stable+bounces-98158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6240A9E2D23
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 21:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11F0FB3B999
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045661FC7E4;
	Tue,  3 Dec 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3CVy1vo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A01F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249617; cv=none; b=VWffNaCJBYb5FrXWKBQr61palJWkonbByuPjdHJDHT8gNFwmqiWnCAQtRkvrgPiD43Bi//l0Y/cJrefSSe+UW0l67R5Lsx544h52AJQ87iSl3wrAL15Oxa1ZhzGR2B2PHy82k3XKF8eMpn7dvMuBeEsAbrrtQAzcVP5lEzdt4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249617; c=relaxed/simple;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQhXy6iFZPyFTFjHfkui+YNbOzcgWFT5ASt4YHqMSvdV9DxqkAE+Lv8IUf4pl9lj5s1rMZdJWHdCa17bp5InRwTNmyZiiasonVLX0wj7hYTSMGPosyI04lNUgRmnoDuWW6/q/ZF9rFFfIl5ksuyVlHxV1HWg6ZkToDzgiOHk5xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3CVy1vo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE8CC4CECF;
	Tue,  3 Dec 2024 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249617;
	bh=/Az+hhvtBqhlIbI6qoyG3vBI2JK04wplhHsjMA/yTYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3CVy1vovAe6P9DiUsDzkqy21XUYWh5Myw83wSPWgppamBb9N2OW/zbyopVxZOH7m
	 bZLfe2JMsWISJ4/CBdH4kMhwdnS6ZCGKHXxYqz4Ze8ZrHgTKC0UyLCD1EJcWun4TPS
	 U7iJP5viXo+Lq6ANPRH1qfnWFWlyO7uY9TThZb6QA4CuhVe9C8AoWcrmbSsQ9zaVTE
	 KcftHwyLDziRzJXB/8/KqhJ2jD4RROKILpCcVDNleTkIZHGxJ4Uz8XlJe/+NzVzTIr
	 hS82dbdH+59NRz3HSJJtABcTk95d2X+7DJm1jeBThXDMxHmmMW/0Z3385koB/zg3wm
	 Ue6lDHv/yVhKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 v4 3/3] net: fec: make PPS channel configurable
Date: Tue,  3 Dec 2024 13:13:35 -0500
Message-ID: <20241203124721-b3be226018e14364@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241203102932.3581093-4-csokas.bence@prolan.hu>
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

Found matching upstream commit: 566c2d83887f0570056833102adc5b88e681b0c7

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


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

