Return-Path: <stable+bounces-164809-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D864DB127FE
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D418169AB2
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585FF3594C;
	Sat, 26 Jul 2025 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLK/TnLk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1813A28FD
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753489520; cv=none; b=N7P/5tCC06/qjKIdE9hIJN4rWm33OJsGHDus1unGDdqip2DoYx7PPDmpgi8BJ9fY4/Eh1WzoCH6R1ZMdFgKCUqyv/H8T8DE4GCdzru6CACMGzEUR6/A23vCUwRJSpP8BysHEL6OzcRHG0XXDG3CIWkonXooAwthJ3LidMmEM0jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753489520; c=relaxed/simple;
	bh=gIVoc/Gh1WvSBk6tBwEL4EcdjtpeKvkbHitmNicllfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EF8N7wm8rO0ZqGHqd5CyWNSbdX4+OVyLE6aBbCcLnoF/77OqtjffyfyILQYnnxYoPlYKIp1DEPaHKpiP7skvmUll517+U3JE6Fg1a2VyXzg/wNs+J2Un6wWd+0lVf4BUKkliLK3/svn1v3p6Z4RvFu5BWEZC0TKEM0wFE4sMrkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLK/TnLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC8DC4CEE7;
	Sat, 26 Jul 2025 00:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753489515;
	bh=gIVoc/Gh1WvSBk6tBwEL4EcdjtpeKvkbHitmNicllfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLK/TnLk2LR8mmeFjz0oRWndVsFXcRwH/DSOa6t+OA/kS5DdEFhu267RAWKnchj05
	 QUJ2KJf41H6QLM3CKtp+/YTdBQD0/J84iSP0gA+4sEaCum6Uf1VmDwGHd6OF1nMKNa
	 VKoWY9EQFfg2gsUf0VV6UhmoosIa4tn7i6itUe16C3HfoDhkV/4Fu5197MWXNnEuyG
	 ypqMwjcFMLLLuRmGfXN0X6NrU75lWm1jxCH1vdxdcBab7hYAEye88zbnskSgh8Kk5c
	 SHW2HPka7UI0kt91NdrvJDG7NVh07AP1gpT5AMOzcvzqxS9TKk8brLJt/CZWTjbgy7
	 Am1JqtOO8XUBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	quic_hardshar@quicinc.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y v2 1/1] block: Fix bounce check logic in blk_queue_may_bounce()
Date: Fri, 25 Jul 2025 20:25:12 -0400
Message-Id: <1753460458-7d532680@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250725112710.219313-1-quic_hardshar@quicinc.com>
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

Summary of potential issues:
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 6.6                       | Success     | Success    |

