Return-Path: <stable+bounces-110414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07054A1BCFD
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 20:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A606D7A5057
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7B81D9688;
	Fri, 24 Jan 2025 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO/lz8jB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEF4A1D
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737748322; cv=none; b=j1DRnUfBW6ntDpENA8iejQFw9sUIKrkRmJUze65vj8yzC98Psfh3FWlqLYzRpWtngXs+472bgW43qc+hNG9DrwhGryBszDojCau0FCUBPU6ww6BUN9XKP8rW+zhQrzA1Oev6r1L1QoDbrHCMb6aC3UQ8jPzI7xt78YcZXw5u0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737748322; c=relaxed/simple;
	bh=mMSlC+xr+7OjFjGBfdmhGCPjcD/6J/dzurzCyMm896Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hIHagIR+U6t9YXaviRbkG6aYJuswejx+cM9+glzTVn3uL+CRt1+4wER7F3ZQD3KPzYXsOBcEs9lHv++TsFtjNqv2BCcXZymUvOH7IBr2q9IUjCz2qretetMxDrijTHSmhIXqtBFkveD3t6cf6cNgkbgE0fff3ZpgvetBgW6xoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO/lz8jB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E753DC4CED2;
	Fri, 24 Jan 2025 19:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748321;
	bh=mMSlC+xr+7OjFjGBfdmhGCPjcD/6J/dzurzCyMm896Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sO/lz8jBMMfv+5h8bTmIUZU0kZZh85byViJrvFgbASuebbczToxbw2vSM6KVZiEtZ
	 k41sKbsdq4gqR2sCWEVdnnu7P3dQQ30CpP9tTIl6J/8AZeKywcqGgBiFpszYGj6ahp
	 gJv1mkdSQ2m+S7u1B0Q6zcUVDGCK4SCNHDHSe5/mPojPMEWn4KuSwp23evQHiC5Wjy
	 FolkRDHPOxmWfHJz6XkBkqEn766OdTdERp8bZPMxKR9x2PkVTifxwt+g5HXAM2srG7
	 5Hmdpxz3eXsdkdK1R4DWfqTV+4BOC0sAKGpCzKwcLNv2zWveJOi/dN3HL0WEi7ptX4
	 3py5FJjfKRfhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: alvalan9@foxmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
Date: Fri, 24 Jan 2025 14:51:59 -0500
Message-Id: <20250124094530-4ef7a53bc6e71514@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <tencent_84E371D061F81AB069496BFC3F862449AC09@qq.com>
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

The upstream commit SHA1 provided is correct: 90e0569dd3d32f4f4d2ca691d3fa5a8a14a13c12

WARNING: Author mismatch between patch and upstream commit:
Backport author: alvalan9@foxmail.com
Commit author: Ido Schimmel<idosch@nvidia.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  90e0569dd3d32 < -:  ------------- ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
-:  ------------- > 1:  01fd4e7cac868 ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_find()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

