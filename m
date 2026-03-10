Return-Path: <stable+bounces-223907-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA8fLOL8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223907-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC0124A26B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40CDF308625B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D35D386C39;
	Tue, 10 Mar 2026 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNz1zTID"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5102638236A;
	Tue, 10 Mar 2026 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140805; cv=none; b=rQE2c3X+0knSMP7EA5T1187FhGX9o0DTcQ7tiE7aJ5/pRsrYa2cjrG2MZt9Hvv55jKSUytSoqs4Pkr0598dKYOh1pblnEo0TY5+5lLkEgmxWEa6cFGZolhCxHrbz5vW0twAYZ1sZxEyR5j61RDVI93qotJzQzEUJt+XNeJ4cL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140805; c=relaxed/simple;
	bh=i7NaneQMGNDRud6nUu1gqlYJnpZIpWfCaEfzm9tBAss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEAzZiQw7QrV9JDN3iOwjTXpAdWxYb76jfsLNmQ7AdHPZVPL88c0jxD2ib7on29WNkZFd28GB8Bx/hQh8oKNYDqjh7qnyUt/lpeHu5Psq2d49SPI7z0lsadwiYywohExOaueGPmUUTxVwNpcw3JdvqWA4ipXLwoS4OxtNJ1VQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNz1zTID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E87C2BC86;
	Tue, 10 Mar 2026 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140805;
	bh=i7NaneQMGNDRud6nUu1gqlYJnpZIpWfCaEfzm9tBAss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNz1zTIDJ5zcPnfSGyuggZpKouR/kZ0hixg5v61SHDm8700jG/nLK7qKym5LiCZxM
	 igJ/8T4asj+To6ZRMezq6zalBxrZ0HMLuHJQGs8MXsAN/47beMVeJ2kVpBJT52Gg62
	 2sATjNlP0uYdt8muncQx3DgVWkifK5NfykyeqVAoXEvXruYLem52btiu3hvr3ET5I6
	 XSSvUAET9iE4CqLwBxHkvh80srOqZj26wb6LYK7AA1VSwitIH9Km60i/dXlQ6b5g1+
	 zfcahSAqaFXwM9YbrGbAIzQ50Euok8UkmQkTbSbPXGM0a2wGWr28/l44utmZlKmGCV
	 ylLv1btgOFDGw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 043/311] cgroup/cpuset: Fix incorrect change to effective_xcpus in partition_xcpus_del()
Date: Tue, 10 Mar 2026 07:01:30 -0400
Message-ID: <eae4019f2488934b90307699e7136810c87cca18.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1CC0124A26B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223907-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Waiman Long <longman@redhat.com>

[ Upstream commit f9a1767ce3a34bc33c3d33473f65dc13a380e379 ]

The effective_xcpus of a cpuset can contain offline CPUs. In
partition_xcpus_del(), the xcpus parameter is incorrectly used as
a temporary cpumask to mask out offline CPUs. As xcpus can be the
effective_xcpus of a cpuset, this can result in unexpected changes
in that cpumask. Fix this problem by not making any changes to the
xcpus parameter.

Fixes: 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in isolated partitions")
Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 62e1807b23448..aaef221a1434c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1401,8 +1401,8 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
 		isolated_cpus_update(old_prs, parent->partition_root_state,
 				     xcpus);
 
-	cpumask_and(xcpus, xcpus, cpu_active_mask);
 	cpumask_or(parent->effective_cpus, parent->effective_cpus, xcpus);
+	cpumask_and(parent->effective_cpus, parent->effective_cpus, cpu_active_mask);
 }
 
 /*
-- 
2.51.0


