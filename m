Return-Path: <stable+bounces-134608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC897A93A0B
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6B6D1B61B6B
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1AA21421C;
	Fri, 18 Apr 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSdpq5xq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0AC1E884
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990972; cv=none; b=XGiOo/tjBAiFODbAqixhxKhx9L4bcN6CaSeZ9KF4OmC3zpDYyLyrHQgObLwFIaF14BfgTFI250Hxk9Tto7EQBR9p5DrKjyY/4ESeq3UADJx8bFrjRUrylzTm2hkCJUYHKZ5Ane1dNEeX19efASfKnsVuJ8MxoQdvac65de7iUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990972; c=relaxed/simple;
	bh=qQhpUXlvuE44WP0vP8af2FEVI6i/MifL5YTz/IfDRQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fk4OZX5zE7Bdwd8otB0vRaRfwDvvuHzcQwYYqqVNjAWgZWITfJ+n2aZ6O7AthmyCuFl7ljYVvdno080zenBfCgEHmhFBpKDnFKXd7DIJgPqE5dx1A3OBXxy1JRsys16fPbwmfH0ddGGO9xvz0ftpTCoe1hiDU0b0CjIKuzeEdcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSdpq5xq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D15C4CEE2;
	Fri, 18 Apr 2025 15:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990972;
	bh=qQhpUXlvuE44WP0vP8af2FEVI6i/MifL5YTz/IfDRQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YSdpq5xq72YsFIj9h1uOfrDqneu8DshhuhxOlyH/MAk2Y8j50UFpfYghpoNt7j5yw
	 GmMwCr9mqFVApkiT0BUmoAoKbI3Ves1ED5pvb3b+4CGwktYAjKH4O2ojoZI72PEpyb
	 +kY8eClEwpu5BuyFw64G2tBkje7WjrI7kL7op+Bwq821R7vvYUgMATCOjn8XbSTtu3
	 moxrndXSTL1swOaaHVg7P1mtmgUZyXpJ/yGrRVbpdFFs6auzvdROP7pnWWcmGhQHR8
	 au+hqRjRVtS5IU0Ac8s5nM5BCNLgcmFxU0okVyZPB27EW9fMgKjerCsdFVmj5kHAiR
	 53K1bVAduZ0Gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johannes Thumshirn <jth@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 2/2] btrfs: zoned: fix zone finishing with missing devices
Date: Fri, 18 Apr 2025 11:42:50 -0400
Message-Id: <20250418090710-028f492dd52f129e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <6e7ceb08075b17b16898adc2b1add98c5ca58473.1744891500.git.jth@kernel.org>
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

The upstream commit SHA1 provided is correct: 35fec1089ebb5617f85884d3fa6a699ce6337a75

WARNING: Author mismatch between patch and upstream commit:
Backport author: Johannes Thumshirn<jth@kernel.org>
Commit author: Johannes Thumshirn<johannes.thumshirn@wdc.com>

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  35fec1089ebb5 < -:  ------------- btrfs: zoned: fix zone finishing with missing devices
-:  ------------- > 1:  a47a1104867b3 btrfs: zoned: fix zone finishing with missing devices
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

