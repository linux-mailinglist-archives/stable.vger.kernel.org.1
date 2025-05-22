Return-Path: <stable+bounces-145986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEE7AC0227
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F05A4A7682
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24762B9B7;
	Thu, 22 May 2025 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaG1sHLc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ADC1758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879570; cv=none; b=LdqUzcdv130iHwKOKwWK9MvOFucrhnLTMriLz+RNu9phnAX91/JiD2GRzvK6dOtDWp9aaUo0oz+qU6LentD6Vm1a0Hv5wRt7tfzMnST+OZ9fZLjv6FVYlY5t6aGBZi+lbUgqIHWamSaXWyxt10uQb9Sfud2gPeeCWPF3Dg6yMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879570; c=relaxed/simple;
	bh=qbT01vfaq81sbY+eMe3QCGXYfa3t6rOk4zAcwDNNtio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tUjO8Z/3S2CB1dzTPM+mbZnkaEDVsgkGuCfdxnVC5FZphxNGVnW6lmEhExzYbECONLZ872ZwEO5P9/SxF0nJ2tJX07sdD9Jvf7TytJkarHyLsukhvZT9js6++NbTpVjePTurQDXVo/FLqf1RUVM+fPUIGAmOQiZE4edGcAlbV00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaG1sHLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EB1C4CEE4;
	Thu, 22 May 2025 02:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879569;
	bh=qbT01vfaq81sbY+eMe3QCGXYfa3t6rOk4zAcwDNNtio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaG1sHLcNCfXPrcqgWW3a5qVwDfNat5YiYYTjOLe+cLkhSjS45B5SYxpunQYr+R50
	 J4ipyPbwbQAkbVACsmkVeZkq5NSh80s9YHy3hRB8J9PAfIKwzhG7w0q7s3YPrG4cwf
	 7sD3x/bZN8Aas84wcjtPzes8/QseG5P5X2dMvKG14LPVDepRUNOfDaLat/omKheGJN
	 zOCjQxvYNMjudC40w6n3kt4rt/8tP+UXTei/KaLfa3Z+NDFzjDZybKq4/ct7lTxmqB
	 InS9b1y6BaVWxEVRcpWRYdr7gUpZWk+5jmRhtpTKn5Qq8XbttobVaNYJWXRp9b6iYg
	 wLWxPyN9sZMVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] sched/deadline: Fix warning in migrate_enable for boosted tasks
Date: Wed, 21 May 2025 22:06:05 -0400
Message-Id: <20250521155628-927d24b98151d159@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521013316.3339744-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 0664e2c311b9fa43b33e3e81429cd0c2d7f9c638

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Wander Lairson Costa<wander@redhat.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: e41074904d9e)
6.6.y | Present (different SHA1: b600d3040285)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  0664e2c311b9f < -:  ------------- sched/deadline: Fix warning in migrate_enable for boosted tasks
-:  ------------- > 1:  5e9a366aaf1a8 sched/deadline: Fix warning in migrate_enable for boosted tasks
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

