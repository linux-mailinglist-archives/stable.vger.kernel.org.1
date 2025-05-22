Return-Path: <stable+bounces-145967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E491BAC0210
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D981B640CF
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF1C5D8F0;
	Thu, 22 May 2025 02:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTs0yg5R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E046B1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879492; cv=none; b=MQucfY94iz16tdROt4D/+bZalXdVfsQjBS/Y1ST3TmnX4T8AUD58zgQDBEkj9d971D4iD9Wk7fXRgK5SEhrQHuqPNsfifx5PL7iIYvhIWeltLN8Ekderfa40J/nsNJ/Wacy51qvqxAX8tF48HvXpakFqvRf1V9ZPZB9LZIZ5d80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879492; c=relaxed/simple;
	bh=oGjO23zVixLDEnXIFcBrUY/uHK/AmG0KSYkCbXZkYZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnaNn6bIN4pRZPY1toVrwy1miqmPUwGfEikkfkIJLAdSHLjWB27n6IGJB5z5Vh1niya2aiDP5fXYPJTg8/pFu3D4fwEJaX1PcUnG3fvAL0l25yAyocuucf1E2Q3uKYYKdqGnpVTsTUSC4wjI8rMPF1dQlOJjeud2mMkYJgwjG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTs0yg5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FF6C4CEE4;
	Thu, 22 May 2025 02:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879491;
	bh=oGjO23zVixLDEnXIFcBrUY/uHK/AmG0KSYkCbXZkYZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hTs0yg5RgBBxsU3zlT1tK0HQ3aeD+SM8MYzXf/NtPMHIiwCZmWksklVqOckDsJaYn
	 UFiR0vO1KHB3bB9MuLBL7tejYYJ8RPWDlpzQx2IB/bVHOeCeYbM48/HSZErBmPh9Jd
	 IXTNFaiZxogtdk8OOlDJcpMZpiKfDvW12zyU7jB8+JzvQqOB2Wb6BFyWwOLHLevoyN
	 Ovc52kxBvObRumjeahPvSANNTdNhNxnpH05KAKuU9Bo2J7tywdKGiuM3cED8P8heWb
	 Sa+CJX22O9MKMMRczHlUti5Ngv7PhlEkdmJBRXkOMtUNBMKrMEcA63xR4MNgWjfKuP
	 WcNyiXZplW3TQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 09/27] af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
Date: Wed, 21 May 2025 22:04:47 -0400
Message-Id: <20250521201605-c0b152cf72c52420@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-10-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 29b64e354029cfcf1eea4d91b146c7b769305930

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  29b64e354029c < -:  ------------- af_unix: Allocate struct unix_edge for each inflight AF_UNIX fd.
-:  ------------- > 1:  325285d9fc869 Linux 6.1.139
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

