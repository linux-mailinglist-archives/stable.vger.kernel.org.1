Return-Path: <stable+bounces-152270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D3DAD33CA
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 12:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D321A189788F
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59128C2C9;
	Tue, 10 Jun 2025 10:37:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E52221D59F;
	Tue, 10 Jun 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551855; cv=none; b=Xw9H4sQwPCOAi4bOTgghXjUAmJLSTuVJeXjwpeGVLgTNWPEZhu4HR/Yi0/kzonljQYGD+8yEHgXz+s7E5rXtK1lYIO0x0+OV0RkiUdj7Gu1tj7sRKnFrkvVhTZ+clYTff5iudCmJx+hpkFAmI5W6fWWYugcYHveE0xiOGj4J7LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551855; c=relaxed/simple;
	bh=L2xbVLQlsBf/xieCX2SEZx2rt1ajw+J8rd/rO3kjmwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jS8DCCkxfT15D0pCMRk6FlBK7Nie64fQBsqFrGozJACeE5gFH1/k3/QN6d6d0kX4DZy3E32yQGt+QmI2qKWTqoRD2z2q6tpunZD8IYCChNwh2XO37xbYDFeLqwm2OyB6fch+C/ycocbXB1DKyNq13z8waJm6qh/ysP9Z1BbDSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6486C14BF;
	Tue, 10 Jun 2025 03:37:13 -0700 (PDT)
Received: from usa.arm.com (unknown [10.57.49.127])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 031EB3F673;
	Tue, 10 Jun 2025 03:37:29 -0700 (PDT)
From: Aishwarya <aishwarya.tcv@arm.com>
To: pulehui@huaweicloud.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	jannh@google.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	pulehui@huawei.com,
	stable@vger.kernel.org,
	vbabka@suse.cz,
	broonie@kernel.org,
	Ryan.Roberts@arm.com,
	Dev.Jain@arm.com
Subject: Re: [PATCH v1 4/4] selftests/mm: Add test about uprobe pte be orphan during vma merge
Date: Tue, 10 Jun 2025 11:37:29 +0100
Message-Id: <20250610103729.72440-1-aishwarya.tcv@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250529155650.4017699-5-pulehui@huaweicloud.com>
References: <20250529155650.4017699-5-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

kselftest-mm test 'merge.handle_uprobe_upon_merged_vma' is failing
against mainline master v6.16-rc1 with Arm64 on Ampere Altra/TX2 in our
CI. The kernel was built using defconfig along with the additional
config fragment from:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/mm/config

I understand the failure is already being discussed and is expected to be
addressed by including sys/syscall.h.Sharing this observation here 
for reference.

A bisect identified commit efe99fabeb11b030c89a7dc5a5e7a7558d0dc7ec as the
first bad commit. This was bisected against tag v6.16-rc1 from:

  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

This test passes on Linux version v6.15-13627-g119b1e61a769.

Failure log:

  7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
  7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
  7153 12:46:54.639306  # # fopen: No such file or directory
  7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
  7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
  7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
  7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma

Git bisection log:

git bisect start
# status: waiting for both good and bad commits
# good: [119b1e61a769aa98e68599f44721661a4d8c55f3] Merge tag 'riscv-for-linus-6.16-mw1' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect good 119b1e61a769aa98e68599f44721661a4d8c55f3
# status: waiting for bad commit, 1 good commit known
# bad: [19272b37aa4f83ca52bdf9c16d5d81bdd1354494] Linux 6.16-rc1
git bisect bad 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
# bad: [b3154a6ff1f53b794c01096577700f35b1be9cc2] Merge tag 'sh-for-v6.16-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux
git bisect bad b3154a6ff1f53b794c01096577700f35b1be9cc2
# bad: [5b032cac622533631b8f9b7826498b7ce75001c6] Merge tag 'ubifs-for-linus-6.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
git bisect bad 5b032cac622533631b8f9b7826498b7ce75001c6
# good: [2da20fd904f87f7bb31b79719bc3dda4093f8cdb] kernel/rcu/tree_stall: add /sys/kernel/rcu_stall_count
git bisect good 2da20fd904f87f7bb31b79719bc3dda4093f8cdb
# good: [d3c82f618a9c2b764b7651afe16594ffeb50ade9] Merge tag 'mm-hotfixes-stable-2025-06-06-16-02' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect good d3c82f618a9c2b764b7651afe16594ffeb50ade9
# bad: [efe99fabeb11b030c89a7dc5a5e7a7558d0dc7ec] selftests/mm: add test about uprobe pte be orphan during vma merge
git bisect bad efe99fabeb11b030c89a7dc5a5e7a7558d0dc7ec
# good: [2b12d06c37fd3a394376f42f026a7478d826ed63] mm: fix uprobe pte be overwritten when expanding vma
git bisect good 2b12d06c37fd3a394376f42f026a7478d826ed63
# good: [6fb6223347d5d9512875120267c117e7437f0db6] selftests/mm: extract read_sysfs and write_sysfs into vm_util
git bisect good 6fb6223347d5d9512875120267c117e7437f0db6
# first bad commit: [efe99fabeb11b030c89a7dc5a5e7a7558d0dc7ec] selftests/mm: add test about uprobe pte be orphan during vma merge

Thanks,
Aishwarya

