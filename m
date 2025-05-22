Return-Path: <stable+bounces-145957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E781AC0205
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95A11B63044
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7D52B9B7;
	Thu, 22 May 2025 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBCpGH1r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692861758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879451; cv=none; b=jC9WVKFfN0oeabDdxuwMPlLpwAq+QvUqXZvKm+5XuutdbISSb3raS7rkDVTrgWIQPzuvJkUR8iRiuRZpvyW1uZXMHbnd5K3wNsrefs5FFD9U1UvmMgUafvDGWXa/qnfWvh1BBlq4wxES694ZbfVRembcYukZ3EKQLvxNP8+3WMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879451; c=relaxed/simple;
	bh=ruJbbb8IOY4zK+O8dINp1DcdE49CzdH5UVxLtwJoh8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hY3wb1aCquSuXh6A0NmR4XL/OaT/9aWPa9oxzSWGF4IAjz30kZpMIXEzr4MYTI3wZeF2+pqpDFGiTEGQFaAP/sRYXb2zSj8a4jUAm+9PBKvAr71b1QaLxl+YtcDGH8TlrenJ8l8DKvdWZ8zwyi235k0C13vNBW0WxTJBsAyMtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBCpGH1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90DCC4CEE4;
	Thu, 22 May 2025 02:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879451;
	bh=ruJbbb8IOY4zK+O8dINp1DcdE49CzdH5UVxLtwJoh8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBCpGH1rk7PcitVpGPAvgGcQ/B2tKXMUZ38W6trbnq6BfyWq4h6fEdcxbqcFU9f5H
	 2Id78okpjm6qaL8ESRNs6Uja+UmojwbaC+h23uB4F4mzcz656uWDqU6vFLHGJ7oQHi
	 ph2aGORtyvdrMEkk89KK/e4O8nDsmDk9VYQ86vgnoMiPiI9AnJa569mcbaXkWKxIST
	 YrpjOwPAoPvcUkkDD6QuMdz6RoeOKgtJo03nMDy4dwzQ07WFQYpU0+tfkPw9M24sxP
	 8coH5XDQ3CH92bz5G1ey7ISgCXPhYKNvBiVVYn7pt+c9dMXMRNOF8qs6EAcrWwKFGV
	 EqWCN0IwzhuQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ghidoliemanuele@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] gpio: pca953x: fix IRQ storm on system wake up
Date: Wed, 21 May 2025 22:04:07 -0400
Message-Id: <20250521125217-a85e0fe14b296889@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520203637.3133360-1-ghidoliemanuele@gmail.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 3e38f946062b4845961ab86b726651b4457b2af8

WARNING: Author mismatch between patch and found commit:
Backport author: Emanuele Ghidoli<ghidoliemanuele@gmail.com>
Commit author: Emanuele Ghidoli<emanuele.ghidoli@toradex.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 91391b297efd)
6.12.y | Present (different SHA1: 8c963649a1dc)

Note: The patch differs from the upstream commit:
---
1:  3e38f946062b4 < -:  ------------- gpio: pca953x: fix IRQ storm on system wake up
-:  ------------- > 1:  c15b7ca8984c7 gpio: pca953x: fix IRQ storm on system wake up
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

