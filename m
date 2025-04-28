Return-Path: <stable+bounces-136937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2986A9F8B5
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3458D17E41F
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1855227A92F;
	Mon, 28 Apr 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDGjTvAg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76751BBBFD;
	Mon, 28 Apr 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745865554; cv=none; b=ftqny2NbNHUaAtW8NsbRR1IQf6enR6Euz5/h9LH2FhyB+NFrKk9JH2311lymhvwbrfrnaX51JyHGF3R7iK7XiswXmdipdUoXTnrt0v0ig9P6euNj9THV7tjs+JCf4QeXAOchpNNvhyp0Z7XiMFcxWs3z/A0a9swkQ6spXi4+lO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745865554; c=relaxed/simple;
	bh=79PAJBEhak912MvDV8PI/M2GPtFL7LcrihkAXFYnE14=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=ZVX+V09u0TdVMvpm9Ju2V1tkwHK5Xw2Z6KdMYSZx+tB0L/+CXNHbiZeVL6xFhpchBXGv/LdPkU9O+Y+iiE8tpsAcA8BCzuIpkzX7fPhCLVGm8HzD481tl0ers/r1inA5XvwnZ3hy6PvPwhTVIGtIc5mjt1+O8qjSPN/ou8Ld1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDGjTvAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F71C4CEE4;
	Mon, 28 Apr 2025 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745865554;
	bh=79PAJBEhak912MvDV8PI/M2GPtFL7LcrihkAXFYnE14=;
	h=Date:Subject:From:To:Cc:From;
	b=pDGjTvAghGqZ86OZJ3+7bbtB2EU0N+xaiYPQ5yfvqLX/LHYVgrfac2px35Rm3SemU
	 zvXJLcthGpIPvq3wYLqDjhikExs1/fhIyo7L705gb1xy2i4eRRjiz5HM0VdklfIGFm
	 BxOa0FquMV543Vu5NLJA2o+/FYJSL1DA9MBrVqdoE9uWdFQjQiZ7OT34VTMo3MpQ7+
	 Xv9kcPIG1iduXx4TRGkzg71GcmZq/aHqgE5g1w5XMqGCNTp1hOCYMA6uMwQMZj5NTn
	 KJpjz3RNbFxdYt+aWOCGOwY7k/SRcpv2ZjDzmYljS3+u7rqb4hjIhXPBYk15U4ipUV
	 MTLelo2mrAztA==
Date: Mon, 28 Apr 2025 11:39:14 -0700
Subject: [PATCHSET 6.12] xfs: backported fixes from upstream
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: sandeen@redhat.com, cmaiolino@redhat.com, lukas@herbolt.com, hch@lst.de,
 cem@kernel.org, dchinner@redhat.com, stable@vger.kernel.org
Message-ID: <174586545357.480536.7498456094082551730.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's a bunch of hand-ported bug fixes for 6.12 LTS.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=next-6.12.y
---
Commits in this patchset:
 * xfs: do not check NEEDSREPAIR if ro,norecovery mount.
 * xfs: Do not allow norecovery mount with quotacheck
 * xfs: rename xfs_iomap_swapfile_activate to xfs_vm_swap_activate
 * xfs: flush inodegc before swapon
---
 fs/xfs/xfs_aops.c   |   41 +++++++++++++++++++++++++++++++++++++----
 fs/xfs/xfs_qm_bhv.c |   49 ++++++++++++++++++++++++++++++++++---------------
 fs/xfs/xfs_super.c  |    8 ++++++--
 3 files changed, 77 insertions(+), 21 deletions(-)


