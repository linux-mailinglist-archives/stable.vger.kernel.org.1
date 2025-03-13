Return-Path: <stable+bounces-124232-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7BA5EECD
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5583A9A00
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33BE265614;
	Thu, 13 Mar 2025 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBWH7PIB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6FD26560F
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856492; cv=none; b=Fnx/RrPx7PEp0L1ly1d7lL6H+0COSz+9LZvNnYxr/8vIAVAvmxlZTGqO1NBKyOV4eNjsFf6/Qh6y1cOSXdKhi3hDf+kdyijCqzErQgrAINLPx0X9npvyQhiy6y5tvlC5zPoc98i66ieEmhr4vgE0zWUM2niALLwS2l/mjAqilq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856492; c=relaxed/simple;
	bh=/MO+RhfsQbuf74KFXcnL88Og7UTS+CUCFBjqvulV3gg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KO96kbhBIuYcm+mje4YtWTkyZNwcyNcv+TGcK3JpFXTzG3T6Sma84zagAO4n/JQBsyfizxZtOFpejmnTcwp9HuNIAc/jmiOlvxrzFrFpPjmalstYFtzv8lnZIp+5szOJF72i+VTqn/GZ4um+/VH7ctXWNWVGMuIpVfgnZPUfZyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBWH7PIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EABC4CEF1;
	Thu, 13 Mar 2025 09:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856490;
	bh=/MO+RhfsQbuf74KFXcnL88Og7UTS+CUCFBjqvulV3gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBWH7PIBFsdyCsU3fu71hr09c6gSAB3YXTSJbAkr92TQIkl98J9zE8fpwW2D4sMD3
	 0coEGt8vEJ0GC3G9ySRqw6N4Y1q9TEbJdu2O2mGBwEPjl4SsBOsNWS4Nwmq0sd8Pgh
	 u+H0woHUt6IoPR/9KJ9u2GGMpuBqitTs10ckGpXTaWxwZY8PpIfok+aZgxDlFKZc/i
	 Wiy/NMRSl+R3WVG7INkYMtl5FdGhRSR6y81tu9oT/yPHXKpu5YVWwf9f4pfFfCs5kN
	 PML5N3uId4rTviOC7a1+gbEtlS+12QMMNBRRNPT7r9cmS8ZAttPvGmC8Zjvt9r79lC
	 E8hYY4cqCEx2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zenm Chen <zenmchen@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
Date: Thu, 13 Mar 2025 05:01:28 -0400
Message-Id: <20250312222819-7c4151e43c8684d1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311081001.1394-3-zenmchen@gmail.com>
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

The upstream commit SHA1 provided is correct: 9c1df813e08832c3836c254bc8a2f83ff22dbc06

WARNING: Author mismatch between patch and upstream commit:
Backport author: Zenm Chen<zenmchen@gmail.com>
Commit author: Ping-Ke Shih<pkshih@realtek.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: bf1aaf8eb546)
6.12.y | Present (different SHA1: e5aeac73ab04)

Note: The patch differs from the upstream commit:
---
1:  9c1df813e0883 < -:  ------------- wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
-:  ------------- > 1:  17fff42da3e65 wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

