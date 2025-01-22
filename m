Return-Path: <stable+bounces-110236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0603CA19B00
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 23:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53ADE16BA9D
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06A51C5F2D;
	Wed, 22 Jan 2025 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H29x2DAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD001C5D4F
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 22:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585532; cv=none; b=UbxH68sXVl7JtthjV2+eTHcIsmtjX01B89W9FQOzFajJ7qZaIs66PAwx1CXGGzF48caqv2Gm5VxKCTO44GracKrgy2B2W5d7GEB1tDQCsEgsZ8CeJadfti2V70fqHBlVPoK5/coy0Ynmw0XbySBbmvp2roWCMn53vGwmt7D4y3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585532; c=relaxed/simple;
	bh=eZyPCNbN7Jkon/MvMo4pFrUbIG534+i2Xem8Bj7tJ8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7gbzvmkZfVzHe+AYw/JvkPwAdBvg79Q5CWs6VEqXiFx7NDXMmDoVd74j1oRN50DAjHmdrKnRfvpJf9JZZAAiM3532kBCt5FMV1NHVw+BAEIc+AnKItE6+MBnBwtT00KxjidZv8e0x2BYqv5PVtLRiFkCkBlwVV1cQQKnM5jrtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H29x2DAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C40CC4CED2;
	Wed, 22 Jan 2025 22:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737585532;
	bh=eZyPCNbN7Jkon/MvMo4pFrUbIG534+i2Xem8Bj7tJ8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H29x2DAFRKWpKesnKAyc6qOE3JVYy9gLYXr6LgXmyv6FF2+6WglBIxLAic1B6ttYt
	 rjk6pKhAQjHqUInAZicAsd11YBtkIS2dmpSGZTcrWT/VhzI0V5ULwf+0H+WaK8xp58
	 d6vm6YOdor0906LIel2Q7NWSfftF/o3eT7dwTFrj8q6lL3pNCFh5ad8ZwGXdTDtOHx
	 N1ocGQJ6HmWGMAx8KY7S0S5ME+pn3x828/0XUnQ2EuRa662kOMOnBhksFpNAM9ViCa
	 LJS624NKpARAywykb8+u2aY60gaN1aMIH+6S0U5afdke2FO0KBA0xj4WbR7GG+2ncQ
	 FZz7ds47dDTJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hagar Hemdan <hagarhem@amazon.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4] net/xen-netback: prevent UAF in xenvif_flush_hash()
Date: Wed, 22 Jan 2025 17:38:50 -0500
Message-Id: <20250122143845-11e388013401e4f3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250122174344.10000-2-hagarhem@amazon.com>
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

The upstream commit SHA1 provided is correct: 0fa5e94a1811d68fbffa0725efe6d4ca62c03d12

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hagar Hemdan<hagarhem@amazon.com>
Commit author: Jeongjun Park<aha310510@gmail.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 143edf098b80)
6.1.y | Present (different SHA1: efcff6ce7467)
5.15.y | Present (different SHA1: a0465723b858)
5.10.y | Present (different SHA1: a7f0073fcd12)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Failed     |  N/A       |

