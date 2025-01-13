Return-Path: <stable+bounces-108550-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB28BA0C53E
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 888877A2819
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70211E3DCB;
	Mon, 13 Jan 2025 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLKg+xzB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B441D61BF
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809765; cv=none; b=S+4KKgNfqlfg0ZqhGwM0I0vZnTeryT3oITmnr35CC9txQ5dZPKbfoXAM0luRXbw+VX1k9KFpYjeIpSWKVNXeehs3ff2nY10qbzY0+ZDVskBsb/RxKagpG8hHQ0MDLad2EfqBgk1FBUngVxpRbj7pQXXUl1dWq3LbjbMkN1unifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809765; c=relaxed/simple;
	bh=/pUnP5Kp+zbAjHgrG/MeOTDaOZVy1RZxMG6dpde/WIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9RQ00LMOx2qF/TQMw/DIsbCvJOpYwACzqj+xpgGKkS433u4+CJ4hDr8LCkjvBDq4Lx0fSsdhvHGAghMGn3eo1bkwqHMAMSP8Q1MKHAIzxKCE3GcLK5fCI/g96LcEi8pkAVnOF8KvcwFv6UIruc550GNU5ocPRwGqWHimzzRU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLKg+xzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD53C4CED6;
	Mon, 13 Jan 2025 23:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809765;
	bh=/pUnP5Kp+zbAjHgrG/MeOTDaOZVy1RZxMG6dpde/WIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qLKg+xzBQwo+wDN6UGGo8Iz52r+9i15DLV3hsHoLUzKDQVpqCwsG+hf4DOpQZMuAp
	 6/SmScaEBn5PngZpSbXUI7em2WUSO7Env/dUpWQ9rGtVDjhNQnDcjbwOYBAV9Guz67
	 lr8wKR/mn1wZMEF/SZ6VY15B1KYUnHjAp2lQBICGOv5RMrXCgFNf6uS2sIVe2Y2ZwL
	 53GNhqcK3KNcp0aoWYCjLNaNpBgswYj2PhN1eh0RcWuYimdaah2tx6G4M3lXVrgllX
	 4S9zbryKpfmKcC1MHEKahK/Bag33iKKPSSL+CpMNWwDvZg53eZ7K4VE9H4cIbH50c4
	 22CyHDVAsh/UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
Date: Mon, 13 Jan 2025 18:09:23 -0500
Message-Id: <20250113154136-f7ffdc9ef966aafa@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113154303.834996-1-inv.git-commit@tdk.com>
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

Found matching upstream commit: 65a60a590142c54a3f3be11ff162db2d5b0e1e06

WARNING: Author mismatch between patch and found commit:
Backport author: inv.git-commit@tdk.com
Commit author: Jean-Baptiste Maneyrol<jean-baptiste.maneyrol@tdk.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 7982d8f24a9b)
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  65a60a590142 < -:  ------------ iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
-:  ------------ > 1:  e5c13e0a1f59 iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

