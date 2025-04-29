Return-Path: <stable+bounces-138127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB72AA166F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6CB07B2D35
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004A250C15;
	Tue, 29 Apr 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MQD5WEsL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697481C6B4;
	Tue, 29 Apr 2025 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948242; cv=none; b=nUAGnfsTJ5xndfWCdHpjt18lrSlWYLrwhZc0anNnLUHgcHUmJuNogkiJ3b/KxEZG7rxNvRzsVJ4Y4v5ELg6OMfZnzD3EY/sIrjW5WGdgHPuH48XuPiR/iQEsjZFoTRU9pL10fdR1tvEauMkDukkcGx6V5amQ9g8oko0fb5+TMZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948242; c=relaxed/simple;
	bh=wZjTnaDIC82VNt2J106oe4kBt8sF0m4Tgs14MQtN12Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6oGSaBiEdsa7GlYf4JUI6GiN38/Nxc18KtU3EoB64ErJmJs2wz3bsEtkjiS5K7i0b5oatjwUNv8viekkD2iTjboP8sAxXW2YkY3JnS5wFAFY/CKIKJ7sZuyMQH/WiVrOoipi4Mn9CX7zK6X0I+88tGFvmDxKyxTUM2AvZKczDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MQD5WEsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAF4C4CEE3;
	Tue, 29 Apr 2025 17:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948242;
	bh=wZjTnaDIC82VNt2J106oe4kBt8sF0m4Tgs14MQtN12Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MQD5WEsL35mZ0aOZUOjBsTNTa3aigYci0/6YKb+EuwosczPqukGd08LH+v8ZV2bNC
	 uKojBcRwa+sTdYmETykBDWVtquhDqeMqFHxlSR2facegHcFO1MZ4+9FZfO94t7aFx4
	 qx+tdUGS1GM9v21WoFuJbGtdLWfqgmfdSQ/HWCQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 203/280] cgroup/cpuset: Dont allow creation of local partition over a remote one
Date: Tue, 29 Apr 2025 18:42:24 +0200
Message-ID: <20250429161123.438565674@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161115.008747050@linuxfoundation.org>
References: <20250429161115.008747050@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

[ Upstream commit 6da580ec656a5ed135db2cdf574b47635611a4d7 ]

Currently, we don't allow the creation of a remote partition underneath
another local or remote partition. However, it is currently possible to
create a new local partition with an existing remote partition underneath
it if top_cpuset is the parent. However, the current cpuset code does
not set the effective exclusive CPUs correctly to account for those
that are taken by the remote partition.

Changing the code to properly account for those remote partition CPUs
under all possible circumstances can be complex. It is much easier to
not allow such a configuration which is not that useful. So forbid
that by making sure that exclusive_cpus mask doesn't overlap with
subpartitions_cpus and invalidate the partition if that happens.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 976a8bc3ff603..383963e28ac69 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -33,6 +33,7 @@ enum prs_errcode {
 	PERR_CPUSEMPTY,
 	PERR_HKEEPING,
 	PERR_ACCESS,
+	PERR_REMOTE,
 };
 
 /* bits in struct cpuset flags field */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 839f88ba17f7d..c709a05023cd9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -62,6 +62,7 @@ static const char * const perr_strings[] = {
 	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
 	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
 	[PERR_ACCESS]    = "Enable partition not permitted",
+	[PERR_REMOTE]    = "Have remote partition underneath",
 };
 
 /*
@@ -2824,6 +2825,19 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			goto out;
 		}
 
+		/*
+		 * We don't support the creation of a new local partition with
+		 * a remote partition underneath it. This unsupported
+		 * setting can happen only if parent is the top_cpuset because
+		 * a remote partition cannot be created underneath an existing
+		 * local or remote partition.
+		 */
+		if ((parent == &top_cpuset) &&
+		    cpumask_intersects(cs->exclusive_cpus, subpartitions_cpus)) {
+			err = PERR_REMOTE;
+			goto out;
+		}
+
 		/*
 		 * If parent is valid partition, enable local partiion.
 		 * Otherwise, enable a remote partition.
-- 
2.39.5




