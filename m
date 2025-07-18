Return-Path: <stable+bounces-163316-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E5B0993A
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5075F16DE32
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1547714A0BC;
	Fri, 18 Jul 2025 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQuPq8qi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FA22C187
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802485; cv=none; b=Am+NmOLSuZnu5sFqWZwvmmLEghefuZtLcVZU0O4ou/i89r/jLwrNw6Hlw+3a8roTVMVIpEq2SAUNedhQFoDXZWHGYsSEJC/mWzd+GYpqYG+GuwVd5avPd9pQ81zKeW+Y2hKuIdICMWPASmnGXtrEY/vZ7UMOxX5D8jm4jijU+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802485; c=relaxed/simple;
	bh=gIVoc/Gh1WvSBk6tBwEL4EcdjtpeKvkbHitmNicllfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWqq6tWmSvW2c1jK/RKr6thtT25YMtr+V/u0vOdGUSDrUZWdX+sgQ8jrN3r9CzuvKP/YcN3ywWzeuDmaYAzkbpFB51hdUu6kZnUW+yshTdzfzz4g3SscR5hNwMEs4OM1R+01Rr5HWIfGFN+1udD+bVHIkEwTHQ6jAk2iOZaR/ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQuPq8qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8620C4CEE3;
	Fri, 18 Jul 2025 01:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802485;
	bh=gIVoc/Gh1WvSBk6tBwEL4EcdjtpeKvkbHitmNicllfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQuPq8qixxbcXAXxHx1g5Zjsxz2+j98apamJmQeBJOTuz0vNYalyT2qK+lXfHP/H7
	 P9I5mW7DUQ0uziPtsH2/1Y77CrsLvD9ny3ZKXpkq4qPYgFkRMXmCV8PTY3W7LDJB+J
	 k4j/Mi89yyQaMcidt7J6vkPyLdW0lvqTZ9ouvbV6rhp2Sh+12y1nqHhgYr2AOmexpb
	 RmSom7/O/kHkRZc+SQ4rGQOOVx2ozldWXmSo2XMMM3KiUlZyEL6fGs34BIxoohANZM
	 0dl/EIDuXkTxDFN2R5pCTltiEfbls6NKKXepIU4Oq5duk4APG8yUZGDg76uVOslKoL
	 VG5OAyT9WgOwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shung-hsi.yu@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 1/2] Revert "selftests/bpf: adjust dummy_st_ops_success to detect additional error"
Date: Thu, 17 Jul 2025 21:34:42 -0400
Message-Id: <1752798028-7c65c1cc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717080928.221475-2-shung-hsi.yu@suse.com>
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

