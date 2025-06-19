Return-Path: <stable+bounces-154774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41262AE013B
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA961173CA4
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73563254AF4;
	Thu, 19 Jun 2025 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA2h1CIl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC026E705
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323859; cv=none; b=aoFyWCou9FqiTNRXCmU/qJqBbylFBB8RGRgM+9JZNiD3qFy6MIsYGZ3Hz2RWSREh8bY7ystNH25DoLQMESDm4uEDHlAorMSp+KGmB5F2O44zcbbD7xrN2fNSa+B6KSaxwjXBcOck9PQyigItmwTv1BbSgqd7+S0y/Ez8FOqi2sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323859; c=relaxed/simple;
	bh=21kSfqd66wXWm2cGYcOSJdJB6WYxcONv6mG2hi34Nz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N++J3XPSTm2GDMFTEMtELviyeFkWJwKGyiMjNuGQHyYgdCRH21zToX/tA8BX9w868mGq1VssV8D/vUb+Jym0DfTqn4ad3O5hWfaDqIvc4mx2BdmSsBsIsVvbAGnvFuVMfYtNzkBsXjcMJNDHdx7mswL3oQrXgB9rFugrsTFpeaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA2h1CIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A62C4CEEA;
	Thu, 19 Jun 2025 09:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323856;
	bh=21kSfqd66wXWm2cGYcOSJdJB6WYxcONv6mG2hi34Nz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rA2h1CIlM+6jy66w9cOdleLFkmA1dYY9qkDJGYqDgLGXxRTJBRluVmtSCyhQmyG76
	 6xOA098ylHT8aeVnhv2iunbMR3qrRTBaN/xAT1yuOldOvIeIxvjUq+nYKeM33JJ2FM
	 HnoIDHiA3/sLBaxbwcahKFNciG+0LC2EE4yZHHlJoez883/lkYrzBmC8war8bPf4iq
	 l2NuYVzvXxlIgnlivMSoJoJIcLsPomTGXg1+NGgMFE8ZKF38yqNnLFi9PslyKXJRl9
	 YGHEtv1tVqmhklk3hD5/EcZeAo3Hd21kblgURLAWdGxYx6tPwNaSANnfB43TAFm9Sn
	 9NUFq3RgKGusQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y 2/2] kbuild: rpm-pkg: simplify installkernel %post
Date: Thu, 19 Jun 2025 05:04:15 -0400
Message-Id: <20250618152046-1f097e8fdae1c770@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617193853.388270-3-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 358de8b4f201bc05712484b15f0109b1ae3516a8

WARNING: Author mismatch between patch and upstream commit:
Backport author: Chuck Lever<cel@kernel.org>
Commit author: Jose Ignacio Tornos Martinez<jtornosm@redhat.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  358de8b4f201b ! 1:  4ec47d5c243f8 kbuild: rpm-pkg: simplify installkernel %post
    @@ Metadata
      ## Commit message ##
         kbuild: rpm-pkg: simplify installkernel %post
     
    +    [ Upstream commit 358de8b4f201bc05712484b15f0109b1ae3516a8 ]
    +
         The new installkernel application that is now included in systemd-udev
         package allows installation although destination files are already present
         in the boot directory of the kernel package, but is failing with the
    @@ Commit message
         Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
         Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
         Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    +    Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
     
      ## scripts/package/kernel.spec ##
     @@ scripts/package/kernel.spec: patch -p1 < %{SOURCE2}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

