Return-Path: <stable+bounces-100680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826DB9ED206
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03668188A11E
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0595D38DE9;
	Wed, 11 Dec 2024 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtr7Nr2r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCC1D9688
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934816; cv=none; b=cht+r6Q6zvnSiFFZbGoampLlhcTizMmViKqLfxYQrAtL9NPnNFI36VazefcQwhcec5Nlxwxb9sx3ad8xuO2wMC2X86g+6OFeb8ZADcV48zv6SCjSHs5pCpyvzrt6bOP+i7M24+gcllHyQ/Xm2LR6HWAmDAzeOs1MdKhjJLkfDyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934816; c=relaxed/simple;
	bh=jj1qqvdMZGX6GnBv+VggTIvkjExmgipjRjxyy/AmTk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5TBL+42I3nj6UiczhOP7qHoSPv4oH/bi9RMVrruOQly2M8c16e0k0r0GHzgsOy4oxF9MCfQHSNc4xyXntwrksQP6YWSUes5dq8ocWqTb+3ojyAk3/Zi1HJMMcl+tWPY6zCEIuP2VXSwMkWfFK5PR95LE0vsfpXCDNup6qH5P4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtr7Nr2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD920C4CED2;
	Wed, 11 Dec 2024 16:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934816;
	bh=jj1qqvdMZGX6GnBv+VggTIvkjExmgipjRjxyy/AmTk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mtr7Nr2rS0/bDoMY6LLUjbatMzJpQDzB60ZzFaO0X/xlgAFKC3MBEQcKGfljJqAzO
	 ju0Uqvyf/Kya9moM+1/YhqlND1mMGsdlpzDIFCiAbLYePvzRU9tbIKBcmBZMj7lNqB
	 wsfOYksFpyTClbrnhKNnPZR0ro+jtstvxtb8g5jLlhKWjssEu7UcpUl2rFVHSFsZ/h
	 A1X8LpZOBe+DIFu7q5vWX7MGTX7npiTZ4ye+H1qnthXXFJkZQXbd2xa9F5Ur4Z8aQT
	 I+tOJ21QJYmPz2pESjeQxlAYUNxVKePqpX1Mr0TXIDBsOqOlhLQr1YFrzEEePWQL9+
	 U99G82y2i/n+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hui Wang <hui.wang@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [stable-kernel][5.15.y][PATCH 3/5] serial: sc16is7xx: remove global regmap from struct sc16is7xx_port
Date: Wed, 11 Dec 2024 11:33:34 -0500
Message-ID: <20241211110234-6b9a881a3acec4da@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211042545.202482-4-hui.wang@canonical.com>
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

The upstream commit SHA1 provided is correct: f6959c5217bd799bcb770b95d3c09b3244e175c6

WARNING: Author mismatch between patch and upstream commit:
Backport author: Hui Wang <hui.wang@canonical.com>
Commit author: Hugo Villeneuve <hvilleneuve@dimonoff.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: fc3de570cb30)
6.1.y | Present (different SHA1: 6dca71e6e14a)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

