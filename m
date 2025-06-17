Return-Path: <stable+bounces-153365-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3BFADD425
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D2E3AE06B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F22EA146;
	Tue, 17 Jun 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YXHVs6gX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CBD2EA164;
	Tue, 17 Jun 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175715; cv=none; b=Qsh+6c7Dri4MVZgBP9n6+q1ESAKcWgbz/M2HpB0eKLBSIkpGgvBDGFihGb+JzmStgEO8THUmoYecU9C06PDGg7DA7rV3Rfm1f/19oTqTMzbgKmBvar7dJNDETcvoNtYtzVj94Vw/vS6MmRTSl3rq1OFfaET7DVhZ/ph4fcdp2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175715; c=relaxed/simple;
	bh=QS3WWtsOWzB7j1aB6vaLLhaFVzfCUBnxDdEvW9a5dWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6Pi5232EJ2jZhvQpyNGemLbo/bL4hpC9rkWN2bFxWcwemJsKWtRsNwW+1wnb4yXRp1DbFr+KSdbIbGXimVUs3ObHEWVynXtJcaQ0DkIcRBI7xoGkf42VBf0uE+MuvIoItSf7CxCcOpBL5PaV5jvBGZ1RzA14vT7rLga2FLGDj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YXHVs6gX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C6DC4CEE3;
	Tue, 17 Jun 2025 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175715;
	bh=QS3WWtsOWzB7j1aB6vaLLhaFVzfCUBnxDdEvW9a5dWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXHVs6gX0s6Wbk9orTZhr6PwK3EINAWqe3G4TvezPyvEX46NF9Kf+W1rhXQlHV92g
	 YrYtP4IPq+6PzFcrQkGUM4vKQsSRg1z39tI1n8kwRBo+tRhBFkM5dUjsWmYim3xlNc
	 PKtfxRugf8mkAX1BqXFfhrIO740THk+WRy61trUw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sagarika Sharma <sharmasagarika@google.com>,
	Minh-Anh Nguyen <minhanhdn@google.com>,
	YiFei Zhu <zhuyifei@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 156/512] bpftool: Fix regression of "bpftool cgroup tree" EINVAL on older kernels
Date: Tue, 17 Jun 2025 17:22:02 +0200
Message-ID: <20250617152425.929259868@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152419.512865572@linuxfoundation.org>
References: <20250617152419.512865572@linuxfoundation.org>
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

From: YiFei Zhu <zhuyifei@google.com>

[ Upstream commit 43745d11bfd9683abdf08ad7a5cc403d6a9ffd15 ]

If cgroup_has_attached_progs queries an attach type not supported
by the running kernel, due to the kernel being older than the bpftool
build, it would encounter an -EINVAL from BPF_PROG_QUERY syscall.

Prior to commit 98b303c9bf05 ("bpftool: Query only cgroup-related
attach types"), this EINVAL would be ignored by the function, allowing
the function to only consider supported attach types. The commit
changed so that, instead of querying all attach types, only attach
types from the array `cgroup_attach_types` is queried. The assumption
is that because these are only cgroup attach types, they should all
be supported. Unfortunately this assumption may be false when the
kernel is older than the bpftool build, where the attach types queried
by bpftool is not yet implemented in the kernel. This would result in
errors such as:

  $ bpftool cgroup tree
  CgroupPath
  ID       AttachType      AttachFlags     Name
  Error: can't query bpf programs attached to /sys/fs/cgroup: Invalid argument

This patch restores the logic of ignoring EINVAL from prior to that patch.

Fixes: 98b303c9bf05 ("bpftool: Query only cgroup-related attach types")
Reported-by: Sagarika Sharma <sharmasagarika@google.com>
Reported-by: Minh-Anh Nguyen <minhanhdn@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Quentin Monnet <qmo@kernel.org>
Link: https://lore.kernel.org/bpf/20250428211536.1651456-1-zhuyifei@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 9af426d432993..afab728468bf6 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -221,7 +221,7 @@ static int cgroup_has_attached_progs(int cgroup_fd)
 	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
 		int count = count_attached_bpf_progs(cgroup_fd, cgroup_attach_types[i]);
 
-		if (count < 0)
+		if (count < 0 && errno != EINVAL)
 			return -1;
 
 		if (count > 0) {
-- 
2.39.5




