Return-Path: <stable+bounces-125769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39302A6C170
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 804A87A6F99
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A03D22D7B9;
	Fri, 21 Mar 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWu+9N2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B5224B1C
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578049; cv=none; b=hsbtqdy3USzL/y3vu4hpIFXoRhJRckBlWkb9ZIFWnwiAM4P5lvqVeQUorNw3Rw9P3T0ouv5RZKr/bNF9363Bmiy21vlmoqEgvyS/GfhU3zA5XF4QXH0vpIZ/k/vLU0UfJyPQteNpvBTwI3dMh2izYYX6njvx130RNKvhW49+lzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578049; c=relaxed/simple;
	bh=EFS8Q/l95oTQItbRyhN2b9ntIOH01EUiNXNSt6g7uCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DR/vvuJ1ts8++dLrKlPe9sPqyRLX00K25CNwrsRlC9OfNjRYXX4Xvv6zfSuXe+HEgCTwtlqfgex8W24D22JGeSqMyMfMFNC3UaUTAeIiUcn50CaESqPBuwMo425as4y+qKgQFdp3BOfmY83rSAqkezfGRw/KEw4jg6Ddlbj5rb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWu+9N2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE06C4CEE3;
	Fri, 21 Mar 2025 17:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578048;
	bh=EFS8Q/l95oTQItbRyhN2b9ntIOH01EUiNXNSt6g7uCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWu+9N2/z38jf9hTnfIZm5wKhlt92JZNm+dp21wlCYeVtA8Njif+e9Eqf2p1MIt2g
	 pVWEp0NjJhlh94op884PjEY8UqfJqrnBwyZIqbSMHHWfmmDfQ/mR8hmnQWpZPZ7oMj
	 WZLCwbPz9rXuzkq+AbrcaMAeRT5dkRBU7+3ywzuo/BUrKxCRSIl6HFSc/kDN1BwNBx
	 zNjbcpLlMb4UBHh836E8TTYmZMngrYINpBojBb3i4iTjXUPXGiUmw/a9u5W+43fDdd
	 BltVMgHWL0Wl3SUvQJJcJ2559vj7gTBElb2cdOVQ8lrEGrvtKMB8kOnSwZSPYJPUYT
	 zd9Cdk1v1ABhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 1/8] KVM: arm64: Calculate cptr_el2 traps on activating traps
Date: Fri, 21 Mar 2025 13:27:16 -0400
Message-Id: <20250321114127-3f2ba7f63e627759@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-6-v1-1-0b3a6a14ea53@kernel.org>
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

The upstream commit SHA1 provided is correct: 2fd5b4b0e7b440602455b79977bfa64dea101e6c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Fuad Tabba<tabba@google.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 341a0c20c99b)
6.12.y | Present (different SHA1: 2ca27353e642)

Note: The patch differs from the upstream commit:
---
1:  2fd5b4b0e7b44 < -:  ------------- KVM: arm64: Calculate cptr_el2 traps on activating traps
-:  ------------- > 1:  caa9f52b94cb4 KVM: arm64: Calculate cptr_el2 traps on activating traps
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

