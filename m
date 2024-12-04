Return-Path: <stable+bounces-98330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 178739E41C7
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F56B376C9
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7720CCF0;
	Wed,  4 Dec 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoLJAG/d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59C20CCD9
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331204; cv=none; b=BMag+pnCtGvLZp9HWSIO1CjU0hzav6v/YVCMJkyCif6GtRrKKEgE1FmhSriymIqFROKd2cE7Q8QZB7160T1btkut0GCy2kr/wZtBMbJYpk5ErkDaR27GKoiBp6uAXemnvGtKUDK+OsaO97s9EbD0CP2tTSRAvltEq1wgwZaeku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331204; c=relaxed/simple;
	bh=oVtMPiXdYEqKiim4wXDM88fnwtaMrwKXaXD4uOgpCcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtVMcsLv/kCoe3oIt+TeLlay3X8E1qSKF6FfQVzqy6SlCPjpJoapCZkv5Lxo3VuhtBqKpo0NYlxw0hY/8WJl14A+Xn8NIk4R/cObLR7hl+CdhqZna3EKLYXEKtXcvgfg6O4v7qFkSYcOiL/cUTK6UJzvX9SuJvka5JQLTnIxWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoLJAG/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50530C4CECD;
	Wed,  4 Dec 2024 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331203;
	bh=oVtMPiXdYEqKiim4wXDM88fnwtaMrwKXaXD4uOgpCcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoLJAG/dtMmE/bwQAe2XjX7Vli0nlrMldosF9Z+ogAD5xKH/W63rF8V/W7F2rlXZG
	 OzfwS2s8SZrLK/b98UsUpUfkZ8Dl/BX2cpWmxO7vyFPmIZenIcbWtT7OR5YrZRvhxc
	 X1kHqiGR3hifihw/8l6MVT2X9l8VFCHffbqRaa5t5eAqK2xuBf9dWMUJC8uQKrVxIB
	 L3A2cQez8xdcaGxOAOrJbpftmJj5P0JX+ftX2jJ5TR8s21749K9n/8Ev7UmYZwtb2H
	 dJLXz4v+bVp2LQbiiF+cuGnvWNONATuiGsRMP1Mvl/qvSjGBHkE7BhLdf53XSBYQBi
	 zlRgOIQLiGfNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 10:42:04 -0500
Message-ID: <20241204070810-b03f050a4d6c3a2b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204082525.2140-1-zhangzekun11@huawei.com>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

