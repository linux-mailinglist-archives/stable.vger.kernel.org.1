Return-Path: <stable+bounces-98196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2509E3075
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 01:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637A7B245FF
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 00:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1E84A2D;
	Wed,  4 Dec 2024 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq0Yeiby"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B77F9
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733273134; cv=none; b=sWZoAD81Y4/flQntdoVM90fR8WFNa0p7xTIrV8e9aTuhT2ngWI7RZrNNQtd9RmFTau2yW4SHrYieug0Kl4mcXsOuOVH3QGxGdYOau6gYP+QWtgBl5j/5Hb17FuLn39RGOs95TklM2+V5MTpgwzoK3BHfrZeJPYzDH8lz64cIjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733273134; c=relaxed/simple;
	bh=4SQSIXe4EnHdzQrYloju6aDt3qHvMTZ7XQQiCAZXyEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejXGG9hFY6osh0nD4UEz1ysjUP92HnZl3y3DQRQj8Ycsz9Z1Ys5jrRhtHhhZDzwny0tBT/Gm5rnCpkDuzg5/uV37MnQsf7J4EJ3TVHEJ6Os/KodytUtk3GCEA5LMrEQyS8AfMsbW7pgs8CQJ5XCCh3JdQfK3kDJ1npP1r9FH/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq0Yeiby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5A2C4CEDC;
	Wed,  4 Dec 2024 00:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733273133;
	bh=4SQSIXe4EnHdzQrYloju6aDt3qHvMTZ7XQQiCAZXyEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oq0YeibyBgtgC2dDoJXgTWBeVmkc57ur4cXFST60YHpGtJ7LUtHh1xJfjzVNfi5Al
	 XgfhwSOucyMkmtG1jWb9RCW0QSppBZLABj/2L/0sLgEph7FgmIGxhWslaeXkiD8sa1
	 xYMw1YkE76A5pfYpM6AcOuCvtbXqRWSxXaY8ISkUCPA9e3cK1XC2wpsmvl6XxKxK/D
	 jTBE9Js+uHYFyWj+E+r2KV7KyKZ0i/cC2i+H1UaQ3EXNoe2on/A66K676aEDNwAMQx
	 Cyzs9+wyEg0GUZkGUZE1eD+GXCp++VEI9BLT+zW9irfKHFG8ltPViVzdH/QIkAxrt9
	 AosdMxPy1ucrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Raghavendra Rao Ananta <rananta@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status
Date: Tue,  3 Dec 2024 18:34:13 -0500
Message-ID: <20241203180911-dd0663d61317b9d3@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241203190236.2711302-1-rananta@google.com>
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

The upstream commit SHA1 provided is correct: 54bbee190d42166209185d89070c58a343bf514b


Status in newer kernel trees:
6.12.y | Present (different SHA1: 2a68705a5469)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.11.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Success    |  Success   |
| stable/linux-4.19.y       |  Success    |  Success   |

