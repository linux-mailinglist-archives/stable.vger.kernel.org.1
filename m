Return-Path: <stable+bounces-98591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2A29E48BD
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4448D16312E
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B1719DFB4;
	Wed,  4 Dec 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzS22fif"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB784202C3C
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354611; cv=none; b=au9JeFtdhKpAN7qjtqyFN9yfInVVIj3OV4WlNueWFaAPANAu7cqyUcLLmOUrJUuXPizKREcHgIWcY6N6AScjKMzZTyJWz7QJj170WFvZjic58iEoRax8y3AQfOJ2xHJ86xowZnbp14KKtzQHw3i4eH8soK94ytts+CSKee6DOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354611; c=relaxed/simple;
	bh=oVtMPiXdYEqKiim4wXDM88fnwtaMrwKXaXD4uOgpCcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFbhDBF8Qw1cJiEGhX0KyooLs5mRbiqWtcd554OhGraeWuQGbjy0nlY+e99a6AZHFrVZPz2jO/fljGFODePQZdlQ/R6DWUP7LD9EuwG146I9S2fEfJWEimKdAgIyE3WGzAJKVziyhxnTpjI76MDNhNC1hcVGEybOGjjWUbZSGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzS22fif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9F9C4CECD;
	Wed,  4 Dec 2024 23:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354611;
	bh=oVtMPiXdYEqKiim4wXDM88fnwtaMrwKXaXD4uOgpCcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzS22fifd9p35+7W9Z1W5omxQj4ZEaJHogdxql8dqwHBEhd78SePYZ5l4hqb5jV5n
	 dxjGdgT9BYF8EdGdzkdUBNuxY2tFLF5lY32rHzzuXcW3mWOKE8YhfkjT1xtw8eMcuJ
	 H9Zxoe9fwv47X09r7YWFz6KdSM3W44Rhpf6gLtAe5ftlc20zBlg+o/CoSMJmwFSfrB
	 UUehcb4lq2zz+f+kyaE8i4eMFHmLahinslwLgn2knUgujzdVPTA82bdyYi6GO404cc
	 FSU5rB94XeGVzsT6U6oLYG5yYmgokCYtla13LXpaJYxwlSJB24nLUbY5DPVjHyynvT
	 l0u2mqFssGRJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 17:12:11 -0500
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

