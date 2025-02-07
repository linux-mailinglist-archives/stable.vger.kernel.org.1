Return-Path: <stable+bounces-114330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6758A2D0FB
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9073AA483
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0191B4223;
	Fri,  7 Feb 2025 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCElcM4U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5251AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968669; cv=none; b=rz+zZ/QYJgOn9zMujtNmXsw4Y18dWpwrmOmdZ52wAoHhsOAOFio00McJ2s2JF7odqaQ8iqM53iy0tyDXFVhsNJQpt4zPlkyKV9rB7L7kWi5OTAs24QvNMumhlhXgq/mb4DA0vAtAcBC2/KGSHNAxY07LYpYC2Pg2C4E7eK2eCfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968669; c=relaxed/simple;
	bh=lP+ALiDwAJbwYz179/L8Nuv51mQ9WTE7qiW9h2jZT5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTglxKfT5UAb3rzZcZVb46l0MHfTutbHfDd2HzWmNCG2M6HRdyV+1/YBK4aL5M3dU/nwnvoZtCGNz9O3uoHk74r5l9qhFaVwhOQI3WTjPB54/Ne1+QzpVckXqXmBb1s1E6T5Xh9xkIEttFB2TTLfDyXkAwuotDXRT6Ky/GgE32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCElcM4U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB00C4CED1;
	Fri,  7 Feb 2025 22:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968669;
	bh=lP+ALiDwAJbwYz179/L8Nuv51mQ9WTE7qiW9h2jZT5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCElcM4U8h0S4BwAmf3SCbUjqfigkt6k2fEHszAqeZAPYZ2w7Kc5R60GBYSp3HqF+
	 6WR40TS3ev9kSCB9ZjfgyVwlGzfbxyJ3YnWG9EQJ9MGXeNIria+ee8FZnBvBMDuk+9
	 XMgUcE5luYllNWkeu3Q2xHGz0aC0NyW/KfnRzOnHr639ecUQyeDoBdrJZelG8tmWHW
	 qskYYoPR20J8oiQ0YlFwvL9oOMxQf/BuEKMod0G4z/HPvfUKV5ne1rE09S1mAgIvB+
	 KDG2tOTvLl4auDHggYCuOq+IXwFECI1WvGOcSYJeHKcxxzM7jM3OUosHsGqZsr3beC
	 kUkBF5AShpPsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <koichiro.den@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 17:51:07 -0500
Message-Id: <20250207165928-7e6d0f5dfa31475a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250206162055.1387169-1-koichiro.den@canonical.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.1.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

