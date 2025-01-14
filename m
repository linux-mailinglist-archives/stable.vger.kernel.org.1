Return-Path: <stable+bounces-108563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA2A0FDF6
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 02:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09453A2C26
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 01:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33E7224B19;
	Tue, 14 Jan 2025 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BmUkj0sn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416E43DBB6;
	Tue, 14 Jan 2025 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736817668; cv=none; b=Nf0y/vaCwki3PRJazeLipFVAyaOjssql0h+FY/skC1TfLUdyJz+5cC0LKG86lArE28kC0Y9Y8sFphfBkQKV4wllsGXzoklxXNCs4QvssVVWrshaN33F1wbrvCLueYEDBKuqlcyNT2tcc1FEi550Ifqm4X3Obc9giEAoWaQbdga0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736817668; c=relaxed/simple;
	bh=1Sb1aL3in7jEzyyYwUIcVPKkolwxf6qxYAybRHjmvGI=;
	h=Date:To:From:Subject:Message-Id; b=ee0PsYLAQqW0IBBgE5ej1on6fblRdBfTgW0QSbLT9TkcPYAbiLOx/o7umLJuaO2YnQviQB/X4jNkEwYdJzM0REDI5uhoemY3bk8oS3b3sCbaODwQwP214aaMULzhJaOrizTzlauV+Oh8uA+QqDOBPcBQR0C22Gw5hRnUbARnA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BmUkj0sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9818C4CEE2;
	Tue, 14 Jan 2025 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1736817667;
	bh=1Sb1aL3in7jEzyyYwUIcVPKkolwxf6qxYAybRHjmvGI=;
	h=Date:To:From:Subject:From;
	b=BmUkj0snM09C+4R5qq5D8yTiLD/0o4tDD+xyVbF10evKB2oxvCPgvLe01ZQ72jeyt
	 83ma0JXoTtRxgQRgrmG+Oxnx6I/tIrokhdtmw4q6BtIa4UZfm5/LVaHTxSNW3RvFTq
	 CSSqk0QtylOGRDVD4aIwksi+u6yGy/O6Dbtnsk7k=
Date: Mon, 13 Jan 2025 17:21:07 -0800
To: mm-commits@vger.kernel.org,tglx@linutronix.de,stable@vger.kernel.org,shuah@kernel.org,oliver.sang@intel.com,dev.jain@arm.com,thomas.weissschuh@linutronix.de,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [to-be-updated] selftests-mm-virtual_address_range-avoid-reading-vvar-mappings.patch removed from -mm tree
Message-Id: <20250114012107.B9818C4CEE2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: selftests/mm: virtual_address_range: avoid reading VVAR mappings
has been removed from the -mm tree.  Its filename was
     selftests-mm-virtual_address_range-avoid-reading-vvar-mappings.patch

This patch was dropped because an updated version will be issued

------------------------------------------------------
From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Subject: selftests/mm: virtual_address_range: avoid reading VVAR mappings
Date: Tue, 07 Jan 2025 16:14:46 +0100

The virtual_address_range selftest reads from the start of each mapping
listed in /proc/self/maps.

However not all mappings are valid to be arbitrarily accessed.  For
example the vvar data used for virtual clocks on x86 can only be accessed
if 1) the kernel configuration enables virtual clocks and 2) the
hypervisor provided the data for it, which can only determined by the VDSO
code itself.

Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into
dedicated mapping") the virtual clock data was split out into its own
mapping, triggering faulting accesses by virtual_address_range.

Skip the various vvar mappings in virtual_address_range to avoid errors.

Link: https://lkml.kernel.org/r/20250107-virtual_address_range-tests-v1-2-3834a2fb47fe@linutronix.de
Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
Cc: Dev Jain <dev.jain@arm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/virtual_address_range.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/mm/virtual_address_range.c~selftests-mm-virtual_address_range-avoid-reading-vvar-mappings
+++ a/tools/testing/selftests/mm/virtual_address_range.c
@@ -116,10 +116,11 @@ static int validate_complete_va_space(vo
 
 	prev_end_addr = 0;
 	while (fgets(line, sizeof(line), file)) {
+		int path_offset = 0;
 		unsigned long hop;
 
-		if (sscanf(line, "%lx-%lx %s[rwxp-]",
-			   &start_addr, &end_addr, prot) != 3)
+		if (sscanf(line, "%lx-%lx %4s %*s %*s %*s %n",
+			   &start_addr, &end_addr, prot, &path_offset) != 3)
 			ksft_exit_fail_msg("cannot parse /proc/self/maps\n");
 
 		/* end of userspace mappings; ignore vsyscall mapping */
@@ -135,6 +136,10 @@ static int validate_complete_va_space(vo
 		if (prot[0] != 'r')
 			continue;
 
+		/* Only the VDSO can know if a VVAR mapping is really readable */
+		if (path_offset && !strncmp(line + path_offset, "[vvar", 5))
+			continue;
+
 		/*
 		 * Confirm whether MAP_CHUNK_SIZE chunk can be found or not.
 		 * If write succeeds, no need to check MAP_CHUNK_SIZE - 1
_

Patches currently in -mm which might be from thomas.weissschuh@linutronix.de are



