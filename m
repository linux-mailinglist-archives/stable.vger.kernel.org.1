Return-Path: <stable+bounces-158590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781DDAE85C6
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 16:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96F737B5B5E
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 14:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863CD264608;
	Wed, 25 Jun 2025 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYhIKb0S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CB126528D
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860541; cv=none; b=Mjy4kAXNNGxnXzS7fpbdLvm0hxP4LjOfUZfHwKsU/sQAJgpnCNwUbEoRW3A4YoyGivXe5pm6pt+KYPY6xv6afNBREechdYex42ni/Lt8R3OUO5DJNL+m3CBC/DWMgRRP5MpNB78ckZXFTVYSJrbroX0ArUaSq1fO7u6GGs42gxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860541; c=relaxed/simple;
	bh=96ijwgDVlVySzUjfsKKyiT6Ty0Rx9+8ZCsB6Qk2PYzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mE7CfNMXLjhJKB6OtPC1YCGQnscECsyDZFrJsGdfg0zLdwsX2oilkLLJisxUyhMqlpaAV4B7m3OB5Ufp3Wi8lFUUp0eWKk4dB7aaL09c5SczdvLUtMx1payT43BeXJUCjFTh8AkRJQZuGjUzPLDjQFZOEvsN1UZG0xn9U8xeZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYhIKb0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97DCC4CEEA;
	Wed, 25 Jun 2025 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860540;
	bh=96ijwgDVlVySzUjfsKKyiT6Ty0Rx9+8ZCsB6Qk2PYzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYhIKb0SeHfb2zUzemV45W3vhx/hU2EovjZ4+a7wMejmWxbyd1xD6Mq1renDx80gd
	 XS/RxcPKIB0+5mJk69APUdsr/IrdamPQUPgLPV9kiqGzKF+YqTG5DOpx7vSU8/xsw3
	 9JGR77CbB5+5hAKKZoxboZ9n6N5GlkrFZfViUsmXBGug9his3lpc2s311+50EhMMtO
	 0A3pJm9z1vRBhoSJlXXhZehGWasu4+XWiT/UMDEQdDq5iGMAU/FhA6Qwl5pZf+e8x4
	 qrf+zEoODkSRtaAichP+0Vhx1K/mk9/PeCTTRme2QNJD21MMNVBhW/iyKhcJicW+yE
	 1aoClEcKkmobQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
Date: Wed, 25 Jun 2025 10:09:00 -0400
Message-Id: <20250624195532-505e3fa1210a6d89@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250623134240.1107347-1-hca@linux.ibm.com>
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

The upstream commit SHA1 provided is correct: 3b8b80e993766dc96d1a1c01c62f5d15fafc79b9

WARNING: Author mismatch between patch and upstream commit:
Backport author: Heiko Carstens<hca@linux.ibm.com>
Commit author: Nathan Chancellor<nathan@kernel.org>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 593d852f7fe2)
6.6.y | Present (different SHA1: cefbf9f892ce)
6.1.y | Present (different SHA1: 62d33b9e68bd)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  3b8b80e993766 < -:  ------------- s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
-:  ------------- > 1:  1d0205496d23d s390: Add '-std=gnu11' to decompressor and purgatory CFLAGS
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

