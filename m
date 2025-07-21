Return-Path: <stable+bounces-163597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D482B0C5B3
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75D617A22BB
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B8919E826;
	Mon, 21 Jul 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTMv7OhN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6D292B22
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106352; cv=none; b=I7iy/nXdj1AHQxb/RgOst1zBdK1OAc60uuJRpdOPA8YzO96XCi/gcsXukzmznKeKFHgqENoxZ5CxYq4bO/5v/SP8+bzN+04WJ0J5e1Dk8pTcC5Ut2L/ZzU8wsBjwAFlkpC5cgo2vhoWQ828Ye8R8JalDJfOYGwOTgEJCX9m1DY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106352; c=relaxed/simple;
	bh=1PXIpG3zl9X52KCcR05u5C3/QO8UDELlLS/bgN9W300=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MVfNDjiEZt1/v30WlrGXG0dcrtJEu2i8pcsFe66A926M1nJ6ZpK1cRq8UsNBrPdNetpFDXhktkp1xc+XaVxTWq61Og7g0LwkrufSZXXwyDPy1tLKr3JEnSi/RMH2Q1s4RBCG2/NgJzA81QSVcBu3BaO69JcQ4NQTH7uw+8Nxf08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTMv7OhN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761F3C4CEED;
	Mon, 21 Jul 2025 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753106352;
	bh=1PXIpG3zl9X52KCcR05u5C3/QO8UDELlLS/bgN9W300=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aTMv7OhNmxE7rVhN8IDW6KxdTuX/UAyeXrRJ+NICmZSJCsWG/Bn8kiGWbOVEc4roo
	 G0XJwP2mRfwHNSH+T1DB1F0O5JzoZd6TfKKr1/puYXWqAhwIFDbe9hST22VM45JYMJ
	 TpE7zP3ocwbA5sNEVbIZD4Gjnr6nrzmDgyTXpBjRDO72utqus++qHOlq4va+u1mvJV
	 hQG/uIE+8cWy7PEhtXEhDZx31YEGx0as6Nkrjz7Gh3/B42FDdQD0ZcJhh8vI093lfx
	 Ycp8jIEkRrZpHkD0FdnXov2Ki4lqoi1634zDIbvovwhkJ39HAQBWNeg6Q4VDbyZU4N
	 AzvIMbV1ukXvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 1/3] power: supply: bq24190_charger: Fix runtime PM imbalance on error
Date: Mon, 21 Jul 2025 09:59:09 -0400
Message-Id: <1753105031-77ec7779@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721114846.1360952-2-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: 1a37a039711610dd53ec03d8cab9e81875338225

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Dinghao Liu <dinghao.liu@zju.edu.cn>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  1a37a0397116 ! 1:  8755abaf563f power: supply: bq24190_charger: Fix runtime PM imbalance on error
    @@ Metadata
      ## Commit message ##
         power: supply: bq24190_charger: Fix runtime PM imbalance on error
     
    +    [ Upstream commit 1a37a039711610dd53ec03d8cab9e81875338225 ]
    +
         pm_runtime_get_sync() increments the runtime PM usage counter even
         it returns an error code. Thus a pairing decrement is needed on
         the error handling path to keep the counter balanced.
    @@ Commit message
         Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
         Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
         Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
    +    Stable-dep-of: 47c29d692129 ("power: supply: bq24190: Fix use after free bug in bq24190_remove due to race condition")
    +    Signed-off-by: Shubham Kulkarni <skulkarni@mvista.com>
     
      ## drivers/power/supply/bq24190_charger.c ##
     @@ drivers/power/supply/bq24190_charger.c: static ssize_t bq24190_sysfs_store(struct device *dev,

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

