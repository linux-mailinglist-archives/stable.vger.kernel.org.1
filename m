Return-Path: <stable+bounces-51861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2681D9071F7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE5F2809C9
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E39143747;
	Thu, 13 Jun 2024 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sBDqoexV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69AF2CA6;
	Thu, 13 Jun 2024 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282530; cv=none; b=VS0OwPqF5XXPDy/JHI/JlK2ep3cb2gWKnduJKt1BXq+e1rTD6WQSYkA91RuJg2pVWFfWBDPauGdLkqDrvj7JX1+84AZdPTKz1I4SOR68KMm8JQCADWeRc/w1QGt5+KFnFNEQByKLc72brFX3401FX+E9Hda018FD3PnCnObGhqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282530; c=relaxed/simple;
	bh=NujHx8AGi+7i7mAf6gSOaXxqdQ1xZ2sI/SnlBJ19J8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4b4DtsQQZ5JQFwxZwPtvou7JwJRdOtLUCYy5AmzyVOg/9twwJ/HRTs/q3IQ8xg8cKavTzsf8Bdu0PtExTVMG5Yef+oGS0xIX7fBb/UvW+3EunITRMMF4NbwisASuVbAxzfYzZ7LJ1qFh3meuCoWTjc4GyP1G9REQ3enZCYcpcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sBDqoexV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D198C32786;
	Thu, 13 Jun 2024 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718282530;
	bh=NujHx8AGi+7i7mAf6gSOaXxqdQ1xZ2sI/SnlBJ19J8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBDqoexV2pXrcwiyKANoVR0C/GA9DbL2gydhRBxPmD0MGnA0aosHfNhbIPDIU1U7q
	 E9xjw09zE/Lv99nGgKJVTFEy4PKXEFib47MIoXU+bU2Zm/1P/FkduGL94JoejsRrle
	 cbIRKPxxEEXJ3C/j+T3LQV16mRpak+S5cmxo4gWo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Barry Song <baohua@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 308/402] dma-mapping: benchmark: handle NUMA_NO_NODE correctly
Date: Thu, 13 Jun 2024 13:34:25 +0200
Message-ID: <20240613113314.156504182@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit e64746e74f717961250a155e14c156616fcd981f ]

cpumask_of_node() can be called for NUMA_NO_NODE inside do_map_benchmark()
resulting in the following sanitizer report:

UBSAN: array-index-out-of-bounds in ./arch/x86/include/asm/topology.h:72:28
index -1 is out of range for type 'cpumask [64][1]'
CPU: 1 PID: 990 Comm: dma_map_benchma Not tainted 6.9.0-rc6 #29
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
 <TASK>
dump_stack_lvl (lib/dump_stack.c:117)
ubsan_epilogue (lib/ubsan.c:232)
__ubsan_handle_out_of_bounds (lib/ubsan.c:429)
cpumask_of_node (arch/x86/include/asm/topology.h:72) [inline]
do_map_benchmark (kernel/dma/map_benchmark.c:104)
map_benchmark_ioctl (kernel/dma/map_benchmark.c:246)
full_proxy_unlocked_ioctl (fs/debugfs/file.c:333)
__x64_sys_ioctl (fs/ioctl.c:890)
do_syscall_64 (arch/x86/entry/common.c:83)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

Use cpumask_of_node() in place when binding a kernel thread to a cpuset
of a particular node.

Note that the provided node id is checked inside map_benchmark_ioctl().
It's just a NUMA_NO_NODE case which is not handled properly later.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DMA APIs")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Acked-by: Barry Song <baohua@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/map_benchmark.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 130feaa8de7fc..b7f8bb7a1e5c5 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -124,7 +124,6 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	struct task_struct **tsk;
 	int threads = map->bparam.threads;
 	int node = map->bparam.node;
-	const cpumask_t *cpu_mask = cpumask_of_node(node);
 	u64 loops;
 	int ret = 0;
 	int i;
@@ -145,7 +144,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 		}
 
 		if (node != NUMA_NO_NODE)
-			kthread_bind_mask(tsk[i], cpu_mask);
+			kthread_bind_mask(tsk[i], cpumask_of_node(node));
 	}
 
 	/* clear the old value in the previous benchmark */
-- 
2.43.0




