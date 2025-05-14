Return-Path: <stable+bounces-144423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95517AB7684
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A8A1BA45F7
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26362951A6;
	Wed, 14 May 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRr3DDKy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C86295502
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253606; cv=none; b=rnbF6/2vqRbTvsT5Z8Mp2pGx6NqCmaIa4tYkhV5ot97ITzReFhTVRfDz+pscEK+zUcEIGRH1YzQQ9kA7vqyuFLYBE5e94b9lfxV/nczYheDTkdHhY7AlLUIuPFHz29ocyWuiOi+m+UuLZFB/uZBkzgNW2W/34srmff4MqYOM/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253606; c=relaxed/simple;
	bh=oaThZHxmnFBLTHwATtrAkMhN5uTcUkHu+Q2Rz3UyK9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvDsUIetQdXapY9k9vPkfH1M1iFayBSgzng3nUsPw7Knwc2UYFcoWcfGSmRgDZMz2F16E2ckF39QKUjxVDQUI4BITEA+p9HLVqCVLx6mze8su+LM0OKo2t37Px49LM1VGM606R98g3XAfQ+w5BTUYqkhz6ssDqFfX+yJgQZ2bsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRr3DDKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF9CC4CEE3;
	Wed, 14 May 2025 20:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253606;
	bh=oaThZHxmnFBLTHwATtrAkMhN5uTcUkHu+Q2Rz3UyK9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRr3DDKyV1XVX+vGUJeQCZgqHbXHWjSWUkpVMkT7P/mcO9U+0kUdpx+X5TKOK/Ris
	 Lf2Dlnt8qYrfkIyvxP42/5Kh5dgjkO6JRw8cO7gerwPiGNLpleQcfWvZoHsNR0ZDcv
	 fqom+cVPjojXw/A5w/UsMYQBPN7fxMjL5b0pX1WutTi/Yn5fLzfYOheQkC0QNixh5m
	 MHTeSd/nk+h3NpbUL+ntIXr43XSHa79Thp+ADNNNb6FzIeHJ3/8x9q8IJousa4Fdi+
	 He3cSZRTcWRRq5yHxzUXx0T8gfC5InwyzzZ7JHAfarKxbZy4DUQNfUiJVCt+NQ1WHV
	 RZUte+qyoNNew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2 09/14] x86/alternatives: Remove faulty optimization
Date: Wed, 14 May 2025 16:13:23 -0400
Message-Id: <20250514112415-26ef70f47a002e77@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-5-15-v2-9-90690efdc7e0@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 4ba89dd6ddeca2a733bdaed7c9a5cbe4e19d9124

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Josh Poimboeuf<jpoimboe@kernel.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  4ba89dd6ddeca < -:  ------------- x86/alternatives: Remove faulty optimization
-:  ------------- > 1:  3b8db0e4f2631 Linux 5.15.182
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

