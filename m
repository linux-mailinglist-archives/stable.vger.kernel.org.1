Return-Path: <stable+bounces-206470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8526D08FAB
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 12:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C3D13012C46
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 11:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CF0358D22;
	Fri,  9 Jan 2026 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uAVMZ8Hq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C273596F9;
	Fri,  9 Jan 2026 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959108; cv=none; b=NFx0fAbySajbbcedFCytG0TYIJ5DLIR+TbE8gwygxTNPJ19Gftk8dUQHeWO+Vp6/haYwHHb6hS2egvVrL+NPUZe20Q3MYxrBpf964ak3Cr2gvvT9lWQMuVhwX5Q6G1n5hbZsfNQBM0twgnIwqHuB8RHuSpGGfEl4m2RBk/9HRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959108; c=relaxed/simple;
	bh=Q2pvO5VZBfKY8Lsb8CgnM9zNbRX+1jq/sOynErnWHfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQ9KyQkXmm3oLh38YjVEaK3TnZQvTtxXem9mTrxxh9dfeFTINkDBCgawktnxV0R2lt/ruB4eqvb96wFATtmhyDHfFvfii3ZYqAszFwrPHWazTHiuMoRc3k+qAeCsbJw2G/oyoNCotQ870QHmty1f4xXkADkVP60lj+WLOKduXHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uAVMZ8Hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A657C4CEF1;
	Fri,  9 Jan 2026 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767959108;
	bh=Q2pvO5VZBfKY8Lsb8CgnM9zNbRX+1jq/sOynErnWHfI=;
	h=From:To:Cc:Subject:Date:From;
	b=uAVMZ8Hq7VfTdoFl+wb/vBvRU2w88KNX1UlO4sMk1rqvxbCdWlAgf/rtd15WD9Vus
	 Zj82MXy3KRzBDIswtTAKgyEm9o3X21lGn6eVccdclJXnere71hkRA06EYTKBPA9K8W
	 6nRxBHKOUpPeja0sW3WTzNusApsZppjpO3QpSr4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	sr@sladewatkins.com
Subject: [PATCH 6.18 0/5] 6.18.5-rc1 review
Date: Fri,  9 Jan 2026 12:44:02 +0100
Message-ID: <20260109111950.344681501@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.5-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.18.5-rc1
X-KernelTest-Deadline: 2026-01-11T11:19+00:00
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.18.5 release.
There are 5 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.5-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.18.5-rc1

Mike Snitzer <snitzer@kernel.org>
    nfs/localio: fix regression due to out-of-order __put_cred

Peter Zijlstra <peterz@infradead.org>
    sched/fair: Proportional newidle balance

Peter Zijlstra <peterz@infradead.org>
    sched/fair: Small cleanup to update_newidle_cost()

Peter Zijlstra <peterz@infradead.org>
    sched/fair: Small cleanup to sched_balance_newidle()

Paolo Abeni <pabeni@redhat.com>
    mptcp: ensure context reset on disconnect()


-------------

Diffstat:

 Makefile                       |  4 +--
 fs/nfs/localio.c               | 12 ++++----
 include/linux/sched/topology.h |  3 ++
 kernel/sched/core.c            |  3 ++
 kernel/sched/fair.c            | 65 ++++++++++++++++++++++++++++++++++--------
 kernel/sched/features.h        |  5 ++++
 kernel/sched/sched.h           |  7 +++++
 kernel/sched/topology.c        |  6 ++++
 net/mptcp/protocol.c           |  8 ++++--
 net/mptcp/protocol.h           |  3 +-
 10 files changed, 92 insertions(+), 24 deletions(-)



