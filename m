Return-Path: <stable+bounces-104121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE859F1090
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931F4280ABF
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1611E22E2;
	Fri, 13 Dec 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9YcVb3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEB41E1A28
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734102807; cv=none; b=mnbsevCdGqMP49n1k/jGrIUDFTPosk47xb7p1Xnf3cIyzJhE12dXqZnVrEE53AnVjEg2541sIgODJIVm37wxaHnr4ihl8jwBaFhHz41ZaUsGTBxsYMfVP09KwytXczzjf2jQCrHSGLPSGhimUH/2X5ZTWRoyIkr6YUS8SrhPWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734102807; c=relaxed/simple;
	bh=0xEvfNKQb0qZAz6tCxJAz3ZXx1L/c8o5z/W5NLBmOe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHQyXOgPWaKKN1xXlSzBcneuqWWy8mDlU5Imtrsh4xDgAsHNrnQAa8rD+UKwws2TF2sZAhTBc6f7bdP8GQgx3AcATdTsFe8A4/2kIFOTY+3KQzylnNrrzLZ0aq6+Jb4NlzFnZgDe4WFLeRrpW+l2wn7Zdb3xYOVHcfCDStDCw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9YcVb3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C689C4CED0;
	Fri, 13 Dec 2024 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734102807;
	bh=0xEvfNKQb0qZAz6tCxJAz3ZXx1L/c8o5z/W5NLBmOe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9YcVb3TLtZiX5xDp627oxtivj5Y4p6JpwDznVGJlPBbgK5XmJn044SYF49Rk8lKb
	 3LsOmXvBaY9HbzODFU0u3Pu6G6Yu+6Yr/N8uzv6fBfmYBm4D72zISMX9CyQWsqDLCO
	 nHc39JdavMufKvbEhM4RP7Qa74YlwFeem0VxTtkHrUnyXprC2oCLlox/ggY5aOd9Bn
	 kT7h4qFlq4GGH1H2aqSiS1JY+T2TcegjtXeU/wC/KoyVMqgb81wYyYfczspY71qoJj
	 Wl1SOVkOs6bjKeF4uPp0I2WTBWcrl7e6lA4BRDapVrrwKgrxhYvT7wnqWHgaiA0i4Z
	 Bc8+EQVJVfmUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: haixiao.yan.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] powerpc/rtas: Prevent Spectre v1 gadget construction in sys_rtas()
Date: Fri, 13 Dec 2024 10:13:25 -0500
Message-ID: <20241213092118-fe9f63a978baa269@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241213034422.2916981-1-haixiao.yan.cn@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 0974d03eb479384466d828d65637814bee6b26d7

WARNING: Author mismatch between patch and upstream commit:
Backport author: haixiao.yan.cn@eng.windriver.com
Commit author: Nathan Lynch <nathanl@linux.ibm.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

