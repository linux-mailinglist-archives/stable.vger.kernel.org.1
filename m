Return-Path: <stable+bounces-142894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A39AAB0025
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 18:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 796B81C07E7D
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869FD280A52;
	Thu,  8 May 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dal7tB6h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463882798E2
	for <stable@vger.kernel.org>; Thu,  8 May 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746721114; cv=none; b=EGckScH5WQLi1cGAxgEOJwYPGputtMcTuMPrwUEOz6qUHcDEvB+pq6c1b6Nfg563fY7WLOtL1FxtU6yp2sf+p6X2SAyUl+x4nVFZIXypvuu18jdPo6kjCZJseOuXJC3chUKn9GE5QX8GMcccJbmts5joQE/cCMXopsjE8QFWBNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746721114; c=relaxed/simple;
	bh=RC8U900UhX/W2UXZwLiWvAm6QkXW7+7b6HsPvFQATq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oc8PH1Yvj/HLGJCADyawDOh8CLfkqz2mrMQElhsuAnLzGF4h92OzIcvBv+rri5pShS7hNHFz0hU34WmjRd/AP0mdho6R9Zmije/SPZHLy0RVFynSll/l2cXRjgCaq2k5lk6cnjZC1kmq39QFBhJgVleUhIGxD+Qj4poI0a+4Axw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dal7tB6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2917C4CEE7;
	Thu,  8 May 2025 16:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746721114;
	bh=RC8U900UhX/W2UXZwLiWvAm6QkXW7+7b6HsPvFQATq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dal7tB6hoHIfe7ty5Kg+vfbRYYVlcOX8YU3hT48lnBpCoQzaVIRv5vbGecfXfMrsA
	 El/eEXe5tz3z3i9z+CXBusT1lWzkPH/oDT8aDHdCBx73ww2ga2FdZ5JvDhnVu6+e5p
	 eBWNta1Y2Ys/vZM8fDKYXkiVuXFL7eRqzSet4/dfqZ9kMlyx1EvqWWbEnE6xEImxqq
	 aZzZXbQsnNQDzqwqtVy7VH0Dhl3mV4S1uRDSZskyjHj72N7pd1uq3F+tfRIHXH+tFQ
	 Z9LIhk0TqrcHfvDZ7QGggCTk+szBVUL/m69dyyoeNIegryfChdx/9vCxlc1L2gAkJ+
	 f1PO7VkE3F8Aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryan Matthews <ryanmatthews@fastmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 1/1] PCI: imx6: Skip controller_id generation logic for i.MX7D
Date: Thu,  8 May 2025 12:18:29 -0400
Message-Id: <20250507075224-592884ae66fe57ca@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250506054406.4961-2-ryanmatthews@fastmail.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: f068ffdd034c93f0c768acdc87d4d2d7023c1379

WARNING: Author mismatch between patch and upstream commit:
Backport author: Ryan Matthews<ryanmatthews@fastmail.com>
Commit author: Richard Zhu<hongxing.zhu@nxp.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: d0f8c566464d)
6.6.y | Present (different SHA1: 8f5a9b5cc102)
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  f068ffdd034c9 < -:  ------------- PCI: imx6: Skip controller_id generation logic for i.MX7D
-:  ------------- > 1:  34963c5f41fd6 PCI: imx6: Skip controller_id generation logic for i.MX7D
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

