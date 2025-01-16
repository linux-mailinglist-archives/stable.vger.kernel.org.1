Return-Path: <stable+bounces-109195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE8BA12FA7
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 01:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0010164053
	for <lists+stable@lfdr.de>; Thu, 16 Jan 2025 00:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA11A957;
	Thu, 16 Jan 2025 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu1s2Gff"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75079EA
	for <stable@vger.kernel.org>; Thu, 16 Jan 2025 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987158; cv=none; b=oduT3QQlKROMsD3bY+A8UsB5ws1EObWS7Ho6LI12S3LUawC4YTzfP4cm4GyIIhgIYqo39F0Pk+ymm13SEaWMZptd6jJ/u5k9EUF8Pi88t4HzWOx2ogYvoEQNxwwYSQxsqLZlNhCX31ji9KAAdNFHp5mIdZNTOZ689qjJ8v5jJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987158; c=relaxed/simple;
	bh=cx97lTrKgf1AynBQsvpjcJ2HsM9JFjltlPceCNoYTv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qh1jfyHEzChJ0XwfRmetQt1JHWi3OKLTPTMQs9ttilL9SuuYYNM6JnVcCeMKe6V0vfc2Kwj+RQAiGhMcd/7Aa1UPnOnrwLl3KUPtrA8Yc0WHMufb3Cei+pUeURAfu00Jj0wjnsnNzc4GiD+bybri1CZ5epPTWBDSFfg1BVZWrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lu1s2Gff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3D2C4CED1;
	Thu, 16 Jan 2025 00:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987158;
	bh=cx97lTrKgf1AynBQsvpjcJ2HsM9JFjltlPceCNoYTv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lu1s2GffX72uuX7ZxIjdMFwFEBd6w7OJZ/EzVctQ0oxkr0PSr5HiNklxr0Ek4rX1S
	 hotS6bnXvCx3NZIvwchbK45XtlfcwLwK9uOX7DlfeMjfadUzAHmUUm3WxSMbSKKUIV
	 fAHdpl5h+HRUHKTJLw25UWf3FGzPTMeNcVZqb9nc91+DykYPVGw8WDbiM9hv7Bm7h2
	 DDNWgQZqSOsibncu2Il3SvJtaU7W/b17IoXuGU/rAqWuLfeKaz5XHRZ0TVp1uwXSz9
	 49mh1J1ZhhBbcRN9FLzkKY1ro/Ea+4t6HatIirC+0yb2tMQ/BC9HKgkZZQammkRhcr
	 /FxGT+sY38caA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] xsk: fix OOB map writes when deleting elements
Date: Wed, 15 Jan 2025 19:25:55 -0500
Message-Id: <20250115170933-2e0be919fe8f32c7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250115084347.333515-1-kovalev@altlinux.org>
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

The upstream commit SHA1 provided is correct: 32cd3db7de97c0c7a018756ce66244342fd583f0

WARNING: Author mismatch between patch and upstream commit:
Backport author: Vasiliy Kovalev<kovalev@altlinux.org>
Commit author: Maciej Fijalkowski<maciej.fijalkowski@intel.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: d486b5741d98)
6.6.y | Present (different SHA1: f8abd03f83d5)
6.1.y | Present (different SHA1: ed08c93d5a98)
5.15.y | Present (different SHA1: 4d03f705e9d7)
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  32cd3db7de97 ! 1:  56235b048d31 xsk: fix OOB map writes when deleting elements
    @@ Metadata
      ## Commit message ##
         xsk: fix OOB map writes when deleting elements
     
    +    commit 32cd3db7de97c0c7a018756ce66244342fd583f0 upstream.
    +
         Jordy says:
     
         "
    @@ Commit message
         Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
         Link: https://lore.kernel.org/r/20241122121030.716788-2-maciej.fijalkowski@intel.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
     
      ## net/xdp/xskmap.c ##
    -@@ net/xdp/xskmap.c: static long xsk_map_delete_elem(struct bpf_map *map, void *key)
    +@@ net/xdp/xskmap.c: static int xsk_map_delete_elem(struct bpf_map *map, void *key)
    + {
      	struct xsk_map *m = container_of(map, struct xsk_map, map);
    - 	struct xdp_sock __rcu **map_entry;
    - 	struct xdp_sock *old_xs;
    + 	struct xdp_sock *old_xs, **map_entry;
     -	int k = *(u32 *)key;
     +	u32 k = *(u32 *)key;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

