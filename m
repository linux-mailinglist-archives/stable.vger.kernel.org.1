Return-Path: <stable+bounces-152301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B80AD3B8F
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A45F16C7CD
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB9A1FAC34;
	Tue, 10 Jun 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAMlF+G7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8031F4E4F
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749566711; cv=none; b=agey2rcRJi9GeUS5M45+0eHAVQUwebjZ+xiCXrtJJA90Eni8FP0fubUS+TDVpyKXc+hX/cYnr6IvUgA+jVLRjidbfLY4D8cCWKGBSClEIjFd/NgsycJQLylxExtAxZHKCIZDm8UcxZ395S4sjtBvV7fPWvEwa6JSLYS9+HhXL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749566711; c=relaxed/simple;
	bh=i2hsA4/7HnZrsT/eZaeuHmZLBuYvjS6J375Y8bvyODU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lxt5WuslETVealYyyVkc+WenXy4MoOtGpAgSRtPIb/PVPb3ACPlDAE1VatAShaJRY9fbdoltPm73Pemv/xd3+9Yu23zM6Mxtn70YiqiXBkM6K6Xn+f2PxS4b6HdA2U4+miu9kT9QOMiI9TtYeWnIdy4Q9825+0rhTB5CUhzi+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAMlF+G7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07677C4CEF3;
	Tue, 10 Jun 2025 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749566711;
	bh=i2hsA4/7HnZrsT/eZaeuHmZLBuYvjS6J375Y8bvyODU=;
	h=From:To:Cc:Subject:Date:From;
	b=ZAMlF+G7BF3x0OIUfy9rNAi43TR6fnqxlpxdwrX5YAQl7MT7BxKnBi76S3c3bo5MD
	 3NL6RSmrky83lCR9iNqYqqXX+iYBbqZsZadvriKdvgvSemaqOoAdC2usuVgnBFx7B4
	 aJ4Arai3ow87CGD7RoT7Cnk0GSECIzAcAosLQ35UUUTpkyhl0qCu+TVKFV71rFPSFt
	 60XpU5MFsBMVcwjc1exM44hquDyrm17JJsTJtZRQfhMc6XP1zDKidxKM+iAG5z0kGO
	 Qe+0qyweadem5vNVrDnuUHhSm18dzeQQ/JRaKisoyoWCkwQAGJR2KR52TMBNQnBBAB
	 Um38+EHO4ALAQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	laura@labbott.name,
	stable@vger.kernel.org,
	Hao Luo <haoluo@google.com>,
	Puranjay Mohan <pjy@amazon.com>
Subject: [PATCH stable linux-5.10.y v1 0/8] Fix bpf mem read/write vulnerability.
Date: Tue, 10 Jun 2025 14:43:55 +0000
Message-ID: <20250610144407.95865-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Please cherry-pick this patch series into 5.10.y stable. It
includes a feature that fixes CVE-2022-0500 which allows a user with
cap_bpf privileges to get root privileges. The patch that fixes
the bug is

 patch 6/8: bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM

The rest are the depedences required by the fix patch.

This patchset has been merged in mainline v5.17 and backported to v5.16[1]
and v5.15[2]

Tested by compile, build and run through the bpf selftest test_progs.

Before:

./test_progs -t ksyms_btf/write_check
test_ksyms_btf:PASS:btf_exists 0 nsec
test_write_check:FAIL:skel_open unexpected load of a prog writing to ksym memory
#44/3 write_check:FAIL
#44 ksyms_btf:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 2 FAILED

After:

./test_progs -t ksyms_btf/write_check
#44/3 write_check:OK
#44 ksyms_btf:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

[1] https://lore.kernel.org/all/Yg6cixLJFoxDmp+I@kroah.com/
[2] https://lore.kernel.org/all/Ymupcl2JshcWjmMD@kroah.com/

Hao Luo (8):
  bpf: Introduce composable reg, ret and arg types.
  bpf: Replace ARG_XXX_OR_NULL with ARG_XXX | PTR_MAYBE_NULL
  bpf: Replace RET_XXX_OR_NULL with RET_XXX | PTR_MAYBE_NULL
  bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL
  bpf: Introduce MEM_RDONLY flag
  bpf: Make per_cpu_ptr return rdonly PTR_TO_MEM.
  bpf: Add MEM_RDONLY for helper args that are pointers to rdonly mem.
  bpf/selftests: Test PTR_TO_RDONLY_MEM

 include/linux/bpf.h                           |  98 +++-
 include/linux/bpf_verifier.h                  |  18 +
 kernel/bpf/btf.c                              |   8 +-
 kernel/bpf/cgroup.c                           |   2 +-
 kernel/bpf/helpers.c                          |  10 +-
 kernel/bpf/map_iter.c                         |   4 +-
 kernel/bpf/ringbuf.c                          |   2 +-
 kernel/bpf/verifier.c                         | 477 +++++++++---------
 kernel/trace/bpf_trace.c                      |  22 +-
 net/core/bpf_sk_storage.c                     |   2 +-
 net/core/filter.c                             |  62 +--
 net/core/sock_map.c                           |   2 +-
 .../selftests/bpf/prog_tests/ksyms_btf.c      |  14 +
 .../bpf/progs/test_ksyms_btf_write_check.c    |  29 ++
 14 files changed, 441 insertions(+), 309 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_btf_write_check.c

-- 
2.47.1


