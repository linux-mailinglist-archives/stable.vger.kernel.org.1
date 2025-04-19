Return-Path: <stable+bounces-134705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF405A94349
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 13:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB763BF57B
	for <lists+stable@lfdr.de>; Sat, 19 Apr 2025 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C028F1D5CE8;
	Sat, 19 Apr 2025 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMsQGQHZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36340BF5
	for <stable@vger.kernel.org>; Sat, 19 Apr 2025 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063446; cv=none; b=txh8rUJyHmYHy6gfp4bH0O9k5bVqqknqV+LODhi+efFKUv/a85S9bl2zf5rVsCSxiIJNbLniSPsoXM56RXry8+GoFCC6TKNAvdoDPQgYxoRo9oMVoibhIeMjrUJqyG1h6xOwDgcTTjEDPxZrNuGjAtoxbEiYL5oplqH/odwNudE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063446; c=relaxed/simple;
	bh=5QiZ2TLdzpkXQb9S0ZniwEip1fQcBGON3DgF102hi4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4ZykwVjkdCAE49KcGThHx1ZBxieGgdvrqq5yHhyl8tT9FJ0J6cSA/H9KdOk9jpqUiVUZnt5SaAAlVJX0soi+qK665boeWkZDZQ1UtdaxGjso/X19zFN41YF+ikj+CX4f0B/xq7RVHsmFUUJ8tkX2efdMb2Tiy3cDzY0NlNvznY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMsQGQHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7659EC4CEE7;
	Sat, 19 Apr 2025 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745063446;
	bh=5QiZ2TLdzpkXQb9S0ZniwEip1fQcBGON3DgF102hi4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMsQGQHZkz21DYEz37YjTKOj8LneYYF/JbxSdbHrpUABmB09lqu5ofcUOtmU/ZhXD
	 HUoV2frOcHKc9P21NEqozaSQFB2o5HHCE1fgIN4xibkDwk9OhfZXBWdT8Bhaa5jl+Y
	 Pzh5EKZxig3DxvmeZr9gqHBGLDa+kuCu4ONGJ6qBey86/eagZ4MVZNDcIcrQLEkvzv
	 O2kDJ7hc68+sID7uO8mUp0lT5cxjR2cy8eBm003fHpzKzo3Gzd1PgTmOV3mTzKpamy
	 lNAbThAN6TRCWdN7dCjdTt5C9SDHYXCjjo5jEfrfIfQC+N4HhGNgtO5HIwGj4Up476
	 6utEkrjO4C3TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hayashi.kunihiko@socionext.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.13.y] misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
Date: Sat, 19 Apr 2025 07:50:44 -0400
Message-Id: <20250418155822-30fc3b98a38fcbc0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250418124357.2045813-1-hayashi.kunihiko@socionext.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: baaef0a274cfb75f9b50eab3ef93205e604f662c

Status in newer kernel trees:
6.14.y | Present (different SHA1: 30ade0da493e)

Note: The patch differs from the upstream commit:
---
1:  baaef0a274cfb < -:  ------------- misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
-:  ------------- > 1:  9fc9a297ac328 misc: pci_endpoint_test: Fix 'irq_type' to convey the correct type
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

