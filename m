Return-Path: <stable+bounces-111929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46566A24C3D
	for <lists+stable@lfdr.de>; Sun,  2 Feb 2025 00:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF79E164829
	for <lists+stable@lfdr.de>; Sat,  1 Feb 2025 23:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBDC155393;
	Sat,  1 Feb 2025 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmJ//3Mb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32F126F1E
	for <stable@vger.kernel.org>; Sat,  1 Feb 2025 23:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738454038; cv=none; b=bWrOHfahJ7CAdEY5zNHwcp3ChXkoTwvdh0GtbB01fSXDEd1UhUTjxyndwuvYuwyGRaDcTnuS+H4PTAf9CDCOZg3czj3cMnFKeRm78ya+pZ18/28H/6seg78h10kxenrhcL5kxxlbgD0Co/J7UkbF+jcjK5iSfi6oXKtRWuuvNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738454038; c=relaxed/simple;
	bh=RPomGiSgc62ln5nNLFc8HnN6W1kTw2j/QDylJ1V8Id8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhJMKTVdwWhAX2UQrvegYOZ7r4YuY3v4ZMuDgUiZdtclHUZOBuCQd2CdxeQHU2ZodC2phcITMYzVNAjSLYXo6NnJ+SSg9KXg7tYd6uwZQ5bLV67u3H5oOqTNr0g9ekhu5Z6xKAn2W9VYwlTQW7A3wDIyMM1Xn28I2tmiFq1BWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmJ//3Mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4E4C4CED3;
	Sat,  1 Feb 2025 23:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738454038;
	bh=RPomGiSgc62ln5nNLFc8HnN6W1kTw2j/QDylJ1V8Id8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmJ//3Mb92DYI40Xk1AymFSH0kJHxrGLuwmzjqf1/8MFOkusxVgHj+EItPHfh6Lgo
	 /QoAUCXWtsSZbAZH4Q4I6kJkOyG6zHy2pr+b1dCwZz1WFRnfHnyEUlT1qXr7zI+PRq
	 RPeeh12k7wH0E6DOCbmfg+1WUk1k0MZ5alscfhF92Pjsh4M8Eqf9fAWWVQ/+7dn6eR
	 ZITtZwDu267rZEM/gF/UW10XFayXiL7HdKgHj1nGmYbHmICp4Xdp+wqtvI19MPlO7N
	 Ac+UAohRFhsG9RpFZJMiJKInGoXPzVHRjimtMBPrBycuHgUFLtqXLWlmTdpEeAnm+B
	 2C5viUNXYIjhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ciprietti@google.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 1/1] blk-cgroup: Fix UAF in blkcg_unpin_online()
Date: Sat,  1 Feb 2025 18:53:56 -0500
Message-Id: <20250201123852-99f035a9e75353c3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250129163637.3420954-2-ciprietti@google.com>
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

The upstream commit SHA1 provided is correct: 86e6ca55b83c575ab0f2e105cf08f98e58d3d7af

WARNING: Author mismatch between patch and upstream commit:
Backport author: ciprietti@google.com
Commit author: Tejun Heo<tj@kernel.org>


Status in newer kernel trees:
6.13.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Failed     |  N/A       |
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Failed     |  N/A       |

