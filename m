Return-Path: <stable+bounces-97181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731FC9E2339
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA6416A713
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373D1F7540;
	Tue,  3 Dec 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yw2kFcWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA971F6698;
	Tue,  3 Dec 2024 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239748; cv=none; b=B2+QO3Y40jp5+gLE1KxQzC5rayEmdggYb9Kd/34PQxP/iLWQPoypBKJMdRJG+DlkwjafHZWBtAxWZ6ZOl05KaqXbDAVL5iSGciHYrMThobNaafDf8ePiZA99BATr94lg7la9b69x6JK9fXgzwBlR53O7vF4lz7WILEIUtj/o3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239748; c=relaxed/simple;
	bh=SU+toaTwMfECND+sPFPrxCdNTdWihw8rqKkeicIRmBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSV2vTBdXwMWtkUrhxxUG081F6iA1XpRsDm2HkKO89X8VPGKLP/kRKR+vsS9YlQ0TM0DAczk5Hh6wmXV1R7ly/tcIlBVj9grU36KjVa1nY4+yakbj4hhZzuEYRdONNZFe7UuGAj2jLEffF78T/vUBMHLDSd2tohUoEzMHMxXOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yw2kFcWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85512C4CECF;
	Tue,  3 Dec 2024 15:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239747;
	bh=SU+toaTwMfECND+sPFPrxCdNTdWihw8rqKkeicIRmBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yw2kFcWHDh8HkeGaa8yfL/JgIQtIaw/A/MBsDK79oymhAby0CQVEHzxC9FfeGFInK
	 UttT4wASw6HEWWClAI+KGOUYWTaldFyr6972ySGoPEis2utvG9b+paIcT6aSUN4CJP
	 T7Gfwrv7zUYINOpaD9CWUhZgSG2oW9Q16iXsnMUo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH 6.11 721/817] sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
Date: Tue,  3 Dec 2024 15:44:53 +0100
Message-ID: <20241203144024.135819417@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 3c891f7c6a4e90bb1199497552f24b26e46383bc upstream.

When CONFIG_CPUMASK_OFFSTACK and CONFIG_DEBUG_PER_CPU_MAPS are selected,
cpu_max_bits_warn() generates a runtime warning similar as below when
showing /proc/cpuinfo. Fix this by using nr_cpu_ids (the runtime limit)
instead of NR_CPUS to iterate CPUs.

[    3.052463] ------------[ cut here ]------------
[    3.059679] WARNING: CPU: 3 PID: 1 at include/linux/cpumask.h:108 show_cpuinfo+0x5e8/0x5f0
[    3.070072] Modules linked in: efivarfs autofs4
[    3.076257] CPU: 0 PID: 1 Comm: systemd Not tainted 5.19-rc5+ #1052
[    3.099465] Stack : 9000000100157b08 9000000000f18530 9000000000cf846c 9000000100154000
[    3.109127]         9000000100157a50 0000000000000000 9000000100157a58 9000000000ef7430
[    3.118774]         90000001001578e8 0000000000000040 0000000000000020 ffffffffffffffff
[    3.128412]         0000000000aaaaaa 1ab25f00eec96a37 900000010021de80 900000000101c890
[    3.138056]         0000000000000000 0000000000000000 0000000000000000 0000000000aaaaaa
[    3.147711]         ffff8000339dc220 0000000000000001 0000000006ab4000 0000000000000000
[    3.157364]         900000000101c998 0000000000000004 9000000000ef7430 0000000000000000
[    3.167012]         0000000000000009 000000000000006c 0000000000000000 0000000000000000
[    3.176641]         9000000000d3de08 9000000001639390 90000000002086d8 00007ffff0080286
[    3.186260]         00000000000000b0 0000000000000004 0000000000000000 0000000000071c1c
[    3.195868]         ...
[    3.199917] Call Trace:
[    3.203941] [<90000000002086d8>] show_stack+0x38/0x14c
[    3.210666] [<9000000000cf846c>] dump_stack_lvl+0x60/0x88
[    3.217625] [<900000000023d268>] __warn+0xd0/0x100
[    3.223958] [<9000000000cf3c90>] warn_slowpath_fmt+0x7c/0xcc
[    3.231150] [<9000000000210220>] show_cpuinfo+0x5e8/0x5f0
[    3.238080] [<90000000004f578c>] seq_read_iter+0x354/0x4b4
[    3.245098] [<90000000004c2e90>] new_sync_read+0x17c/0x1c4
[    3.252114] [<90000000004c5174>] vfs_read+0x138/0x1d0
[    3.258694] [<90000000004c55f8>] ksys_read+0x70/0x100
[    3.265265] [<9000000000cfde9c>] do_syscall+0x7c/0x94
[    3.271820] [<9000000000202fe4>] handle_syscall+0xc4/0x160
[    3.281824] ---[ end trace 8b484262b4b8c24c ]---

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/kernel/cpu/proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/sh/kernel/cpu/proc.c
+++ b/arch/sh/kernel/cpu/proc.c
@@ -132,7 +132,7 @@ static int show_cpuinfo(struct seq_file
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos < NR_CPUS ? cpu_data + *pos : NULL;
+	return *pos < nr_cpu_ids ? cpu_data + *pos : NULL;
 }
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {



