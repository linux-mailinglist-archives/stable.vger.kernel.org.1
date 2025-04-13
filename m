Return-Path: <stable+bounces-132345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F21A872AA
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62D93B74A0
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B71DD9AB;
	Sun, 13 Apr 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsGDPxQt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7171D7E37
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562810; cv=none; b=c6lv9WWaCtTcNxHdhvZSDt7KlEJutyFhP65D2HoaS2zFawGeGTnNz0mHiQUQ6sQzr8CToxKgE5qLEB+ItwVbaWOmpE2QiLb2kTFXYf7o/x6t1CKBvnweo6HrX1UdGhLlW1zkc+yXbwKNio8Eg2nuhOPXfKMNyVD4fFLJaT1E7W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562810; c=relaxed/simple;
	bh=OR2ikprLfxSlzTNy0awypLpG7TUVJNtNAwVVY9jXghQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1laubHyLB0Im2gfppG9zndUNlchpX6om7EoAZ9aFgzYvJXb1PQAYyOJN1wcfg0zUoXIqBLGbdBxe/AKgb9fCI/IHEXMZV8BK6t6D9dob59IH8r6+WfDmY385vQ/bg4Idiy5SsioLTApS4U6o3aZwYeQQaJPQ7T7tclsPBtZMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsGDPxQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B8AC4CEDD;
	Sun, 13 Apr 2025 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562810;
	bh=OR2ikprLfxSlzTNy0awypLpG7TUVJNtNAwVVY9jXghQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsGDPxQtpavaBe+hErKX4lA5NejDJob4elayznKVebKpDx84vqAuo66UQ+mfOwMiN
	 Dy5OfmREcxg//sVmkG5qdWB7HUdglXIteH6jk2yzIfZC7Husi0Pa2z0nyRsROVlNoO
	 1w6F2W+XtssN3a1T0zWBgN8sPdJ0DoxwE7EVjgaUi0yEomih0iqRqGG5n30067acoT
	 y/AXh+BbPnZDi93BIWSxJuia+UhckkcjQmVi38FM1qG03NLyGR/m6fkuRjU8vj0a9W
	 JTdJ5A7nO+IDYLZ89lo/ryC4tWmxj4DScsxlob0FpgWTZg9CqWoTP04A75ciI+AbkM
	 1qddjOA4NggIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sauerwein <dssauerw@amazon.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
Date: Sun, 13 Apr 2025 12:46:47 -0400
Message-Id: <20250412123837-087c22b867d4b818@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411154701.57102-1-dssauerw@amazon.de>
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

The upstream commit SHA1 provided is correct: 7601df8031fd67310af891897ef6cc0df4209305

WARNING: Author mismatch between patch and upstream commit:
Backport author: David Sauerwein<dssauerw@amazon.de>
Commit author: Oleg Nesterov<oleg@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 3820b0fac773)
6.1.y | Present (different SHA1: cf4b8c39b9a0)

Note: The patch differs from the upstream commit:
---
1:  7601df8031fd6 < -:  ------------- fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
-:  ------------- > 1:  49c9b6bb0f69c fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

