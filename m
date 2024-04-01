Return-Path: <stable+bounces-34596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEEF893FFE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C41C212BC
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83BC45BE4;
	Mon,  1 Apr 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ldhfmuqu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756F2C129;
	Mon,  1 Apr 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711988651; cv=none; b=Xp07+5DPm7in0a6UwBuq9Yo7UIwiEX31f0JjyUAuQIe79iMfVSoJfL30KGjyJJUc2yU4w4I9TxJnfi2HY1Xffl6cuWZCaqVuLf1jDE2KvVo6SKsjQ7N3CIJ/ojgtNpV1a/kQp1EwTZVtVQNeef48NiPwDYsrnIDT1eoduPhLHQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711988651; c=relaxed/simple;
	bh=DAXdInYhAGpdm9L1MmQy5g3xuO6aPyMUYi4cbjaSxzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTjWbwzbSruq8zvxglQomB4Ru9mhrGErSC1kZhAc5uLPtRlPzR61QCpV8JN++649SgS/i6r1Ljx7uiXNEyUXeq3BnGCrWrK3K3Uyz3f5170cuR3T3jrW9EbXUlEuhZzv0KrpJjkX1HBfJrpo5zmBsBnEgkuWDzBmNjlq4Y0uhEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ldhfmuqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82CAC43390;
	Mon,  1 Apr 2024 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711988651;
	bh=DAXdInYhAGpdm9L1MmQy5g3xuO6aPyMUYi4cbjaSxzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdhfmuquTOKVCjLweDfqa+DN0Mh4kAny3UVrdQzKMbhC8t3JfNlq6ISFLhE6kfOTT
	 XipwQbwEB8Pt1ACg4VpHqTvfJHNB20v85FyJ58ukn+vM2hIBvuZ9xmYbyFJUWBBGiN
	 Ca4FnETiIlLnpaER4uGi928x72PAfW2MWQ8zxYN8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.7 248/432] cgroup/cpuset: Fix retval in update_cpumask()
Date: Mon,  1 Apr 2024 17:43:55 +0200
Message-ID: <20240401152600.536315722@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kamalesh Babulal <kamalesh.babulal@oracle.com>

commit 25125a4762835d62ba1e540c1351d447fc1f6c7c upstream.

The update_cpumask(), checks for newly requested cpumask by calling
validate_change(), which returns an error on passing an invalid set
of cpu(s). Independent of the error returned, update_cpumask() always
returns zero, suppressing the error and returning success to the user
on writing an invalid cpu range for a cpuset. Fix it by returning
retval instead, which is returned by validate_change().

Fixes: 99fe36ba6fc1 ("cgroup/cpuset: Improve temporary cpumasks handling")
Signed-off-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/cpuset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2466,7 +2466,7 @@ static int update_cpumask(struct cpuset
 		update_partition_sd_lb(cs, old_prs);
 out_free:
 	free_cpumasks(NULL, &tmp);
-	return 0;
+	return retval;
 }
 
 /**



