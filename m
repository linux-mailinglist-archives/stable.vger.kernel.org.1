Return-Path: <stable+bounces-133224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93531A924B4
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AB03BB393
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF3D263F23;
	Thu, 17 Apr 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dw4y10Om"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB50263C7F;
	Thu, 17 Apr 2025 17:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912434; cv=none; b=RIEDGVB1wP0mYnfECH5QeNtf+xg1yIJ+Es9OKipM2W32vgvwLq9mTPupQeSfInKr+v6wQ8VCgyNj8dXzmhBmDd7W258j3u5jnqs+j26UVnlI2EYiOPArld3F9X/do0WMmPWjYmVNGsUJxSLMv61C4dPXijjjsSaLPuKRSnlMlgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912434; c=relaxed/simple;
	bh=ve/9xcL3ZwwitPFVgN+ZlU6KSCX0Rw8oscqm/8jpZW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3nYfhueZ+JV1eAadCxf5rY0AkN2/ke11fdZAlddsgg8oCDm1prgYW3Qk8Av+8/4M32foqE8nzeN2JwBfOkPHVh9/ZZawTNP6ASwzz3Cy9Ny+ct1ztRO0rdSTi7pnD01DsQMn5TcoQD8BMrEfYZRejbszqobuYx/CoPOBcoHRy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dw4y10Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78ACCC4CEEA;
	Thu, 17 Apr 2025 17:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912433;
	bh=ve/9xcL3ZwwitPFVgN+ZlU6KSCX0Rw8oscqm/8jpZW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dw4y10Om1o86/gWegG/w3+Knly0UUmzdFjGo8WhNWP9/d7PUN+9SHTvxCnYRqh1oJ
	 1CCl8otCtaDa245Jp/frLwyj+R1MSUJnZearSwnK5cM6OUFbqvZi9s0JaReZpz/Se3
	 7z0l34LTgjfsbX4Ut8sW7HAmYfomC9Fy+ZJgDIoQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 002/449] cgroup/cpuset: Fix incorrect isolated_cpus update in update_parent_effective_cpumask()
Date: Thu, 17 Apr 2025 19:44:50 +0200
Message-ID: <20250417175118.079987470@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit 668e041662e92ab3ebcb9eb606d3ec01884546ab ]

Before commit f0af1bfc27b5 ("cgroup/cpuset: Relax constraints to
partition & cpus changes"), a cpuset partition cannot be enabled if not
all the requested CPUs can be granted from the parent cpuset. After
that commit, a cpuset partition can be created even if the requested
exclusive CPUs contain CPUs not allowed its parent.  The delmask
containing exclusive CPUs to be removed from its parent wasn't
adjusted accordingly.

That is not a problem until the introduction of a new isolated_cpus
mask in commit 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in
isolated partitions") as the CPUs in the delmask may be added directly
into isolated_cpus.

As a result, isolated_cpus may incorrectly contain CPUs that are not
isolated leading to incorrect data reporting. Fix this by adjusting
the delmask to reflect the actual exclusive CPUs for the creation of
the partition.

Fixes: 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in isolated partitions")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1892dc8cd2119..0a7ec0f1ce4e7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1689,9 +1689,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (nocpu)
 			return PERR_NOCPUS;
 
-		cpumask_copy(tmp->delmask, xcpus);
-		deleting = true;
-		subparts_delta++;
+		deleting = cpumask_and(tmp->delmask, xcpus, parent->effective_xcpus);
+		if (deleting)
+			subparts_delta++;
 		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 	} else if (cmd == partcmd_disable) {
 		/*
-- 
2.39.5




