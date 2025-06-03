Return-Path: <stable+bounces-150750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C13ACCD22
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 20:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72B53A6AAF
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 18:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9E24DCED;
	Tue,  3 Jun 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhQoegcr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0CCBA34
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975757; cv=none; b=LUNvhpv/ISaFqXdA7uK0CwvrWQ7hNBft+6Xttj199qy4QN4gdQP3WXTnRfrxbVSFF6TRcx/YaM2ghz2Er6RlBRpxcTUsoywPx+tF5piDfxCMTIkXNcKD7NZi/QQGM9pyNPoUIInT7Ndp6fQGJftBbuBiiljhP8diQBzHuHQ4h1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975757; c=relaxed/simple;
	bh=/5MmGtyrKjr8J43Bp27BvWdkuAsRtb0Kab0EGV/PQtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TklQMb5Pilarnfhl6DunkjZ1Lh0S8dI6Wl5aMUXBMiuzgp0Esh/eWsQhOqF0wYqX1eTeo+9apwKjwv42pqgRI4rWLgkD9XkRQPzfVrMzg/uF/T5/bn4kUuL/Ube9uK2ywDDVMDUsqIUYwg6TJC44St6sxlmtYODrUxjiw1fG1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhQoegcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFACC4CEED;
	Tue,  3 Jun 2025 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975757;
	bh=/5MmGtyrKjr8J43Bp27BvWdkuAsRtb0Kab0EGV/PQtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IhQoegcrZJTpTZg8TvBWcaH3vhDTe+CAkF/KzOLfUCFrX6lM+3BdcVNV/ZHdm5YXA
	 EdgorEwBnD/FaKjNqz3cZygSEA6oKyHkPbgBYc9gA+pIlbA3L4CVXYpmOeV+r93553
	 oE09UOkUFa/j13lXM2ZXvrv5BL0pEaycj4+0+TZFGzGNl9R3bo84khasQfX2X/r8X1
	 w1j7agWBFDDcsyO1YwaF7G9GvvV/EGnV5q+pqyoylhpgpjVRqDO2QW/PO1lul6av4t
	 Mcls7J9WQRP3sgyC94a6M9plHiGuR7+UMPVQF/q2Hb6G5ORFNhBQ2a1KqaSp6J6R4j
	 30QfBJ8lU48jg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	jm@ti.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
Date: Tue,  3 Jun 2025 14:35:55 -0400
Message-Id: <20250603134515-df6e24d414634c62@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250602224224.92221-1-jm@ti.com>
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

Found matching upstream commit: f55c9f087cc2e2252d44ffd9d58def2066fc176e

Status in newer kernel trees:
6.15.y | Present (different SHA1: 4f35dcb075c0)
6.14.y | Present (different SHA1: 4a4594de75b5)
6.12.y | Present (different SHA1: 084b88703921)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f55c9f087cc2e < -:  ------------- arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
-:  ------------- > 1:  0913f2f6fffe2 arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

