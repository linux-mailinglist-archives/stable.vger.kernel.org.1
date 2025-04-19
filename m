Return-Path: <stable+bounces-134709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD6A9434E
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC8E7B05BD
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565431D63D8;
	Sat, 19 Apr 2025 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1cKAiaD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABF1D61BB
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063454; cv=none; b=ajy1NIhKQd3wlc71iTyNF+c+gjRy8fS6QGIPiiGFkTWCkxQV+6T44OcV+Mekca9imysTtXsmOoSnE+bsdvc7LDRML1okxleQShMJ1RDDDN0WraYh1RwkwlD7kfPkRui1CtKtc0vxDoXKOin6F44vxBx0UPNey1wDWk6/Amd7BAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063454; c=relaxed/simple;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O46HJChBf1p3hoZPewosDwMX7goSbvqPPXvaChWZI8QqSDB5fobBRF4DguPPkmTHtvL6OMPrCWv0qiMaK7/xo/43Clwu8/qfICwnwK/ZA0sUfcRHSuIOUXIRiNIRe7lJ1nT04MBPNmK2iRyGMhBbhOOoy/CPw7j1/cHMkouGIcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1cKAiaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F8FC4CEE7;
	Sat, 19 Apr 2025 11:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063454;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H1cKAiaDguvTL/d9Lgu/a8hbN9AKZxoCcLBm0p4UPlGEe6SKix2L2ItkzkZNyqUPU
	 GTJKkuMe+h4t46KPrjKTwmhyFt+CYy9jLuQvBwoCb+y8l8fOaV9UEvDGfV3jlXetui
	 4okIDwFxVudSpvs4RMshGtu/pbKaL7NwFs6euAOnX0ItTbGMNHochFBklrwh2EJp7e
	 FRmPdMJuICRY8XJ6qH6kQnJSdN/AyRXnlbu7wZoikpsdYKAvhA49dwWR+abxb8jS0H
	 1skCHxRaPgcr0wHoc5NK31E2bYrStcbrDR5QkXlFE7fJqsFEFu3NdU30mjMedZxqNu
	 y+ft4QIulsewA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shung-hsi.yu@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 1/1] selftests/bpf: Fix raw_tp null handling test
Date: Sat, 19 Apr 2025 07:50:52 -0400
Message-Id: <20250418171212-001318731d218854@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418080346.37112-1-shung-hsi.yu@suse.com>
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
| stable/linux-6.12.y       |  Success    |  Success   |

