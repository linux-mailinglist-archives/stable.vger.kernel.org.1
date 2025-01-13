Return-Path: <stable+bounces-108542-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5C3A0C53B
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1AC7A3856
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559741F9AAE;
	Mon, 13 Jan 2025 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9a+DmJu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C931FA14A
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809749; cv=none; b=TUqnpbyLQiJpTnn0eyPz7vQgWYovd+6pRWx9H4M2vfBBd3bW+BeuCsf6ojH4f789Daww/AVesiriGkpplyYPjAamsFTOztTnysR9klUNRVnzGG1qjgIkTp3uMhN+dALxerJAZoxdRsyjnhdkg62a2nhxKzYEVgNpSqNHRjbvZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809749; c=relaxed/simple;
	bh=mafGMWejxy8C/3xjqayseh4Aijm+ww4WfhTXDq05Xz0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XU2GQFidojo+NvzX+2F0ZWyEMO51UU06JfdtYjKC2FNC0OY8rW1Bgktw+YSC6PNg6acXgO6ftcuQ7ccjNRgtcOAjqobYEqOhqxtnYz+FpXUjKLIMO+6Dp1Ek64n9WiC93a/jrLr6vbkaOQr1YzEBBGfgpJIPpSh3FxjbiJVoCqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9a+DmJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72AE8C4CED6;
	Mon, 13 Jan 2025 23:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809748;
	bh=mafGMWejxy8C/3xjqayseh4Aijm+ww4WfhTXDq05Xz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N9a+DmJuaGdOKfzVynoFoLrIAYwt92MJokq2jWMrxb3UHPqPRkqKvdpvFQjCayc8l
	 usXH6vAN9VGD4XitMEh6kfMMbOqiB6escj8qn9QOicVzgO0mV9rM3x1lU37nOvo35F
	 /KT52xQbhaKmvlUrB+psk2muldQFSXzJTstrH2vu8+bpdQGpZzMmcnmj1u6JWpgd2t
	 BdSyMfsRb4BOd04R+SE3WHpKPKgWP4+TKv6jKKEg8z0zoDcAxlQ2CAEXiNnS6jCRrq
	 I0yz1LMTixKg8dbT0s8qXakvLEUPlSyJeNEl1hgBiIY9D6HwsgzeUfWh4dMHaEHYv1
	 09FlVyvXW2L3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
Date: Mon, 13 Jan 2025 18:09:07 -0500
Message-Id: <20250113155843-5c6e2080b670d3c6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113155118.936319-1-inv.git-commit@tdk.com>
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

Found matching upstream commit: 65a60a590142c54a3f3be11ff162db2d5b0e1e06

WARNING: Author mismatch between patch and found commit:
Backport author: inv.git-commit@tdk.com
Commit author: Jean-Baptiste Maneyrol<jean-baptiste.maneyrol@tdk.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 7982d8f24a9b)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  65a60a590142 < -:  ------------ iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
-:  ------------ > 1:  c7211d6b4e9d iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

