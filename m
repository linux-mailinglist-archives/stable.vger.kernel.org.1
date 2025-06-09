Return-Path: <stable+bounces-151968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D42AD16D9
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 04:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB91168FA0
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 02:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF9246332;
	Mon,  9 Jun 2025 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4vXyOvA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95655157A67
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436466; cv=none; b=EDCOsaWKHAstx6l87wuREP3GYFfRLRbjQ2YrJyYwdmPY288Ic+lbDGQ2LlbIfSYzWFqStfSJZ2rezoSUUauJPYcKoJplV4xut21aeyC8viRVePuz1IH6skh0df7BsUHOGMirlh8SG3qv99ld3sTLs/98vup5mLRu0X1thX87ezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436466; c=relaxed/simple;
	bh=Wsu7GfzV+cFAToBG+rnYRzyqsc0QDnwMp1BXJHnBXLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=na4mq9gBAQJMG1RuGWqwKdWOupkHCMMgg4YMHtsszZEx+AMzgjnF7HV7Q4VXVbG4MqeQ32yOYmYcgVnhu8jlxsRwllXfW5WYAS/hJAPh6IX+NqQl0cOOyjkHFmQP5MA4EUGprq4bsHdUZ0wpR4mXRQVT+WQqZ0BvDhkgUik2z80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4vXyOvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD549C4CEEE;
	Mon,  9 Jun 2025 02:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436466;
	bh=Wsu7GfzV+cFAToBG+rnYRzyqsc0QDnwMp1BXJHnBXLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4vXyOvAolRu5u3zuwb8VoZKjP9gVGO9cnosIqERpxqu28SZrVpUU7+pTczm5ljVw
	 KCGHJ/tJH6QR0cO6WZmhbDpWxFs++aYyzfZU8Q71tCAbVTH/UiSWGCpAj+ZZ4058lD
	 ZCukvKXSBNMRoS8UO0MizhlqTu4pdxpz+4L+CmRSyEaGIQI7e5CnNbh9VzKNPXmymC
	 PkUTagvfcrp32od/IWzTmDGD8eONAyYwk38e9Fsd4EyQIV6t2YZPy9y7dN75mxfE6H
	 +pZK+HLrywok4habSvnn9n1TQT2EqYgCGAtJ8Gwc5gIOG0PXEiJ/NCdEeeeexc6BYq
	 h8Fk3RUUP5Qvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pu Lehui <pulehui@huaweicloud.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 1/9] arm64: move AARCH64_BREAK_FAULT into insn-def.h
Date: Sun,  8 Jun 2025 22:34:24 -0400
Message-Id: <20250608135850-1ac727995597b76a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250607153535.3613861-2-pulehui@huaweicloud.com>
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

The upstream commit SHA1 provided is correct: 97e58e395e9c074fd096dad13c54e9f4112cf71d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pu Lehui<pulehui@huaweicloud.com>
Commit author: Hou Tao<houtao1@huawei.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  97e58e395e9c0 ! 1:  a01fa5ebdbff5 arm64: move AARCH64_BREAK_FAULT into insn-def.h
    @@ Metadata
      ## Commit message ##
         arm64: move AARCH64_BREAK_FAULT into insn-def.h
     
    +    [ Upstream commit 97e58e395e9c074fd096dad13c54e9f4112cf71d ]
    +
         If CONFIG_ARM64_LSE_ATOMICS is off, encoders for LSE-related instructions
         can return AARCH64_BREAK_FAULT directly in insn.h. In order to access
         AARCH64_BREAK_FAULT in insn.h, we can not include debug-monitors.h in
    @@ Commit message
         Signed-off-by: Hou Tao <houtao1@huawei.com>
         Link: https://lore.kernel.org/r/20220217072232.1186625-2-houtao1@huawei.com
         Signed-off-by: Will Deacon <will@kernel.org>
    +    Signed-off-by: Pu Lehui <pulehui@huawei.com>
     
      ## arch/arm64/include/asm/debug-monitors.h ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

