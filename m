Return-Path: <stable+bounces-13408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EBCF837BF0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA628294A3C
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4301420BA;
	Tue, 23 Jan 2024 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YCaQaBBc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C1131748;
	Tue, 23 Jan 2024 00:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969445; cv=none; b=miYJRsploJTTUebJLCvyJvlFBbTN1iu7vLGKPY3PtBUbbiqv6lCpRMBnmA7fcVLN9JdMPy4evXQWBvd8qCpLgsUJUfauUxGWp/ZVgdqRKi3igNkI1Ell7N8EZya9IVH98QwlTluI0U1Ev+2O1Gram8WUFc/zxhgC5ecjnZW5zq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969445; c=relaxed/simple;
	bh=5q4uoYXOh8RS5jhWmZFtcLrVAkPNbEMRsOfPecRcwp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQBYZUSTiqW6VcbWHXVTbtX6XHCf8MonwiRNLNxGPFeFhhzhkzJMbbsLCtuyAiv81fvUt6OKCj3wBkTJQEuDH0+Ul+xSfgjdlYFbhjl4DdKOmCkk7rlDx2MLghfTBBxOBlH/Us1t3NnhAA1w8FUdkQhgx+ZbTovPWQGbYUbPeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YCaQaBBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FC0C43390;
	Tue, 23 Jan 2024 00:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969445;
	bh=5q4uoYXOh8RS5jhWmZFtcLrVAkPNbEMRsOfPecRcwp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCaQaBBc+BV6dPach1/uqKd2b+i1mNAMO1jM9OcodFfqezNQFBjn5FvVPR9/NYaJV
	 wOvx/GOLv3T6kNvYXGPZmqTv8uqV8uqdFLjhHuqNQg38RMtqq2EQLjAfHqeXMSZMbP
	 F0EMEANMuMkr4tgLkeNM3WWPjanmAIcAvmoFrymQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abhinav Singh <singhabhinav9051571833@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 251/641] drm/nouveau/fence:: fix warning directly dereferencing a rcu pointer
Date: Mon, 22 Jan 2024 15:52:35 -0800
Message-ID: <20240122235825.777335497@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

From: Abhinav Singh <singhabhinav9051571833@gmail.com>

[ Upstream commit 5f35a624c1e30b5bae5023b3c256e94e0ad4f806 ]

Fix a sparse warning with this message
"warning:dereference of noderef expression". In this context it means we
are dereferencing a __rcu tagged pointer directly.

We should not be directly dereferencing a rcu pointer. To get a normal
(non __rcu tagged pointer) from a __rcu tagged pointer we are using the
function unrcu_pointer(...). The non __rcu tagged pointer then can be
dereferenced just like a normal pointer.

I tested with qemu with this command
qemu-system-x86_64 \
	-m 2G \
	-smp 2 \
	-kernel bzImage \
	-append "console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
	-drive file=bullseye.img,format=raw \
	-net user,host=10.0.2.10,hostfwd=tcp:127.0.0.1:10021-:22 \
	-net nic,model=e1000 \
	-enable-kvm \
	-nographic \
	-pidfile vm.pid \
	2>&1 | tee vm.log
with lockdep enabled.

Fixes: 0ec5f02f0e2c ("drm/nouveau: prevent stale fence->channel pointers, and protect with rcu")
Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231113191303.3277733-1-singhabhinav9051571833@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nv04_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nv04_fence.c b/drivers/gpu/drm/nouveau/nv04_fence.c
index 5b71a5a5cd85..cdbc75e3d1f6 100644
--- a/drivers/gpu/drm/nouveau/nv04_fence.c
+++ b/drivers/gpu/drm/nouveau/nv04_fence.c
@@ -39,7 +39,7 @@ struct nv04_fence_priv {
 static int
 nv04_fence_emit(struct nouveau_fence *fence)
 {
-	struct nvif_push *push = fence->channel->chan.push;
+	struct nvif_push *push = unrcu_pointer(fence->channel)->chan.push;
 	int ret = PUSH_WAIT(push, 2);
 	if (ret == 0) {
 		PUSH_NVSQ(push, NV_SW, 0x0150, fence->base.seqno);
-- 
2.43.0




