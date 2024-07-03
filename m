Return-Path: <stable+bounces-57515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E4925F3A
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3E2B3C3DC
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80301922DF;
	Wed,  3 Jul 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrA2pNaZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755BB194A50;
	Wed,  3 Jul 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005114; cv=none; b=hRO7w2ZWQh9HosytLkThJQafoAVg2L8L0L2Z+WsBsV7Vp8/98+RTfq/AG9rkxw1oaDFZf0LUUQWlfMfUmMsOVUCS3EafpJpAHn8/lRVFugzof0/sfLhyo8iqiTn7QF+1tmZKaBMia2CBfXYk4XqbtfEEE5qhdNO5sJJWt4YmNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005114; c=relaxed/simple;
	bh=CnyfphxRfkrQKMsc5FxcvGPkFWjcbOFFE4ClLDtzpJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgFZwWL0VfiqDBmBxAMGPSeIRTim1oyiNNfWLmqR62kqriV9Ar8xDVUCM5+4FAkmSTHpcHFT0JPGzGBE5xVu1BQ8QA2zcc22yoh/6xzEk1jOM4b+bBg0m1EkU8zDHR3XfSWO7b7eRfNT3DVO04WmFS+TkdM7NOj0eTB4bsSPENw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrA2pNaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11C0C2BD10;
	Wed,  3 Jul 2024 11:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005114;
	bh=CnyfphxRfkrQKMsc5FxcvGPkFWjcbOFFE4ClLDtzpJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IrA2pNaZNMgvg/vtup14X9qUoAAWHpWj1FdYCI9QLjSimvfPJAYuhrXg5rcoFHmKh
	 36jW9rwrE+M+Lv7Q7vd0YkOw2uLlo410Dtf1dsL/dzl7o5+Hm8uzrzakvKyT763uLv
	 JDBR76EiNFq+bwDOt6n8E5ZFuTg0lfbdx0zeU6QE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guo Ren <guoren@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.10 266/290] csky, hexagon: fix broken sys_sync_file_range
Date: Wed,  3 Jul 2024 12:40:47 +0200
Message-ID: <20240703102914.190476503@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 3339b99ef6fe38dac43b534cba3a8a0e29fb2eff upstream.

Both of these architectures require u64 function arguments to be
passed in even/odd pairs of registers or stack slots, which in case of
sync_file_range would result in a seven-argument system call that is
not currently possible. The system call is therefore incompatible with
all existing binaries.

While it would be possible to implement support for seven arguments
like on mips, it seems better to use a six-argument version, either
with the normal argument order but misaligned as on most architectures
or with the reordered sync_file_range2() calling conventions as on
arm and powerpc.

Cc: stable@vger.kernel.org
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/csky/include/uapi/asm/unistd.h    |    1 +
 arch/hexagon/include/uapi/asm/unistd.h |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -7,6 +7,7 @@
 #define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYNC_FILE_RANGE2
 #include <asm-generic/unistd.h>
 
 #define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -36,5 +36,6 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYNC_FILE_RANGE2
 
 #include <asm-generic/unistd.h>



