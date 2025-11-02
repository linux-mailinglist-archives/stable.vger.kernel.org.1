Return-Path: <stable+bounces-192062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC59C29079
	for <lists+stable@lfdr.de>; Sun, 02 Nov 2025 15:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC4714E041E
	for <lists+stable@lfdr.de>; Sun,  2 Nov 2025 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B31684B0;
	Sun,  2 Nov 2025 14:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkyxJ27o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288B3FBA7
	for <stable@vger.kernel.org>; Sun,  2 Nov 2025 14:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762094661; cv=none; b=VllAkT+NSewAGnZ1Y+wuhFfb1JzrunngHYY07yS8gxKXDaUfZ6MoUCa7W+Himt+44A6rv4wvhAw4lgUQ2XDc1gXlSAMcVeyB5M8r6gg6MWQ0CU4G5w6ObvQIcihOw9n0JjpFyyL+F2t26Hye7AA32IocW1QypWla7Avly1kDhCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762094661; c=relaxed/simple;
	bh=0RlwnpqB+Fz9axEfnkqY4HO6FS/C1FMqPRBvuplNs9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/iQz66+3pmivERbyjG3S+YGAY3Oqsk7K7YjPQnVzG2KRLyOgQCo9iiWxfez0GKZcA3IqkQgz5KS1+dBvd+iwtIAU7LtJNc+zuchnXnozFhTyMgMeqf29yvkKZb/ou/XTFbDbMa8E/5q25aGcB89hqKDsWRenZYCwPXwc0LQKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkyxJ27o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F36C4CEF7;
	Sun,  2 Nov 2025 14:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762094660;
	bh=0RlwnpqB+Fz9axEfnkqY4HO6FS/C1FMqPRBvuplNs9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pkyxJ27oZ0pUq/cJtLiUbAa/6jIlRm21nScri5vxZRHLkljIKSFDnLKDp5qkbT1Nq
	 GVL2vC4EL24Y+ms+kH+A68XvuVswZDJojil5msieozMjxzQGTUJaJGqrkGZWuu2DtV
	 uAOEg2b6PHgsgXaGAfN0kXGwNoooiJnE5WYCeJfTEHGSCU5LccalmeF9ab3o0rNtA0
	 7kwd3NbIDhJM6xfPaW9RDyv+hQ6W2eOjWN19gjiSeVFVhTKkI+aomr5DMJU/YcQJyn
	 su8jWlVTMgXsHn+UBTj/mNg69DbANPq5iC8AhxEm6DnZn5DZE7rrGDiNG8+BCpswmx
	 UFg2QWHAyDYrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] sched_ext: Mark scx_bpf_dsq_move_set_[slice|vtime]() with KF_RCU
Date: Sun,  2 Nov 2025 09:44:17 -0500
Message-ID: <20251102144417.3456382-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025110231-exposable-prelude-6f67@gregkh>
References: <2025110231-exposable-prelude-6f67@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit 54e96258a6930909b690fd7e8889749231ba8085 ]

scx_bpf_dsq_move_set_slice() and scx_bpf_dsq_move_set_vtime() take a DSQ
iterator argument which has to be valid. Mark them with KF_RCU.

Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
Cc: stable@vger.kernel.org # v6.12+
Acked-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ scx_bpf_dsq_move_set_* => scx_bpf_dispatch_from_dsq_set_* ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 563a7dc2ece6f..be2e836e10e93 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6493,8 +6493,8 @@ BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
 BTF_ID_FLAGS(func, scx_bpf_consume)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
@@ -6593,8 +6593,8 @@ __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_unlocked)
 BTF_ID_FLAGS(func, scx_bpf_create_dsq, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice)
-BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_slice, KF_RCU)
+BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
-- 
2.51.0


