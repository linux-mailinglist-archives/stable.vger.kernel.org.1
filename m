Return-Path: <stable+bounces-163310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EABB09932
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71F9560C73
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEFE153BD9;
	Fri, 18 Jul 2025 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U72wZm6S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4461145FE0
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802467; cv=none; b=QoBpfse7a+/U4sno7GUJKXgpbe4iBRHO43a9sZyZXy8QYObF4FxEFMFzMXOVFeHNg2yhgIotBzm7cAQDMjDp2tr9EqD/5cYgmtKJxaxi/mS9FGyXvpoUiH/n+kMyGW1FCVHmEbWzRtaXXCc4dbe6j+J6Zh2VkV12CQt0S+YItDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802467; c=relaxed/simple;
	bh=+I86k4Xg2l1VcN/IEgkXUFVbhL+KE2pvbu5wOec7xAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecSb2FEMWr7BB9wG36Ssr1XmiSim5X4CkkohYo+h7Ae5/BmPS0I/y5WyfN2eokToDf/c0c2XR8UJM+i80dQWRpKRvZG84BYN2JqfnwOpGHEqB2Ztx2mgtfB2JbMASPsdNaDy9Dhw2GYpVywu4wWZO27Fw5VARPQ7IqcDYzVra5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U72wZm6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5C8C4CEE3;
	Fri, 18 Jul 2025 01:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802467;
	bh=+I86k4Xg2l1VcN/IEgkXUFVbhL+KE2pvbu5wOec7xAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U72wZm6SqgEjwRKirCwbB8H9DTRcO7PRUI1smBYj8lugkYzDJdQpA4nn0EPX0cwu+
	 8g4+IiX3Gvh8+u8zGyRrtcVuogVo0xjPnEOYIlpcSqQ9FT/wm+UGnvgV7/WE2xyHQE
	 jpu2UAdVIonixigFH4SVcFChfh6XfqDLfMui8Cq7FyIUPjdtkV+88OQi0nWPnWXyb4
	 ebxqhjteBP/7s1YCPgZr1CmZJ9sPj9BBh8eR1K3a2j9Kvq+iUOo34VYViPlrnPz4LN
	 629FMl3/x0pIUB+9bpovIg0CT14MetOujnKUpL2E6nOB0T9yoeJdElirVC0DclW5tg
	 Z6nRIgyVvU8jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 1/6] net_sched: sch_sfq: annotate data-races around q->perturb_period
Date: Thu, 17 Jul 2025 21:34:25 -0400
Message-Id: <1752797234-fbbf60f9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717124556.589696-2-harshit.m.mogalapalli@oracle.com>
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

The upstream commit SHA1 provided is correct: a17ef9e6c2c1cf0fc6cd6ca6a9ce525c67d1da7f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Commit author: Eric Dumazet <edumazet@google.com>

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

