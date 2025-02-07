Return-Path: <stable+bounces-114333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE0CA2D0FE
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10A216D665
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1341B040E;
	Fri,  7 Feb 2025 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM5EtpDH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8741B4223
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968675; cv=none; b=fwMtrwZOZipBeL1nkKFM+tkR1t0/WELlxFEgTsqFURMyrEdfZ7Y83ULNd5nYCWIqIa17CLSZLHEySxGBy1DRZdLlA6QXWAd4gGqqgLofdoP+dMlRa/U1qlMOQnTazkb1tBK0BmSTxAuDp5FGMC4t0aqX4eu6ci/39DRAe0Vz7OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968675; c=relaxed/simple;
	bh=ciZjnzOlyrWgK1aPjLVKmmW/xUcjoHbh8EoI8Pyihww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PwnKlmhFlPvRcDru22biWXd5dro0zmJxAkSUPlRYeW8VHVNinH2hvgJvewZIvD3zk3u8hWoPJJMZ9M8DkUiOQZNDXieGjWRxAjUR+66N1vwzLeqPMhD79NL/s2puq3RNarbotd/7Sm7GTjBYDiLeu/+SfQ1Gy1iHfrTD/GPNUzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM5EtpDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B828AC4CED1;
	Fri,  7 Feb 2025 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968675;
	bh=ciZjnzOlyrWgK1aPjLVKmmW/xUcjoHbh8EoI8Pyihww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bM5EtpDHIhaTzpcOCgzCM3smjrM2WSTpZYjrmg+Z4FnrqtE1r7U1XKRTFuQq0Nk5A
	 Agn1mbSOVjw/uY3Tc0JPi0IznnGvFYdiY1t3fMJ5cAzf3foG7beuRV0o6YzqCWt2Gn
	 xYM1aU2qkgABa1KaF211SWy0SdQjmvfdhC7GLwa0+bYoZVDlyvkiyUfdDToYH9Q3pa
	 i8rB4+depD7GdpK0/W1Kd52Zkcm5Xry4Q4QvaQtU98SAx3ZNQgUkOwbK5xpneCw5SJ
	 XnqK7Gb/PIiqIhj+25247+tEbrh7kEjb9Isk0iU+q3UTxtSLqWdrK9fXs/fJDF/F5u
	 kg+2vAp9m8j4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yifei Liu <yifei.l.liu@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1] selftests/mm: build with -O2
Date: Fri,  7 Feb 2025 17:51:13 -0500
Message-Id: <20250204175459-0471fc53aa369298@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250204214723.1991309-1-yifei.l.liu@oracle.com>
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

The upstream commit SHA1 provided is correct: 46036188ea1f5266df23a6149dea0df1c77cd1c7

WARNING: Author mismatch between patch and upstream commit:
Backport author: Yifei Liu<yifei.l.liu@oracle.com>
Commit author: Kevin Brodsky<kevin.brodsky@arm.com>


Status in newer kernel trees:
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Success    |  Success   |

